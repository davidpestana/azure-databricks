### Anexo: Generación de Recursos Masivos para Laboratorios de Optimización y Consultas Complejas

---

#### 1. **Generar un DataFrame Masivo Simulado para Ciudad y Población**

Este script generará un DataFrame con millones de filas, simulando ciudades y su población. El conjunto de datos será lo suficientemente grande para probar las optimizaciones, como particionamiento y caching.

```python
import random
import pandas as pd

# Crear un DataFrame masivo simulado con millones de filas
num_filas = 10**7  # Generar 10 millones de registros

# Lista de ciudades simuladas
ciudades = ["Madrid", "Barcelona", "Valencia", "Sevilla", "Zaragoza", "Málaga", "Bilbao", "Murcia", "Palma", "Las Palmas"]

# Generar datos aleatorios de ciudades y poblaciones
data = {
    "city": [random.choice(ciudades) for _ in range(num_filas)],
    "population": [random.randint(1000, 5000000) for _ in range(num_filas)],
    "region": [random.choice(["Madrid", "Cataluña", "Valencia", "Andalucía", "País Vasco", "Canarias"]) for _ in range(num_filas)]
}

# Convertir a DataFrame de pandas y luego a un DataFrame de PySpark
df_masivo_pandas = pd.DataFrame(data)
df_masivo = spark.createDataFrame(df_masivo_pandas)

# Mostrar una muestra del DataFrame generado
df_masivo.show(5)

# Guardar el DataFrame masivo en formato Parquet para futuras consultas optimizadas
df_masivo.write.parquet("/dbfs/FileStore/shared_uploads/tu_usuario/ciudades_masivo.parquet")

print("Archivo Parquet masivo generado y guardado correctamente.")
```

**Explicación**:
- Este script genera un DataFrame con **10 millones** de registros simulando ciudades y su población. El DataFrame se guarda en formato **Parquet**, optimizado para las consultas que ejecutaremos en los laboratorios.
- Utilizamos **Parquet** para permitir consultas más rápidas y eficientes sobre grandes volúmenes de datos.

---

#### 2. **Generar Datos de Ventas y Precios de Productos**

Vamos a generar un DataFrame masivo para simular un conjunto de datos de ventas y precios de productos. Este recurso puede ser utilizado para realizar operaciones de agregación, uniones y optimización de consultas.

```python
# Crear un DataFrame masivo simulado para ventas y precios
num_filas_ventas = 10**7  # 10 millones de registros

# Lista de productos simulados
productos = ["Producto A", "Producto B", "Producto C", "Producto D", "Producto E"]

# Generar datos aleatorios para las ventas
data_ventas = {
    "producto": [random.choice(productos) for _ in range(num_filas_ventas)],
    "cantidad_vendida": [random.randint(1, 1000) for _ in range(num_filas_ventas)],
    "precio_unitario": [random.uniform(10, 500) for _ in range(num_filas_ventas)],
    "fecha_venta": [random.choice(pd.date_range("2020-01-01", "2024-01-01").tolist()) for _ in range(num_filas_ventas)]
}

# Convertir a DataFrame de pandas y luego a PySpark
df_ventas_pandas = pd.DataFrame(data_ventas)
df_ventas = spark.createDataFrame(df_ventas_pandas)

# Mostrar una muestra del DataFrame generado
df_ventas.show(5)

# Guardar el DataFrame de ventas en formato Parquet
df_ventas.write.parquet("/dbfs/FileStore/shared_uploads/tu_usuario/ventas_masivo.parquet")

print("Archivo Parquet masivo de ventas generado y guardado correctamente.")
```

**Explicación**:
- Este script genera un DataFrame masivo con **10 millones** de registros de ventas de productos, incluyendo cantidades vendidas, precios y fechas de venta.
- Este recurso es ideal para practicar agregaciones, operaciones de **JOIN** y optimización de consultas complejas.

---

#### 3. **Generar DataFrame Masivo de Eventos de Logs**

Este DataFrame simulará millones de eventos de logs, que son útiles para prácticas relacionadas con el análisis de eventos y la optimización de consultas en grandes volúmenes de datos.

```python
# Crear un DataFrame masivo simulado para logs de eventos
num_filas_logs = 10**7  # 10 millones de registros

# Tipos de eventos simulados
eventos = ["LOGIN", "LOGOUT", "VIEW", "CLICK", "PURCHASE"]

# Generar datos aleatorios de eventos
data_logs = {
    "event_id": [random.randint(1, num_filas_logs) for _ in range(num_filas_logs)],
    "event_type": [random.choice(eventos) for _ in range(num_filas_logs)],
    "user_id": [random.randint(1, 1000000) for _ in range(num_filas_logs)],
    "timestamp": [random.choice(pd.date_range("2023-01-01", "2023-12-31").tolist()) for _ in range(num_filas_logs)]
}

# Convertir a DataFrame de pandas y luego a PySpark
df_logs_pandas = pd.DataFrame(data_logs)
df_logs = spark.createDataFrame(df_logs_pandas)

# Mostrar una muestra del DataFrame generado
df_logs.show(5)

# Guardar el DataFrame masivo de logs en formato Parquet
df_logs.write.parquet("/dbfs/FileStore/shared_uploads/tu_usuario/logs_masivo.parquet")

print("Archivo Parquet masivo de logs generado y guardado correctamente.")
```

**Explicación**:
- Este DataFrame simula **10 millones** de eventos de logs con tipos de eventos como `LOGIN`, `LOGOUT`, `VIEW`, `CLICK`, y `PURCHASE`, ideal para análisis de eventos y patrones en los datos.
- Al igual que los otros ejemplos, los datos se guardan en formato **Parquet** para mejorar el rendimiento en las consultas.

---

### Conclusión

Con estos recursos generados, estarás listo para ejecutar los laboratorios relacionados con **optimización** y **consultas complejas** sobre grandes volúmenes de datos. Estos datasets masivos permiten probar técnicas como **broadcast join**, **caching**, **particionamiento** y visualización del **plan de ejecución** en situaciones cercanas a entornos reales de Big Data.