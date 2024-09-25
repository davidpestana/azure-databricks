### Laboratorio: Escribir y ejecutar scripts básicos en Python

En este laboratorio, vamos a escribir y ejecutar scripts básicos en Python orientados a la ingeniería de datos. Vamos a trabajar con operaciones de lectura, transformación, y manejo básico de datos utilizando listas, diccionarios y archivos. No utilizaremos bibliotecas externas, todo será con Python puro (vanilla).

#### Objetivos:
1. Escribir un script que manipule datos básicos en listas y diccionarios.
2. Crear un script para leer y escribir datos en un archivo de texto.
3. Iterar sobre los datos para realizar cálculos básicos y transformar la información.

#### Requisitos:
- Tener Python instalado en tu máquina (ver sección "Instalación y configuración de Python").
- Tener un editor de texto (recomendado VS Code, PyCharm o cualquier otro de tu preferencia).
- Acceso a la línea de comandos o terminal.

#### 1. **Escribir y ejecutar un script básico**

Vamos a comenzar con un script simple que manipula una lista de nombres y edades.

##### Paso 1: Crear un archivo Python
1. Abre tu editor de texto.
2. Crea un nuevo archivo y guárdalo con el nombre `manipulacion_datos.py`.

##### Paso 2: Crear una lista de datos
1. En el archivo, comienza creando una lista de diccionarios con información de nombres y edades de personas.
   ```python
   datos = [
       {"nombre": "Carlos", "edad": 25},
       {"nombre": "Ana", "edad": 30},
       {"nombre": "Pedro", "edad": 22},
       {"nombre": "Lucía", "edad": 28}
   ]
   ```

   - **Explicación**: Estamos usando una lista que contiene varios diccionarios. Cada diccionario representa a una persona con su nombre y edad. Esta es una estructura de datos común en la manipulación de información en la ingeniería de datos.

##### Paso 3: Iterar sobre los datos y calcular el promedio de edad
1. Ahora, vamos a calcular la edad promedio de todas las personas en la lista.
   ```python
   total_edad = 0
   for persona in datos:
       total_edad += persona["edad"]
   
   promedio_edad = total_edad / len(datos)
   print(f"La edad promedio es: {promedio_edad}")
   ```

   - **Explicación**: Estamos usando un bucle `for` para iterar sobre la lista de personas y sumando las edades. Al final, calculamos el promedio dividiendo la suma total entre el número de personas (`len(datos)`).

##### Paso 4: Ejecutar el script
1. Guarda el archivo `manipulacion_datos.py`.
2. Abre la terminal o línea de comandos.
3. Navega a la carpeta donde guardaste el archivo y ejecuta el siguiente comando:
   ```bash
   python manipulacion_datos.py
   ```

   - **Explicación**: Este comando ejecuta el script y deberías ver en la salida el promedio de edad calculado.

---

#### 2. **Lectura y escritura de datos en archivos**

Vamos a modificar nuestro script para leer la información desde un archivo de texto y luego escribir el resultado en otro archivo. Este es un proceso muy común en la ingeniería de datos.

##### Paso 1: Crear un archivo de entrada
1. Crea un archivo de texto llamado `datos_personas.txt` en la misma carpeta que el script.
2. Agrega las siguientes líneas en el archivo:
   ```
   Carlos, 25
   Ana, 30
   Pedro, 22
   Lucía, 28
   ```

   - **Explicación**: Este archivo de texto contiene datos simples de personas y sus edades. Vamos a leer este archivo desde nuestro script de Python.

##### Paso 2: Leer datos desde el archivo
1. Modifica el script `manipulacion_datos.py` para leer los datos desde el archivo:
   ```python
   # Abrimos el archivo para leer los datos
   with open("datos_personas.txt", "r") as archivo:
       datos = []
       for linea in archivo:
           nombre, edad = linea.strip().split(", ")
           datos.append({"nombre": nombre, "edad": int(edad)})
   
   print(datos)  # Solo para verificar la lectura de datos
   ```

   - **Explicación**:
     - Usamos `with open()` para abrir el archivo y asegurarnos de que se cierre automáticamente después de usarlo.
     - Iteramos sobre cada línea del archivo, eliminamos espacios en blanco con `strip()`, y dividimos los datos por la coma con `split()`.
     - Creamos un diccionario para cada persona y lo agregamos a la lista `datos`.

##### Paso 3: Calcular la edad promedio y escribir el resultado en un archivo
1. Ahora vamos a escribir el resultado del cálculo en un archivo de salida:
   ```python
   total_edad = 0
   for persona in datos:
       total_edad += persona["edad"]
   
   promedio_edad = total_edad / len(datos)
   
   # Escribimos el resultado en un archivo de salida
   with open("resultado.txt", "w") as archivo_salida:
       archivo_salida.write(f"La edad promedio es: {promedio_edad}\n")
   
   print("Resultado escrito en 'resultado.txt'")
   ```

   - **Explicación**:
     - Después de calcular el promedio, abrimos un nuevo archivo `resultado.txt` en modo escritura (`"w"`).
     - Escribimos el resultado del cálculo en el archivo con el método `write()`.

##### Paso 4: Ejecutar el script y verificar el archivo de salida
1. Guarda los cambios en el archivo `manipulacion_datos.py`.
2. Ejecuta el script de nuevo en la terminal:
   ```bash
   python manipulacion_datos.py
   ```

3. Verifica el archivo `resultado.txt` en la misma carpeta. Debería contener algo como:
   ```
   La edad promedio es: 26.25
   ```

---

#### 3. **Iteración y transformación de datos**

Ahora vamos a transformar los datos y agregar una nueva columna que categorice a las personas según su edad.

##### Paso 1: Categorizar personas según su edad
1. Modifica el script para agregar una nueva clave llamada `categoria` a cada persona. Las categorías serán:
   - "Joven" para personas menores de 25 años.
   - "Adulto" para personas entre 25 y 35 años.
   - "Mayor" para personas mayores de 35 años.

   ```python
   for persona in datos:
       if persona["edad"] < 25:
           persona["categoria"] = "Joven"
       elif 25 <= persona["edad"] <= 35:
           persona["categoria"] = "Adulto"
       else:
           persona["categoria"] = "Mayor"
   
   print(datos)  # Verificamos las categorías agregadas
   ```

   - **Explicación**: Utilizamos condicionales `if` para asignar una categoría a cada persona según su edad.

##### Paso 2: Escribir las personas categorizadas en un archivo
1. Vamos a escribir los datos categorizados en un archivo llamado `personas_categorizadas.txt`:
   ```python
   with open("personas_categorizadas.txt", "w") as archivo_salida:
       for persona in datos:
           archivo_salida.write(f"{persona['nombre']}, {persona['edad']}, {persona['categoria']}\n")
   
   print("Datos categorizados escritos en 'personas_categorizadas.txt'")
   ```

   - **Explicación**: Iteramos sobre la lista `datos` y escribimos el nombre, la edad y la categoría de cada persona en el archivo.

##### Paso 3: Ejecutar y verificar
1. Guarda el script y ejecútalo.
2. Verifica el archivo `personas_categorizadas.txt`, que debería contener:
   ```
   Carlos, 25, Adulto
   Ana, 30, Adulto
   Pedro, 22, Joven
   Lucía, 28, Adulto
   ```

---

### Conclusión del Laboratorio
En este laboratorio, hemos escrito y ejecutado scripts básicos en Python que manipulan datos estructurados. Hemos aprendido a:
1. Crear listas y diccionarios para almacenar datos.
2. Iterar sobre los datos para calcular resultados (como la edad promedio).
3. Leer datos desde un archivo y escribir resultados en otro archivo.
4. Transformar los datos agregando nuevas características (como la categorización por edad).

Estas habilidades son fundamentales para la ingeniería de datos, ya que permiten manipular y transformar información de forma eficiente utilizando Python.