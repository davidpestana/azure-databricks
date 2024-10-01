### **Laboratorio: Monitoreo y depuración de pipelines de datos**

### **Objetivo del laboratorio**

El objetivo de este laboratorio es aprender a **monitorear y depurar** un pipeline de procesamiento de datos en **Azure Databricks**. Monitorear un pipeline es fundamental para identificar problemas de rendimiento, fallos en las transformaciones de datos y otros errores. Además, aprenderás a depurar el código y optimizar el pipeline para que sea más eficiente.

### **Escenario**

Estás trabajando en un pipeline que procesa grandes volúmenes de datos diariamente. Se te ha solicitado monitorear el pipeline para identificar posibles problemas de rendimiento, como tiempos de ejecución largos o errores en la carga de datos. Usarás las herramientas de monitoreo disponibles en Databricks y realizarás ajustes en el código para optimizar el pipeline y mejorar su rendimiento.

---

### **Paso 1: Monitorear el rendimiento del pipeline en Spark UI**

**Spark UI** proporciona una interfaz visual para monitorear y analizar el rendimiento de los trabajos que se ejecutan en Spark. En este paso, aprenderás cómo utilizar **Spark UI** para revisar el tiempo de ejecución de cada tarea, identificar cuellos de botella y analizar la cantidad de recursos utilizados.

#### Instrucciones:

1. Ejecuta el pipeline que configuraste en los laboratorios anteriores.
2. Durante la ejecución, abre la interfaz de **Spark UI** desde el clúster de Databricks:
   - Ve a **Clusters** > selecciona el clúster que está ejecutando el Job.
   - Haz clic en **Spark UI**.
3. Dentro de **Spark UI**, revisa los siguientes apartados:
   - **Jobs**: Te muestra una lista de todos los trabajos ejecutados, junto con el estado (completado, fallido, en ejecución).
   - **Stages**: Muestra las diferentes etapas de cada trabajo y el tiempo que ha tomado cada etapa.
   - **Tasks**: Proporciona detalles sobre cada tarea ejecutada, como el uso de CPU y memoria.
4. Identifica posibles cuellos de botella, como etapas que tardan más de lo esperado o tareas que utilizan demasiados recursos.

#### Explicación:
- **Spark UI** es una herramienta visual que te permite monitorear en tiempo real el estado de cada etapa del pipeline, identificar tareas que pueden estar fallando o consumiendo demasiados recursos, y obtener métricas detalladas sobre el uso de CPU y memoria.
- Revisar el rendimiento de cada **job** y **stage** te permite tomar decisiones informadas sobre cómo optimizar el pipeline para reducir tiempos de ejecución.

---

### **Paso 2: Configurar logs de depuración en el pipeline**

En este paso, configurarás el registro de **logs detallados** para capturar información sobre el estado de las transformaciones y detectar posibles errores o fallos. Usar **logs** es una buena práctica para saber qué está ocurriendo en cada etapa del pipeline y qué datos pueden estar causando problemas.

#### Celda 1: Añadir logs al pipeline

```python
import logging

# Configurar el logger
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("PipelineVentas")

# Log para registrar el inicio del pipeline
logger.info("Iniciando el pipeline de procesamiento de ventas")

# Cargar los datos de ventas
df_ventas = spark.read.csv("/mnt/blobstorage/sales/2024-10-01/ventas.csv", header=True, inferSchema=True)
logger.info(f"Datos de ventas cargados: {df_ventas.count()} registros")

# Log para registrar el cálculo de ventas totales por categoría
logger.info("Calculando las ventas totales por categoría de producto")
df_ventas_agrupadas = df_ventas.groupBy("categoria_producto").agg(sum("precio_venta").alias("total_ventas"))

# Log para registrar la finalización del proceso
logger.info("El pipeline ha finalizado correctamente")
```

#### Explicación:
- **logging.info()**: Se utiliza para registrar información detallada sobre cada paso del pipeline. Estos logs te permiten hacer un seguimiento del estado de la ejecución.
- Los logs se pueden revisar después de la ejecución para identificar posibles errores o entender mejor el flujo del pipeline.

---

### **Paso 3: Manejo de errores y excepciones en el pipeline**

Es importante manejar adecuadamente los errores y excepciones que puedan surgir durante la ejecución del pipeline. En este paso, agregarás bloques de manejo de excepciones para capturar y registrar cualquier error que ocurra durante el procesamiento de los datos.

#### Celda 2: Añadir manejo de errores

```python
try:
    # Intentar cargar los datos de ventas
    logger.info("Intentando cargar los datos de ventas")
    df_ventas = spark.read.csv("/mnt/blobstorage/sales/2024-10-01/ventas.csv", header=True, inferSchema=True)
except Exception as e:
    logger.error(f"Error al cargar los datos de ventas: {e}")
    raise

try:
    # Intentar procesar los datos
    logger.info("Iniciando el procesamiento de las ventas")
    df_ventas_agrupadas = df_ventas.groupBy("categoria_producto").agg(sum("precio_venta").alias("total_ventas"))
except Exception as e:
    logger.error(f"Error en el procesamiento de las ventas: {e}")
    raise

logger.info("El pipeline ha finalizado correctamente")
```

#### Explicación:
- **try-except**: Captura los errores que ocurren durante la ejecución del pipeline, lo que permite manejar fallos específicos sin detener todo el proceso.
- **logger.error()**: Registra un mensaje de error si ocurre alguna excepción, lo que facilita la depuración.

---

### **Paso 4: Optimizar el pipeline utilizando caching**

Para mejorar el rendimiento del pipeline, aplicarás **caching** a los datos transformados. Esto permite que los resultados intermedios se almacenen en memoria y se reutilicen en futuras transformaciones, evitando recalculaciones innecesarias.

#### Celda 3: Aplicar caching a los datos

```python
# Cachear los datos de ventas agrupadas
logger.info("Cacheando los datos de ventas agrupadas para optimizar el rendimiento")
df_ventas_agrupadas.cache()

# Realizar una consulta rápida sobre los datos cacheados
df_ventas_agrupadas.filter(df_ventas_agrupadas.total_ventas > 1000).show(5)
```

#### Explicación:
- **cache()**: Almacena los datos en memoria, lo que mejora el rendimiento al evitar recalcular los resultados de las transformaciones anteriores.
- **filter()**: Realiza una consulta rápida sobre los datos cacheados para verificar que el caching funciona correctamente.

---

### **Conclusión del laboratorio**

En este laboratorio, has aprendido a:

1. **Monitorear el rendimiento del pipeline** utilizando Spark UI para identificar cuellos de botella y analizar el uso de recursos.
2. **Configurar logs de depuración** para registrar información detallada sobre el estado del pipeline y detectar posibles errores.
3. **Manejar excepciones** en el pipeline para garantizar que los errores sean capturados y registrados de manera efectiva.
4. **Optimizar el pipeline** aplicando técnicas de caching para mejorar el rendimiento y reducir los tiempos de ejecución.

Monitorear y depurar correctamente un pipeline de datos es esencial en entornos empresariales, donde el procesamiento eficiente de grandes volúmenes de datos puede ser crítico para el éxito de los negocios.