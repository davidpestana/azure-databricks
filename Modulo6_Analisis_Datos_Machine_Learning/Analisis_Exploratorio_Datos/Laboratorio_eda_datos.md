### Laboratorio: Realizar Análisis Exploratorio de Datos (EDA) en un Conjunto de Datos en Databricks

En este laboratorio, realizaremos un **Análisis Exploratorio de Datos (EDA)** utilizando **Spark DataFrames** en Databricks, explicando detalladamente cada paso y considerando los casos en los que es necesario usar **pandas**. Veremos cómo y por qué se utilizan ambas herramientas, explicando las limitaciones de Spark en algunos casos y cómo podemos aprovechar pandas de manera eficiente usando **muestreo**.

### Paso 1: **Preparar el entorno**

#### 1.1 Crear el clúster de Databricks

- **Paso**: Crear un clúster en Databricks para ejecutar código de forma distribuida.
- **Por qué lo hacemos**: Los clústeres permiten ejecutar tareas de procesamiento distribuido, que es ideal para trabajar con grandes volúmenes de datos. Spark está optimizado para manejar datos que no caben en la memoria de una sola máquina, escalando horizontalmente con la infraestructura de Databricks.

1. Ve al panel de control de Databricks.
2. Haz clic en "Clusters" y selecciona "Create Cluster".
3. Configura una máquina `Standard_DS3_v2` y nómbrala `EDA-Cluster`.
4. Inicia el clúster.

#### 1.2 Cargar el conjunto de datos

Trabajaremos con el clásico **conjunto de datos Iris**, que contiene mediciones de flores de tres especies.

1. Subir el archivo `iris.csv` a Databricks desde la pestaña "Data".
2. Cargar el archivo en un Spark DataFrame:

   ```python
   df = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load("/FileStore/tables/iris.csv")
   ```

   **Explicación**: Spark permite cargar y procesar grandes volúmenes de datos de manera distribuida, a diferencia de pandas, que está limitado por la capacidad de memoria de una sola máquina. Por eso, usamos Spark para manejar archivos de gran tamaño desde el principio.

### Paso 2: **Explorar los datos**

#### 2.1 Mostrar las primeras filas del DataFrame

- **Paso**: Ver las primeras filas del DataFrame para obtener una idea de la estructura y contenido.
- **Por qué lo hacemos**: Familiarizarnos con los datos es el primer paso en el análisis exploratorio, ya que nos permite confirmar que el dataset ha sido cargado correctamente y contiene las columnas y valores esperados.

```python
df.show(5)
```

#### 2.2 Descripción básica de las columnas

- **Paso**: Generar estadísticas descriptivas para las columnas numéricas.
- **Por qué lo hacemos**: Obtener métricas como la media, desviación estándar y los valores mínimos y máximos nos ayuda a entender rápidamente las características de las variables.

```python
df.describe().show()
```

   **Explicación**: Spark permite obtener estadísticas descriptivas distribuidas para grandes volúmenes de datos, a diferencia de pandas, que maneja estos cálculos en memoria. Sin embargo, cuando necesitemos hacer visualizaciones más específicas o cálculos detallados, evaluaremos si es necesario reducir el dataset y usar pandas.

### Paso 3: **Muestrear y Reducir el DataFrame para Visualización con pandas**

A veces, Spark no ofrece funciones directas para tareas específicas, como visualización de gráficos (histogramas, boxplots) o cálculos avanzados como la moda. En estos casos, utilizaremos pandas. **Sin embargo, dado que pandas maneja todo en memoria**, vamos a reducir el tamaño del DataFrame utilizando un **muestreo aleatorio**.

#### 3.1 Muestreo del DataFrame

- **Paso**: Tomar una muestra representativa del 10% del DataFrame original.
- **Por qué lo hacemos**: pandas no está diseñado para procesar grandes volúmenes de datos. Al reducir el tamaño de los datos mediante un muestreo aleatorio, podemos manejar el conjunto de datos de manera eficiente en memoria sin perder la representatividad.

```python
df_sampled = df.sample(fraction=0.1, seed=42)
```

   **Explicación**: Usamos el método `sample` de Spark para obtener un subconjunto aleatorio de los datos. Este proceso es muy eficiente y nos permite trabajar con pandas en el siguiente paso sin problemas de memoria.

#### 3.2 Convertir la muestra a pandas

- **Paso**: Convertir el DataFrame reducido a pandas para realizar visualizaciones.
- **Por qué lo hacemos**: pandas ofrece funciones más directas y sencillas para crear gráficos y realizar análisis estadísticos detallados. Para conjuntos de datos pequeños o muestreados, pandas es una excelente opción.

```python
df_pandas = df_sampled.toPandas()
```

   **Explicación**: Aunque Spark es eficiente para el procesamiento distribuido, no cuenta con funciones de visualización como las de pandas. Convertir una muestra de los datos a pandas nos permite acceder a sus capacidades de visualización y análisis detallado.

### Paso 4: **Análisis de la Distribución de los Datos**

#### 4.1 Crear histogramas con pandas

- **Paso**: Crear histogramas para las variables numéricas.
- **Por qué lo hacemos**: Los histogramas nos permiten ver cómo se distribuyen los datos, lo cual es crucial para detectar sesgos o distribuciones no normales en las variables.

```python
import matplotlib.pyplot as plt
df_pandas.hist(figsize=(10, 10))
plt.show()
```

   **Explicación**: Spark no tiene una función directa para generar histogramas, pero pandas nos permite hacerlo fácilmente. Gracias a la reducción y muestreo de datos, pandas puede manejar este proceso sin problemas.

#### 4.2 Detectar outliers usando un Boxplot

- **Paso**: Crear boxplots para detectar valores atípicos (outliers).
- **Por qué lo hacemos**: Los outliers pueden afectar significativamente el análisis. Detectarlos visualmente con un boxplot es una manera rápida de identificarlos.

```python
import seaborn as sns
sns.boxplot(data=df_pandas[['sepal_length', 'sepal_width', 'petal_length', 'petal_width']])
plt.show()
```

   **Explicación**: Nuevamente, Spark no tiene una funcionalidad integrada para gráficos como los boxplots. Por eso, tras muestrear y convertir a pandas, aprovechamos esta herramienta de visualización avanzada para un análisis más profundo.

### Paso 5: **Análisis de Correlaciones**

#### 5.1 Calcular la matriz de correlación

- **Paso**: Calcular la matriz de correlación entre las variables numéricas.
- **Por qué lo hacemos**: Queremos entender si hay relaciones fuertes entre las variables. Las correlaciones nos ayudarán a identificar qué variables están relacionadas y si pueden influir unas en otras.

```python
correlation_matrix = df_pandas.corr()
print(correlation_matrix)
```

   **Explicación**: pandas facilita la generación de matrices de correlación con el método `.corr()`, algo que Spark no ofrece de manera directa. Aunque podemos calcular correlaciones individuales en Spark, pandas es más conveniente cuando queremos visualizar la correlación entre todas las variables.

#### 5.2 Visualizar la matriz de correlación con un heatmap

- **Paso**: Crear un heatmap para visualizar las correlaciones entre variables.
- **Por qué lo hacemos**: Los heatmaps permiten ver visualmente la fuerza de las relaciones entre variables, haciendo que las correlaciones sean más fáciles de interpretar.

```python
sns.heatmap(correlation_matrix, annot=True, cmap="coolwarm")
plt.show()
```

   **Explicación**: Las visualizaciones de heatmaps en Spark no son posibles directamente. Al usar pandas y seaborn, podemos crear fácilmente representaciones visuales de las correlaciones entre variables, lo que facilita la interpretación.

### Paso 6: **Análisis de Variables Categóricas**

#### 6.1 Contar las categorías en la columna `species`

- **Paso**: Contar las observaciones de cada categoría en la columna `species`.
- **Por qué lo hacemos**: Es crucial conocer el balance entre clases antes de hacer análisis avanzados, para evitar sesgos.

```python
df.groupBy("species").count().show()
```

   **Explicación**: Spark es muy eficiente en el manejo de variables categóricas mediante agregaciones distribuidas. Para este tipo de análisis, no necesitamos pandas, ya que Spark ofrece un enfoque más escalable.

### Conclusión

Este laboratorio ha demostrado cómo realizar un EDA efectivo utilizando tanto **Spark** como **pandas** en Databricks. Usamos **Spark DataFrames** para manejar grandes volúmenes de datos de manera distribuida, y cuando fue necesario realizar análisis más específicos o visualizaciones, aplicamos **muestreo** y convertimos los datos a **pandas**. Este enfoque mixto garantiza un análisis eficiente y preciso sin comprometer el rendimiento.
