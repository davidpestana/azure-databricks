### Laboratorio: Clustering K-Means con MLlib

En este laboratorio, vamos a implementar el algoritmo de **K-Means** usando **Apache Spark MLlib** en Databricks. El clustering es un método de **aprendizaje no supervisado** que agrupa los datos en **clusters** o grupos según sus similitudes. **K-Means** es uno de los algoritmos más comunes para resolver problemas de agrupamiento en grandes conjuntos de datos.

El objetivo de este laboratorio es dividir un conjunto de datos en varios grupos y explorar cómo se puede utilizar este algoritmo en un entorno distribuido.

#### Objetivos del laboratorio:
1. **Cargar y preparar** un conjunto de datos.
2. **Aplicar el algoritmo K-Means** para encontrar grupos en los datos.
3. **Evaluar el rendimiento** del modelo y ajustar el número de clusters.
4. **Visualizar los resultados** y analizar los clusters.

---

### Paso 1: **Preparar el entorno**

#### 1.1 Crear el clúster en Databricks

- **Paso**: Crear un clúster en Databricks para procesar los datos de manera distribuida.
- **Por qué lo hacemos**: K-Means requiere un entorno distribuido para escalar eficientemente con grandes volúmenes de datos.

1. En el panel de control de Databricks, selecciona "Clusters".
2. Haz clic en "Create Cluster" y selecciona la configuración adecuada (por ejemplo, `Standard_DS3_v2`).
3. Inicia el clúster.

---

### Paso 2: **Cargar y preparar los datos**

Utilizaremos el conjunto de datos **Iris** que hemos utilizado en laboratorios anteriores. Este dataset es perfecto para agrupar observaciones en tres clases distintas, basadas en características de flores.

#### 2.1 Cargar el conjunto de datos

1. Sube el archivo `iris.csv` a Databricks si no lo tienes cargado.
2. Carga el archivo en un **DataFrame de Spark**:

   ```python
   df = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load("/FileStore/tables/iris.csv")
   ```

3. Verifica los primeros registros para entender su estructura:

   ```python
   df.show(5)
   ```

---

#### 2.2 Preprocesar los datos

El algoritmo K-Means requiere que las características numéricas estén representadas en una única columna de tipo **vector**. Vamos a preparar los datos utilizando **VectorAssembler**.

1. **Convertir las características en un vector**: Utilizamos el **VectorAssembler** para combinar las columnas de características en una columna de vector.

   ```python
   from pyspark.ml.feature import VectorAssembler

   assembler = VectorAssembler(inputCols=["sepal_length", "sepal_width", "petal_length", "petal_width"], outputCol="features")
   df_assembled = assembler.transform(df)
   ```

2. Verifica el DataFrame transformado:

   ```python
   df_assembled.select("features").show(5, truncate=False)
   ```

---

### Paso 3: **Aplicar el algoritmo K-Means**

Ahora aplicaremos el algoritmo **K-Means** para agrupar los datos en tres clusters, lo que es apropiado para el conjunto de datos Iris, ya que contiene tres especies de flores.

#### 3.1 Crear y entrenar el modelo K-Means

1. Configura el modelo K-Means para agrupar los datos en tres clusters (`k=3`):

   ```python
   from pyspark.ml.clustering import KMeans

   kmeans = KMeans(k=3, seed=42, featuresCol="features")
   ```

2. Entrena el modelo:

   ```python
   kmeans_model = kmeans.fit(df_assembled)
   ```

---

### Paso 4: **Evaluar y visualizar el modelo**

Una vez entrenado el modelo, evaluaremos su rendimiento y visualizaremos los resultados.

#### 4.1 Hacer predicciones

Utiliza el modelo entrenado para asignar cada observación a un cluster:

```python
predictions = kmeans_model.transform(df_assembled)
predictions.select("features", "prediction").show(5)
```

#### 4.2 Evaluar el modelo

Una de las métricas más comunes para evaluar el rendimiento de K-Means es la **inercia** o la **suma de distancias cuadradas dentro del cluster** (Within Set Sum of Squared Errors, **WSSSE**).

```python
wssse = kmeans_model.computeCost(df_assembled)
print(f"Suma de distancias cuadradas dentro del cluster (WSSSE): {wssse}")
```

#### 4.3 Determinar el número óptimo de clusters (elbow method)

Podemos variar el número de clusters (`k`) y observar cómo cambia la WSSSE para encontrar el número óptimo de clusters.

1. Definir un rango de valores de `k` (número de clusters):

   ```python
   costs = []
   for k in range(2, 10):
       kmeans = KMeans(k=k, seed=42, featuresCol="features")
       model = kmeans.fit(df_assembled)
       wssse = model.computeCost(df_assembled)
       costs.append((k, wssse))
   ```

2. Visualiza los costos para cada valor de `k`:

   ```python
   import matplotlib.pyplot as plt

   ks, wssse_values = zip(*costs)
   plt.plot(ks, wssse_values, marker='o')
   plt.xlabel('Número de Clusters (k)')
   plt.ylabel('WSSSE')
   plt.title('Método Elbow para determinar el número óptimo de clusters')
   plt.show()
   ```

**Explicación**: El método **Elbow** nos ayuda a encontrar el número óptimo de clusters. Buscamos el valor de `k` en el que el WSSSE deja de disminuir significativamente.

---

### Paso 5: **Visualización de los clusters**

#### 5.1 Visualizar los clusters

Para visualizar los resultados, convertimos los datos a **pandas** y creamos un gráfico de dispersión para mostrar cómo se agrupan las observaciones.

```python
import pandas as pd
import seaborn as sns

# Convertir las predicciones a pandas para visualización
df_pandas = predictions.select("sepal_length", "sepal_width", "petal_length", "petal_width", "prediction").toPandas()

# Crear un gráfico de dispersión con seaborn
sns.pairplot(df_pandas, hue="prediction", palette="Set1")
plt.show()
```

**Explicación**: Este gráfico de dispersión muestra cómo se agrupan las flores en diferentes clusters según las características de las flores.

---

### Conclusión

En este laboratorio, hemos implementado el algoritmo de **K-Means** utilizando **MLlib** para agrupar el conjunto de datos Iris en tres clusters. Además, hemos evaluado el rendimiento del modelo utilizando WSSSE y aplicado el **método Elbow** para determinar el número óptimo de clusters. Finalmente, visualizamos los resultados con gráficos de dispersión para comprender mejor la estructura de los grupos.

Este laboratorio te proporciona una base sólida para aplicar técnicas de clustering en grandes conjuntos de datos utilizando **Spark MLlib** y Databricks, combinando tanto el poder de procesamiento distribuido como herramientas de visualización efectivas.