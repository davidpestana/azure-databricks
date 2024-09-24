### Laboratorio: Creación y Manipulación de DataFrames

**Objetivo**: En este laboratorio, aprenderás a trabajar con **DataFrames** en PySpark, una abstracción de alto nivel para manipular datos estructurados. Los DataFrames son similares a los de **pandas** y ofrecen una interfaz más fácil de usar que los **RDDs**. Veremos cómo crear un DataFrame, realizar operaciones básicas y avanzadas, y finalmente cómo guardar los resultados.

#### Requisitos:
- Acceso a un **notebook** en **Azure Databricks**.
- Un **clúster** de Databricks en funcionamiento (si no tienes uno creado, consulta laboratorios anteriores sobre cómo crear un clúster).

#### ¿Qué es un DataFrame en PySpark?

Un **DataFrame** en PySpark es una colección distribuida de datos organizados en columnas, que proporciona una API similar a las bases de datos relacionales y **pandas**. Está diseñado para manejar grandes volúmenes de datos distribuidos en varios nodos, permitiendo realizar consultas y operaciones en paralelo de manera eficiente.

---

#### 1. **Crear un DataFrame desde una Lista de Datos**

Comencemos creando un DataFrame a partir de una lista de datos en Python. 

```python
from pyspark.sql import SparkSession
from pyspark.sql import Row

# Crear una SparkSession
spark = SparkSession.builder.appName("DataFrame").getOrCreate()

# Crear una lista de datos
datos = [("Alice", 25), ("Bob", 30), ("Charlie", 35)]

# Crear un DataFrame a partir de la lista
df = spark.createDataFrame(datos, ["Nombre", "Edad"])

# Mostrar el DataFrame
df.show()
```

**Explicación**:
- El método `createDataFrame()` permite crear un DataFrame a partir de una lista o RDD.
- `show()` muestra los datos en formato tabular.

---

#### 2. **Leer un DataFrame desde un Archivo CSV**

Además de crear DataFrames desde listas, también puedes leer archivos de datos como CSVs.

```python
# Leer un archivo CSV en un DataFrame
df_csv = spark.read.csv("/databricks-datasets/samples/population-vs-price/data_geo.csv", header=True, inferSchema=True)

# Mostrar los primeros registros
df_csv.show(5)
```

**Explicación**:
- `read.csv()` permite cargar archivos CSV en un DataFrame.
- `header=True` indica que el archivo CSV tiene encabezados.
- `inferSchema=True` permite que Spark infiera automáticamente los tipos de datos de las columnas.

---

#### 3. **Realizar Operaciones Básicas en un DataFrame**

Vamos a realizar algunas operaciones comunes, como seleccionar columnas, filtrar filas, y ordenar los datos.

```python
# Seleccionar columnas específicas
df_csv_seleccion = df_csv.select("city", "population")
df_csv_seleccion.show(5)

# Filtrar filas donde la población sea mayor a 1 millón
df_csv_filtrado = df_csv.filter(df_csv["population"] > 1000000)
df_csv_filtrado.show(5)

# Ordenar los datos por la población en orden descendente
df_csv_ordenado = df_csv.orderBy(df_csv["population"].desc())
df_csv_ordenado.show(5)
```

**Explicación**:
- **select()**: Permite seleccionar columnas específicas del DataFrame.
- **filter()**: Filtra las filas que cumplen con una condición.
- **orderBy()**: Ordena los datos por una o más columnas (en este caso, por población).

---

#### 4. **Agregar y Agrupar Datos en el DataFrame**

Realicemos operaciones de agregación y agrupamiento sobre los datos.

```python
# Agrupar los datos por ciudad y sumar la población
df_agrupado = df_csv.groupBy("city").sum("population")

# Mostrar el resultado
df_agrupado.show(5)
```

**Explicación**:
- **groupBy()** agrupa los datos por una columna y permite realizar agregaciones como la suma de la población.

---

#### 5. **Añadir una Nueva Columna al DataFrame**

Puedes crear una nueva columna derivada de las existentes. A continuación, añadiremos una columna que clasifique las ciudades en base a su población.

```python
from pyspark.sql.functions import when

# Añadir una nueva columna 'clasificación' basada en la población
df_con_clasificacion = df_csv.withColumn("clasificación", when(df_csv["population"] > 1000000, "Alta").otherwise("Baja"))

# Mostrar el DataFrame con la nueva columna
df_con_clasificacion.show(5)
```

**Explicación**:
- **withColumn()** se usa para añadir una nueva columna.
- **when()** crea una expresión condicional para asignar valores a la nueva columna basada en los valores de otra columna.

---

#### 6. **Realizar Consultas SQL en DataFrames**

Spark permite ejecutar consultas SQL sobre DataFrames. Para hacer esto, primero debes registrar el DataFrame como una tabla temporal.

```python
# Registrar el DataFrame como una tabla temporal
df_csv.createOrReplaceTempView("poblacion")

# Ejecutar una consulta SQL
resultado_sql = spark.sql("SELECT city, population FROM poblacion WHERE population > 1000000")

# Mostrar el resultado de la consulta SQL
resultado_sql.show(5)
```

**Explicación**:
- **createOrReplaceTempView()** permite registrar un DataFrame como una tabla temporal sobre la cual se pueden realizar consultas SQL.
- **sql()** ejecuta una consulta SQL directamente en el DataFrame registrado.

---

#### 7. **Guardar los Resultados en un Archivo**

Puedes guardar los resultados de las operaciones en varios formatos, como CSV, Parquet, JSON, etc. A continuación, guardamos el DataFrame en un archivo CSV en DBFS.

```python
# Guardar el DataFrame en formato CSV
df_con_clasificacion.write.csv("/dbfs/FileStore/shared_uploads/tu_usuario/ciudades_clasificadas.csv")

print("Archivo CSV guardado correctamente.")
```

---

#### 8. **Caché de un DataFrame**

Si planeas reutilizar un DataFrame varias veces, puedes almacenarlo en caché para mejorar el rendimiento.

```python
# Almacenar el DataFrame en caché
df_csv.cache()

# Contar el número de filas (esto utilizará la versión en caché)
df_csv.count()
```

**Explicación**:
- **cache()** almacena el DataFrame en memoria para futuras operaciones.

---

### Conclusión

En este laboratorio, hemos aprendido a crear y manipular **DataFrames** en PySpark. Has visto cómo cargar datos desde archivos CSV, realizar operaciones comunes como filtrado, selección, agregación y ordenamiento, así como ejecutar consultas SQL sobre los datos. Además, aprendimos a añadir nuevas columnas, almacenar los resultados y cómo optimizar las operaciones utilizando caché. Los DataFrames son una herramienta poderosa en PySpark para el procesamiento de grandes volúmenes de datos distribuidos, facilitando un flujo de trabajo similar a **pandas**, pero con las ventajas de un motor distribuido como **Apache Spark**.