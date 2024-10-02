### Laboratorio: Clasificación de Datos con MLlib

En este laboratorio, vamos a realizar un análisis de **clasificación** utilizando **Apache Spark MLlib**. Exploraremos cómo entrenar y evaluar un modelo de clasificación, en este caso, un modelo de **Regresión Logística**, para predecir la clase de una observación a partir de un conjunto de características.

La clasificación es un problema supervisado en el que el objetivo es asignar una etiqueta (categoría) a cada observación. En este caso, utilizaremos un conjunto de datos con etiquetas predefinidas, entrenaremos un modelo con Spark MLlib y evaluaremos su precisión.

#### Objetivos del laboratorio:
1. **Cargar y preparar** un conjunto de datos.
2. **Construir un modelo de clasificación** utilizando la **Regresión Logística** de MLlib.
3. **Entrenar el modelo** con los datos de entrenamiento.
4. **Evaluar el modelo** y analizar su rendimiento.
5. **Ajustar los hiperparámetros** para mejorar el modelo.

---

### Paso 1: **Preparar el entorno**

#### 1.1 Crear el clúster en Databricks

- **Paso**: Crear un clúster en Databricks para procesar los datos de manera distribuida.
- **Por qué lo hacemos**: El clúster proporciona el entorno distribuido necesario para trabajar con Spark y ejecutar algoritmos de Machine Learning.

1. En el panel de control de Databricks, selecciona la pestaña "Clusters".
2. Haz clic en "Create Cluster" y selecciona una configuración adecuada (por ejemplo, `Standard_DS3_v2`).
3. Inicia el clúster y espera a que esté listo.

---

### Paso 2: **Cargar y preparar los datos**

Vamos a utilizar el conjunto de datos **Iris**, un clásico en tareas de clasificación. Este dataset contiene mediciones de características de flores de tres especies distintas.

#### 2.1 Cargar el conjunto de datos

Primero, subimos el archivo CSV a Databricks y lo cargamos en un **DataFrame de Spark**.

1. En la barra lateral de Databricks, haz clic en “Data” y selecciona “Upload File”.
2. Sube el archivo `iris.csv` a Databricks.
3. Carga el conjunto de datos en un DataFrame de Spark:

   ```python
   df = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load("/FileStore/tables/iris.csv")
   ```

4. Verifica los primeros registros:

   ```python
   df.show(5)
   ```

---

#### 2.2 Preprocesar los datos

Antes de entrenar un modelo, debemos preparar los datos. Esto implica seleccionar las características relevantes y convertirlas en un formato que el modelo pueda interpretar.

1. **Convertir las características en un vector**: Spark MLlib espera que todas las características estén en una sola columna de tipo vector. Utilizaremos el **VectorAssembler** para combinar las columnas de características.

   ```python
   from pyspark.ml.feature import VectorAssembler

   assembler = VectorAssembler(inputCols=["sepal_length", "sepal_width", "petal_length", "petal_width"], outputCol="features")
   df_assembled = assembler.transform(df)
   ```

2. **Convertir la etiqueta a numérica**: En algunos casos, las etiquetas categóricas deben ser convertidas a un formato numérico.

   ```python
   from pyspark.ml.feature import StringIndexer

   indexer = StringIndexer(inputCol="species", outputCol="label")
   df_prepared = indexer.fit(df_assembled).transform(df_assembled)
   df_prepared.show(5)
   ```

---

### Paso 3: **Entrenar el modelo de clasificación**

Usaremos **Logistic Regression** (Regresión Logística) para entrenar nuestro modelo de clasificación. La Regresión Logística es adecuada para tareas de clasificación binaria y multiclase.

#### 3.1 Dividir el conjunto de datos en entrenamiento y prueba

Para evaluar adecuadamente el modelo, dividimos los datos en dos subconjuntos: **entrenamiento** (80%) y **prueba** (20%).

```python
train_data, test_data = df_prepared.randomSplit([0.8, 0.2], seed=42)
```

#### 3.2 Crear y entrenar el modelo

Utilizamos el modelo de **Regresión Logística** para entrenar nuestro modelo en los datos de entrenamiento.

```python
from pyspark.ml.classification import LogisticRegression

# Crear el modelo de Regresión Logística
lr = LogisticRegression(featuresCol="features", labelCol="label")

# Entrenar el modelo
lr_model = lr.fit(train_data)
```

---

### Paso 4: **Evaluar el modelo**

Una vez entrenado el modelo, lo evaluamos utilizando los datos de prueba para verificar su rendimiento.

#### 4.1 Hacer predicciones

Utilizamos el modelo entrenado para hacer predicciones sobre los datos de prueba.

```python
predictions = lr_model.transform(test_data)
predictions.select("features", "label", "prediction").show(5)
```

#### 4.2 Evaluar el rendimiento del modelo

Para evaluar el modelo, utilizamos métricas comunes como la **exactitud** (accuracy), **precisión**, y **recall**.

```python
from pyspark.ml.evaluation import MulticlassClassificationEvaluator

evaluator = MulticlassClassificationEvaluator(labelCol="label", predictionCol="prediction", metricName="accuracy")
accuracy = evaluator.evaluate(predictions)
print(f"Exactitud del modelo: {accuracy}")
```

---

### Paso 5: **Ajuste de hiperparámetros**

Podemos mejorar el rendimiento del modelo ajustando los **hiperparámetros**. Un método común es utilizar **Cross-Validation** para probar diferentes combinaciones de hiperparámetros.

#### 5.1 Crear un pipeline y ajustar los hiperparámetros

Utilizaremos un pipeline de Spark para automatizar el ajuste de hiperparámetros.

```python
from pyspark.ml.tuning import ParamGridBuilder, CrossValidator

# Crear una cuadrícula de parámetros
paramGrid = (ParamGridBuilder()
             .addGrid(lr.regParam, [0.01, 0.1, 0.5])
             .addGrid(lr.elasticNetParam, [0.0, 0.5, 1.0])
             .build())

# Crear un validador cruzado
crossval = CrossValidator(estimator=lr, 
                          estimatorParamMaps=paramGrid, 
                          evaluator=evaluator, 
                          numFolds=5)

# Entrenar con cross-validation
cv_model = crossval.fit(train_data)

# Evaluar el mejor modelo
best_model = cv_model.bestModel
predictions_best = best_model.transform(test_data)
accuracy_best = evaluator.evaluate(predictions_best)
print(f"Mejor exactitud del modelo: {accuracy_best}")
```

---

### Conclusión

En este laboratorio, hemos construido un modelo de **clasificación** utilizando **MLlib** en **Databricks**. Desde la carga de datos hasta el ajuste de hiperparámetros, hemos seguido todo el flujo de trabajo de Machine Learning en Spark. Este laboratorio te proporciona una base sólida para trabajar con tareas de clasificación en Spark, donde la escalabilidad y el procesamiento distribuido permiten trabajar con grandes volúmenes de datos de manera eficiente.