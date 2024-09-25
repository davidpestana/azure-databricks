## Laboratorio: Uso de contextos para manejo de archivos

### Objetivo

En este laboratorio, aprenderás a utilizar correctamente los **contextos** en Python para manejar archivos de manera segura y eficiente. Usar el bloque `with` garantiza que los archivos se cierren automáticamente, lo que es fundamental para evitar fugas de recursos y asegurar que los archivos se manejen adecuadamente, incluso si ocurren errores en el proceso.

---

### Parte 1: Lectura de archivos con `with`

El uso de `with` al abrir archivos simplifica el manejo de archivos al garantizar que se cierren automáticamente después de que se complete el bloque de código.

#### Paso 1: Leer un archivo de texto con `with`

Vamos a leer el contenido de un archivo de texto utilizando `with` para asegurar que el archivo se cierre automáticamente.

1. Crea un archivo Python llamado `leer_con_contexto.py` con el siguiente código:

```python
def leer_archivo_con_contexto(nombre_archivo):
    try:
        with open(nombre_archivo, "r") as archivo:
            contenido = archivo.read()
            return contenido
    except FileNotFoundError:
        print("Error: El archivo no se encontró.")
    except IOError:
        print("Error: Ocurrió un problema al leer el archivo.")
    finally:
        print("Lectura finalizada.")

archivo = "datos.txt"
contenido = leer_archivo_con_contexto(archivo)

if contenido:
    print("Contenido del archivo:")
    print(contenido)
```

#### Explicación:

- Usamos `with` para abrir el archivo, lo que garantiza que se cierre automáticamente al salir del bloque de código.
- En caso de que el archivo no exista o haya un error al leerlo, el código maneja estas excepciones.

### Parte 2: Escritura de archivos con `with`

El uso de `with` para escribir en un archivo es igualmente importante para asegurarse de que el archivo se cierre correctamente, evitando problemas como la pérdida de datos.

#### Paso 2: Escribir en un archivo con `with`

1. Crea un archivo Python llamado `escribir_con_contexto.py` con el siguiente código:

```python
def escribir_archivo_con_contexto(nombre_archivo, contenido):
    try:
        with open(nombre_archivo, "w") as archivo:
            archivo.write(contenido)
    except IOError:
        print("Error: No se pudo escribir en el archivo.")
    finally:
        print("Escritura finalizada.")

contenido = "Este es un ejemplo de texto escrito usando un contexto."
archivo = "salida.txt"
escribir_archivo_con_contexto(archivo, contenido)
```

#### Explicación:

- Al usar `with` para escribir en el archivo, garantizamos que el archivo se cierre correctamente al finalizar la escritura.
- El archivo `salida.txt` contendrá el texto proporcionado en la variable `contenido`.

### Parte 3: Múltiples archivos en un solo bloque `with`

También puedes abrir y manejar múltiples archivos dentro de un solo bloque `with`. Esto es útil cuando necesitas copiar el contenido de un archivo a otro, por ejemplo.

#### Paso 3: Leer de un archivo y escribir en otro

1. Crea un archivo Python llamado `copiar_archivo_con_contexto.py` con el siguiente código:

```python
def copiar_archivo(origen, destino):
    try:
        with open(origen, "r") as archivo_entrada, open(destino, "w") as archivo_salida:
            contenido = archivo_entrada.read()
            archivo_salida.write(contenido)
    except FileNotFoundError:
        print(f"Error: El archivo {origen} no se encontró.")
    except IOError:
        print("Error: Ocurrió un problema al leer o escribir el archivo.")
    finally:
        print("Operación de copia finalizada.")

archivo_origen = "datos.txt"
archivo_destino = "copia_datos.txt"
copiar_archivo(archivo_origen, archivo_destino)
```

#### Explicación:

- Abrimos dos archivos simultáneamente dentro de un solo bloque `with`: uno para leer (`archivo_entrada`) y otro para escribir (`archivo_salida`).
- Copiamos el contenido de `archivo_origen` a `archivo_destino`.
- Como ambos archivos se abren dentro del mismo bloque `with`, ambos se cierran automáticamente cuando finaliza el bloque.

---

### Parte 4: Manejo de archivos binarios con `with`

El manejo de archivos binarios sigue las mismas reglas que los archivos de texto, pero se abre en modo binario usando `"rb"` (lectura binaria) o `"wb"` (escritura binaria).

#### Paso 4: Leer y escribir archivos binarios

1. Crea un archivo Python llamado `copiar_binario_con_contexto.py` para copiar un archivo binario (como una imagen) de un lugar a otro.

```python
def copiar_archivo_binario(origen, destino):
    try:
        with open(origen, "rb") as archivo_entrada, open(destino, "wb") as archivo_salida:
            while True:
                bloque = archivo_entrada.read(1024)
                if not bloque:
                    break
                archivo_salida.write(bloque)
    except FileNotFoundError:
        print(f"Error: El archivo {origen} no se encontró.")
    except IOError:
        print("Error: Ocurrió un problema al leer o escribir el archivo.")
    finally:
        print("Copia del archivo binario finalizada.")

archivo_origen = "imagen.jpg"
archivo_destino = "copia_imagen.jpg"
copiar_archivo_binario(archivo_origen, archivo_destino)
```

#### Explicación:

- Leemos el archivo binario en bloques de 1024 bytes usando un bucle `while` para asegurarnos de no cargar todo el archivo en memoria de una sola vez.
- Tanto el archivo de origen como el de destino se cierran automáticamente cuando el bloque `with` finaliza.

---

### Conclusión del Laboratorio

En este laboratorio, has aprendido a:

1. Utilizar **contextos** (`with`) para manejar archivos de manera segura y eficiente.
2. Garantizar que los archivos se cierren automáticamente utilizando `with`.
3. Abrir y manipular **múltiples archivos** dentro de un solo bloque `with`.
4. Manejar archivos tanto en **modo texto** como en **modo binario**.
5. Asegurar que incluso en caso de errores, los archivos se cierran correctamente para evitar fugas de recursos.

El uso de `with` es fundamental para garantizar que los archivos se manejen de manera segura y eficiente, lo que es crucial en cualquier proyecto de ingeniería de datos donde el procesamiento y manejo de archivos es una tarea común.