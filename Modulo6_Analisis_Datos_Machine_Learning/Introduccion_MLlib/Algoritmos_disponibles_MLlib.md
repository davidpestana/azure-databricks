### Algoritmos disponibles en MLlib

**MLlib** ofrece una amplia gama de algoritmos de Machine Learning que permiten abordar diversas tareas, tales como clasificación, regresión, clustering y filtrado colaborativo, entre otras. A continuación, se describe cada tipo de algoritmo disponible en **MLlib**, acompañado de ejemplos prácticos en **PySpark**.

#### 1. **Clasificación**

Los algoritmos de clasificación se utilizan para predecir una **categoría** o **clase** de un conjunto de datos etiquetados. En otras palabras, dada una entrada, el modelo de clasificación asigna una etiqueta de clase predefinida.

##### Algoritmos de clasificación comunes en MLlib:
- **Regresión logística**: Utilizada para clasificación binaria o multiclase.
- **Árboles de decisión**: Modelos que dividen el espacio de datos en regiones y asignan etiquetas.
- **Random Forest**: Un conjunto de árboles de decisión entrenados para mejorar la precisión.
- **Máquinas de soporte vectorial (SVM)**: Utilizadas para clasificación binaria.

##### Ejemplo de clasificación con regresión logística:
```python
from pyspark.ml.classification import LogisticRegression
from pyspark.ml.feature import VectorAssembler

# Preparación de los datos
assembler = VectorAssembler(inputCols=["feature1", "feature2", "feature3"], outputCol="features")
train_data = assembler.transform(df)

# Crear el modelo de regresión logística
lr = LogisticRegression(featuresCol="features", labelCol="label")

# Entrenar el modelo
lr_model = lr.fit(train_data)

# Hacer predicciones
predictions = lr_model.transform(train_data)
predictions.select("features", "label", "prediction").show()
```

**Explicación**: En este ejemplo, hemos utilizado **LogisticRegression** de MLlib para realizar una clasificación binaria. Primero, preparamos los datos utilizando **VectorAssembler** para combinar múltiples columnas en un único vector de características y luego entrenamos el modelo de regresión logística.

#### 2. **Regresión**

Los algoritmos de regresión se utilizan para predecir un **valor numérico continuo**. Estos algoritmos ajustan un modelo a los datos de entrenamiento para hacer predicciones sobre valores continuos.

##### Algoritmos de regresión comunes en MLlib:
- **Regresión lineal**: Utilizada para predecir un valor numérico en función de una o más variables.
- **Árboles de decisión para regresión**: Árboles de decisión ajustados para problemas de regresión.
- **Random Forest para regresión**: Conjunto de árboles de decisión utilizados para mejorar las predicciones continuas.

##### Ejemplo de regresión lineal:
```python
from pyspark.ml.regression import LinearRegression

# Crear el modelo de regresión lineal
lr = LinearRegression(featuresCol="features", labelCol="label")

# Entrenar el modelo
lr_model = lr.fit(train_data)

# Hacer predicciones
predictions = lr_model.transform(train_data)
predictions.select("features", "label", "prediction").show()
```

**Explicación**: Aquí hemos creado un modelo de **regresión lineal** utilizando MLlib. El proceso es similar a la clasificación: preparamos los datos, entrenamos el modelo y luego realizamos predicciones.

#### 3. **Clustering**

El clustering agrupa un conjunto de datos en **clusters** o **grupos** de elementos que tienen similitudes entre sí. A diferencia de la clasificación, el clustering es un **algoritmo no supervisado**, lo que significa que no requiere etiquetas para entrenarse.

##### Algoritmos de clustering en MLlib:
- **K-Means**: El algoritmo más popular para agrupar datos en `K` clusters.
- **Gaussian Mixture Model (GMM)**: Modelo probabilístico basado en distribuciones gaussianas.

##### Ejemplo de clustering con K-Means:
```python
from pyspark.ml.clustering import KMeans

# Crear el modelo K-Means
kmeans = KMeans(k=3, featuresCol="features")

# Entrenar el modelo
kmeans_model = kmeans.fit(train_data)

# Hacer predicciones
predictions = kmeans_model.transform(train_data)
predictions.select("features", "prediction").show()
```

**Explicación**: El algoritmo **K-Means** agrupa los datos en `k` clusters (en este caso, 3). El modelo es no supervisado, es decir, no se necesita un conjunto de etiquetas durante el entrenamiento.

#### 4. **Filtrado colaborativo**

El filtrado colaborativo se utiliza en **sistemas de recomendación** para hacer predicciones sobre los intereses de un usuario basándose en la información de otros usuarios. Este enfoque se utiliza comúnmente en plataformas como **Netflix** o **Amazon**.

##### Algoritmos de filtrado colaborativo en MLlib:
- **Alternating Least Squares (ALS)**: Algoritmo utilizado para recomendaciones de productos basadas en interacciones pasadas (e.g., películas vistas por un usuario).

##### Ejemplo de filtrado colaborativo con ALS:
```python
from pyspark.ml.recommendation import ALS

# Crear el modelo ALS
als = ALS(userCol="user_id", itemCol="movie_id", ratingCol="rating")

# Entrenar el modelo
als_model = als.fit(train_data)

# Hacer predicciones
predictions = als_model.transform(test_data)
predictions.select("user_id", "movie_id", "prediction").show()
```

**Explicación**: En este ejemplo, utilizamos el algoritmo **ALS** para generar recomendaciones personalizadas. Este algoritmo aprende las preferencias de los usuarios en función de las interacciones anteriores y realiza recomendaciones de elementos (e.g., películas) que podrían interesar a cada usuario.

#### 5. **Reducción de dimensionalidad**

Cuando los conjuntos de datos tienen un gran número de características, algunos algoritmos de Machine Learning pueden volverse ineficientes. La **reducción de dimensionalidad** reduce el número de variables sin perder demasiada información relevante.

##### Algoritmos de reducción de dimensionalidad en MLlib:
- **PCA (Análisis de Componentes Principales)**: Método para reducir la dimensionalidad proyectando los datos en un espacio de menor dimensión.

##### Ejemplo de reducción de dimensionalidad con PCA:
```python
from pyspark.ml.feature import PCA

# Configurar PCA para reducir a 2 componentes
pca = PCA(k=2, inputCol="features", outputCol="pca_features")

# Ajustar el modelo PCA
pca_model = pca.fit(train_data)

# Transformar los datos
pca_result = pca_model.transform(train_data)
pca_result.select("features", "pca_features").show()
```

**Explicación**: En este ejemplo, utilizamos **PCA** para reducir el número de características a 2 componentes principales. Este proceso ayuda a mejorar la eficiencia y reducir el ruido en los datos.

---

### Conclusión:

**MLlib** en Spark proporciona un conjunto robusto de algoritmos para abordar diferentes problemas de Machine Learning. Gracias a la escalabilidad y capacidad distribuida de Spark, estos algoritmos son ideales para trabajar con grandes volúmenes de datos. Desde clasificación y regresión hasta clustering y filtrado colaborativo, MLlib cubre las principales áreas del aprendizaje automático de manera eficiente y escalable.