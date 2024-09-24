### Laboratorio: Ejecutar un Script Básico de Spark para Contar Líneas en un Archivo de Texto

**Objetivo**: Utilizar el clúster de Spark creado previamente para ejecutar un script que lea un archivo de texto y cuente el número de líneas. Este ejercicio es una introducción básica al uso de **RDDs** y las transformaciones en Spark.

#### Requisitos:
- Clúster de Spark previamente creado en **Azure Databricks**.
- Un archivo de texto para procesar (puede ser cargado en el sistema de archivos de Databricks, DBFS).

#### Pasos:

1. **Cargar el Archivo de Texto en DBFS (Databricks File System)**:
   - Ve a la sección de **Data** en la barra lateral izquierda.
   - Haz clic en **Add Data** y selecciona **Upload File**.
   - Carga un archivo de texto de tu elección, o puedes crear uno simple de ejemplo en tu máquina:
     ```text
     Hola, este es un archivo de ejemplo.
     Spark es una herramienta potente para el procesamiento de grandes datos.
     Apache Spark es rápido gracias a su procesamiento en memoria.
     ```
   - Carga el archivo y selecciona la opción de **DBFS** (Databricks File System).

2. **Crear un Nuevo Notebook**:
   - Ve a la sección **Workspace**.
   - Haz clic en los tres puntos junto al nombre de tu workspace y selecciona **Create** > **Notebook**.
   - Asigna un nombre al notebook, selecciona **Python** como lenguaje y asegúrate de conectarlo al clúster que creaste previamente.

3. **Escribir el Script para Contar Líneas**:
   En el notebook recién creado, introduce el siguiente código en la primera celda. Este script utiliza Spark para leer el archivo de texto desde DBFS, cuenta el número de líneas y muestra el resultado:

   ```python
   # Definir la ruta del archivo en DBFS (ajusta la ruta a la de tu archivo)
   ruta_archivo = "/dbfs/FileStore/shared_uploads/tu_usuario/archivo_ejemplo.txt"

   # Leer el archivo de texto como un RDD
   rdd_texto = spark.sparkContext.textFile(ruta_archivo)

   # Contar el número de líneas en el archivo
   num_lineas = rdd_texto.count()

   # Mostrar el resultado
   print(f"El archivo contiene {num_lineas} líneas.")
   ```

   En este código:
   - **textFile()** carga el archivo de texto como un **RDD** (Resilient Distributed Dataset), permitiendo que Spark distribuya el procesamiento del archivo en los nodos del clúster.
   - **count()** es una acción que cuenta el número de elementos (en este caso, líneas) en el RDD.

4. **Ejecutar el Script**:
   - Haz clic en **Run Cell** o presiona **Shift + Enter** para ejecutar el código.
   - Spark leerá el archivo desde DBFS y mostrará el número de líneas en el archivo.

   **Ejemplo de salida**:
   ```
   El archivo contiene 3 líneas.
   ```

5. **Validar los Resultados**:
   - Si deseas ver el contenido del archivo, puedes utilizar el siguiente comando en una nueva celda:
   ```python
   rdd_texto.collect()
   ```

   Esto devolverá el contenido del archivo como una lista de líneas, que puedes revisar en la salida del notebook.

---

Este laboratorio muestra cómo Spark puede trabajar con archivos de texto, cargando los datos en un RDD y ejecutando una operación básica de conteo de líneas. Es un ejemplo práctico del procesamiento distribuido en Apache Spark.