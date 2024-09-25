# Importar y usar módulos estándar

## Introducción

Python incluye una amplia variedad de **módulos estándar** que proporcionan funcionalidades útiles y especializadas, como matemáticas avanzadas, manipulación de archivos, manejo de fechas, generación de números aleatorios, entre otros. Estos módulos forman parte de la biblioteca estándar de Python y están disponibles para ser utilizados sin necesidad de instalar nada adicional.

En este laboratorio, aprenderemos cómo importar y utilizar algunos de los módulos estándar más comunes en Python, los cuales son especialmente útiles para el manejo y procesamiento de datos.

## Objetivos:

1. Importar y usar módulos estándar de Python como `math`, `datetime`, `random` y `os`.
2. Aplicar estos módulos en ejemplos prácticos relacionados con la ingeniería de datos.
3. Comprender cómo funcionan los métodos más comunes de estos módulos para resolver problemas.

---

## Laboratorio paso a paso: Importar y usar módulos estándar

### Paso 1: Uso del módulo `math` para cálculos matemáticos

El módulo **`math`** incluye una serie de funciones para realizar cálculos matemáticos avanzados. Esto es especialmente útil cuando necesitas trabajar con operaciones matemáticas como raíces cuadradas, potencias o logaritmos.

1. Crea un archivo llamado `calculos_matematicos.py`.
2. Importa el módulo `math` y usa algunas de sus funciones:

```python
import math

# Raíz cuadrada
print(f"La raíz cuadrada de 16 es: {math.sqrt(16)}")

# Potencia (2 elevado a 3)
print(f"2 elevado a 3 es: {math.pow(2, 3)}")

# Logaritmo natural
print(f"El logaritmo natural de 2 es: {math.log(2)}")
```

3. Ejecuta el archivo en tu terminal:
   ```bash
   python calculos_matematicos.py
   ```

- **Explicación**: 
   - `math.sqrt()` calcula la raíz cuadrada.
   - `math.pow()` eleva un número a una potencia.
   - `math.log()` devuelve el logaritmo natural de un número.

---

### Paso 2: Uso del módulo `datetime` para trabajar con fechas y horas

El módulo **`datetime`** permite trabajar con fechas y horas. Este es un módulo fundamental en proyectos de ingeniería de datos que requieren el análisis de datos temporales.

1. Crea un archivo llamado `manejo_fechas.py`.
2. Importa el módulo `datetime` y usa algunas de sus funciones:

```python
import datetime

# Obtener la fecha y hora actual
ahora = datetime.datetime.now()
print(f"Fecha y hora actual: {ahora}")

# Crear una fecha específica
fecha = datetime.date(2022, 12, 25)
print(f"Fecha específica: {fecha}")

# Formatear una fecha en un formato legible
fecha_formateada = ahora.strftime("%d/%m/%Y, %H:%M:%S")
print(f"Fecha formateada: {fecha_formateada}")
```

3. Ejecuta el archivo en tu terminal:
   ```bash
   python manejo_fechas.py
   ```

- **Explicación**:
   - `datetime.datetime.now()` devuelve la fecha y hora actual.
   - `datetime.date(año, mes, día)` crea una fecha específica.
   - `strftime()` permite formatear una fecha para que se muestre en un formato más amigable, como `dd/mm/yyyy`.

---

### Paso 3: Uso del módulo `random` para generar números aleatorios

El módulo **`random`** es muy útil cuando necesitas generar números aleatorios o realizar selecciones aleatorias de una lista. Esto se usa comúnmente en pruebas, simulaciones y procesamiento de datos.

1. Crea un archivo llamado `generar_aleatorios.py`.
2. Importa el módulo `random` y usa algunas de sus funciones:

```python
import random

# Generar un número aleatorio entre 1 y 10
numero_aleatorio = random.randint(1, 10)
print(f"Número aleatorio entre 1 y 10: {numero_aleatorio}")

# Seleccionar un elemento aleatorio de una lista
colores = ["rojo", "azul", "verde", "amarillo"]
color_aleatorio = random.choice(colores)
print(f"Color aleatorio seleccionado: {color_aleatorio}")

# Mezclar una lista de elementos
random.shuffle(colores)
print(f"Colores después de mezclar: {colores}")
```

3. Ejecuta el archivo en tu terminal:
   ```bash
   python generar_aleatorios.py
   ```

- **Explicación**:
   - `random.randint(a, b)` genera un número entero aleatorio entre `a` y `b`.
   - `random.choice(lista)` selecciona un elemento aleatorio de la lista.
   - `random.shuffle(lista)` mezcla los elementos de una lista en orden aleatorio.

---

### Paso 4: Uso del módulo `os` para interactuar con el sistema operativo

El módulo **`os`** permite interactuar con el sistema operativo, lo que incluye tareas como la lectura y escritura de archivos, la creación de directorios, y la obtención de información sobre el sistema. Este módulo es clave cuando trabajas con grandes volúmenes de datos almacenados en archivos.

1. Crea un archivo llamado `interaccion_sistema.py`.
2. Importa el módulo `os` y usa algunas de sus funciones:

```python
import os

# Obtener el directorio actual de trabajo
directorio_actual = os.getcwd()
print(f"Directorio actual de trabajo: {directorio_actual}")

# Listar los archivos en el directorio actual
archivos = os.listdir(directorio_actual)
print(f"Archivos en el directorio: {archivos}")

# Crear un nuevo directorio
nuevo_directorio = "nueva_carpeta"
if not os.path.exists(nuevo_directorio):
    os.mkdir(nuevo_directorio)
    print(f"Directorio '{nuevo_directorio}' creado.")
else:
    print(f"El directorio '{nuevo_directorio}' ya existe.")
```

3. Ejecuta el archivo en tu terminal:
   ```bash
   python interaccion_sistema.py
   ```

- **Explicación**:
   - `os.getcwd()` devuelve el directorio actual donde se está ejecutando el script.
   - `os.listdir()` lista los archivos y carpetas en el directorio.
   - `os.mkdir()` crea un nuevo directorio.

---

## Conclusión del Laboratorio

En este laboratorio, hemos aprendido a importar y usar módulos estándar de Python como `math`, `datetime`, `random`, y `os`, los cuales son muy útiles para realizar tareas comunes en el desarrollo de software y la ingeniería de datos. 

- **`math`**: Proporciona funciones matemáticas avanzadas.
- **`datetime`**: Permite manipular fechas y horas.
- **`random`**: Genera números aleatorios y realiza selecciones aleatorias.
- **`os`**: Facilita la interacción con el sistema operativo, como la manipulación de archivos y directorios.

Estos módulos forman parte de la **biblioteca estándar** de Python, lo que significa que no necesitas instalarlos. El conocimiento de estos módulos te permitirá escribir programas más eficientes y realizar tareas de manera más simple en tus proyectos de ingeniería de datos.