### **Laboratorio: Crear un pipeline de procesamiento de datos usando notebooks**

### **Objetivo del laboratorio**

En este laboratorio, crearás un pipeline de procesamiento por lotes utilizando notebooks en **Azure Databricks**. Este pipeline simulará el procesamiento de datos de ventas diarias, los cuales se agruparán, transformarán, y finalmente se almacenarán en **Azure Data Lake** para su posterior análisis. Implementarás este pipeline en un notebook y luego lo automatizarás usando **Databricks Jobs**.

### **Escenario**

Imagina que trabajas en el departamento de análisis de una empresa de **retail**. Se te ha solicitado crear un pipeline por lotes que procese las ventas diarias. El pipeline debe:
1. **Extraer los datos de ventas** del día anterior desde **Azure Blob Storage**.
2. **Transformar los datos** para calcular las ventas totales por categoría de producto.
3. **Guardar los resultados** en **Azure Data Lake** en formato **Parquet**.

---

### **Paso 1: Extraer los datos de ventas del día anterior**

En el primer paso, cargaremos los datos de ventas desde **Azure Blob Storage** correspondientes al día anterior. Utilizaremos la función `datetime` para obtener la fecha del día anterior y acceder al archivo correcto.

#### Celda 1: Cargar los datos de ventas

```python
from datetime import datetime, timedelta

# Calcular la fecha del día anterior
ayer = (datetime.now() - timedelta(1)).strftime("%Y-%m-%d")

# Ruta donde se almacenan los datos de ventas
sales_path = f"/mnt/blobstorage/sales/{ayer}/ventas.csv"

# Cargar el archivo CSV de ventas del día anterior
df_ventas = spark.read.csv(sales_path, header=True, inferSchema=True)

# Mostrar los primeros registros del DataFrame
df_ventas.show(5)
```

#### Explicación:
- **datetime.now() - timedelta(1)**: Calcula la fecha del día anterior.
- **spark.read.csv()**: Carga los datos de ventas desde un archivo CSV.

---

### **Paso 2: Transformar los datos**

El siguiente paso consiste en transformar los datos cargados. Agruparemos las ventas por **categoría de producto** y calcularemos el total de ventas por categoría.

#### Celda 2: Agrupar y transformar los datos

```python
from pyspark.sql.functions import sum

# Agrupar los datos por categoría de producto y calcular el total de ventas
df_ventas_agrupadas = df_ventas.groupBy("categoria_producto").agg(sum("precio_venta").alias("total_ventas"))

# Mostrar los resultados
df_ventas_agrupadas.show(5)
```

#### Explicación:
- **groupBy()**: Agrupa las ventas por categoría de producto.
- **agg()**: Calcula la suma de ventas por cada categoría.

---

### **Paso 3: Guardar los resultados en Azure Data Lake**

Una vez transformados los datos, los almacenaremos en **Azure Data Lake** en formato **Parquet**, lo que facilitará su análisis en futuras consultas.

#### Celda 3: Guardar los datos en formato Parquet

```python
# Ruta de destino en Azure Data Lake para guardar los resultados
output_path = f"/mnt/datalake/results/{ayer}/ventas_por_categoria.parquet"

# Guardar los datos transformados en formato Parquet
df_ventas_agrupadas.write.parquet(output_path, mode="overwrite")

# Verificar que los archivos se han guardado correctamente
display(dbutils.fs.ls(f"/mnt/datalake/results/{ayer}/"))
```

#### Explicación:
- **write.parquet()**: Almacena los resultados en **formato Parquet**.
- **overwrite**: Sobrescribe los archivos existentes si ya hay datos para la misma fecha.

---

### **Paso 4: Optimización del pipeline con caching**

Para mejorar el rendimiento, utilizaremos **caching** en los datos de ventas agrupadas, lo que evitará recalculaciones en futuras transformaciones o consultas.

#### Celda 4: Cachear los datos agrupados

```python
# Cachear los datos transformados para optimizar el rendimiento en futuras consultas
df_ventas_agrupadas.cache()

# Realizar una consulta sobre los datos cacheados para verificar
df_ventas_agrupadas.filter(df_ventas_agrupadas.total_ventas > 1000).show(5)
```

#### Explicación:
- **cache()**: Almacena los datos en memoria para optimizar futuras consultas.
- **filter()**: Realiza una consulta para filtrar categorías con ventas mayores a 1000.

---

### **Paso 5: Automatización del pipeline con Databricks Jobs**

Finalmente, automatizaremos la ejecución de este pipeline utilizando **Databricks Jobs**, lo que permitirá que el pipeline se ejecute automáticamente todos los días a la medianoche.

#### Configuración del Job:

1. En el entorno de **Azure Databricks**, accede a la sección **Jobs**.
2. Crea un **nuevo Job** y selecciona el **notebook** que contiene el pipeline que acabas de crear.
3. Configura la programación para que el job se ejecute todos los días a la medianoche.
4. Agrega una notificación para recibir un correo si el job falla.

---

### **Conclusión del laboratorio**

En este laboratorio, has aprendido a:
1. **Crear un pipeline de procesamiento por lotes** utilizando notebooks en Azure Databricks.
2. **Automatizar el pipeline** utilizando Databricks Jobs para su ejecución diaria.
3. **Optimizar el pipeline** con técnicas de caching para mejorar el rendimiento.
4. **Guardar los resultados** en formato Parquet en Azure Data Lake.

Este tipo de pipeline es común en entornos empresariales donde es necesario procesar grandes volúmenes de datos periódicamente para generar informes o realizar análisis.