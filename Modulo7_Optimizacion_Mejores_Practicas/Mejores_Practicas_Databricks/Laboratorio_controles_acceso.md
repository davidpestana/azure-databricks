### Laboratorio: Implementación de Controles de Acceso y Permisos en Databricks

#### Objetivo:
Este laboratorio tiene como objetivo guiar a los estudiantes a implementar controles de acceso y permisos en Databricks. Aprenderás a utilizar grupos de seguridad para gestionar el acceso a recursos como notebooks, carpetas y clústeres, asegurando que solo los usuarios autorizados puedan acceder o modificar dichos recursos.

#### Requisitos:
- Acceso a **Microsoft Entra ID** para la gestión de usuarios y grupos.
- Acceso de administrador a un **espacio de trabajo en Databricks**.
- Familiaridad básica con la consola de administración de Databricks.

---

### Paso 1: Creación de Grupos de Usuarios en Microsoft Entra ID

En este paso, crearás dos grupos de usuarios en Microsoft Entra ID, uno para científicos de datos y otro para analistas de negocios.

##### Instrucciones:

1. **Accede a Microsoft Entra ID**:
   - Dirígete al **portal de Azure** (https://portal.azure.com) y selecciona **Microsoft Entra ID** en el menú de la izquierda.

2. **Crear un grupo para científicos de datos**:
   - Haz clic en **Grupos** y selecciona **+ Agregar**.
   - En el formulario de creación, selecciona el tipo de grupo adecuado para controlar el acceso a los recursos.
   - Nombra el grupo `Data Scientists`.
   - Agrega una descripción para identificar fácilmente el propósito del grupo.
   - Haz clic en **Crear**.

3. **Crear un grupo para analistas de negocios**:
   - Repite los mismos pasos que en el grupo anterior, pero nombra este grupo `Business Analysts`.
   - Asegúrate de que los usuarios agregados a este grupo tengan acceso limitado a los recursos.

4. **Agregar usuarios a los grupos**:
   - Selecciona cada grupo creado y en la pestaña de miembros, selecciona **+ Agregar miembros**.
   - Busca y añade los usuarios correspondientes para cada grupo según su rol.

---

### Paso 2: Configurar Control de Acceso Basado en Roles (RBAC) en Databricks

A continuación, asignaremos roles a los grupos creados en el paso anterior dentro de Databricks para controlar el acceso a recursos de manera centralizada.

##### Instrucciones:

1. **Iniciar sesión en Databricks**:
   - Ve a tu espacio de trabajo de Databricks y selecciona **Admin Console** desde el menú izquierdo.

2. **Añadir grupos desde Microsoft Entra ID**:
   - En la pestaña de **Users** dentro de la consola de administración, selecciona **Add Group**.
   - Busca y selecciona los grupos creados en **Microsoft Entra ID** (`Data Scientists` y `Business Analysts`).

3. **Asignar roles a los grupos**:
   - Para el grupo `Data Scientists`, otorga un rol que permita gestionar y modificar recursos, ejecutar trabajos y acceder a notebooks.
   - Para el grupo `Business Analysts`, asigna un rol que limite el acceso a solo lectura, sin permisos de edición o ejecución de trabajos.

---

### Paso 3: Configurar Acceso a Notebooks y Carpetas

En este paso, configurarás el acceso a notebooks y carpetas en Databricks utilizando listas de control de acceso (ACLs).

##### Instrucciones:

1. **Crear una carpeta para científicos de datos**:
   - En el menú de **Workspaces** de Databricks, selecciona **Create** y luego **Folder**.
   - Nombra la carpeta `DataScience_Workspace`.
   - Haz clic derecho en la carpeta y selecciona **Permissions**.

2. **Asignar permisos a la carpeta**:
   - Para el grupo `Data Scientists`, otorga acceso completo para que puedan modificar y ejecutar notebooks.
   - Para el grupo `Business Analysts`, otorga solo acceso de lectura.

3. **Crear un notebook compartido**:
   - Dentro de la carpeta `DataScience_Workspace`, crea un nuevo notebook llamado `Sales Analysis`.
   - Revisa que herede los permisos de la carpeta.

4. **Verificar los permisos**:
   - Inicia sesión con un usuario del grupo `Business Analysts` y verifica que solo pueda ver el notebook.
   - Inicia sesión con un usuario del grupo `Data Scientists` y verifica que pueda editar y ejecutar el notebook.

---

### Paso 4: Control de Acceso a Clústeres

Asegúrate de que los permisos para gestionar clústeres estén configurados adecuadamente para cada grupo.

##### Instrucciones:

1. **Crear un clúster**:
   - Desde el menú de **Clusters**, selecciona **Create Cluster**.
   - Nombra el clúster `DataScience_Cluster` y configura los recursos necesarios.

2. **Asignar permisos al clúster**:
   - Otorga al grupo `Data Scientists` permisos para gestionar el clúster y adjuntar notebooks.
   - Otorga al grupo `Business Analysts` permisos de solo lectura para ver la información del clúster.

3. **Verificar los permisos**:
   - Inicia sesión con un usuario del grupo `Data Scientists` y verifica que puedas gestionar el clúster.
   - Inicia sesión con un usuario del grupo `Business Analysts` y verifica que solo puedas ver los detalles del clúster.

---

### Paso 5: Uso de Azure Key Vault para Protección de Datos Sensibles

En este paso, integrarás Azure Key Vault con Databricks para proteger datos sensibles.

##### Instrucciones:

1. **Configurar un Azure Key Vault**:
   - En el portal de Azure, crea un nuevo Key Vault y agrega un secreto llamado `DatabaseConnection`.

2. **Integrar Key Vault en Databricks**:
   - En Databricks, crea un notebook y accede a los secretos almacenados en Key Vault con el siguiente código:

```python
dbutils.secrets.get(scope="MyKeyVaultScope", key="DatabaseConnection")
```

3. **Configurar permisos de acceso a Key Vault**:
   - Asegúrate de que solo los usuarios del grupo `Data Scientists` tengan acceso a los secretos.
   - Verifica que los usuarios del grupo `Business Analysts` no puedan acceder a los datos sensibles.

---

### Conclusión del Laboratorio:

En este laboratorio, configuraste controles de acceso en Databricks utilizando grupos y permisos adecuados para cada rol:
- Asignaste roles mediante **RBAC** para gestionar el acceso a recursos como notebooks, carpetas y clústeres.
- Configuraste **ACLs** en notebooks y carpetas para controlar el acceso granular.
- Utilizaste **Azure Key Vault** para proteger datos sensibles.

Este proceso garantiza una correcta administración de permisos en Databricks, protegiendo los recursos y asegurando que los usuarios solo accedan a lo que necesitan para su trabajo.