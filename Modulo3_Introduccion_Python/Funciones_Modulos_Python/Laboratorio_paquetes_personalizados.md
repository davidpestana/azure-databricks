# Crear y usar paquetes personalizados

## Introducción

En Python, los **paquetes** son una forma de organizar y estructurar el código en módulos reutilizables. Un paquete es básicamente una carpeta que contiene varios módulos y un archivo especial `__init__.py`. Esta estructura ayuda a organizar proyectos de gran escala y permite reutilizar código en diferentes partes del proyecto o en otros proyectos.

En este laboratorio, aprenderemos a crear nuestros propios paquetes, organizarlos de manera eficiente y utilizarlos en proyectos más grandes. Este enfoque es crucial en la ingeniería de datos, donde el procesamiento, análisis y transformación de datos a menudo se realiza en varias etapas.

---

## Objetivos:

1. Aprender a crear paquetes personalizados en Python.
2. Utilizar módulos dentro de un paquete.
3. Organizar el código en varios archivos y módulos para mantener proyectos grandes y complejos.

---

## Laboratorio paso a paso: Crear y usar paquetes personalizados

### Paso 1: Crear la estructura básica del paquete

Para crear un paquete en Python, debemos crear una carpeta que contenga un archivo `__init__.py` (este archivo puede estar vacío, pero debe existir). También podemos crear módulos adicionales dentro de esa carpeta.

#### Estructura básica del paquete

1. Crea una carpeta para el paquete, por ejemplo, `mi_paquete`.
2. Dentro de esa carpeta, crea un archivo vacío llamado `__init__.py`.
3. Agrega otros archivos Python (módulos) dentro de la carpeta, como `operaciones.py`.

La estructura será la siguiente:

```
mi_paquete/
    __init__.py
    operaciones.py
```

---

### Paso 2: Definir funciones en los módulos del paquete

Vamos a definir funciones dentro de los módulos que hemos creado en la carpeta `mi_paquete`. Empezaremos con el módulo `operaciones.py`, que contendrá funciones matemáticas.

1. Dentro del archivo `operaciones.py`, agrega las siguientes funciones:

```python
# mi_paquete/operaciones.py

def sumar(a, b):
    return a + b

def restar(a, b):
    return a - b

def multiplicar(a, b):
    return a * b

def dividir(a, b):
    if b == 0:
        return "Error: División por cero no permitida"
    return a / b
```

- **Explicación**: 
   - Hemos definido cuatro funciones: `sumar`, `restar`, `multiplicar` y `dividir`. Estas funciones realizan operaciones matemáticas simples. La función `dividir` incluye un control para evitar la división por cero.

---

### Paso 3: Importar y usar el paquete en otro script

Ahora que tenemos nuestro paquete `mi_paquete` con el módulo `operaciones.py`, podemos usarlo en otro script. Vamos a importar las funciones de este módulo y utilizarlas en un nuevo archivo.

1. Crea un archivo Python fuera de la carpeta `mi_paquete`, por ejemplo, `usar_paquete.py`.
2. En este archivo, importa el módulo y usa las funciones que definimos:

```python
# usar_paquete.py

from mi_paquete import operaciones

# Usar las funciones del paquete
resultado_suma = operaciones.sumar(5, 3)
resultado_resta = operaciones.restar(10, 4)
resultado_multiplicacion = operaciones.multiplicar(6, 7)
resultado_division = operaciones.dividir(8, 2)

print(f"Suma: {resultado_suma}")
print(f"Resta: {resultado_resta}")
print(f"Multiplicación: {resultado_multiplicacion}")
print(f"División: {resultado_division}")
```

3. Ejecuta el archivo en tu terminal:

   ```bash
   python usar_paquete.py
   ```

- **Explicación**: 
   - Hemos importado el módulo `operaciones` desde el paquete `mi_paquete` usando `from mi_paquete import operaciones`. Luego, utilizamos las funciones `sumar`, `restar`, `multiplicar` y `dividir` como si estuvieran definidas directamente en el script, pero en realidad vienen de nuestro paquete personalizado.

---

### Paso 4: Añadir más módulos al paquete

Un paquete puede tener varios módulos, lo que permite organizar funciones y clases de acuerdo con su propósito. Vamos a añadir otro módulo a nuestro paquete llamado `estadisticas.py`, que contendrá funciones para trabajar con listas de números.

1. Crea un archivo llamado `estadisticas.py` dentro de la carpeta `mi_paquete`.

2. Agrega las siguientes funciones al archivo `estadisticas.py`:

```python
# mi_paquete/estadisticas.py

def calcular_promedio(numeros):
    if len(numeros) == 0:
        return 0
    return sum(numeros) / len(numeros)

def calcular_mediana(numeros):
    numeros_ordenados = sorted(numeros)
    n = len(numeros)
    mitad = n // 2
    if n % 2 == 0:
        return (numeros_ordenados[mitad - 1] + numeros_ordenados[mitad]) / 2
    else:
        return numeros_ordenados[mitad]

def calcular_maximo(numeros):
    return max(numeros)

def calcular_minimo(numeros):
    return min(numeros)
```

- **Explicación**: 
   - Hemos añadido funciones para calcular el promedio, la mediana, el valor máximo y el valor mínimo de una lista de números. Cada función realiza una operación diferente y se basa en la lista de entrada proporcionada.

---

### Paso 5: Usar las funciones del nuevo módulo

Vamos a modificar nuestro archivo `usar_paquete.py` para utilizar las funciones del nuevo módulo `estadisticas.py`.

1. Abre el archivo `usar_paquete.py` y agrega las importaciones para el nuevo módulo `estadisticas`:

```python
# usar_paquete.py

from mi_paquete import operaciones
from mi_paquete import estadisticas

# Usar las funciones del módulo operaciones
resultado_suma = operaciones.sumar(5, 3)
resultado_resta = operaciones.restar(10, 4)

print(f"Suma: {resultado_suma}")
print(f"Resta: {resultado_resta}")

# Usar las funciones del módulo estadisticas
numeros = [10, 20, 30, 40, 50]

promedio = estadisticas.calcular_promedio(numeros)
mediana = estadisticas.calcular_mediana(numeros)
maximo = estadisticas.calcular_maximo(numeros)
minimo = estadisticas.calcular_minimo(numeros)

print(f"Promedio: {promedio}")
print(f"Mediana: {mediana}")
print(f"Máximo: {maximo}")
print(f"Mínimo: {minimo}")
```

2. Ejecuta el archivo en tu terminal:

   ```bash
   python usar_paquete.py
   ```

- **Explicación**: 
   - Ahora estamos utilizando funciones de dos módulos diferentes dentro del mismo paquete: `operaciones.py` y `estadisticas.py`. Esto nos permite dividir el código en módulos pequeños y reutilizables, mejorando la organización y la escalabilidad del proyecto.

---

### Paso 6: Organizar el paquete en submódulos

A medida que el proyecto crece, es posible que desees organizar los módulos dentro de **submódulos** (carpetas adicionales dentro del paquete principal). Esto proporciona aún más organización, especialmente en proyectos grandes.

1. Dentro de la carpeta `mi_paquete`, crea una nueva carpeta llamada `avanzado`.
2. Dentro de la carpeta `avanzado`, crea un archivo `__init__.py` y otro archivo `matematicas_avanzadas.py`.
3. En `matematicas_avanzadas.py`, agrega las siguientes funciones:

```python
# mi_paquete/avanzado/matematicas_avanzadas.py

def potencia(base, exponente):
    return base ** exponente

def raiz_cuadrada(numero):
    return numero ** 0.5
```

4. En `usar_paquete.py`, importa y usa las funciones del submódulo:

```python
from mi_paquete.avanzado import matematicas_avanzadas

# Usar funciones del submódulo avanzado
resultado_potencia = matematicas_avanzadas.potencia(2, 3)
resultado_raiz = matematicas_avanzadas.raiz_cuadrada(16)

print(f"2 elevado a 3: {resultado_potencia}")
print(f"Raíz cuadrada de 16: {resultado_raiz}")
```

---

## Conclusión del Laboratorio

En este laboratorio, hemos aprendido a:

1. Crear y organizar paquetes personalizados en Python.
2. Utilizar múltiples módulos dentro de un paquete.
3. Organizar el código en submódulos para mantener el proyecto escalable y bien estructurado.

La organización del código en paquetes y módulos es una práctica clave en la programación modular, especialmente en proyectos de ingeniería de datos donde la reutilización y la organización son fundamentales para el éxito de proyectos grandes.