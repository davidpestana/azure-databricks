### Laboratorio: Configuración de Alertas y Monitoreo de Clústeres en Databricks

#### Objetivo:
El objetivo de este laboratorio es aprender a configurar alertas y monitorear el uso de los recursos de un clúster en Databricks mediante la integración con **Azure Monitor**. También aprenderás a crear umbrales de alerta para que el sistema notifique automáticamente sobre el rendimiento, el estado del clúster y el uso de recursos.

#### Requisitos:
- Acceso a **Azure Monitor** dentro del portal de Azure.
- Acceso de administrador a un espacio de trabajo en **Databricks**.
- Un clúster en Databricks configurado y en ejecución.

---

### Paso 1: Configuración del Clúster en Databricks

En este paso, crearás o utilizarás un clúster en Databricks que será monitoreado y para el cual se configurarán alertas.

##### Instrucciones:

1. **Crear un nuevo clúster**:
   - En el menú de **Clusters** de Databricks, selecciona **Create Cluster**.
   - Nombra el clúster `Monitoring_Cluster`.
   - Configura los recursos del clúster, asegurándote de que el clúster se ajusta a las necesidades de procesamiento de tu organización.
   - Activa las opciones de **Autoscaling** para permitir que el clúster se escale automáticamente según la carga de trabajo.
   - Una vez configurado, haz clic en **Create Cluster** y espera a que el clúster esté en ejecución.

2. **Verificar que el clúster está en funcionamiento**:
   - Revisa la pestaña de estado del clúster y asegúrate de que el clúster se ha iniciado correctamente.

---

### Paso 2: Integración de Azure Monitor con Databricks

Azure Monitor es una plataforma que te permite monitorear métricas y recursos de tus servicios en Azure, incluido Databricks. En este paso, configurarás la integración de Azure Monitor para obtener métricas del clúster.

##### Instrucciones:

1. **Acceder al Portal de Azure**:
   - Abre el **portal de Azure** (https://portal.azure.com) y navega a **Azure Monitor**.

2. **Crear una nueva cuenta de Log Analytics**:
   - Dentro de **Azure Monitor**, selecciona **Log Analytics Workspaces** y haz clic en **Crear**.
   - Completa los detalles:
     - **Nombre**: `Databricks_Monitoring`.
     - **Región**: Selecciona la misma región en la que tienes tu clúster de Databricks.
   - Haz clic en **Revisar y Crear**, y luego en **Crear** para crear el espacio de trabajo de Log Analytics.

3. **Configurar el espacio de trabajo en Databricks**:
   - Vuelve a **Databricks**.
   - En la consola de administración, selecciona **Clusters**, y en el clúster `Monitoring_Cluster`, ve a **Advanced Options** y luego a **Spark**.
   - Añade la siguiente configuración:

```bash
spark.databricks.monitoring.enabled true
spark.databricks.monitoring.logAnalytics.workspaceId <workspace-id>
spark.databricks.monitoring.logAnalytics.workspaceKey <workspace-key>
```

   - Sustituye `<workspace-id>` y `<workspace-key>` por los valores correspondientes de tu espacio de trabajo de Log Analytics, que puedes obtener desde **Azure Monitor** en el portal de Azure.

4. **Reiniciar el clúster**:
   - Después de configurar estos parámetros, reinicia el clúster para que los cambios surtan efecto.

---

### Paso 3: Configurar Métricas y Alertas en Azure Monitor

En este paso, configurarás alertas basadas en las métricas del clúster de Databricks para recibir notificaciones cuando ciertos umbrales sean superados, como el uso de CPU o memoria.

##### Instrucciones:

1. **Configurar métricas de clúster**:
   - En el portal de **Azure Monitor**, selecciona **Métricas** en el menú de la izquierda.
   - En la pestaña de **Recursos**, selecciona el clúster de Databricks que creaste.
   - Elige métricas como **CPU Utilization**, **Memory Usage**, **Disk I/O**, y **Network Traffic**.
   - Puedes visualizar estas métricas en tiempo real para ver cómo el clúster está usando los recursos.

2. **Crear alertas basadas en las métricas**:
   - Haz clic en **Crear Alerta** en la esquina superior derecha.
   - En el panel de creación de alertas, selecciona las métricas críticas, como:
     - **CPU Utilization** superior al 85%.
     - **Memory Usage** superior al 80%.
     - **Disk I/O** que supera cierto umbral.
   - Configura una **acción de alerta** para que te envíe un correo electrónico o mensaje SMS cuando se superen estos límites.

3. **Configurar el umbral de alerta**:
   - Define los umbrales para cada métrica. Por ejemplo:
     - Si la **utilización de CPU** supera el 85%, el sistema te enviará una alerta.
   - Configura la severidad de la alerta (por ejemplo, **Warning** o **Critical**) dependiendo de la importancia de la métrica.

4. **Asignar acciones a la alerta**:
   - En la pestaña **Acciones**, selecciona el tipo de notificación que prefieras: correo electrónico, webhook o mensaje SMS.
   - Configura los detalles de la notificación, como la dirección de correo o el número de teléfono.

---

### Paso 4: Verificación de las Alertas

Después de configurar las alertas y los umbrales, es importante verificar que funcionan correctamente.

##### Instrucciones:

1. **Simular una carga alta en el clúster**:
   - Abre un notebook en **Databricks** y ejecuta una tarea que utilice muchos recursos, como una operación de `groupBy` o un procesamiento de datos intensivo.
   - Ejemplo de código para ejecutar:

```python
# Cargar un dataset grande y realizar una operación intensiva
df = spark.range(1000000000).toDF("number")
df.groupBy("number").count().show()
```

2. **Revisar Azure Monitor**:
   - Vuelve a **Azure Monitor** y observa cómo las métricas del clúster cambian a medida que la carga aumenta.
   - Verifica que las alertas configuradas se disparen si los umbrales establecidos se alcanzan.

3. **Revisar las notificaciones**:
   - Verifica que las notificaciones que configuraste (correo electrónico, SMS, etc.) se envían correctamente cuando se supera un umbral crítico.

---

### Paso 5: Optimización Basada en las Métricas

En este paso, utilizarás las métricas recopiladas para realizar ajustes en el clúster y mejorar el rendimiento.

##### Instrucciones:

1. **Analizar las métricas**:
   - Observa en Azure Monitor las tendencias de las métricas mientras se ejecutan los trabajos en el clúster.
   - Si las métricas de CPU o memoria están consistentemente altas, considera aumentar el tamaño del clúster o activar más nodos con autoscaling.

2. **Optimizar el uso del clúster**:
   - Si las alertas indican que ciertos recursos (como CPU o memoria) están al máximo, ajusta el tamaño del clúster o el paralelismo de las tareas en Spark.
   - Usa **autoscaling** si no está activado para permitir que el clúster se ajuste dinámicamente según la carga de trabajo.

---

### Conclusión del Laboratorio

En este laboratorio, aprendiste a:
- Configurar un clúster en Databricks con autoscaling habilitado.
- Integrar Databricks con **Azure Monitor** para obtener métricas de rendimiento en tiempo real.
- Configurar alertas personalizadas para recibir notificaciones cuando los recursos del clúster superan los umbrales establecidos.
- Monitorear el uso de CPU, memoria y disco en Azure Monitor y ajustar el tamaño del clúster según el uso de recursos.

Con estas habilidades, puedes optimizar el rendimiento de tus clústeres de Databricks y asegurar que siempre se ejecuten de manera eficiente y sin interrupciones críticas.