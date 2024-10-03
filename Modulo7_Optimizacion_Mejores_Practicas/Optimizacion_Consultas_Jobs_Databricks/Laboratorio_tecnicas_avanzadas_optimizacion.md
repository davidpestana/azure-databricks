### Laboratorio: Uso de Técnicas Avanzadas de Optimización (Particionamiento y Paralelismo)

#### Objetivo:
En este laboratorio, los estudiantes aprenderán a utilizar técnicas avanzadas de optimización, como el particionamiento de datos y la configuración del paralelismo, para mejorar el rendimiento de trabajos en Databricks. Estas técnicas son esenciales para manejar grandes volúmenes de datos en entornos distribuidos.

#### Requisitos Previos:
- Tener un clúster de Databricks configurado.
- Familiaridad básica con Spark SQL y la ejecución de consultas en Databricks.
- Un conjunto de datos lo suficientemente grande para observar el impacto de las optimizaciones (se puede utilizar el dataset `sales_data` generado en laboratorios anteriores).

---

### Paso 1: Crear un Dataset Particionado

El particionamiento de datos permite que Spark procese porciones de los datos en paralelo, mejorando el rendimiento al reducir la sobrecarga de procesamiento en cada nodo del clúster. Vamos a crear una tabla particionada que facilite este procesamiento.

**Instrucciones**: Crear una tabla particionada basada en el campo `store_id` del dataset `sales_data`.

1. **Crear una tabla particionada**:

```sql
-- Crear una tabla particionada por tienda
CREATE OR REPLACE TABLE sales_data_partitioned
USING PARQUET
PARTITIONED BY (store_id)
AS SELECT * FROM sales_data;
```

**Explicación**:
En este paso, estamos creando una tabla particionada utilizando el formato **Parquet**, que es óptimo para grandes volúmenes de datos. La partición por `store_id` permitirá a Spark procesar los datos de cada tienda de manera independiente, lo que mejora el paralelismo.

---

### Paso 2: Verificar el Particionamiento en Spark UI

Es importante verificar que el particionamiento de los datos se ha aplicado correctamente y que las consultas aprovechan este particionamiento. Vamos a ejecutar una consulta y revisaremos el plan de ejecución en Spark UI.

**Instrucciones**: Ejecuta una consulta para aprovechar el particionamiento.

```sql
-- Consulta que aprovecha el particionamiento
SELECT
  store_id,
  SUM(sales_amount) AS total_sales
FROM
  sales_data_partitioned
WHERE
  store_id = 123 -- Filtrando por una tienda en particular
GROUP BY
  store_id;
```

1. **Revisar Spark UI**:
   - Después de ejecutar la consulta, accede a **Spark UI** haciendo clic en el ícono de **Ver Detalles**.
   - Revisa el plan de ejecución físico y verifica si Spark ha aprovechado el particionamiento.
   
2. **Evaluar el impacto del particionamiento**:
   - En la pestaña de **Stages**, observa si la consulta se ha ejecutado solo en las particiones correspondientes al `store_id` 123, en lugar de procesar toda la tabla.

**Explicación**:
El particionamiento permite que Spark acceda solo a las particiones relevantes, reduciendo el volumen de datos a procesar y mejorando significativamente el rendimiento. Si el plan de ejecución muestra que Spark está leyendo todas las particiones, podría ser necesario ajustar el particionamiento o la consulta.

---

### Paso 3: Ajustar el Paralelismo en el Clúster

El paralelismo en Spark define cuántas tareas se pueden ejecutar simultáneamente. Ajustar el nivel de paralelismo es crucial para aprovechar todos los recursos del clúster de manera eficiente.

**Instrucciones**:

1. **Configurar el paralelismo por defecto**:
   - Abre las configuraciones avanzadas del clúster en Databricks.
   - Establece el valor de **spark.default.parallelism** a 2 o 3 veces el número de núcleos totales disponibles en el clúster.

   ```bash
   spark.default.parallelism = [Número de núcleos] * 2
   ```

2. **Ajustar el número de particiones en operaciones de `shuffle`**:
   - **spark.sql.shuffle.partitions**: Este valor controla el número de particiones durante las operaciones de `shuffle` en agregaciones, joins, etc. Incrementa este valor si trabajas con grandes volúmenes de datos para evitar que las particiones sean demasiado grandes.

   ```bash
   spark.sql.shuffle.partitions = 1000
   ```

**Explicación**:
Ajustar el paralelismo permite que Spark aproveche al máximo los núcleos disponibles en el clúster, lo que reduce los tiempos de procesamiento. Configurar un número adecuado de particiones para `shuffle` es importante para evitar que las tareas individuales se vuelvan demasiado grandes o pequeñas.

---

### Paso 4: Aplicar Persistencia y Uso de Caché

Persistir datos en la memoria de Spark o usar la caché es una técnica avanzada que permite almacenar temporalmente los resultados intermedios de una consulta para acelerar las ejecuciones posteriores.

**Instrucciones**:

1. **Aplicar caché a una consulta repetida**:

```sql
-- Cachear los datos de ventas filtrados por fecha
CACHE TABLE sales_data_filtered AS
SELECT *
FROM sales_data_partitioned
WHERE sale_date >= '2023-01-01';
```

2. **Ejecutar la consulta cacheada**:

```sql
-- Consulta usando los datos cacheados
SELECT
  store_id,
  SUM(sales_amount) AS total_sales
FROM
  sales_data_filtered
GROUP BY
  store_id;
```

3. **Verificar el uso de caché en Spark UI**:
   - Accede a Spark UI y revisa la pestaña de **Storage** para verificar que los datos han sido cacheados correctamente.
   - Revisa el impacto en el tiempo de ejecución de la consulta tras usar el caché.

**Explicación**:
El uso de caché es útil cuando se realizan múltiples consultas sobre el mismo conjunto de datos. Al persistir los resultados en la memoria, las futuras consultas pueden ejecutarse mucho más rápido al evitar recalcular los resultados.

---

### Paso 5: Evaluar el Rendimiento del Clúster

Finalmente, evaluaremos el rendimiento del clúster después de aplicar las técnicas avanzadas de optimización.

**Instrucciones**:

1. **Ejecutar una consulta compleja sobre el dataset particionado y cacheado**:

```sql
-- Consulta sobre el dataset particionado y cacheado
SELECT
  store_id,
  product_id,
  SUM(sales_amount) AS total_sales,
  AVG(discount_amount) AS avg_discount
FROM
  sales_data_filtered
GROUP BY
  store_id, product_id
ORDER BY
  total_sales DESC;
```

2. **Revisar Spark UI**:
   - Accede a Spark UI y revisa las secciones de **Jobs**, **Stages** y **Executors**.
   - Evalúa si las tareas se están ejecutando en paralelo y si los datos cacheados están siendo reutilizados.

3. **Documentar los resultados**:
   - Compara el tiempo de ejecución y el uso de recursos antes y después de aplicar las técnicas avanzadas de particionamiento, paralelismo y caché.
   - Documenta si hubo mejoras significativas en el rendimiento, especialmente en la reducción del tiempo de ejecución.

**Explicación**:
En este paso, estamos combinando varias técnicas avanzadas para optimizar tanto el uso de recursos como el tiempo de ejecución de las consultas. Revisar Spark UI permite identificar si los cambios han tenido un impacto positivo en el rendimiento general del clúster.

---

### Conclusión del Laboratorio

Este laboratorio ha demostrado cómo utilizar técnicas avanzadas de optimización en Spark, como el particionamiento de datos, el ajuste del paralelismo y el uso de caché, para mejorar el rendimiento de trabajos en Databricks. Estas técnicas son esenciales para manejar grandes volúmenes de datos de manera eficiente y reducir los tiempos de ejecución.

**Recomendaciones**:
- Experimenta con diferentes configuraciones de particionamiento y paralelismo en tu clúster para ver cómo afectan el rendimiento en diferentes escenarios de carga de datos.
- Intenta aplicar estas técnicas en un caso de uso propio y documenta los resultados obtenidos.