### **Laboratorio: Crear y usar funciones de usuario (UDFs) para transformar datos**

### **Objetivo del laboratorio**

El objetivo de este laboratorio es mostrar cómo crear y aplicar **User Defined Functions (UDFs)** en PySpark para manejar transformaciones personalizadas y complejas en grandes volúmenes de datos. Este tipo de transformaciones son comunes en un entorno empresarial donde las reglas de negocio pueden ser específicas y no estar cubiertas por las funciones nativas de PySpark. 

En este caso, trabajarás con datos de transacciones de una empresa de **e-commerce** y crearás UDFs para realizar operaciones como la clasificación de clientes según su comportamiento de compra y la aplicación de reglas personalizadas de cálculo de impuestos.

### **Escenario**

Estás trabajando en el equipo de análisis de datos de una empresa de **e-commerce**. Se te ha pedido que implementes reglas de negocio para clasificar a los clientes según su comportamiento y calcular los impuestos aplicables a cada transacción basándote en el país del cliente y la categoría del producto.

---

### **Paso 1: Cargar los datos de transacciones**

Primero, cargarás los datos de transacciones de un archivo **Parquet** para trabajar con ellos. Los datos incluyen detalles como el **ID del cliente**, **categoría del producto**, **país**, **cantidad comprada**, **precio de venta** y **fecha de la transacción**.

#### Celda 1: Cargar el archivo de transacciones

```python
# Cargar los datos de transacciones desde un archivo Parquet
df_transacciones = spark.read.parquet("/mnt/data/transacciones_ecommerce.parquet")

# Mostrar los primeros registros
df_transacciones.show(5)
```

#### Explicación:
- **Parquet** es el formato de archivo que se utiliza aquí, ya que es eficiente para el manejo de grandes volúmenes de datos.

---

### **Paso 2: Crear una UDF para clasificar a los clientes según su comportamiento**

En este paso, crearás una **UDF** que clasifica a los clientes en función de su comportamiento. La clasificación se basará en el monto total de sus compras. Si un cliente ha gastado más de 1000€, será clasificado como "Premium", mientras que otros clientes se clasificarán como "Regular".

#### Celda 2: Crear y aplicar la UDF para clasificar clientes

```python
from pyspark.sql.functions import udf
from pyspark.sql.types import StringType

# Definir una UDF para clasificar a los clientes en función de su gasto total
def clasificar_cliente(gasto_total):
    if gasto_total > 1000:
        return "Premium"
    else:
        return "Regular"

# Registrar la UDF en PySpark
clasificar_cliente_udf = udf(clasificar_cliente, StringType())

# Calcular el gasto total por cliente y aplicar la UDF
df_transacciones_agrupadas = df_transacciones.groupBy("cliente_id").agg(sum("precio_venta").alias("gasto_total"))
df_clientes_clasificados = df_transacciones_agrupadas.withColumn("clasificacion_cliente", clasificar_cliente_udf(df_transacciones_agrupadas.gasto_total))

# Mostrar los resultados
df_clientes_clasificados.show(5)
```

#### Explicación:
- **UDF**: Se usa para aplicar una lógica personalizada que clasifica a los clientes según sus hábitos de compra.
- **groupBy()**: Agrupa las transacciones por cliente y calcula el gasto total.
- **withColumn()**: Añade una nueva columna que contiene la clasificación del cliente.

---

### **Paso 3: Crear una UDF para aplicar reglas personalizadas de impuestos**

Ahora, crearás una UDF para calcular los impuestos en función del país y la categoría del producto. Las reglas de impuestos varían según estos factores, por lo que se aplicarán diferentes tasas de impuestos en función de las reglas definidas en la UDF.

#### Celda 3: Crear y aplicar la UDF para calcular impuestos

```python
# Definir una UDF para calcular impuestos basados en el país y la categoría del producto
def calcular_impuesto(pais, categoria_producto):
    if pais == "España":
        if categoria_producto == "Electrónica":
            return 0.21
        elif categoria_producto == "Ropa":
            return 0.10
        else:
            return 0.15
    elif pais == "Francia":
        if categoria_producto == "Electrónica":
            return 0.20
        elif categoria_producto == "Ropa":
            return 0.12
        else:
            return 0.18
    return 0.17  # Impuesto estándar para otros países y categorías

# Registrar la UDF en PySpark
calcular_impuesto_udf = udf(calcular_impuesto, StringType())

# Aplicar la UDF para calcular impuestos en base a las columnas de país y categoría
df_transacciones_con_impuesto = df_transacciones.withColumn("tasa_impuesto", calcular_impuesto_udf(df_transacciones.pais, df_transacciones.categoria_producto))

# Calcular el total de impuestos por transacción
df_transacciones_con_impuesto = df_transacciones_con_impuesto.withColumn("impuesto_total", df_transacciones_con_impuesto.precio_venta * df_transacciones_con_impuesto.tasa_impuesto)

# Mostrar los resultados
df_transacciones_con_impuesto.select("pais", "categoria_producto", "precio_venta", "tasa_impuesto", "impuesto_total").show(5)
```

#### Explicación:
- **calcular_impuesto()**: Aplica reglas específicas basadas en el país y la categoría del producto para calcular los impuestos.
- **withColumn()**: Añade dos nuevas columnas, una para la tasa de impuesto y otra para el total de impuestos aplicados a cada transacción.

---

### **Paso 4: Optimización del uso de UDFs con caching**

Para mejorar el rendimiento al aplicar las UDFs, utilizaremos **caching** en los datos procesados. Esto evitará recalculaciones innecesarias y acelerará las consultas posteriores.

#### Celda 4: Cachear los datos con UDFs aplicadas

```python
# Cachear los datos para optimizar las operaciones posteriores
df_transacciones_con_impuesto.cache()

# Realizar una consulta rápida sobre los datos cacheados
df_transacciones_con_impuesto.filter(df_transacciones_con_impuesto.impuesto_total > 50).show(5)
```

#### Explicación:
- **cache()**: Almacena los datos procesados en memoria para evitar que se recalculen, mejorando el rendimiento.

---

### **Paso 5: Guardar los resultados transformados en Parquet**

Finalmente, guardaremos los resultados con las clasificaciones de clientes y los impuestos calculados en **formato Parquet**, lo que permitirá que estos datos sean reutilizados en futuras etapas del pipeline.

#### Celda 5: Guardar los datos transformados en formato Parquet

```python
# Definir la ruta de salida
output_path = "/mnt/data/transacciones_con_impuestos_y_clasificacion.parquet"

# Guardar el DataFrame en formato Parquet
df_transacciones_con_impuesto.write.parquet(output_path, mode="overwrite")

# Verificar que el archivo se ha guardado correctamente
display(dbutils.fs.ls("/mnt/data/"))
```

#### Explicación:
- **write.parquet()**: Guarda los datos transformados en formato **Parquet**, eficiente para grandes volúmenes de datos.
- **overwrite**: Sobrescribe los archivos existentes si ya hay un archivo con el mismo nombre.

---

### **Conclusión del laboratorio**

En este laboratorio, has aprendido a:

1. **Crear y aplicar UDFs** para realizar transformaciones personalizadas en datos masivos.
2. **Clasificar clientes según su comportamiento** y aplicar reglas personalizadas de impuestos a las transacciones de e-commerce.
3. **Optimizar el rendimiento** utilizando caching para evitar recalculaciones innecesarias.
4. **Guardar los resultados transformados** en formato Parquet para ser reutilizados en otras etapas del pipeline.

Estas técnicas son fundamentales en escenarios empresariales donde las reglas de negocio personalizadas son esenciales y donde se manejan grandes volúmenes de datos con eficiencia.