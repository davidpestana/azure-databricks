### Anexo: Configuración de FileStore y Contenedores en Databricks

En este anexo, aprenderás a configurar un sistema de almacenamiento en **Azure Databricks** utilizando **DBFS (Databricks File System)** y a trabajar con contenedores de almacenamiento en la nube como **Azure Blob Storage** o **Azure Data Lake Storage**. También te enseñaré cómo montar y desmontar estos sistemas de almacenamiento dentro de tu entorno de Databricks.

#### 1. **Introducción a Databricks File System (DBFS)**

**DBFS** es un sistema de archivos distribuido que viene integrado con Databricks. Funciona como un espacio de almacenamiento que permite cargar, guardar y procesar archivos directamente desde tu entorno de notebooks en Databricks. DBFS es una capa de abstracción sobre el almacenamiento en la nube, lo que significa que está diseñado para interactuar con servicios como Azure Blob Storage o S3.

##### Ventajas de DBFS:
- **Acceso sencillo**: Los archivos cargados en DBFS son accesibles desde cualquier notebook.
- **Soporte para almacenamiento externo**: Puedes montar contenedores de almacenamiento en DBFS desde servicios en la nube como Azure Blob Storage.

##### Comandos básicos de DBFS:
- **Listar archivos**:
  ```python
  dbutils.fs.ls("/FileStore/")
  ```

- **Subir archivos**: 
  ```python
  dbutils.fs.put("/FileStore/shared_uploads/tu_usuario/nombre_archivo.txt", "Contenido del archivo", overwrite=True)
  ```

- **Eliminar archivos**:
  ```python
  dbutils.fs.rm("/FileStore/shared_uploads/tu_usuario/nombre_archivo.txt")
  ```

---

#### 2. **Configurar un Contenedor de Almacenamiento en Azure Blob Storage**

**Azure Blob Storage** es un servicio de almacenamiento de objetos escalable que puedes utilizar para almacenar datos no estructurados como archivos de texto, imágenes o videos. En este apartado, configuraremos un contenedor de Azure Blob Storage y lo montaremos en Databricks para acceder a los datos.

##### Pasos para configurar un contenedor de Blob Storage:

1. **Crear una Cuenta de Almacenamiento en Azure**:
   - Accede al **[Portal de Azure](https://portal.azure.com)**.
   - En el menú de la izquierda, selecciona **Crear un recurso** y busca **Cuenta de almacenamiento**.
   - Proporciona los detalles necesarios:
     - Nombre de la cuenta de almacenamiento.
     - Ubicación (elige la región más cercana a tu clúster de Databricks).
     - Tipo de cuenta: **Standard**.
   - Haz clic en **Revisar y Crear** y espera a que se cree la cuenta.

2. **Crear un Contenedor en Blob Storage**:
   - Dentro de la cuenta de almacenamiento creada, ve a la sección de **Contenedores**.
   - Haz clic en **+ Contenedor** y proporciona un nombre (por ejemplo, `datos-proyecto`).
   - Selecciona el nivel de acceso adecuado (por ejemplo, **privado**).
   - Crea el contenedor.

---

#### 3. **Montar un Contenedor de Azure Blob Storage en DBFS**

Montar un contenedor en **DBFS** te permite acceder directamente a los archivos almacenados en Azure Blob Storage desde tu entorno de Databricks como si estuvieran en el sistema de archivos local. Para hacer esto, necesitas la **clave de acceso** y la **URL del contenedor**.

##### Pasos para montar el contenedor:

1. **Obtener la Clave de Acceso**:
   - En el portal de Azure, dentro de tu **cuenta de almacenamiento**, selecciona **Claves de acceso** en el menú lateral.
   - Copia una de las claves de acceso.

2. **Montar el Contenedor en Databricks**:
   Abre un notebook en **Databricks** y utiliza el siguiente código para montar el contenedor:

   ```python
   # Definir los parámetros
   contenedor = "datos-proyecto"
   cuenta_almacenamiento = "nombre_de_tu_cuenta"
   clave_acceso = "clave_de_acceso_que_copiaste"

   # Ruta de montaje en DBFS
   ruta_montaje = "/mnt/almacenamiento_blob"

   # Comando para montar el contenedor en DBFS
   dbutils.fs.mount(
       source = f"wasbs://{contenedor}@{cuenta_almacenamiento}.blob.core.windows.net",
       mount_point = ruta_montaje,
       extra_configs = {f"fs.azure.account.key.{cuenta_almacenamiento}.blob.core.windows.net": clave_acceso}
   )
   ```

3. **Verificar que el Contenedor esté Montado**:
   Una vez ejecutado el comando, puedes listar los archivos en el contenedor montado utilizando:

   ```python
   dbutils.fs.ls("/mnt/almacenamiento_blob")
   ```

##### Consideraciones Importantes:
- **Permisos**: Asegúrate de tener los permisos adecuados en Azure Blob Storage y en Databricks para realizar la operación de montaje.
- **Desmontar el Contenedor**: Si en algún momento necesitas desmontar el contenedor, puedes hacerlo con el siguiente comando:
   ```python
   dbutils.fs.unmount("/mnt/almacenamiento_blob")
   ```

---

#### 4. **Configurar y Montar un Contenedor en Azure Data Lake Storage (ADLS)**

**Azure Data Lake Storage (ADLS)** es una solución de almacenamiento escalable optimizada para análisis de big data. Si necesitas un sistema que ofrezca mayor capacidad de escalado y soporte para el procesamiento de grandes volúmenes de datos, ADLS es una excelente opción.

##### Pasos para montar un contenedor en ADLS:

1. **Crear una Cuenta de Azure Data Lake Storage**:
   - En el **Portal de Azure**, sigue los mismos pasos que para crear una cuenta de almacenamiento, pero asegúrate de seleccionar el **nivel de rendimiento Premium** (si es necesario) y habilitar la opción de **Data Lake Storage Gen2**.

2. **Crear un Contenedor**:
   - Ve a la sección de **Contenedores** dentro de tu cuenta de almacenamiento y crea uno similar al proceso de Blob Storage.

3. **Obtener la Clave de Acceso**:
   - En la página de la cuenta de almacenamiento, selecciona **Claves de acceso** y copia una de las claves.

4. **Montar el Contenedor en Databricks**:
   Para montar el contenedor de ADLS en DBFS, sigue estos pasos:

   ```python
   # Definir los parámetros
   contenedor_adls = "datos-proyecto-adls"
   cuenta_adls = "nombre_de_tu_cuenta"
   clave_acceso_adls = "clave_de_acceso_adls"

   # Ruta de montaje
   ruta_montaje_adls = "/mnt/almacenamiento_adls"

   # Comando para montar el contenedor de ADLS en DBFS
   dbutils.fs.mount(
       source = f"abfss://{contenedor_adls}@{cuenta_adls}.dfs.core.windows.net/",
       mount_point = ruta_montaje_adls,
       extra_configs = {f"fs.azure.account.key.{cuenta_adls}.dfs.core.windows.net": clave_acceso_adls}
   )
   ```

5. **Verificar el Montaje**:
   Como en el caso de Blob Storage, puedes verificar el contenido del contenedor montado utilizando:

   ```python
   dbutils.fs.ls("/mnt/almacenamiento_adls")
   ```

##### Desmontar el Contenedor de ADLS:
   Para desmontar el contenedor en cualquier momento, puedes utilizar el siguiente comando:

   ```python
   dbutils.fs.unmount("/mnt/almacenamiento_adls")
   ```

---

#### 5. **Mejores Prácticas al Trabajar con Almacenamiento en la Nube y DBFS**

- **Control de Acceso**: Asegúrate de definir bien los roles y políticas de acceso en Azure para limitar quién puede acceder o modificar los datos en los contenedores.
- **Seguridad**: Utiliza claves de acceso rotativas y asegúrate de configurar cifrado tanto en Azure Blob Storage como en ADLS para proteger tus datos.
- **Monitorización y Optimización**: Usa las herramientas de monitorización de Azure para revisar el rendimiento de tu almacenamiento en la nube y ajustar el escalado si es necesario.

---

Este anexo proporciona los pasos necesarios para montar y gestionar contenedores de almacenamiento en la nube dentro de Databricks, tanto con **Azure Blob Storage** como con **Azure Data Lake Storage (ADLS)**. Los montajes son útiles para trabajar con grandes volúmenes de datos de manera eficiente, sin necesidad de mover archivos manualmente entre servicios.