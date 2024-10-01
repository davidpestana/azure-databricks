### **Laboratorio: Aplicar transformaciones complejas a un DataFrame**

### **Objetivo del laboratorio**

El objetivo de este laboratorio es aplicar transformaciones complejas a un **DataFrame** en PySpark, simulando un caso de uso empresarial real. En este laboratorio, trabajaremos con datos de transacciones de una empresa de **retail**, donde transformaremos los datos para obtener un análisis avanzado de ventas, descuentos aplicados, y márgenes de beneficio. Además, exploraremos cómo optimizar estas transformaciones para manejar grandes volúmenes de datos de manera eficiente.

### **Escenario**

Trabajas en el departamento de análisis de una empresa de retail. Se te ha solicitado preparar un informe sobre las ventas recientes, donde se deben incluir:
- **Descuentos aplicados por producto**.
- **Margen de beneficio por cada transacción**.
- **Ingresos totales y netos por cliente**.

Para este análisis, aplicarás transformaciones complejas sobre un gran conjunto de datos y optimizarás el proceso para asegurarte de que sea escalable.

---

### **Paso 1: Cargar y visualizar los datos de ventas**

#### Celda 1: Cargar los datos de transacciones

```python
# Cargar el DataFrame desde un archivo Parquet (puedes utilizar datasets reales disponibles en tu entorno de Databricks)
df_ventas = spark.read.parquet("/mnt/data/transacciones_retail.parquet")

# Mostrar las primeras filas de los datos
df_ventas.show(5)
```

En este paso cargamos un **DataFrame** que contiene los datos de transacciones de ventas. Cada transacción incluye columnas como el **ID del producto**, **ID del cliente**, **cantidad vendida**, **precio de venta**, **costo del producto**, y **descuento aplicado**.

#### Explicación:
- **DataFrame**: Estructura de datos distribuida en PySpark que se utiliza para manejar grandes volúmenes de datos.
- **Parquet**: Formato de archivo altamente eficiente para grandes conjuntos de datos.

---

### **Paso 2: Calcular el descuento aplicado y margen de beneficio**

A continuación, agregaremos dos nuevas columnas: el descuento aplicado en cada transacción y el margen de beneficio. 

#### Celda 2: Calcular el descuento y margen de beneficio

```python
# Calcular el descuento aplicado por transacción
df_ventas = df_ventas.withColumn("descuento_aplicado", df_ventas.precio_venta * df_ventas.descuento / 100)

# Calcular el margen de beneficio
df_ventas = df_ventas.withColumn("margen_beneficio", df_ventas.precio_venta - df_ventas.costo - df_ventas.descuento_aplicado)

# Mostrar los resultados
df_ventas.select("producto_id", "precio_venta", "descuento_aplicado", "margen_beneficio").show(5)
```

#### Explicación:
- **withColumn()**: Añade o reemplaza una columna en el DataFrame. Aquí calculamos los valores de descuento y margen.
- **margen_beneficio**: Calculado como la diferencia entre el precio de venta y el costo del producto, menos el descuento aplicado.

---

### **Paso 3: Agrupar datos por cliente e identificar ingresos totales**

Ahora que hemos calculado los márgenes y descuentos a nivel de transacción, es importante agrupar los datos por cliente para analizar el total de ventas y márgenes.

#### Celda 3: Calcular los ingresos totales y netos por cliente

```python
from pyspark.sql.functions import sum

# Calcular el total de ingresos por cliente
df_ingresos_cliente = df_ventas.groupBy("cliente_id").agg(
    sum("precio_venta").alias("ingreso_total"),
    sum("margen_beneficio").alias("ingreso_neto")
)

# Mostrar los resultados
df_ingresos_cliente.show(5)
```

#### Explicación:
- **groupBy()**: Agrupa los datos por **cliente_id**.
- **sum()**: Calcula los ingresos totales y netos (es decir, después de aplicar márgenes de beneficio).

---

### **Paso 4: Optimización de la transformación con caching**

Dado que las operaciones de agregación pueden ser costosas, utilizaremos **caching** para almacenar los resultados intermedios en memoria y optimizar el rendimiento, especialmente en grandes volúmenes de datos.

#### Celda 4: Cachear los datos para optimizar las consultas posteriores

```python
# Cachear los datos agrupados para evitar recalcular
df_ingresos_cliente.cache()

# Realizar otra consulta rápida usando los datos cacheados
df_ingresos_cliente.filter(df_ingresos_cliente.ingreso_neto > 1000).show(5)
```

#### Explicación:
- **cache()**: Almacena los resultados en memoria, lo que reduce el tiempo de procesamiento en consultas posteriores sobre el mismo conjunto de datos.

---

### **Paso 5: Guardar los resultados optimizados en formato Parquet**

Finalmente, guardaremos los resultados de este análisis en **formato Parquet**, optimizado para grandes volúmenes de datos. Esto permitirá que otros equipos o procesos reutilicen estos datos en futuras consultas.

#### Celda 5: Guardar los resultados en formato Parquet

```python
# Guardar el DataFrame optimizado en Parquet
output_path = "/mnt/data/ingresos_cliente.parquet"
df_ingresos_cliente.write.parquet(output_path, mode="overwrite")

# Verificar que el archivo se ha guardado correctamente
display(dbutils.fs.ls("/mnt/data/"))
```

#### Explicación:
- **write.parquet()**: Guarda los resultados en formato **Parquet**, que es eficiente en términos de almacenamiento y lectura.
- **overwrite**: Sobrescribe cualquier archivo existente en el mismo directorio.

---

### **Conclusión del laboratorio**

En este laboratorio, has aprendido a:

1. **Aplicar transformaciones complejas** como el cálculo de descuentos y márgenes de beneficio en un DataFrame de transacciones.
2. **Agrupar los datos por cliente** y calcular ingresos totales y netos a partir de las transformaciones.
3. **Optimizar el proceso utilizando caching** para mejorar el rendimiento de las consultas sobre grandes volúmenes de datos.
4. **Guardar los resultados** en formato Parquet para su reutilización eficiente en futuros análisis.

Estas técnicas de transformación y optimización son esenciales en un entorno empresarial para manejar grandes conjuntos de datos y realizar análisis detallados sin comprometer el rendimiento.