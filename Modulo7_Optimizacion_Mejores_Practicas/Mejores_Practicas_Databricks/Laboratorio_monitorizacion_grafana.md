### Laboratorio: Uso de Herramientas de Monitoreo Avanzadas (Azure Monitor, Grafana) en Databricks

#### Objetivo:
En este laboratorio, los estudiantes aprenderán a configurar e integrar **Azure Monitor** y **Grafana** para realizar un monitoreo avanzado de clústeres en Databricks. Verán cómo utilizar estas herramientas para visualizar métricas en tiempo real y crear paneles de control personalizados que ayuden a identificar problemas de rendimiento y a optimizar los recursos del clúster.

#### Requisitos:
- Acceso a **Azure Monitor** y **Grafana**.
- Acceso de administrador a un espacio de trabajo en **Databricks**.
- Un clúster en Databricks en funcionamiento.

---

### Paso 1: Configurar Azure Monitor para Recopilar Métricas de Databricks

En este primer paso, configurarás Azure Monitor para recopilar métricas de los clústeres de Databricks.

##### Instrucciones:

1. **Acceder al Portal de Azure**:
   - Inicia sesión en el **portal de Azure** y navega a **Azure Monitor**.
   
2. **Crear un Espacio de Trabajo de Log Analytics**:
   - Dentro de Azure Monitor, selecciona **Log Analytics Workspaces** y haz clic en **Crear**.
   - Completa los campos requeridos:
     - **Nombre**: `Databricks_Monitoring_Workspace`.
     - **Región**: Asegúrate de elegir la misma región que tu espacio de trabajo de Databricks.
   - Haz clic en **Revisar y Crear**, y luego en **Crear**.

3. **Configurar Databricks para enviar métricas a Azure Monitor**:
   - En **Databricks**, abre la consola de administración y selecciona **Clusters**.
   - Ve a las **Advanced Options** del clúster que deseas monitorear.
   - Añade la configuración para habilitar el monitoreo con Azure Monitor:

```bash
spark.databricks.monitoring.enabled true
spark.databricks.monitoring.logAnalytics.workspaceId <workspace-id>
spark.databricks.monitoring.logAnalytics.workspaceKey <workspace-key>
```
   - Sustituye `<workspace-id>` y `<workspace-key>` por los valores correspondientes del espacio de trabajo de Log Analytics que creaste.

4. **Reiniciar el Clúster**:
   - Reinicia el clúster para aplicar los cambios y comenzar a enviar métricas a **Azure Monitor**.

---

### Paso 2: Configurar Grafana para Monitorear Métricas de Databricks

Grafana es una plataforma de monitoreo y visualización que te permite crear paneles personalizados. En este paso, integrarás Grafana con Azure Monitor para monitorear tu clúster de Databricks.

##### Instrucciones:

1. **Instalar Grafana**:
   - Si no tienes Grafana instalado, puedes instalarlo en una máquina virtual de Azure o utilizar la versión en la nube de Grafana (https://grafana.com/).
   - Sigue las instrucciones para la instalación en tu sistema operativo o crea una cuenta en Grafana Cloud si prefieres usar la versión en la nube.

2. **Configurar la conexión entre Grafana y Azure Monitor**:
   - En el portal de Grafana, ve a **Configuration** y selecciona **Data Sources**.
   - Haz clic en **Add data source** y selecciona **Azure Monitor**.
   - Introduce la información necesaria:
     - **Subscription ID**: Puedes encontrarla en el portal de Azure.
     - **Tenant ID**: También puedes encontrar esta información en el portal de Azure.
     - **Client ID** y **Client Secret**: Estos son necesarios para autenticar la conexión a Azure Monitor. Puedes generar un cliente de autenticación siguiendo las instrucciones de **Azure Active Directory**.
   - Haz clic en **Save & Test** para verificar la conexión.

3. **Seleccionar el Espacio de Trabajo de Log Analytics**:
   - En la configuración de Azure Monitor dentro de Grafana, selecciona el espacio de trabajo de Log Analytics (`Databricks_Monitoring_Workspace`) que creaste en el paso anterior.

---

### Paso 3: Crear Paneles de Control en Grafana para Monitorear Databricks

Una vez que Grafana esté conectado a Azure Monitor, crearás paneles de control personalizados para monitorear las métricas clave de tu clúster de Databricks.

##### Instrucciones:

1. **Crear un nuevo panel de control en Grafana**:
   - En el menú de Grafana, selecciona **Create** y luego **Dashboard**.
   - Haz clic en **Add New Panel**.

2. **Seleccionar las métricas del clúster de Databricks**:
   - En la sección de **Query**, selecciona **Azure Monitor** como la fuente de datos.
   - Elige las métricas que quieres monitorear, como:
     - **CPU Utilization**: Porcentaje de uso de la CPU.
     - **Memory Usage**: Uso de la memoria.
     - **Disk I/O**: Operaciones de entrada y salida en disco.
     - **Network Traffic**: Tráfico de red.
   - Haz clic en **Apply** para guardar la configuración del panel.

3. **Personalizar el panel**:
   - Ajusta la visualización del panel utilizando diferentes tipos de gráficos, como gráficos de líneas, barras o indicadores.
   - Añade más paneles al dashboard para incluir múltiples métricas que desees monitorear.

4. **Guardar el panel de control**:
   - Una vez que hayas añadido todas las métricas deseadas, guarda el panel de control.
   - Puedes compartir este panel con otros miembros del equipo o configurar alertas personalizadas en Grafana basadas en las métricas que estás monitoreando.

---

### Paso 4: Configuración de Alertas en Grafana

En este paso, configurarás alertas en Grafana para que te notifique cuando las métricas del clúster de Databricks superen ciertos umbrales.

##### Instrucciones:

1. **Agregar una alerta a un panel de control**:
   - Selecciona un panel en el que desees agregar una alerta (por ejemplo, el panel de **CPU Utilization**).
   - Haz clic en el icono de campana en la esquina superior derecha del panel y selecciona **Create Alert**.

2. **Definir las condiciones de alerta**:
   - En el formulario de alerta, define las condiciones que deben cumplirse para activar la alerta, como:
     - **CPU Utilization** > 85%.
     - **Memory Usage** > 80%.
   - Configura el umbral y la duración de la condición (por ejemplo, si la condición se cumple durante más de 5 minutos).

3. **Configurar notificaciones de alerta**:
   - Selecciona el canal de notificación para la alerta, como **correo electrónico** o **Slack**.
   - Configura los detalles de la notificación, como la dirección de correo electrónico o la integración con Slack.

4. **Guardar la configuración de la alerta**:
   - Guarda la alerta y verifica que esté activa. Grafana te notificará automáticamente cuando las métricas superen los umbrales definidos.

---

### Paso 5: Verificar y Ajustar las Alertas

Después de configurar los paneles y las alertas, es importante probarlas y ajustarlas para asegurarse de que funcionen correctamente.

##### Instrucciones:

1. **Simular una alta carga en el clúster**:
   - Ejecuta un trabajo en **Databricks** que genere una carga alta en el clúster. Por ejemplo, puedes usar el siguiente código para realizar una operación intensiva:

```python
# Ejecutar una operación intensiva para generar carga en el clúster
df = spark.range(1000000000).toDF("number")
df.groupBy("number").count().show()
```

2. **Monitorear en tiempo real**:
   - Vuelve a Grafana y verifica cómo las métricas cambian en tiempo real mientras el trabajo se ejecuta.
   - Si los umbrales definidos se alcanzan, deberías recibir una notificación de alerta.

3. **Ajustar las métricas y umbrales**:
   - Si las alertas se activan demasiado temprano o tarde, ajusta los umbrales y la duración de las condiciones en Grafana.

---

### Conclusión del Laboratorio

En este laboratorio, has aprendido a:
- Configurar **Azure Monitor** y **Grafana** para recopilar métricas de clústeres de Databricks.
- Crear paneles de control personalizados en **Grafana** para visualizar métricas clave.
- Configurar alertas en **Grafana** para que te notifiquen cuando los recursos del clúster superen los umbrales definidos.
- Monitorear y ajustar las alertas basadas en el uso de los recursos del clúster.

Este enfoque te permite mantener un monitoreo avanzado y continuo de tus clústeres de Databricks, lo que garantiza que puedas identificar y resolver problemas de rendimiento antes de que afecten a la operación.