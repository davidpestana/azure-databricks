## **Laboratorio: Uso de Celdas Mágicas en Databricks**

### **Objetivo**
Aprender a utilizar los comandos mágicos disponibles en Databricks notebooks para interactuar con el sistema, instalar paquetes y realizar operaciones especiales.

### **Instrucciones**

En este laboratorio, aprenderás a usar celdas mágicas como `%fs`, `%sh`, `%run`, y `%pip` para realizar diversas operaciones dentro de un notebook en Databricks.

### **Requisitos**
- Tener acceso a un clúster de Databricks en funcionamiento.
- Un notebook abierto en Databricks.

### **Paso 1: Exploración del sistema de archivos con `%fs`**
Databricks tiene acceso a un sistema de archivos distribuido conocido como DBFS (Databricks File System), y puedes interactuar con él utilizando el comando mágico `%fs`.

1. Crea una nueva celda en tu notebook.
2. En esta celda, escribe el siguiente código para listar los archivos en el directorio raíz de DBFS:

```python
%fs ls /
```

3. Ejecuta la celda y observa la salida, que mostrará los archivos y carpetas disponibles en el sistema de archivos distribuido de Databricks.

### **Paso 2: Uso de comandos de shell con `%sh`**
Puedes ejecutar comandos de shell directamente desde un notebook utilizando la celda mágica `%sh`.

1. Crea una nueva celda y utiliza `%sh` para verificar el espacio disponible en disco usando el siguiente comando:

```bash
%sh df -h
```

2. Ejecuta la celda. Esto mostrará la información sobre el uso del disco en el entorno del clúster de Databricks.

### **Paso 3: Instalación de paquetes con `%pip`**
En Databricks, puedes instalar paquetes adicionales utilizando la celda mágica `%pip`. Esto es útil cuando necesitas instalar una biblioteca de Python que no está disponible por defecto.

1. Crea una nueva celda y escribe el siguiente código para instalar el paquete `matplotlib`:

```bash
%pip install matplotlib
```

2. Ejecuta la celda. Esto instalará el paquete en el entorno del clúster de Databricks.
3. Verifica que se haya instalado correctamente creando un gráfico sencillo:

```python
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0, 10, 100)
y = np.sin(x)

plt.plot(x, y)
plt.show()
```

### **Paso 4: Ejecución de otros notebooks con `%run`**
El comando mágico `%run` te permite ejecutar otro notebook dentro de tu notebook actual. Esto es útil si quieres reutilizar código de otros notebooks.

1. Crea o utiliza otro notebook que contenga una simple función de Python. Por ejemplo, crea un notebook llamado `funciones_utiles` con la siguiente celda:

```python
# Notebook: funciones_utiles
def saludo(nombre):
    return f"Hola, {nombre}!"
```

2. Ahora, en tu notebook principal, puedes ejecutar el notebook anterior con `%run`:

```python
%run ./funciones_utiles
```

3. Una vez ejecutado, llama a la función `saludo` definida en el otro notebook:

```python
print(saludo("Databricks"))
```

Esto importará la función del notebook y la ejecutará.

### **Paso 5: Almacenamiento de variables y contexto mágico con `%md`**
El comando mágico `%md` se utiliza para crear celdas con formato Markdown, lo que permite incluir texto formateado, encabezados, listas y enlaces en los notebooks.

1. Crea una celda con el siguiente contenido para agregar una explicación en formato Markdown sobre los comandos mágicos que acabas de aprender:

```markdown
%md
### Resumen de comandos mágicos en Databricks
- **%fs**: Interactuar con el sistema de archivos de Databricks (DBFS).
- **%sh**: Ejecutar comandos de shell en el clúster.
- **%pip**: Instalar paquetes de Python en el entorno del clúster.
- **%run**: Ejecutar otro notebook dentro del actual.
- **%md**: Crear contenido en formato Markdown para documentar tu notebook.
```

2. Ejecuta la celda y verás el texto renderizado en formato Markdown.

### **Conclusión**
En este laboratorio, aprendiste a utilizar varios comandos mágicos en Databricks, que te permiten interactuar con el sistema de archivos, ejecutar scripts de shell, instalar paquetes y ejecutar otros notebooks. Estos comandos te facilitarán el manejo de tareas comunes y te ayudarán a automatizar parte del flujo de trabajo en los notebooks.