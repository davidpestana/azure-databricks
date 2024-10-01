### Transformaciones básicas de datos

Las transformaciones de datos en Databricks permiten a las empresas limpiar, organizar y estructurar los datos en un formato adecuado para análisis más complejos. A través de operaciones como el filtrado, la agregación, la unión y las conversiones de tipos de datos, las organizaciones pueden preparar grandes volúmenes de información para obtener insights que les permitan tomar decisiones más informadas. A continuación, se exponen diferentes casos de uso en diversos sectores empresariales, que aplican transformaciones básicas de datos para responder a necesidades reales.

---

#### 1. Caso de uso: Filtrado de registros en el sector de seguros

En el sector de seguros, las empresas necesitan filtrar datos de pólizas y reclamaciones para detectar potenciales fraudes o patrones inusuales. Imagina que tienes un dataset que contiene todas las reclamaciones de los asegurados y necesitas filtrar aquellas reclamaciones por montos superiores a un umbral y en categorías específicas, como "accidentes de coche".

```python
# Leer datos de reclamaciones
df_reclamaciones = spark.read.parquet("/mnt/seguros/reclamaciones.parquet")

# Filtrar las reclamaciones por categoría 'Accidente de coche' y montos superiores a 20,000
df_filtrado = df_reclamaciones.filter((df_reclamaciones['categoria'] == 'Accidente de coche') & (df_reclamaciones['monto'] > 20000))

# Mostrar las primeras 5 reclamaciones filtradas
df_filtrado.show(5)
```

**Explicación**: Esta transformación permite reducir el conjunto de datos a aquellas reclamaciones que requieren más atención debido a su categoría o monto elevado. En sectores como el de seguros, este tipo de análisis es fundamental para detectar reclamaciones sospechosas y gestionar riesgos de manera eficiente.

---

#### 2. Caso de uso: Limpieza y eliminación de duplicados en el sector de recursos humanos

En el ámbito de recursos humanos, es común trabajar con datos de empleados donde pueden existir registros duplicados debido a errores en la entrada de datos. Para generar informes precisos, es importante eliminar estos duplicados antes de realizar cualquier análisis.

```python
# Leer datos de empleados
df_empleados = spark.read.csv("/mnt/recursos_humanos/empleados.csv", header=True, inferSchema=True)

# Eliminar registros duplicados basados en la identificación del empleado
df_empleados_limpios = df_empleados.dropDuplicates(["id_empleado"])

# Mostrar los primeros 5 registros después de eliminar duplicados
df_empleados_limpios.show(5)
```

**Explicación**: En el sector de recursos humanos, eliminar duplicados garantiza que los análisis y reportes relacionados con el número de empleados o sus métricas (como antigüedad o salario) sean precisos. Mantener bases de datos limpias también permite tomar decisiones más fiables en la planificación de la fuerza laboral.

---

#### 3. Caso de uso: Creación de columnas calculadas en el sector de comercio electrónico

Las empresas de comercio electrónico necesitan analizar métricas de ventas, como el precio final después de aplicar impuestos o descuentos. La creación de columnas calculadas permite agregar información relevante a los datos originales para calcular métricas personalizadas.

```python
# Leer datos de ventas
df_ventas = spark.read.parquet("/mnt/ecommerce/ventas.parquet")

# Calcular el precio final aplicando un impuesto del 15%
df_ventas_con_precio_final = df_ventas.withColumn("precio_final", df_ventas["precio"] * 1.15)

# Mostrar los primeros 5 registros con la columna calculada
df_ventas_con_precio_final.show(5)
```

**Explicación**: Agregar una columna calculada para el precio final es una transformación sencilla pero crítica para las empresas de comercio electrónico. Este tipo de transformación permite a los analistas calcular métricas clave como ingresos netos o márgenes de ganancia y compararlas en diferentes escenarios.

---

#### 4. Caso de uso: Agrupación de datos por categorías en el sector de energía

Las empresas del sector energético suelen analizar grandes volúmenes de datos de consumo eléctrico. Una operación común es agrupar estos datos por día o por tipo de cliente para analizar los patrones de consumo y hacer previsiones.

```python
# Leer datos de consumo de energía
df_consumo_energia = spark.read.csv("/mnt/energia/consumo_diario.csv", header=True, inferSchema=True)

# Agrupar por día y sumar el consumo total de energía
df_consumo_diario = df_consumo_energia.groupBy("fecha").sum("consumo_energia")

# Mostrar los primeros 5 resultados del consumo diario
df_consumo_diario.show(5)
```

**Explicación**: Este tipo de agregación permite a las empresas energéticas obtener una visión clara de cómo varía el consumo de energía a lo largo del tiempo. Estas métricas son útiles para hacer previsiones y gestionar la oferta energética de manera más eficiente.

---

#### 5. Caso de uso: Transformaciones de datos de salud en hospitales

Los hospitales manejan datos médicos sensibles de pacientes, donde es importante realizar transformaciones que aseguren la privacidad, como el enmascaramiento de información, además de agrupar datos por diagnóstico para obtener métricas agregadas.

```python
# Leer datos de pacientes
df_pacientes = spark.read.csv("/mnt/hospital/pacientes.csv", header=True, inferSchema=True)

# Enmascarar información sensible (por ejemplo, ocultar parte del número de seguro social)
df_pacientes_enmascarados = df_pacientes.withColumn("ssn_enmascarado", 
                             concat(lit("***-**-"), substring(df_pacientes["ssn"], -4, 4)))

# Agrupar por diagnóstico y contar el número de pacientes
df_pacientes_diagnostico = df_pacientes_enmascarados.groupBy("diagnostico").count()

# Mostrar los primeros 5 diagnósticos con el conteo de pacientes
df_pacientes_diagnostico.show(5)
```

**Explicación**: La protección de datos sensibles es un requisito fundamental en el sector de la salud. Este ejemplo muestra cómo enmascarar información personal y, al mismo tiempo, realizar agregaciones por diagnóstico para obtener información útil para los médicos y administradores del hospital.

---

#### 6. Caso de uso: Unión de datos geográficos en el sector de transporte

En el sector de transporte, es común combinar datos geográficos de rutas con datos operativos de vehículos para obtener una visión completa del estado de las flotas y las rutas.

```python
# Leer datos de rutas y datos de vehículos
df_rutas = spark.read.csv("/mnt/transporte/rutas.csv", header=True, inferSchema=True)
df_vehiculos = spark.read.csv("/mnt/transporte/vehiculos.csv", header=True, inferSchema=True)

# Unir datos de rutas con información de vehículos por el ID de ruta
df_rutas_vehiculos = df_rutas.join(df_vehiculos, "id_ruta", "inner")

# Mostrar los primeros 5 registros de la unión
df_rutas_vehiculos.show(5)
```

**Explicación**: Esta operación de unión es fundamental para analizar el rendimiento de las rutas de transporte y el estado de los vehículos que las realizan. Las empresas de transporte pueden optimizar el uso de su flota y mejorar la eficiencia de sus rutas al combinar estos dos conjuntos de datos.

---

#### 7. Caso de uso: Conversión de tipos de datos en la industria farmacéutica

En la industria farmacéutica, es importante garantizar que los datos se encuentren en el formato correcto para su análisis. En muchos casos, es necesario convertir tipos de datos para que sean consistentes y permitan realizar cálculos precisos.

```python
# Leer datos de producción de medicamentos
df_produccion = spark.read.csv("/mnt/farmaceutica/produccion_medicamentos.csv", header=True, inferSchema=True)

# Convertir la columna de producción a tipo entero
df_produccion = df_produccion.withColumn("cantidad_producida", df_produccion["cantidad_producida"].cast("int"))

# Mostrar los primeros 5 registros con la columna convertida
df_produccion.show(5)
```

**Explicación**: En la industria farmacéutica, es crucial que las columnas como "cantidad producida" estén en el formato correcto (en este caso, entero) para poder realizar cálculos de producción y analizar la eficiencia de las plantas de fabricación.

---

### Conclusión

Las transformaciones básicas en Databricks son aplicables en una amplia variedad de sectores empresariales, desde seguros y salud hasta transporte y energía. Estas operaciones permiten a las empresas preparar sus datos para análisis más avanzados, optimizar procesos y obtener insights que son clave para tomar decisiones informadas. Las transformaciones de filtrado, agregación, creación de columnas calculadas y uniones son herramientas esenciales en cualquier flujo de trabajo de datos masivos.