SOP: Offboarding de Usuario en Active Directory

Última actualización: 7/06/2026
Autor: Franco Sanchez
Rol: Access Management Analyst (en formación)

 1. Propósito

Este documento describe el procedimiento estándar para deshabilitar y mover un usuario que ha dejado la empresa, asegurando que no mantenga accesos activos y que su cuenta quede disponible para auditorías futuras.

 2. Alcance

Aplica a todos los usuarios del dominio `francolab.local` que sean dados de baja del sistema.

 3. Requisitos previos

- Acceso al servidor con Active Directory Users and Computers
- PowerShell ejecutándose como Administrador
- Permisos de administrador del dominio

 4. Procedimiento

 4.1 Identificar al usuario

Recibir ticket o notificación con el nombre del empleado (ej: ¨laura.martinez¨).

 4.2 Deshabilitar la cuenta

Opción gráfica:
1. Abrir Active Directory Users and Computers
2. Buscar al usuario en su OU correspondiente
3. Click derecho → Disable Account

Opción PowerShell:
powershell
Disable-ADAccount -Identity "laura.martinez"
