### Laboratorio: Monitorización de Tareas y Debugging en Spark

**Objetivo**: En este laboratorio, aprenderás a monitorear la ejecución de trabajos y tareas en **Spark UI**, y cómo depurar posibles problemas utilizando las herramientas de monitorización de Databricks. Esto es clave para entender el comportamiento de tus trabajos, optimizar el rendimiento y detectar cuellos de botella o errores.

#### Pasos:

1. **Ejecutar un Trabajo con un Script más Complejo**:
   Vamos a comenzar ejecutando un trabajo que realice más operaciones sobre un archivo de texto. Esto nos dará la oportunidad de ver cómo Spark gestiona las tareas distribuidas.

   En el notebook que has creado anteriormente, añade el siguiente código para contar las palabras en el archivo de texto que subiste previamente:

   ```python
   # Leer el archivo de texto
   rdd_texto = spark.sparkContext.textFile("/dbfs/FileStore/shared_uploads/tu_usuario/archivo_ejemplo.txt")

   # Dividir cada línea en palabras
   rdd_palabras = rdd_texto.flatMap(lambda linea: linea.split(" "))

   # Crear pares (palabra, 1) para contar las palabras
   rdd_contar = rdd_palabras.map(lambda palabra: (palabra, 1))

   # Reducir por clave (palabra) sumando las apariciones
   rdd_resultado = rdd_contar.reduceByKey(lambda a, b: a + b)

   # Mostrar los resultados
   rdd_resultado.collect()
   ```

   Este código realiza las siguientes transformaciones:
   - **flatMap()**: Divide las líneas en palabras.
   - **map()**: Crea pares de la forma (palabra, 1).
   - **reduceByKey()**: Suma las ocurrencias de cada palabra.

   Ejecuta este código en tu notebook y espera a que finalice.

2. **Monitorear el Trabajo en Spark UI**:
   Una vez que ejecutes el trabajo, puedes monitorear su progreso en **Spark UI**.

   - Ve al menú superior de Databricks y haz clic en el ícono del **clúster**.
   - En la página del clúster, selecciona **Spark UI**.
   - Aquí podrás ver varias pestañas útiles:
     - **Jobs**: Muestra una lista de todos los trabajos que se han ejecutado en el clúster. Cada trabajo se desglosa en stages y tareas.
     - **Stages**: Muestra las diferentes etapas del trabajo y cómo están distribuidas las tareas en los nodos.
     - **Tasks**: Proporciona detalles a nivel de tarea, como el tiempo de ejecución, el tamaño de entrada y salida de datos y el uso de CPU.
     - **SQL**: Si estás ejecutando consultas SQL, aquí verás un desglose de su rendimiento.

   **Ejemplo de vista en Spark UI**:
   ```
   +-----------------+----------------------+----------------+
   | Stage ID        | Tasks (Completed/Total) | Input Size    |
   +-----------------+----------------------+----------------+
   | Stage 1         | 4/4                    | 100 MB        |
   | Stage 2         | 4/4                    | 50 MB         |
   +-----------------+----------------------+----------------+
   ```

   En esta vista, puedes observar cuántas tareas se han completado en cada etapa y cuántos datos se han procesado. Si alguna tarea falla, aparecerá un indicador rojo, lo que te permite investigar la causa del fallo.

3. **Depurar Tareas Fallidas**:
   Si alguna tarea falla, Spark UI te permitirá acceder a los detalles del fallo.

   - En la pestaña de **Tasks**, busca las tareas que hayan fallado (se mostrarán en rojo).
   - Haz clic en la tarea fallida para ver el **error de registro** y obtener más información sobre lo que ocurrió.
   - Es posible que el error sea debido a datos corruptos, problemas de red o limitaciones de recursos (memoria o CPU).

   **Consejo**: Si encuentras errores frecuentes, puedes intentar ajustar el número de particiones de los RDDs para evitar sobrecargar los ejecutores. Puedes usar el método `repartition()` para aumentar el número de particiones y distribuir mejor la carga de trabajo:
   ```python
   rdd_reparticionado = rdd_texto.repartition(10)
   ```

4. **Optimización de los Recursos del Clúster**:
   Una vez que hayas identificado cuellos de botella o tareas que tardan más de lo esperado, puedes optimizar el uso de recursos del clúster.

   - **Ajustar el Número de Particiones**: Si tu trabajo tiene pocas particiones, algunos nodos del clúster podrían estar inactivos. Incrementar el número de particiones puede distribuir mejor la carga.
   - **Caché de Datos**: Si algunos datos se utilizan repetidamente, puedes almacenarlos en memoria utilizando el método `cache()` para evitar recalculaciones:
     ```python
     rdd_resultado.cache()
     ```

5. **Utilizar el Historial de Ejecuciones**:
   Databricks también proporciona un **historial de trabajos** para que puedas revisar los trabajos pasados. Desde el clúster, selecciona **Job History** para ver las ejecuciones anteriores y analizar el rendimiento histórico de tus trabajos.

---

Este laboratorio te introduce al uso de **Spark UI** para monitorear y depurar trabajos en Apache Spark. Es una herramienta esencial para identificar cuellos de botella, errores y optimizar el rendimiento en aplicaciones distribuidas.