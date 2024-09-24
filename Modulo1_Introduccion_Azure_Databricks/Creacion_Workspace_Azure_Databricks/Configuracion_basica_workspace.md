### Configuración Básica del Workspace de Azure Databricks

Una vez creado el **recurso de Azure Databricks**, el siguiente paso es realizar la configuración básica del workspace. Esta configuración incluye la creación de clústeres de Apache Spark, la gestión de permisos de acceso y la personalización de los ajustes iniciales para trabajar de manera eficiente dentro del entorno de Databricks.

---

#### Componentes Clave de la Configuración Básica

1. **Creación de Clústeres de Apache Spark**
   - Un **clúster** en Azure Databricks es el conjunto de máquinas virtuales que ejecutan los trabajos de procesamiento de datos utilizando **Apache Spark**.
   - Los clústeres pueden ser escalables, lo que significa que pueden ajustarse automáticamente según la carga de trabajo, o configurarse de manera manual para tener un número fijo de nodos.
   
   **Pasos para Crear un Clúster**:
   - Accede a la interfaz de Azure Databricks y, en la barra lateral izquierda, selecciona **Clusters**.
   - Haz clic en **Create Cluster**.
   - Completa los campos requeridos:
     - **Nombre del Clúster**: Proporciona un nombre único y descriptivo para tu clúster.
     - **Versión de Spark**: Selecciona la versión de Apache Spark que deseas usar (por defecto, se seleccionará la última versión estable).
     - **Tipo de Nodos**: Elige el tipo de máquinas virtuales (VMs) que se usarán para los nodos del clúster. Para propósitos de prueba, puedes elegir instancias de tipo **Standard_DS3_v2** o similares.
     - **Número de Nodos**: Especifica cuántos nodos deseas tener en el clúster o habilita la opción de **autoescalado** para que el clúster aumente o disminuya la cantidad de nodos automáticamente.
   
   - Haz clic en **Create** para iniciar el clúster. El proceso puede tardar algunos minutos, dependiendo del tamaño del clúster.

   **Recomendaciones**:
   - Para trabajos ligeros o pruebas iniciales, utiliza un clúster pequeño con un número limitado de nodos para ahorrar costos.
   - Si vas a ejecutar trabajos de producción con grandes volúmenes de datos, considera habilitar el autoescalado para manejar picos de demanda.

---

2. **Gestión de Permisos y Usuarios**
   - Azure Databricks está completamente integrado con **Azure Active Directory (Azure AD)**, lo que permite gestionar los permisos de acceso de usuarios y equipos.
   - Puedes agregar usuarios o grupos de usuarios desde Azure AD y asignarles roles como **Admin**, **User** o **Viewer**, según el nivel de acceso que necesiten.

   **Agregar Usuarios al Workspace**:
   - En la interfaz de Azure Databricks, haz clic en el icono de perfil en la esquina superior derecha y selecciona **Admin Console**.
   - En la pestaña **Users**, haz clic en **Add User**.
   - Ingresa el correo electrónico del usuario que deseas agregar o selecciona usuarios desde Azure Active Directory.
   - Asigna un rol al usuario:
     - **Admin**: Acceso total para gestionar el workspace y los recursos.
     - **User**: Puede crear y ejecutar notebooks, pero no gestionar la configuración de seguridad ni los clústeres.
     - **Viewer**: Tiene acceso de solo lectura a los recursos del workspace.

   **Recomendaciones**:
   - Asigna roles con base en el principio de **menor privilegio**, dando acceso solo a los recursos que un usuario necesita para realizar su trabajo.
   - Si gestionas un equipo grande, utiliza grupos de Azure AD para gestionar permisos de manera más eficiente.

---

3. **Configuración de Librerías**
   - Las **librerías** son paquetes adicionales de software que puedes instalar en los clústeres para utilizarlos en los notebooks de Databricks. Estos paquetes incluyen librerías de Python, Scala, R, entre otros.
   - Databricks proporciona una serie de librerías preinstaladas, pero puedes añadir librerías personalizadas según tus necesidades.

   **Agregar Librerías a un Clúster**:
   - En la sección **Clusters**, selecciona el clúster en el que deseas instalar las librerías.
   - Haz clic en **Libraries** y luego en **Install New**.
   - Puedes instalar librerías desde varias fuentes:
     - **Maven**: Para librerías Java/Scala.
     - **PyPI**: Para librerías Python (por ejemplo, `pandas`, `numpy`).
     - **CRAN**: Para librerías R.
     - **Cargar un archivo**: Si tienes una librería personalizada, puedes subirla desde tu computadora o desde un almacenamiento externo (como S3 o Azure Blob Storage).
   - Una vez seleccionada la librería, haz clic en **Install**.

   **Recomendaciones**:
   - Asegúrate de instalar solo las librerías necesarias para mantener el entorno del clúster ligero y evitar conflictos entre versiones de paquetes.
   - Si utilizas una librería en múltiples clústeres, puedes configurarla como librería compartida para ahorrar tiempo.

---

4. **Gestión del Almacenamiento**
   - Azure Databricks se integra de manera nativa con **Azure Blob Storage** y **Azure Data Lake Storage (ADLS)**. Esto te permite almacenar y acceder a grandes volúmenes de datos directamente desde tu workspace.
   - Para interactuar con estos sistemas de almacenamiento, puedes utilizar **Databricks File System (DBFS)**, que es una abstracción que permite leer y escribir datos de manera similar a un sistema de archivos local.

   **Conectar Azure Blob Storage o ADLS**:
   - Desde un notebook en Azure Databricks, puedes montar un contenedor de **Azure Blob Storage** o **ADLS** usando las credenciales adecuadas:
     ```python
     # Montar un contenedor de Azure Blob Storage
     storage_account_name = "nombre_cuenta_almacenamiento"
     container_name = "nombre_contenedor"
     storage_account_access_key = "clave_de_acceso"

     dbutils.fs.mount(
         source = f"wasbs://{container_name}@{storage_account_name}.blob.core.windows.net",
         mount_point = f"/mnt/{container_name}",
         extra_configs = {f"fs.azure.account.key.{storage_account_name}.blob.core.windows.net": storage_account_access_key}
     )
     ```
   - Los datos montados estarán disponibles en el directorio `/mnt/` dentro de DBFS, desde donde puedes leer o escribir archivos en tus notebooks de Databricks.

   **Recomendaciones**:
   - Utiliza **Azure Key Vault** para gestionar de manera segura las credenciales de almacenamiento.
   - Si trabajas con grandes volúmenes de datos, utiliza **ADLS Gen2**, que está optimizado para cargas de trabajo de Big Data.
---

El **"modo de acceso"** en Azure Databricks se refiere a cómo los usuarios y los trabajos interactúan con el clúster de Spark. Este parámetro define los permisos y la forma en la que el clúster interactúa con los datos y otros servicios dentro de tu infraestructura. Existen varios modos de acceso, y cada uno tiene diferentes implicaciones en términos de seguridad, permisos y aislamiento. Veamos las opciones más comunes:

### 1. **Modo de Acceso Estándar (Standard Mode)**:
   - **Descripción**: Este es el modo predeterminado en el que los trabajos en un clúster tienen acceso completo a los datos, clústeres, y otros recursos dentro del workspace. Todos los usuarios que se conectan al clúster comparten el mismo contexto de Spark.
   - **Implicaciones**:
     - **Permisos compartidos**: Todos los usuarios que acceden al clúster pueden ejecutar trabajos y compartir el mismo espacio de trabajo dentro del clúster.
     - **Seguridad limitada**: No hay aislamiento fuerte entre los trabajos de diferentes usuarios; pueden acceder y modificar recursos de Spark dentro del clúster que otros usuarios también están usando.
     - **Uso típico**: Ideal para entornos colaborativos donde no es necesario un aislamiento estricto entre usuarios, como en un entorno de desarrollo compartido o una clase.
   
### 2. **Modo de Acceso Aislado (No Isolation Shared Mode)**:
   - **Descripción**: Este modo es muy similar al "Modo Estándar", pero agrega algunos niveles de aislamiento entre los trabajos de diferentes usuarios. A pesar de que los trabajos comparten el mismo clúster, cada usuario tiene su propio contexto de ejecución de Spark (su propio driver).
   - **Implicaciones**:
     - **Aislamiento parcial**: Aunque el clúster es compartido, los trabajos de los usuarios se ejecutan en sus propios drivers, lo que proporciona un aislamiento básico.
     - **Permisos independientes**: Cada trabajo tiene un control más individualizado sobre los recursos y datos.
     - **Uso típico**: Útil en escenarios donde diferentes usuarios deben ejecutar trabajos en el mismo clúster pero requieren un poco más de control sobre sus propios trabajos, sin interferir con los trabajos de otros usuarios.
   
### 3. **Modo de Acceso con Red Privada (Single User Mode)**:
   - **Descripción**: En este modo, el clúster está completamente aislado para un solo usuario. Nadie más puede acceder al clúster ni ejecutar trabajos en él. Está diseñado para situaciones donde se requiere un alto nivel de seguridad y aislamiento.
   - **Implicaciones**:
     - **Máximo aislamiento**: Solo un usuario tiene acceso al clúster. Nadie más puede interactuar o ejecutar trabajos en él, lo que asegura que no haya interferencia con los trabajos de otros usuarios.
     - **Seguridad robusta**: Ideal para situaciones donde se manejan datos sensibles o cuando es necesario un alto nivel de control sobre la seguridad y el aislamiento de los recursos.
     - **Uso típico**: Clústeres utilizados para trabajos con datos altamente sensibles, o cuando es necesario que el clúster esté dedicado a un solo usuario o trabajo.

### 4. **Modo de Acceso con Aislamiento Completo (High Concurrency Mode)**:
   - **Descripción**: Este modo es altamente seguro y está diseñado para casos en los que muchos usuarios se conectan simultáneamente al clúster. El aislamiento es fuerte, lo que significa que los trabajos de cada usuario se ejecutan en contextos completamente independientes.
   - **Implicaciones**:
     - **Máximo aislamiento y seguridad**: Cada trabajo o usuario está completamente aislado de los demás, con un entorno seguro. También mejora la capacidad del clúster para manejar múltiples trabajos simultáneamente.
     - **Optimización para concurrencia**: Ideal para casos donde hay muchos usuarios ejecutando trabajos al mismo tiempo. Este modo optimiza los recursos del clúster para manejar múltiples peticiones simultáneas.
     - **Uso típico**: Perfecto para entornos de producción en los que muchos usuarios acceden al mismo clúster con trabajos concurrentes, y donde el aislamiento y la seguridad son críticos.
   
### Resumen de Implicaciones según Modo de Acceso:

| **Modo de Acceso**              | **Aislamiento**                           | **Seguridad**                             | **Escenario Ideal**                         |
|----------------------------------|-------------------------------------------|-------------------------------------------|---------------------------------------------|
| **Estándar (Standard Mode)**     | Bajo                                       | Limitada (contexto compartido)            | Entornos colaborativos o de desarrollo.     |
| **Aislado (No Isolation)**       | Parcial                                    | Mejor que el estándar                     | Trabajo en equipo con más aislamiento.      |
| **Red Privada (Single User)**    | Alto (aislado a un solo usuario)           | Alta seguridad                            | Trabajo individual o datos sensibles.       |
| **Alta Concurrencia (High Concurrency)** | Alto (contextos completamente independientes) | Máxima seguridad y manejo de usuarios simultáneos | Producción y múltiples usuarios concurrentes. |

### ¿Qué implica el "modo de acceso" para compartir entre workspaces?
El modo de acceso no influye directamente en la capacidad de compartir clústeres entre diferentes workspaces de Databricks. Como mencionamos antes, los clústeres no pueden compartirse entre workspaces. El "modo de acceso" se refiere más a cómo se gestiona el acceso y la seguridad dentro de un mismo workspace y cómo los usuarios interactúan con los recursos de Spark en un clúster específico.

En resumen, el **"modo de acceso"** define cómo los usuarios y los trabajos interactúan con los recursos del clúster dentro de un workspace, pero no permite compartir esos recursos entre diferentes workspaces de Databricks.

---

En **Azure Databricks**, los tres modos de cómputo — **Pools de Instancias**, **Cómputo Interactivo** (Clusters Interactivos) y **Cómputo de Trabajos** (Clusters de Jobs) — tienen propósitos y características específicos que los diferencian. Aquí te explico cada uno:

### 1. **Pools de Instancias (Instance Pools)**:
   - **Descripción**: Un **pool de instancias** es un grupo predefinido de máquinas virtuales que están en espera de ser asignadas a un clúster. Esto ayuda a reducir el tiempo de inicio de los clústeres al reutilizar instancias, en lugar de aprovisionar nuevas máquinas desde cero cada vez que se lanza un clúster.
   - **Uso principal**: Optimizar el tiempo de arranque y los costos, especialmente cuando se lanzan muchos clústeres frecuentemente.
   - **Ventajas**:
     - **Arranque más rápido**: Los clústeres se inician más rápidamente porque las instancias ya están listas para ser usadas.
     - **Ahorro de costos**: Puedes gestionar mejor los costos al compartir instancias entre varios clústeres.
     - **Flexibilidad**: Permite la creación tanto de clústeres interactivos como de clústeres de trabajos con tiempos de inicio más cortos.
   - **Aplicación**: Ideal cuando tienes muchos usuarios o cargas de trabajo que requieren la creación y destrucción frecuente de clústeres.

### 2. **Cómputo Interactivo (Clusters Interactivos)**:
   - **Descripción**: Son clústeres que se utilizan principalmente para **análisis exploratorios, desarrollo, pruebas** y uso interactivo de notebooks en Databricks. Estos clústeres permiten a los usuarios conectarse y trabajar de manera interactiva con los datos.
   - **Uso principal**: Desarrollo, pruebas, exploración de datos y trabajo interactivo con notebooks.
   - **Ventajas**:
     - **Interacción en tiempo real**: Los usuarios pueden ejecutar consultas, scripts o notebooks y ver resultados en tiempo real.
     - **Persistencia**: Un clúster interactivo puede permanecer activo para varias sesiones de trabajo, permitiendo a los usuarios reconectar en lugar de reiniciar el clúster.
   - **Aplicación**: Perfecto para tareas de desarrollo y experimentación donde se requiere iterar y probar diferentes enfoques en tiempo real.

### 3. **Cómputo de Trabajos (Clusters de Jobs)**:
   - **Descripción**: Los clústeres de trabajos están diseñados para ejecutar **trabajos programados** o **tareas por lotes** (batch jobs) en Databricks. Estos clústeres generalmente se crean cuando se lanza un trabajo y se destruyen automáticamente cuando el trabajo ha finalizado.
   - **Uso principal**: Ejecución de trabajos programados o por lotes, donde el clúster se puede crear y destruir de forma automatizada según sea necesario.
   - **Ventajas**:
     - **Eficiencia**: Los clústeres de trabajos se crean únicamente cuando son necesarios, lo que ayuda a reducir costos ya que no permanecen activos entre trabajos.
     - **Escalabilidad**: Diseñado para ejecutar grandes volúmenes de datos o procesos automatizados de larga duración.
   - **Aplicación**: Ideal para la automatización de procesos, pipelines de datos o trabajos ETL programados que se ejecutan de manera periódica o bajo demanda.

### Diferencias clave:

| Característica               | **Pool de Instancias**                | **Cómputo Interactivo**               | **Cómputo de Trabajos**               |
|------------------------------|---------------------------------------|---------------------------------------|---------------------------------------|
| **Propósito**                | Reducir tiempos de arranque y optimizar costos al reutilizar instancias. | Desarrollo y análisis interactivo con notebooks. | Ejecución de trabajos programados o por lotes. |
| **Persistencia del clúster** | N/A (instancias reutilizables)         | Los clústeres pueden persistir entre sesiones. | Los clústeres se crean y destruyen por cada trabajo. |
| **Tiempo de arranque**       | Muy rápido, ya que las instancias están listas. | Depende de la disponibilidad de máquinas, puede tardar más. | Se crean en el momento de la ejecución del trabajo, por lo que puede tardar más. |
| **Costo**                    | Ahorro de costos mediante la reutilización de instancias. | Mayor costo si los clústeres se mantienen activos sin uso. | Ahorro de costos, ya que los clústeres se destruyen al finalizar el trabajo. |
| **Aplicación típica**        | Entornos con alta demanda de clústeres con tiempos de inicio rápidos. | Desarrollo, experimentación y análisis interactivo. | Ejecución de trabajos ETL, pipelines de datos, o automatización de procesos. |

### Resumen:
- Si buscas **acelerar el tiempo de creación de clústeres** y reutilizar recursos, los **pools de instancias** son ideales.
- Si necesitas **trabajar de manera interactiva** con datos en un entorno de notebooks, el **cómputo interactivo** es la mejor opción.
- Si estás **ejecutando trabajos por lotes o programados**, el **cómputo de trabajos** es más adecuado, ya que permite crear y destruir clústeres en función de la ejecución del trabajo.

Cada uno tiene su aplicación específica dependiendo de las necesidades de tu curso o proyecto.

---

Para evitar costos innecesarios en **Azure Databricks** (o cualquier otro proveedor en la nube), lo recomendable es **parar** o **detener** los clústeres cuando no los estás utilizando activamente. Sin embargo, hay algunas consideraciones importantes a tener en cuenta:

### Opción 1: **Parar (Stop) el Clúster**
- **Costos asociados**: Cuando paras un clúster, los nodos de trabajo (las máquinas virtuales) se liberan y no generan costos por uso de recursos computacionales. Sin embargo, es posible que todavía tengas costos mínimos asociados al **almacenamiento persistente** del clúster, como los **discos de almacenamiento** que se mantienen asignados para guardar configuraciones del clúster o caché de datos.
- **Ventaja**: Parar el clúster te permite reanudarlo rápidamente cuando lo necesites sin tener que volver a configurar todo desde cero.
- **Desventaja**: Aunque los costos son significativamente menores que si el clúster estuviera corriendo, podrían seguir generándose costos mínimos por el almacenamiento.

### Opción 2: **Eliminar (Delete) el Clúster**
- **Costos asociados**: Eliminar un clúster destruye por completo los recursos asociados, por lo que no hay costos recurrentes ni por uso de máquinas virtuales ni por almacenamiento persistente.
- **Ventaja**: No genera costos adicionales en absoluto una vez que el clúster es eliminado.
- **Desventaja**: La próxima vez que necesites el clúster, tendrás que volver a crearlo y configurarlo desde cero, lo que puede llevar algo de tiempo.

### Recomendación:
- **Destruir el clúster** es la opción más efectiva si no planeas usarlo en un periodo prolongado.
- Si solo necesitas un descanso temporal (unas horas o días), **pararlo** puede ser más conveniente para poder retomarlo rápidamente sin incurrir en costos computacionales elevados.

Además, en Azure Databricks puedes configurar políticas de **auto-terminación** para los clústeres. Estas políticas permiten que los clústeres se apaguen automáticamente después de un periodo de inactividad, evitando costos innecesarios cuando se olvidan clústeres encendidos.

```python
# Ejemplo de configuración de auto-terminación (desde la consola de Azure Databricks)
# Establece un tiempo de inactividad para que el clúster se termine automáticamente (en minutos).
# Por ejemplo, 60 minutos de inactividad.
```

### En resumen:
- **Parar** el clúster es suficiente para evitar la mayor parte de los costos, pero **destruir** el clúster elimina cualquier costo asociado, incluyendo el almacenamiento persistente.

---

### Conclusión

La **configuración básica del workspace** de Azure Databricks te permite personalizar y optimizar el entorno para tus necesidades de análisis de datos y procesamiento masivo. Al crear clústeres de Spark, gestionar permisos de acceso, instalar librerías adicionales y conectar sistemas de almacenamiento, puedes preparar tu entorno para ejecutar trabajos de análisis de datos y machine learning de manera eficiente y segura.

Con una configuración adecuada, podrás aprovechar al máximo la potencia de procesamiento distribuido de Apache Spark y la colaboración en tiempo real que ofrece Azure Databricks, mejorando la productividad y asegurando el cumplimiento de las políticas de seguridad y gestión de datos en tu organización.