### Laboratorio: Ejecutar Consultas SQL en el DataFrame y Visualizar los Resultados

**Objetivo**: En este laboratorio, aprenderás cómo ejecutar consultas **SQL** sobre un **DataFrame** en PySpark. Veremos cómo registrar un DataFrame como una vista temporal y realizar consultas SQL, incluyendo selección, filtrado y agregación. También aprenderás cómo visualizar los resultados de las consultas SQL en **Azure Databricks**.

---

#### Requisitos:
- Acceso a **Azure Databricks** con un clúster configurado.
- Un DataFrame ya cargado (si no tienes uno, sigue el laboratorio anterior para cargar un archivo CSV en un DataFrame).

---

#### 1. **Registrar un DataFrame como una Vista Temporal**

Para ejecutar consultas SQL en un DataFrame, primero necesitas registrarlo como una **vista temporal**. Esto te permite utilizar SQL para interactuar con los datos de manera más familiar, similar a trabajar con bases de datos relacionales.

```python
# Registrar el DataFrame como una vista temporal llamada 'poblacion'
df_csv.createOrReplaceTempView("poblacion")

# Mostrar las primeras filas utilizando una consulta SQL
spark.sql("SELECT * FROM poblacion").show(5)
```

**Explicación**:
- **createOrReplaceTempView()** registra el DataFrame como una vista temporal. Luego, puedes ejecutar consultas SQL sobre la vista.
- **spark.sql()** permite ejecutar una consulta SQL sobre la vista temporal registrada.

---

#### 2. **Realizar Consultas SQL Básicas**

Una vez que el DataFrame esté registrado como una vista temporal, puedes ejecutar consultas SQL estándar. Vamos a seleccionar algunas columnas y aplicar un filtro.

```python
# Ejecutar una consulta SQL para seleccionar las columnas 'city' y 'population'
resultado_sql = spark.sql("SELECT city, population FROM poblacion WHERE population > 1000000")

# Mostrar los resultados
resultado_sql.show(5)
```

**Explicación**:
- **SELECT** te permite seleccionar columnas específicas.
- **WHERE** aplica un filtro a la consulta. En este caso, seleccionamos solo las ciudades con una población mayor a 1 millón.

---

#### 3. **Aplicar Funciones de Agregación en SQL**

Al igual que en SQL estándar, puedes aplicar funciones de agregación como `SUM`, `AVG`, `COUNT` en tus consultas SQL en PySpark.

```python
# Calcular la suma de la población por región utilizando SQL
resultado_agrupacion = spark.sql("SELECT region, SUM(population) AS total_population FROM poblacion GROUP BY region")

# Mostrar los resultados
resultado_agrupacion.show()
```

**Explicación**:
- **SUM()** es una función de agregación que suma los valores de una columna.
- **GROUP BY** agrupa los datos por una columna, en este caso por la región, y luego aplica la agregación de la población.

---

#### 4. **Ordenar los Resultados de la Consulta SQL**

Puedes ordenar los resultados de las consultas SQL de forma ascendente o descendente utilizando **ORDER BY**.

```python
# Ordenar los resultados de la consulta SQL por la población total en orden descendente
resultado_ordenado = spark.sql("SELECT city, population FROM poblacion ORDER BY population DESC")

# Mostrar los resultados ordenados
resultado_ordenado.show(5)
```

**Explicación**:
- **ORDER BY** permite ordenar los resultados según una columna específica. En este caso, los datos están ordenados por población en orden descendente.

---

#### 5. **Uniones entre Vistas Temporales (JOIN)**

Puedes realizar **JOINs** entre diferentes vistas temporales. Esto es útil cuando trabajas con múltiples conjuntos de datos y necesitas combinarlos.

```python
# Crear otro DataFrame de ejemplo con países
data_paises = [("Madrid", "España"), ("Barcelona", "España"), ("Valencia", "España"), ("Lisboa", "Portugal")]
df_paises = spark.createDataFrame(data_paises, ["city", "country"])

# Registrar el nuevo DataFrame como una vista temporal
df_paises.createOrReplaceTempView("ciudades_paises")

# Realizar un JOIN entre las vistas 'poblacion' y 'ciudades_paises'
resultado_union = spark.sql("""
    SELECT p.city, p.population, c.country 
    FROM poblacion p
    JOIN ciudades_paises c ON p.city = c.city
""")

# Mostrar los resultados de la unión
resultado_union.show()
```

**Explicación**:
- **JOIN** es una operación que combina filas de dos vistas temporales en función de una condición. En este caso, combinamos las vistas `poblacion` y `ciudades_paises` en la columna `city`.

---

#### 6. **Guardar los Resultados de una Consulta SQL en un DataFrame**

Después de ejecutar consultas SQL, puedes guardar los resultados en un nuevo DataFrame para realizar más transformaciones o guardarlos en almacenamiento externo.

```python
# Guardar los resultados de una consulta SQL en un nuevo DataFrame
df_resultado = spark.sql("SELECT city, population FROM poblacion WHERE population > 1000000")

# Mostrar el DataFrame resultante
df_resultado.show()

# Guardar los resultados en un archivo CSV
df_resultado.write.csv("/dbfs/FileStore/shared_uploads/tu_usuario/ciudades_grandes.csv")

print("Archivo CSV guardado correctamente.")
```

**Explicación**:
- **write.csv()** permite guardar los resultados del DataFrame en formato CSV en el sistema de archivos distribuido de Databricks (**DBFS**).

---

### Conclusión

Este laboratorio te ha mostrado cómo ejecutar consultas **SQL** sobre un **DataFrame** en **PySpark**. Has aprendido a registrar un DataFrame como una vista temporal, realizar consultas SQL básicas y avanzadas, aplicar funciones de agregación y ordenar los resultados. Además, has aprendido a realizar uniones entre vistas temporales y a guardar los resultados de las consultas SQL en un archivo CSV. El uso de SQL en PySpark es una herramienta poderosa para aquellos que desean aprovechar su conocimiento de SQL para trabajar con grandes volúmenes de datos distribuidos.