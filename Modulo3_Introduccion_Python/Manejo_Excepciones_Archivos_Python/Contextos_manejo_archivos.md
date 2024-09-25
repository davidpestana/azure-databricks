## Contextos de manejo de archivos

### Uso de `with` para manejar archivos

El uso de la palabra clave `with` es la forma recomendada para manejar archivos en Python. La razón principal es que **automáticamente cierra el archivo** una vez que se completa el bloque de código, incluso si ocurre una excepción. Esto evita fugas de recursos y garantiza que el archivo siempre se cierre correctamente.

#### Ejemplo básico de uso de `with`

```python
with open("archivo.txt", "r") as archivo:
    contenido = archivo.read()
    print(contenido)
```

- **Explicación**: 
  - Al abrir el archivo dentro del bloque `with`, no es necesario llamar a `archivo.close()`, ya que Python lo hará automáticamente por nosotros.

### Ventajas de usar `with`

1. **Gestión automática de recursos**: No tienes que preocuparte por cerrar archivos manualmente.
2. **Código más limpio**: El bloque de código es más fácil de leer y mantener.
3. **Manejo seguro de errores**: Si ocurre una excepción dentro del bloque `with`, el archivo se cierra antes de que se propague el error.

#### Ejemplo con manejo de excepciones

El uso de `with` también se combina bien con el manejo de excepciones:

```python
try:
    with open("archivo.txt", "r") as archivo:
        contenido = archivo.read()
except FileNotFoundError:
    print("Error: El archivo no se encontró.")
except IOError:
    print("Error: Hubo un problema al leer el archivo.")
```

### Múltiples archivos en un solo bloque `with`

Es posible trabajar con múltiples archivos dentro del mismo bloque `with`, lo cual es útil cuando se requiere leer y escribir en diferentes archivos simultáneamente.

#### Ejemplo de lectura y escritura con múltiples archivos

```python
with open("archivo_entrada.txt", "r") as entrada, open("archivo_salida.txt", "w") as salida:
    for linea in entrada:
        salida.write(linea.upper())
```

- **Explicación**:
  - En este ejemplo, estamos leyendo desde `archivo_entrada.txt` y escribiendo su contenido en mayúsculas en `archivo_salida.txt`.
  - Ambos archivos se cierran automáticamente cuando el bloque `with` finaliza.

### Manejo de archivos binarios

El manejo de archivos binarios se realiza de la misma manera que los archivos de texto, pero añadiendo el modo `"b"` (binario) en la apertura del archivo. Esto es útil para manejar archivos de imágenes, videos o cualquier tipo de archivo que no sea texto.

#### Ejemplo de manejo de archivos binarios

```python
with open("imagen.jpg", "rb") as archivo_binario:
    contenido_binario = archivo_binario.read()
```

- **Explicación**: 
  - El modo `"rb"` abre el archivo en modo binario de solo lectura.
  - El archivo se cierra automáticamente cuando el bloque `with` finaliza.

### Escribir archivos binarios

También puedes escribir en archivos binarios usando el modo `"wb"`.

```python
with open("copia_imagen.jpg", "wb") as archivo_copia:
    archivo_copia.write(contenido_binario)
```

- **Explicación**:
  - El modo `"wb"` abre el archivo en modo binario de escritura.
  - En este ejemplo, copiamos el contenido binario de una imagen a otro archivo.

