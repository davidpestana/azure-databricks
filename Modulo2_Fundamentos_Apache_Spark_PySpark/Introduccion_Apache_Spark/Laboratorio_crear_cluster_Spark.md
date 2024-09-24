### Laboratorio: Crear un clúster de Spark en Databricks

**Objetivo**: Aprender a crear y configurar un clúster en **Azure Databricks** que sirva como base para ejecutar trabajos distribuidos con Apache Spark.

#### Pasos:

1. **Acceder al Workspace de Azure Databricks**:
   - Abre el **portal de Azure** y navega al recurso de **Azure Databricks**.
   - Haz clic en **Iniciar Workspace** para acceder a la interfaz de usuario de Databricks.

2. **Navegar a la Sección de Clústeres**:
   - En el menú lateral izquierdo, selecciona la opción **Clusters**.
   - Haz clic en **Create Cluster** para comenzar la creación del clúster.

3. **Configurar el Clúster**:
   - **Cluster Name**: Asigna un nombre único al clúster, por ejemplo, `"Cluster-Ejemplo-Spark"`.
   - **Databricks Runtime Version**: Selecciona la versión más reciente de Apache Spark. La opción por defecto suele ser la mejor para la mayoría de los trabajos.
   - **Worker Type**: Selecciona el tipo de máquina virtual para los nodos de trabajo. Puedes elegir **Standard_DS3_v2** como una opción económica.
   - **Driver Type**: Configura el mismo tipo de máquina para el driver.
   - **Autoescalado**: Activa esta opción para permitir que el clúster escale automáticamente según la carga de trabajo. Configura un mínimo de **2 nodos** y un máximo de **8 nodos**.

4. **Opciones Avanzadas (Opcional)**:
   - **Auto Termination**: Configura para que el clúster se apague automáticamente después de un tiempo determinado de inactividad. Puedes establecer **30 minutos** como límite de inactividad.
   - **Librerías**: Puedes preinstalar librerías adicionales como **pandas**, **numpy**, etc., si tu trabajo lo requiere.

5. **Crear el Clúster**:
   - Una vez configurados todos los parámetros, haz clic en **Create Cluster**. El proceso puede tardar algunos minutos.

6. **Conectar un Notebook al Clúster**:
   - Ve a la sección de **Workspace** y crea un nuevo **notebook**.
   - En el menú superior del notebook, selecciona el clúster que acabas de crear para conectar el notebook al clúster.

---

Este laboratorio te permite crear un clúster de Apache Spark que podrás utilizar para ejecutar trabajos de procesamiento de datos en paralelo y distribuido en Databricks.