**Laboratorio: Organización y estructuración de notebooks para proyectos complejos en Databricks**

### Objetivo del laboratorio

En este laboratorio, trabajaremos en un escenario simulado en el que organizarás y estructurarás un notebook de Databricks para un proyecto de análisis de datos masivos en una empresa de e-commerce. Este laboratorio no solo se enfocará en la ejecución de celdas, sino también en cómo estructurar un notebook para un flujo de trabajo realista y escalable, siguiendo las mejores prácticas para manejar grandes volúmenes de datos.

### Contexto del laboratorio

Estás trabajando en el equipo de datos de una empresa de e-commerce, y te han encargado la tarea de analizar las ventas diarias para identificar productos más vendidos, ingresos por categoría de producto y tendencias semanales. Los datos están disponibles en el sistema de almacenamiento de Databricks, y tu objetivo es extraer información de valor utilizando PySpark para procesar millones de transacciones.

### Prerrequisitos

- Acceso a un workspace de Azure Databricks.
- Permisos para crear un clúster en Databricks.

### Paso 1: Crear el notebook y conectar al clúster

#### Instrucciones

1. Accede a tu **workspace de Azure Databricks**.
2. Selecciona **Workspace** en la barra lateral.
3. Haz clic en **Create** (Crear) y selecciona **Notebook**.
4. Nombra el notebook como "Análisis de ventas e-commerce".
5. Selecciona **Python** como lenguaje.
6. Selecciona o crea un **clúster** adecuado para ejecutar el análisis de datos masivos.

**Explicación del paso**: Este notebook será la base de tu proyecto de análisis de ventas. Es importante asignar un nombre claro y descriptivo que permita identificar rápidamente su propósito dentro del proyecto.

### Paso 2: Cargar y explorar los datos de ventas

En este paso, cargarás los datos masivos de ventas simuladas de un e-commerce y realizarás una exploración básica para entender la estructura y el contenido de los datos.

#### Celda 1: Cargar los datos masivos

```python
# Cargar datos masivos simulados de ventas desde almacenamiento de Databricks
df_ventas = spark.range(0, 10000000).selectExpr(
    "id as id_venta",
    "cast(rand() * 1000000 as int) as id_producto",
    "cast(rand() * 50 as int) as cantidad",
    "cast(rand() * 100 as double) as precio",
    "date_sub(current_date(), cast(rand() * 365 as int)) as fecha"
)

df_ventas.show(5)
```

**Por qué crear una celda aquí**: Separar la carga de datos en su propia celda permite que puedas visualizar y verificar los primeros registros del DataFrame antes de proceder con las transformaciones y el análisis. Esto también te da la posibilidad de reutilizar este DataFrame en otras celdas sin tener que volver a cargar los datos.

#### Celda 2: Revisar el esquema de los datos

```python
# Revisar el esquema del DataFrame para entender la estructura de los datos
df_ventas.printSchema()
```

**Por qué crear una celda aquí**: Verificar el esquema del DataFrame es una práctica importante para asegurarte de que los datos se cargaron correctamente y los tipos de datos son los esperados. Esto facilita el diseño de las transformaciones futuras.

### Paso 3: Realizar transformaciones y cálculos iniciales

#### Celda 3: Calcular el valor total de cada venta

En esta celda, calcularás el valor total de cada venta multiplicando la cantidad de productos por su precio.

```python
# Calcular el valor total de cada venta
df_ventas = df_ventas.withColumn("valor_total", col("cantidad") * col("precio"))
df_ventas.show(5)
```

**Por qué crear una celda aquí**: Esta transformación es esencial para agregar valor a los datos, permitiendo calcular los ingresos totales por venta. Al mantenerla separada, puedes evaluar el impacto de este nuevo campo en el análisis sin afectar las operaciones previas.

#### Celda 4: Filtrar las ventas más recientes

En esta celda, filtrarás los datos para concentrarte en las ventas de los últimos 30 días, ya que este período es clave para el análisis de tendencias actuales.

```python
# Filtrar las ventas de los últimos 30 días
df_ventas_recientes = df_ventas.filter(col("fecha") >= date_sub(current_date(), 30))
df_ventas_recientes.show(5)
```

**Por qué crear una celda aquí**: El filtrado de los datos permite centrarte en un conjunto más relevante de ventas recientes, lo cual es útil para realizar análisis de tendencias en períodos cortos. Separar este paso asegura que puedas ajustar los parámetros del filtro sin afectar el resto del análisis.

### Paso 4: Análisis de productos y ventas

#### Celda 5: Identificar los productos más vendidos

Ahora realizarás un análisis para identificar los productos más vendidos en los últimos 30 días, ordenados por cantidad de ventas.

```python
# Agrupar por id_producto y sumar la cantidad de ventas para identificar los más vendidos
df_productos_mas_vendidos = df_ventas_recientes.groupBy("id_producto").sum("cantidad").orderBy(col("sum(cantidad)").desc())
df_productos_mas_vendidos.show(10)
```

**Por qué crear una celda aquí**: La agrupación por producto y el cálculo del total de ventas son operaciones de agregación costosas, y tener esta operación en una celda separada permite concentrarte en este análisis específico sin necesidad de recalcular otras partes del flujo.

#### Celda 6: Calcular los ingresos por producto

En esta celda, sumarás el valor total de ventas por producto, ordenando por los productos que más ingresos han generado.

```python
# Calcular los ingresos por producto
df_ingresos_por_producto = df_ventas_recientes.groupBy("id_producto").sum("valor_total").orderBy(col("sum(valor_total)").desc())
df_ingresos_por_producto.show(10)
```

**Por qué crear una celda aquí**: Al mantener esta operación en una celda separada, puedes ajustar las agrupaciones y el cálculo de ingresos sin necesidad de volver a cargar o transformar los datos. Esto es útil cuando necesitas hacer ajustes rápidos al análisis.

### Paso 5: Análisis de tendencias semanales

#### Celda 7: Agrupar los datos por semana

Realiza un análisis de tendencias semanales agrupando las ventas por semana y calculando el total de ventas por semana.

```python
# Agrupar las ventas por semana y calcular el total
df_ventas_por_semana = df_ventas_recientes.groupBy(weekofyear("fecha").alias("semana")).sum("valor_total").orderBy("semana")
df_ventas_por_semana.show(5)
```

**Por qué crear una celda aquí**: El análisis por semanas permite identificar tendencias clave en el comportamiento de las ventas. Separarlo en una celda ayuda a aislar esta métrica de otras transformaciones, facilitando ajustes en el análisis temporal sin interferir en otros cálculos.

### Paso 6: Guardar los resultados

#### Celda 8: Guardar los resultados del análisis

Finalmente, guarda los resultados del análisis en formato Parquet para futuras consultas y análisis más detallados.

```python
# Guardar los resultados en formato Parquet
df_ingresos_por_producto.write.format("parquet").mode("overwrite").save("/tmp/ingresos_por_producto.parquet")
```

**Por qué crear una celda aquí**: Guardar los resultados es un paso crítico en cualquier análisis. Tener esta operación en su propia celda asegura que puedes guardar los datos sin interferir con el resto del flujo, permitiendo reutilizar los datos en futuras sesiones.

#### Celda 9: Verificar los archivos guardados

En esta celda, verificarás que los datos se hayan guardado correctamente.

```python
# Verificar que los archivos se han guardado
dbutils.fs.ls("/tmp/")
```

**Por qué crear una celda aquí**: Este paso final confirma que los resultados del análisis se guardaron correctamente y están disponibles para futuras consultas o análisis adicionales. Se recomienda mantener esta verificación en su propia celda para poder ejecutar este paso sin necesidad de repetir los análisis.

### Conclusión del laboratorio

Este laboratorio te ha guiado a través de un proceso estructurado para realizar un análisis práctico de datos masivos en un entorno de Databricks, simulando un escenario real de una empresa de e-commerce. Has aprendido a:

- Cargar y explorar grandes conjuntos de datos.
- Realizar transformaciones como cálculos de valor total y filtrado de fechas.
- Identificar productos más vendidos y calcular ingresos por producto.
- Analizar tendencias semanales.
- Guardar los resultados en formato Parquet para su reutilización.

La estructura modular del notebook te permite hacer modificaciones en diferentes puntos del análisis sin tener que repetir todo el flujo, lo que facilita el desarrollo y la depuración en proyectos complejos.