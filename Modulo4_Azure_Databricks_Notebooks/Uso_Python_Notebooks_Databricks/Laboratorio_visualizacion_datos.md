**Laboratorio: Integración de bibliotecas externas y visualización de datos con matplotlib**

### Objetivo del laboratorio

El objetivo de este laboratorio es aprender a integrar bibliotecas populares de Python, como **matplotlib**, en un notebook de Databricks y generar visualizaciones detalladas a partir de un conjunto de datos masivo. Además, realizarás múltiples cálculos con PySpark y analizarás los resultados de varias maneras antes de visualizarlos.

### Prerrequisitos

- Acceso a un workspace de Azure Databricks.
- Permisos para crear y ejecutar un clúster en Databricks.
- Familiaridad con **matplotlib** y PySpark.

### Paso 1: Crear un nuevo notebook en Azure Databricks

#### Instrucciones

1. Accede a tu **workspace de Azure Databricks**.
2. Selecciona **Workspace** en la barra lateral.
3. Haz clic en **Create** (Crear) y selecciona **Notebook**.
4. Nombra el notebook como "Laboratorio - Visualización con Matplotlib".
5. Selecciona **Python** como lenguaje.
6. Selecciona o crea un **clúster** adecuado para la ejecución.

### Paso 2: Generar un conjunto de datos masivo en PySpark

#### Celda 1: Generar datos de ventas simulados

En esta primera celda, generaremos un conjunto de datos masivo que simule ventas de productos. Este conjunto de datos servirá como base para las visualizaciones. Además, vamos a incluir una categoría de producto para que las visualizaciones sean más interesantes.

```python
# Generar un DataFrame masivo con datos simulados de ventas
df_ventas = spark.range(0, 10000000).selectExpr(
    "id as id_venta",
    "cast(rand() * 1000 as int) as id_producto",
    "cast(rand() * 10 + 1 as int) as cantidad",
    "cast(rand() * 100 as double) as precio",
    "date_sub(current_date(), cast(rand() * 365 as int)) as fecha",
    "CASE WHEN id % 3 = 0 THEN 'Electrónica' WHEN id % 3 = 1 THEN 'Ropa' ELSE 'Hogar' END as categoria"
)

df_ventas.show(5)
```

**Explicación del paso**: Este código genera un conjunto de datos masivo de 10 millones de registros, simulando las ventas de productos en tres categorías diferentes: **Electrónica**, **Ropa** y **Hogar**. Usamos `spark.range` para generar los datos de manera distribuida y eficiente.

### Paso 3: Calcular ingresos totales por producto y categoría

En este paso, realizaremos múltiples cálculos para obtener los ingresos totales por producto y también agregaremos estos datos por categoría de producto.

#### Celda 2: Cálculo de ingresos totales

```python
# Calcular el valor total de cada venta
df_ventas = df_ventas.withColumn("valor_total", df_ventas["cantidad"] * df_ventas["precio"])

# Agrupar por id_producto y calcular el total de ingresos por producto
df_ingresos_por_producto = df_ventas.groupBy("id_producto").sum("valor_total").orderBy("sum(valor_total)", ascending=False)
df_ingresos_por_producto.show(5)

# Agrupar por categoría de producto y calcular el total de ingresos por categoría
df_ingresos_por_categoria = df_ventas.groupBy("categoria").sum("valor_total").orderBy("sum(valor_total)", ascending=False)
df_ingresos_por_categoria.show(5)
```

**Explicación del paso**: Primero, calculamos los ingresos totales por producto sumando el total de ventas (`cantidad * precio`). Luego, agregamos estos datos por **categoría de producto** para obtener los ingresos totales por cada una de las tres categorías.

### Paso 4: Filtrar productos por rango de ingresos y analizar las categorías

Aquí vamos a realizar más análisis para entender mejor los datos. Vamos a filtrar los productos en diferentes rangos de ingresos y analizaremos qué categorías tienen productos con los ingresos más altos.

#### Celda 3: Filtrar productos por rango de ingresos

```python
# Filtrar productos con ingresos superiores a 10,000
df_productos_ingresos_altos = df_ingresos_por_producto.filter(df_ingresos_por_producto["sum(valor_total)"] > 10000)
df_productos_ingresos_altos.show(5)

# Filtrar productos con ingresos entre 1,000 y 10,000
df_productos_ingresos_medios = df_ingresos_por_producto.filter((df_ingresos_por_producto["sum(valor_total)"] > 1000) & 
                                                               (df_ingresos_por_producto["sum(valor_total)"] <= 10000))
df_productos_ingresos_medios.show(5)

# Filtrar productos con ingresos inferiores a 1,000
df_productos_ingresos_bajos = df_ingresos_por_producto.filter(df_ingresos_por_producto["sum(valor_total)"] <= 1000)
df_productos_ingresos_bajos.show(5)
```

**Explicación del paso**: Hemos separado los productos en tres grupos según sus ingresos totales: **ingresos altos**, **ingresos medios** y **ingresos bajos**. Esto nos permitirá visualizar mejor los productos más rentables y los que generan menores ingresos.

### Paso 5: Convertir los datos a pandas para visualización

Para poder visualizar los resultados con **matplotlib**, convertiremos los datos agregados a un DataFrame de pandas. Realizaremos visualizaciones tanto de los productos como de las categorías.

#### Celda 4: Convertir a pandas

```python
# Convertir el DataFrame de Spark a pandas para visualización
df_ingresos_pd = df_ingresos_por_producto.limit(100).toPandas()  # Limitamos a 100 productos para una mejor visualización
df_ingresos_categoria_pd = df_ingresos_por_categoria.toPandas()
```

**Explicación del paso**: Convertimos los resultados a pandas para poder generar las visualizaciones. Limitamos el número de productos a 100 para no sobrecargar los gráficos y hacer la visualización más manejable.

### Paso 6: Visualizar los resultados con matplotlib

Vamos a crear varias visualizaciones para entender mejor los datos de ventas por producto y por categoría.

#### Celda 5: Crear gráficos de barras para ingresos por producto y por categoría

```python
import matplotlib.pyplot as plt

# Visualizar ingresos por producto (gráfico de barras)
plt.figure(figsize=(12,6))
plt.bar(df_ingresos_pd['id_producto'], df_ingresos_pd['sum(valor_total)'], color='blue')
plt.title('Ingresos Totales por Producto')
plt.xlabel('ID Producto')
plt.ylabel('Ingresos Totales')
plt.show()

# Visualizar ingresos totales por categoría (gráfico de barras)
plt.figure(figsize=(8,5))
plt.bar(df_ingresos_categoria_pd['categoria'], df_ingresos_categoria_pd['sum(valor_total)'], color=['red', 'green', 'orange'])
plt.title('Ingresos Totales por Categoría')
plt.xlabel('Categoría de Producto')
plt.ylabel('Ingresos Totales')
plt.show()
```

**Explicación del paso**: Generamos dos gráficos de barras. El primero muestra los ingresos totales por producto, lo que nos permite identificar los productos más rentables. El segundo gráfico agrupa los ingresos por categoría, lo que da una visión más general de qué categorías son más lucrativas.

### Paso 7: Guardar los resultados

Para finalizar, guardaremos los resultados de los ingresos totales por producto y por categoría en formato Parquet para futuras consultas.

#### Celda 6: Guardar los datos en Parquet

```python
# Guardar el DataFrame de ingresos por producto en formato Parquet
df_ingresos_por_producto.write.format("parquet").mode("overwrite").save("/mnt/datos/ingresos_por_producto.parquet")

# Guardar el DataFrame de ingresos por categoría en formato Parquet
df_ingresos_por_categoria.write.format("parquet").mode("overwrite").save("/mnt/datos/ingresos_por_categoria.parquet")
```

**Explicación del paso**: Guardamos los resultados en formato **Parquet** para que puedan ser reutilizados en futuras sesiones sin necesidad de recalcular los datos.

### Paso 8: Verificar los archivos guardados

Vamos a verificar que los archivos se hayan guardado correctamente en el sistema de archivos de Databricks.

#### Celda 7: Verificar los archivos guardados

```python
# Verificar los archivos guardados
dbutils.fs.ls("/mnt/datos/")
```

**Explicación del paso**: Este paso es importante para asegurarnos de que los archivos se hayan guardado correctamente y estén disponibles para futuras consultas.

### Conclusión del laboratorio

En este laboratorio has aprendido a:

- Generar un conjunto de datos masivo en PySpark con diferentes categorías de productos.
- Realizar múltiples cálculos de ingresos totales por producto y por categoría.
- Filtrar productos por rangos de ingresos para un análisis más detallado.
- Convertir los resultados a pandas para visualización.
- Utilizar **matplotlib** para crear gráficos detallados de ingresos por producto y por categoría.
- Guardar los resultados en formato Parquet para su uso futuro.

Este laboratorio proporciona una comprensión profunda de cómo utilizar las bibliotecas de visualización y procesamiento de Python junto con PySpark para manejar grandes volúmenes de datos y generar análisis detallados en Databricks.