### Laboratorio: Regresión Lineal con MLlib

En este laboratorio, aprenderemos cómo implementar un modelo de **Regresión Lineal** utilizando **Apache Spark MLlib** en **Databricks**. La regresión lineal es un algoritmo supervisado que predice un valor continuo en función de una o más variables independientes. Es ampliamente utilizado para tareas como la predicción de precios, ventas y cualquier métrica que pueda modelarse de manera continua.

#### Objetivos del laboratorio:
1. **Cargar y preparar** un conjunto de datos.
2. **Construir un modelo de regresión lineal** utilizando **MLlib**.
3. **Entrenar el modelo** con los datos de entrenamiento.
4. **Evaluar el modelo** y analizar su rendimiento.
5. **Ajustar los hiperparámetros** para mejorar la predicción.

---

### Paso 1: **Preparar el entorno**

#### 1.1 Crear el clúster en Databricks

- **Paso**: Crear un clúster en Databricks para ejecutar las operaciones distribuidas.
- **Por qué lo hacemos**: Un clúster en Databricks proporciona la infraestructura necesaria para trabajar con grandes volúmenes de datos y ejecutar algoritmos de Machine Learning de manera eficiente.

1. Ve a la pestaña "Clusters" en Databricks.
2. Haz clic en "Create Cluster" y selecciona una configuración adecuada (por ejemplo, `Standard_DS3_v2`).
3. Inicia el clúster.

---

### Paso 2: **Cargar y preparar los datos**

Para este laboratorio, utilizaremos un conjunto de datos sintético de **precios de casas** que contiene las características de diferentes propiedades (como el número de habitaciones, tamaño en pies cuadrados, etc.) y el precio de la casa.

#### 2.1 Cargar el conjunto de datos

1. Subir el archivo de datos `house_prices.csv` a Databricks.
2. Cargar los datos en un **DataFrame de Spark**:

   ```python
   df = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load("/FileStore/tables/house_prices.csv")
   ```

3. Verifica los primeros registros del DataFrame para entender su estructura:

   ```python
   df.show(5)
   ```

---

#### 2.2 Preprocesar los datos

Antes de entrenar el modelo, necesitamos preparar los datos. Esto implica seleccionar las características relevantes y convertirlas en un formato que el modelo de regresión lineal pueda entender.

1. **Convertir las características en un vector**: Utilizamos el **VectorAssembler** para combinar múltiples columnas en un único vector de características.

   ```python
   from pyspark.ml.feature import VectorAssembler

   assembler = VectorAssembler(inputCols=["rooms", "bathrooms", "size_sqft"], outputCol="features")
   df_assembled = assembler.transform(df)
   ```

2. **Preparar la variable objetivo**: En este caso, la variable que deseamos predecir es `price`, que corresponde al valor de la casa.

   ```python
   df_assembled = df_assembled.withColumnRenamed("price", "label")
   df_assembled.show(5)
   ```

---

### Paso 3: **Entrenar el modelo de regresión lineal**

Usaremos el modelo de **Regresión Lineal** de MLlib para entrenar el modelo y predecir el precio de las casas en función de las características.

#### 3.1 Dividir el conjunto de datos en entrenamiento y prueba

Para evaluar el rendimiento del modelo, dividimos el conjunto de datos en dos subconjuntos: **entrenamiento** (80%) y **prueba** (20%).

```python
train_data, test_data = df_assembled.randomSplit([0.8, 0.2], seed=42)
```

#### 3.2 Crear y entrenar el modelo de regresión lineal

Creamos el modelo de **Regresión Lineal** y lo entrenamos con los datos de entrenamiento.

```python
from pyspark.ml.regression import LinearRegression

# Crear el modelo de Regresión Lineal
lr = LinearRegression(featuresCol="features", labelCol="label")

# Entrenar el modelo
lr_model = lr.fit(train_data)
```

---

### Paso 4: **Evaluar el modelo**

Una vez entrenado el modelo, lo evaluamos en los datos de prueba para ver qué tan bien predice los precios de las casas.

#### 4.1 Hacer predicciones

Usamos el modelo entrenado para hacer predicciones en los datos de prueba.

```python
predictions = lr_model.transform(test_data)
predictions.select("features", "label", "prediction").show(5)
```

#### 4.2 Evaluar el rendimiento del modelo

Podemos evaluar el modelo utilizando métricas como el **Error Cuadrático Medio (RMSE)**, el **Error Absoluto Medio (MAE)**, y el **coeficiente de determinación (R2)** para ver cómo se ajusta el modelo a los datos.

```python
# Evaluar el modelo
trainingSummary = lr_model.summary
print(f"RMSE: {trainingSummary.rootMeanSquaredError}")
print(f"R2: {trainingSummary.r2}")
```

- **RMSE (Root Mean Squared Error)**: Indica cuán lejos están las predicciones del valor real.
- **R2**: Indica qué proporción de la variabilidad en los datos es explicada por el modelo.

---

### Paso 5: **Ajuste de hiperparámetros**

Podemos mejorar el rendimiento del modelo ajustando los **hiperparámetros**, como la tasa de regularización y el término de elasticidad.

#### 5.1 Crear un pipeline y ajustar los hiperparámetros

Utilizamos **Cross-Validation** y un **grid de parámetros** para buscar la mejor combinación de hiperparámetros.

```python
from pyspark.ml.tuning import ParamGridBuilder, CrossValidator
from pyspark.ml.evaluation import RegressionEvaluator

# Crear un evaluador de regresión
evaluator = RegressionEvaluator(predictionCol="prediction", labelCol="label", metricName="rmse")

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
rmse_best = evaluator.evaluate(predictions_best)
print(f"Mejor RMSE del modelo: {rmse_best}")
```

---

### Conclusión

En este laboratorio, hemos implementado y evaluado un modelo de **regresión lineal** utilizando **Spark MLlib**. Aprendimos a dividir los datos, entrenar el modelo, hacer predicciones y evaluar su rendimiento utilizando métricas como RMSE y R2. Además, utilizamos **Cross-Validation** para ajustar los hiperparámetros del modelo y mejorar su rendimiento. Este laboratorio te proporciona una comprensión clara del flujo de trabajo de regresión en **MLlib**, permitiéndote abordar problemas de predicción de valores continuos en el mundo real.