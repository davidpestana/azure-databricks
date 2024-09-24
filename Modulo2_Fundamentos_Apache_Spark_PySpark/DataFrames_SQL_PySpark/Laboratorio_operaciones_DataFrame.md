### Laboratorio: Realizar Operaciones de Selección, Filtrado y Agrupación en el DataFrame

**Objetivo**: En este laboratorio, aprenderás a realizar operaciones avanzadas sobre un **DataFrame** en **PySpark**, como selección de columnas, filtrado de datos basados en condiciones, y agrupación con agregaciones. Estas operaciones son fundamentales para el análisis de datos estructurados.

---

#### Requisitos:
- Acceso a **Azure Databricks** con un clúster configurado.
- Un DataFrame ya cargado (si no tienes uno, sigue el laboratorio anterior para cargar un archivo CSV en un DataFrame).

---

#### 1. **Seleccionar Columnas Específicas**

La selección de columnas es una operación básica pero muy importante en el análisis de datos. Te permite trabajar solo con las columnas relevantes para tu análisis.

```python
# Seleccionar las columnas 'city' y 'population'
df_seleccion = df_csv.select("city", "population")

# Mostrar las primeras filas del DataFrame seleccionado
df_seleccion.show(5)
```

**Explicación**:
- **select()** permite elegir las columnas específicas que deseas extraer del DataFrame. En este ejemplo, estamos seleccionando las columnas "city" y "population".

---

#### 2. **Filtrar Filas Según Condiciones**

El filtrado es esencial cuando necesitas trabajar con un subconjunto de datos que cumpla con ciertos criterios. Vamos a filtrar las ciudades con una población mayor a 1 millón.

```python
# Filtrar las filas donde la población es mayor a 1 millón
df_filtrado = df_csv.filter(df_csv["population"] > 1000000)

# Mostrar las primeras filas del DataFrame filtrado
df_filtrado.show(5)
```

**Explicación**:
- **filter()** permite aplicar condiciones lógicas a las filas del DataFrame. Aquí, seleccionamos solo las ciudades cuya población es mayor a 1 millón.

---

#### 3. **Agrupar Datos y Aplicar Agregaciones**

La agrupación es clave para resumir y analizar datos. En este caso, vamos a agrupar las ciudades por región y calcular la suma de la población en cada una.

```python
# Agrupar por 'region' y sumar la población
df_agrupado = df_csv.groupBy("region").sum("population")

# Mostrar el resultado de la agregación
df_agrupado.show()
```

**Explicación**:
- **groupBy()** permite agrupar los datos por una o más columnas.
- **sum()** es una función de agregación que suma los valores de una columna. En este ejemplo, sumamos las poblaciones por región.

---

#### 4. **Filtrar los Resultados de la Agrupación**

Puedes aplicar un filtro adicional sobre los resultados agregados para obtener información más detallada. Por ejemplo, podrías filtrar las regiones donde la población total es mayor a 2 millones.

```python
# Filtrar las regiones donde la población total es mayor a 2 millones
df_agrupado_filtrado = df_agrupado.filter(df_agrupado["sum(population)"] > 2000000)

# Mostrar el resultado
df_agrupado_filtrado.show()
```

**Explicación**:
- Después de realizar la agregación, puedes aplicar un filtro adicional sobre los resultados utilizando **filter()** para obtener un subconjunto más específico.

---

#### 5. **Ordenar los Resultados**

Finalmente, puedes ordenar los datos agrupados y agregados. En este caso, ordenaremos las regiones por población total en orden descendente.

```python
# Ordenar las regiones por población total en orden descendente
df_agrupado_ordenado = df_agrupado.orderBy(df_agrupado["sum(population)"].desc())

# Mostrar el resultado ordenado
df_agrupado_ordenado.show()
```

**Explicación**:
- **orderBy()** ordena los datos según una o más columnas. En este caso, estamos ordenando las regiones por el total de la población de mayor a menor.

---

#### 6. **Guardar los Resultados Agrupados en un Archivo CSV**

Después de realizar las operaciones de selección, filtrado, agrupación y ordenación, puedes guardar los resultados en un archivo CSV.

```python
# Guardar los resultados agrupados en un archivo CSV
df_agrupado_ordenado.write.csv("/dbfs/FileStore/shared_uploads/tu_usuario/region_poblacion.csv")

print("Archivo CSV guardado correctamente.")
```

**Explicación**:
- **write.csv()** guarda los resultados del DataFrame en formato CSV en el sistema de archivos distribuido de Databricks (**DBFS**).

---

### Conclusión

En este laboratorio, has aprendido a realizar operaciones de selección de columnas, filtrado de filas, y agrupación de datos en un **DataFrame** de **PySpark**. Estas operaciones son fundamentales para el análisis de grandes volúmenes de datos estructurados en **Apache Spark**. Además, hemos visto cómo ordenar y guardar los resultados de las operaciones en un archivo CSV para su uso futuro.