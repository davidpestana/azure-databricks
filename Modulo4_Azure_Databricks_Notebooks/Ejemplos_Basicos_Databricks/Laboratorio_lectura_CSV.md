### **Laboratorio: Leer datos desde un archivo CSV**

### **Objetivo del laboratorio**

En este laboratorio, trabajaremos con un archivo CSV que contiene datos de ventas de una empresa de retail. El objetivo es aprender a leer estos datos, validar su calidad, realizar transformaciones y guardar los resultados en un formato más eficiente para su posterior análisis.

### **Escenario empresarial**

Imagina que trabajas en el equipo de análisis de datos de una cadena de retail. Tu tarea es procesar un archivo CSV que contiene información de ventas de productos en diferentes categorías. Tu equipo necesita preparar estos datos para un análisis más detallado que ayude a identificar las categorías de productos más rentables.

### **Paso 1: Crear un nuevo notebook en Azure Databricks**

#### Instrucciones

1. Accede a tu **workspace de Azure Databricks**.
2. Selecciona **Workspace** en la barra lateral.
3. Haz clic en **Create** (Crear) y selecciona **Notebook**.
4. Nombra el notebook como "Laboratorio - Análisis de Ventas CSV".
5. Selecciona **Python** como lenguaje.
6. Selecciona o crea un **clúster** adecuado para ejecutar el análisis.

### **Paso 2: Generar el dataset de ventas simulado**

Para simular un escenario empresarial real, generaremos un conjunto de datos masivo que represente las ventas de productos en diferentes categorías. Este dataset incluirá información sobre el producto, su precio, cantidad vendida, categoría y fecha de venta.

#### Celda 1: Generar los datos de ventas

```python
# Generar un DataFrame masivo con datos simulados de ventas
df_ventas = spark.range(0, 1000000).selectExpr(
    "id as id_venta",
    "cast(rand() * 1000 as int) as id_producto",
    "cast(rand() * 100 + 10 as double) as precio",  # Precios entre 10 y 110
    "cast(rand() * 10 + 1 as int) as cantidad",  # Cantidades entre 1 y 10
    "CASE WHEN id % 3 = 0 THEN 'Electrónica' WHEN id % 3 = 1 THEN 'Hogar' ELSE 'Ropa' END as categoria",
    "date_sub(current_date(), cast(rand() * 365 as int)) as fecha"
)

# Mostrar los primeros 5 registros
df_ventas.show(5)
```

### **Paso 3: Guardar el dataset en formato CSV**

Simulamos un escenario donde el equipo de ventas entrega el dataset en formato CSV. Guardaremos el conjunto de datos en este formato para replicar esa situación.

#### Celda 2: Guardar el dataset en CSV

```python
# Guardar los datos en formato CSV
df_ventas.write.format("csv").mode("overwrite").save("/mnt/retail/ventas_simuladas.csv")
```

### **Paso 4: Leer los datos desde el archivo CSV**

Ahora que tenemos un archivo CSV, lo leeremos y verificaremos que los datos se hayan cargado correctamente.

#### Celda 3: Leer el archivo CSV

```python
# Leer los datos desde el archivo CSV
df_ventas_csv = spark.read.csv("/mnt/retail/ventas_simuladas.csv", header=True, inferSchema=True)

# Mostrar los primeros 5 registros
df_ventas_csv.show(5)
```

### **Paso 5: Validar la calidad de los datos**

Antes de realizar el análisis, es importante validar los datos. Verificaremos si hay valores nulos en columnas clave como **id_producto**, **precio** y **cantidad**.

#### Celda 4: Verificar valores nulos

```python
# Verificar si hay valores nulos en columnas clave
nulos_id_producto = df_ventas_csv.filter(df_ventas_csv["id_producto"].isNull()).count()
nulos_precio = df_ventas_csv.filter(df_ventas_csv["precio"].isNull()).count()
nulos_cantidad = df_ventas_csv.filter(df_ventas_csv["cantidad"].isNull()).count()

print(f"Registros con id_producto nulo: {nulos_id_producto}")
print(f"Registros con precio nulo: {nulos_precio}")
print(f"Registros con cantidad nula: {nulos_cantidad}")
```

### **Paso 6: Limpiar los datos**

En este paso, eliminaremos los registros con valores nulos en las columnas clave para garantizar que los datos estén listos para análisis.

#### Celda 5: Eliminar valores nulos

```python
# Eliminar registros con valores nulos
df_ventas_limpio = df_ventas_csv.dropna(subset=["id_producto", "precio", "cantidad"])

# Mostrar los primeros 5 registros del DataFrame limpio
df_ventas_limpio.show(5)
```

### **Paso 7: Realizar transformaciones**

Ahora calcularemos el valor total de cada venta (precio * cantidad) y agruparemos los datos por categoría de producto para analizar el rendimiento por categoría.

#### Celda 6: Calcular ingresos y agrupar por categoría

```python
# Calcular el valor total de cada venta
df_ventas_limpio = df_ventas_limpio.withColumn("valor_total", df_ventas_limpio["precio"] * df_ventas_limpio["cantidad"])

# Agrupar por categoría y sumar los ingresos
df_ingresos_categoria = df_ventas_limpio.groupBy("categoria").sum("valor_total")

# Mostrar los ingresos por categoría
df_ingresos_categoria.show()
```

### **Paso 8: Guardar los resultados en formato Parquet**

Para optimizar el almacenamiento y las consultas futuras, guardaremos los resultados en formato Parquet.

#### Celda 7: Guardar en Parquet

```python
# Guardar los ingresos por categoría en formato Parquet
df_ingresos_categoria.write.format("parquet").mode("overwrite").save("/mnt/retail/ingresos_por_categoria.parquet")
```

---

### **Conclusión del laboratorio**

En este laboratorio has aprendido a:

- Generar datos masivos simulados con **Spark** para representar un escenario real de ventas.
- Leer datos desde un archivo CSV y validarlos.
- Limpiar los datos eliminando valores nulos.
- Realizar transformaciones como calcular ingresos por venta y agrupar por categoría de producto.
- Guardar los resultados en un formato eficiente para consultas futuras.

Este proceso es esencial en escenarios empresariales para garantizar que los datos estén listos para análisis detallados que apoyen la toma de decisiones estratégicas.