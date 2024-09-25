# Módulos y paquetes en Python

## Introducción

Los **módulos** en Python son archivos que contienen código Python, como funciones, clases o variables, y que pueden ser reutilizados en otros programas mediante su importación. Los **paquetes** son colecciones de módulos que se organizan en una estructura de directorios. Este sistema permite organizar el código en fragmentos más manejables y reutilizables.

## 1. ¿Qué es un módulo?

Un **módulo** es un archivo que contiene definiciones y declaraciones en Python. Al dividir el código en módulos, puedes mantener tu código limpio, organizado y reutilizable. Python tiene módulos incorporados que se pueden importar, y también puedes crear tus propios módulos.

### Importar un módulo estándar

Para utilizar funciones o clases de un módulo, es necesario **importarlo** utilizando la palabra clave `import`.

- **Ejemplo: Importar el módulo `math`**:
  
  ```python
  import math

  # Usar la función sqrt() del módulo math
  resultado = math.sqrt(16)
  print(f"La raíz cuadrada de 16 es: {resultado}")  # Salida: La raíz cuadrada de 16 es: 4.0
  ```

En este ejemplo, `math` es un módulo estándar que contiene funciones matemáticas como `sqrt` (raíz cuadrada).

### Importar solo una parte de un módulo

En lugar de importar todo el módulo, también puedes importar funciones específicas de él.

- **Ejemplo: Importar solo la función `sqrt` del módulo `math`**:
  
  ```python
  from math import sqrt

  resultado = sqrt(25)
  print(f"La raíz cuadrada de 25 es: {resultado}")  # Salida: La raíz cuadrada de 25 es: 5.0
  ```

---

## 2. Crear un módulo propio

Puedes crear un **módulo propio** al guardar funciones, clases o variables en un archivo con la extensión `.py`. Luego puedes importar y utilizar ese módulo en otros scripts.

### Paso 1: Crear el módulo

1. Crea un archivo llamado `mi_modulo.py` con la siguiente función:

   ```python
   # mi_modulo.py
   def saludar(nombre):
       return f"Hola, {nombre}!"
   ```

### Paso 2: Importar el módulo

1. Crea un nuevo archivo Python y utiliza el módulo que acabas de crear:

   ```python
   import mi_modulo

   mensaje = mi_modulo.saludar("Ana")
   print(mensaje)  # Salida: Hola, Ana!
   ```

---

## 3. Paquetes en Python

Un **paquete** es una colección de módulos organizados en una estructura de carpetas. Para crear un paquete, se necesita una carpeta con un archivo especial llamado `__init__.py`. Los paquetes permiten organizar módulos relacionados y reutilizarlos en proyectos más grandes.

### Crear un paquete

1. **Paso 1**: Crea una carpeta con el nombre del paquete, por ejemplo `mi_paquete`.

2. **Paso 2**: Dentro de la carpeta `mi_paquete`, crea el archivo `__init__.py` (puede estar vacío o contener código).

3. **Paso 3**: Crea otros módulos dentro de la carpeta `mi_paquete`, como `modulo1.py`.

   ```python
   # mi_paquete/modulo1.py
   def sumar(a, b):
       return a + b
   ```

4. **Paso 4**: Crea un archivo Python en otra ubicación y usa el paquete.

   ```python
   from mi_paquete import modulo1

   resultado = modulo1.sumar(10, 5)
   print(f"El resultado de la suma es: {resultado}")  # Salida: El resultado de la suma es: 15
   ```

---

## 4. Importación relativa y absoluta

Cuando trabajas dentro de paquetes, existen dos tipos de importaciones: **absolutas** y **relativas**.

- **Importación absoluta**: Hace referencia al módulo desde la raíz del paquete.
  
  ```python
  import mi_paquete.modulo1
  ```

- **Importación relativa**: Utiliza `.` y `..` para indicar rutas relativas dentro del paquete.

  ```python
  from . import modulo1
  ```

Las importaciones relativas se usan comúnmente cuando quieres importar un módulo dentro del mismo paquete.

---

## 5. Módulos integrados más utilizados

Python viene con una gran cantidad de módulos incorporados. Algunos de los más utilizados son:

- **`os`**: Permite interactuar con el sistema operativo (lectura de archivos, rutas, directorios).
  
  ```python
  import os

  print(os.getcwd())  # Imprime el directorio actual
  ```

- **`sys`**: Proporciona funciones y variables relacionadas con el intérprete de Python.

  ```python
  import sys

  print(sys.version)  # Imprime la versión de Python
  ```

- **`random`**: Genera números aleatorios.

  ```python
  import random

  print(random.randint(1, 10))  # Genera un número aleatorio entre 1 y 10
  ```

---

## Conclusión

Los módulos y paquetes son herramientas fundamentales en Python para organizar y reutilizar código de manera eficiente. Los módulos permiten dividir el código en unidades manejables, mientras que los paquetes ayudan a organizar módulos relacionados en una estructura jerárquica. Además, Python cuenta con una vasta biblioteca estándar de módulos listos para ser utilizados en cualquier proyecto.
