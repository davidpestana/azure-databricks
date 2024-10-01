### **Laboratorio: Programar la ejecución de notebooks con Databricks Jobs**

### **Objetivo del laboratorio**

En este laboratorio, aprenderás a programar la ejecución de notebooks mediante **Databricks Jobs**. Esto permitirá que los procesos de datos por lotes se ejecuten automáticamente en intervalos específicos sin intervención manual. El objetivo es configurar la ejecución automática del pipeline que procesaste en el laboratorio anterior, de forma que se ejecute todos los días a la medianoche y puedas monitorear su progreso y estado.

### **Escenario**

Trabajas en una empresa de **e-commerce** y has creado un pipeline que procesa las ventas diarias, calcula las ventas totales y guarda los resultados en **Azure Data Lake**. Ahora, es necesario automatizar este proceso utilizando **Databricks Jobs**, configurando su ejecución diaria a medianoche y habilitando alertas para recibir notificaciones en caso de fallos.

---

### **Paso 1: Crear un Databricks Job**

El primer paso es crear un **Databricks Job** que ejecute el notebook de procesamiento por lotes.

#### Instrucciones:

1. En el entorno de **Azure Databricks**, accede a la sección **Jobs** en el menú principal.
2. Haz clic en **Create Job**.
3. Asigna un nombre al Job, por ejemplo: `Procesamiento_Ventas_Diarias`.
4. Selecciona el **notebook** que contiene el pipeline de procesamiento por lotes que creaste en el laboratorio anterior.
5. En la sección de clúster, selecciona o configura un clúster con autoescalado que se utilice para ejecutar el Job.

#### Explicación:
- El Job es un mecanismo que permite programar la ejecución de notebooks de forma automática.
- Utilizar un clúster con **autoescalado** garantiza que el pipeline tenga los recursos necesarios para procesar los datos de forma eficiente, sin necesidad de intervención manual para ajustar el tamaño del clúster.

---

### **Paso 2: Configurar la programación del Job**

Ahora que has creado el Job, es necesario configurarlo para que se ejecute automáticamente todos los días a la medianoche.

#### Instrucciones:

1. En la misma página de configuración del Job, selecciona la opción **Schedule**.
2. Configura la programación de la siguiente manera:
   - **Frecuencia**: Diario.
   - **Hora**: Medianoche (00:00).
   - **Zona horaria**: Selecciona la zona horaria de tu región (por ejemplo, CET para España).
3. Guarda la programación.

#### Explicación:
- Configurar la programación diaria garantiza que el pipeline se ejecute automáticamente sin intervención manual. Este tipo de programación es común en los procesos de datos por lotes que deben ejecutarse fuera del horario comercial para evitar afectar a los usuarios durante las horas de trabajo.

---

### **Paso 3: Configurar alertas y notificaciones**

Para monitorear el estado de ejecución del Job y recibir notificaciones en caso de errores, es necesario configurar las alertas en **Databricks Jobs**.

#### Instrucciones:

1. En la configuración del Job, selecciona la pestaña **Notifications**.
2. Configura las notificaciones en función de los siguientes eventos:
   - **On failure**: Recibirás un correo si el Job falla.
   - **On success**: Opcionalmente, puedes recibir una notificación cuando el Job se ejecute con éxito.
   - **On timeout**: Configura una alerta si el Job tarda más de lo esperado en completarse (por ejemplo, más de 1 hora).
3. Introduce las direcciones de correo electrónico a las que se enviarán las notificaciones en caso de error.

#### Explicación:
- Las alertas te permiten estar informado de los fallos o problemas durante la ejecución del pipeline, lo que es crucial en entornos empresariales donde los datos deben estar disponibles y procesados en tiempo y forma.
- La configuración de notificaciones de tiempo límite (**timeout**) te permite detectar rápidamente cuellos de botella en el procesamiento de los datos.

---

### **Paso 4: Ejecutar el Job manualmente**

Es recomendable ejecutar el Job manualmente una vez para verificar que todo funcione correctamente antes de que la programación automática entre en vigor.

#### Instrucciones:

1. En la página del Job, selecciona la opción **Run Now** para ejecutar el pipeline inmediatamente.
2. Monitorea el progreso del Job desde la pestaña de **Runs**.
3. Verifica que el Job se complete correctamente y que los datos se procesen y almacenen como se esperaba en **Azure Data Lake**.

#### Explicación:
- La ejecución manual te permite verificar que el Job se ejecuta correctamente y que los resultados son los esperados antes de que la programación diaria entre en funcionamiento.
- Puedes monitorear el estado del Job en tiempo real desde la interfaz de **Databricks Jobs**.

---

### **Paso 5: Monitorear las ejecuciones del Job**

Una vez que el Job esté en funcionamiento, es importante monitorear su estado regularmente para asegurarte de que se complete sin problemas.

#### Instrucciones:

1. Accede a la sección **Jobs** en el menú de **Databricks**.
2. Selecciona el Job que creaste (`Procesamiento_Ventas_Diarias`).
3. En la pestaña **Runs**, puedes ver el historial de ejecuciones, que incluye:
   - El estado de cada ejecución (éxito o fallo).
   - El tiempo que tardó en completarse cada ejecución.
   - Los logs de errores si algo falló.

#### Explicación:
- Monitorear el Job es importante para detectar problemas con el pipeline a tiempo. Los logs te proporcionan información detallada sobre cualquier error que haya ocurrido y te permiten realizar ajustes si es necesario.
- Asegúrate de revisar periódicamente el tiempo de ejecución para asegurarte de que el procesamiento se realiza dentro de los tiempos esperados.

---

### **Conclusión del laboratorio**

En este laboratorio, has aprendido a:

1. **Configurar un Databricks Job** para automatizar la ejecución de un notebook.
2. **Programar la ejecución diaria** del pipeline de procesamiento de ventas.
3. **Configurar alertas y notificaciones** para estar informado en caso de fallos o problemas durante la ejecución.
4. **Monitorear el estado del Job** y revisar el historial de ejecuciones.

Este proceso de automatización garantiza que los datos se procesen de manera confiable todos los días, lo que es fundamental en entornos empresariales donde los informes y análisis de datos deben estar disponibles a tiempo.