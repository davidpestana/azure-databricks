### Laboratorio: Crear y Configurar un Nuevo Clúster en Azure Databricks

En este laboratorio realizarás el proceso completo de creación y configuración de un **clúster en Azure Databricks**, desde la configuración básica de los nodos hasta la implementación de parámetros avanzados de seguridad y redes. Al final de este laboratorio, tendrás un clúster completamente funcional y optimizado para tus necesidades de procesamiento de datos.

#### Objetivos del Laboratorio:
1. **Crear un clúster en Azure Databricks.**
2. **Configurar los parámetros básicos del clúster (tipo de máquina, autoescalado, etc.).**
3. **Configurar los parámetros avanzados (seguridad, redes).**

---

### Paso 1: Acceder a Azure Databricks

1. Abre tu navegador web y accede al **[portal de Azure](https://portal.azure.com)**.
2. Inicia sesión con tus credenciales.
3. Navega al **recurso de Azure Databricks** que hayas creado previamente.
4. Haz clic en **Iniciar Workspace** para acceder a la interfaz de usuario de Databricks.

---

### Paso 2: Crear un Nuevo Clúster

1. Una vez en la interfaz de Databricks, en la barra lateral izquierda selecciona **Clusters**.
2. Haz clic en el botón **Create Cluster**.

---

### Paso 3: Configuración Básica del Clúster

En esta parte del laboratorio, configuraremos los parámetros básicos del clúster, como el tipo de máquina y el autoescalado.

1. **Asignar un Nombre al Clúster**:
   - En el campo **Cluster Name**, ingresa un nombre descriptivo para tu clúster, como "**Cluster-Data-Analysis**".

2. **Seleccionar la Versión de Apache Spark**:
   - En **Databricks Runtime Version**, selecciona la versión más reciente de **Apache Spark**. La opción por defecto suele ser la más estable y optimizada.

3. **Seleccionar el Tipo de Máquina Virtual (VM)**:
   - En **Worker Type**, selecciona el tipo de máquina virtual que deseas para los **nodos de trabajo**. Para este ejercicio, puedes seleccionar **Standard_DS3_v2**, una opción económica y adecuada para trabajos de pequeña a mediana escala.
   - Para el **Driver**, selecciona también **Standard_DS3_v2**.

4. **Configurar el Número de Nodos**:
   - Activa la opción de **Auto-scaling** para que el clúster ajuste automáticamente el número de nodos según la demanda.
   - Define el **mínimo de 2 nodos** y un **máximo de 8 nodos**. Esto permite que el clúster se escale automáticamente según la carga de trabajo.

5. **Configurar el Tiempo de Terminación Automática**:
   - En **Auto Termination**, establece el tiempo de inactividad tras el cual el clúster se apagará automáticamente. Esto es útil para reducir costos cuando el clúster no esté en uso. Configura, por ejemplo, **30 minutos de inactividad**.

---

### Paso 4: Configuración Avanzada del Clúster

En esta parte del laboratorio, profundizaremos en la configuración avanzada del clúster, incluyendo parámetros de seguridad y redes.

1. **Configuración de Seguridad**:
   - En la sección **Advanced Options**, dirígete a **IAM Roles**. Si necesitas que el clúster acceda a recursos externos como **Azure Storage** o **Amazon S3**, puedes configurar un rol de IAM para darle los permisos adecuados.
   
2. **Configuración de Redes (VNet)**:
   - Si deseas que el clúster se ejecute dentro de una **red virtual (VNet)** para mejorar la seguridad y el control del tráfico, selecciona la red y subred correspondiente en la sección **Network**.
   - Asegúrate de que la red seleccionada tenga suficiente espacio de direcciones IP para permitir la escalabilidad del clúster.

3. **Instalación de Librerías Adicionales**:
   - En la pestaña **Libraries**, puedes preinstalar librerías adicionales necesarias para tus trabajos. Por ejemplo, si vas a trabajar con **pandas** o **numpy**, puedes instalarlas desde **PyPI**:
     - Haz clic en **Install New**.
     - Selecciona **PyPI** y busca la librería que necesitas, por ejemplo, `"pandas"` o `"numpy"`, y haz clic en **Install**.
     - Esto asegura que las librerías estén disponibles en todos los nodos del clúster.

---

### Paso 5: Crear y Desplegar el Clúster

1. Después de revisar todas las configuraciones, haz clic en **Create Cluster**.
2. El proceso de creación puede tardar unos minutos dependiendo del tamaño y los recursos seleccionados. Puedes monitorear el progreso en la sección de **Clusters**.

---

### Paso 6: Conectar Notebooks al Clúster

Una vez que el clúster esté listo, puedes conectar tus notebooks para empezar a procesar datos.

1. En la barra lateral izquierda, selecciona **Workspace** y abre un notebook existente o crea uno nuevo.
2. En la parte superior del notebook, selecciona el clúster recién creado desde el menú desplegable de clústeres.
3. Ahora, al ejecutar el código en el notebook, este se procesará utilizando los recursos del clúster.

---

### Conclusión del Laboratorio

En este laboratorio, has aprendido a **crear y configurar un clúster de Apache Spark** en **Azure Databricks**, incluyendo la configuración de parámetros básicos y avanzados. La correcta configuración del clúster es esencial para aprovechar al máximo los recursos y optimizar los costos. Con este clúster, ya puedes comenzar a ejecutar tus trabajos de análisis de datos, modelado de machine learning y procesamiento de grandes volúmenes de datos.

