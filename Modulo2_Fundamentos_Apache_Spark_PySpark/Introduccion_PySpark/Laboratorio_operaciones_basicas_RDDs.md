### Laboratorio: Ejecutar Operaciones Básicas con RDDs (Resilient Distributed Datasets)

**Objetivo**: En este laboratorio, aprenderás a trabajar con **RDDs (Resilient Distributed Datasets)**, la estructura de datos fundamental de PySpark para el procesamiento distribuido. Realizaremos algunas operaciones básicas como map, filter y reduce para procesar datos de manera distribuida utilizando un clúster de Spark en **Databricks**.

#### Requisitos:
- Acceso a un **notebook** en **Azure Databricks**.
- Un **clúster** de Databricks en funcionamiento (si no tienes uno creado, consulta laboratorios anteriores sobre cómo crear un clúster).

#### ¿Qué es un RDD?

**RDD** es la estructura básica de Apache Spark. Representa un conjunto de datos distribuido y tolerante a fallos que puede procesarse en paralelo en diferentes nodos de un clúster. Los RDDs permiten ejecutar transformaciones y acciones de forma eficiente en grandes volúmenes de datos.

Existen dos tipos de operaciones con RDDs:
1. **Transformaciones**: Operaciones que crean nuevos RDDs a partir de otros, como `map()`, `filter()`, y `flatMap()`. Estas transformaciones son "perezosas", lo que significa que no se ejecutan hasta que se realice una acción.
2. **Acciones**: Operaciones que devuelven un valor o escriben datos, como `collect()`, `count()`, y `reduce()`.

---

#### 1. **Crear un RDD desde un Archivo de Texto**

Vamos a empezar creando un RDD a partir de un archivo de texto. Utilizaremos un archivo de texto de ejemplo disponible en DBFS.

```python
# Crear un RDD desde un archivo de texto
rdd = spark.sparkContext.textFile("/databricks-datasets/SPARK_README.md")

# Mostrar las primeras 5 líneas del archivo
rdd.take(5)
```

**Explicación**:
- El método `textFile()` crea un RDD donde cada elemento es una línea del archivo de texto.
- `take(5)` es una **acción** que devuelve las primeras 5 líneas del archivo.

---

#### 2. **Aplicar la Transformación `map()` para Procesar Datos**

El método `map()` transforma cada elemento del RDD aplicando una función a cada uno de ellos. Vamos a dividir cada línea del archivo en palabras.

```python
# Aplicar la transformación map() para dividir cada línea en palabras
rdd_palabras = rdd.map(lambda linea: linea.split(" "))

# Mostrar algunas palabras procesadas
rdd_palabras.take(5)
```

**Explicación**:
- `map()` aplica la función lambda a cada línea, dividiéndola en palabras. El resultado es un nuevo RDD donde cada elemento es una lista de palabras.

---

#### 3. **Filtrar los Elementos del RDD Usando `filter()`**

Vamos a filtrar las líneas que contienen la palabra "Spark".

```python
# Filtrar las líneas que contienen la palabra "Spark"
rdd_filtro = rdd.filter(lambda linea: "Spark" in linea)

# Mostrar las líneas que contienen "Spark"
rdd_filtro.take(5)
```

**Explicación**:
- `filter()` aplica la función lambda y devuelve un nuevo RDD que solo contiene las líneas que cumplen con la condición especificada.

---

#### 4. **Aplicar la Transformación `flatMap()` para Generar una Lista de Palabras**

A diferencia de `map()`, que devuelve una lista por cada entrada, `flatMap()` transforma cada entrada y aplana el resultado en un solo RDD.

```python
# Utilizar flatMap() para aplanar el RDD de palabras
rdd_palabras_planas = rdd.flatMap(lambda linea: linea.split(" "))

# Mostrar algunas de las palabras
rdd_palabras_planas.take(10)
```

**Explicación**:
- `flatMap()` toma cada línea y la divide en palabras, luego aplanando los resultados en un único RDD de palabras.

---

#### 5. **Aplicar la Acción `reduce()` para Contar el Número Total de Palabras**

Usaremos la acción `reduce()` para contar el número total de palabras en el archivo.

```python
# Contar el número total de palabras usando reduce()
total_palabras = rdd_palabras_planas.map(lambda palabra: 1).reduce(lambda a, b: a + b)

# Mostrar el total de palabras
print(f"Total de palabras: {total_palabras}")
```

**Explicación**:
- El primer `map()` convierte cada palabra en un valor de 1.
- Luego, `reduce()` suma todos estos valores para obtener el número total de palabras en el RDD.

---

#### 6. **Aplicar la Acción `collect()` para Recuperar los Resultados**

La acción `collect()` es útil para obtener los datos completos de un RDD a la máquina local, pero debe usarse con precaución, ya que puede sobrecargar la memoria si el RDD es muy grande.

```python
# Recoger todos los resultados en la máquina local
resultados = rdd_palabras_planas.collect()

# Mostrar los primeros 20 resultados
print(resultados[:20])
```

**Explicación**:
- `collect()` trae todos los elementos del RDD al nodo del driver. Es ideal para pequeños conjuntos de datos.

---

#### 7. **Persistir el RDD en Memoria Usando `cache()`**

Cuando un RDD se va a reutilizar varias veces, es recomendable persistirlo en memoria para evitar recalcularlo en cada operación.

```python
# Persistir el RDD en memoria
rdd_palabras_planas.cache()

# Realizar una operación en el RDD persistido
print(rdd_palabras_planas.count())
```

**Explicación**:
- `cache()` persiste el RDD en memoria para que las operaciones futuras sean más rápidas.

---

#### 8. **Guardar los Resultados en DBFS**

Finalmente, puedes guardar el RDD en un archivo de texto dentro del sistema de archivos distribuido de Databricks (DBFS).

```python
# Guardar el RDD en un archivo de texto
rdd_palabras_planas.saveAsTextFile("/dbfs/FileStore/shared_uploads/tu_usuario/palabras.txt")

print("Archivo guardado correctamente.")
```

---

### Conclusión

En este laboratorio, has aprendido a ejecutar varias operaciones básicas con **RDDs** en PySpark, incluyendo transformaciones como `map()`, `filter()`, y `flatMap()`, y acciones como `reduce()` y `collect()`. También hemos explorado cómo persistir datos en memoria con `cache()` y cómo guardar los resultados en **DBFS**. El uso de RDDs es fundamental cuando trabajas con datos grandes y distribuidos en Spark, especialmente cuando deseas realizar operaciones de bajo nivel sobre los datos.