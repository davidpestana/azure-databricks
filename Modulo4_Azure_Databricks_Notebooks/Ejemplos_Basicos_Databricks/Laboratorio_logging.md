### **Laboratorio: Uso de logging para seguimiento y depuración**

### **Objetivo del laboratorio**

El objetivo de este laboratorio es aprender cómo implementar un sistema de **logging** para hacer seguimiento y depuración en un pipeline de análisis de datos en **Databricks**. El logging es una herramienta crítica para monitorear los procesos, registrar errores y asegurarse de que los flujos de trabajo funcionen correctamente. Simularemos un caso empresarial en el cual una aerolínea registra eventos clave durante el análisis de los vuelos retrasados para su monitoreo.

### **Escenario empresarial**

Imagina que trabajas en el equipo de operaciones de una aerolínea que analiza diariamente los datos de retrasos en vuelos. Es esencial registrar eventos críticos, como el inicio del análisis, posibles errores en la lectura de datos, el éxito o fallo de transformaciones, y el guardado final de los resultados. Implementar un sistema de logging permitirá hacer un seguimiento del proceso y depurar cualquier error que ocurra, asegurando así que todo funcione como se espera.

---

### **Paso 1: Crear un nuevo notebook en Azure Databricks**

#### Instrucciones

1. Accede a tu **workspace de Azure Databricks**.
2. Selecciona **Workspace** en la barra lateral.
3. Haz clic en **Create** (Crear) y selecciona **Notebook**.
4. Nombra el notebook como "Laboratorio - Uso de Logging en Análisis de Vuelos".
5. Selecciona **Python** como lenguaje.
6. Selecciona o crea un **clúster** adecuado para ejecutar el análisis.

---

### **Paso 2: Configurar el sistema de logging**

El primer paso es configurar un logger que registre los eventos clave en el flujo de trabajo. Vamos a utilizar la librería **logging** de Python para este propósito. Guardaremos los logs en un archivo en el sistema de archivos de Databricks (DBFS), de manera que podamos revisarlos en cualquier momento.

#### Celda 1: Configuración inicial del logger

```python
import logging

# Configurar el logger
log_file_path = "/dbfs/mnt/airline/logs/analisis_vuelos.log"
logging.basicConfig(filename=log_file_path, level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Registrar el inicio del proceso
logging.info("Inicio del proceso de análisis de vuelos retrasados")
```

**Explicación**: Hemos configurado el sistema de logging para registrar eventos en un archivo llamado `analisis_vuelos.log`. Este archivo se guardará en el almacenamiento de Databricks en la ruta especificada. Al iniciar el proceso, registramos un mensaje para saber cuándo comenzó el análisis.

---

### **Paso 3: Cargar y verificar los datos de vuelos**

El siguiente paso es cargar los datos de vuelos y verificar si se han cargado correctamente. Si ocurre un error en la carga del archivo, se registrará en el sistema de logs.

#### Celda 2: Cargar los datos de vuelos y verificar su carga

```python
# Intentar cargar el dataset de vuelos desde Databricks Datasets
try:
    df_vuelos = spark.read.csv("/databricks-datasets/flights/departuredelays.csv", header=True, inferSchema=True)
    logging.info("Datos de vuelos cargados exitosamente")
except Exception as e:
    logging.error(f"Error al cargar los datos de vuelos: {e}")
    raise e  # Re-levantar el error para detener el proceso
```

**Explicación**: Este paso carga el dataset de vuelos y registra el éxito o fallo de la operación. Si ocurre un error al leer los datos (por ejemplo, si el archivo no está disponible), el logger lo registrará y se detendrá el proceso para evitar análisis con datos incompletos o erróneos.

---

### **Paso 4: Filtrar los vuelos con retraso y registrar la operación**

Una vez que los datos se hayan cargado correctamente, procederemos a filtrar los vuelos que tienen un retraso mayor a 60 minutos. Registraremos este paso para hacer un seguimiento del progreso del análisis.

#### Celda 3: Filtrar vuelos retrasados y registrar el proceso

```python
try:
    # Filtrar vuelos con un retraso mayor a 60 minutos
    df_vuelos_retrasados = df_vuelos.filter(df_vuelos["delay"] > 60)
    logging.info(f"Se han filtrado los vuelos retrasados. Total de registros filtrados: {df_vuelos_retrasados.count()}")
except Exception as e:
    logging.error(f"Error al filtrar vuelos retrasados: {e}")
    raise e  # Re-levantar el error si ocurre
```

**Explicación**: Registramos el éxito de la operación de filtrado, así como el número de registros que pasaron el filtro. Esto es útil para depurar casos en los que el número de registros filtrados no sea el esperado. Si ocurre un error durante el filtrado, también se registrará.

---

### **Paso 5: Realizar una transformación y registrar el éxito**

Procederemos a calcular una columna adicional que nos permita convertir la distancia del vuelo en horas (asumiendo una velocidad promedio de 500 millas por hora). Este paso también será registrado.

#### Celda 4: Crear columna calculada y registrar el proceso

```python
try:
    # Crear una nueva columna con la duración del vuelo en horas
    df_vuelos_retrasados = df_vuelos_retrasados.withColumn("duracion_horas", df_vuelos_retrasados["distance"] / 500)
    logging.info("Se ha creado la columna 'duracion_horas' con éxito")
except Exception as e:
    logging.error(f"Error al crear la columna 'duracion_horas': {e}")
    raise e  # Re-levantar el error si ocurre
```

**Explicación**: Aquí estamos registrando el éxito de la creación de una nueva columna calculada, lo que permite un seguimiento detallado del progreso de las transformaciones. Si algo sale mal, se registra el error para depurarlo más adelante.

---

### **Paso 6: Guardar los resultados y registrar el proceso**

Finalmente, después de haber realizado todas las transformaciones necesarias, vamos a guardar los resultados en formato **Parquet**. Esto también se registrará en nuestro archivo de logs para confirmar que el proceso de guardado fue exitoso.

#### Celda 5: Guardar los resultados en formato Parquet

```python
try:
    # Guardar los resultados en formato Parquet
    df_vuelos_retrasados.write.format("parquet").mode("overwrite").save("/mnt/airline/retrasos_vuelos.parquet")
    logging.info("Los resultados se han guardado en formato Parquet con éxito")
except Exception as e:
    logging.error(f"Error al guardar los resultados en formato Parquet: {e}")
    raise e  # Re-levantar el error si ocurre
```

**Explicación**: Guardar los datos en formato **Parquet** es una de las últimas etapas en este flujo de trabajo, y registrar el éxito de esta operación asegura que se ha completado correctamente. Si falla, podemos revisar el log para entender dónde estuvo el problema y tomar las medidas correctivas necesarias.

---

### **Paso 7: Verificar el archivo de logs**

Para finalizar el laboratorio, verificaremos el contenido del archivo de logs para asegurarnos de que todos los eventos clave se hayan registrado correctamente.

#### Celda 6: Verificar el archivo de logs

```python
# Leer el archivo de logs y mostrar las últimas líneas
log_file = "/mnt/airline/logs/analisis_vuelos.log"
dbutils.fs.head(log_file)
```

**Explicación**: En este paso, revisamos el archivo de logs para asegurarnos de que los eventos como la carga de datos, el filtrado, la creación de columnas y el guardado se hayan registrado correctamente. Este archivo es muy útil para depuración, auditoría y seguimiento.

---

### **Conclusión del laboratorio**

En este laboratorio, has aprendido a:

- Configurar un sistema de **logging** en un notebook de Databricks para hacer seguimiento de procesos.
- Registrar eventos clave como la carga de datos, transformaciones y filtrado de datos.
- Manejar errores y registrar fallos en el proceso para facilitar la depuración.
- Guardar los resultados del análisis en formato Parquet y registrar el éxito de la operación.
- Revisar el archivo de logs para verificar que los eventos se hayan registrado correctamente.

Este enfoque es esencial en entornos empresariales donde los flujos de datos deben ser confiables, monitoreados y depurados en caso de fallos. El logging es una herramienta crítica para asegurar que los pipelines de datos se ejecuten sin problemas y, si fallan, los errores puedan ser fácilmente localizados y corregidos.