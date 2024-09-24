### Anexo de Recursos para los Laboratorios del Tema: Introducción a Apache Spark

En este anexo, generaremos los datos necesarios para ejecutar los laboratorios asociados a la **Introducción a Apache Spark**, específicamente los laboratorios de procesamiento de archivos de texto, conteo de palabras y monitorización de tareas. Las celdas de código proporcionadas aquí pueden ser añadidas al inicio de cada laboratorio para generar los datos que se requieren para su ejecución.

---

#### 1. **Generar un Archivo de Texto en DBFS**

Este script crea un archivo de texto en el sistema de archivos de Databricks (DBFS) con contenido simple para procesar con Spark.

```python
# Crear contenido de ejemplo para el archivo de texto
contenido = """
Hola, este es un archivo de ejemplo.
Spark es una herramienta potente para el procesamiento de grandes datos.
Apache Spark es rápido gracias a su procesamiento en memoria.
El procesamiento distribuido es clave para el análisis de grandes volúmenes de datos.
"""

# Guardar el contenido en un archivo de texto en DBFS
ruta_archivo = "/dbfs/FileStore/shared_uploads/tu_usuario/archivo_ejemplo.txt"
dbutils.fs.put(ruta_archivo, contenido, overwrite=True)

# Verificar que el archivo fue guardado correctamente
print(f"Archivo guardado en: {ruta_archivo}")
```

Este archivo ahora puede ser utilizado en los laboratorios donde se requiere procesar un archivo de texto para contar líneas, palabras, o realizar otras operaciones en Spark.

---

#### 2. **Generar Datos Aleatorios para Pruebas**

En algunos laboratorios, podría ser útil trabajar con datos estructurados o semi-estructurados. A continuación, se muestra cómo generar datos aleatorios en un formato que puede ser utilizado para otros ejercicios de procesamiento con Spark.

##### Generar un DataFrame con Datos Aleatorios:

```python
from pyspark.sql import SparkSession
from pyspark.sql.functions import rand, col

# Crear un SparkSession
spark = SparkSession.builder.appName("GenerarDatosAleatorios").getOrCreate()

# Generar un DataFrame con datos aleatorios
df = spark.range(1000).withColumn("valor_random", rand())

# Mostrar los primeros registros
df.show()

# Guardar el DataFrame como un archivo Parquet en DBFS
df.write.mode("overwrite").parquet("/dbfs/FileStore/shared_uploads/tu_usuario/datos_aleatorios.parquet")

# Verificar la ruta del archivo
print("Datos aleatorios guardados en: /dbfs/FileStore/shared_uploads/tu_usuario/datos_aleatorios.parquet")
```

Este DataFrame contiene 1000 filas con valores aleatorios generados por la función `rand()`. Puedes utilizar estos datos para operaciones de prueba como transformaciones o agregaciones.

---

#### 3. **Generar un Archivo CSV para Procesar en Spark**

Este script genera un archivo CSV de ejemplo que puede ser usado para ejercicios de manipulación de datos y consultas SQL en Spark.

```python
import pandas as pd

# Crear un DataFrame de Pandas con datos de ejemplo
datos = {
    "nombre": ["Alice", "Bob", "Charlie", "David", "Eva"],
    "edad": [25, 30, 35, 40, 22],
    "ciudad": ["Madrid", "Barcelona", "Valencia", "Sevilla", "Bilbao"]
}
df_pandas = pd.DataFrame(datos)

# Convertir el DataFrame a CSV y guardarlo en DBFS
ruta_csv = "/dbfs/FileStore/shared_uploads/tu_usuario/datos_ejemplo.csv"
df_pandas.to_csv(ruta_csv, index=False)

# Verificar la ruta del archivo
print(f"Archivo CSV guardado en: {ruta_csv}")
```

Este archivo CSV contiene datos de personas con campos como **nombre**, **edad** y **ciudad**. Puede ser utilizado para realizar consultas SQL o transformaciones utilizando Spark.

---

#### 4. **Generar Datos en JSON**

Si necesitas trabajar con datos semi-estructurados, este script crea un archivo en formato **JSON** que contiene una estructura más compleja.

```python
import json

# Crear una lista de diccionarios con datos de ejemplo
datos_json = [
    {"nombre": "Alice", "edad": 25, "ciudad": "Madrid", "empleo": {"cargo": "Ingeniera", "años_experiencia": 3}},
    {"nombre": "Bob", "edad": 30, "ciudad": "Barcelona", "empleo": {"cargo": "Analista", "años_experiencia": 5}},
    {"nombre": "Charlie", "edad": 35, "ciudad": "Valencia", "empleo": {"cargo": "Gerente", "años_experiencia": 10}},
]

# Guardar los datos como un archivo JSON en DBFS
ruta_json = "/dbfs/FileStore/shared_uploads/tu_usuario/datos_ejemplo.json"
with open(ruta_json.replace("/dbfs", ""), "w") as archivo_json:
    json.dump(datos_json, archivo_json, indent=4)

# Verificar que los datos se guardaron correctamente
print(f"Archivo JSON guardado en: {ruta_json}")
```

Este archivo JSON contiene datos estructurados con campos anidados, útiles para operaciones complejas de transformación y análisis en Spark.

---

### Conclusión

Este anexo proporciona los datos necesarios para ejecutar los laboratorios relacionados con **Apache Spark**. Los archivos creados en **DBFS** pueden ser utilizados de manera repetida en los ejercicios, y los formatos de datos (texto, Parquet, CSV, JSON) cubren una variedad de escenarios de procesamiento y análisis de datos.