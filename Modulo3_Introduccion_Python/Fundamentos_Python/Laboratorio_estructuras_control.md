### Laboratorio: Uso de estructuras de control (if, for, while)

En este laboratorio, nos centraremos en aprender cómo utilizar las estructuras de control en Python (como condicionales y bucles) para manipular y procesar datos. Todas las prácticas estarán orientadas a la manipulación de datos de forma iterativa, sin el uso de bibliotecas externas.

#### Objetivos:
1. Aprender a utilizar las estructuras de control `if`, `for` y `while` para tomar decisiones y procesar datos.
2. Aplicar estas estructuras en situaciones reales de manipulación de datos, como filtrar, clasificar y transformar información.

#### Requisitos:
- Tener Python instalado en tu máquina.
- Un editor de texto (VS Code, PyCharm, etc.).
- Acceso a la línea de comandos o terminal.

#### 1. **Uso de `if` para filtrar datos**

En muchas situaciones de ingeniería de datos, es necesario filtrar datos en función de condiciones específicas. Usaremos la estructura condicional `if` para filtrar una lista de datos.

##### Paso 1: Crear un archivo de script
1. Abre tu editor de texto y crea un nuevo archivo llamado `filtrar_datos.py`.

##### Paso 2: Definir una lista de datos
1. Vamos a trabajar con una lista de datos que contiene información sobre empleados, incluyendo su nombre, edad y salario.
   ```python
   empleados = [
       {"nombre": "Carlos", "edad": 45, "salario": 3000},
       {"nombre": "Ana", "edad": 22, "salario": 2000},
       {"nombre": "Pedro", "edad": 35, "salario": 4000},
       {"nombre": "Lucía", "edad": 30, "salario": 3500},
       {"nombre": "Juan", "edad": 40, "salario": 5000}
   ]
   ```

   - **Explicación**: Esta lista de diccionarios contiene datos de empleados. Vamos a filtrar empleados con base en diferentes criterios utilizando estructuras de control.

##### Paso 3: Filtrar empleados por salario
1. Usa una estructura `if` para seleccionar empleados con un salario mayor a 3500.
   ```python
   empleados_alto_salario = []
   for empleado in empleados:
       if empleado["salario"] > 3500:
           empleados_alto_salario.append(empleado)

   print("Empleados con salario mayor a 3500:")
   for emp in empleados_alto_salario:
       print(emp)
   ```

   - **Explicación**: Utilizamos un bucle `for` para recorrer la lista de empleados y un `if` para filtrar aquellos cuyo salario es mayor a 3500. Los empleados filtrados se agregan a una nueva lista.

##### Paso 4: Ejecutar el script
1. Guarda el archivo y ejecuta el siguiente comando en la terminal:
   ```bash
   python filtrar_datos.py
   ```

2. La salida debería mostrar solo los empleados con un salario mayor a 3500.

---

#### 2. **Uso de bucles `for` para manipular datos**

Los bucles `for` son fundamentales para recorrer secuencias de datos y realizar operaciones en cada elemento. Vamos a usar un bucle `for` para sumar los salarios de todos los empleados y encontrar el promedio salarial.

##### Paso 1: Sumar los salarios de los empleados
1. Añade el siguiente código a tu script para calcular el salario total:
   ```python
   salario_total = 0
   for empleado in empleados:
       salario_total += empleado["salario"]

   print(f"El salario total de todos los empleados es: {salario_total}")
   ```

   - **Explicación**: Este bucle `for` recorre cada empleado en la lista y suma sus salarios, almacenando el resultado en `salario_total`.

##### Paso 2: Calcular el salario promedio
1. Después de sumar los salarios, calcula el promedio salarial:
   ```python
   promedio_salarial = salario_total / len(empleados)
   print(f"El salario promedio es: {promedio_salarial}")
   ```

   - **Explicación**: Dividimos el salario total entre la cantidad de empleados usando `len(empleados)`.

##### Paso 3: Ejecutar el script
1. Guarda el archivo y ejecútalo de nuevo para ver el salario total y el promedio salarial.

---

#### 3. **Uso de bucles `while` para realizar operaciones repetitivas**

A veces es necesario realizar operaciones repetitivas mientras se cumple una condición. El bucle `while` es ideal para estas situaciones. Vamos a usar un `while` para calcular aumentos salariales hasta que todos los empleados alcancen un salario mínimo de 4000.

##### Paso 1: Aplicar aumentos salariales
1. Agrega el siguiente código para incrementar los salarios de empleados que ganan menos de 4000:
   ```python
   i = 0
   while i < len(empleados):
       if empleados[i]["salario"] < 4000:
           empleados[i]["salario"] += 500
       i += 1

   print("Empleados con aumentos salariales:")
   for empleado in empleados:
       print(empleado)
   ```

   - **Explicación**: Utilizamos un bucle `while` para recorrer la lista de empleados, y si el salario es menor a 4000, se incrementa en 500. El bucle continúa hasta que todos los empleados tengan un salario mayor o igual a 4000.

##### Paso 2: Ejecutar el script
1. Guarda el archivo y ejecútalo para ver cómo cambian los salarios de los empleados que inicialmente ganaban menos de 4000.

---

#### 4. **Combinar `for`, `if` y `while` para resolver problemas complejos**

Ahora vamos a combinar todas las estructuras de control aprendidas para resolver un problema más complejo: encontrar empleados cuya edad está en un rango específico y ajustar sus salarios si están por debajo de un umbral.

##### Paso 1: Filtrar empleados y ajustar salarios según su edad
1. Vamos a filtrar a los empleados cuya edad está entre 30 y 40 años y que ganan menos de 4500. A estos empleados les aumentaremos el salario hasta que alcancen un mínimo de 4500.
   ```python
   for empleado in empleados:
       if 30 <= empleado["edad"] <= 40 and empleado["salario"] < 4500:
           while empleado["salario"] < 4500:
               empleado["salario"] += 500

   print("Empleados con ajustes salariales según la edad:")
   for empleado in empleados:
       print(empleado)
   ```

   - **Explicación**: Usamos un bucle `for` para filtrar a los empleados que están en el rango de edad 30-40 y ganan menos de 4500. Dentro de este bucle, utilizamos un `while` para aumentar su salario en incrementos de 500 hasta que alcancen el umbral de 4500.

##### Paso 2: Ejecutar el script
1. Guarda los cambios y ejecuta el script en la terminal.

---

### Conclusión del Laboratorio
En este laboratorio, hemos explorado el uso de las estructuras de control (`if`, `for` y `while`) para manipular y procesar datos. Aprendimos a:
1. Filtrar datos utilizando condiciones (`if`).
2. Iterar sobre listas y sumar valores con bucles `for`.
3. Usar bucles `while` para aplicar operaciones repetitivas hasta cumplir una condición.
4. Combinar estructuras de control para resolver problemas más complejos en la manipulación de datos.

Estas estructuras son fundamentales para el desarrollo de scripts que procesen grandes volúmenes de información, como es habitual en la ingeniería de datos.