### Operaciones Básicas en DataFrames

En **PySpark**, las **operaciones básicas** en DataFrames incluyen la selección, filtrado, ordenación, agregación, y transformación de datos. Estas operaciones son fundamentales para trabajar de manera eficiente con grandes volúmenes de datos distribuidos.

A continuación, se presentan las operaciones más comunes que se pueden realizar sobre un DataFrame en PySpark:

---

#### 1. **Selección de Columnas**

La operación más básica que puedes realizar en un DataFrame es seleccionar columnas específicas. Esto te permite trabajar solo con las columnas necesarias para tu análisis.

```python
# Seleccionar una o más columnas de un DataFrame
df_seleccion = df_csv.select("city", "population")

# Mostrar las primeras filas del DataFrame seleccionado
df_seleccion.show(5)
```

**Explicación**:
- **select()** permite seleccionar una o varias columnas del DataFrame. Las columnas seleccionadas se pasan como argumentos de la función.

---

#### 2. **Renombrar Columnas**

En ocasiones, es útil cambiar los nombres de las columnas para hacer el DataFrame más legible o para evitar conflictos.

```python
# Renombrar la columna 'population' a 'total_population'
df_renombrado = df_csv.withColumnRenamed("population", "total_population")

# Mostrar el DataFrame con la columna renombrada
df_renombrado.show(5)
```

**Explicación**:
- **withColumnRenamed()** permite cambiar el nombre de una columna en el DataFrame.

---

#### 3. **Filtrado de Filas**

El filtrado es útil para obtener un subconjunto de datos que cumpla con ciertas condiciones. Puedes aplicar múltiples condiciones de filtrado.

```python
# Filtrar las filas donde la población es mayor a 1 millón
df_filtrado = df_csv.filter(df_csv["population"] > 1000000)

# Mostrar las filas filtradas
df_filtrado.show(5)
```

**Explicación**:
- **filter()** aplica una condición lógica para seleccionar solo las filas que cumplan con el criterio.

---

#### 4. **Ordenar el DataFrame**

La ordenación es importante cuando deseas organizar los datos de acuerdo con una o más columnas. Puedes ordenar en orden ascendente o descendente.

```python
# Ordenar el DataFrame por población en orden descendente
df_ordenado = df_csv.orderBy(df_csv["population"].desc())

# Mostrar el DataFrame ordenado
df_ordenado.show(5)
```

**Explicación**:
- **orderBy()** permite ordenar los datos de acuerdo con una columna, ya sea en orden ascendente o descendente. Para ordenar en orden descendente, se utiliza `.desc()`.

---

#### 5. **Eliminar Duplicados**

PySpark permite eliminar filas duplicadas de un DataFrame basadas en una o más columnas.

```python
# Eliminar filas duplicadas basadas en la columna 'city'
df_sin_duplicados = df_csv.dropDuplicates(["city"])

# Mostrar el DataFrame sin duplicados
df_sin_duplicados.show(5)
```

**Explicación**:
- **dropDuplicates()** elimina filas duplicadas en función de una o varias columnas.

---

#### 6. **Agregar Nuevas Columnas**

Es posible añadir nuevas columnas a un DataFrame, ya sea a partir de otras columnas o a través de cálculos.

```python
from pyspark.sql.functions import col

# Añadir una nueva columna que calcule el doble de la población
df_con_nueva_columna = df_csv.withColumn("doble_poblacion", col("population") * 2)

# Mostrar el DataFrame con la nueva columna
df_con_nueva_columna.show(5)
```

**Explicación**:
- **withColumn()** se utiliza para crear una nueva columna en el DataFrame. Puedes usar funciones como **col()** para referenciar columnas existentes y realizar cálculos.

---

#### 7. **Agrupar y Agregar Datos**

La agregación es crucial para realizar operaciones como la suma, el promedio o el conteo de los datos agrupados por una o más columnas.

```python
# Agrupar por 'city' y calcular la suma de la población
df_agrupado = df_csv.groupBy("city").sum("population")

# Mostrar los resultados agregados
df_agrupado.show(5)
```

**Explicación**:
- **groupBy()** agrupa los datos por una o más columnas, y luego se pueden aplicar funciones de agregación como **sum()**, **avg()**, **count()**, etc.

---

#### 8. **Contar el Número de Filas**

Una de las acciones más comunes es contar cuántas filas tiene un DataFrame. Esto es útil para verificar la cantidad de datos procesados.

```python
# Contar el número total de filas en el DataFrame
conteo_filas = df_csv.count()

# Mostrar el número total de filas
print(f"El DataFrame tiene {conteo_filas} filas.")
```

**Explicación**:
- **count()** es una acción que devuelve el número total de filas en el DataFrame.

---

#### 9. **Realizar Operaciones Condicionales**

Puedes crear nuevas columnas en función de condiciones específicas utilizando la función **when()**.

```python
from pyspark.sql.functions import when

# Añadir una nueva columna que clasifique las ciudades en 'Grande' o 'Pequeña'
df_con_clasificacion = df_csv.withColumn(
    "clasificacion",
    when(df_csv["population"] > 1000000, "Grande").otherwise("Pequeña")
)

# Mostrar el DataFrame con la clasificación
df_con_clasificacion.show(5)
```

**Explicación**:
- **when()** crea una expresión condicional. Si la condición se cumple, se asigna el valor "Grande"; de lo contrario, se asigna el valor "Pequeña".

---

#### 10. **Combinar DataFrames (Union)**

A veces es necesario combinar dos DataFrames que tienen la misma estructura de columnas.

```python
# Crear otro DataFrame con la misma estructura
data_nueva = [("Valencia", 791413, "Valencia"), ("Sevilla", 688592, "Andalucía")]
df_nuevo = spark.createDataFrame(data_nueva, ["city", "population", "region"])

# Unir ambos DataFrames
df_union = df_csv.union(df_nuevo)

# Mostrar el DataFrame combinado
df_union.show()
```

**Explicación**:
- **union()** permite combinar dos DataFrames siempre y cuando tengan el mismo número de columnas y tipos de datos compatibles.

---

### Conclusión

Las operaciones básicas en **DataFrames** en PySpark son esenciales para manipular y procesar grandes volúmenes de datos distribuidos. PySpark ofrece una amplia gama de operaciones, como selección, filtrado, ordenación, agregación, y transformación de columnas, lo que te permite preparar los datos para análisis o procesamiento posterior de manera eficiente. Además, al trabajar con datos distribuidos, todas estas operaciones se pueden ejecutar en paralelo, lo que proporciona un rendimiento escalable para grandes volúmenes de datos.