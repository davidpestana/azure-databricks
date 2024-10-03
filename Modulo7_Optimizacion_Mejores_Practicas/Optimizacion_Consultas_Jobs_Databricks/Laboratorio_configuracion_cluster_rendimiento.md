### Laboratorio: Configurar un Clúster de Databricks para Mejorar el Rendimiento

#### Objetivo:
El objetivo de este laboratorio es aprender a configurar un clúster de Databricks de manera óptima para mejorar el rendimiento de trabajos Spark. Los estudiantes ajustarán parámetros clave del clúster, como el número de ejecutores, la memoria asignada y las configuraciones de autoscaling, para lograr una ejecución más eficiente de los trabajos.

#### Requisitos Previos:
- Acceso a un clúster Databricks.
- Familiaridad básica con la configuración de clústeres en Databricks y los conceptos de ejecutores y núcleos de Spark.

---

### Paso 1: Crear un Clúster en Databricks

Lo primero que haremos es crear un clúster en Databricks con la configuración básica. Luego, lo ajustaremos para optimizar el rendimiento.

**Instrucciones**: Sigue los pasos a continuación para crear un nuevo clúster.

1. **Acceder al panel de clústeres**:
   - Inicia sesión en tu cuenta de Databricks.
   - En el panel izquierdo, selecciona **Clústeres** y luego haz clic en **Crear Clúster**.

2. **Configurar el clúster básico**:
   - Asigna un nombre al clúster, por ejemplo, `Cluster_Optimizacion`.
   - Selecciona la versión de **Databricks Runtime** más reciente (por ejemplo, Databricks Runtime 10.5 o superior).
   - Elige una **máquina principal** (driver), por ejemplo: `Standard_DS3_v2`.
   - Configura el **número de trabajadores (workers)**, por ejemplo: entre 2 y 4 nodos para este laboratorio inicial.
   - Establece la configuración de **autoscaling**: Activa la opción de **autoscaling** para que el clúster escale automáticamente según la carga de trabajo.

3. **Lanzar el clúster**:
   - Haz clic en **Crear** para lanzar el clúster. Este proceso puede tardar unos minutos en completarse.

**Explicación**:
En este paso, estamos configurando un clúster básico en Databricks que se usará para realizar las optimizaciones posteriores. Hemos activado el autoscaling para que el clúster pueda escalar automáticamente según la demanda de trabajo, lo que permite optimizar los recursos.

---

### Paso 2: Ajustar la Configuración de los Ejecutores

La configuración de los ejecutores y la cantidad de memoria asignada son clave para mejorar el rendimiento. Ahora ajustaremos la cantidad de memoria por ejecutor y el número de núcleos para maximizar la eficiencia del clúster.

**Instrucciones**:

1. **Acceder a la configuración avanzada del clúster**:
   - En la página de clústeres, selecciona el clúster que acabas de crear.
   - Haz clic en **Editar** y luego en la pestaña **Configuración avanzada**.

2. **Configurar los parámetros de los ejecutores**:
   - **spark.executor.cores**: Establece el número de núcleos por ejecutor. Un valor común es 4 núcleos por ejecutor, pero puedes ajustarlo según el tipo de carga.
   - **spark.executor.memory**: Define la cantidad de memoria asignada por ejecutor. Un valor típico es 8 GB por ejecutor, pero si los trabajos requieren más memoria, este valor debe aumentarse.
   
   **Ejemplo de configuración**:
   ```bash
   spark.executor.cores = 4
   spark.executor.memory = 8g
   ```

3. **Configurar la memoria del driver**:
   - **spark.driver.memory**: Ajusta la memoria del driver a un valor adecuado, como 4 GB o 8 GB, dependiendo de la carga.

**Explicación**:
Asignar la cantidad correcta de memoria y núcleos a los ejecutores asegura que Spark pueda procesar más particiones en paralelo, lo que puede mejorar el rendimiento. Al ajustar la memoria del driver, también nos aseguramos de que el nodo principal pueda manejar las tareas de coordinación sin quedarse sin recursos.

---

### Paso 3: Optimizar el Particionamiento y Paralelismo

El siguiente paso es ajustar el particionamiento y el paralelismo en el clúster para optimizar el procesamiento de los trabajos.

**Instrucciones**:

1. **Configurar el paralelismo por defecto**:
   - Establece el nivel de paralelismo en función del número de núcleos totales disponibles en el clúster.
   - **spark.default.parallelism**: Ajusta este valor a 2 o 3 veces el número de núcleos disponibles.

   ```bash
   spark.default.parallelism = [Número de núcleos] * 2
   ```

2. **Ajustar el número de particiones en operaciones `shuffle`**:
   - **spark.sql.shuffle.partitions**: Reduce o incrementa el número de particiones dependiendo del tamaño del conjunto de datos y la capacidad del clúster. Un valor adecuado para conjuntos de datos medianos puede ser entre 200 y 1000 particiones.

   ```bash
   spark.sql.shuffle.partitions = 500
   ```

**Explicación**:
El nivel de paralelismo define cuántas tareas puede ejecutar Spark simultáneamente. Ajustar este parámetro en función de los recursos del clúster mejora la eficiencia. También, al modificar el número de particiones, podemos reducir la sobrecarga del procesamiento de `shuffle`, lo que optimiza el rendimiento general.

---

### Paso 4: Ejecutar un Trabajo y Evaluar el Rendimiento

Ahora que hemos configurado el clúster, es momento de ejecutar un trabajo en Spark y monitorear su rendimiento utilizando el Spark UI.

**Instrucciones**:

1. **Ejecutar una consulta SQL simple**:
   - Abre un nuevo notebook en Databricks.
   - Ejecuta la siguiente consulta SQL sobre un conjunto de datos grande (como la tabla `sales_data` que generaste en el laboratorio anterior):

   ```sql
   SELECT
     store_id,
     SUM(sales_amount) AS total_sales
   FROM
     sales_data
   GROUP BY
     store_id;
   ```

2. **Monitorear el rendimiento usando Spark UI**:
   - Haz clic en el ícono de **Ver Detalles** (en la parte superior derecha de la celda) para acceder a la vista de **Spark UI**.
   - Revisa el tiempo de ejecución, el número de etapas, la cantidad de particiones y el uso de los ejecutores.

3. **Evaluar el uso de recursos**:
   - En el Spark UI, dirígete a la pestaña de **Executors**. Evalúa cómo se distribuye la carga entre los ejecutores y si alguno de ellos está inactivo o sobrecargado.
   - Verifica que el tamaño de las particiones esté bien equilibrado y que no haya particiones excesivamente grandes o pequeñas.

**Explicación**:
Ejecutar un trabajo en Spark y monitorear su rendimiento en el Spark UI permite verificar si las configuraciones del clúster están funcionando de manera óptima. En este paso, evaluaremos el uso de recursos, el tiempo de ejecución y si el particionamiento y el paralelismo están bien configurados.

---

### Paso 5: Ajustar el Clúster Basado en el Análisis de Spark UI

Con base en los resultados obtenidos de la ejecución del trabajo y el análisis en Spark UI, realizaremos ajustes adicionales al clúster para optimizar aún más el rendimiento.

**Instrucciones**:

1. **Ajustar el número de trabajadores (autoscaling)**:
   - Si el clúster parece estar bajo o sobreutilizado, ajusta el número mínimo y máximo de trabajadores. Puedes incrementar el máximo si el trabajo requiere más recursos.

2. **Reevaluar la cantidad de memoria asignada**:
   - Si los ejecutores están alcanzando su límite de memoria, puedes incrementar **spark.executor.memory** para asegurar que haya suficiente memoria disponible.
   - Si notas que algunos ejecutores están inactivos o subutilizados, reduce el número de núcleos por ejecutor para distribuir la carga de manera más eficiente.

3. **Configurar el almacenamiento en caché**:
   - Si el trabajo reutiliza frecuentemente los mismos datos, utiliza el almacenamiento en caché para acelerar las siguientes consultas.
   
   ```sql
   CACHE TABLE sales_data_cached AS SELECT * FROM sales_data;
   ```

**Explicación**:
Con estos ajustes adicionales, podemos asegurarnos de que el clúster esté usando los recursos de manera eficiente y que cualquier cuello de botella identificado se resuelva. El autoscaling es especialmente útil para manejar la variabilidad en la carga de trabajo.

---

### Paso 6: Documentar los Resultados y Comparaciones

**Instrucciones**:
1. **Documenta los tiempos de ejecución antes y después de la optimización**. 
   - Anota el tiempo que tomó ejecutar la consulta en la configuración básica del clúster.
   - Luego, registra los tiempos después de ajustar los parámetros del clúster y hacer uso de caché, particiones y paralelismo.

2. **Comparación de uso de recursos**:
   - Compara el uso de memoria y el número de ejecutores activos antes y después de las optimizaciones.

**Conclus

ión**:
Este paso final te permite evaluar las mejoras en el rendimiento tras aplicar los ajustes en la configuración del clúster. Documentar los resultados ayuda a medir el impacto de las optimizaciones.

---

### Conclusión del Laboratorio:

En este laboratorio, aprendiste cómo configurar un clúster de Databricks para mejorar el rendimiento, ajustando parámetros clave como la cantidad de memoria, núcleos, particiones y el uso de autoscaling. Además, monitoreaste el rendimiento usando el Spark UI y aplicaste ajustes adicionales para optimizar el uso de recursos.

**Tarea Extra**:
- Intenta realizar ajustes adicionales basados en el tamaño del dataset y evalúa cómo afectan al rendimiento.
- Ejecuta más trabajos con diferentes configuraciones y documenta los resultados.