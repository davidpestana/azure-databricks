# Definición y uso de funciones en Python

## Definición de una función

En Python, se define una función utilizando la palabra clave `def`, seguida por el nombre de la función y una lista de parámetros entre paréntesis. El cuerpo de la función se escribe indentado.

### Sintaxis básica:
```python
def nombre_funcion(parámetro1, parámetro2):
    # Código de la función
    return resultado_opcional
```

### Ejemplo básico:
```python
def saludar(nombre):
    return f"Hola, {nombre}!"

print(saludar("Carlos"))  # Salida: Hola, Carlos!
```

---

## Parámetros y argumentos

Los **parámetros** son variables que se definen en la firma de la función, mientras que los **argumentos** son los valores que se pasan a la función cuando se llama.

### Ejemplo con múltiples parámetros:
```python
def sumar(a, b):
    return a + b

resultado = sumar(3, 4)
print(resultado)  # Salida: 7
```

---

## Valores por defecto en funciones

Es posible definir valores por defecto para los parámetros de una función. Si no se proporciona un argumento al llamar la función, se utilizará el valor por defecto.

### Ejemplo de valores por defecto:
```python
def saludar(nombre="Mundo"):
    return f"Hola, {nombre}!"

print(saludar())        # Salida: Hola, Mundo!
print(saludar("Ana"))   # Salida: Hola, Ana!
```

---

## Funciones que no devuelven valor

Las funciones no siempre necesitan devolver un valor. Si no se utiliza `return`, la función devuelve `None` de manera implícita.

### Ejemplo de función sin retorno:
```python
def mostrar_mensaje():
    print("Este es un mensaje.")

mostrar_mensaje()  # Salida: Este es un mensaje.
```

---

## Funciones con múltiples valores de retorno

En Python, es posible que una función devuelva múltiples valores, que se pueden empaquetar como una tupla.

### Ejemplo de múltiples valores de retorno:
```python
def operaciones(a, b):
    suma = a + b
    resta = a - b
    return suma, resta

resultado_suma, resultado_resta = operaciones(5, 3)
print(f"Suma: {resultado_suma}, Resta: {resultado_resta}")
```

---

## Funciones anidadas

Es posible definir funciones dentro de otras funciones. Esto es útil cuando se desea encapsular la lógica dentro de una función específica.

### Ejemplo de funciones anidadas:
```python
def operacion(a, b):
    def sumar(x, y):
        return x + y
    return sumar(a, b)

resultado = operacion(5, 10)
print(resultado)  # Salida: 15
```

---

## Funciones `lambda`

Las funciones `lambda` en Python son funciones anónimas, es decir, funciones que no tienen un nombre. Son útiles cuando necesitamos una función simple y rápida.

### Ejemplo de función `lambda`:
```python
suma = lambda a, b: a + b
print(suma(5, 3))  # Salida: 8
```