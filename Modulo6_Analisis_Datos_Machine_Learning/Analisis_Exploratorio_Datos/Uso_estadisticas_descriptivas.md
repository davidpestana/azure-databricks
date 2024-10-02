### Uso de Estadísticas Descriptivas en EDA en Databricks

Las **estadísticas descriptivas** juegan un papel fundamental en el **análisis exploratorio de datos (EDA)**, ya que permiten obtener información resumida sobre la estructura y características de los datos. En Databricks, podemos aprovechar tanto **Spark DataFrames** como **pandas** para calcular estas estadísticas. Sin embargo, es crucial utilizar el enfoque correcto según el tamaño y la naturaleza de los datos.

#### 1. **Medidas de Tendencia Central**

- **Media**: La media o promedio es una medida importante para conocer el valor central de los datos.

  - **Con Spark**:
  
    Spark es muy eficiente para calcular la media en grandes conjuntos de datos distribuidos.

    ```python
    from pyspark.sql.functions import mean
    df.select(mean("column_name")).show()
    ```

  - **Con pandas**:
  
    Si los datos son pequeños y pueden caber en la memoria, pandas proporciona un método directo para calcular la media:

    ```python
    df_pandas['column_name'].mean()
    ```

- **Mediana**: La mediana es útil cuando hay valores atípicos que pueden distorsionar la media.

  - **Con Spark**:
  
    Spark utiliza un enfoque aproximado para calcular la mediana y otros percentiles:

    ```python
    df.approxQuantile("column_name", [0.5], 0.0)
    ```

  - **Con pandas**:
  
    Pandas ofrece una función directa para calcular la mediana:

    ```python
    df_pandas['column_name'].median()
    ```

#### 2. **Medidas de Dispersión**

- **Desviación Estándar**: La desviación estándar mide la dispersión de los datos respecto a la media.

  - **Con Spark**:
  
    En Spark, la desviación estándar se calcula eficientemente para grandes volúmenes de datos distribuidos:

    ```python
    from pyspark.sql.functions import stddev
    df.select(stddev("column_name")).show()
    ```

  - **Con pandas**:
  
    Si los datos son pequeños, pandas puede calcularla rápidamente:

    ```python
    df_pandas['column_name'].std()
    ```

- **Varianza**: Mide la dispersión de los datos y es el cuadrado de la desviación estándar.

  - **Con Spark**:

    ```python
    from pyspark.sql.functions import variance
    df.select(variance("column_name")).show()
    ```

  - **Con pandas**:

    ```python
    df_pandas['column_name'].var()
    ```

#### 3. **Medidas de Posición: Percentiles y Cuartiles**

Los **percentiles** y **cuartiles** son útiles para obtener una idea de cómo se distribuyen los datos, dividiéndolos en partes iguales.

- **Con Spark**:
  
  Spark puede calcular percentiles y cuartiles de forma eficiente en grandes conjuntos de datos distribuidos:

  ```python
  df.approxQuantile("column_name", [0.25, 0.5, 0.75], 0.0)
  ```

- **Con pandas**:

  Pandas también proporciona una función directa para calcular percentiles:

  ```python
  df_pandas['column_name'].quantile([0.25, 0.5, 0.75])
  ```

#### 4. **Distribución de los Datos**

- **Histograma**: Los histogramas son útiles para visualizar la distribución de los valores en una columna. Spark no tiene una función directa para histogramas, pero puedes agrupar los datos por rango y contar las ocurrencias.

  - **Con Spark**:

    ```python
    df.groupBy("column_name").count().show()
    ```

  - **Con pandas**:
  
    Si los datos son pequeños, puedes usar pandas para crear un histograma:

    ```python
    df_pandas['column_name'].hist()
    ```

#### 5. **Outliers: Boxplots y Medidas de Asimetría**

- **Boxplot**: Los boxplots ayudan a visualizar la dispersión de los datos y detectar outliers. En Spark, no hay una función nativa para esto, por lo que debes usar **pandas** para conjuntos de datos pequeños.

  - **Con Spark**: Aunque no hay un método directo, puedes usar `approxQuantile` para detectar valores extremos.
  
  - **Con pandas**:

    ```python
    import seaborn as sns
    sns.boxplot(x='column_name', data=df_pandas)
    ```

- **Asimetría (Skewness)**: Indica si los datos están sesgados a la izquierda o derecha.

  - **Con Spark**:

    ```python
    from pyspark.sql.functions import skewness
    df.select(skewness("column_name")).show()
    ```

  - **Con pandas**:

    ```python
    df_pandas['column_name'].skew()
    ```

#### Conclusión

- **Pandas** es una excelente opción para análisis rápidos y cuando trabajas con conjuntos de datos pequeños que pueden caber en la memoria local. Es más sencillo de usar para operaciones personalizadas y visualizaciones.
  
- **Spark** es la herramienta adecuada cuando trabajas con grandes volúmenes de datos. Aunque algunas operaciones pueden parecer más complicadas de realizar que con pandas, Spark distribuye el procesamiento, lo que lo hace eficiente para manejar grandes cantidades de datos en Databricks.

En resumen:
- Para **grandes volúmenes de datos** en Databricks, **Spark DataFrames** son la mejor opción.
- Para **análisis rápidos** o **datos pequeños**, **pandas** puede ser más conveniente.