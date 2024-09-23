### Laboratorio: Configurar un Recurso de Databricks en Azure

En este laboratorio aprenderás a configurar un **recurso de Azure Databricks** en el portal de **Microsoft Azure**. La creación y configuración correcta de este recurso es fundamental para trabajar con los servicios de procesamiento de datos, machine learning y análisis de grandes volúmenes de datos que Databricks ofrece. 

#### Objetivos del Laboratorio:
1. **Crear un recurso de Azure Databricks.**
2. **Configurar las opciones iniciales del recurso.**
3. **Conectar y acceder al workspace de Azure Databricks.**

#### Requisitos Previos:
- **Cuenta de Azure**: Necesitarás una cuenta activa de **Microsoft Azure**. Si aún no tienes una, puedes crear una cuenta gratuita en [Azure Free Account](https://azure.microsoft.com/es-es/free/).
- **Permisos Adecuados**: Asegúrate de que tienes permisos para crear recursos en la suscripción de Azure.

---

### Paso 1: Acceder al Portal de Azure

1. Abre tu navegador web y dirígete al **[portal de Azure](https://portal.azure.com)**.
2. Inicia sesión con las credenciales de tu cuenta de Microsoft Azure.

---

### Paso 2: Crear un Recurso de Azure Databricks

1. **Navegar a la Sección de Creación de Recursos**:
   - En el menú lateral izquierdo del portal de Azure, selecciona la opción **Crear un recurso**.
   - En la barra de búsqueda de la ventana de creación de recursos, escribe "**Azure Databricks**" y selecciona la opción que aparece en los resultados de búsqueda.

2. **Configurar el Workspace de Databricks**:
   - Haz clic en **Crear** para comenzar a configurar el recurso de Databricks.
   - Completa los campos de configuración inicial:
     - **Suscripción**: Selecciona la suscripción de Azure en la que deseas crear el recurso.
     - **Grupo de Recursos**: Selecciona un grupo de recursos existente o crea uno nuevo. Los grupos de recursos son contenedores lógicos que agrupan recursos relacionados.
     - **Nombre del Workspace**: Asigna un nombre único a tu workspace de Databricks. Por ejemplo, "**Databricks-Workspace-Ejemplo**".
     - **Región**: Selecciona la región donde deseas desplegar el recurso. La elección de la región puede influir en el rendimiento y en los costos del recurso.
     - **Nivel de Precio**: Selecciona el nivel de precio adecuado para tus necesidades:
       - **Standard**: Incluye las funciones básicas de Azure Databricks.
       - **Premium**: Ofrece características avanzadas, como controles adicionales de seguridad y gobernanza.

3. **Revisar y Crear el Recurso**:
   - Después de completar la configuración, haz clic en **Revisar y crear** para revisar los detalles.
   - Azure validará la configuración. Si todo es correcto, haz clic en **Crear** para proceder con el despliegue del recurso de Databricks.

---

### Paso 3: Monitorear la Creación del Recurso

1. **Monitorear el Progreso de la Creación**:
   - La creación del recurso puede tardar unos minutos. Mientras Azure despliega el recurso de Databricks, podrás ver el progreso en la sección de **notificaciones** del portal.
   - Una vez que el recurso esté listo, recibirás una notificación de que la implementación ha sido exitosa.

2. **Ir al Recurso de Azure Databricks**:
   - Una vez que el recurso haya sido creado, haz clic en **Ir al recurso** para acceder al panel de control del workspace de Databricks dentro del portal de Azure.

---

### Paso 4: Iniciar y Conectar al Workspace de Azure Databricks

1. **Iniciar el Workspace**:
   - En la página de detalles del recurso de Databricks, verás un botón que dice **Iniciar Workspace**. Haz clic en este botón para abrir la interfaz de usuario de Azure Databricks en una nueva pestaña del navegador.
   - Serás redirigido a la página de inicio de sesión de Azure Databricks, donde deberás utilizar las mismas credenciales de Azure para iniciar sesión.

2. **Acceso al Workspace de Databricks**:
   - Después de iniciar sesión, se abrirá el **workspace de Azure Databricks**. Este es el entorno donde podrás crear y gestionar clústeres, notebooks y ejecutar trabajos de procesamiento de datos.
   - Familiarízate con la interfaz, navegando por las distintas secciones como **Workspace**, **Clusters**, **Jobs**, y **DBFS** (Databricks File System).

---

### Paso 5: Explorar las Opciones Básicas del Workspace

Una vez que hayas accedido al workspace, explora las características básicas del entorno:

1. **Home**: En esta página puedes ver una lista de recursos recientes y accesos rápidos a los notebooks y clústeres que crees en el futuro.

2. **Workspace**: Es la sección donde se organizan los archivos, notebooks y scripts que utilices en Databricks. Aquí podrás crear notebooks interactivos en lenguajes como **Python**, **Scala**, **SQL**, y **R**.

3. **Clusters**: Aunque en este laboratorio no configuraremos clústeres, esta es la sección donde gestionarás los clústeres de Apache Spark, necesarios para ejecutar trabajos de procesamiento de datos distribuidos.

4. **DBFS (Databricks File System)**: Es el sistema de archivos integrado en Databricks. Aquí puedes almacenar y acceder a los datos que utilizarás en tus notebooks y trabajos de procesamiento.

---

### Conclusión del Laboratorio

En este laboratorio has aprendido a **crear y configurar un recurso de Azure Databricks** en el portal de Azure, accediendo y explorando el workspace para futuras tareas de procesamiento de datos. Esta configuración es esencial para trabajar con Azure Databricks, permitiéndote gestionar grandes volúmenes de datos y crear soluciones de machine learning y análisis de datos de manera colaborativa y eficiente.