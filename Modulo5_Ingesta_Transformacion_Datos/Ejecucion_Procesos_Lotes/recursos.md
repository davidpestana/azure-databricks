Para facilitar la ejecución de este laboratorio, podemos crear generadores de datos y configurar los recursos necesarios. A continuación, te indico cómo generar datos de ventas simulados y cómo configurar los recursos en Azure Databricks y Azure Blob Storage para llevar a cabo este laboratorio.

### Generador de Datos de Ventas Simulados

En este laboratorio, vamos a generar datos simulados para las transacciones de ventas diarias. Para simular estos datos, crearemos un archivo CSV con columnas que representen las ventas de diferentes productos de una tienda de retail.

#### Celda 1: Generador de datos de ventas simulados
Primero, crearemos un generador de datos que simulará las transacciones diarias de ventas. Vamos a generar un DataFrame de Spark con ventas aleatorias para varias categorías de productos y lo guardaremos en un archivo CSV en Azure Blob Storage.

```python
from pyspark.sql.functions import rand, floor, col
from pyspark.sql.types import StringType
from datetime import datetime, timedelta

# Función para generar datos de ventas simulados
def generar_datos_ventas(num_filas=10000):
    categorias = ["Electrónica", "Ropa", "Alimentos", "Hogar", "Deportes"]
    fecha_actual = datetime.now().strftime("%Y-%m-%d")
    
    # Generar DataFrame de ventas simuladas
    df_simulado = spark.range(num_filas).withColumn("id_transaccion", col("id")) \
        .withColumn("categoria_producto", floor(rand() * len(categorias)).cast(StringType())) \
        .withColumn("precio_venta", (rand() * 100 + 1).cast("double")) \
        .withColumn("costo", (rand() * 50 + 1).cast("double")) \
        .withColumn("fecha", lit(fecha_actual))
    
    # Mapear índices a categorías
    for i, categoria in enumerate(categorias):
        df_simulado = df_simulado.withColumn("categoria_producto", 
                                             when(col("categoria_producto") == str(i), categoria).otherwise(col("categoria_producto")))

    return df_simulado

# Generar datos de ventas
df_simulado = generar_datos_ventas()

# Mostrar una muestra de los datos simulados
df_simulado.show(5)
```

#### Celda 2: Guardar los datos simulados en Azure Blob Storage

Ahora, guardamos estos datos simulados en un contenedor de Azure Blob Storage para usarlos en el laboratorio. Si tienes configurado el mount point de Azure Blob Storage (`/mnt/blobstorage/`), puedes usarlo directamente para guardar los datos.

```python
from datetime import datetime

# Ruta de almacenamiento en Azure Blob Storage
ayer = (datetime.now() - timedelta(1)).strftime("%Y-%m-%d")
sales_path = f"/mnt/blobstorage/sales/{ayer}/ventas.csv"

# Guardar el DataFrame simulado como archivo CSV en Blob Storage
df_simulado.write.csv(sales_path, header=True, mode="overwrite")

# Verificar que el archivo se ha guardado correctamente
display(dbutils.fs.ls(f"/mnt/blobstorage/sales/{ayer}/"))
```

### Creación de Recursos en Azure Databricks y Blob Storage

Para que el laboratorio funcione correctamente, es necesario configurar algunos recursos en Azure Databricks y Azure Blob Storage.

1. **Configurar un contenedor de Blob Storage**: El primer paso es crear un contenedor de almacenamiento donde se alojarán los archivos de ventas diarios.
   - Ve a tu cuenta de almacenamiento en Azure.
   - Crea un nuevo contenedor llamado `sales` en Azure Blob Storage.
   - Configura el acceso adecuado para Databricks usando `dbutils.fs.mount` o mediante un `Shared Access Signature (SAS)` token.

2. **Montar el contenedor en Databricks**:
   Si decides usar `dbutils.fs.mount` para montar el contenedor de Blob Storage en Databricks, aquí tienes un ejemplo:

```python
# Montar el contenedor de Blob Storage en Databricks
storage_account_name = "<nombre_de_tu_storage_account>"
container_name = "sales"
sas_token = "<tu_SAS_token>"

# Punto de montaje
mount_point = f"/mnt/blobstorage/{container_name}"

dbutils.fs.mount(
  source = f"wasbs://{container_name}@{storage_account_name}.blob.core.windows.net",
  mount_point = mount_point,
  extra_configs = {f"fs.azure.sas.{container_name}.{storage_account_name}.blob.core.windows.net":sas_token}
)

# Verificar que el contenedor está montado correctamente
display(dbutils.fs.ls(mount_point))
```


### Configuración de Azure Data Lake

Para almacenar los resultados del pipeline, también debes crear un contenedor en Azure Data Lake. Este contenedor se usará para guardar los archivos Parquet generados por el pipeline. El proceso de configuración es similar al de Azure Blob Storage.

1. **Crear un contenedor de resultados**: Ve a tu cuenta de almacenamiento y crea un contenedor llamado `resultados`.

2. **Montar el contenedor de Data Lake**:
   Si necesitas montar este contenedor, sigue el mismo proceso que con el contenedor de `sales`.

```python
# Montar el contenedor de Data Lake para resultados
container_name_resultados = "resultados"

dbutils.fs.mount(
  source = f"wasbs://{container_name_resultados}@{storage_account_name}.blob.core.windows.net",
  mount_point = f"/mnt/datalake/{container_name_resultados}",
  extra_configs = {f"fs.azure.sas.{container_name_resultados}.{storage_account_name}.blob.core.windows.net":sas_token}
)

# Verificar que el contenedor está montado correctamente
display(dbutils.fs.ls(f"/mnt/datalake/{container_name_resultados}"))
```
