**Laboratorio: Escribir funciones Python dentro de un notebook en Databricks**

### Objetivo del laboratorio

En este laboratorio, aprenderás a escribir y ejecutar funciones personalizadas en Python dentro de un notebook en Databricks. También aplicarás estas funciones a datos masivos utilizando PySpark, lo que te permitirá realizar cálculos complejos y aplicar lógica personalizada de manera eficiente en un entorno distribuido.

### Prerrequisitos

- Acceso a un workspace de Azure Databricks.
- Permisos para crear y ejecutar un clúster en Databricks.
- Conocimiento básico de Python y PySpark.

### Paso 1: Crear un nuevo notebook en Azure Databricks

#### Instrucciones

1. Accede a tu **workspace de Azure Databricks**.
2. Selecciona **Workspace** en la barra lateral.
3. Haz clic en **Create** (Crear) y selecciona **Notebook**.
4. Asigna un nombre como "Laboratorio - Funciones Python en PySpark".
5. Selecciona **Python** como lenguaje.
6. Selecciona o crea un **clúster** adecuado para ejecutar el análisis de datos masivos.

**Explicación del paso**: Este notebook será el entorno donde escribirás y ejecutarás funciones personalizadas en Python, las cuales luego aplicarás a un conjunto de datos utilizando PySpark. La creación del notebook es el primer paso fundamental para organizar tu trabajo de manera eficiente.

### Paso 2: Generar datos masivos en PySpark

#### Celda 1: Generar un conjunto de datos de ventas

Para practicar la aplicación de funciones, primero necesitas un conjunto de datos. Vamos a generar un DataFrame masivo que simula las ventas de productos.

```python
# Generar un DataFrame masivo con datos simulados de ventas
df_ventas = spark.range(0, 10000000).selectExpr(
    "id as id_venta",
    "cast(rand() * 1000 as int) as id_producto",
    "cast(rand() * 10 + 1 as int) as cantidad",
    "cast(rand() * 100 as double) as precio",
    "date_sub(current_date(), cast(rand() * 365 as int)) as fecha"
)

df_ventas.show(5)
```

**Por qué crear una celda aquí**: Este paso es esencial para generar un conjunto de datos masivo sobre el cual trabajar. El uso de `spark.range` es eficiente para generar millones de filas de datos distribuidos que representan transacciones de ventas, lo que permite realizar pruebas realistas sobre grandes volúmenes de datos.

### Paso 3: Escribir una función Python personalizada

En este paso, escribirás una función en Python que será utilizada para calcular un valor adicional sobre los datos de ventas. La función se aplicará a cada fila del DataFrame, transformando la columna `precio` para reflejar un impuesto del 15%.

#### Celda 2: Definir la función en Python

```python
# Definir una función para aplicar un impuesto del 15% al precio
def aplicar_impuesto(precio):
    return precio * 1.15
```

**Por qué crear una celda aquí**: Esta celda contiene una función simple que encapsula la lógica de negocio (aplicar un impuesto). Tener esta función en una celda separada permite que se pueda reutilizar en cualquier parte del notebook.

#### Celda 3: Registrar la función como una UDF en PySpark

Para aplicar la función en un entorno distribuido con PySpark, necesitamos convertirla en una UDF (User Defined Function).

```python
from pyspark.sql.functions import udf
from pyspark.sql.types import DoubleType

# Registrar la función como UDF
udf_aplicar_impuesto = udf(aplicar_impuesto, DoubleType())
```

**Por qué crear una celda aquí**: Registrar la función como UDF permite que se aplique en el DataFrame distribuido. Este paso es crucial, ya que PySpark no puede ejecutar funciones de Python directamente en su entorno distribuido sin convertirlas a UDFs.

### Paso 4: Aplicar la función a los datos masivos

Ahora que tienes la función registrada, puedes aplicarla a los datos de ventas para calcular el precio final de cada producto con el impuesto añadido.

#### Celda 4: Aplicar la UDF al DataFrame

```python
# Aplicar la UDF para calcular el precio con impuesto
df_ventas_con_impuesto = df_ventas.withColumn("precio_con_impuesto", udf_aplicar_impuesto(df_ventas["precio"]))
df_ventas_con_impuesto.show(5)
```

**Por qué crear una celda aquí**: Aplicar la UDF en una celda separada permite observar cómo la función personalizada afecta el DataFrame. Esto es útil para verificar que la lógica se ha aplicado correctamente sin interferir con el resto de las transformaciones.

### Paso 5: Calcular el valor total de ventas con el precio modificado

En esta etapa, utilizarás la nueva columna `precio_con_impuesto` para calcular el valor total de cada transacción.

#### Celda 5: Calcular el valor total

```python
# Calcular el valor total de cada venta (cantidad * precio con impuesto)
df_ventas_total = df_ventas_con_impuesto.withColumn("valor_total", df_ventas_con_impuesto["cantidad"] * df_ventas_con_impuesto["precio_con_impuesto"])
df_ventas_total.show(5)
```

**Por qué crear una celda aquí**: Este cálculo utiliza la columna con el impuesto aplicado para obtener el valor total de las ventas. Separarlo en una celda adicional permite realizar este cálculo sin necesidad de volver a aplicar la UDF.

### Paso 6: Guardar los resultados en formato Parquet

Una vez realizado el cálculo, es recomendable almacenar los resultados en un formato eficiente como Parquet para futuras consultas.

#### Celda 6: Guardar el DataFrame transformado

```python
# Guardar el DataFrame en formato Parquet
df_ventas_total.write.format("parquet").mode("overwrite").save("/mnt/datos/ventas_con_impuesto.parquet")
```

**Por qué crear una celda aquí**: Guardar los resultados es un paso esencial en cualquier flujo de trabajo de datos. Al almacenarlo en Parquet, puedes consultar los datos en futuras sesiones sin tener que recalcular los valores.

#### Celda 7: Verificar los archivos guardados

```python
# Verificar los archivos guardados
dbutils.fs.ls("/mnt/datos/")
```

**Por qué crear una celda aquí**: Este paso permite asegurarte de que los datos han sido guardados correctamente. También es útil para verificar la ruta de acceso a los archivos en caso de que necesites cargar los resultados en el futuro.

### Conclusión del laboratorio

En este laboratorio, has aprendido a:

- Escribir funciones personalizadas en Python dentro de un notebook de Databricks.
- Registrar estas funciones como UDFs para aplicarlas a datos masivos con PySpark.
- Aplicar estas funciones para transformar datos en un entorno distribuido.
- Guardar los resultados en formato Parquet para su uso futuro.

Este laboratorio te ha permitido ver cómo combinar las capacidades de Python y PySpark para ejecutar análisis avanzados en un entorno de datos masivos, optimizando tanto el rendimiento como la escalabilidad de tus proyectos en Databricks.