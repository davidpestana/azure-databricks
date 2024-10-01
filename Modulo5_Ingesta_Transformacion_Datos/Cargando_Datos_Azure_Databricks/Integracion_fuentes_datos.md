### **Integración con otras fuentes de datos (bases de datos, APIs)**

En un entorno empresarial, los datos no solo residen en sistemas de archivos como **Azure Blob Storage** o **Azure Data Lake Storage**, sino que también se almacenan en **bases de datos relacionales**, **bases de datos NoSQL**, y provienen de **APIs externas**. La integración de estas diversas fuentes de datos en **Azure Databricks** es esencial para proporcionar una vista completa y coherente de los datos en una organización, permitiendo un análisis avanzado y la generación de insights más profundos.

En esta sección, cubriremos cómo integrar Databricks con bases de datos como **Azure SQL Database**, **MySQL**, **PostgreSQL**, y cómo interactuar con **APIs externas** para ingestar datos dinámicos.

---

### **1. Conectar Azure Databricks con Bases de Datos Relacionales**

#### Conexión a bases de datos relacionales (Azure SQL Database, MySQL, PostgreSQL)

**Azure Databricks** permite conectarse a una variedad de bases de datos relacionales mediante controladores JDBC. Para bases de datos como **Azure SQL Database**, **MySQL**, y **PostgreSQL**, es necesario configurar las credenciales adecuadas y asegurarse de que los clústeres de Databricks tienen conectividad de red con la base de datos (por ejemplo, a través de una red privada o una IP pública).

#### Pasos generales para conectarse a una base de datos relacional:

1. **Configurar la base de datos**: Asegúrate de tener una base de datos relacional configurada (Azure SQL Database, MySQL o PostgreSQL) con una tabla de datos disponible para consultar. Anota las credenciales de acceso, como el nombre de usuario, la contraseña, la URL de la base de datos, y el puerto.

2. **Instalar el controlador JDBC**: En muchos casos, Databricks ya incluye controladores JDBC para bases de datos comunes. Si necesitas un controlador específico, puedes instalarlo en tu clúster mediante el uso de **Libraries** en el entorno de Databricks.

3. **Establecer la conexión desde Databricks**: Utiliza el formato JDBC para conectar Databricks a la base de datos relacional. Aquí hay ejemplos de cómo conectarse a diferentes bases de datos.

#### Ejemplo 1: Conectar a **Azure SQL Database**

```python
# Datos de conexión
jdbc_hostname = "nombre_servidor.database.windows.net"
jdbc_port = "1433"
database_name = "nombre_base_de_datos"
user = "tu_usuario"
password = "tu_contraseña"

# URL de conexión JDBC
jdbc_url = f"jdbc:sqlserver://{jdbc_hostname}:{jdbc_port};database={database_name};user={user};password={password}"

# Consulta SQL a ejecutar
query = "(SELECT * FROM nombre_tabla) AS data"

# Leer los datos de Azure SQL Database en un DataFrame de Spark
df_sql = spark.read.format("jdbc").option("url", jdbc_url).option("dbtable", query).load()

# Mostrar los primeros 5 registros
df_sql.show(5)
```

#### Ejemplo 2: Conectar a **MySQL**

```python
# Datos de conexión
jdbc_hostname = "nombre_servidor_mysql"
jdbc_port = "3306"
database_name = "nombre_base_de_datos"
user = "tu_usuario"
password = "tu_contraseña"

# URL de conexión JDBC para MySQL
jdbc_url = f"jdbc:mysql://{jdbc_hostname}:{jdbc_port}/{database_name}?user={user}&password={password}"

# Leer los datos desde MySQL en un DataFrame de Spark
df_mysql = spark.read.format("jdbc").option("url", jdbc_url).option("dbtable", "nombre_tabla").load()

# Mostrar los primeros 5 registros
df_mysql.show(5)
```

#### Ejemplo 3: Conectar a **PostgreSQL**

```python
# Datos de conexión
jdbc_hostname = "nombre_servidor_postgres"
jdbc_port = "5432"
database_name = "nombre_base_de_datos"
user = "tu_usuario"
password = "tu_contraseña"

# URL de conexión JDBC para PostgreSQL
jdbc_url = f"jdbc:postgresql://{jdbc_hostname}:{jdbc_port}/{database_name}?user={user}&password={password}"

# Leer los datos desde PostgreSQL en un DataFrame de Spark
df_postgres = spark.read.format("jdbc").option("url", jdbc_url).option("dbtable", "nombre_tabla").load()

# Mostrar los primeros 5 registros
df_postgres.show(5)
```

---

### **2. Conectar Azure Databricks con APIs Externas**

Además de bases de datos, es común que los datos provengan de **APIs REST** externas. Las APIs pueden proporcionar datos dinámicos y actualizados, como información meteorológica, datos financieros, datos de redes sociales, etc. Para trabajar con APIs en Databricks, utilizamos las bibliotecas **`requests`** o **`urllib`** de Python para realizar solicitudes HTTP a las APIs y luego procesamos la respuesta como un DataFrame de Spark.

#### Pasos para conectar Databricks a una API externa:

1. **Obtener la URL de la API y la clave de acceso**: Asegúrate de que tienes acceso a la API con la clave adecuada (si la API requiere autenticación).
2. **Realizar una solicitud HTTP**: Utiliza la biblioteca `requests` para obtener los datos de la API.
3. **Procesar la respuesta de la API**: Generalmente, la API devolverá una respuesta en formato **JSON** o **CSV**, que se puede convertir fácilmente a un DataFrame de Spark.

#### Ejemplo: Obtener datos de una API pública (OpenWeather)

En este ejemplo, conectamos a la API de **OpenWeather** para obtener información meteorológica en tiempo real.

```python
import requests
import json
from pyspark.sql import Row

# Parámetros de la API
api_key = "TU_API_KEY"
ciudad = "Madrid"
url = f"http://api.openweathermap.org/data/2.5/weather?q={ciudad}&appid={api_key}"

# Realizar la solicitud HTTP a la API
response = requests.get(url)

# Verificar que la solicitud fue exitosa
if response.status_code == 200:
    # Parsear el resultado como JSON
    data = response.json()

    # Extraer información importante del clima
    temperatura = data["main"]["temp"]
    humedad = data["main"]["humidity"]
    descripcion = data["weather"][0]["description"]

    # Crear un DataFrame de Spark con la información del clima
    datos_clima = [Row(Ciudad=ciudad, Temperatura=temperatura, Humedad=humedad, Descripcion=descripcion)]
    df_clima = spark.createDataFrame(datos_clima)

    # Mostrar el resultado
    df_clima.show()
else:
    print(f"Error al obtener los datos de la API: {response.status_code}")
```

#### Explicación:
- **requests.get(url)**: Realiza la solicitud HTTP a la API de OpenWeather con la ciudad deseada y tu API Key.
- **response.json()**: Convierte la respuesta en un diccionario JSON.
- **spark.createDataFrame**: Creamos un DataFrame a partir de los datos extraídos de la respuesta de la API.

#### Ejemplo: Conectar a una API que devuelve datos en CSV (usando `urllib`)

```python
import urllib.request
import pandas as pd

# URL de la API que devuelve un CSV
url_csv = "https://example.com/api/data.csv"

# Descargar el archivo CSV
csv_file_path = "/dbfs/tmp/api_data.csv"
urllib.request.urlretrieve(url_csv, csv_file_path)

# Leer el archivo CSV en un DataFrame de Spark
df_csv = spark.read.csv(csv_file_path, header=True, inferSchema=True)

# Mostrar los primeros 5 registros
df_csv.show(5)
```

---

### **3. Consideraciones clave al trabajar con APIs y Bases de Datos**

- **Manejo de errores**: Al trabajar con APIs o bases de datos, es importante capturar y manejar errores (por ejemplo, conexiones fallidas, credenciales incorrectas, o tiempo de espera agotado). El uso de bloques `try-except` es una buena práctica.
  
- **Autenticación**: Algunas APIs y bases de datos requieren autenticación avanzada (OAuth, claves API, tokens de acceso). Asegúrate de manejar las credenciales de manera segura, utilizando variables de entorno o servicios como **Azure Key Vault**.

- **Paginación**: Algunas APIs devuelven grandes volúmenes de datos de forma paginada. Asegúrate de implementar lógica para manejar múltiples solicitudes si los datos vienen en diferentes páginas.

- **Optimización de consultas**: Al conectar a bases de datos relacionales, es importante optimizar las consultas SQL que se envían desde Databricks para reducir la latencia y la carga en la base de datos.

---

### **Conclusión**

La integración de **Azure Databricks** con fuentes de datos externas, como bases de datos relacionales (Azure SQL, MySQL, PostgreSQL) y **APIs REST**, permite aprovechar al máximo los datos en entornos empresariales. Databricks proporciona una potente plataforma para combinar datos de múltiples orígenes, procesarlos en paralelo y generar insights clave para la toma de decisiones empresariales.