### Laboratorio: Optimizar y Ejecutar Consultas Complejas

**Objetivo**: En este laboratorio, aprenderás a optimizar y ejecutar consultas complejas en **PySpark**. Exploraremos cómo usar las técnicas de optimización como **broadcast joins**, **caching**, y particionamiento para mejorar el rendimiento de consultas sobre grandes conjuntos de datos distribuidos.

---

#### Requisitos:
- Acceso a **Azure Databricks** con un clúster configurado.
- Un DataFrame ya cargado y disponible para realizar las consultas.

---

#### 1. **Uso de Broadcast Join para Optimización**

Cuando realizas un **JOIN** entre un DataFrame pequeño y uno grande, PySpark puede optimizar la ejecución mediante el uso de un **broadcast join**, donde el DataFrame pequeño se distribuye a todos los nodos del clúster para evitar costosos movimientos de datos.

```python
from pyspark.sql.functions import broadcast

# Crear un DataFrame pequeño para el join
df_pequeno = spark.createDataFrame([("Madrid", "España"), ("Barcelona", "España")], ["city", "country"])

# Realizar un broadcast join entre el DataFrame grande y el DataFrame pequeño
df_join = df_csv.join(broadcast(df_pequeno), df_csv["city"] == df_pequeno["city"])

# Mostrar los resultados
df_join.show(5)
```

**Explicación**:
- **broadcast()** fuerza que el DataFrame pequeño se transmita a todos los nodos, mejorando el rendimiento de los **joins** con conjuntos de datos grandes.

---

#### 2. **Almacenar los Resultados en Caché (Caching)**

Si planeas reutilizar los resultados de un DataFrame en varias operaciones, es recomendable almacenarlos en memoria utilizando **caching**. Esto evita que Spark recalcule los resultados cada vez que se accede a ellos.

```python
# Almacenar el DataFrame en memoria para optimizar futuras operaciones
df_csv.cache()

# Ejecutar una acción para cargar el DataFrame en caché
df_csv.count()

# Mostrar el DataFrame almacenado en caché
df_csv.show(5)
```

**Explicación**:
- **cache()** almacena el DataFrame en la memoria distribuida, lo que acelera las operaciones subsiguientes sobre el mismo DataFrame al evitar su recomputación.

---

#### 3. **Reparticionar los Datos para Mejorar el Rendimiento**

El particionamiento de datos es clave para mejorar el rendimiento en PySpark. Si tienes datos desbalanceados o un número inadecuado de particiones, puede afectar negativamente la ejecución de las consultas.

```python
# Ver el número de particiones actuales del DataFrame
print(f"Particiones actuales: {df_csv.rdd.getNumPartitions()}")

# Reparticionar el DataFrame en un número óptimo de particiones
df_reparticionado = df_csv.repartition(10)

# Mostrar las primeras filas del DataFrame reparticionado
df_reparticionado.show(5)
```

**Explicación**:
- **repartition()** redistribuye los datos en un número específico de particiones. Es útil cuando tus datos están desbalanceados o cuando necesitas más paralelismo en la ejecución.

---

#### 4. **Ejecutar Consultas SQL Complejas con Subconsultas**

Las subconsultas pueden ser una parte fundamental de las consultas complejas. Vamos a ejecutar una subconsulta para filtrar las ciudades cuya población es mayor al promedio.

```python
# Ejecutar una subconsulta para filtrar ciudades con población mayor al promedio
df_subconsulta = spark.sql("""
    SELECT city, population FROM poblacion
    WHERE population > (SELECT AVG(population) FROM poblacion)
""")

# Mostrar los resultados de la subconsulta
df_subconsulta.show(5)
```

**Explicación**:
- En esta subconsulta, primero calculamos el promedio de la población y luego filtramos las ciudades cuya población es mayor que ese promedio.

---

#### 5. **Optimizar Consultas con Funciones Condicionales (CASE WHEN)**

Las funciones condicionales, como **CASE WHEN**, te permiten crear nuevas columnas basadas en condiciones. Este tipo de optimización es útil para agregar complejidad lógica en tus consultas sin afectar demasiado el rendimiento.

```python
# Ejecutar una consulta con CASE WHEN para clasificar ciudades
df_clasificacion = spark.sql("""
    SELECT city, population,
    CASE 
        WHEN population > 1000000 THEN 'Grande'
        ELSE 'Pequeña' 
    END as clasificacion
    FROM poblacion
""")

# Mostrar los resultados
df_clasificacion.show(5)
```

**Explicación**:
- **CASE WHEN** es una función SQL condicional que permite agregar lógica personalizada a las consultas, en este caso clasificando las ciudades como "Grande" o "Pequeña".

---

#### 6. **Utilizar el Catalyst Optimizer para Ver el Plan de Ejecución**

El **Catalyst Optimizer** de Spark optimiza automáticamente las consultas SQL y las transformaciones de DataFrames. Puedes visualizar el plan de ejecución optimizado para entender cómo Spark distribuye las operaciones en el clúster.

```python
# Mostrar el plan de ejecución optimizado de la consulta
df_csv.explain(True)
```

**Explicación**:
- **explain(True)** muestra el plan de ejecución optimizado del DataFrame, detallando las etapas físicas y lógicas que Spark ejecutará en el clúster.

---

#### 7. **Guardar los Resultados Optimizados en un Formato Eficiente (Parquet)**

Después de optimizar y ejecutar consultas complejas, es recomendable guardar los resultados en un formato eficiente, como **Parquet**. Este formato es columnar, lo que reduce el espacio de almacenamiento y mejora el rendimiento de las consultas.

```python
# Guardar el DataFrame optimizado en formato Parquet
df_csv.write.parquet("/dbfs/FileStore/shared_uploads/tu_usuario/ciudades_optimizado.parquet")

print("Archivo Parquet guardado correctamente.")
```

**Explicación**:
- **write.parquet()** guarda los datos en formato **Parquet**, un formato columnar que es eficiente tanto en almacenamiento como en consultas.

---

### Conclusión

Este laboratorio ha cubierto técnicas avanzadas para **optimizar y ejecutar consultas complejas** en PySpark, como el uso de **broadcast joins**, **caching**, **reparticionamiento**, y la ejecución de **consultas SQL complejas**. También has aprendido a visualizar el **plan de ejecución** optimizado de Spark utilizando **Catalyst Optimizer**. Estas técnicas son esenciales para manejar grandes volúmenes de datos distribuidos de manera eficiente y optimizar el rendimiento de las consultas en un entorno de producción.