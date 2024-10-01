**Laboratorio: Crear un nuevo notebook en Databricks**

### Objetivo del laboratorio

El objetivo de este laboratorio es aprender a crear y configurar un notebook en Azure Databricks, generar y trabajar con datos masivos utilizando PySpark, y realizar operaciones de transformación y análisis sobre los datos. Durante este proceso, indicaremos claramente cuándo crear nuevas celdas y qué partes del código deben ir en cada una, explicando el porqué de esas divisiones.

### Prerrequisitos

- Acceso a un workspace de Azure Databricks.
- Permisos para crear y ejecutar un clúster en Databricks.

### Paso 1: Crear un nuevo notebook en Azure Databricks

#### Instrucciones

1. Accede a tu **workspace de Azure Databricks** y selecciona **Workspace** en la barra lateral.
2. Haz clic en **Create** (Crear) y selecciona **Notebook**.
3. Asigna un nombre a tu notebook, como "Laboratorio de datos masivos".
4. Selecciona **Python** como lenguaje.
5. Asocia el notebook a un **clúster**. Si no tienes un clúster activo, crea uno con al menos 4 nodos para manejar grandes volúmenes de datos.

**Explicación del paso**: Esta configuración inicial te permitirá ejecutar el código en el entorno distribuido de Databricks. El notebook será el espacio de trabajo donde ejecutarás diferentes celdas de código, una por cada operación significativa o transformación.

### Paso 2: Generar un conjunto de datos masivo

#### Celda 1: Generación de datos masivos

Abre una nueva celda para generar un conjunto de datos masivo. Este paso es fundamental y requiere una celda independiente, ya que es una operación de generación que podría tomar tiempo y es útil mantenerla separada de las transformaciones posteriores.

```python
# Generar un DataFrame masivo de transacciones con 100 millones de filas
from pyspark.sql.functions import col, expr

df_masivo = spark.range(0, 100000000).select(
    col("id").alias("id_transaccion"),
    (col("id") % 1000).alias("id_producto"),
    (col("id") % 100 + 1).alias("cantidad"),
    expr("cast(rand() * 100 as double)").alias("precio"),
    expr("cast(rand() * 10000 as date)").alias("fecha")
)
df_masivo.show(5)
```

**Por qué crear una celda aquí**: La generación de datos es una operación grande y costosa que puede tardar tiempo en ejecutarse. Colocar esta operación en su propia celda permite que puedas ejecutarla por separado y reutilizar los datos generados en las siguientes celdas sin volver a ejecutar la generación de datos.

#### Celda 2: Contar el número de registros

Ahora, en una nueva celda, contamos el número de registros para confirmar que hemos generado correctamente los datos.

```python
# Contar el número de registros en el DataFrame
print(f"Número total de registros: {df_masivo.count()}")
```

**Por qué crear una celda aquí**: Es importante verificar los datos generados antes de continuar con otras transformaciones. Tener esta operación en su propia celda permite confirmar los resultados sin ejecutar otras transformaciones innecesariamente.

### Paso 3: Transformación de los datos

#### Celda 3: Crear una columna calculada

En esta nueva celda, vamos a realizar una transformación para agregar una nueva columna que calcule el valor total de cada transacción.

```python
# Crear una columna con el valor total de cada transacción
df_transformado = df_masivo.withColumn("valor_total", col("cantidad") * col("precio"))
df_transformado.show(5)
```

**Por qué crear una celda aquí**: Al separar las transformaciones en diferentes celdas, se puede ver claramente cómo evolucionan los datos después de cada paso. Si se detecta un error en esta transformación, puedes corregirlo sin tener que volver a ejecutar las celdas anteriores.

#### Celda 4: Filtrar los datos de transacciones de alto valor

Abre una nueva celda para filtrar los datos de las transacciones cuyo valor total sea mayor a 5000.

```python
# Filtrar las transacciones de alto valor
df_filtrado = df_transformado.filter(col("valor_total") > 5000)
df_filtrado.show(5)
```

**Por qué crear una celda aquí**: El filtrado es otra operación importante que podría afectar el tamaño de los datos. Mantenerla separada en una celda facilita probar diferentes criterios de filtrado sin interferir con las otras transformaciones.

#### Celda 5: Agrupar las transacciones por producto y sumar las ventas

En una nueva celda, agruparás los datos por `id_producto` y sumarás el valor total de las ventas.

```python
# Agrupar las transacciones por producto y sumar las ventas
df_agrupado = df_filtrado.groupBy("id_producto").sum("valor_total")
df_agrupado.show(5)
```

**Por qué crear una celda aquí**: Las operaciones de agrupación son costosas y pueden afectar significativamente el rendimiento. Mantener esta operación en una celda separada permite verificar los resultados de las agregaciones sin afectar los pasos anteriores.

### Paso 4: Guardar los resultados

#### Celda 6: Guardar los resultados en formato Parquet

Vamos a guardar los datos agrupados en formato Parquet, que es más eficiente para almacenamiento y consulta.

```python
# Guardar los datos filtrados en formato Parquet
df_agrupado.write.format("parquet").mode("overwrite").save("/tmp/ventas_agrupadas.parquet")
```

**Por qué crear una celda aquí**: Guardar los datos es el paso final en el proceso de análisis y debe estar claramente separado de las transformaciones para que puedas ejecutar este paso en cualquier momento sin tener que regenerar ni transformar los datos.

#### Celda 7: Verificar los archivos guardados

Abre una nueva celda para verificar que los archivos se han guardado correctamente.

```python
# Verificar que los archivos se han guardado
dbutils.fs.ls("/tmp/")
```

**Por qué crear una celda aquí**: Al listar los archivos guardados en una celda separada, se puede confirmar de manera independiente que los resultados se han guardado correctamente en el sistema de archivos.

#### Celda 8: Leer los datos guardados

Finalmente, en una nueva celda, recupera los datos guardados en formato Parquet para asegurarte de que pueden ser reutilizados en futuras sesiones.

```python
# Leer los datos guardados
df_recuperado = spark.read.format("parquet").load("/tmp/ventas_agrupadas.parquet")
df_recuperado.show(5)
```

**Por qué crear una celda aquí**: Esta operación de lectura es independiente y puede realizarse en cualquier momento posterior a la ejecución del notebook. Mantenerla en su propia celda te permite reutilizar este código en diferentes sesiones sin tener que generar ni transformar nuevamente los datos.

### Conclusión del laboratorio

Este laboratorio está diseñado para enseñarte a crear y configurar un notebook en Databricks, generar datos masivos y aplicar transformaciones y agregaciones usando PySpark. A lo largo del proceso, hemos dividido cada paso en celdas específicas, permitiendo la verificación y reutilización del código de manera modular.

Al final del laboratorio, habrás:
- Generado un conjunto de datos masivo.
- Aplicado transformaciones y filtros a los datos.
- Realizado agregaciones.
- Guardado y recuperado los resultados en formato Parquet.

La división en celdas permite que cada operación sea independiente y reutilizable, facilitando la depuración y el análisis incremental de los datos.