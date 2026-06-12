7 a 10 de junio - Práctica con Entra ID y Microsoft Graph

Objetivo
Explorar la gestión de identidades en la nube usando Entra ID (antes Azure AD) y conectar con PowerShell para entender el modelo de permisos de Microsoft Graph.

Qué hice

 1. Creación de usuario en Entra ID
- Creé un usuario de prueba `carlos.gomez` en el portal de Azure
- Le asigné el rol *User Administrator*
- Verifiqué que aparece correctamente en la lista de usuarios

 2. Manejo de permisos en Microsoft Graph
- Instalé el módulo Microsoft.Graph para PowerShell
- Conecté a mi tenant con Connect-MgGraph
- Aprendí la diferencia entre:
  - *Autenticación* (loguearme)
  - *Autorización* (dar consentimiento para leer usuarios)
- Enfrenté un error 403 Forbidden hasta que comprendí que faltaba marcar la casilla *"Consentir en nombre de la organización"*

 3. Consultas básicas con Graph (pendiente de permisos)
- Practiqué las consultas:
  - GET /users (para listar usuarios)
  - GET /users/{id} (para buscar uno específico)
  - Comprendí el rol de `$select` para optimizar respuestas

 4. ServiceNow
- Exploré la interfaz de mi instancia de prueba
- Entendí el flujo: Ticket → Acción en AD → Cierre con Work Note
- Practiqué la asociación de cambios con SamAccountName

Aprendizajes de estos dias

 Concepto | Por qué importa 

 Consentimiento de administrador | En la nube, los permisos no se heredan automáticamente 
 API vs Portal Web | El portal es más confiable para tareas cotidianas; la API es para automatización 
 Códigos 200 con errores internos | A veces la conexión es exitosa pero la respuesta está mal formada (Graph Explorer) 
 403 Forbidden | Error de permisos

 Herramientas usadas

- Microsoft Entra ID (Azure AD)
- PowerShell 7 + módulo Microsoft.Graph
- ServiceNow Developer Instance
- Graph Explorer (con limitaciones)

 Próximos pasos

- Completar correctamente el consentimiento de administrador para usar Get-MgUser
- Probar creación de grupos desde PowerShell
- Documentar flujo completo: ticket en ServiceNow → acción en AD → cierre
