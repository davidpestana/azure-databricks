### **Laboratorio: Ingesta de datos desde diferentes fuentes (Azure SQL Database y APIs)**

### **Objetivo del laboratorio**

En este laboratorio aprenderás a ingestar datos en **Azure Databricks** desde una base de datos creada dentro de la **cuenta de almacenamiento de cada alumno**, y a combinar estos datos con información obtenida de una **API externa (OpenWeather API)**. El objetivo es generar una base de datos en la cuenta de almacenamiento de cada alumno, poblarla con datos ficticios, y combinar los resultados con datos obtenidos a través de una API, para analizarlos y almacenarlos eficientemente en un entorno distribuido como **Apache Spark**.

### **Escenario**

Trabajas en un equipo que realiza análisis de datos combinando información de bases de datos internas con datos externos obtenidos mediante APIs. Tienes acceso a una **Azure SQL Database** que has creado en tu cuenta de almacenamiento, y también necesitas integrar información meteorológica para enriquecer los análisis. En este laboratorio aprenderás a realizar estas integraciones y a gestionar los datos de forma eficiente.

---

### **Paso 1: Crear una base de datos en la cuenta de almacenamiento**

En este paso, se te proporcionará una base de datos **Azure SQL Database** ya configurada en la cuenta de almacenamiento que tienes en Azure. Utilizaremos esta base de datos para almacenar y recuperar datos de productos, ventas o cualquier otro conjunto de datos que quieras analizar.

#### 1.1 Crear la base de datos en el portal de Azure

Cada alumno deberá seguir los siguientes pasos para crear una base de datos SQL dentro de su cuenta de almacenamiento:

1. Accede al portal de **Azure**.
2. Dirígete al **grupo de recursos** que se te ha asignado para este curso.
3. Dentro del grupo de recursos, selecciona la opción para crear un nuevo recurso.
4. Busca **Azure SQL Database** y selecciona "Crear".
5. Crea un servidor SQL (si aún no tienes uno) y selecciona las configuraciones predeterminadas.
6. Asigna un nombre a la base de datos y selecciona el grupo de recursos asignado.
7. Finaliza la creación de la base de datos.

Una vez creada la base de datos, toma nota de:
- El **nombre del servidor SQL**.
- El **nombre de la base de datos**.
- El **usuario** y la **contraseña** que configuraste durante el proceso.

#### 1.2 Conectar Databricks a la base de datos de Azure SQL

Vamos a conectar **Azure Databricks** a la base de datos que acabas de crear usando JDBC. Esto nos permitirá insertar y consultar datos desde Databricks.

#### Celda 1: Conexión a la base de datos Azure SQL

```python
# Datos de conexión a Azure SQL Database
jdbc_hostname = "nombre_servidor.database.windows.net"  # Reemplaza con el nombre de tu servidor
jdbc_port = "1433"
database_name = "nombre_base_datos"  # Reemplaza con el nombre de tu base de datos
user = "tu_usuario"  # Reemplaza con tu nombre de usuario
password = "tu_contraseña"  # Reemplaza con tu contraseña

# URL de conexión JDBC
jdbc_url = f"jdbc:sqlserver://{jdbc_hostname}:{jdbc_port};database={database_name};user={user};password={password}"

# Consulta SQL que se utilizará para verificar la conexión
query = "(SELECT * FROM INFORMATION_SCHEMA.TABLES) AS data"

# Leer la tabla de la base de datos en un DataFrame de Spark
df_sql = spark.read.format("jdbc").option("url", jdbc_url).option("dbtable", query).load()

# Mostrar las tablas en la base de datos
df_sql.show()
```

**Explicación**:
- **jdbc_url**: Es la URL que permite la conexión a la base de datos **Azure SQL** utilizando JDBC.
- **spark.read.format("jdbc")**: Permite leer los datos desde una base de datos relacional utilizando el conector JDBC.
- **query**: Es una consulta que extrae las tablas de la base de datos como un punto de verificación inicial.

---

### **Paso 2: Poblar la base de datos con datos de ejemplo**

Para realizar análisis, primero necesitamos poblar la base de datos con datos de ejemplo. Vamos a crear una tabla y llenarla con datos ficticios.

#### Celda 2: Crear una tabla de productos y poblarla con datos

```python
# Definir la consulta SQL para crear la tabla de productos
create_table_query = """
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY,
    Nombre NVARCHAR(50),
    Categoria NVARCHAR(50),
    Precio DECIMAL(10, 2)
);
"""

# Ejecutar la consulta para crear la tabla
spark.read.format("jdbc") \
  .option("url", jdbc_url) \
  .option("dbtable", f"({create_table_query}) AS create_table") \
  .option("user", user) \
  .option("password", password) \
  .load()

# Insertar datos ficticios en la tabla de productos
insert_data_query = """
INSERT INTO Productos (ProductoID, Nombre, Categoria, Precio)
VALUES (1, 'Laptop', 'Electrónica', 1200.00),
       (2, 'Tablet', 'Electrónica', 300.00),
       (3, 'Teléfono', 'Electrónica', 800.00),
       (4, 'Monitor', 'Oficina', 150.00);
"""

# Ejecutar la consulta para insertar los datos
spark.read.format("jdbc") \
  .option("url", jdbc_url) \
  .option("dbtable", f"({insert_data_query}) AS insert_data") \
  .option("user", user) \
  .option("password", password) \
  .load()
```

**Explicación**:
- **create_table_query**: Define la estructura de la tabla que vamos a crear (en este caso, una tabla de productos).
- **insert_data_query**: Inserta algunos registros de prueba en la tabla.

---

### **Paso 3: Obtener datos de una API externa (OpenWeather)**

Ahora que hemos poblado la base de datos, vamos a combinar esos datos con información externa que obtendremos de la API de **OpenWeather**. Vamos a realizar una consulta para obtener datos meteorológicos que complementarán el análisis.

#### Celda 3: Conectar a la API de OpenWeather y obtener datos

```python
import requests
import json
from pyspark.sql import Row

# Parámetros de la API de OpenWeather
api_key = "TU_API_KEY"
ciudad = "Madrid"
url = f"http://api.openweathermap.org/data/2.5/weather?q={ciudad}&appid={api_key}"

# Realizar la solicitud a la API
response = requests.get(url)

# Verificar que la solicitud fue exitosa
if response.status_code == 200:
    # Parsear el resultado como JSON
    data = response.json()

    # Extraer la temperatura, humedad y la descripción del clima
    temperatura = data["main"]["temp"]
    humedad = data["main"]["humidity"]
    descripcion = data["weather"][0]["description"]

    # Crear un DataFrame de Spark con los datos del clima
    datos_clima = [Row(Ciudad=ciudad, Temperatura=temperatura, Humedad=humedad, Descripcion=descripcion)]
    df_clima = spark.createDataFrame(datos_clima)

    # Mostrar los resultados
    df_clima.show()
else:
    print(f"Error al obtener los datos de la API: {response.status_code}")
```

**Explicación**:
- **requests.get()**: Realiza una solicitud HTTP para obtener los datos del clima de la API de OpenWeather.
- **Row()**: Crea una fila con los datos meteorológicos, que luego convertimos en un **DataFrame de Spark**.

---

### **Paso 4: Combinar datos de la base de datos con datos de la API**

Finalmente, vamos a combinar los datos de productos de la base de datos con la información meteorológica obtenida de la API. Esta combinación puede utilizarse para proporcionar un análisis más completo.

#### Celda 4: Combinar datos de la base de datos y la API

```python
# Suponiendo que tenemos una tabla con productos en la base de datos y datos del clima de la API
# Aquí combinamos ambas fuentes de datos en un solo DataFrame

# Consulta SQL para obtener los datos de productos desde la base de datos
productos_query = "(SELECT * FROM Productos) AS productos"

# Leer los datos de productos
df_productos = spark.read.format("jdbc") \
  .option("url", jdbc_url) \
  .option("dbtable", productos_query) \
  .option("user", user) \
  .option("password", password) \
  .load()

# Añadir la columna de temperatura a los datos de productos (para ejemplo)
df_combinado = df_productos.withColumn("Temperatura", lit(df_clima.collect()[0]["Temperatura"]))

# Mostrar los datos combinados
df_combinado.show()
```

**Explicación**:
- **lit()**: Permite agregar un valor constante (en este caso, la temperatura obtenida de la API) a cada fila del DataFrame de productos.

---

### **Conclusión del laboratorio**

En este laboratorio, aprendiste a:

1. **Crear y conectar Azure Databricks con Azure SQL Database** utilizando JDBC.
2. **Poblar una base de datos con datos de ejemplo** desde Databricks.
3. **Obtener datos externos** desde una **API