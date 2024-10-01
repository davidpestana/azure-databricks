### **Cargar datos desde Azure Blob Storage y Azure Data Lake Storage**

**Azure Blob Storage** y **Azure Data Lake Storage (ADLS)** son dos de las soluciones más potentes para almacenar datos en la nube de Microsoft Azure. Ambos servicios permiten el almacenamiento masivo de datos no estructurados (como archivos, logs, imágenes, videos, y datasets) y ofrecen capacidades escalables y seguras. Sin embargo, hay algunas diferencias clave entre ambos servicios:

- **Azure Blob Storage** está optimizado para el almacenamiento de objetos grandes como imágenes y archivos multimedia. Se utiliza principalmente para almacenar datos no estructurados o semiestructurados.
- **Azure Data Lake Storage (Gen2)** está diseñado específicamente para manejar grandes volúmenes de datos para análisis y machine learning. Integra las capacidades de Blob Storage con características avanzadas como un sistema de archivos jerárquico, seguridad granular y optimización para el procesamiento de datos masivos.

### **1. Conectando Databricks con Azure Blob Storage y Azure Data Lake Storage**

Azure Databricks permite la integración directa con ambos servicios de almacenamiento, lo que facilita la ingesta de grandes volúmenes de datos desde estos servicios en los notebooks de Databricks para procesamiento y análisis.

#### Pasos para conectar Databricks a Azure Blob Storage:

1. **Crear un contenedor en Azure Blob Storage**:
   - Accede al portal de Azure.
   - Crea una cuenta de **Azure Blob Storage** o selecciona una existente.
   - Dentro de la cuenta de almacenamiento, crea un nuevo contenedor donde almacenarás los datos.

2. **Generar la clave de acceso**:
   - En la cuenta de almacenamiento, accede a la sección de claves de acceso (Access keys).
   - Copia la clave de acceso (storage account key) y el nombre de la cuenta de almacenamiento.

3. **Montar el Blob Storage en Databricks**:
   En Databricks, puedes montar un Blob Storage para que esté accesible como un sistema de archivos local.

   Ejemplo de código para montar Azure Blob Storage en Databricks:

   ```python
   # Configuración del almacenamiento
   storage_account_name = "tu_nombre_de_cuenta"
   storage_account_key = "tu_clave_de_acceso"

   # Punto de montaje en DBFS
   container_name = "nombre_del_contenedor"
   mount_point = "/mnt/blobstorage"

   # Desmontar si ya está montado (opcional)
   dbutils.fs.unmount(mount_point)

   # Montar el contenedor
   dbutils.fs.mount(
       source = f"wasbs://{container_name}@{storage_account_name}.blob.core.windows.net",
       mount_point = mount_point,
       extra_configs = {f"fs.azure.account.key.{storage_account_name}.blob.core.windows.net": storage_account_key}
   )
   ```

4. **Acceder a los datos en el contenedor**:
   Una vez montado, puedes acceder a los datos como si fueran parte del sistema de archivos local de Databricks.

   ```python
   # Listar archivos en el contenedor
   display(dbutils.fs.ls("/mnt/blobstorage"))
   ```

#### Pasos para conectar Databricks a Azure Data Lake Storage (ADLS Gen2):

1. **Configurar ADLS Gen2**:
   - Crea una cuenta de almacenamiento en **Azure Data Lake Storage Gen2**.
   - Genera la clave de acceso o crea una aplicación registrada en Azure Active Directory (AAD) para usar **OAuth 2.0**.

2. **Montar ADLS Gen2 en Databricks**:
   Para montar ADLS en Databricks, se usa el protocolo `abfss://` en lugar de `wasbs://`, y se puede usar la autenticación basada en OAuth o con la clave de acceso.

   Ejemplo de código para montar ADLS Gen2 en Databricks utilizando una clave de acceso:

   ```python
   # Configuración del almacenamiento
   storage_account_name = "tu_nombre_de_cuenta_adls"
   storage_account_key = "tu_clave_de_acceso_adls"

   # Punto de montaje en DBFS
   filesystem_name = "nombre_del_filesystem"
   mount_point = "/mnt/adlsgen2"

   # Desmontar si ya está montado (opcional)
   dbutils.fs.unmount(mount_point)

   # Montar el contenedor de ADLS Gen2
   dbutils.fs.mount(
       source = f"abfss://{filesystem_name}@{storage_account_name}.dfs.core.windows.net/",
       mount_point = mount_point,
       extra_configs = {f"fs.azure.account.key.{storage_account_name}.dfs.core.windows.net": storage_account_key}
   )
   ```

3. **Acceder a los datos en ADLS**:
   Puedes listar y acceder a los archivos montados de la misma manera que con Blob Storage.

   ```python
   # Listar archivos en el filesystem montado
   display(dbutils.fs.ls("/mnt/adlsgen2"))
   ```

### **2. Diferencias entre Blob Storage y Data Lake Storage**

| Característica                     | Azure Blob Storage                          | Azure Data Lake Storage (Gen2)         |
|------------------------------------|---------------------------------------------|----------------------------------------|
| **Propósito principal**            | Almacenamiento de objetos no estructurados  | Almacenamiento de grandes volúmenes de datos para análisis |
| **Compatibilidad con HDFS**        | No                                          | Sí (Sistema de archivos distribuido jerárquico) |
| **Optimización para análisis**     | No                                          | Sí, optimizado para procesamiento distribuido |
| **Control de acceso avanzado**     | Básico (basado en contenedor)               | Sí, con ACLs a nivel de archivo y directorio |
| **Uso típico**                     | Archivos no estructurados (imágenes, vídeos)| Big data, machine learning, análisis a gran escala |

### **Conclusión**

Tanto **Azure Blob Storage** como **Azure Data Lake Storage** son soluciones clave en el ecosistema de Azure para el almacenamiento de datos. Mientras que Blob Storage es ideal para datos no estructurados y semi-estructurados, ADLS está diseñado específicamente para el almacenamiento de datos a gran escala con la optimización necesaria para flujos de trabajo de análisis y machine learning. Azure Databricks se conecta de forma nativa con ambos servicios, permitiendo una ingesta de datos fluida y escalable para su procesamiento y análisis.