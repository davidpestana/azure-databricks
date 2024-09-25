### Laboratorio: Trabajar con listas, diccionarios y conjuntos

En este laboratorio, aprenderemos a trabajar con listas, diccionarios y conjuntos para manipular datos de manera eficiente. Nos enfocaremos en las operaciones más comunes que se realizan en el manejo de datos: filtrado, transformación, búsqueda y eliminación de duplicados. Estas estructuras de datos son clave en la ingeniería de datos y permiten realizar muchas operaciones necesarias en el procesamiento de información.

#### Objetivos:
1. Aprender a manipular listas para almacenar y procesar conjuntos de datos.
2. Utilizar diccionarios para organizar datos en pares clave-valor y realizar búsquedas eficientes.
3. Usar conjuntos para eliminar duplicados y hacer operaciones de intersección y diferencia.
4. Aplicar estas estructuras en un contexto práctico orientado a la manipulación de datos.

#### Requisitos:
- Tener Python instalado en tu máquina.
- Un editor de texto (VS Code, PyCharm, etc.).
- Acceso a la línea de comandos o terminal.

---

#### 1. **Manipulación de listas**

Las listas son una estructura fundamental en Python, usadas para almacenar secuencias de elementos. Vamos a trabajar con listas para almacenar, agregar, eliminar y ordenar datos.

##### Paso 1: Crear una lista de ventas diarias
1. Abre tu editor de texto y crea un archivo llamado `ventas.py`.
2. Define una lista con las ventas diarias de una tienda durante una semana.
   ```python
   ventas_diarias = [2500, 3000, 2000, 3200, 4000, 1000, 5000]
   print("Ventas diarias:", ventas_diarias)
   ```

   - **Explicación**: Esta lista contiene las ventas diarias de una tienda en valores numéricos. Vamos a manipular esta lista en los siguientes pasos.

##### Paso 2: Calcular el total y el promedio de ventas
1. Usa las funciones `sum()` y `len()` para calcular el total y el promedio de ventas.
   ```python
   total_ventas = sum(ventas_diarias)
   promedio_ventas = total_ventas / len(ventas_diarias)
   print(f"Total de ventas: {total_ventas}")
   print(f"Promedio de ventas: {promedio_ventas}")
   ```

   - **Explicación**: `sum()` calcula la suma de los elementos en la lista y `len()` devuelve la cantidad de elementos, que nos ayuda a calcular el promedio.

##### Paso 3: Agregar y eliminar elementos en la lista
1. Ahora vamos a agregar una nueva venta y eliminar el valor de la venta más baja.
   ```python
   ventas_diarias.append(4500)  # Agregamos una nueva venta
   print("Ventas después de agregar:", ventas_diarias)
   
   menor_venta = min(ventas_diarias)  # Encuentra la venta más baja
   ventas_diarias.remove(menor_venta)  # Elimina la venta más baja
   print(f"Ventas después de eliminar la menor venta ({menor_venta}):", ventas_diarias)
   ```

   - **Explicación**: Usamos `append()` para agregar una nueva venta al final de la lista, y `remove()` para eliminar la venta más baja, encontrada con `min()`.

##### Paso 4: Ordenar la lista
1. Vamos a ordenar las ventas de menor a mayor.
   ```python
   ventas_diarias.sort()
   print("Ventas ordenadas de menor a mayor:", ventas_diarias)
   ```

   - **Explicación**: Usamos el método `sort()` para ordenar la lista en orden ascendente.

---

#### 2. **Uso de diccionarios para organizar datos**

Los diccionarios son estructuras de datos que almacenan pares clave-valor. Vamos a utilizarlos para organizar información sobre productos y sus precios.

##### Paso 1: Crear un diccionario de productos y precios
1. Crea un archivo llamado `productos.py`.
2. Define un diccionario que almacene productos y sus precios.
   ```python
   productos = {
       "manzana": 1.2,
       "banana": 0.8,
       "naranja": 1.5,
       "pera": 2.0
   }
   print("Productos y precios:", productos)
   ```

   - **Explicación**: Cada clave en el diccionario es el nombre de un producto, y el valor asociado es su precio.

##### Paso 2: Buscar un producto específico
1. Vamos a buscar el precio de un producto específico (por ejemplo, "naranja").
   ```python
   producto_buscado = "naranja"
   if producto_buscado in productos:
       print(f"El precio de la {producto_buscado} es {productos[producto_buscado]}")
   else:
       print(f"El producto {producto_buscado} no está disponible.")
   ```

   - **Explicación**: Usamos la palabra clave `in` para verificar si un producto existe en el diccionario antes de intentar acceder a su valor.

##### Paso 3: Agregar y eliminar productos
1. Vamos a agregar un nuevo producto y eliminar otro.
   ```python
   productos["kiwi"] = 1.8  # Agregar un nuevo producto
   print("Productos después de agregar kiwi:", productos)
   
   productos.pop("banana")  # Eliminar un producto
   print("Productos después de eliminar banana:", productos)
   ```

   - **Explicación**: Usamos `productos["kiwi"] = 1.8` para agregar un nuevo producto y `pop()` para eliminar otro.

##### Paso 4: Iterar sobre el diccionario
1. Vamos a iterar sobre los productos para mostrar su nombre y precio.
   ```python
   for producto, precio in productos.items():
       print(f"Producto: {producto}, Precio: {precio}")
   ```

   - **Explicación**: Usamos el método `items()` del diccionario para iterar sobre los pares clave-valor.

---

#### 3. **Manipulación de conjuntos para eliminar duplicados y hacer operaciones**

Los conjuntos son útiles para trabajar con colecciones de elementos únicos. Vamos a usarlos para eliminar duplicados y hacer operaciones de conjunto como intersección y diferencia.

##### Paso 1: Crear un conjunto con nombres de clientes
1. Crea un archivo llamado `clientes.py`.
2. Define dos conjuntos de clientes para dos tiendas diferentes.
   ```python
   clientes_tienda1 = {"Carlos", "Ana", "Pedro", "Lucía"}
   clientes_tienda2 = {"Ana", "Lucía", "Juan", "Marta"}
   print("Clientes tienda 1:", clientes_tienda1)
   print("Clientes tienda 2:", clientes_tienda2)
   ```

   - **Explicación**: Los conjuntos permiten almacenar datos sin duplicados. Cada cliente se almacena solo una vez en el conjunto.

##### Paso 2: Encontrar la intersección de clientes entre ambas tiendas
1. Vamos a encontrar los clientes que compraron en ambas tiendas.
   ```python
   clientes_comunes = clientes_tienda1.intersection(clientes_tienda2)
   print("Clientes que compraron en ambas tiendas:", clientes_comunes)
   ```

   - **Explicación**: La operación `intersection()` devuelve los elementos que están presentes en ambos conjuntos.

##### Paso 3: Encontrar la diferencia de clientes
1. Vamos a encontrar los clientes que compraron solo en la tienda 1.
   ```python
   clientes_solo_tienda1 = clientes_tienda1.difference(clientes_tienda2)
   print("Clientes que compraron solo en la tienda 1:", clientes_solo_tienda1)
   ```

   - **Explicación**: La operación `difference()` devuelve los elementos que están en el primer conjunto pero no en el segundo.

##### Paso 4: Unir los clientes de ambas tiendas
1. Vamos a unir los dos conjuntos para obtener una lista completa de todos los clientes.
   ```python
   todos_los_clientes = clientes_tienda1.union(clientes_tienda2)
   print("Todos los clientes:", todos_los_clientes)
   ```

   - **Explicación**: La operación `union()` devuelve un nuevo conjunto que contiene todos los elementos de ambos conjuntos, sin duplicados.

---

### Conclusión del Laboratorio
En este laboratorio, hemos trabajado con las principales estructuras de datos en Python para manipular y procesar información de manera eficiente. Hemos aprendido a:
1. Utilizar listas para almacenar, ordenar y manipular secuencias de datos numéricos.
2. Trabajar con diccionarios para organizar información en pares clave-valor y realizar búsquedas.
3. Utilizar conjuntos para eliminar duplicados y realizar operaciones de intersección, diferencia y unión.

Estas habilidades son esenciales para trabajar con datos en Python, especialmente en el contexto de la ingeniería de datos, donde es común manejar grandes volúmenes de información y realizar diversas operaciones con ella.