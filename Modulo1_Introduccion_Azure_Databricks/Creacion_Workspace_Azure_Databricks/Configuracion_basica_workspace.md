### Configuración Básica del Workspace de Azure Databricks

Una vez creado el **recurso de Azure Databricks**, el siguiente paso es realizar la configuración básica del workspace. Esta configuración incluye la creación de clústeres de Apache Spark, la gestión de permisos de acceso y la personalización de los ajustes iniciales para trabajar de manera eficiente dentro del entorno de Databricks.

---

#### Componentes Clave de la Configuración Básica

1. **Creación de Clústeres de Apache Spark**
   - Un **clúster** en Azure Databricks es el conjunto de máquinas virtuales que ejecutan los trabajos de procesamiento de datos utilizando **Apache Spark**.
   - Los clústeres pueden ser escalables, lo que significa que pueden ajustarse automáticamente según la carga de trabajo, o configurarse de manera manual para tener un número fijo de nodos.
   
   **Pasos para Crear un Clúster**:
   - Accede a la interfaz de Azure Databricks y, en la barra lateral izquierda, selecciona **Clusters**.
   - Haz clic en **Create Cluster**.
   - Completa los campos requeridos:
     - **Nombre del Clúster**: Proporciona un nombre único y descriptivo para tu clúster.
     - **Versión de Spark**: Selecciona la versión de Apache Spark que deseas usar (por defecto, se seleccionará la última versión estable).
     - **Tipo de Nodos**: Elige el tipo de máquinas virtuales (VMs) que se usarán para los nodos del clúster. Para propósitos de prueba, puedes elegir instancias de tipo **Standard_DS3_v2** o similares.
     - **Número de Nodos**: Especifica cuántos nodos deseas tener en el clúster o habilita la opción de **autoescalado** para que el clúster aumente o disminuya la cantidad de nodos automáticamente.
   
   - Haz clic en **Create** para iniciar el clúster. El proceso puede tardar algunos minutos, dependiendo del tamaño del clúster.

   **Recomendaciones**:
   - Para trabajos ligeros o pruebas iniciales, utiliza un clúster pequeño con un número limitado de nodos para ahorrar costos.
   - Si vas a ejecutar trabajos de producción con grandes volúmenes de datos, considera habilitar el autoescalado para manejar picos de demanda.

---

2. **Gestión de Permisos y Usuarios**
   - Azure Databricks está completamente integrado con **Azure Active Directory (Azure AD)**, lo que permite gestionar los permisos de acceso de usuarios y equipos.
   - Puedes agregar usuarios o grupos de usuarios desde Azure AD y asignarles roles como **Admin**, **User** o **Viewer**, según el nivel de acceso que necesiten.

   **Agregar Usuarios al Workspace**:
   - En la interfaz de Azure Databricks, haz clic en el icono de perfil en la esquina superior derecha y selecciona **Admin Console**.
   - En la pestaña **Users**, haz clic en **Add User**.
   - Ingresa el correo electrónico del usuario que deseas agregar o selecciona usuarios desde Azure Active Directory.
   - Asigna un rol al usuario:
     - **Admin**: Acceso total para gestionar el workspace y los recursos.
     - **User**: Puede crear y ejecutar notebooks, pero no gestionar la configuración de seguridad ni los clústeres.
     - **Viewer**: Tiene acceso de solo lectura a los recursos del workspace.

   **Recomendaciones**:
   - Asigna roles con base en el principio de **menor privilegio**, dando acceso solo a los recursos que un usuario necesita para realizar su trabajo.
   - Si gestionas un equipo grande, utiliza grupos de Azure AD para gestionar permisos de manera más eficiente.

---

3. **Configuración de Librerías**
   - Las **librerías** son paquetes adicionales de software que puedes instalar en los clústeres para utilizarlos en los notebooks de Databricks. Estos paquetes incluyen librerías de Python, Scala, R, entre otros.
   - Databricks proporciona una serie de librerías preinstaladas, pero puedes añadir librerías personalizadas según tus necesidades.

   **Agregar Librerías a un Clúster**:
   - En la sección **Clusters**, selecciona el clúster en el que deseas instalar las librerías.
   - Haz clic en **Libraries** y luego en **Install New**.
   - Puedes instalar librerías desde varias fuentes:
     - **Maven**: Para librerías Java/Scala.
     - **PyPI**: Para librerías Python (por ejemplo, `pandas`, `numpy`).
     - **CRAN**: Para librerías R.
     - **Cargar un archivo**: Si tienes una librería personalizada, puedes subirla desde tu computadora o desde un almacenamiento externo (como S3 o Azure Blob Storage).
   - Una vez seleccionada la librería, haz clic en **Install**.

   **Recomendaciones**:
   - Asegúrate de instalar solo las librerías necesarias para mantener el entorno del clúster ligero y evitar conflictos entre versiones de paquetes.
   - Si utilizas una librería en múltiples clústeres, puedes configurarla como librería compartida para ahorrar tiempo.

---

4. **Gestión del Almacenamiento**
   - Azure Databricks se integra de manera nativa con **Azure Blob Storage** y **Azure Data Lake Storage (ADLS)**. Esto te permite almacenar y acceder a grandes volúmenes de datos directamente desde tu workspace.
   - Para interactuar con estos sistemas de almacenamiento, puedes utilizar **Databricks File System (DBFS)**, que es una abstracción que permite leer y escribir datos de manera similar a un sistema de archivos local.

   **Conectar Azure Blob Storage o ADLS**:
   - Desde un notebook en Azure Databricks, puedes montar un contenedor de **Azure Blob Storage** o **ADLS** usando las credenciales adecuadas:
     ```python
     # Montar un contenedor de Azure Blob Storage
     storage_account_name = "nombre_cuenta_almacenamiento"
     container_name = "nombre_contenedor"
     storage_account_access_key = "clave_de_acceso"

     dbutils.fs.mount(
         source = f"wasbs://{container_name}@{storage_account_name}.blob.core.windows.net",
         mount_point = f"/mnt/{container_name}",
         extra_configs = {f"fs.azure.account.key.{storage_account_name}.blob.core.windows.net": storage_account_access_key}
     )
     ```
   - Los datos montados estarán disponibles en el directorio `/mnt/` dentro de DBFS, desde donde puedes leer o escribir archivos en tus notebooks de Databricks.

   **Recomendaciones**:
   - Utiliza **Azure Key Vault** para gestionar de manera segura las credenciales de almacenamiento.
   - Si trabajas con grandes volúmenes de datos, utiliza **ADLS Gen2**, que está optimizado para cargas de trabajo de Big Data.

---

### Conclusión

La **configuración básica del workspace** de Azure Databricks te permite personalizar y optimizar el entorno para tus necesidades de análisis de datos y procesamiento masivo. Al crear clústeres de Spark, gestionar permisos de acceso, instalar librerías adicionales y conectar sistemas de almacenamiento, puedes preparar tu entorno para ejecutar trabajos de análisis de datos y machine learning de manera eficiente y segura.

Con una configuración adecuada, podrás aprovechar al máximo la potencia de procesamiento distribuido de Apache Spark y la colaboración en tiempo real que ofrece Azure Databricks, mejorando la productividad y asegurando el cumplimiento de las políticas de seguridad y gestión de datos en tu organización.