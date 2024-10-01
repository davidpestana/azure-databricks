**Escribir y ejecutar código Python en un notebook de Databricks**

### Introducción

Este apartado se centra en cómo aplicar las capacidades de Python de manera eficiente dentro de los notebooks de Databricks, aprovechando las capacidades distribuidas de Apache Spark. Vamos a explorar técnicas y casos de uso prácticos que permiten escalar el procesamiento de datos y realizar análisis avanzados en un entorno empresarial utilizando PySpark, mejorando considerablemente lo que se puede hacer con Python tradicional.

### 1. Maximizar el potencial de Python con PySpark

La integración de Python con Spark en Databricks permite aprovechar las ventajas de ambos. Mientras que Python es ideal para escribir código conciso y claro, Spark permite escalar ese código para procesar grandes volúmenes de datos de manera distribuida.

#### Caso de uso: Procesamiento de datos masivos

Por ejemplo, supón que trabajas con un dataset de ventas que contiene millones de transacciones. Mientras que en Python estándar (usando pandas) esto podría ser lento e ineficiente, con PySpark puedes manejar estos datos sin problemas gracias a su capacidad para distribuir las tareas entre los nodos de un clúster.

```python
# Generar un DataFrame con datos masivos
df_ventas = spark.range(0, 5000000).selectExpr(
    "id as id_venta",
    "cast(rand() * 1000 as int) as id_producto",
    "cast(rand() * 10 + 1 as int) as cantidad",
    "cast(rand() * 100 as double) as precio",
    "date_sub(current_date(), cast(rand() * 100 as int)) as fecha"
)
df_ventas.show(5)
```

**Explicación**: Este código genera un conjunto de datos masivo con 5 millones de filas, donde se simulan transacciones de ventas. El uso de `spark.range` permite generar este tipo de datos de manera eficiente y distribuida.

### 2. Uso de funciones definidas por el usuario (UDFs)

Las UDFs te permiten extender la funcionalidad de Spark con lógica de negocio específica en Python. Esto es útil cuando necesitas aplicar una transformación personalizada que no está disponible de manera nativa en PySpark.

#### Caso de uso: Clasificación de productos por precio

Si trabajas con un conjunto de datos de ventas, podrías necesitar categorizar productos según su rango de precios.

```python
from pyspark.sql.functions import udf
from pyspark.sql.types import StringType

# Definir una función para clasificar productos según el precio
def clasificar_producto(precio):
    if precio < 20:
        return "bajo"
    elif 20 <= precio < 50:
        return "medio"
    else:
        return "alto"

# Registrar la función como UDF
clasificar_udf = udf(clasificar_producto, StringType())

# Aplicar la UDF en el DataFrame
df_ventas = df_ventas.withColumn("categoria_precio", clasificar_udf(df_ventas["precio"]))
df_ventas.show(5)
```

**Explicación**: Esta UDF clasifica los productos en función de su precio. Aunque es útil, las UDFs pueden tener un rendimiento menor que las funciones nativas de Spark, por lo que se recomienda usarlas solo cuando sea absolutamente necesario.

### 3. Uso de funciones nativas y operaciones avanzadas en PySpark

Las funciones nativas de PySpark son más rápidas y eficientes que las UDFs, por lo que se deben priorizar cuando sea posible. Un ejemplo claro es el uso de funciones de agregación y transformación que están optimizadas para el procesamiento distribuido.

#### Caso de uso: Calcular ingresos totales y aplicar descuentos

En un entorno de ventas, es común realizar cálculos de ingresos y aplicar descuentos. En este caso, calculamos el valor total de cada venta y luego aplicamos un descuento del 10%.

```python
from pyspark.sql.functions import col

# Calcular el valor total de la venta
df_ventas = df_ventas.withColumn("valor_total", col("cantidad") * col("precio"))

# Aplicar un descuento del 10% a los productos con valor total mayor a 500
df_ventas_descuento = df_ventas.withColumn("valor_descuento", 
                                           col("valor_total") * 0.9).filter(col("valor_total") > 500)
df_ventas_descuento.show(5)
```

**Explicación**: Aquí estamos calculando el valor total de cada transacción y aplicando un descuento solo a las ventas cuyo valor sea mayor a 500. Usar funciones nativas como `withColumn` y `filter` es eficiente ya que Spark distribuye el cálculo entre los nodos del clúster.

### 4. Aplicación de funciones de ventana (Window Functions)

Las funciones de ventana permiten realizar cálculos avanzados como acumulados, promedios móviles o rankings. Son extremadamente útiles cuando necesitas realizar análisis en un conjunto de datos que debe ser particionado en grupos.

#### Caso de uso: Acumulado de ventas por fecha

Un caso común en análisis de ventas es calcular el acumulado de ventas por día o por categoría de producto.

```python
from pyspark.sql.window import Window
from pyspark.sql.functions import sum

# Definir una ventana para calcular el acumulado de ventas por fecha
window_spec = Window.partitionBy("fecha").orderBy("fecha")

# Calcular el acumulado de ventas por fecha
df_ventas_acumulado = df_ventas.withColumn("acumulado_ventas", sum("valor_total").over(window_spec))
df_ventas_acumulado.show(5)
```

**Explicación**: En este ejemplo, usamos una función de ventana para calcular el acumulado de ventas por fecha. Las funciones de ventana son útiles en análisis temporales o cuando se necesita agregar datos dentro de un grupo específico, como ventas por día o por categoría.

### 5. Optimización del rendimiento en PySpark

Cuando trabajas con grandes volúmenes de datos, es esencial optimizar el rendimiento de tus procesos. PySpark ofrece varias herramientas para hacerlo.

#### a) **Particionamiento de datos**

El particionamiento adecuado de los datos permite distribuir las tareas de manera eficiente entre los nodos del clúster. Si tienes un conjunto de datos desbalanceado, el rendimiento puede verse afectado.

```python
# Repartir el DataFrame en 100 particiones
df_particionado = df_ventas.repartition(100)
```

**Explicación**: Repartir los datos de manera uniforme permite que las tareas se distribuyan mejor en el clúster, evitando sobrecargar algunos nodos mientras otros permanecen inactivos.

#### b) **Caché de datos**

Cuando trabajas con un conjunto de datos que vas a reutilizar en varias partes del proceso, es recomendable almacenarlo en caché para evitar recalcular los resultados.

```python
# Almacenar el DataFrame en caché
df_particionado.cache()
df_particionado.count()  # Activar el caché
```

**Explicación**: Al cachear un DataFrame, lo mantienes en memoria, lo que mejora el rendimiento si necesitas realizar múltiples operaciones sobre los mismos datos.

#### c) **Broadcast para optimizar joins**

Si estás uniendo un conjunto de datos grande con uno pequeño, puedes usar `broadcast` para mejorar el rendimiento de la unión.

```python
from pyspark.sql.functions import broadcast

# Unir un DataFrame pequeño con el DataFrame masivo de ventas
df_productos = spark.read.csv("/mnt/datos/productos.csv", header=True, inferSchema=True)
df_unido = df_ventas.join(broadcast(df_productos), "id_producto")
df_unido.show(5)
```

**Explicación**: `broadcast` permite que el conjunto de datos pequeño se transmita a todos los nodos del clúster, haciendo las uniones mucho más rápidas y eficientes.

### Conclusión

Combinar Python con PySpark en un notebook de Databricks permite realizar análisis avanzados a gran escala, aprovechando las capacidades distribuidas de Spark. Desde la creación de UDFs para lógica personalizada, pasando por el uso de funciones de ventana, hasta la optimización del rendimiento con técnicas como particionamiento y caché, estas técnicas te permiten escalar tus análisis más allá de lo que sería posible con Python estándar.

El uso de estas herramientas en proyectos empresariales y científicos mejora no solo la eficiencia, sino también la capacidad para manejar conjuntos de datos complejos, lo que facilita la obtención de insights valiosos de manera rápida y efectiva.