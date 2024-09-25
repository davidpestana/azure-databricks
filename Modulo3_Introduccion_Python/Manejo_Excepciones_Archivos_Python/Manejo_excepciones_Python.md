## Manejo de Excepciones en Python

### ¿Qué es una excepción?

Una excepción es un error que ocurre durante la ejecución de un programa. Python genera automáticamente excepciones cuando el código encuentra una condición que no puede manejar. Las excepciones comunes incluyen `ZeroDivisionError`, `FileNotFoundError`, `TypeError`, entre otras.

### Sintaxis básica para manejar excepciones

En Python, las excepciones se manejan utilizando las palabras clave `try`, `except`, `else` y `finally`.

```python
try:
    # Código que puede generar una excepción
except NombreExcepcion:
    # Código que se ejecuta si ocurre la excepción
else:
    # Código que se ejecuta si no ocurre ninguna excepción
finally:
    # Código que se ejecuta siempre, ocurra o no la excepción
```

- **`try`**: El bloque donde se coloca el código que puede generar una excepción.
- **`except`**: El bloque que se ejecuta si ocurre una excepción.
- **`else`**: (Opcional) El bloque que se ejecuta si no ocurre ninguna excepción.
- **`finally`**: (Opcional) El bloque que siempre se ejecuta, tanto si ocurre una excepción como si no.

### Ejemplo básico

```python
try:
    numero = int(input("Introduce un número: "))
    resultado = 10 / numero
    print(f"El resultado es: {resultado}")
except ZeroDivisionError:
    print("Error: No se puede dividir entre cero.")
except ValueError:
    print("Error: Entrada inválida, no es un número.")
else:
    print("El cálculo se realizó correctamente.")
finally:
    print("Fin del bloque try-except.")
```

### Capturar múltiples excepciones

Puedes manejar múltiples excepciones en el mismo bloque `try` utilizando varios bloques `except`.

```python
try:
    numero = int(input("Introduce un número: "))
    resultado = 10 / numero
except (ValueError, ZeroDivisionError) as e:
    print(f"Ha ocurrido un error: {e}")
```

### Levantar excepciones manualmente

En algunos casos, es útil **levantar excepciones manualmente** para controlar mejor el flujo del programa. Esto se hace utilizando la palabra clave `raise`.

```python
def dividir(a, b):
    if b == 0:
        raise ValueError("El divisor no puede ser cero.")
    return a / b

try:
    resultado = dividir(10, 0)
except ValueError as e:
    print(f"Error: {e}")
```

### Excepciones personalizadas

Puedes definir tus propias excepciones creando clases que hereden de la clase base `Exception`.

```python
class MiExcepcion(Exception):
    pass

try:
    raise MiExcepcion("Ha ocurrido un error personalizado.")
except MiExcepcion as e:
    print(f"Error personalizado: {e}")
```

