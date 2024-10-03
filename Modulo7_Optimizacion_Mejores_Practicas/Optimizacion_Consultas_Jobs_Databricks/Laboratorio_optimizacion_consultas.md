### Laboratorio: Optimización de una Consulta SQL Compleja

#### Objetivo:
En este laboratorio, los estudiantes aprenderán a optimizar una consulta SQL compleja ejecutada en un clúster de Databricks. El objetivo es reducir el tiempo de ejecución de la consulta aplicando técnicas como el uso de índices, particionamiento, caché, y el análisis detallado del plan de ejecución mediante Spark UI.

#### Requisitos Previos:
- Tener acceso a un clúster Databricks con un conjunto de datos de tamaño considerable (más de 10 millones de registros) para realizar pruebas de rendimiento.
- Familiaridad con Spark SQL y la ejecución de consultas en Databricks.

---

#### Paso 1: Preparación del Dataset

Antes de comenzar con la optimización, crearemos un dataset lo suficientemente grande para que se pueda observar una mejora significativa en el rendimiento tras aplicar las optimizaciones.

##### Crear una tabla de gran tamaño

**Instrucciones**: Copia el siguiente código en una celda nueva para generar un dataset grande. Este dataset simula datos de ventas, con múltiples registros por cada cliente, producto y tienda.

```sql
-- Crear una tabla grande de ejemplo
CREATE OR REPLACE TABLE sales_data AS
SELECT
  CAST(rand() * 1000000 AS int) AS customer_id,
  CAST(rand() * 1000 AS int) AS store_id,
  CAST(rand() * 5000 AS int) AS product_id,
  CAST(rand() * 1000 AS int) AS sales_amount,
  CAST(rand() * 1000 AS int) AS discount_amount,
  CAST(rand() * 5 AS int) AS quantity,
  date_add(current_date(), -CAST(rand() * 3650 AS int)) AS sale_date
FROM
  RANGE(10000000); -- Genera 10 millones de registros
```

**Explicación**:
Esta consulta genera una tabla llamada `sales_data` con 10 millones de registros, simulando ventas en distintas tiendas. A partir de aquí, se ejecutarán las consultas de ejemplo.

---

#### Paso 2: Ejecución de una Consulta SQL Compleja

Ahora ejecutaremos una consulta SQL compleja sobre esta tabla sin aplicar ninguna optimización inicial. El propósito es observar el comportamiento de la consulta y usar el Spark UI para identificar áreas de mejora.

##### Ejecutar la consulta sin optimizar

**Instrucciones**: Ejecuta la siguiente consulta sin optimización en una nueva celda.

```sql
-- Consulta sin optimización
SELECT
  store_id,
  product_id,
  SUM(sales_amount) AS total_sales,
  AVG(discount_amount) AS avg_discount,
  COUNT(quantity) AS total_quantity
FROM
  sales_data
WHERE
  sale_date >= '2023-01-01'
GROUP BY
  store_id, product_id
ORDER BY
  total_sales DESC;
```

**Explicación**:
Esta consulta agrupa las ventas por tienda y producto, calcula la suma de ventas, el promedio de descuento y el total de productos vendidos para las ventas realizadas desde el 1 de enero de 2023. La consulta finaliza con un `ORDER BY` para obtener los productos más vendidos.

#### Análisis inicial con Spark UI:

1. **Accede a Spark UI**:
   - Una vez que ejecutes la consulta, haz clic en el ícono de **Ver Detalles** (en la parte superior derecha de la celda) para abrir el Spark UI.
   - Revisa las secciones de **Stages** y **Tasks** para identificar posibles cuellos de botella. Especialmente, presta atención al tiempo de ejecución de las etapas y la cantidad de datos que se están procesando en cada etapa.

2. **Evaluación del rendimiento**:
   - Revisa si el tamaño de las particiones es adecuado y si la etapa de `shuffle` está tomando mucho tiempo. Esto suele ocurrir cuando hay demasiadas o muy pocas particiones.

---

#### Paso 3: Aplicar la Primera Optimización (Filtro Temprano)

Uno de los primeros pasos para optimizar una consulta es aplicar los filtros lo antes posible. Esto reduce el conjunto de datos que Spark tiene que procesar y puede mejorar el rendimiento de manera significativa.

##### Aplicar filtrado temprano

**Instrucciones**: Modifica la consulta para que aplique los filtros de forma más eficiente.

```sql
-- Consulta optimizada con filtrado temprano
WITH FilteredSales AS (
  SELECT *
  FROM sales_data
  WHERE sale_date >= '2023-01-01'
)
SELECT
  store_id,
  product_id,
  SUM(sales_amount) AS total_sales,
  AVG(discount_amount) AS avg_discount,
  COUNT(quantity) AS total_quantity
FROM
  FilteredSales
GROUP BY
  store_id, product_id
ORDER BY
  total_sales DESC;
```

**Explicación**:
En esta versión, se filtran los datos antes de realizar cualquier agregación o `GROUP BY`, reduciendo el número de registros que Spark necesita procesar. Esto puede ahorrar tiempo si hay muchas filas que no cumplen con el filtro.

---

#### Paso 4: Aplicar Particionamiento y Uso de Índices

El siguiente paso es aprovechar el particionamiento para mejorar el rendimiento. Particionar los datos permite a Spark procesar particiones individuales en paralelo, mejorando el rendimiento.

##### Crear una tabla particionada

**Instrucciones**: Crea una nueva tabla particionada por la columna `sale_date`.

```sql
-- Crear una tabla particionada
CREATE OR REPLACE TABLE sales_data_partitioned
USING PARQUET
PARTITIONED BY (sale_date)
AS SELECT * FROM sales_data;
```

##### Ejecutar la consulta optimizada en tabla particionada

**Instrucciones**: Vuelve a ejecutar la consulta, esta vez usando la tabla particionada.

```sql
-- Consulta optimizada en tabla particionada
SELECT
  store_id,
  product_id,
  SUM(sales_amount) AS total_sales,
  AVG(discount_amount) AS avg_discount,
  COUNT(quantity) AS total_quantity
FROM
  sales_data_partitioned
WHERE
  sale_date >= '2023-01-01'
GROUP BY
  store_id, product_id
ORDER BY
  total_sales DESC;
```

**Explicación**:
Al usar una tabla particionada, Spark puede acceder más rápidamente a los datos que corresponden al filtro de fecha. Las particiones que no están incluidas en la consulta se ignoran por completo, mejorando el rendimiento.

---

#### Paso 5: Utilizar Caché para Consultas Repetidas

Si tienes consultas que se ejecutan repetidamente sobre el mismo conjunto de datos, puedes utilizar la caché de Spark para almacenar temporalmente los resultados y acelerar las siguientes consultas.

##### Aplicar caché a los datos filtrados

**Instrucciones**: Usa la caché para mejorar el rendimiento de consultas repetidas.

```sql
-- Cachear los datos filtrados
CACHE TABLE FilteredSales AS
SELECT *
FROM sales_data_partitioned
WHERE sale_date >= '2023-01-01';

-- Consulta usando caché
SELECT
  store_id,
  product_id,
  SUM(sales_amount) AS total_sales,
  AVG(discount_amount) AS avg_discount,
  COUNT(quantity) AS total_quantity
FROM
  FilteredSales
GROUP BY
  store_id, product_id
ORDER BY
  total_sales DESC;
```

**Explicación**:
Con esta técnica, Spark almacenará en memoria el conjunto de datos filtrado, evitando tener que leer y procesar la tabla completa en futuras consultas. Esto es útil cuando se repiten las consultas sobre el mismo subconjunto de datos.

---

#### Paso 6: Analizar los Resultados en Spark UI

1. **Volver a Spark UI**: Accede nuevamente a Spark UI tras aplicar estas optimizaciones.
   - Compara el tiempo total de ejecución y el uso de recursos con la consulta original.
   - Revisa la sección de **Stages** para verificar si los tiempos de ejecución se han reducido y si el tamaño de las particiones ahora está más balanceado.
   
2. **Evaluar el Impacto**: 
   - Analiza si el uso de particiones y caché ha mejorado significativamente el tiempo de respuesta.
   - Observa los cambios en la distribución de las tareas y si los datos ahora se procesan de manera más eficiente.

---

#### Conclusión:

Este laboratorio ha demostrado cómo aplicar técnicas de optimización en una consulta SQL compleja en Databricks. Al usar filtros tempranos, particiones, y caché, se puede mejorar drásticamente el rendimiento de las consultas, especialmente en grandes volúmenes de datos. Utilizar herramientas como Spark UI es fundamental para identificar cuellos de botella y ajustar las configuraciones de manera adecuada.