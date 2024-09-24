### Ejecución de Consultas SQL en PySpark

**PySpark** permite ejecutar consultas SQL sobre los **DataFrames**, facilitando el análisis y manipulación de datos utilizando el conocido lenguaje SQL. Esta funcionalidad es muy útil para aquellos que están familiarizados con las bases de datos relacionales y desean aplicar esas habilidades a entornos de big data distribuidos.

En esta sección, aprenderás a realizar consultas SQL sobre DataFrames, registrar vistas temporales y ejecutar consultas complejas utilizando PySpark.

---

#### 1. **Registrar un DataFrame como una Vista Temporal**

Para poder ejecutar consultas SQL en un DataFrame, primero debes registrarlo como una **vista temporal**. Esto crea una tabla temporal en la que puedes realizar consultas SQL.

```python
# Registrar un DataFrame como una vista temporal
df_csv.createOrReplaceTempView("poblacion")

# Mostrar las primeras filas de la tabla temporal
spark.sql("SELECT * FROM poblacion").show(5)
```

**Explicación**:
- **createOrReplaceTempView()** registra el DataFrame como una vista temporal en la que puedes realizar consultas SQL.
- Luego, utilizas `spark.sql()` para ejecutar consultas SQL directamente en la tabla temporal.

---

#### 2. **Ejecutar Consultas SQL Básicas**

Una vez que el DataFrame está registrado como una vista temporal, puedes ejecutar consultas SQL estándar para seleccionar, filtrar, y ordenar los datos.

```python
# Ejecutar una consulta SQL para seleccionar y ordenar los datos por población
resultado_sql = spark.sql("SELECT city, population FROM poblacion WHERE population > 1000000 ORDER BY population DESC")

# Mostrar los resultados
resultado_sql.show(5)
```

**Explicación**:
- El comando **spark.sql()** permite ejecutar consultas SQL directamente en la vista temporal que hemos registrado.
- En este ejemplo, seleccionamos las columnas `city` y `population`, filtramos aquellas ciudades con una población mayor a 1 millón y ordenamos los resultados en orden descendente.

---

#### 3. **Consultas SQL con Funciones de Agregación**

Al igual que en las bases de datos SQL tradicionales, puedes realizar operaciones de agregación como `SUM`, `AVG`, `COUNT`, entre otras, en PySpark.

```python
# Calcular la suma total de la población por región
resultado_agregacion = spark.sql("SELECT region, SUM(population) as total_population FROM poblacion GROUP BY region")

# Mostrar los resultados
resultado_agregacion.show()
```

**Explicación**:
- **SUM()** es una función de agregación en SQL que suma los valores de una columna.
- **GROUP BY** agrupa los datos según una columna específica (en este caso, `region`), lo que nos permite calcular la suma de población por región.

---

#### 4. **Usar Consultas con Funciones Condicionales en SQL**

Al igual que en SQL tradicional, puedes aplicar funciones condicionales utilizando el comando **CASE WHEN**. Esto es útil para crear nuevas columnas basadas en condiciones específicas.

```python
# Clasificar ciudades según la población utilizando CASE WHEN
resultado_clasificacion = spark.sql("""
    SELECT city, population, 
    CASE 
        WHEN population > 1000000 THEN 'Grande'
        ELSE 'Pequeña' 
    END as clasificacion
    FROM poblacion
""")

# Mostrar los resultados
resultado_clasificacion.show()
```

**Explicación**:
- **CASE WHEN** es una función condicional en SQL que asigna un valor basado en una condición.
- En este ejemplo, clasificamos las ciudades como "Grande" o "Pequeña" según su población.

---

#### 5. **Consultas SQL Anidadas**

PySpark también admite consultas SQL anidadas, lo que te permite realizar operaciones complejas como subconsultas o combinaciones de varias consultas.

```python
# Ejecutar una consulta anidada para obtener las ciudades con población mayor que el promedio
resultado_subconsulta = spark.sql("""
    SELECT city, population FROM poblacion
    WHERE population > (SELECT AVG(population) FROM poblacion)
""")

# Mostrar los resultados
resultado_subconsulta.show()
```

**Explicación**:
- En esta consulta, utilizamos una subconsulta para calcular el promedio de la población y luego filtramos las ciudades cuya población es mayor que ese promedio.

---

#### 6. **Uniones entre Vistas Temporales (JOIN)**

Puedes realizar uniones entre varias vistas temporales de la misma manera que lo harías en SQL estándar. Las uniones son útiles para combinar datos de diferentes fuentes en una única consulta.

```python
# Crear otro DataFrame de ejemplo
data_nueva = [("Madrid", "España"), ("Barcelona", "España"), ("Valencia", "España"), ("Lisboa", "Portugal")]
df_nuevo = spark.createDataFrame(data_nueva, ["city", "country"])

# Registrar el nuevo DataFrame como una vista temporal
df_nuevo.createOrReplaceTempView("ciudades_paises")

# Ejecutar una consulta SQL para unir ambas vistas temporales
resultado_union = spark.sql("""
    SELECT p.city, p.population, c.country 
    FROM poblacion p
    JOIN ciudades_paises c ON p.city = c.city
""")

# Mostrar los resultados
resultado_union.show()
```

**Explicación**:
- **JOIN** es una operación que combina filas de dos o más tablas basadas en una condición. En este caso, combinamos las vistas `poblacion` y `ciudades_paises` según la columna `city`.

---

#### 7. **Guardar los Resultados de una Consulta SQL en un DataFrame**

Después de ejecutar consultas SQL, puedes almacenar los resultados en un nuevo DataFrame para realizar más transformaciones o guardarlo en almacenamiento externo.

```python
# Ejecutar una consulta SQL y guardar los resultados en un nuevo DataFrame
df_resultado = spark.sql("SELECT city, population FROM poblacion WHERE population > 1000000")

# Mostrar el nuevo DataFrame
df_resultado.show()

# Guardar los resultados en un archivo CSV
df_resultado.write.csv("/dbfs/FileStore/shared_uploads/tu_usuario/ciudades_grandes.csv")
```

**Explicación**:
- **write.csv()** guarda los resultados del DataFrame en formato CSV en **DBFS** (Databricks File System).

---

### Conclusión

La capacidad de **ejecutar consultas SQL** directamente sobre **DataFrames** en PySpark proporciona una forma flexible y potente de trabajar con grandes volúmenes de datos distribuidos. Las consultas SQL permiten realizar operaciones avanzadas como agregaciones, uniones, subconsultas y transformaciones condicionales, todo mientras se aprovecha la potencia de procesamiento distribuido de Apache Spark. Al registrar DataFrames como vistas temporales, puedes aplicar todo tu conocimiento de SQL a los datos, permitiendo una transición sencilla desde entornos relacionales a PySpark.