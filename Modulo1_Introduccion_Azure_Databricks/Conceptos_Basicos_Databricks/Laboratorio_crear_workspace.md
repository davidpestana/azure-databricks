### Laboratorio: Crear y Configurar un Workspace de Azure Databricks (Con Verificación de Límites de Cuenta)

En este laboratorio aprenderás a crear y configurar un **workspace de Azure Databricks** dentro de tu suscripción de **Microsoft Azure**, además de cómo verificar los límites de tu cuenta de Azure para determinar qué instancias puedes elegir al configurar tu clúster. Es fundamental entender los límites de la cuenta, ya que estos determinan los recursos (como máquinas virtuales) que puedes asignar a tu clúster.

#### Objetivos del Laboratorio:
1. **Crear un workspace de Azure Databricks.**
2. **Configurar las opciones iniciales del workspace.**
3. **Verificar los límites de la cuenta para las máquinas virtuales.**
4. **Explorar el workspace y sus componentes clave.**

#### Requisitos Previos:
- **Cuenta de Azure**: Necesitarás una cuenta activa de **Microsoft Azure**. Si aún no tienes una, puedes crear una cuenta gratuita en [Azure Free Account](https://azure.microsoft.com/es-es/free/).
- **Acceso a la suscripción de Azure**: Debes tener acceso a una suscripción válida donde puedas crear recursos.
- **Permisos adecuados**: Asegúrate de tener permisos para visualizar los límites de la suscripción y crear nuevos recursos en Azure.

---

### Paso 1: Acceder al Portal de Azure

1. Abre un navegador web y dirígete al **[portal de Azure](https://portal.azure.com)**.
2. Inicia sesión con tu cuenta de Azure.

---

### Paso 2: Verificar los Límites de la Cuenta de Azure

Antes de crear un clúster de Databricks, es importante conocer los límites de tu cuenta para seleccionar adecuadamente las máquinas virtuales y recursos que estén dentro de los límites disponibles de tu suscripción.

1. **Buscar la Sección de Cuotas**:
   - En el portal de Azure, en el menú del lado izquierdo, busca y selecciona **Suscripciones**.
   - Selecciona la suscripción que estás utilizando para el laboratorio.
   - En el panel izquierdo de la página de tu suscripción, selecciona la opción **Uso + Cuotas**.

2. **Ver Cuotas de Máquinas Virtuales (VMs)**:
   - En la sección de **Uso + Cuotas**, filtra los resultados por **Cómputo** para ver las cuotas relacionadas con máquinas virtuales.
   - Busca el tipo de **VM Series** (como **Standard_DS3_v2** o **Standard_F4s_v2**) que deseas utilizar para tu clúster. Verifica cuántos núcleos (vCPUs) y otras capacidades están disponibles en tu región.
   - Si no tienes suficientes cuotas para el tipo de VM que deseas utilizar, puedes solicitar un aumento de cuota a través del portal de Azure, aunque esto puede tardar unos días.

3. **Revisar Cuotas de Otros Recursos**:
   - Además de las máquinas virtuales, puedes verificar las cuotas de otros recursos importantes para tu clúster, como discos administrados y redes.

4. **Documentar las Cuotas Disponibles**:
   - Anota los límites y el uso actual de los recursos que planeas utilizar para asegurarte de que puedes configurar tu clúster sin problemas.

---

### Paso 3: Crear un Nuevo Workspace de Azure Databricks

1. **Navegar a la sección de creación de recursos**:
   - Una vez dentro del portal de Azure, en el menú del lado izquierdo, selecciona **Crear un recurso**.
   - En la barra de búsqueda de la ventana de creación, escribe "**Azure Databricks**" y selecciona la opción que aparece en los resultados.

2. **Configurar el Workspace de Databricks**:
   - Haz clic en **Crear** para comenzar a configurar el workspace.
   - Completa la información solicitada:

     - **Suscripción**: Selecciona la suscripción de Azure donde deseas crear el workspace.
     - **Grupo de Recursos**: Selecciona un grupo de recursos existente o crea uno nuevo.
     - **Nombre del Workspace**: Ingresa un nombre único para tu workspace de Databricks.
     - **Región**: Selecciona la región geográfica donde deseas alojar tu workspace.
     - **Nivel de Precio**: Selecciona el nivel de precio que mejor se adapte a tus necesidades (Standard o Premium).

3. **Revisar y Crear**:
   - Haz clic en **Revisar y crear**. El portal de Azure validará la configuración.
   - Si todo está correcto, haz clic en **Crear** para desplegar el workspace.

4. **Monitorear la Creación del Workspace**:
   - La creación del workspace puede tardar unos minutos. Mientras se despliega, podrás ver el progreso en las **notificaciones** del portal de Azure.
   - Una vez que el workspace esté listo, recibirás una notificación indicando que la implementación ha sido exitosa.

---

### Paso 4: Explorar el Workspace de Azure Databricks

1. **Acceder al Workspace**:
   - Una vez que el workspace se haya creado, haz clic en el botón **Ir al recurso** en la notificación de finalización o en el menú del portal de Azure.
   - Esto te llevará a la página del workspace de Databricks dentro del portal de Azure.

2. **Iniciar el Workspace de Databricks**:
   - En la página del recurso del workspace, haz clic en el botón **Iniciar Workspace** para abrir la interfaz de usuario de Azure Databricks en una nueva pestaña.

3. **Familiarízate con el Entorno de Databricks**:
   - Navega por las secciones clave del workspace:
     - **Home**: Página principal que muestra recursos recientes y acceso rápido a tus notebooks y clústeres.
     - **Workspace**: Donde puedes crear notebooks y organizar archivos.
     - **Clusters**: Para crear y gestionar clústeres de Spark.
     - **Jobs**: Para programar trabajos y pipelines de datos.
     - **Libraries**: Para añadir y gestionar librerías externas que puedas necesitar.

---

### Paso 5: Crear un Clúster de Apache Spark Basado en los Límites Disponibles

Después de verificar los límites de tu cuenta y de haber creado el workspace, es hora de configurar un **clúster de Apache Spark** en Databricks.

1. **Crear un Clúster**:
   - En la interfaz de Databricks, selecciona **Clusters** en la barra lateral izquierda.
   - Haz clic en **Create Cluster**.

2. **Configurar el Clúster**:
   - Asigna un nombre al clúster (por ejemplo, "**Cluster-BigData**").
   - Elige el tipo de máquinas virtuales disponibles dentro de los límites verificados previamente. Por ejemplo, si tienes límites suficientes, selecciona **Standard_DS3_v2**.
   - Configura el número de nodos de trabajo. Si quieres aprovechar el **autoescalado**, habilita la opción de **Auto-scaling** para que el clúster pueda ajustar automáticamente el número de nodos según la carga de trabajo.
   - Define la **Duración de inactividad** para que el clúster se apague automáticamente si no hay actividad, lo que te permitirá optimizar costos.

3. **Crear el Clúster**:
   - Haz clic en **Create Cluster**. La creación del clúster puede tardar unos minutos.

---

### Conclusión del Laboratorio

En este laboratorio, has aprendido a:
- **Verificar los límites de tu cuenta de Azure** para asegurarte de seleccionar las máquinas virtuales adecuadas al configurar tu clúster.
- **Crear y configurar un workspace de Azure Databricks** dentro del portal de Azure.
- **Crear un clúster de Apache Spark** basándote en los recursos disponibles en tu suscripción.

Con esta configuración lista, puedes empezar a explorar Databricks para crear notebooks interactivos, procesar grandes volúmenes de datos, y ejecutar pipelines de datos a gran escala utilizando Spark. Además, la verificación de los límites de la cuenta te permite gestionar los recursos de manera eficiente y evitar problemas al crear clústeres.