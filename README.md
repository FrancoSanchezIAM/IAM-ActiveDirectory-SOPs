# Proyecto IAM - Active Directory Lab

## Resumen

Este repositorio documenta mi laboratorio práctico de Identity & Access Management (IAM), donde construí un entorno completo de Active Directory para simular procesos de gestión de identidades en una empresa.

## Tecnologías utilizadas

- Windows Server 2025
- Active Directory Domain Services
- PowerShell (automatización y reportes)
- Entra ID (Azure AD)
- ServiceNow (simulación de tickets)
- Git / GitHub

## Procesos implementados

- **Onboarding (Joiner):** Creación de usuarios, asignación de grupos, automatización con PowerShell.
- **Offboarding (Leaver):** Deshabilitación de usuarios, revocación de accesos, movimiento a OU de inactivos.
- **Cambio de rol (Mover):** Modificación de grupos y permisos sin crear nuevos usuarios.
- **Auditoría:** Reportes de usuarios activos, inactivos, y contraseñas caducadas.
- **Políticas de seguridad:** GPOs para complejidad de contraseñas y bloqueo de cuentas.

## Scripts disponibles

| Script | Descripción |
|--------|-------------|
| `OnboardingAutomation_v2.ps1` | Automatiza la creación de usuarios y asignación de grupos desde un CSV |
| `Reporte_Usuarios_Activos.ps1` | Genera un reporte de usuarios habilitados en AD |
| `Reporte_Usuarios_Inactivos.ps1` | Genera un reporte de usuarios inactivos (30 días) |

## Próximos pasos

- Profundizar en CyberArk y SailPoint
- Explorar AWS IAM y políticas en la nube



Franco Sanchez - En camino hacia Access Management Analyst
Contacto
LinkedIn (https://linkedin.com/in/franco-sanchez-analista)
