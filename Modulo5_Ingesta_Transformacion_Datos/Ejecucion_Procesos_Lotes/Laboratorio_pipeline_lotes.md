### **Laboratorio: Crear un pipeline de procesamiento de datos usando notebooks**

### **Objetivo del laboratorio**

El objetivo de este laboratorio es aprender a crear un **pipeline de procesamiento por lotes** usando un notebook en **Azure Databricks**. Este pipeline procesará un conjunto de datos masivo de transacciones diarias de una empresa de **retail**, calculará las métricas necesarias y almacenará los resultados en **Azure Data Lake** para su posterior análisis. El pipeline se automatizará para ejecutarse cada noche de manera continua.

### **Escenario**

Trabajas en el equipo de análisis de una empresa de retail que procesa transacciones diarias. Se te ha solicitado crear un pipeline que procese los datos de ventas del día anterior, calcule métricas como las ventas totales y los márgenes de beneficio por categoría de producto, y almacene los resultados en un archivo **Parquet** en **Azure Data Lake**.

---

### **Paso 1: Cargar los datos de ventas desde Azure Blob Storage**

El primer paso en este pipeline es cargar los datos de ventas diarios desde **Azure Blob Storage**. Para hacerlo, utilizaremos las funciones de **Spark** para leer archivos CSV desde un contenedor de almacenamiento.

#### Celda 1: Cargar los datos de ventas

```python
from datetime import datetime, timedelta

# Calcular la fecha del día anterior
ayer = (datetime.now() - timedelta(1)).strftime("%Y-%m-%d")

# Ruta donde se almacenan los datos de ventas
sales_path = f"/mnt/blobstorage/sales/{ayer}/ventas.csv"

# Cargar los datos de ventas desde un archivo CSV
df_ventas = spark.read.csv(sales_path, header=True, inferSchema=True)

# Mostrar los primeros registros
df_ventas.show(5)
```

#### Explicación:
- **datetime.now() - timedelta(1)**: Calcula la fecha del día anterior para cargar el archivo correcto.
- **spark.read.csv()**: Lee el archivo CSV que contiene las transacciones del día anterior desde **Azure Blob Storage**.

---

### **Paso 2: Transformar los datos**

A continuación, transformaremos los datos de ventas. Esto incluye eliminar duplicados, calcular el margen de beneficio y agrupar las ventas por categoría de producto para obtener las métricas necesarias.

#### Celda 2: Eliminar duplicados y calcular margen de beneficio

```python
# Eliminar duplicados en las transacciones
df_ventas_limpio = df_ventas.dropDuplicates()

# Calcular el margen de beneficio
df_ventas_limpio = df_ventas_limpio.withColumn("margen_beneficio", df_ventas_limpio.precio_venta - df_ventas_limpio.costo)

# Mostrar los resultados
df_ventas_limpio.show(5)
```

#### Explicación:
- **dropDuplicates()**: Elimina cualquier registro duplicado en las transacciones.
- **withColumn()**: Añade una nueva columna que calcula el margen de beneficio de cada transacción.

#### Celda 3: Agrupar ventas por categoría de producto

```python
from pyspark.sql.functions import sum

# Agrupar ventas por categoría de producto y calcular las ventas totales y el margen de beneficio
df_ventas_agrupadas = df_ventas_limpio.groupBy("categoria_producto").agg(
    sum("precio_venta").alias("total_ventas"),
    sum("margen_beneficio").alias("total_margen")
)

# Mostrar los resultados
df_ventas_agrupadas.show(5)
```

#### Explicación:
- **groupBy()**: Agrupa las transacciones por categoría de producto.
- **agg()**: Calcula el total de ventas y el margen de beneficio por categoría.

---

### **Paso 3: Guardar los resultados en Azure Data Lake**

Una vez que hemos transformado los datos, el siguiente paso es guardar los resultados en **Azure Data Lake** en formato **Parquet**.

#### Celda 4: Guardar los datos en formato Parquet

```python
# Ruta de destino en Azure Data Lake para guardar los resultados
output_path = f"/mnt/datalake/resultados/{ayer}/ventas_por_categoria.parquet"

# Guardar los resultados en formato Parquet
df_ventas_agrupadas.write.parquet(output_path, mode="overwrite")

# Verificar que los archivos se han guardado correctamente
display(dbutils.fs.ls(f"/mnt/datalake/resultados/{ayer}/"))
```

#### Explicación:
- **write.parquet()**: Guarda los resultados en **formato Parquet**, que es eficiente para grandes volúmenes de datos.
- **overwrite**: Sobrescribe cualquier archivo existente en la ruta especificada.

---

### **Paso 4: Automatizar la ejecución del pipeline**

Para automatizar este pipeline, lo programaremos para que se ejecute cada día a la medianoche utilizando **Databricks Jobs**.

#### Instrucciones para configurar el Job:

1. En el entorno de **Azure Databricks**, ve a la sección **Jobs**.
2. Crea un **nuevo Job** y selecciona el **notebook** que contiene el pipeline.
3. Configura la **programación** para que el Job se ejecute todos los días a la medianoche.
4. Agrega notificaciones para recibir alertas por correo en caso de fallo.

---

### **Conclusión del laboratorio**

En este laboratorio, has aprendido a:

1. **Cargar datos de ventas diarios** desde Azure Blob Storage utilizando un notebook en Databricks.
2. **Transformar los datos** para calcular las ventas totales y márgenes de beneficio por categoría de producto.
3. **Guardar los resultados transformados** en Azure Data Lake en formato Parquet.
4. **Automatizar la ejecución del pipeline** programando un Databricks Job.

Este pipeline es un ejemplo típico de un proceso de datos por lotes que se ejecuta diariamente en entornos empresariales para procesar grandes volúmenes de datos de manera eficiente y confiable.