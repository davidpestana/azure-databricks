### **Técnicas de EDA con PySpark**

El análisis exploratorio de datos (EDA) es una etapa crítica en la ciencia de datos. Antes de profundizar en modelos predictivos o algoritmos avanzados, es fundamental comprender los datos que estás trabajando. En PySpark, el EDA se realiza a través de transformaciones y consultas distribuidas que te permiten manejar grandes volúmenes de datos de manera eficiente.

A continuación, exploraremos técnicas clave de EDA en PySpark, abordando desde la manipulación básica de datos hasta transformaciones más complejas. Cada técnica está pensada para ayudarte a construir una comprensión sólida de los datos mientras te preparas para el modelado posterior.

---

### **1. Lectura y exploración inicial de los datos**
El primer paso en cualquier análisis de datos es la **carga** y **visualización inicial** de los datos. En PySpark, los datos se cargan en un **DataFrame** distribuido, lo que permite manejar grandes volúmenes de datos de manera eficiente.

- **Lectura de un archivo CSV**:
  PySpark soporta varios formatos de datos, pero uno de los más comunes es el CSV. A continuación, te muestro cómo cargar un archivo CSV en un DataFrame:

   ```python
   df = spark.read.csv("/path/to/dataset.csv", header=True, inferSchema=True)
   df.show(5)  # Mostrar las primeras 5 filas
   ```

   **Explicación**:
   - `header=True`: Usa la primera fila del archivo como nombres de columna.
   - `inferSchema=True`: PySpark intenta deducir los tipos de datos automáticamente.
   - `show(5)`: Muestra las primeras 5 filas del DataFrame.

   **Ejemplo**: Si cargas un conjunto de datos de ventas, las primeras filas te darán una idea rápida de las columnas (como fechas de transacción, nombres de productos, ventas totales, etc.).

- **Inspección de columnas y esquema**:
   Una vez cargado el DataFrame, es importante inspeccionar su esquema y columnas para entender qué tipo de datos estás manejando.

   ```python
   df.printSchema()
   df.columns  # Devuelve una lista de los nombres de las columnas
   ```

   **Explicación**: `printSchema()` te muestra los tipos de datos de cada columna, lo cual es útil para asegurarte de que el esquema es correcto (numérico, cadena, fecha, etc.).

---

### **2. Resumen estadístico**
Una de las primeras acciones en el análisis de datos es calcular estadísticas descriptivas. Estas estadísticas incluyen métricas como la **media**, **desviación estándar**, **mínimos** y **máximos**, que proporcionan una visión general de la distribución de los datos.

- **Cálculo de estadísticas descriptivas**:
   PySpark incluye el método `describe()` que permite calcular algunas estadísticas clave de forma rápida.

   ```python
   df.describe().show()
   ```

   **Explicación**: Este comando proporciona un resumen estadístico de todas las columnas numéricas del DataFrame, incluyendo la **media**, **mínimo**, **máximo**, **desviación estándar**, y **conteo** de valores no nulos.

   **Ejemplo**: Si estás analizando un conjunto de datos de ventas, podrías usar `describe()` para obtener la media de las ventas por producto y la desviación estándar de los precios.

---

### **3. Identificación y manejo de valores nulos**
Los valores nulos o faltantes son comunes en muchos conjuntos de datos y pueden afectar negativamente el análisis. Antes de continuar, es importante identificar estos valores y decidir cómo manejarlos.

- **Identificación de valores nulos**:
   PySpark te permite contar los valores nulos en cada columna utilizando la función `isNull()`.

   ```python
   from pyspark.sql.functions import col, sum
   df.select([sum(col(c).isNull().cast("int")).alias(c) for c in df.columns]).show()
   ```

   **Explicación**: Este código cuenta los valores nulos en cada columna y muestra el resultado. Conocer la cantidad de valores nulos en cada columna es clave para decidir qué hacer con ellos (imputar o eliminar).

   **Estrategias para manejar valores nulos**:
   1. **Eliminar valores nulos**: Si los valores nulos representan una porción pequeña de los datos, podrías eliminarlos.
      ```python
      df_clean = df.dropna()
      ```

   2. **Imputación de valores nulos**: Si los valores nulos son numerosos, puedes reemplazarlos por la media o la mediana.
      ```python
      from pyspark.ml.feature import Imputer
      imputer = Imputer(inputCols=["columna1", "columna2"], outputCols=["columna1_imputed", "columna2_imputed"])
      df_imputed = imputer.fit(df).transform(df)
      ```

   **Explicación**: `Imputer` reemplaza los valores nulos de las columnas seleccionadas con la media o mediana de la columna. Este proceso es crucial cuando no puedes permitirte eliminar muchas filas, pero necesitas valores completos para análisis posteriores.

---

### **4. Transformaciones de datos**
A menudo, antes de realizar análisis avanzados o construir modelos predictivos, necesitas transformar tus datos para hacerlos más manejables o para crear nuevas variables. Esto incluye la **codificación de variables categóricas**, **normalización** de datos y la **creación de nuevas características**.

- **Codificación de variables categóricas**:
   Cuando trabajas con variables categóricas (como el nombre de un producto), a menudo necesitas convertirlas en variables numéricas para poder incluirlas en modelos. Esto se puede hacer con `StringIndexer` y `OneHotEncoder`.

   ```python
   from pyspark.ml.feature import StringIndexer, OneHotEncoder

   # Convertir variable categórica a índice numérico
   indexer = StringIndexer(inputCol="categoria", outputCol="categoria_indexada")
   df_indexed = indexer.fit(df).transform(df)

   # Aplicar codificación One-Hot
   encoder = OneHotEncoder(inputCol="categoria_indexada", outputCol="categoria_onehot")
   df_encoded = encoder.fit(df_indexed).transform(df_indexed)
   ```

   **Explicación**: `StringIndexer` asigna un valor numérico a cada categoría, y `OneHotEncoder` convierte esa columna numérica en un vector con valores binarios para cada categoría. Este proceso es esencial en muchas aplicaciones de aprendizaje automático que no pueden manejar directamente variables categóricas.

---

### **5. Filtrado y agrupación de datos**
Es común que quieras filtrar o agrupar datos para ver distribuciones por categoría. PySpark te permite hacer esto de manera eficiente utilizando las funciones `filter()`, `groupBy()` y `agg()`.

- **Agrupación y agregación de datos**:
   Puedes calcular agregados como la **media**, **suma**, o **conteo** de diferentes grupos utilizando `groupBy()`.

   ```python
   df.groupBy("categoria").agg({"precio": "mean", "ventas": "sum"}).show()
   ```

   **Explicación**: Este comando agrupa el DataFrame por la columna `categoria` y calcula la **media del precio** y la **suma de las ventas** para cada categoría. Esta es una técnica poderosa para entender cómo se distribuyen ciertas métricas clave a través de diferentes segmentos de los datos.

---

### **Conclusión**
Estas técnicas te permiten comenzar a explorar tus datos de manera eficiente con PySpark. Cada técnica es fundamental para construir una base sólida antes de aplicar técnicas de machine learning o análisis más avanzados.