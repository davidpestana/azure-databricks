### Laboratorio: Crear gráficos básicos para visualizar datos en Databricks

En este laboratorio, aprenderemos cómo crear gráficos básicos para visualizar datos en **Databricks**, utilizando tanto **Spark DataFrames** como **pandas**, donde sea necesario. A lo largo de este laboratorio, mantendremos los mismos criterios que hemos seguido en el anterior, maximizando el uso de **Spark** y recurriendo a **pandas** solo cuando sea imprescindible, aplicando **muestreo** cuando sea necesario para evitar problemas de memoria.

### Paso 1: **Preparar el entorno**

#### 1.1 Crear el clúster de Databricks

- **Paso**: Crear un clúster en Databricks.
- **Por qué lo hacemos**: Para ejecutar las operaciones de Spark en un entorno distribuido, esencial para manejar grandes volúmenes de datos.

1. Ve a la pestaña "Clusters" en el panel de Databricks.
2. Haz clic en "Create Cluster".
3. Configura la máquina como `Standard_DS3_v2` y nómbrala `Visualization-Cluster`.
4. Inicia el clúster.

#### 1.2 Cargar el conjunto de datos

Vamos a trabajar con el dataset **Iris**, que hemos utilizado en laboratorios anteriores. Si ya lo has cargado en Databricks, puedes usar el mismo DataFrame.

1. Subir el archivo `iris.csv` a Databricks.
2. Cargarlo en un Spark DataFrame:

   ```python
   df = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load("/FileStore/tables/iris.csv")
   ```

---

### Paso 2: **Visualización con Spark (Alternativa a pandas)**

En este paso, vamos a explorar las capacidades de **Spark** para la visualización de datos. Aunque Spark no tiene herramientas de visualización nativas, podemos utilizar su capacidad para **agregar** y **procesar** los datos, y luego utilizar herramientas como Databricks Visualizations.

#### 2.1 Crear un gráfico de barras con agregación en Spark

- **Paso**: Crear un gráfico de barras que muestre el número de observaciones para cada especie.
- **Por qué lo hacemos**: Los gráficos de barras son útiles para visualizar distribuciones categóricas. En Spark, primero realizamos la agregación y luego mostramos el resultado en un gráfico.

1. Realiza la agregación en Spark para contar el número de especies:

   ```python
   df_species_count = df.groupBy("species").count()
   df_species_count.show()
   ```

2. Para visualizar el gráfico en Databricks, utiliza **Databricks Visualizations**:

   - Tras ejecutar `df_species_count`, haz clic en el botón "Plot" en la esquina superior derecha del resultado en el notebook de Databricks.
   - Selecciona "Bar Chart" y ajusta los ejes:
     - **X-axis**: `species`
     - **Y-axis**: `count`

#### 2.2 Crear un gráfico de dispersión con Spark

- **Paso**: Crear un gráfico de dispersión para visualizar la relación entre dos variables numéricas (e.g., `sepal_length` y `sepal_width`).
- **Por qué lo hacemos**: Los gráficos de dispersión son útiles para detectar correlaciones entre dos variables.

1. Selecciona las columnas que quieres comparar:

   ```python
   df.select("sepal_length", "sepal_width").show()
   ```

2. Usar **Databricks Visualizations**:
   - Tras ejecutar el `select`, haz clic en "Plot".
   - Selecciona "Scatter Plot".
   - Configura los ejes:
     - **X-axis**: `sepal_length`
     - **Y-axis**: `sepal_width`

---

### Paso 3: **Uso de pandas para Visualización Avanzada**

Si necesitamos gráficos más complejos, como histogramas o boxplots, y no podemos realizarlos directamente con Spark, podemos usar **pandas**. Sin embargo, es importante **muestrear** el conjunto de datos antes de convertirlo a pandas, para evitar problemas de memoria.

#### 3.1 Muestrear los datos para pandas

- **Paso**: Muestrear el DataFrame de Spark antes de convertirlo a pandas.
- **Por qué lo hacemos**: pandas no puede manejar grandes volúmenes de datos como Spark. Al reducir el tamaño del DataFrame, podemos realizar análisis y visualizaciones más detalladas con pandas sin comprometer la memoria.

```python
df_sampled = df.sample(fraction=0.1, seed=42)
df_pandas = df_sampled.toPandas()
```

#### 3.2 Crear histogramas con pandas

- **Paso**: Crear histogramas para las variables numéricas.
- **Por qué lo hacemos**: Los histogramas permiten visualizar la distribución de los datos de manera rápida y eficaz.

```python
import matplotlib.pyplot as plt
df_pandas.hist(figsize=(10, 10))
plt.show()
```

#### 3.3 Crear un boxplot con pandas

- **Paso**: Visualizar un boxplot para detectar outliers en las variables numéricas.
- **Por qué lo hacemos**: Un boxplot es una forma rápida de identificar valores atípicos en los datos.

```python
import seaborn as sns
sns.boxplot(data=df_pandas[['sepal_length', 'sepal_width', 'petal_length', 'petal_width']])
plt.show()
```

---

### Paso 4: **Correlaciones y Visualización de Relaciones**

#### 4.1 Calcular la matriz de correlación

- **Paso**: Generar una matriz de correlación para las variables numéricas.
- **Por qué lo hacemos**: Las correlaciones nos permiten entender cómo se relacionan las variables entre sí.

```python
correlation_matrix = df_pandas.corr()
print(correlation_matrix)
```

#### 4.2 Visualizar la matriz de correlación con un heatmap

- **Paso**: Crear un heatmap para visualizar las correlaciones entre las variables numéricas.
- **Por qué lo hacemos**: Un heatmap facilita la interpretación visual de la matriz de correlación, mostrando relaciones fuertes y débiles entre las variables.

```python
sns.heatmap(correlation_matrix, annot=True, cmap="coolwarm")
plt.show()
```

---

### Conclusión

En este laboratorio, hemos visto cómo crear gráficos básicos utilizando tanto **Spark** como **pandas** en Databricks. Hemos aprendido a:
- Utilizar **Spark** para realizar agregaciones y generar gráficos básicos dentro de Databricks.
- Aplicar **pandas** para crear visualizaciones más avanzadas, como histogramas y boxplots, cuando Spark no puede ofrecer estas funcionalidades de forma directa.
- Usar **muestreo** para manejar los datos de manera eficiente en pandas, asegurando que las operaciones no sobrecarguen la memoria.

Este laboratorio te enseña cómo combinar lo mejor de **Spark** y **pandas** para visualizar datos en Databricks, optimizando el rendimiento y la eficiencia.