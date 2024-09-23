### Laboratorio: Crear y Configurar un Workspace de Azure Databricks

**Objetivo**: En este laboratorio, aprenderás a crear y configurar un **workspace de Azure Databricks** desde cero, y realizar configuraciones básicas y avanzadas para prepararlo para un trabajo eficiente. También se configurará un clúster de Apache Spark, esencial para ejecutar trabajos de procesamiento de datos.

#### Pasos:

1. **Acceder al Portal de Azure**:
   - Inicia sesión en el **[portal de Azure](https://portal.azure.com)** con tus credenciales.
   - En el menú lateral izquierdo, selecciona **Crear un recurso**.
   - En la barra de búsqueda, escribe **Azure Databricks** y selecciona la opción.

2. **Crear un Workspace de Databricks**:
   - Haz clic en **Crear** para comenzar a configurar el recurso de Databricks.
   - Proporciona la siguiente información:
     - **Suscripción**: Selecciona la suscripción en la que crearás el recurso.
     - **Grupo de Recursos**: Crea uno nuevo o selecciona uno existente.
     - **Nombre del Workspace**: Asigna un nombre único y descriptivo.
     - **Región**: Selecciona la región más cercana o relevante para tu proyecto.
     - **Nivel de Precio**: Puedes elegir entre **Standard** o **Premium**. El nivel **Premium** incluye características adicionales de seguridad y gobernanza.
   - Haz clic en **Revisar y Crear** y luego en **Crear**.

3. **Acceder al Workspace de Databricks**:
   - Una vez que el workspace haya sido creado, haz clic en **Ir al Recurso** y luego en **Iniciar Workspace**.
   - Serás redirigido a la interfaz de usuario de Azure Databricks.

4. **Crear un Clúster de Apache Spark**:
   - En la barra lateral izquierda, selecciona **Clusters** y haz clic en **Create Cluster**.
   - Configura los siguientes parámetros:
     - **Cluster Name**: Asigna un nombre al clúster.
     - **Databricks Runtime Version**: Selecciona la versión más reciente de Spark.
     - **Worker Type**: Selecciona el tipo de máquina virtual, como **Standard_DS3_v2**.
     - **Autoescalado**: Actívalo si quieres que el número de nodos varíe según la carga de trabajo. Configura un mínimo de **2 nodos** y un máximo de **8 nodos**.
     - **Auto Termination**: Configura para que el clúster se apague automáticamente tras 30 minutos de inactividad.
   - Haz clic en **Create Cluster** y espera unos minutos hasta que el clúster esté listo.

5. **Revisar Límites y Permisos del Workspace**:
   - Ve a la configuración del workspace seleccionando tu perfil en la parte superior derecha y haciendo clic en **Admin Console**.
   - Revisa los **límites de la cuenta**, como los límites de la capacidad de escalado de los clústeres, y asegúrate de que el workspace esté configurado de acuerdo con los requisitos del proyecto.
   - También puedes gestionar **usuarios y permisos** desde esta sección, añadiendo otros miembros de tu equipo o restringiendo el acceso según roles.

6. **Conectar un Notebook al Clúster**:
   - Crea un **notebook** dentro del workspace, siguiendo el mismo proceso del laboratorio anterior.
   - Conecta el notebook al clúster recién creado seleccionando el clúster desde el menú desplegable en la parte superior del notebook.
   - Ejecuta comandos básicos para verificar que el clúster está en funcionamiento:
     ```python
     print("Clúster conectado correctamente")
     ```

---

Este laboratorio te guía a través del proceso de **creación y configuración del workspace**, además de la creación de un clúster que puedes usar para ejecutar tus trabajos de procesamiento de datos.