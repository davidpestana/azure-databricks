### Laboratorio: Uso de Bibliotecas Avanzadas para Visualización (Seaborn, Plotly) en Databricks

En este laboratorio, exploraremos cómo usar bibliotecas avanzadas como **Seaborn** y **Plotly** para generar visualizaciones interactivas y detalladas en **Databricks**. Continuaremos aplicando los criterios que hemos establecido anteriormente: maximizar el uso de **Spark** cuando sea posible y recurrir a **pandas** para casos donde necesitamos funciones específicas de estas bibliotecas, utilizando **muestreo** cuando los datos son grandes.

### Paso 1: **Preparar el entorno**

#### 1.1 Crear el clúster de Databricks

- **Paso**: Crear un clúster en Databricks para ejecutar operaciones distribuidas.
- **Por qué lo hacemos**: Un clúster de Databricks nos permite aprovechar Spark para manejar grandes volúmenes de datos, algo esencial para mantener la eficiencia en nuestro análisis.

1. Ve a la pestaña "Clusters".
2. Haz clic en "Create Cluster" y selecciona la configuración `Standard_DS3_v2`.
3. Inicia el clúster.

#### 1.2 Cargar el conjunto de datos

Trabajaremos con el conjunto de datos **Iris** que hemos utilizado en laboratorios anteriores. Si ya lo has cargado, puedes utilizar el mismo DataFrame.

1. Cargar el archivo `iris.csv` en Databricks.
2. Cargar los datos en un Spark DataFrame:

   ```python
   df = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load("/FileStore/tables/iris.csv")
   ```

---

### Paso 2: **Muestrear y Reducir el DataFrame para Visualización con pandas**

Dado que bibliotecas como **Seaborn** y **Plotly** están diseñadas para funcionar con **pandas**, primero tomaremos una muestra representativa de nuestro conjunto de datos grande para convertirlo a pandas. Esto nos permitirá realizar visualizaciones avanzadas sin problemas de rendimiento.

#### 2.1 Muestrear los datos para pandas

- **Paso**: Muestrear el DataFrame de Spark antes de convertirlo a pandas.
- **Por qué lo hacemos**: pandas no está diseñado para manejar grandes volúmenes de datos, por lo que muestrear los datos nos permite realizar análisis avanzados y visualizaciones sin sobrecargar la memoria.

```python
df_sampled = df.sample(fraction=0.1, seed=42)
df_pandas = df_sampled.toPandas()
```

---

### Paso 3: **Uso de Seaborn para Visualización**

**Seaborn** es una poderosa biblioteca de visualización que permite crear gráficos estadísticos atractivos y detallados con menos código. En este paso, vamos a generar gráficos comunes utilizando Seaborn.

#### 3.1 Crear un gráfico de dispersión con Seaborn

- **Paso**: Crear un gráfico de dispersión (scatterplot) que muestre la relación entre `sepal_length` y `sepal_width`.
- **Por qué lo hacemos**: Un gráfico de dispersión es ideal para visualizar correlaciones entre dos variables continuas.

```python
import seaborn as sns
import matplotlib.pyplot as plt

sns.scatterplot(x='sepal_length', y='sepal_width', data=df_pandas)
plt.title('Relación entre largo y ancho del sépalo')
plt.show()
```

#### 3.2 Crear un gráfico de boxplot con Seaborn

- **Paso**: Crear un boxplot para visualizar la distribución de los valores de `sepal_length` por especie.
- **Por qué lo hacemos**: Un boxplot es útil para identificar outliers y observar la dispersión de los datos por grupos.

```python
sns.boxplot(x='species', y='sepal_length', data=df_pandas)
plt.title('Distribución del largo del sépalo por especie')
plt.show()
```

#### 3.3 Crear un gráfico de correlación con un heatmap

- **Paso**: Crear un heatmap para visualizar las correlaciones entre las variables numéricas.
- **Por qué lo hacemos**: Un heatmap facilita la interpretación visual de la matriz de correlación, mostrando qué tan fuerte es la relación entre las variables.

```python
correlation_matrix = df_pandas.corr()
sns.heatmap(correlation_matrix, annot=True, cmap="coolwarm")
plt.title('Matriz de Correlación')
plt.show()
```

---

### Paso 4: **Uso de Plotly para Visualización Interactiva**

**Plotly** es una biblioteca avanzada que permite crear gráficos interactivos. A diferencia de Seaborn o matplotlib, Plotly ofrece herramientas para explorar los gráficos de manera interactiva, lo que es útil para la presentación de resultados y la exploración de datos.

#### 4.1 Crear un gráfico de dispersión interactivo con Plotly

- **Paso**: Crear un gráfico de dispersión interactivo con `sepal_length` y `sepal_width`.
- **Por qué lo hacemos**: Los gráficos de dispersión interactivos permiten a los usuarios explorar los datos con facilidad, acercando, alejando y seleccionando puntos específicos.

```python
import plotly.express as px

fig = px.scatter(df_pandas, x='sepal_length', y='sepal_width', color='species', title='Scatter plot interactivo - Largo y Ancho del Sépalo')
fig.show()
```

#### 4.2 Crear un gráfico de líneas con Plotly

- **Paso**: Crear un gráfico de líneas para mostrar la evolución de los valores de `sepal_length` a lo largo de las observaciones.
- **Por qué lo hacemos**: Un gráfico de líneas es útil para ver tendencias en los datos a lo largo de un índice temporal o una secuencia de observaciones.

```python
fig = px.line(df_pandas, y='sepal_length', title='Evolución del largo del sépalo en las observaciones')
fig.show()
```

#### 4.3 Crear un histograma interactivo con Plotly

- **Paso**: Crear un histograma interactivo para visualizar la distribución de `sepal_length`.
- **Por qué lo hacemos**: Los histogramas interactivos permiten explorar la distribución de los datos y ver cómo cambian los valores al ajustar los filtros o los rangos.

```python
fig = px.histogram(df_pandas, x='sepal_length', nbins=20, title='Histograma interactivo - Largo del Sépalo')
fig.show()
```

---

### Conclusión

En este laboratorio, hemos aprendido a utilizar bibliotecas avanzadas como **Seaborn** y **Plotly** para crear visualizaciones tanto estáticas como interactivas. Hemos seguido los mismos criterios que en los laboratorios anteriores, utilizando **Spark** para manejar grandes volúmenes de datos, **muestreando** cuando sea necesario para trabajar con pandas, y aprovechando las capacidades de visualización avanzadas de estas bibliotecas.

Las visualizaciones interactivas con **Plotly** son particularmente útiles cuando queremos que los usuarios exploren los gráficos de manera dinámica, mientras que **Seaborn** es ideal para gráficos estadísticos rápidos y efectivos. Esto proporciona una poderosa combinación para explorar y presentar datos en **Databricks** de forma eficiente y detallada.