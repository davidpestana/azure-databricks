### Laboratorio: Cargar un Archivo CSV en un DataFrame

**Objetivo**: En este laboratorio, aprenderás a cargar un archivo **CSV** en un DataFrame utilizando PySpark. Además, exploraremos cómo inspeccionar el esquema de los datos, seleccionar columnas y aplicar filtros básicos.

---

#### Requisitos:
- Acceso a **Azure Databricks** con un clúster configurado.
- Un archivo CSV almacenado en **DBFS (Databricks File System)** o en cualquier otra ubicación accesible.

---

#### 1. **Cargar un Archivo CSV desde DBFS en un DataFrame**

Primero, vamos a cargar un archivo CSV desde **DBFS** en un DataFrame de PySpark.

```python
# Cargar un archivo CSV en un DataFrame
df_csv = spark.read.csv("/databricks-datasets/samples/population-vs-price/data_geo.csv", header=True, inferSchema=True)

# Mostrar las primeras filas del DataFrame
df_csv.show(5)
```

**Explicación**:
- **spark.read.csv()** permite cargar un archivo CSV en un DataFrame.
- **header=True** indica que la primera fila del archivo contiene los nombres de las columnas.
- **inferSchema=True** permite a PySpark inferir automáticamente los tipos de datos de las columnas.

---

#### 2. **Ver el Esquema del DataFrame**

Después de cargar los datos, es importante verificar el **esquema** del DataFrame para asegurarse de que PySpark haya detectado correctamente los tipos de datos de cada columna.

```python
# Mostrar el esquema del DataFrame
df_csv.printSchema()
```

**Explicación**:
- **printSchema()** imprime el esquema del DataFrame, mostrando los nombres de las columnas y sus tipos de datos (por ejemplo, StringType, IntegerType, DoubleType).

---

#### 3. **Seleccionar Columnas Específicas**

En muchos casos, solo necesitas trabajar con un subconjunto de las columnas. Vamos a seleccionar algunas columnas del DataFrame.

```python
# Seleccionar las columnas 'city' y 'population'
df_seleccion = df_csv.select("city", "population")

# Mostrar las primeras filas del DataFrame seleccionado
df_seleccion.show(5)
```

**Explicación**:
- **select()** permite elegir las columnas específicas que deseas extraer del DataFrame.

---

#### 4. **Filtrar los Datos**

Aplicar filtros es una de las operaciones más comunes cuando se trabaja con grandes volúmenes de datos. Vamos a filtrar las ciudades con una población mayor a 1 millón.

```python
# Filtrar las filas donde la población es mayor a 1 millón
df_filtrado = df_csv.filter(df_csv["population"] > 1000000)

# Mostrar las primeras filas del DataFrame filtrado
df_filtrado.show(5)
```

**Explicación**:
- **filter()** permite aplicar condiciones lógicas para filtrar los datos. En este caso, seleccionamos solo las ciudades con una población superior a 1 millón.

---

#### 5. **Guardar el DataFrame Filtrado en un Archivo CSV**

Después de filtrar los datos, puedes guardar el resultado en un archivo CSV para utilizarlo más adelante o compartirlo.

```python
# Guardar el DataFrame filtrado en un archivo CSV
df_filtrado.write.csv("/dbfs/FileStore/shared_uploads/tu_usuario/ciudades_filtradas.csv")

print("Archivo CSV guardado correctamente.")
```

**Explicación**:
- **write.csv()** permite guardar los datos del DataFrame en un archivo CSV dentro del sistema de archivos de Databricks (**DBFS**).

---

### Conclusión

Este laboratorio te ha mostrado cómo cargar un archivo **CSV** en un **DataFrame** de PySpark, inspeccionar su esquema, seleccionar columnas y filtrar filas según condiciones específicas. Finalmente, también hemos visto cómo guardar los resultados en un archivo CSV para futuras operaciones. El manejo de archivos CSV es una habilidad esencial para procesar datos estructurados en **Apache Spark** y PySpark.