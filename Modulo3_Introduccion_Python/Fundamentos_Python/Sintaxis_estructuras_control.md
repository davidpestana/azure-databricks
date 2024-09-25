### Sintaxis básica y estructuras de control en Python

#### 1. **Variables en Python**
Las variables son contenedores para almacenar valores. Python no requiere declarar el tipo de una variable antes de usarla, ya que el lenguaje es dinámicamente tipado. El tipo de la variable se infiere a partir del valor que se le asigna.

##### Definición y asignación de variables:
- **Sintaxis**:
  ```python
  variable = valor
  ```

##### Ejemplos:
- Asignar diferentes tipos de valores a variables:
  ```python
  nombre = "Carlos"  # Variable tipo str (cadena de texto)
  edad = 30          # Variable tipo int (entero)
  peso = 70.5        # Variable tipo float (flotante)
  es_programador = True  # Variable tipo bool (booleano)
  ```

- **Caso de uso**: Una aplicación de salud que almacena la edad y el peso de un usuario podría definir esas variables así:
  ```python
  edad = 28
  peso = 68.9
  ```

#### 2. **Tipos de datos en Python**

##### Tipos numéricos:
- **Enteros (`int`)**: Almacenan números enteros, positivos o negativos.
  ```python
  numero = 100
  ```

- **Flotantes (`float`)**: Almacenan números con punto decimal.
  ```python
  temperatura = 36.5
  ```

##### Tipos de secuencias:
- **Cadenas de texto (`str`)**: Secuencias de caracteres.
  ```python
  saludo = "Hola, Mundo!"
  ```

- **Listas (`list`)**: Colecciones ordenadas que pueden cambiar (mutables) y que permiten duplicados.
  ```python
  frutas = ["manzana", "banana", "cereza"]
  ```

- **Tuplas (`tuple`)**: Similares a las listas, pero inmutables.
  ```python
  coordenadas = (10.5, 20.6)
  ```

##### Tipos de conjuntos:
- **Conjuntos (`set`)**: Colecciones desordenadas y sin duplicados.
  ```python
  colores = {"rojo", "verde", "azul"}
  ```

##### Tipos de mapeo:
- **Diccionarios (`dict`)**: Colecciones no ordenadas de pares clave-valor.
  ```python
  persona = {"nombre": "Ana", "edad": 22, "ciudad": "Madrid"}
  ```

##### Ejemplo práctico: Gestión de una lista de compras.
```python
lista_compras = ["pan", "leche", "huevos"]
```

#### 3. **Operadores en Python**
Los operadores en Python permiten realizar cálculos, comparaciones y otros tipos de operaciones con los datos.

##### Operadores aritméticos:
- **Suma (`+`)**:
  ```python
  resultado = 10 + 5  # Resultado: 15
  ```

- **Resta (`-`)**:
  ```python
  resultado = 10 - 3  # Resultado: 7
  ```

- **Multiplicación (`*`)**:
  ```python
  resultado = 4 * 3  # Resultado: 12
  ```

- **División (`/`)**:
  ```python
  resultado = 10 / 2  # Resultado: 5.0
  ```

- **División entera (`//`)**:
  ```python
  resultado = 10 // 3  # Resultado: 3
  ```

- **Módulo (`%`)**:
  ```python
  resultado = 10 % 3  # Resultado: 1
  ```

##### Operadores de comparación:
Permiten comparar valores y devuelven un valor booleano (`True` o `False`).

- **Igualdad (`==`)**:
  ```python
  10 == 10  # True
  ```

- **Desigualdad (`!=`)**:
  ```python
  10 != 5  # True
  ```

- **Mayor que (`>`) y Menor que (`<`)**:
  ```python
  10 > 5  # True
  3 < 1   # False
  ```

##### Operadores lógicos:
Permiten combinar varias condiciones.

- **`and`** (y lógico):
  ```python
  10 > 5 and 3 < 4  # True
  ```

- **`or`** (o lógico):
  ```python
  10 > 5 or 3 > 4  # True
  ```

- **`not`** (negación lógica):
  ```python
  not(10 > 5)  # False
  ```

#### 4. **Estructuras de control**

##### Condicionales:
Permiten ejecutar bloques de código dependiendo de si una condición es verdadera o falsa.

###### `if`, `elif`, `else`:
- **Sintaxis**:
  ```python
  if condición:
      # código si la condición es verdadera
  elif otra_condición:
      # código si otra_condición es verdadera
  else:
      # código si ninguna es verdadera
  ```

- **Ejemplo**:
  ```python
  edad = 20
  if edad >= 18:
      print("Eres mayor de edad.")
  else:
      print("Eres menor de edad.")
  ```

##### Bucles:
Se utilizan para repetir bloques de código varias veces.

###### Bucle `for`:
Itera sobre una secuencia de elementos.
- **Ejemplo**:
  ```python
  for i in range(5):
      print(i)
  ```

###### Bucle `while`:
Se ejecuta mientras una condición sea verdadera.
- **Ejemplo**:
  ```python
  contador = 0
  while contador < 5:
      print(contador)
      contador += 1
  ```

##### Control de flujo (`break` y `continue`):
- **`break`**: Termina el bucle.
- **`continue`**: Salta a la siguiente iteración del bucle.

##### Ejemplo práctico: Control de flujo en una lista de números.
```python
numeros = [1, 2, 3, 4, 5]
for num in numeros:
    if num == 3:
        break
    print(num)  # Se detiene cuando llega al número 3
```

---

### Casos de uso

#### 1. **Validación de entrada de usuario**
```python
edad = int(input("Ingresa tu edad: "))
if edad >= 18:
    print("Puedes votar.")
else:
    print("Aún no puedes votar.")
```

#### 2. **Gestión de inventario con listas**
```python
inventario = ["manzanas", "naranjas", "plátanos"]
for item in inventario:
    print(f"Producto en inventario: {item}")
```

#### 3. **Cálculo de promedio de notas**
```python
notas = [90, 85, 78, 92]
promedio = sum(notas) / len(notas)
print(f"El promedio es: {promedio}")
```

Este documento extiende los conceptos esenciales de Python cubriendo las variables, tipos de datos, operadores y estructuras de control con ejemplos prácticos y casos de uso, proporcionando una base sólida para aprender a programar en Python.