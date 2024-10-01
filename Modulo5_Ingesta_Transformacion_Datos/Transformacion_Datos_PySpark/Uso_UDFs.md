### **Uso de funciones de usuario (UDFs)**

Las **User Defined Functions (UDFs)** en PySpark son funciones personalizadas que permiten realizar transformaciones complejas y específicas en los datos, más allá de las operaciones predeterminadas que ofrece PySpark. En el ámbito empresarial, los UDFs son usados para manejar casos únicos, reglas de negocio particulares o cálculos avanzados que no se pueden realizar directamente con las funciones nativas de PySpark.

#### **Caso de uso 1: Normalización de direcciones en logística**

En una empresa de logística, los datos de dirección pueden estar escritos de diferentes maneras (variaciones en el nombre de la calle, abreviaciones, etc.). Para estandarizar estos datos y facilitar la integración con sistemas de geolocalización o envío de paquetes, es común utilizar UDFs que limpien y normalicen las direcciones.

Ejemplo:

```python
from pyspark.sql.functions import udf
from pyspark.sql.types import StringType

# Definir una UDF para normalizar las direcciones
def normalizar_direccion(direccion):
    direccion = direccion.lower().replace("st.", "street").replace("rd.", "road")
    return direccion.title()

# Registrar la UDF en PySpark
normalizar_udf = udf(normalizar_direccion, StringType())

# Aplicar la UDF en una columna de direcciones
df_logistica_normalizado = df_logistica.withColumn("direccion_normalizada", normalizar_udf(df_logistica.direccion))
df_logistica_normalizado.show()
```

**Aplicación**: Esta función puede ayudar a la empresa a mejorar la precisión de la entrega al asegurar que las direcciones son consistentes, lo cual reduce errores en la logística.

---

#### **Caso de uso 2: Cálculo avanzado de impuestos en e-commerce**

En empresas de **e-commerce** que operan en múltiples jurisdicciones, es común que se apliquen diferentes reglas de impuestos para distintos productos y regiones. En lugar de aplicar cálculos manuales o reglas de negocio estáticas, un UDF permite manejar reglas de impuestos específicas para cada producto y país.

Ejemplo:

```python
# Definir una UDF para calcular impuestos basados en la categoría de producto y el país
def calcular_impuesto(producto, pais):
    if pais == "España":
        if producto == "Electrónica":
            return 0.21
        elif producto == "Ropa":
            return 0.10
    elif pais == "Francia":
        if producto == "Electrónica":
            return 0.20
        elif producto == "Ropa":
            return 0.12
    return 0.15  # Impuesto general para otros productos

# Registrar la UDF en PySpark
calcular_impuesto_udf = udf(calcular_impuesto, StringType())

# Aplicar la UDF para calcular el impuesto en base a la columna de producto y país
df_ecommerce = df_ecommerce.withColumn("impuesto_aplicado", calcular_impuesto_udf(df_ecommerce.producto, df_ecommerce.pais))
df_ecommerce.show()
```

**Aplicación**: Esta UDF permite aplicar reglas de negocio específicas y realizar cálculos de impuestos adaptados a las regulaciones locales sin tener que modificar la lógica principal de los pipelines de datos.

---

#### **Caso de uso 3: Clasificación de clientes en marketing basado en comportamiento**

Una empresa de marketing digital puede querer clasificar a sus clientes en diferentes grupos según su comportamiento de compra, por ejemplo, identificar a los clientes "premium" que han gastado más de una cantidad específica o a los "nuevos" clientes que hicieron su primera compra en los últimos 30 días. Estas reglas de clasificación pueden ser implementadas como una UDF.

Ejemplo:

```python
# Definir una UDF para clasificar a los clientes
def clasificar_cliente(gasto_total, dias_como_cliente):
    if gasto_total > 1000:
        return "Premium"
    elif dias_como_cliente <= 30:
        return "Nuevo"
    else:
        return "Regular"

# Registrar la UDF en PySpark
clasificar_cliente_udf = udf(clasificar_cliente, StringType())

# Aplicar la UDF para clasificar a los clientes
df_clientes_clasificados = df_clientes.withColumn("clasificacion", clasificar_cliente_udf(df_clientes.gasto_total, df_clientes.dias_como_cliente))
df_clientes_clasificados.show()
```

**Aplicación**: Este tipo de clasificación puede ser utilizado para segmentar campañas de marketing o personalizar ofertas y promociones, optimizando los recursos de la empresa.

---

**Conclusión**: Las **UDFs** en PySpark permiten a las empresas implementar transformaciones altamente personalizadas que reflejan reglas de negocio específicas, haciendo posible realizar cálculos complejos o transformaciones a medida en un entorno de big data. Esto es particularmente útil en empresas que tienen reglas o procesos de negocio que no pueden ser fácilmente modelados con las funciones integradas de PySpark.