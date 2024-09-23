### Laboratorio: Familiarizarse con las Opciones de Configuración y Seguridad del Workspace de Databricks

En este laboratorio, exploraremos las opciones de configuración y seguridad dentro del **workspace de Azure Databricks**. Estas configuraciones son fundamentales para gestionar el acceso, garantizar la seguridad de los datos y personalizar el entorno para tus necesidades de procesamiento y análisis.

#### Objetivos del Laboratorio:
1. **Explorar las opciones de configuración del workspace.**
2. **Configurar roles y permisos para usuarios (Azure Active Directory).**
3. **Revisar las políticas de seguridad y auditoría.**

#### Requisitos Previos:
- **Workspace de Azure Databricks creado**: Debes haber completado el proceso de creación de un workspace de Databricks en Azure.
- **Permisos Adecuados**: Debes tener permisos de **Administrador** o de **Propietario** del workspace para acceder a las configuraciones de seguridad.

---

### Paso 1: Acceder a las Opciones de Configuración del Workspace

1. **Accede a Azure Databricks**:
   - Inicia sesión en el **[portal de Azure](https://portal.azure.com)** y navega al **recurso de Azure Databricks** que creaste previamente.
   - Haz clic en **Iniciar Workspace** para acceder a la interfaz de usuario de Databricks.

2. **Acceder a la Configuración del Workspace**:
   - En la barra lateral izquierda de la interfaz de Databricks, haz clic en el ícono de perfil (arriba a la derecha) y selecciona **Admin Console**.
   - La **Admin Console** te permite gestionar la configuración del workspace, incluyendo la seguridad, los usuarios y los clústeres.

3. **Explorar las Pestañas de Configuración**:
   - **Users**: Aquí puedes ver y gestionar todos los usuarios que tienen acceso al workspace.
   - **Workspace Settings**: Esta pestaña contiene las configuraciones generales del workspace, como la activación/desactivación de características, configuraciones de seguridad y políticas de cumplimiento.
   - **Clusters**: En esta sección puedes gestionar las políticas de creación de clústeres, definir límites de acceso a recursos y asegurar que los clústeres cumplan con las normativas de la organización.

---

### Paso 2: Configurar Roles y Permisos de Usuarios

La seguridad en **Azure Databricks** está estrechamente integrada con **Azure Active Directory (Azure AD)**. La configuración de roles y permisos es fundamental para garantizar que los usuarios solo tengan acceso a los recursos que necesitan, minimizando el riesgo de acceso no autorizado.

1. **Agregar Usuarios a Azure Databricks**:
   - En la pestaña **Users** de la **Admin Console**, haz clic en **Add User** para agregar un nuevo usuario.
   - Puedes agregar usuarios desde **Azure Active Directory** (Azure AD). Solo debes ingresar el correo electrónico o el ID de usuario de la persona que deseas agregar.
   - El usuario recibirá una invitación para unirse al workspace de Databricks.

2. **Asignar Roles a los Usuarios**:
   - Después de agregar un usuario, selecciona el rol que tendrá en el workspace. Los roles predeterminados son:
     - **Admin**: Tiene acceso completo para gestionar la configuración y los recursos del workspace, incluyendo la creación de clústeres y la administración de usuarios.
     - **User**: Tiene acceso limitado, puede crear y ejecutar notebooks, pero no puede gestionar la configuración ni los usuarios.
     - **Viewer**: Solo puede ver los notebooks y resultados, sin capacidad de modificación.
   
   - **Ejemplo**: Un científico de datos puede recibir el rol de **User**, mientras que el administrador del equipo recibe el rol de **Admin** para gestionar los recursos y la seguridad.

---

### Paso 3: Revisar las Políticas de Seguridad del Workspace

Azure Databricks ofrece varias opciones para asegurar los datos y cumplir con normativas de seguridad, como cifrado de datos en tránsito y en reposo, políticas de cumplimiento y auditoría.

1. **Revisar la Seguridad de los Datos**:
   - En la pestaña **Workspace Settings** de la **Admin Console**, verifica las opciones de **seguridad de datos**. Algunas de las configuraciones más importantes son:
     - **Cifrado de Datos en Tránsito**: Esta opción asegura que todos los datos transferidos dentro y fuera del workspace estén cifrados mediante **TLS/SSL**.
     - **Cifrado de Datos en Reposo**: Azure Databricks cifra automáticamente los datos almacenados en **DBFS (Databricks File System)** utilizando claves de cifrado gestionadas por Azure. Si tu organización requiere claves gestionadas por el cliente, puedes configurarlo en **Azure Key Vault**.
  
   - **Ejemplo**: Una organización que maneja datos sensibles, como información financiera o médica, debe asegurarse de que tanto los datos en tránsito como los datos en reposo estén cifrados para cumplir con normativas como **GDPR** o **HIPAA**.

2. **Configurar Políticas de Auditoría**:
   - Para cumplir con las políticas de cumplimiento y auditoría de seguridad, Databricks permite habilitar el seguimiento de acciones realizadas dentro del workspace.
   - Habilita la opción de **Auditoria de Eventos** para registrar todas las actividades críticas dentro del workspace, como la creación o eliminación de clústeres, cambios en la configuración de seguridad, y acceso a datos.
   - Los logs de auditoría se pueden almacenar en **Azure Blob Storage** o integrarse con soluciones de monitoreo como **Azure Monitor** o **Log Analytics**.

3. **Establecer Políticas de Clústeres**:
   - En la pestaña **Clusters** de la **Admin Console**, puedes definir políticas de creación de clústeres. Esto es especialmente importante para limitar el acceso a recursos computacionales y asegurar que los clústeres cumplan con las políticas de la organización.
   - Puedes restringir qué usuarios pueden crear clústeres y qué tipos de clústeres pueden ser creados (por ejemplo, clústeres con nodos de GPU, o solo clústeres escalables).
   - **Ejemplo**: Si tienes un equipo de desarrollo que solo necesita realizar pruebas de notebooks, puedes restringir su acceso para que solo puedan crear clústeres pequeños con instancias de bajo costo.

---

### Conclusión del Laboratorio

En este laboratorio has aprendido a **explorar y configurar las opciones de seguridad en Azure Databricks**. Desde la gestión de usuarios y roles utilizando **Azure Active Directory**, hasta la revisión de políticas de cifrado y auditoría, estas configuraciones son esenciales para asegurar un entorno controlado y protegido. Además, hemos revisado cómo restringir la creación de clústeres para optimizar recursos y mejorar la seguridad en el workspace. 

Estos controles de seguridad y gestión de permisos son fundamentales para cualquier organización que maneje datos sensibles o trabaje en entornos de múltiples usuarios dentro de Azure Databricks.