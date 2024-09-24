### Creación y Manipulación de DataFrames

En **PySpark**, los **DataFrames** son una abstracción de alto nivel utilizada para manipular y analizar datos tabulares. Son similares a las tablas en bases de datos relacionales y al concepto de DataFrames en **pandas**, lo que los convierte en una opción poderosa para manipular grandes volúmenes de datos distribuidos en un clúster de Apache Spark.

#### ¿Qué es un DataFrame?

Un **DataFrame** es una colección distribuida de datos estructurados organizados en columnas, similar a una tabla en una base de datos o un archivo CSV con encabezados. Ofrece varias ventajas sobre otras estructuras de datos distribuidos (como los RDDs), ya que está optimizado para realizar consultas SQL, agregaciones, filtros y muchas otras operaciones a gran escala.

Los **DataFrames** son ideales cuando se trabaja con datos estructurados o semiestructurados. Las columnas en un DataFrame tienen tipos de datos definidos y se pueden aplicar operaciones como filtrado, selección, agregación y ordenamiento de manera eficiente.

---

#### 1. **Crear un DataFrame a partir de una lista o colección**

Puedes crear un DataFrame en PySpark directamente a partir de una colección como una lista de Python o un RDD. Esto es útil para datos estructurados almacenados en estructuras de datos en memoria.

```python
from pyspark.sql import SparkSession

# Crear una sesión de Spark
spark = SparkSession.builder.appName("DataFrameExample").getOrCreate()

# Crear una lista de datos
data = [("Alice", 25), ("Bob", 30), ("Charlie", 35)]

# Crear un DataFrame a partir de una lista
df = spark.createDataFrame(data, ["Nombre", "Edad"])

# Mostrar el DataFrame
df.show()
```

**Explicación**:
- **createDataFrame()** permite crear un DataFrame a partir de una lista o un RDD.
- **show()** muestra los datos del DataFrame en formato tabular.

---

#### 2. **Leer un DataFrame desde un Archivo CSV**

Uno de los métodos más comunes para crear DataFrames en PySpark es leyendo datos desde archivos CSV. PySpark permite inferir el esquema automáticamente o definirlo manualmente.

```python
# Leer un archivo CSV en un DataFrame
df_csv = spark.read.csv("/databricks-datasets/samples/population-vs-price/data_geo.csv", header=True, inferSchema=True)

# Mostrar las primeras filas del DataFrame
df_csv.show(5)
```

**Explicación**:
- **read.csv()** carga un archivo CSV en un DataFrame.
- **header=True** indica que la primera fila del archivo contiene los nombres de las columnas.
- **inferSchema=True** permite a PySpark inferir los tipos de datos de cada columna automáticamente.

---

#### 3. **Esquema de un DataFrame**

El esquema de un DataFrame define los nombres de las columnas y los tipos de datos asociados a cada columna. Esto permite que PySpark optimice las operaciones sobre los datos.

```python
# Ver el esquema del DataFrame
df_csv.printSchema()
```

**Explicación**:
- **printSchema()** muestra la estructura de las columnas del DataFrame y sus tipos de datos.

---

#### 4. **Seleccionar Columnas de un DataFrame**

Al trabajar con DataFrames, una de las operaciones más comunes es la selección de columnas específicas para análisis o procesamiento.

```python
# Seleccionar columnas específicas
df_seleccion = df_csv.select("city", "population")

# Mostrar el DataFrame con las columnas seleccionadas
df_seleccion.show(5)
```

**Explicación**:
- **select()** permite elegir columnas específicas de un DataFrame.

---

#### 5. **Agregar Nuevas Columnas a un DataFrame**

Puedes añadir nuevas columnas a un DataFrame basadas en cálculos o valores derivados de otras columnas.

```python
from pyspark.sql.functions import when

# Añadir una nueva columna 'clasificación' basada en la población
df_con_clasificacion = df_csv.withColumn("clasificación", when(df_csv["population"] > 1000000, "Alta").otherwise("Baja"))

# Mostrar el DataFrame con la nueva columna
df_con_clasificacion.show(5)
```

**Explicación**:
- **withColumn()** añade una nueva columna a un DataFrame.
- **when()** es una función de PySpark que se utiliza para crear expresiones condicionales en columnas.

---

#### 6. **Filtrar Filas en un DataFrame**

El filtrado es esencial para extraer subconjuntos de datos en función de condiciones lógicas.

```python
# Filtrar filas donde la población es mayor a 1 millón
df_filtrado = df_csv.filter(df_csv["population"] > 1000000)

# Mostrar el DataFrame filtrado
df_filtrado.show(5)
```

**Explicación**:
- **filter()** permite aplicar una condición lógica para filtrar las filas de un DataFrame.

---

#### 7. **Agrupar y Agregar Datos en un DataFrame**

Las agregaciones son muy comunes en el análisis de datos, y PySpark permite agrupar datos por una o más columnas y aplicar funciones de agregación como la suma o el promedio.

```python
# Agrupar por ciudad y sumar la población
df_agrupado = df_csv.groupBy("city").sum("population")

# Mostrar el resultado de la agregación
df_agrupado.show(5)
```

**Explicación**:
- **groupBy()** agrupa los datos por una o más columnas.
- **sum()** calcula la suma de los valores en la columna especificada.

---

#### 8. **Guardar un DataFrame en un Archivo CSV**

Después de realizar las transformaciones necesarias en un DataFrame, puedes guardar los resultados en un archivo CSV para usarlos más tarde.

```python
# Guardar el DataFrame en formato CSV
df_con_clasificacion.write.csv("/dbfs/FileStore/shared_uploads/tu_usuario/ciudades_clasificadas.csv")

print("Archivo CSV guardado correctamente.")
```

**Explicación**:
- **write.csv()** guarda el contenido del DataFrame en un archivo CSV en el almacenamiento de Databricks.

---

#### Conclusión

Los **DataFrames** en PySpark son una herramienta poderosa para procesar grandes volúmenes de datos estructurados. Permiten realizar operaciones de selección, filtrado, agregación, y muchas otras de manera distribuida y eficiente. Con PySpark, puedes leer y manipular datos desde una variedad de fuentes, incluyendo archivos CSV, JSON y bases de datos. Además, los DataFrames están optimizados para consultas SQL y se pueden integrar fácilmente con otros componentes del ecosistema Apache Spark.