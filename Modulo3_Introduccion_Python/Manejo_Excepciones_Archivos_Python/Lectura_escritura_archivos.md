## Lectura y escritura de archivos

### Abrir y leer archivos

Python proporciona la función `open()` para abrir archivos. Al abrir un archivo, puedes leer su contenido o escribir en él. El modo de apertura determina qué tipo de operación puedes realizar.

- **Modos de apertura**:
  - `"r"`: lectura (modo predeterminado).
  - `"w"`: escritura (crea el archivo si no existe).
  - `"a"`: agregar al final del archivo.
  - `"b"`: modo binario.

#### Leer archivos de texto

```python
with open("archivo.txt", "r") as archivo:
    contenido = archivo.read()
    print(contenido)
```

El uso de `with` es importante porque garantiza que el archivo se cierre automáticamente después de ser leído.

#### Leer línea por línea

```python
with open("archivo.txt", "r") as archivo:
    for linea in archivo:
        print(linea.strip())
```

### Escribir en archivos

Para escribir en un archivo, utiliza el modo `"w"` o `"a"`. El modo `"w"` sobrescribe el contenido del archivo si ya existe, mientras que `"a"` agrega contenido al final.

```python
with open("archivo.txt", "w") as archivo:
    archivo.write("Este es el contenido del archivo.")
```

#### Escribir varias líneas

```python
lineas = ["Primera línea\n", "Segunda línea\n", "Tercera línea\n"]

with open("archivo.txt", "w") as archivo:
    archivo.writelines(lineas)
```

### Leer y escribir archivos CSV

Los archivos **CSV** son comunes en el procesamiento de datos. Python incluye el módulo `csv` para facilitar la lectura y escritura de este formato.

#### Leer archivos CSV

```python
import csv

with open("datos.csv", "r") as archivo:
    lector_csv = csv.reader(archivo)
    for fila in lector_csv:
        print(fila)
```

#### Escribir archivos CSV

```python
import csv

datos = [["Nombre", "Edad", "Ciudad"], ["Ana", 23, "Madrid"], ["Carlos", 30, "Barcelona"]]

with open("datos.csv", "w", newline="") as archivo:
    escritor_csv = csv.writer(archivo)
    escritor_csv.writerows(datos)
```

### Manejo de errores al trabajar con archivos

Al trabajar con archivos, pueden ocurrir errores si el archivo no existe o si hay problemas de permisos. El manejo de excepciones es útil en estos casos.

```python
try:
    with open("archivo_inexistente.txt", "r") as archivo:
        contenido = archivo.read()
except FileNotFoundError:
    print("Error: El archivo no existe.")
```