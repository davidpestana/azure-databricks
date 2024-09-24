### Laboratorio: Configurar un Notebook de Databricks para Usar PySpark

**Objetivo**: Configurar y utilizar un notebook en **Azure Databricks** para ejecutar código de PySpark. Aprenderás a crear un notebook, conectarlo a un clúster, y realizar operaciones básicas utilizando PySpark en un entorno de Databricks.

#### Requisitos:
- Acceso a un **workspace** de Azure Databricks.
- Un clúster de Databricks en funcionamiento (si no tienes uno creado, consulta laboratorios anteriores sobre cómo crear un clúster).

#### Pasos para Configurar el Notebook:

1. **Crear un Notebook en Databricks**:
   - Navega al **Workspace** de Databricks.
   - En el menú de la izquierda, selecciona **Create** > **Notebook**.
   - Asigna un nombre al notebook (por ejemplo, `"Notebook PySpark Básico"`).
   - Elige **Python** como el lenguaje del notebook.
   - Selecciona el clúster que has creado previamente para conectarlo al notebook.

2. **Iniciar una Sesión de PySpark**:
   A continuación, escribe el siguiente código en una celda del notebook para iniciar una sesión de PySpark.

   ```python
   from pyspark.sql import SparkSession

   # Crear una SparkSession
   spark = SparkSession.builder.appName("EjemploPySpark").getOrCreate()

   # Verificar la versión de Spark
   print(f"Versión de Spark: {spark.version}")
   ```

   **Explicación**:
   - **SparkSession** es el punto de entrada para trabajar con PySpark.
   - Este código inicializa una nueva sesión de Spark y verifica la versión instalada de Apache Spark en el clúster.

3. **Leer Datos en el Notebook Usando PySpark**:
   Ahora que la sesión está configurada, vamos a leer datos desde un archivo CSV usando PySpark.

   ```python
   # Cargar un archivo CSV desde DBFS (Asegúrate de que este archivo exista)
   ruta_archivo_csv = "/databricks-datasets/samples/population-vs-price/data_geo.csv"
   
   # Leer el archivo CSV en un DataFrame de PySpark
   df = spark.read.csv(ruta_archivo_csv, header=True, inferSchema=True)

   # Mostrar los primeros registros
   df.show(5)
   ```

   **Explicación**:
   - La función `spark.read.csv()` permite leer archivos CSV en un **DataFrame** de PySpark.
   - `header=True` indica que la primera fila contiene los nombres de las columnas.
   - `inferSchema=True` permite a PySpark inferir automáticamente los tipos de datos.

4. **Realizar Operaciones Básicas con PySpark**:
   Ahora que tienes datos cargados en un DataFrame, puedes realizar algunas operaciones simples, como filtrado y agregación.

   **Filtrar el DataFrame**:
   ```python
   # Filtrar los datos donde la columna 'population' sea mayor a 1 millón
   df_filtro = df.filter(df["population"] > 1000000)
   
   # Mostrar los resultados
   df_filtro.show(5)
   ```

   **Agregar Datos**:
   ```python
   # Agrupar por 'city' y sumar las poblaciones
   df_agrupado = df.groupBy("city").sum("population")
   
   # Mostrar el resultado
   df_agrupado.show(5)
   ```

   **Explicación**:
   - En la primera operación, se filtran las ciudades cuya población es mayor a un millón.
   - En la segunda operación, se agrupan los datos por ciudad y se calcula la suma de las poblaciones.

5. **Guardar el Resultado en un Archivo**:
   Puedes guardar los resultados de tus análisis en un archivo CSV en **DBFS** (Databricks File System) o en otro formato.

   ```python
   # Guardar el DataFrame filtrado en un archivo CSV
   df_filtro.write.csv("/dbfs/FileStore/shared_uploads/tu_usuario/resultado.csv")
   
   print("Archivo CSV guardado correctamente.")
   ```

   **Explicación**:
   - El método `write.csv()` se utiliza para guardar los resultados del DataFrame en un archivo CSV en el almacenamiento de Databricks.

6. **Detener la Sesión de Spark**:
   Es importante detener la sesión de Spark cuando hayas terminado para liberar los recursos del clúster.

   ```python
   spark.stop()
   ```

---

#### Expansión: Conexión con Azure Blob Storage o Data Lake

En escenarios donde necesitas leer o escribir grandes volúmenes de datos desde o hacia **Azure Blob Storage** o **Azure Data Lake**, puedes montar esos servicios en **DBFS** (Databricks File System) como se explica en el anexo anterior.

**Leer Datos desde Blob Storage**:
```python
# Configurar las credenciales y montar Blob Storage
dbutils.fs.mount(
    source = "wasbs://contenedor@nombrecuenta.blob.core.windows.net",
    mount_point = "/mnt/contenedor",
    extra_configs = {"fs.azure.account.key.nombrecuenta.blob.core.windows.net": "clave_de_acceso"}
)

# Leer datos desde Blob Storage
df_blob = spark.read.csv("/mnt/contenedor/datos.csv", header=True)

df_blob.show(5)
```

**Desmontar el Contenedor**:
```python
# Desmontar el contenedor cuando hayas terminado
dbutils.fs.unmount("/mnt/contenedor")
```

---

#### Conclusión

Este laboratorio te ha mostrado cómo configurar un notebook en **Azure Databricks** para trabajar con **PySpark**. Has aprendido a leer datos, realizar operaciones básicas con DataFrames y guardar los resultados. En entornos más complejos, puedes conectar tu notebook a fuentes de datos externas como **Azure Blob Storage** o **Azure Data Lake**, lo que te permite manejar grandes volúmenes de datos distribuidos.