### Laboratorio: Crear un Nuevo Clúster en Azure Databricks

En este laboratorio, aprenderás a crear y configurar un **clúster de Apache Spark** dentro del entorno de **Azure Databricks**. Los clústeres en Databricks son los componentes clave que permiten ejecutar trabajos de análisis de datos y procesamiento masivo a gran escala. La creación de un clúster es un paso esencial para cualquier operación en Databricks, ya que es donde se ejecutan los notebooks y los trabajos de Spark.

#### Objetivos del Laboratorio:
1. **Crear un clúster en Azure Databricks.**
2. **Configurar los parámetros básicos del clúster (tipo de máquina, número de nodos, autoescalado).**
3. **Configurar parámetros avanzados (seguridad, redes).**

#### Requisitos Previos:
- **Workspace de Azure Databricks**: Asegúrate de tener un **workspace de Azure Databricks** creado.
- **Permisos adecuados**: Debes tener permisos de **Administrador** o **Usuario** en Azure Databricks para poder crear clústeres.

---

### Paso 1: Acceder al Workspace de Azure Databricks

1. Abre tu navegador web y dirígete al **[portal de Azure](https://portal.azure.com)**.
2. Inicia sesión en el portal de Azure con tus credenciales.
3. En el portal, busca y selecciona el **recurso de Azure Databricks** que creaste previamente.
4. Haz clic en **Iniciar Workspace** para acceder a la interfaz de usuario de Databricks.

---

### Paso 2: Navegar a la Sección de Clústeres

1. Una vez dentro de la interfaz de **Azure Databricks**, en la barra lateral izquierda, selecciona la opción **Clusters**.
2. Verás una lista de los clústeres existentes (si hay alguno). Haz clic en el botón **Create Cluster** para iniciar la configuración de un nuevo clúster.

---

### Paso 3: Configuración Básica del Clúster

1. **Asignar un Nombre al Clúster**:
   - En el campo **Cluster Name**, proporciona un nombre descriptivo para tu clúster, por ejemplo, "**Cluster-Analisis-Datos**".
   
2. **Seleccionar la Versión de Apache Spark**:
   - En el campo **Databricks Runtime Version**, selecciona la versión de Apache Spark que deseas utilizar. Te recomendamos elegir la última versión estable para aprovechar las mejoras y optimizaciones más recientes.

3. **Seleccionar el Tipo de Máquina Virtual (VM)**:
   - En la sección **Worker Type**, elige el tipo de máquina virtual que deseas utilizar para los **nodos de trabajo** del clúster. Para este laboratorio, puedes seleccionar instancias de tipo **Standard_DS3_v2**, que son económicas y adecuadas para pruebas y trabajos de pequeña a mediana escala.
   - También debes seleccionar el tipo de máquina para el **Driver** del clúster, que se encargará de gestionar la coordinación de los trabajos de Spark.

4. **Configurar el Número de Nodos**:
   - En la sección **Autoscaling**, puedes habilitar el **autoescalado** para que el clúster aumente o disminuya automáticamente el número de nodos según la demanda de trabajo. 
     - Si habilitas esta opción, debes especificar el número mínimo y máximo de nodos que el clúster puede tener.
     - Por ejemplo, puedes definir que el clúster tenga **un mínimo de 2 nodos** y **un máximo de 8 nodos** para garantizar que se ajusta según la carga de trabajo.

---

### Paso 4: Configuración Avanzada del Clúster

1. **Configuración de Seguridad**:
   - En la sección **Advanced Options**, puedes configurar detalles avanzados de seguridad para tu clúster.
   - **IAM Roles**: Si trabajas con datos en **Amazon S3** o servicios externos de Azure, puedes asociar un **rol de IAM** a tu clúster para otorgar permisos de acceso a esos recursos.
   - **Network**: Si integras Databricks con una **Virtual Network (VNet)**, selecciona la **subred** donde se desplegarán los nodos del clúster.

2. **Políticas de Inicio y Apagado del Clúster**:
   - En la sección **Auto Termination**, puedes configurar el clúster para que se apague automáticamente después de un cierto período de inactividad. Esta opción es importante para **reducir costos**.
   - Puedes establecer un tiempo de inactividad, por ejemplo, de **30 minutos**. Si no se ejecuta ningún trabajo durante ese tiempo, el clúster se apagará automáticamente.

3. **Instalación de Librerías**:
   - Si tu análisis requiere librerías específicas (por ejemplo, **pandas**, **numpy**, o **scikit-learn** para Python), puedes preinstalarlas en el clúster.
   - Haz clic en la pestaña **Libraries** y selecciona **Install New**. Puedes instalar librerías desde **PyPI**, **CRAN** (para R) o cargar archivos **.jar** o **.whl** desde un almacenamiento externo.

---

### Paso 5: Crear el Clúster

1. Una vez que hayas configurado todos los parámetros del clúster, revisa las opciones seleccionadas para asegurarte de que todo esté correcto.
2. Haz clic en **Create Cluster** para iniciar el proceso de creación del clúster. El proceso puede tardar unos minutos, dependiendo del tamaño del clúster y la configuración elegida.
3. Mientras se despliega el clúster, puedes ver el progreso en la sección de **Clusters**.

---

### Paso 6: Conectar Notebooks al Clúster

1. Después de que el clúster esté listo, puedes **conectar un notebook** al clúster para comenzar a ejecutar trabajos de procesamiento de datos.
2. En la barra lateral izquierda, selecciona **Workspace** y abre un notebook existente o crea uno nuevo.
3. En la parte superior del notebook, selecciona el clúster recién creado desde el menú desplegable de clústeres.
4. Ahora, cuando ejecutes el código en el notebook, este se procesará utilizando los recursos del clúster.

---

### Conclusión del Laboratorio

En este laboratorio has aprendido a **crear y configurar un clúster de Apache Spark en Azure Databricks**. La configuración adecuada del clúster es fundamental para garantizar que tus trabajos de procesamiento de datos se ejecuten de manera eficiente y dentro de los costos previstos. Ahora puedes empezar a utilizar el clúster para realizar análisis de datos, modelado de machine learning y ejecutar trabajos distribuidos a gran escala.

Este clúster será la base para futuras operaciones en Databricks, por lo que es importante que ajustes sus configuraciones de acuerdo con las necesidades de tus proyectos.