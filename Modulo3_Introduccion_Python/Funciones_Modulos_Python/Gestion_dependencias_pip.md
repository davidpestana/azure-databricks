# Gestión de dependencias con `pip`

## Introducción

En proyectos de Python, es común utilizar bibliotecas de terceros para evitar tener que desarrollar todo desde cero. La herramienta **`pip`** es el gestor de paquetes de Python que permite instalar y gestionar estos paquetes de forma sencilla. Además, es muy útil para garantizar que todos los miembros de un equipo de desarrollo utilicen las mismas versiones de las bibliotecas, evitando inconsistencias.

Este documento cubre cómo utilizar `pip` para instalar, actualizar, y gestionar dependencias, así como la creación y uso de archivos `requirements.txt` para la gestión de dependencias en proyectos colaborativos.

---

## 1. Instalación y configuración de `pip`

### Verificar si `pip` está instalado

En la mayoría de las instalaciones de Python, `pip` ya viene preinstalado. Para verificar si lo tienes en tu entorno, abre una terminal o línea de comandos y ejecuta:

```bash
pip --version
```

La salida debería ser algo como:

```bash
pip 21.0.1 from ... (python 3.9)
```

Si `pip` no está instalado, puedes seguir las instrucciones oficiales para su instalación [aquí](https://pip.pypa.io/en/stable/installation/).

---

## 2. Instalación de paquetes con `pip`

Para instalar un paquete, simplemente usa el comando `pip install` seguido del nombre del paquete que deseas instalar.

### Ejemplo: Instalar la biblioteca `requests`

```bash
pip install requests
```

Una vez instalado, puedes utilizar el paquete en tu código Python.

### Ejemplo de uso:

```python
import requests

respuesta = requests.get('https://jsonplaceholder.typicode.com/posts')
print(respuesta.status_code)  # Imprime 200 si la solicitud fue exitosa
```

`pip` se encarga de descargar e instalar el paquete, así como todas sus dependencias. Es posible que el paquete tenga otras bibliotecas de las que dependa, y `pip` las instalará automáticamente.

---

## 3. Actualización de paquetes

Con el tiempo, las bibliotecas se actualizan, y puede que quieras actualizar tus paquetes a la última versión. Para actualizar un paquete, usa el siguiente comando:

```bash
pip install --upgrade nombre_del_paquete
```

### Ejemplo: Actualizar `requests`

```bash
pip install --upgrade requests
```

---

## 4. Desinstalación de paquetes

Si ya no necesitas un paquete en tu entorno, puedes desinstalarlo usando el comando `pip uninstall` seguido del nombre del paquete.

### Ejemplo: Desinstalar `requests`

```bash
pip uninstall requests
```

---

## 5. Listar los paquetes instalados

Para ver una lista de todos los paquetes instalados en tu entorno Python, puedes ejecutar el siguiente comando:

```bash
pip list
```

Este comando mostrará una lista de todos los paquetes instalados y sus versiones correspondientes.

---

## 6. Crear y usar archivos `requirements.txt`

Cuando trabajas en proyectos colaborativos, es común utilizar un archivo llamado **`requirements.txt`** para definir las dependencias necesarias del proyecto. Este archivo contiene una lista de todos los paquetes y sus versiones, lo que permite que cualquier miembro del equipo pueda instalar las mismas versiones y asegurar que el código funcione de manera uniforme.

### 6.1. Crear un archivo `requirements.txt`

Para crear este archivo, simplemente ejecuta el siguiente comando:

```bash
pip freeze > requirements.txt
```

Este comando creará un archivo llamado `requirements.txt` que contendrá la lista de todos los paquetes instalados en tu entorno actual y sus versiones.

### Ejemplo de `requirements.txt`

```
requests==2.25.1
numpy==1.21.0
pandas==1.3.0
```

### 6.2. Instalar dependencias desde un archivo `requirements.txt`

Si estás comenzando a trabajar en un proyecto y te proporcionan un archivo `requirements.txt`, puedes instalar todas las dependencias enumeradas en ese archivo usando el siguiente comando:

```bash
pip install -r requirements.txt
```

`pip` se encargará de instalar todas las bibliotecas necesarias en el entorno.

---

## 7. Entornos virtuales

Cuando trabajas en varios proyectos de Python, puede que necesites gestionar diferentes versiones de las mismas bibliotecas. Para evitar conflictos entre proyectos, es recomendable usar **entornos virtuales**. Un entorno virtual crea un espacio aislado en tu sistema donde puedes instalar dependencias específicas para un proyecto sin afectar a otros proyectos.

### 7.1. Crear un entorno virtual

Para crear un entorno virtual, utiliza la herramienta `venv`, que viene integrada en Python. En la terminal, navega a la carpeta de tu proyecto y ejecuta:

```bash
python -m venv nombre_del_entorno
```

Esto creará una carpeta llamada `nombre_del_entorno` que contendrá un Python aislado y su propio gestor de paquetes `pip`.

### 7.2. Activar el entorno virtual

Para activar el entorno en diferentes sistemas operativos:

- **En Windows**:
  
  ```bash
  nombre_del_entorno\Scripts\activate
  ```

- **En macOS/Linux**:
  
  ```bash
  source nombre_del_entorno/bin/activate
  ```

Una vez activado, verás que el nombre del entorno aparece en tu terminal, lo que indica que estás trabajando dentro de él.

### 7.3. Instalar paquetes dentro de un entorno virtual

Con el entorno activado, puedes usar `pip` normalmente para instalar paquetes dentro del entorno virtual. Las dependencias instaladas en un entorno virtual no afectarán a otros proyectos fuera de ese entorno.

---

## 8. Uso de `pipenv` para la gestión de dependencias

Otra herramienta popular para la gestión de dependencias y entornos virtuales es **`pipenv`**, que combina la funcionalidad de `pip` y `virtualenv` en una sola herramienta.

### Instalación de `pipenv`

Para instalar `pipenv`, puedes usar `pip`:

```bash
pip install pipenv
```

### Crear un entorno virtual y gestionar dependencias con `pipenv`

1. Para crear un entorno virtual y gestionar dependencias con `pipenv`, navega a la carpeta de tu proyecto y ejecuta:

   ```bash
   pipenv install nombre_del_paquete
   ```

   Esto creará un entorno virtual y un archivo `Pipfile` que gestionará las dependencias de tu proyecto.

2. Para activar el entorno virtual:

   ```bash
   pipenv shell
   ```

3. Para instalar todas las dependencias desde el archivo `Pipfile`:

   ```bash
   pipenv install
   ```

---

## Conclusión

El uso de `pip` es esencial en cualquier proyecto de Python para gestionar y mantener las dependencias de manera eficiente. Herramientas como `venv` y `pipenv` añaden una capa extra de control sobre los entornos y garantizan que las dependencias se mantengan aisladas entre proyectos. Esto es especialmente importante en la ingeniería de datos, donde diferentes proyectos pueden necesitar diferentes versiones de las mismas bibliotecas.

Con esta guía, deberías estar preparado para gestionar paquetes y dependencias en tus proyectos de Python de manera profesional y eficiente.