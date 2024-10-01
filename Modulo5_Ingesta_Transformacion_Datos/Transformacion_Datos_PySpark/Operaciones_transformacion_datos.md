### **Operaciones de transformación**

En el contexto empresarial, las operaciones de transformación en **PySpark** permiten convertir, agregar o modificar los datos para que sean útiles en análisis avanzados y aplicaciones de negocio. Estas transformaciones son clave en sectores como ventas, marketing, logística y finanzas, donde los grandes volúmenes de datos necesitan ser procesados de manera eficiente y precisa.

#### **Caso de uso 1: Enriquecimiento de datos en un pipeline de ETL**

En una empresa de retail, los datos de transacciones de ventas pueden requerir transformaciones para enriquecer la información antes de almacenarla en un **Data Warehouse**. Por ejemplo:

- **Filtrar datos**: Filtrar ventas por regiones específicas o por categorías de productos clave para análisis regional.
- **Agregar columnas calculadas**: Agregar una columna calculada de descuento aplicado en las ventas para obtener el margen de beneficio.
- **Conversión de datos**: Convertir valores de divisas internacionales en una moneda base (por ejemplo, convertir todas las ventas a euros o dólares).

Ejemplo:

```python
# Filtrar transacciones solo de la región "Europa"
df_europa = df_ventas.filter(df_ventas.region == "Europa")

# Calcular el margen de beneficio en base al precio y el costo
df_con_margen = df_europa.withColumn("margen_beneficio", df_ventas.precio_venta - df_ventas.costo)

# Convertir todas las ventas a euros (suponiendo tasa de conversión)
df_europa = df_con_margen.withColumn("precio_euro", df_con_margen.precio_venta * 0.85)
```

#### **Caso de uso 2: Transformación para la creación de modelos predictivos**

En una empresa de seguros, los datos sin procesar pueden no estar en un formato adecuado para la creación de modelos predictivos. Las operaciones de transformación permiten preparar los datos para su uso en modelos de machine learning, como el tratamiento de valores nulos, creación de variables dummies, y normalización.

Ejemplo:

```python
from pyspark.ml.feature import Imputer, StringIndexer

# Imputar valores nulos en la columna de edad con la media
imputer = Imputer(inputCols=["edad"], outputCols=["edad_imputada"]).setStrategy("mean")
df_imputado = imputer.fit(df_asegurados).transform(df_asegurados)

# Convertir la columna "género" en índices numéricos para el modelo predictivo
indexer = StringIndexer(inputCol="genero", outputCol="genero_index")
df_indexado = indexer.fit(df_imputado).transform(df_imputado)
```

#### **Caso de uso 3: Agrupación de datos para análisis financiero**

En el ámbito financiero, una tarea común es agrupar datos de operaciones o transacciones por clientes, fechas, o categorías para generar informes o análisis. Las transformaciones de agregación son utilizadas para obtener insights como la suma total de transacciones, promedio de ventas por cliente, o distribución de gastos por categoría.

Ejemplo:

```python
# Agrupar transacciones por cliente y calcular el total gastado por cada uno
df_total_por_cliente = df_transacciones.groupBy("cliente_id").agg(sum("total").alias("total_gastado"))

# Agrupar por categoría de productos y calcular el gasto promedio
df_promedio_por_categoria = df_transacciones.groupBy("categoria").agg(avg("total").alias("gasto_promedio"))
```

Estas operaciones de transformación son aplicadas frecuentemente para mejorar la calidad de los datos, optimizar su estructura y hacerlos útiles para diferentes aplicaciones de negocio.