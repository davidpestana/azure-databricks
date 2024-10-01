### **Laboratorio: Conectar Databricks con Azure Blob Storage**

### **Objetivo del laboratorio**

En este laboratorio, aprenderás a conectar **Azure Databricks** con **Azure Blob Storage**. Vamos a montar un contenedor de Blob Storage dentro de Databricks y acceder a los datos almacenados. Este es un paso fundamental para poder realizar la ingesta de datos desde un servicio de almacenamiento externo y procesar estos datos dentro de un entorno de **Apache Spark**.

### **Escenario empresarial**

Imagina que trabajas en una empresa de e-commerce y necesitas analizar grandes cantidades de datos de transacciones almacenadas en **Azure Blob Storage**. Antes de realizar análisis o transformaciones de estos datos, necesitas conectarte a Blob Storage desde **Databricks** para poder acceder a los archivos de datos. 

---

### **Paso 1: Crear un contenedor en Azure Blob Storage**

Antes de conectar Azure Databricks con **Azure Blob Storage**, necesitamos asegurarnos de que tenemos un contenedor de Blob Storage disponible y configurado.

1. Accede al portal de Azure.
2. Crea una cuenta de **Azure Blob Storage** si aún no la tienes.
3. Dentro de la cuenta de almacenamiento, crea un nuevo **contenedor** llamado "transacciones".
4. Carga un archivo de datos (puede ser un archivo CSV o JSON) en el contenedor para usarlo en este laboratorio.

---

### **Paso 2: Obtener las claves de acceso de Blob Storage**

Para conectar Databricks a **Azure Blob Storage**, necesitarás las claves de acceso de la cuenta de almacenamiento.

1. En el portal de Azure, selecciona tu cuenta de almacenamiento de Blob.
2. En el menú lateral, selecciona **Access keys** (Claves de acceso).
3. Copia el nombre de la cuenta de almacenamiento y una de las claves de acceso.

---

### **Paso 3: Montar el contenedor de Azure Blob Storage en Databricks**

Ahora que tienes los detalles de tu cuenta de almacenamiento y contenedor, puedes montar el contenedor en el sistema de archivos de **Databricks** (DBFS).

#### Celda 1: Configurar las credenciales y montar el contenedor

```python
# Configurar el nombre de la cuenta y la clave de acceso
storage_account_name = "tu_nombre_de_cuenta"
storage_account_key = "tu_clave_de_acceso"
container_name = "transacciones"  # El nombre del contenedor de Azure Blob Storage

# Definir el punto de montaje en DBFS
mount_point = f"/mnt/{container_name}"

# Desmontar si ya está montado (opcional)
if any(mount.mountPoint == mount_point for mount in dbutils.fs.mounts()):
    dbutils.fs.unmount(mount_point)

# Montar el contenedor de Blob Storage en Databricks
dbutils.fs.mount(
    source = f"wasbs://{container_name}@{storage_account_name}.blob.core.windows.net",
    mount_point = mount_point,
    extra_configs = {f"fs.azure.account.key.{storage_account_name}.blob.core.windows.net": storage_account_key}
)
```

**Explicación**:
- **storage_account_name**: Es el nombre de la cuenta de almacenamiento de Blob.
- **storage_account_key**: La clave de acceso de la cuenta de almacenamiento.
- **container_name**: El nombre del contenedor donde están almacenados los datos.
- **mount_point**: Es el punto en el sistema de archivos de Databricks donde se montará el contenedor para que sea accesible.

Si el contenedor ya está montado, se desmontará y se volverá a montar para asegurar una conexión limpia.

---

### **Paso 4: Verificar que el contenedor está montado**

Después de montar el contenedor de Blob Storage, es importante verificar que los archivos dentro del contenedor son accesibles.

#### Celda 2: Listar los archivos en el contenedor

```python
# Listar los archivos en el contenedor montado
display(dbutils.fs.ls(f"/mnt/{container_name}"))
```

**Explicación**:
Este comando lista todos los archivos presentes en el contenedor de **Blob Storage** que se ha montado. Si ves tus archivos, como el archivo CSV o JSON que subiste, sabrás que el montaje ha sido exitoso.

---

### **Paso 5: Leer un archivo desde Azure Blob Storage**

Una vez que el contenedor está montado y puedes acceder a los archivos, el siguiente paso es leer un archivo desde el contenedor en un **DataFrame de Spark**.

#### Celda 3: Leer un archivo CSV desde Blob Storage

```python
# Definir la ruta del archivo CSV en el contenedor montado
file_path = f"/mnt/{container_name}/archivo_transacciones.csv"  # Reemplaza con el nombre real de tu archivo

# Leer el archivo CSV en un DataFrame de Spark
df = spark.read.csv(file_path, header=True, inferSchema=True)

# Mostrar los primeros 5 registros del DataFrame
df.show(5)
```

**Explicación**:
- **file_path**: La ruta al archivo dentro del contenedor montado.
- **spark.read.csv**: Este comando lee un archivo CSV y lo convierte en un DataFrame de Spark.
- **header=True**: Indica que el archivo CSV tiene una fila de encabezados con nombres de columnas.
- **inferSchema=True**: Infiera automáticamente el tipo de datos de las columnas.

---

### **Paso 6: Realizar una operación simple en los datos**

Vamos a realizar una operación simple de agregación sobre los datos que hemos leído. Supondremos que el archivo contiene datos de transacciones, y queremos agrupar los datos por categoría de producto y calcular el total de ventas.

#### Celda 4: Agregar por categoría y calcular las ventas totales

```python
# Suponiendo que el archivo tiene columnas 'categoria' y 'ventas'
df_ventas_por_categoria = df.groupBy("categoria").sum("ventas")

# Mostrar los resultados agregados
df_ventas_por_categoria.show()
```

**Explicación**:
- **groupBy("categoria")**: Agrupamos los datos por la columna de categorías.
- **sum("ventas")**: Calculamos la suma de las ventas por categoría.

---

### **Paso 7: Guardar los resultados en formato Parquet en Azure Blob Storage**

Ahora que hemos realizado una transformación de los datos, guardaremos el resultado en formato **Parquet** dentro del mismo contenedor de Blob Storage para futuras consultas.

#### Celda 5: Guardar los resultados en Parquet

```python
# Definir la ruta donde se guardarán los resultados en Parquet
output_path = f"/mnt/{container_name}/resultados_ventas_por_categoria.parquet"

# Guardar el DataFrame resultante en formato Parquet
df_ventas_por_categoria.write.parquet(output_path, mode="overwrite")

# Verificar que el archivo Parquet se ha guardado correctamente
display(dbutils.fs.ls(f"/mnt/{container_name}/resultados_ventas_por_categoria.parquet"))
```

**Explicación**:
- **write.parquet**: Guardamos el DataFrame en formato Parquet, que es eficiente para el almacenamiento de grandes volúmenes de datos y consultas rápidas.
- **mode="overwrite"**: Sobrescribimos cualquier archivo existente con el mismo nombre.
- **display**: Listamos los archivos en el contenedor para confirmar que el archivo Parquet ha sido guardado correctamente.

---

### **Conclusión del laboratorio**

En este laboratorio, has aprendido a:

1. **Conectar Databricks con Azure Blob Storage** utilizando claves de acceso y montando un contenedor en el sistema de archivos de Databricks (DBFS).
2. **Verificar el acceso a los datos** almacenados en Blob Storage.
3. **Leer archivos desde Blob Storage** y cargarlos en un DataFrame de Spark para análisis.
4. **Realizar una operación de agregación simple** en los datos leídos (ventas por categoría).
5. **Guardar los resultados en formato Parquet** en el contenedor de Blob Storage para consultas futuras.

Este flujo de trabajo refleja cómo las empresas pueden utilizar **Azure Databricks** para acceder a datos almacenados en **Azure Blob Storage**, realizar transformaciones en esos datos y guardar los resultados en un formato eficiente.