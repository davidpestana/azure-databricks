### **Laboratorio: Gestión de contenido en un contenedor Blob Storage**

### **Objetivo del laboratorio**

Este laboratorio está diseñado para enseñarte a organizar, procesar y almacenar datos de manera eficiente dentro de **Azure Blob Storage** desde **Azure Databricks**. Además, se abordará la creación de una estructura lógica de carpetas y la generación de salidas en diferentes formatos (como **Parquet** para su uso en etapas posteriores y **HTML/PDF** para publicación de informes accesibles). También discutiremos si es posible configurar **Blob Storage** como un servidor web, similar a **Amazon S3**, para poder publicar informes y gráficos generados directamente desde los notebooks de Databricks.

### **Escenario**

Imagina que trabajas en un equipo de análisis de datos y los datos de ventas diarias se almacenan en **Azure Blob Storage**. Tras realizar un análisis en Databricks, necesitas organizar los resultados en una estructura de carpetas por fecha y secciones. Los resultados se guardarán en formato **Parquet** para su reutilización en otras etapas del pipeline, y los informes y gráficos se generarán en formatos más accesibles para su publicación (como HTML o PDF). Además, exploraremos la posibilidad de servir estos archivos directamente desde Blob Storage como un servidor web.

---

### **Paso 1: Montar el contenedor de Azure Blob Storage**

Lo primero es montar el contenedor de **Azure Blob Storage** en **Azure Databricks** para tener acceso a los datos almacenados. Esto permitirá leer los datos, procesarlos y guardar los resultados en diferentes formatos.

#### Celda 1: Montar el contenedor de Blob Storage

```python
# Configurar las credenciales y detalles del contenedor
storage_account_name = "nombre_cuenta"
storage_account_key = "clave_acceso"
container_name = "ventas"

# Definir el punto de montaje en Databricks File System (DBFS)
mount_point = f"/mnt/{container_name}"

# Desmontar si ya está montado (opcional)
if any(mount.mountPoint == mount_point for mount in dbutils.fs.mounts()):
    dbutils.fs.unmount(mount_point)

# Montar el contenedor
dbutils.fs.mount(
    source = f"wasbs://{container_name}@{storage_account_name}.blob.core.windows.net",
    mount_point = mount_point,
    extra_configs = {f"fs.azure.account.key.{storage_account_name}.blob.core.windows.net": storage_account_key}
)
```

---

### **Paso 2: Verificar el contenido del contenedor**

Verificamos que el montaje ha sido exitoso y los archivos en el contenedor son accesibles.

#### Celda 2: Listar los archivos dentro del contenedor

```python
# Listar los archivos presentes en el contenedor montado
display(dbutils.fs.ls(f"/mnt/{container_name}"))
```

---

### **Paso 3: Crear una estructura lógica de carpetas para almacenar resultados**

Vamos a crear una estructura que nos permita organizar los resultados del análisis por fecha, sección y tipo de archivo. Esto facilitará la reutilización de los archivos y el acceso a informes y gráficos generados.

#### Celda 3: Crear la estructura de carpetas

```python
from datetime import datetime

# Definir la estructura basada en la fecha actual y tipo de contenido
seccion = "informes"
fecha = datetime.now().strftime("%Y/%m/%d")
directorio = f"/mnt/{container_name}/{seccion}/{fecha}/"

# Crear el directorio si no existe
dbutils.fs.mkdirs(directorio)

# Mostrar el directorio creado
print(f"Directorio creado: {directorio}")
```

---

### **Paso 4: Leer los datos de ventas desde el contenedor de Blob Storage**

Procedemos a leer los datos de ventas almacenados en el contenedor y cargarlos en un DataFrame de **Spark** para su análisis.

#### Celda 4: Leer los datos de ventas

```python
# Definir la ruta del archivo CSV de ventas
file_path = f"/mnt/{container_name}/ventas_diarias.csv"

# Leer los datos de ventas en un DataFrame de Spark
df_ventas = spark.read.csv(file_path, header=True, inferSchema=True)

# Mostrar los primeros registros
df_ventas.show(5)
```

---

### **Paso 5: Realizar el análisis de ventas**

Agrupamos los datos de ventas por producto para calcular las ventas totales de cada uno.

#### Celda 5: Agrupar ventas por producto

```python
# Agrupar los datos de ventas por producto y calcular las ventas totales
df_ventas_totales = df_ventas.groupBy("producto").sum("cantidad_vendida")

# Mostrar los resultados
df_ventas_totales.show()
```

---

### **Paso 6: Guardar los resultados en formato Parquet para uso posterior**

El formato **Parquet** es muy útil para almacenar grandes volúmenes de datos de manera eficiente y para optimizar futuras consultas y análisis. Aunque no es directamente legible por humanos, es ideal para su uso en otras etapas del pipeline de datos.

#### Celda 6: Guardar los resultados en formato Parquet

```python
# Guardar los resultados en formato Parquet
output_parquet = f"{directorio}/ventas_totales.parquet"
df_ventas_totales.write.parquet(output_parquet, mode="overwrite")

# Verificar que el archivo Parquet se ha guardado correctamente
display(dbutils.fs.ls(directorio))
```

**Nota**: Los archivos **Parquet** son más apropiados para ser consumidos por otras aplicaciones o etapas de procesamiento automatizado, por lo que no se generan para una lectura directa humana. Se usan comúnmente en pipelines de datos.

---

### **Paso 7: Generar y guardar informes accesibles (HTML, PDF)**

Además de guardar los datos en formato Parquet, es útil generar informes en formatos más accesibles para las partes interesadas, como **HTML** o **PDF**. Estos informes se pueden visualizar directamente sin necesidad de procesamiento adicional.

#### Celda 7: Crear y guardar un informe HTML

```python
# Crear un informe HTML simple
html_content = f"""
<html>
<head><title>Informe de Ventas</title></head>
<body>
<h1>Ventas Totales por Producto</h1>
<table border="1">
<tr><th>Producto</th><th>Ventas Totales</th></tr>
"""
for row in df_ventas_totales.collect():
    html_content += f"<tr><td>{row['producto']}</td><td>{row['sum(cantidad_vendida)']}</td></tr>"
html_content += "</table></body></html>"

# Guardar el informe HTML en el contenedor
html_path = f"{directorio}/informe_ventas.html"
with open(f"/dbfs{html_path}", "w") as f:
    f.write(html_content)

# Verificar que el informe HTML se ha guardado correctamente
display(dbutils.fs.ls(directorio))
```

---

### **Paso 8: Publicar informes en Azure Blob Storage como servidor web**

A diferencia de **Amazon S3**, **Azure Blob Storage** no tiene capacidades nativas tan extendidas para actuar como un servidor web de archivos estáticos. Sin embargo, se puede habilitar **Azure Static Website** en una cuenta de Blob Storage para servir contenido estático (como HTML, JavaScript, imágenes, etc.).

#### Pasos para habilitar Azure Static Website:

1. **Acceder al portal de Azure**:
   - Ve a la cuenta de **Blob Storage** donde quieres habilitar el servicio de sitio web estático.

2. **Habilitar la opción de Static Website**:
   - En la sección **Static Website** del menú de la cuenta de almacenamiento, habilita la opción.
   - Define una **página de índice** (por ejemplo, `index.html`) y una página de error (opcional).

3. **Subir los archivos**:
   - Sube el informe HTML generado en el paso anterior a la carpeta especial `\$web` de Blob Storage.
   - Azure te proporcionará una **URL pública** donde se podrá acceder al archivo.

**Ejemplo de comando para subir desde Databricks**:

```python
# Mover el archivo HTML al contenedor $web para servirlo públicamente
dbutils.fs.cp(f"/mnt/{container_name}/informes/2023/09/30/informe_ventas.html", f"/mnt/{container_name}/$web/informe_ventas.html")
```

---

### **Conclusión del laboratorio**

En este laboratorio aprendiste a:

1. **Conectar Azure Databricks con Azure Blob Storage** para acceder a los datos de ventas almacenados.
2. **Organizar una estructura de carpetas** para almacenar archivos de análisis por fecha y sección.
3. **Guardar resultados en formato Parquet**, un formato eficiente para grandes volúmenes de datos, utilizado en futuras etapas del pipeline de procesamiento.
4. **Generar informes en formatos accesibles** como **HTML** para usuarios finales.
5. **Explorar la opción de habilitar Azure Static Website** para servir contenido web estático directamente desde Blob Storage, como informes generados en Databricks.

Este enfoque asegura que los resultados de análisis estén organizados y accesibles para las diferentes partes interesadas de manera eficiente.