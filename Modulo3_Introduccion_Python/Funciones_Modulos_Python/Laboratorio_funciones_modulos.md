# Crear y usar funciones en Python

## Introducción

Las funciones en Python son bloques de código reutilizables que se pueden definir una vez y utilizar múltiples veces. Nos permiten reducir la repetición de código y estructurar el programa de una manera más clara y eficiente. En este laboratorio, exploraremos cómo crear y usar funciones en Python para resolver problemas comunes en el desarrollo orientado a datos.

## Objetivos:

1. Definir y utilizar funciones en Python.
2. Trabajar con parámetros y valores de retorno en funciones.
3. Crear funciones reutilizables para procesar datos.

---

## Laboratorio paso a paso: Crear y usar funciones

### Paso 1: Definir una función básica

1. Vamos a empezar creando una función que reciba dos números y devuelva su suma.

```python
def sumar(a, b):
    return a + b

# Llamada a la función
resultado = sumar(5, 3)
print(f"El resultado de la suma es: {resultado}")
```

- **Explicación**: La función `sumar` toma dos parámetros `a` y `b`, realiza la operación de suma y devuelve el resultado. Luego, llamamos a la función y guardamos el resultado en la variable `resultado`.

### Paso 2: Función para calcular estadísticas básicas

Ahora vamos a crear una función que reciba una lista de datos numéricos y devuelva el total, el promedio y el valor máximo de la lista. Esto es útil en la ingeniería de datos para procesar conjuntos de datos.

1. Definamos una lista de ventas diarias:
   ```python
   ventas = [2500, 3000, 4000, 1500, 2000, 3500, 2800]
   ```

2. Ahora definimos la función `calcular_estadisticas` que realice las operaciones necesarias:
   ```python
   def calcular_estadisticas(datos):
       total = sum(datos)
       promedio = total / len(datos)
       maximo = max(datos)
       return total, promedio, maximo
   ```

3. Llamamos a la función y mostramos el resultado:
   ```python
   total, promedio, maximo = calcular_estadisticas(ventas)
   print(f"Total ventas: {total}, Promedio ventas: {promedio}, Mayor venta: {maximo}")
   ```

- **Explicación**: La función recibe una lista de ventas, calcula el total con `sum()`, el promedio dividiendo el total entre la longitud de la lista con `len()`, y encuentra el valor máximo con `max()`.

---

### Paso 3: Función con valores por defecto

En algunos casos, puedes querer que ciertos parámetros tengan un valor predeterminado si no se proporcionan argumentos. Vamos a crear una función para saludar, donde el valor por defecto del saludo sea "Mundo".

```python
def saludar(nombre="Mundo"):
    return f"Hola, {nombre}!"

# Llamadas a la función
print(saludar())         # Salida: Hola, Mundo!
print(saludar("Ana"))    # Salida: Hola, Ana!
```

- **Explicación**: En esta función, el parámetro `nombre` tiene un valor por defecto de `"Mundo"`, por lo que si no se proporciona un nombre al llamar la función, se utilizará ese valor.

---

### Paso 4: Función que devuelve múltiples valores

Python permite que una función devuelva más de un valor a la vez, lo cual es útil cuando necesitas devolver varios resultados en una sola llamada. Veamos un ejemplo donde devolvemos el total y el promedio de una lista de ventas.

```python
def calcular_totales_y_promedio(ventas):
    total = sum(ventas)
    promedio = total / len(ventas)
    return total, promedio

# Llamada a la función
total_ventas, promedio_ventas = calcular_totales_y_promedio(ventas)
print(f"Total: {total_ventas}, Promedio: {promedio_ventas}")
```

- **Explicación**: La función devuelve dos valores, el total y el promedio de la lista `ventas`. En la llamada a la función, estos dos valores son asignados a las variables `total_ventas` y `promedio_ventas`.

---

### Paso 5: Funciones que procesan listas de diccionarios

Ahora vamos a trabajar con una lista de diccionarios, un formato común en la ingeniería de datos, para mostrar cómo podemos procesar datos más complejos. Supondremos que tenemos una lista de empleados con su nombre y salario.

1. Definamos la lista de empleados:
   ```python
   empleados = [
       {"nombre": "Carlos", "salario": 2500},
       {"nombre": "Ana", "salario": 3000},
       {"nombre": "Lucía", "salario": 3500}
   ]
   ```

2. Vamos a definir una función que calcule el salario total de los empleados:
   ```python
   def calcular_salario_total(empleados):
       total_salario = 0
       for empleado in empleados:
           total_salario += empleado["salario"]
       return total_salario
   ```

3. Llamamos a la función:
   ```python
   total_salario = calcular_salario_total(empleados)
   print(f"Salario total: {total_salario}")
   ```

- **Explicación**: La función recorre la lista de empleados usando un bucle `for` y suma los valores de la clave `"salario"` de cada diccionario. Luego devuelve el salario total.

---

### Paso 6: Función que filtra datos

En la ingeniería de datos, es común necesitar filtrar información según condiciones específicas. Vamos a crear una función que filtre los empleados que tienen un salario mayor a un determinado umbral.

1. Definamos la función `filtrar_empleados_por_salario`:
   ```python
   def filtrar_empleados_por_salario(empleados, salario_minimo):
       empleados_filtrados = []
       for empleado in empleados:
           if empleado["salario"] > salario_minimo:
               empleados_filtrados.append(empleado)
       return empleados_filtrados
   ```

2. Llamemos a la función para obtener los empleados que ganan más de 2800:
   ```python
   empleados_con_alto_salario = filtrar_empleados_por_salario(empleados, 2800)
   print(f"Empleados con salario mayor a 2800: {empleados_con_alto_salario}")
   ```

- **Explicación**: La función toma la lista de empleados y un valor `salario_minimo`. Utiliza un bucle `for` para agregar a una nueva lista solo los empleados cuyo salario es mayor al umbral dado.

---

## Conclusión del Laboratorio

En este laboratorio, hemos aprendido a:

1. Definir y utilizar funciones en Python.
2. Usar parámetros y devolver valores de una función.
3. Crear funciones que procesan listas y listas de diccionarios.
4. Filtrar y calcular datos utilizando funciones.

El uso de funciones es esencial para estructurar y organizar el código en cualquier proyecto de Python, especialmente en la ingeniería de datos, donde el procesamiento eficiente de grandes volúmenes de información es clave. Las funciones permiten que el código sea más claro, modular y reutilizable.