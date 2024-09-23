### Laboratorio: Navegar por el Portal de Azure y Familiarizarse con los Servicios Disponibles

En este laboratorio, nos familiarizaremos con el **portal de Azure** y aprenderemos cómo navegar por su interfaz para explorar los diferentes servicios que ofrece Microsoft Azure. Este es el primer paso fundamental para trabajar en la nube de Azure, ya que el portal es la interfaz principal donde los usuarios pueden gestionar recursos, crear máquinas virtuales, configurar redes, administrar bases de datos y mucho más.

#### Objetivos del Laboratorio:
1. **Acceder al Portal de Azure.**
2. **Navegar por el panel de control (Dashboard).**
3. **Explorar los diferentes servicios de Azure.**
4. **Crear y eliminar un recurso básico (almacenamiento o máquina virtual).**

#### Requisitos Previos:
- **Cuenta de Azure**: Para completar este laboratorio, necesitarás una cuenta activa de Microsoft Azure. Si aún no tienes una, puedes crear una cuenta gratuita en [Azure Free Account](https://azure.microsoft.com/es-es/free/).
- **Navegador Web**: Se recomienda utilizar un navegador actualizado, como Google Chrome, Microsoft Edge, o Firefox.

---

#### Paso 1: Acceder al Portal de Azure

1. Abre tu navegador web y dirígete a la página del portal de Azure: [portal.azure.com](https://portal.azure.com).
   
2. Inicia sesión con las credenciales de tu cuenta de Microsoft Azure.

3. Después de iniciar sesión, serás dirigido al **panel de control de Azure**, donde podrás ver un resumen de tus recursos, servicios y configuraciones.

   - **Consejo**: Si estás utilizando una cuenta gratuita, deberías ver una lista de los servicios gratuitos que tienes disponibles y un resumen de tus gastos y créditos restantes en la cuenta.

---

#### Paso 2: Navegar por el Panel de Control (Dashboard)

El **Dashboard** es la primera pantalla que verás al acceder al portal de Azure. Este panel es totalmente personalizable y te proporciona una vista rápida de los recursos y servicios que más utilizas.

1. **Explora la Barra de Navegación Izquierda**:
   - **Inicio**: Te lleva de nuevo al Dashboard principal.
   - **Todos los servicios**: Aquí puedes ver una lista completa de todos los servicios que Azure tiene para ofrecer.
   - **Grupos de recursos**: Los grupos de recursos permiten organizar y gestionar todos tus recursos de Azure.
   - **Recursos recientes**: Muestra una lista de los recursos en los que has trabajado recientemente.
   - **Panel de monitoreo**: Muestra gráficos y métricas clave de tus recursos en Azure.

2. **Personaliza tu Dashboard**:
   - Haz clic en el botón de personalización del dashboard (ícono de lápiz) para agregar o eliminar widgets según tus necesidades.
   - Puedes agregar atajos a servicios importantes, como máquinas virtuales, almacenamiento, o bases de datos, para acceder rápidamente a ellos.

---

#### Paso 3: Explorar los Diferentes Servicios de Azure

Azure ofrece una vasta gama de servicios. A continuación, exploraremos algunos de los más comunes:

1. **Todos los Servicios**:
   - Haz clic en **"Todos los Servicios"** en la barra lateral izquierda.
   - Aquí verás una lista de categorías como **Computación**, **Redes**, **Almacenamiento**, **Bases de Datos**, y **Análisis**.
   - Selecciona cualquier categoría para explorar los servicios disponibles. Por ejemplo, en la categoría **Computación**, podrás ver opciones como **Máquinas Virtuales (Virtual Machines)**, **Kubernetes Service**, **App Services**, entre otros.

2. **Buscar un Servicio Específico**:
   - Usa la barra de búsqueda en la parte superior del portal para encontrar un servicio específico. Por ejemplo, busca **Azure Virtual Machines** para ver opciones de creación y gestión de máquinas virtuales.

3. **Explorar Documentación**:
   - Cada servicio tiene un enlace a su documentación oficial. Puedes hacer clic en el servicio y luego buscar en la pestaña de documentación para leer más sobre cómo configurarlo y usarlo.

---

#### Paso 4: Crear un Recurso Básico en Azure

En este paso, aprenderemos cómo crear un recurso simple, como una cuenta de almacenamiento o una máquina virtual. En este ejemplo, crearemos una **cuenta de almacenamiento**.

1. **Crear una Cuenta de Almacenamiento**:
   - Desde el **dashboard** o la sección de **Todos los Servicios**, busca **Storage Accounts** (Cuentas de Almacenamiento).
   - Haz clic en **"Crear"** en la parte superior de la pantalla.
   - Completa la siguiente información:
     - **Grupo de Recursos**: Si no tienes uno, crea un nuevo grupo de recursos.
     - **Nombre de la Cuenta de Almacenamiento**: Introduce un nombre único para tu cuenta de almacenamiento.
     - **Región**: Elige la región donde se alojará tu cuenta de almacenamiento.
     - **Tipo de Rendimiento**: Selecciona el rendimiento deseado (por ejemplo, **Estándar** o **Premium**).
     - **Replicación**: Elige el tipo de replicación (por ejemplo, **LRS** para replicación local).

2. **Revisar y Crear**:
   - Revisa las configuraciones y haz clic en **Crear**. Azure tardará unos minutos en desplegar la cuenta de almacenamiento.

3. **Ver el Recurso Creado**:
   - Una vez que se haya creado la cuenta de almacenamiento, podrás acceder a ella desde el panel de **Todos los Recursos**. Desde aquí, puedes ver los detalles del almacenamiento, cargar archivos y configurar permisos.

---

#### Paso 5: Eliminar el Recurso

Después de completar la exploración, es una buena práctica eliminar cualquier recurso que ya no necesites para evitar costos innecesarios.

1. Navega hasta **Grupos de Recursos** o **Todos los Recursos** desde la barra de navegación.
   
2. Selecciona el recurso que deseas eliminar (en este caso, la cuenta de almacenamiento que creaste).

3. Haz clic en **Eliminar**. Confirma la eliminación escribiendo el nombre del recurso cuando se te solicite.

---

#### Conclusión del Laboratorio

En este laboratorio, aprendiste cómo navegar por el **portal de Azure**, exploraste los diferentes servicios disponibles y creaste y eliminaste un recurso básico. Familiarizarte con el portal es esencial para trabajar de manera efectiva en la nube de Azure, ya que te permite acceder, gestionar y monitorizar todos los recursos y servicios que utilizas en tus proyectos.

Este es solo el primer paso en tu experiencia con Azure, y en los siguientes laboratorios, profundizaremos en servicios más avanzados y cómo desplegar aplicaciones y soluciones completas en la nube.