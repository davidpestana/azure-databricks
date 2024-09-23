### Laboratorio: Explorar la Interfaz de Usuario de Databricks

**Objetivo**: Familiarizarse con la interfaz de usuario de Databricks y entender las funcionalidades clave que ofrece para la gestión de datos y recursos.

#### Pasos:

1. **Acceder al Portal de Azure**:
   - Inicia sesión en el **[portal de Azure](https://portal.azure.com)**.
   - Navega a tu recurso de **Azure Databricks**.
   - Haz clic en **Iniciar Workspace** para abrir la interfaz de Databricks.

2. **Explorar la Barra Lateral**:
   - **Home**: Desde aquí puedes acceder a los recursos recientes y ver resúmenes generales de actividades.
   - **Workspace**: En esta sección puedes crear y organizar notebooks, bibliotecas, y otros recursos.
   - **Clusters**: Aunque no crearemos un clúster en este laboratorio, es importante familiarizarse con esta sección, ya que desde aquí podrás gestionar los recursos computacionales para ejecutar trabajos de Spark.
   - **Jobs**: Para gestionar trabajos automatizados y flujos de trabajo en Databricks.
   - **DBFS (Databricks File System)**: Sistema de archivos distribuido de Databricks donde podrás almacenar datos.

3. **Crear un Notebook**:
   - Navega a **Workspace** y haz clic en los tres puntos junto al nombre de tu workspace.
   - Selecciona **Create** > **Notebook**.
   - Asigna un nombre a tu notebook, selecciona **Python** como lenguaje y haz clic en **Create**.

4. **Ejecutar un Comando Básico en el Notebook**:
   - En el notebook recién creado, en la primera celda, introduce el siguiente comando de prueba:
     ```python
     print("Hola, Databricks")
     ```
   - Presiona **Shift + Enter** para ejecutar la celda. Verás el resultado de la ejecución justo debajo.

5. **Navegar por la Interfaz del Notebook**:
   - Explora las herramientas disponibles en la parte superior del notebook: puedes **añadir nuevas celdas**, **detener la ejecución**, **cargar datos**, y **ver el historial de ejecuciones**.

6. **Guardar y Cerrar el Notebook**:
   - Haz clic en **File** > **Save** para guardar el notebook.
   - Cierra el notebook y regresa a la vista principal del workspace.

---

Este laboratorio ha cubierto la creación de un notebook básico y la exploración de la interfaz de usuario de Databricks, clave para trabajar con datos y ejecutar trabajos de procesamiento.