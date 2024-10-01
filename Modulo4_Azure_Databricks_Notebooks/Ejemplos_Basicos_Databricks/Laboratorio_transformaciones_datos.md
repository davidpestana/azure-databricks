### **Laboratorio: Realizar transformaciones simples y guardar los resultados en un nuevo archivo**

### **Objetivo del laboratorio**

Este laboratorio tiene como objetivo trabajar con un dataset real de vuelos y aplicar varias transformaciones para analizar retrasos en vuelos, calcular métricas relevantes y realizar agrupaciones que nos ayuden a identificar rutas problemáticas. Posteriormente, guardaremos los resultados en un formato eficiente como **Parquet**. Simularemos un escenario empresarial real de una aerolínea que busca optimizar sus operaciones mediante la identificación de rutas con problemas de retrasos.

### **Escenario empresarial**

Imagina que trabajas para una aerolínea que busca mejorar su puntualidad. Tienes acceso a un dataset que contiene información de vuelos, como el tiempo de retraso, la duración, el origen, el destino y la distancia de los vuelos. Tu tarea es realizar un análisis detallado de los vuelos que tienen retrasos significativos, agrupar las rutas que más se retrasan y calcular métricas adicionales que puedan ayudar a identificar problemas operativos. Finalmente, necesitas almacenar estos resultados de manera eficiente para futuras consultas.

---

### **Paso 1: Crear un nuevo notebook en Azure Databricks**

#### Instrucciones

1. Accede a tu **workspace de Azure Databricks**.
2. Selecciona **Workspace** en la barra lateral.
3. Haz clic en **Create** (Crear) y selecciona **Notebook**.
4. Nombra el notebook como "Laboratorio - Análisis Completo de Vuelos".
5. Selecciona **Python** como lenguaje.
6. Selecciona o crea un **clúster** adecuado para ejecutar el análisis.

---

### **Paso 2: Cargar el dataset desde Databricks Datasets**

Vamos a trabajar con un dataset de vuelos proporcionado por **Databricks Datasets**. Este dataset contiene información detallada sobre los vuelos, incluyendo el tiempo de retraso, la distancia, el origen y el destino.

#### Celda 1: Cargar los datos de vuelos

```python
# Cargar el dataset de vuelos desde Databricks Datasets
df_vuelos = spark.read.csv("/databricks-datasets/flights/departuredelays.csv", header=True, inferSchema=True)

# Mostrar los primeros 5 registros para verificar la estructura
df_vuelos.show(5)
```

**Explicación**: Este dataset incluye varios campos importantes, como el origen y destino del vuelo, la distancia entre los aeropuertos, y el tiempo de retraso. En este paso, nos aseguramos de que la estructura de los datos sea correcta antes de continuar con las transformaciones.

---

### **How-To: ¿Qué hacer si no encuentras el dataset en Azure Databricks?**

Si el dataset `/databricks-datasets/flights/departuredelays.csv` no está disponible en tu entorno de Azure Databricks, aquí tienes varias alternativas:

1. **Descargar un dataset similar desde Kaggle**: En Kaggle puedes encontrar datasets de vuelos que contienen información detallada sobre retrasos y rutas de vuelo. Puedes descargarlo y subirlo a tu entorno de Databricks.
   - **Instrucciones**: Descarga el dataset desde [Kaggle Flight Delays](https://www.kaggle.com/usdot/flight-delays), súbelo a Databricks y luego cárgalo:
   ```python
   df_vuelos = spark.read.csv("/mnt/datasets/flight_delays.csv", header=True, inferSchema=True)
   ```

2. **Usar Azure Open Datasets**: También puedes acceder a **Azure Open Datasets**, que contiene información sobre vuelos y retrasos.
   ```python
   from azureml.opendatasets import FlightDelayDataset
   flight_data = FlightDelayDataset().to_spark_dataframe()
   ```

---

### **Paso 3: Filtrar los vuelos con retraso**

En esta etapa, queremos centrarnos en los vuelos que han experimentado retrasos significativos. Vamos a filtrar aquellos vuelos que tienen un retraso superior a 60 minutos, ya que estos son los que más afectan la puntualidad de la aerolínea.

#### Celda 2: Filtrar vuelos con un retraso superior a 60 minutos

```python
# Filtrar vuelos con un retraso mayor a 60 minutos
df_vuelos_retrasados = df_vuelos.filter(df_vuelos["delay"] > 60)

# Mostrar los primeros 5 registros para verificar los datos filtrados
df_vuelos_retrasados.show(5)
```

**Explicación**: En este paso, hemos filtrado solo los vuelos con un retraso significativo, lo cual es importante para enfocar el análisis en los problemas más críticos. Las aerolíneas a menudo se enfocan en los retrasos mayores porque son los que tienen mayor impacto en los pasajeros y en la operación logística.

---

### **Paso 4: Validar la calidad de los datos**

Antes de proceder con el análisis, es fundamental validar la calidad de los datos. En este paso, verificaremos si existen valores nulos en las columnas clave (por ejemplo, origen, destino, distancia y retraso). Los datos incompletos pueden afectar la precisión del análisis, por lo que es importante limpiarlos antes de cualquier transformación adicional.

#### Celda 3: Validar y manejar valores nulos

```python
# Verificar si existen valores nulos en las columnas clave
nulos_origen = df_vuelos_retrasados.filter(df_vuelos_retrasados["origin"].isNull()).count()
nulos_destino = df_vuelos_retrasados.filter(df_vuelos_retrasados["destination"].isNull()).count()
nulos_distancia = df_vuelos_retrasados.filter(df_vuelos_retrasados["distance"].isNull()).count()
nulos_retraso = df_vuelos_retrasados.filter(df_vuelos_retrasados["delay"].isNull()).count()

print(f"Registros con origen nulo: {nulos_origen}")
print(f"Registros con destino nulo: {nulos_destino}")
print(f"Registros con distancia nula: {nulos_distancia}")
print(f"Registros con retraso nulo: {nulos_retraso}")
```

**Explicación**: Este paso es esencial para garantizar que los datos utilizados en el análisis sean consistentes. Si se encuentran valores nulos en las columnas clave, los registros correspondientes serán eliminados o corregidos, lo que asegura que las métricas finales sean confiables.

---

### **Paso 5: Limpiar los datos**

Si encontramos valores nulos en columnas clave, procederemos a eliminar esos registros para asegurar que los datos con los que trabajamos estén completos y listos para el análisis.

#### Celda 4: Eliminar valores nulos

```python
# Eliminar registros con valores nulos en columnas clave
df_vuelos_limpio = df_vuelos_retrasados.dropna(subset=["origin", "destination", "distance", "delay"])

# Mostrar los primeros 5 registros después de la limpieza
df_vuelos_limpio.show(5)
```

**Explicación**: Limpiar los datos es un paso fundamental para evitar sesgos o problemas en los análisis posteriores. En este caso, estamos eliminando los registros incompletos que podrían afectar el cálculo de métricas críticas, como el promedio de retrasos o la duración de los vuelos.

---

### **Paso 6: Crear columnas calculadas**

Vamos a crear una nueva columna calculada que nos permita convertir la distancia en una métrica de duración aproximada de los vuelos, utilizando una velocidad promedio de 500 millas por hora. Esto ayudará a entender cuánto tiempo en promedio debería tomar cada vuelo.

#### Celda 5: Crear la columna calculada de duración de vuelo en horas

```python
# Crear una nueva columna con la duración del vuelo en horas (asumiendo velocidad promedio de 500 millas/hora)
df_vuelos_limpio = df_vuelos_limpio.withColumn("duracion_horas", df_vuelos_limpio["distance"] / 500)

# Mostrar los primeros registros con la nueva columna calculada
df_vuelos_limpio.show(5)
```

**Explicación**: Esta columna es útil para tener una idea aproximada de la duración de cada vuelo en función de la distancia recorrida. Esta métrica puede ser relevante al analizar las diferencias entre la duración esperada y los retrasos que sufren los vuelos en rutas específicas.

---

### **Paso 7: Calcular el promedio de retraso por origen y destino**

Es importante identificar qué rutas presentan mayores problemas de retrasos. Agruparemos los datos por origen y destino para calcular el retraso promedio en cada ruta, lo que nos ayudará a identificar los puntos críticos en la operación de la aerolínea.

#### Celda 6: Calcular el retraso promedio por ruta

```python
# Agrupar por origen y destino, y calcular el promedio de retraso en minutos por ruta
df_retraso_promedio = df_vuelos_limpio.groupBy("origin", "destination").avg("delay")

# Mostrar los primeros 5 registros con el retraso promedio por ruta
df_retraso_promedio.show(5)
```

**Explicación**: Al agrupar los datos por origen y destino, obtenemos el promedio de retraso para cada ruta. Este tipo de análisis es crucial para las aerolíneas, ya que les permite identificar las rutas que necesitan mejoras operativas o logísticas para reducir los tiempos de retraso.

---

### **Paso 8: Guardar los resultados en formato Parquet**

Finalmente, guardaremos los resultados de nuestro análisis en un formato eficiente como **Parquet**, que permite almacenar grandes volúmenes de datos de manera comprimida y optimizada para consultas rápidas.

#### Celda 7:

 Guardar los resultados en formato Parquet

```python
# Guardar los resultados en formato Parquet
df_retraso_promedio.write.format("parquet").mode("overwrite").save("/mnt/airline/retraso_promedio_por_ruta.parquet")
```

**Explicación**: Guardar los datos en formato **Parquet** es una buena práctica en entornos de análisis de grandes volúmenes de datos, ya que este formato permite realizar consultas eficientes y ahorrar espacio de almacenamiento. Es un estándar en la industria para el almacenamiento de datos estructurados.

---

### **Conclusión del laboratorio**

En este laboratorio hemos aprendido a:

- Cargar un dataset real de vuelos desde **Databricks Datasets** (o alternativas como Kaggle o Azure Open Datasets).
- Filtrar los vuelos con retrasos significativos.
- Validar y limpiar los datos eliminando registros incompletos.
- Crear nuevas columnas calculadas para obtener métricas adicionales (duración de vuelo).
- Agrupar los datos por origen y destino para calcular el retraso promedio por ruta.
- Guardar los resultados en formato Parquet, optimizando el almacenamiento y la consulta de datos.

Este flujo de trabajo simula cómo una aerolínea puede analizar datos históricos de vuelos para mejorar la operación y reducir los retrasos en rutas clave.