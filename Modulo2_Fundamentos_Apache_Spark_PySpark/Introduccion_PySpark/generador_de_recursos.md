### Anexo: Generación de Recursos para los Laboratorios de DataFrames y RDDs en PySpark

En este anexo, aprenderemos cómo generar los recursos de datos necesarios para ejecutar los laboratorios relacionados con **RDDs** y **DataFrames** en **PySpark**. A continuación, se proporcionan ejemplos de cómo generar archivos CSV, JSON, y archivos de texto que pueden ser utilizados como entrada en los laboratorios. Estos archivos serán almacenados en **DBFS (Databricks File System)** para facilitar su uso en los notebooks.

---

#### 1. **Generar un Archivo de Texto para Operaciones con RDDs**

Este archivo de texto será utilizado en los laboratorios relacionados con **RDDs**, como el conteo de palabras o el filtrado de líneas. El archivo se guardará en **DBFS**.

```python
# Crear contenido de ejemplo para el archivo de texto
contenido_texto = """
Apache Spark es un motor de procesamiento distribuido.
Permite el procesamiento en memoria, lo que mejora la velocidad.
PySpark es la interfaz de Spark para Python.
Los RDDs son la estructura de datos fundamental en Spark.
"""

# Guardar el contenido como un archivo de texto en DBFS
dbutils.fs.put("/dbfs/FileStore/shared_uploads/tu_usuario/archivo_rdd.txt", contenido_texto, overwrite=True)

# Verificar que el archivo fue guardado correctamente
print("Archivo de texto guardado correctamente en DBFS.")
```

Este archivo podrá ser utilizado en los ejercicios de RDD para realizar operaciones como `map()`, `filter()`, y `reduce()`.

---

#### 2. **Generar un Archivo CSV para Operaciones con DataFrames**

Este archivo CSV será utilizado en los laboratorios de **DataFrames**. Crearemos un archivo que contiene datos de ciudades y poblaciones, que luego podremos cargar en un **DataFrame** y manipular con PySpark.

```python
import pandas as pd

# Crear un DataFrame de pandas con datos de ejemplo
datos_ciudades = {
    "city": ["Madrid", "Barcelona", "Valencia", "Sevilla", "Bilbao"],
    "population": [3223334, 1620343, 791413, 688592, 345122],
    "region": ["Madrid", "Cataluña", "Valencia", "Andalucía", "País Vasco"]
}

df_ciudades = pd.DataFrame(datos_ciudades)

# Guardar el DataFrame como un archivo CSV en DBFS
ruta_csv = "/dbfs/FileStore/shared_uploads/tu_usuario/ciudades_poblacion.csv"
df_ciudades.to_csv(ruta_csv, index=False)

# Verificar que el archivo fue guardado correctamente
print("Archivo CSV guardado correctamente en DBFS.")
```

Este archivo CSV podrá ser utilizado para realizar operaciones con **DataFrames**, como agregaciones, filtrados, y consultas SQL.

---

#### 3. **Generar un Archivo JSON para Operaciones Avanzadas con DataFrames**

El archivo JSON se utilizará para practicar el procesamiento de datos semi-estructurados, lo que es útil cuando los datos incluyen estructuras anidadas.

```python
import json

# Crear una lista de diccionarios para generar un archivo JSON
datos_json = [
    {"city": "Madrid", "population": 3223334, "region": "Madrid", "coordinates": {"lat": 40.4168, "lon": -3.7038}},
    {"city": "Barcelona", "population": 1620343, "region": "Cataluña", "coordinates": {"lat": 41.3851, "lon": 2.1734}},
    {"city": "Valencia", "population": 791413, "region": "Valencia", "coordinates": {"lat": 39.4699, "lon": -0.3763}},
    {"city": "Sevilla", "population": 688592, "region": "Andalucía", "coordinates": {"lat": 37.3886, "lon": -5.9823}},
    {"city": "Bilbao", "population": 345122, "region": "País Vasco", "coordinates": {"lat": 43.2630, "lon": -2.9349}}
]

# Guardar los datos en formato JSON
ruta_json = "/dbfs/FileStore/shared_uploads/tu_usuario/ciudades.json"
with open(ruta_json.replace("/dbfs", ""), "w") as archivo_json:
    json.dump(datos_json, archivo_json, indent=4)

# Verificar que el archivo fue guardado correctamente
print(f"Archivo JSON guardado correctamente en: {ruta_json}")
```

Este archivo JSON será útil para operaciones avanzadas, como procesar datos anidados y ejecutar consultas complejas en PySpark.

---

#### 4. **Generar un Archivo Parquet para Operaciones con DataFrames**

El formato **Parquet** es ideal para almacenar datos grandes y comprimidos, optimizado para consultas rápidas. Este archivo será utilizado en los laboratorios de PySpark para trabajar con datos almacenados en formato Parquet.

```python
from pyspark.sql import SparkSession

# Crear una sesión de Spark
spark = SparkSession.builder.appName("ParquetExample").getOrCreate()

# Crear un DataFrame en PySpark
data = [("Madrid", 3223334, "Madrid"), ("Barcelona", 1620343, "Cataluña"), 
        ("Valencia", 791413, "Valencia"), ("Sevilla", 688592, "Andalucía"), 
        ("Bilbao", 345122, "País Vasco")]

columnas = ["city", "population", "region"]
df_parquet = spark.createDataFrame(data, columnas)

# Guardar el DataFrame en formato Parquet
df_parquet.write.parquet("/dbfs/FileStore/shared_uploads/tu_usuario/ciudades_parquet")

print("Archivo Parquet guardado correctamente en DBFS.")
```

Este archivo **Parquet** será utilizado para cargar y manipular datos estructurados de manera eficiente en los laboratorios de DataFrames.

---

#### 5. **Verificación de Archivos Guardados en DBFS**

Puedes verificar que los archivos se han guardado correctamente y listar los archivos disponibles en **DBFS** utilizando los siguientes comandos:

```python
# Listar los archivos en la carpeta de DBFS
dbutils.fs.ls("/FileStore/shared_uploads/tu_usuario/")

# Mostrar el contenido de un archivo CSV
df = spark.read.csv("/FileStore/shared_uploads/tu_usuario/ciudades_poblacion.csv", header=True)
df.show()
```

---

### Conclusión

Este anexo proporciona los recursos necesarios para ejecutar los laboratorios de **RDDs** y **DataFrames** en PySpark, generando archivos de texto, CSV, JSON, y Parquet. Estos archivos se almacenarán en **DBFS (Databricks File System)** para que puedan ser accedidos y manipulados desde cualquier notebook dentro del entorno de Databricks.