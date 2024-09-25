## Laboratorio: Leer y escribir archivos de texto y CSV

### Objetivo

En este laboratorio, aprenderás a leer y escribir archivos de texto y CSV utilizando Python. Los archivos de texto se utilizan comúnmente para almacenar datos simples, mientras que los archivos CSV son ampliamente utilizados en la ingeniería de datos para almacenar conjuntos de datos tabulares.

---

### Parte 1: Leer y escribir archivos de texto

#### Paso 1: Leer un archivo de texto

Vamos a leer el contenido de un archivo de texto llamado `datos.txt`. Supongamos que este archivo contiene información simple, como nombres en cada línea.

1. Crea un archivo llamado `datos.txt` con el siguiente contenido:

```
Carlos
Ana
Pedro
Lucía
```

2. Crea un archivo Python llamado `leer_archivo_texto.py` y añade el siguiente código para leer el contenido del archivo:

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

archivo = "datos.txt"
contenido = leer_archivo(archivo)

if contenido:
    print("Contenido del archivo:")
    print(contenido)
```

#### Explicación:

- Utilizamos `with open()` para abrir el archivo en modo lectura (`"r"`).
- Si el archivo no se encuentra o si ocurre algún problema durante la lectura, el código maneja esas excepciones.
- Después de leer el archivo, el contenido se imprime en pantalla.

#### Paso 2: Escribir en un archivo de texto

Vamos a escribir el contenido de una lista en un archivo de texto.

1. Crea un archivo Python llamado `escribir_archivo_texto.py` con el siguiente código:

```python
def escribir_archivo(nombre_archivo, lineas):
    try:
        with open(nombre_archivo, "w") as archivo:
            archivo.writelines(lineas)
    except IOError:
        print("Error: No se pudo escribir en el archivo.")
    finally:
        print("Operación de escritura finalizada.")

nombres = ["Carlos\n", "Ana\n", "Pedro\n", "Lucía\n"]
archivo = "nuevos_nombres.txt"
escribir_archivo(archivo, nombres)
```

#### Explicación:

- Utilizamos el modo `"w"` para escribir en el archivo, lo que sobrescribirá cualquier contenido anterior.
- El método `writelines()` escribe cada elemento de la lista `nombres` en una nueva línea del archivo.

---

### Parte 2: Leer y escribir archivos CSV

Los archivos CSV (Comma Separated Values) se utilizan para almacenar datos en formato tabular y son muy populares en el análisis de datos. Python tiene un módulo integrado llamado `csv` que facilita el trabajo con este tipo de archivos.

#### Paso 1: Leer un archivo CSV

Vamos a leer un archivo CSV que contiene información de productos.

1. Crea un archivo CSV llamado `productos.csv` con el siguiente contenido:

```
Producto,Precio,Cantidad
Manzana,0.5,10
Banana,0.3,25
Pera,1.2,15
```

2. Crea un archivo Python llamado `leer_archivo_csv.py` con el siguiente código:

```python
import csv

def leer_csv(nombre_archivo):
    try:
        with open(nombre_archivo, "r") as archivo:
            lector_csv = csv.reader(archivo)
            for fila in lector_csv:
                print(fila)
    except FileNotFoundError:
        print("Error: El archivo no se encontró.")
    except IOError:
        print("Error: Ocurrió un problema al leer el archivo.")
    finally:
        print("Operación de lectura del archivo CSV finalizada.")

archivo_csv = "productos.csv"
leer_csv(archivo_csv)
```

#### Explicación:

- Utilizamos `csv.reader()` para leer el archivo CSV.
- Cada fila se imprime como una lista de elementos.
- Manejamos excepciones si el archivo no existe o si ocurre un error al leer el archivo.

#### Paso 2: Escribir en un archivo CSV

Vamos a escribir una lista de datos en un archivo CSV.

1. Crea un archivo Python llamado `escribir_archivo_csv.py` con el siguiente código:

```python
import csv

def escribir_csv(nombre_archivo, datos):
    try:
        with open(nombre_archivo, "w", newline="") as archivo:
            escritor_csv = csv.writer(archivo)
            escritor_csv.writerows(datos)
    except IOError:
        print("Error: No se pudo escribir en el archivo CSV.")
    finally:
        print("Operación de escritura del archivo CSV finalizada.")

datos = [["Producto", "Precio", "Cantidad"], ["Manzana", 0.5, 10], ["Banana", 0.3, 25], ["Pera", 1.2, 15]]
archivo_csv = "nuevos_productos.csv"
escribir_csv(archivo_csv, datos)
```

#### Explicación:

- El método `csv.writer()` se usa para escribir datos en un archivo CSV.
- La función `writerows()` escribe una lista de listas, donde cada sublista representa una fila del archivo CSV.
- Utilizamos `newline=""` para evitar que se inserten líneas en blanco entre las filas en algunos sistemas.

---

### Parte 3: Manejo de errores al trabajar con archivos CSV

Es importante manejar correctamente los errores al trabajar con archivos CSV, ya que podrían faltar datos o el archivo podría estar mal formateado.

1. Crea un archivo Python llamado `manejo_errores_csv.py` con el siguiente código:

```python
import csv

def leer_csv_seguro(nombre_archivo):
    try:
        with open(nombre_archivo, "r") as archivo:
            lector_csv = csv.reader(archivo)
            for fila in lector_csv:
                if len(fila) != 3:  # Verifica que cada fila tenga 3 columnas
                    raise ValueError("Fila con formato incorrecto")
                print(fila)
    except FileNotFoundError:
        print("Error: El archivo no se encontró.")
    except ValueError as e:
        print(f"Error en el formato de datos: {e}")
    except IOError:
        print("Error: Ocurrió un problema al leer el archivo.")
    finally:
        print("Operación de lectura segura del archivo CSV finalizada.")

archivo_csv = "productos.csv"
leer_csv_seguro(archivo_csv)
```

#### Explicación:

- En este ejemplo, verificamos que cada fila tenga el número correcto de columnas y lanzamos una excepción `ValueError` si el formato no es correcto.
- Manejamos las excepciones de manera adecuada para asegurar que el programa no falle.

---

## Conclusión del Laboratorio

En este laboratorio, has aprendido a:

1. Leer y escribir archivos de texto utilizando los modos `"r"` y `"w"`.
2. Leer y escribir archivos CSV utilizando el módulo `csv`.
3. Manejar excepciones adecuadamente al trabajar con archivos, garantizando que el programa sea robusto ante errores.

Estas habilidades son fundamentales en la ingeniería de datos, ya que trabajar con archivos es una de las tareas más comunes en este campo. Los archivos CSV, en particular, son ampliamente utilizados para almacenar y procesar grandes volúmenes de datos estructurados.