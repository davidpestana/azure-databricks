### **Laboratorio: Uso de técnicas avanzadas de optimización de datos (caching, broadcast variables)**

### **Objetivo del laboratorio**

En este laboratorio aprenderás a aplicar técnicas avanzadas de optimización de datos en PySpark, como **caching** y **broadcast variables**, para mejorar el rendimiento al trabajar con grandes volúmenes de datos. Estas técnicas son especialmente útiles en entornos empresariales donde el procesamiento eficiente de datos masivos es crucial.

### **Escenario**

Trabajas en una empresa de **finanzas** que maneja grandes volúmenes de datos de transacciones diarias. Estos datos se cruzan frecuentemente con tablas más pequeñas, como información de clientes o productos. Para optimizar este proceso, usarás técnicas de **broadcasting** para distribuir de manera eficiente los datos pequeños y **caching** para evitar recalculaciones innecesarias en transformaciones que se aplican repetidamente.

---

### **Paso 1: Cargar los datos de transacciones y clientes**

En este primer paso, cargarás un conjunto de datos grande de transacciones y un conjunto más pequeño de información de clientes. Posteriormente, aplicarás técnicas de optimización para mejorar el rendimiento.

#### Celda 1: Cargar los datos de transacciones y clientes

```python
# Cargar el DataFrame de transacciones desde un archivo Parquet (dataset masivo)
df_transacciones = spark.read.parquet("/mnt/data/transacciones_financieras.parquet")

# Cargar el DataFrame de clientes desde un archivo Parquet (dataset más pequeño)
df_clientes = spark.read.parquet("/mnt/data/clientes_financieros.parquet")

# Mostrar algunos registros de ambos DataFrames
df_transacciones.show(5)
df_clientes.show(5)
```

#### Explicación:
- **Parquet**: Utilizamos este formato para manejar eficientemente grandes volúmenes de datos.
- **df_transacciones**: Conjunto de datos masivo que contiene las transacciones diarias.
- **df_clientes**: Conjunto de datos más pequeño que contiene la información de los clientes.

---

### **Paso 2: Usar broadcast variables para optimizar uniones (joins)**

Las **broadcast variables** permiten que un conjunto de datos pequeño (como la información de clientes) sea distribuido a todos los nodos de procesamiento, lo que evita la necesidad de mover grandes volúmenes de datos durante una operación de **join**.

#### Celda 2: Aplicar broadcast para optimizar la unión entre transacciones y clientes

```python
from pyspark.sql.functions import broadcast

# Aplicar broadcast a la tabla de clientes
df_transacciones_clientes = df_transacciones.join(broadcast(df_clientes), "cliente_id")

# Mostrar los resultados de la unión optimizada
df_transacciones_clientes.show(5)
```

#### Explicación:
- **broadcast()**: Optimiza el rendimiento distribuyendo el conjunto de datos más pequeño (en este caso, los clientes) a todos los nodos de procesamiento.
- **join()**: Realiza una unión entre las transacciones y los clientes utilizando el **cliente_id** como clave.

---

### **Paso 3: Cachear los datos para evitar recalculaciones**

Dado que el conjunto de datos combinado será utilizado en múltiples transformaciones, utilizaremos **caching** para almacenar los resultados en memoria y evitar recalculaciones en futuras consultas.

#### Celda 3: Cachear los datos combinados

```python
# Cachear los datos combinados para evitar recalcular la unión en futuras consultas
df_transacciones_clientes.cache()

# Realizar una consulta rápida para verificar el cache
df_transacciones_clientes.filter(df_transacciones_clientes.monto > 1000).show(5)
```

#### Explicación:
- **cache()**: Almacena los datos en memoria para acelerar futuras consultas que utilizan el mismo conjunto de datos.
- **filter()**: Realiza una consulta sobre los datos cacheados, en este caso filtrando transacciones mayores a 1000.

---

### **Paso 4: Aplicar transformaciones avanzadas con los datos cacheados**

Una vez que los datos están cacheados, aplicaremos una serie de transformaciones para calcular estadísticas avanzadas, como el total de transacciones por cliente y la media de los montos de las transacciones.

#### Celda 4: Calcular el total y la media de las transacciones por cliente

```python
from pyspark.sql.functions import sum, avg

# Calcular el total de transacciones y el promedio por cliente
df_estadisticas_cliente = df_transacciones_clientes.groupBy("cliente_id").agg(
    sum("monto").alias("total_transacciones"),
    avg("monto").alias("promedio_monto")
)

# Mostrar los resultados
df_estadisticas_cliente.show(5)
```

#### Explicación:
- **groupBy()**: Agrupa los datos por cliente para realizar agregaciones.
- **agg()**: Calcula el total de transacciones y el promedio de monto por cliente.

---

### **Paso 5: Guardar los resultados optimizados en Parquet**

Finalmente, guardaremos los resultados en **formato Parquet** para que puedan ser reutilizados en análisis futuros.

#### Celda 5: Guardar los resultados en formato Parquet

```python
# Guardar los resultados en un archivo Parquet
output_path = "/mnt/data/estadisticas_cliente_optimizado.parquet"
df_estadisticas_cliente.write.parquet(output_path, mode="overwrite")

# Verificar que el archivo se ha guardado correctamente
display(dbutils.fs.ls("/mnt/data/"))
```

#### Explicación:
- **write.parquet()**: Guarda el DataFrame resultante en **formato Parquet**, optimizado para grandes volúmenes de datos.
- **overwrite**: Sobrescribe cualquier archivo existente en la misma ubicación.

---

### **Conclusión del laboratorio**

En este laboratorio, has aprendido a:

1. **Usar broadcast variables** para optimizar las uniones entre grandes y pequeños conjuntos de datos, mejorando el rendimiento de las consultas.
2. **Aplicar caching** para evitar recalculaciones innecesarias en operaciones que se repiten, acelerando el procesamiento de datos.
3. **Realizar transformaciones avanzadas** sobre datos cacheados, como el cálculo del total de transacciones y el promedio por cliente.
4. **Guardar los resultados optimizados** en formato Parquet para su reutilización en futuros análisis.

Estas técnicas son esenciales en el manejo de datos masivos en un entorno empresarial, permitiendo procesar información de manera eficiente y escalable.