**Laboratorio: Ejecutar celdas de código básico en Python en Databricks**

### Objetivo del laboratorio

El objetivo de este laboratorio es trabajar en la ejecución de celdas de código Python en un notebook de Databricks. Aprenderás a crear y organizar celdas para realizar diferentes operaciones básicas, como operaciones aritméticas, manejo de listas, bucles, y funciones personalizadas. También realizarás tareas más avanzadas como la creación y manipulación de grandes conjuntos de datos.

### Prerrequisitos

- Tener acceso a un workspace de Azure Databricks.
- Permisos para crear y ejecutar un clúster en Databricks.

### Paso 1: Crear un nuevo notebook en Azure Databricks

#### Instrucciones

1. Accede a tu **workspace de Azure Databricks**.
2. Selecciona **Workspace** en la barra lateral.
3. Haz clic en **Create** (Crear) y selecciona **Notebook**.
4. Asigna un nombre como "Ejecutar celdas de código básico en Python".
5. Selecciona **Python** como lenguaje.
6. Selecciona o crea un **clúster** adecuado para ejecutar el notebook.

**Explicación del paso**: El notebook que acabas de crear será donde trabajarás para ejecutar diferentes bloques de código Python. Python es ideal para este tipo de laboratorios, ya que permite realizar operaciones tanto simples como complejas de manera estructurada.

### Paso 2: Operaciones aritméticas y manejo de variables

#### Celda 1: Operaciones básicas en Python

Abre una nueva celda y ejecuta las siguientes operaciones aritméticas. Aquí aprenderás a realizar operaciones matemáticas básicas como suma, resta, multiplicación y división.

```python
# Operaciones aritméticas básicas
a = 10
b = 5

suma = a + b
resta = a - b
multiplicacion = a * b
division = a / b

print(f"Suma: {suma}, Resta: {resta}, Multiplicación: {multiplicacion}, División: {division}")
```

**Por qué crear una celda aquí**: Este bloque de código contiene las operaciones más simples que se pueden ejecutar en Python. Mantenerlo en su propia celda te permite realizar pruebas básicas sin interferir con operaciones más complejas que vienen después.

#### Celda 2: Asignación de variables y su reutilización

En esta nueva celda, reutiliza las variables creadas en la celda anterior para realizar más operaciones.

```python
# Reutilización de variables
resultado = suma * resta
print(f"Resultado de multiplicar suma y resta: {resultado}")
```

**Por qué crear una celda aquí**: La reutilización de variables es importante para comprender cómo se almacenan y manipulan los datos en un entorno interactivo como Databricks. Separar las celdas permite un flujo lógico y te ayuda a corregir errores fácilmente.

### Paso 3: Listas y bucles en Python

#### Celda 3: Crear una lista y aplicar bucles

Vamos a crear una lista de números y aplicar bucles para realizar operaciones con ellos.

```python
# Creación de una lista
lista_numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Iterar sobre la lista para calcular el cuadrado de cada número
cuadrados = []
for numero in lista_numeros:
    cuadrados.append(numero ** 2)

print(f"Números originales: {lista_numeros}")
print(f"Cuadrados de los números: {cuadrados}")
```

**Por qué crear una celda aquí**: Las operaciones con listas y bucles son esenciales en cualquier lenguaje de programación. Al colocarlo en una celda aparte, puedes experimentar con diferentes listas y realizar diversas operaciones sin afectar el código anterior.

#### Celda 4: Bucle `while` en Python

En esta nueva celda, aplicaremos un bucle `while` para sumar todos los números de la lista hasta que se alcance un límite determinado.

```python
# Sumar los números hasta que la suma alcance 30
suma_total = 0
indice = 0

while suma_total <= 30 and indice < len(lista_numeros):
    suma_total += lista_numeros[indice]
    indice += 1

print(f"Suma total hasta alcanzar 30: {suma_total}")
```

**Por qué crear una celda aquí**: El bucle `while` es diferente al bucle `for` en Python, ya que ejecuta el código hasta que se cumple una condición específica. Separarlo en su propia celda te permite concentrarte en entender cómo funciona este tipo de bucle sin interferir con otros tipos de iteraciones.

### Paso 4: Funciones personalizadas

#### Celda 5: Crear una función para calcular factoriales

Ahora, crea una función personalizada en Python que calcule el factorial de un número. Las funciones son fundamentales para estructurar el código y hacer que sea reutilizable.

```python
# Definir una función para calcular el factorial de un número
def factorial(n):
    resultado = 1
    for i in range(1, n+1):
        resultado *= i
    return resultado

# Probar la función con diferentes valores
print(f"Factorial de 5: {factorial(5)}")
print(f"Factorial de 10: {factorial(10)}")
```

**Por qué crear una celda aquí**: Las funciones permiten estructurar mejor el código. Colocarla en una celda separada te permitirá invocar esta función desde cualquier otra celda del notebook y reutilizarla a medida que desarrollas más análisis.

#### Celda 6: Aplicar la función a una lista de números

Vamos a reutilizar la función de factorial para calcular el factorial de una lista de números.

```python
# Aplicar la función factorial a una lista de números
lista_factoriales = [factorial(num) for num in lista_numeros[:5]]  # Solo los primeros 5 números
print(f"Factoriales de los primeros 5 números: {lista_factoriales}")
```

**Por qué crear una celda aquí**: Reutilizar funciones dentro de bucles o en operaciones vectorizadas es una práctica común en Python. Colocar este código en su propia celda permite probar diferentes listas y verificar el comportamiento de la función sin necesidad de reescribirla.

### Paso 5: Crear y manipular datos masivos

#### Celda 7: Generar un conjunto de datos masivo con Spark DataFrames

Ahora vamos a crear un conjunto de datos masivo utilizando Spark para simular datos de ventas. Esta operación es más costosa computacionalmente y debe estar en una celda separada.

```python
# Crear un DataFrame masivo simulado de ventas
df_ventas = spark.range(0, 10000000).selectExpr(
    "id as id_venta",
    "cast(rand() * 100 as double) as precio",
    "cast(rand() * 50 as cantidad"
)
df_ventas.show(5)
```

**Por qué crear una celda aquí**: Generar datos masivos requiere una operación independiente para que puedas reutilizar este DataFrame en las siguientes celdas sin tener que regenerar los datos cada vez. También es útil verificar que el conjunto de datos se creó correctamente.

#### Celda 8: Calcular el valor total de ventas

En esta celda, vamos a realizar una transformación básica en el DataFrame para calcular el valor total de cada venta.

```python
# Calcular el valor total de cada venta
df_ventas = df_ventas.withColumn("valor_total", col("precio") * col("cantidad"))
df_ventas.show(5)
```

**Por qué crear una celda aquí**: Al dividir la creación de datos de las transformaciones, puedes ejecutar las operaciones de transformación en diferentes escenarios sin necesidad de volver a generar los datos. Este es un enfoque eficiente en grandes volúmenes de datos.

### Paso 6: Guardar y verificar los datos

#### Celda 9: Guardar los resultados

Finalmente, guarda los resultados en formato Parquet para futuras consultas.

```python
# Guardar los datos en formato Parquet
df_ventas.write.format("parquet").save("/tmp/ventas.parquet")
```

**Por qué crear una celda aquí**: Guardar los resultados es un paso crítico que debe estar separado de las operaciones de transformación. Esto te permite guardar el estado final de los datos sin tener que volver a ejecutar las operaciones previas.

#### Celda 10: Verificar y leer los datos guardados

En esta última celda, verificamos que los datos se hayan guardado correctamente y los volvemos a leer para su revisión.

```python
# Verificar los archivos guardados
dbutils.fs.ls("/tmp/")

# Leer los datos guardados
df_recuperado = spark.read.format("parquet").load("/tmp/ventas.parquet")
df_recuperado.show(5)
```

**Por qué crear una celda aquí**: La verificación de los datos guardados es fundamental para asegurarte de que todo el proceso se completó correctamente. Mantener esta verificación en una celda separada te permitirá reutilizar el código sin ejecutar de nuevo las transformaciones o el guardado.

### Conclusión del laboratorio

En este laboratorio, has aprendido a:

- Ejecutar operaciones básicas en Python.
- Manipular listas y aplicar bucles.
- Crear funciones personalizadas y reutilizarlas en diferentes contextos.
- Generar y transformar datos masivos utilizando Spark.
- Guard

ar y verificar los resultados de tus operaciones en Databricks.

Este flujo de trabajo modular facilita el desarrollo, la depuración y la reutilización del código en tareas más complejas en futuros laboratorios.