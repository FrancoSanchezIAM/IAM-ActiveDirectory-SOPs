# Verificación de usuarios creados

Después de ejecutar el script de onboarding, se verificó:

## Usuarios creados
- carlos.fernandez
- lucia.gomez

## Grupos asignados
- carlos.fernandez: Acceso_CRM, Acceso_Correo
- lucia.gomez: Acceso_VPN, Acceso_Correo

## Comandos utilizados
powershell
Get-ADUser -Identity "carlos.fernandez" -Properties MemberOf
Get-ADGroupMember -Identity "Acceso_VPN"
