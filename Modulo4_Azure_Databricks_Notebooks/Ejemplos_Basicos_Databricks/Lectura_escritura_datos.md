**Teoría: Leer y escribir datos**

### Introducción

Una de las tareas más fundamentales en cualquier entorno de análisis de datos es la capacidad de **leer** y **escribir** datos. En Databricks, el manejo de archivos es clave para cargar, transformar, y finalmente almacenar los datos procesados. Los notebooks de Databricks permiten realizar estas operaciones de lectura y escritura de manera eficiente en diversos formatos (como CSV, Parquet, JSON, etc.) y desde múltiples fuentes de datos (Azure Blob Storage, Amazon S3, bases de datos, entre otros). Este apartado se centrará en mostrar casos reales de cómo los notebooks pueden ser utilizados para manejar datos de diferentes tipos y en diversos contextos empresariales.

### 1. Leer y escribir datos en formatos estructurados y semi-estructurados

#### Caso de uso: Carga de datos desde un archivo CSV y escritura en Parquet en un entorno financiero

Una empresa financiera necesita analizar los movimientos de cuentas de clientes que están almacenados en archivos CSV. Utilizando notebooks de Databricks, los analistas pueden leer estos archivos de manera distribuida, realizar operaciones de limpieza y transformación, y luego escribir los resultados en un formato más eficiente como Parquet para futuras consultas.

```python
# Leer datos desde un archivo CSV
df_movimientos = spark.read.csv("/mnt/finanzas/movimientos.csv", header=True, inferSchema=True)

# Transformar y limpiar los datos (eliminar registros con nulos)
df_movimientos_limpios = df_movimientos.dropna()

# Escribir los datos transformados en formato Parquet
df_movimientos_limpios.write.format("parquet").mode("overwrite").save("/mnt/finanzas/movimientos_limpios.parquet")
```

**Explicación**: En este ejemplo, los datos CSV se leen desde un almacenamiento en la nube, se procesan para eliminar registros incompletos y se guardan en Parquet. Este flujo es muy común en sectores financieros donde los datos deben ser fácilmente accesibles para análisis repetidos.

### 2. Lectura y escritura en bases de datos empresariales

#### Caso de uso: Conexión a una base de datos de producción y análisis en el sector de la salud

Un hospital desea analizar los datos de sus pacientes almacenados en una base de datos SQL. Los analistas pueden conectarse a la base de datos desde un notebook de Databricks, leer los datos de los pacientes, realizar análisis exploratorios y luego escribir los resultados en un almacenamiento accesible para otros sistemas.

```python
# Leer datos desde una base de datos SQL
df_pacientes = spark.read.format("jdbc").option("url", "jdbc:sqlserver://hosp-db").option("dbtable", "pacientes").load()

# Realizar análisis exploratorio (estadísticas descriptivas)
df_pacientes.describe().show()

# Escribir los resultados en un almacenamiento para ser usados por otros sistemas
df_pacientes.write.format("json").mode("overwrite").save("/mnt/hospital/datos_pacientes.json")
```

**Explicación**: Este notebook permite a los equipos médicos realizar análisis de datos directamente desde una base de datos de producción y compartir los resultados con otros equipos del hospital de manera eficiente.

### 3. Integración con APIs para leer y escribir datos en tiempo real

#### Caso de uso: Consumo de una API de clima para análisis de tendencias en la agricultura

Un equipo de agrónomos quiere estudiar cómo las condiciones meteorológicas afectan la producción agrícola. Utilizando notebooks de Databricks, pueden integrar la **API de OpenWeather**, extraer datos en tiempo real y combinarlos con sus propios datos históricos de producción.

```python
import requests

# Hacer una solicitud a la API de OpenWeather
api_key = "YOUR_API_KEY"
ciudad = "Madrid"
url = f"http://api.openweathermap.org/data/2.5/weather?q={ciudad}&appid={api_key}"

response = requests.get(url)
datos_clima = response.json()

# Extraer la temperatura y otras variables de interés
temperatura = datos_clima['main']['temp']
clima = datos_clima['weather'][0]['description']

# Crear un DataFrame con los datos de clima
df_clima = spark.createDataFrame([(ciudad, temperatura, clima)], ["ciudad", "temperatura", "clima"])

# Guardar los datos en un archivo CSV
df_clima.write.format("csv").mode("overwrite").save("/mnt/agricultura/clima_madrid.csv")
```

**Explicación**: Este notebook permite a los equipos de agronomía analizar los datos meteorológicos en tiempo real y almacenarlos para cruzarlos con los datos de producción agrícola, obteniendo insights que les permitan ajustar sus estrategias.

---

**Teoría: Transformaciones básicas de datos**

### Introducción

La transformación de datos es una de las tareas más comunes y esenciales en el procesamiento de datos empresariales. Implica modificar, filtrar, agregar, y limpiar datos para que estén listos para análisis posteriores o integrarse con otros sistemas. En Databricks, las transformaciones de datos son altamente escalables gracias a las capacidades de PySpark, permitiendo a los equipos manejar grandes volúmenes de datos sin comprometer el rendimiento. Los siguientes ejemplos mostrarán cómo realizar transformaciones básicas en diferentes entornos empresariales.

### 1. Transformaciones básicas en entornos de ventas

#### Caso de uso: Filtrar transacciones fraudulentas en una cadena de tiendas

Una cadena de tiendas necesita identificar transacciones potencialmente fraudulentas. Los analistas usan un notebook para filtrar las transacciones que superan un umbral determinado y marcan las que deben investigarse más a fondo.

```python
# Leer datos de transacciones
df_transacciones = spark.read.parquet("/mnt/ventas/transacciones.parquet")

# Filtrar transacciones con valores mayores a 10,000
df_fraudes = df_transacciones.filter(df_transacciones['monto'] > 10000)

# Escribir los datos filtrados
df_fraudes.write.format("csv").mode("overwrite").save("/mnt/ventas/transacciones_fraudulentas.csv")
```

**Explicación**: Los equipos de seguridad pueden automatizar la identificación de transacciones sospechosas utilizando transformaciones básicas como el filtrado de montos elevados.

### 2. Agregación de datos en el sector energético

#### Caso de uso: Agregación de consumo energético por hora

Una empresa de energía quiere calcular el consumo total de electricidad por hora de sus clientes residenciales. Con un notebook en Databricks, los analistas pueden agrupar los datos por horas y calcular las sumas correspondientes.

```python
# Leer datos de consumo energético
df_consumo = spark.read.csv("/mnt/energia/consumo_horas.csv", header=True, inferSchema=True)

# Agrupar por la hora y sumar el consumo
df_consumo_por_hora = df_consumo.groupBy("hora").sum("consumo")

# Guardar los resultados
df_consumo_por_hora.write.format("parquet").mode("overwrite").save("/mnt/energia/consumo_total_horas.parquet")
```

**Explicación**: Esta transformación permite que la empresa energética calcule el consumo total de energía y lo utilice para prever la demanda en horas específicas del día.

---

**Teoría: Manejo de excepciones y errores en notebooks**

### Introducción

El manejo de excepciones y errores es fundamental en cualquier entorno de desarrollo, especialmente cuando se trabaja con grandes volúmenes de datos y sistemas distribuidos. En notebooks de Databricks, los errores pueden ocurrir debido a problemas con los datos, errores de conexión a bases de datos, o fallos en la ejecución de funciones. Tener un buen manejo de excepciones permite a los analistas y desarrolladores asegurar que los procesos no se detengan abruptamente y que los problemas se manejen de manera adecuada.

### 1. Uso de `try-except` para manejar errores de conexión a APIs

#### Caso de uso: Manejo de errores en la solicitud de datos a una API de logística

Una empresa de logística está integrando datos de su flota de camiones en tiempo real mediante una API. Si la API falla, el notebook debe manejar la excepción y registrar el error sin detener el proceso.

```python
try:
    # Solicitar datos de la API
    response = requests.get("http://logistica-api.com/camiones")
    response.raise_for_status()  # Lanzar una excepción si hay errores en la solicitud
    datos_camiones = response.json()
except requests.exceptions.RequestException as e:
    # Manejar el error y continuar el proceso
    print(f"Error al conectar con la API: {e}")
    # Registrar el error
    dbutils.fs.put("/mnt/logs/error_log.txt", f"Error API: {e}", True)
```

**Explicación**: Este manejo de errores asegura que los problemas con la API no detengan todo el proceso, permitiendo que otras partes del análisis continúen.

### 2. Manejo de errores durante la lectura de archivos

#### Caso de uso: Manejo de excepciones al leer archivos corruptos

En un entorno bancario, al leer un archivo CSV de clientes, puede haber datos corruptos o faltantes que generen errores. El notebook debe manejar estos casos y registrar los archivos problemáticos para su posterior revisión.

```python
try:
    # Intentar leer el archivo CSV
    df_clientes = spark.read.csv("/mnt/bancos/clientes.csv", header=True, inferSchema=True)
except Exception as e:
    # Registrar el error en un archivo de log
    dbutils.fs.put("/mnt/logs/lectura_clientes_error.txt", f"Error al leer archivo clientes: {e}", True)
    raise
```

**Explicación**

: Al manejar los errores de lectura de archivos, el proceso puede registrar cualquier problema y detenerse de manera controlada, sin dejar datos incompletos.