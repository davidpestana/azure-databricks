## Laboratorio: Implementar manejo de excepciones en scripts

### Objetivo

En este laboratorio, aprenderás a implementar correctamente el manejo de excepciones en scripts de Python para prevenir que errores inesperados detengan la ejecución de tu programa.

---

### Paso 1: Crear un archivo Python

1. Crea un archivo llamado `manejo_excepciones.py`.

### Paso 2: Implementar manejo de excepciones para evitar división por cero

En este ejemplo, solicitaremos al usuario dos números para realizar una división. Vamos a manejar los posibles errores, como la división por cero o la introducción de valores no numéricos.

```python
def dividir(a, b):
    try:
        resultado = a / b
    except ZeroDivisionError:
        print("Error: No se puede dividir por cero.")
        return None
    except TypeError:
        print("Error: Ambos valores deben ser números.")
        return None
    else:
        return resultado
    finally:
        print("La operación de división ha terminado.")

# Solicitar al usuario dos números
try:
    num1 = float(input("Introduce el primer número: "))
    num2 = float(input("Introduce el segundo número: "))
    resultado = dividir(num1, num2)
    if resultado is not None:
        print(f"El resultado de la división es: {resultado}")
except ValueError:
    print("Error: Entrada inválida. Debes introducir un número.")
```

#### Explicación:

- La función `dividir` utiliza un bloque `try-except` para manejar posibles excepciones al dividir dos números.
- Los errores que manejamos son:
  - **ZeroDivisionError**: ocurre cuando el usuario intenta dividir por cero.
  - **TypeError**: ocurre si los valores proporcionados no son números.
- El bloque `finally` se ejecuta siempre, asegurando que cualquier tarea de limpieza (como liberar recursos o imprimir mensajes) se realice.
- También incluimos un manejo de excepción `ValueError` para cuando el usuario no introduce un número válido.

### Paso 3: Ejecutar el script

Guarda y ejecuta el archivo `manejo_excepciones.py`. Prueba las siguientes situaciones:

1. Introduce dos números para ver el resultado de una división normal.
2. Introduce un `0` como segundo número para probar el manejo de `ZeroDivisionError`.
3. Introduce un valor no numérico (como una letra) para probar el manejo de `ValueError`.

---

### Paso 4: Manejo de archivos con excepciones

Ahora vamos a crear un script que intente leer un archivo de texto. Si el archivo no existe o si ocurre algún problema durante la lectura, manejaremos el error apropiadamente.

1. Crea un archivo llamado `leer_archivo.py`.

2. Agrega el siguiente código para leer un archivo y manejar las posibles excepciones.

```python
def leer_archivo(nombre_archivo):
    try:
        with open(nombre_archivo, "r") as archivo:
            contenido = archivo.read()
            return contenido
    except FileNotFoundError:
        print("Error: El archivo no se encontró.")
    except IOError:
        print("Error: Ocurrió un problema al leer el archivo.")
    finally:
        print("Operación de lectura finalizada.")

# Solicitar el nombre del archivo al usuario
archivo_a_leer = input("Introduce el nombre del archivo que quieres leer: ")
contenido = leer_archivo(archivo_a_leer)

if contenido:
    print("Contenido del archivo:")
    print(contenido)
```

#### Explicación:

- La función `leer_archivo` abre un archivo usando un bloque `try-except` y maneja las siguientes excepciones:
  - **FileNotFoundError**: ocurre cuando el archivo no existe.
  - **IOError**: ocurre si hay algún problema al leer el archivo, como falta de permisos.
- El bloque `finally` imprime un mensaje para indicar que la operación ha finalizado.

### Paso 5: Ejecutar el script

Guarda y ejecuta el archivo `leer_archivo.py`. Prueba los siguientes escenarios:

1. Introduce el nombre de un archivo que no existe para probar el manejo de `FileNotFoundError`.
2. Si tienes un archivo disponible, introduce su nombre para ver cómo se lee su contenido.

---

## Conclusión del laboratorio

En este laboratorio, has aprendido a:

1. Implementar el manejo de excepciones en scripts para evitar que los errores detengan la ejecución del programa.
2. Manejar diferentes tipos de excepciones, como `ZeroDivisionError`, `TypeError`, `FileNotFoundError` y `ValueError`.
3. Usar bloques `try`, `except`, `else` y `finally` para controlar el flujo del programa.
4. Manejar archivos con seguridad, verificando la existencia del archivo y gestionando cualquier error relacionado.

Este enfoque es fundamental en la ingeniería de datos, donde los errores pueden ocurrir debido a datos inconsistentes o archivos faltantes, y es importante que el programa siga funcionando de manera segura y controlada.