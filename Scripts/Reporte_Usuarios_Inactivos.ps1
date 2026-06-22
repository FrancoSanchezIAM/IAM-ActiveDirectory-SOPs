# Reporte_Usuarios_Inactivos.ps1
# Franco Sanchez
# Descripción: Genera un reporte de usuarios que no han iniciado sesión en los últimos 30 días.

$fecha = Get-Date -Format "yyyy-MM-dd"
$carpeta = "C:\Reportes_$fecha"
$archivo = "$carpeta\Usuarios_Inactivos_30dias.csv"

if (-not (Test-Path $carpeta)) { New-Item -ItemType Directory -Path $carpeta -Force | Out-Null }

$fechaLimite = (Get-Date).AddDays(-30)

Search-ADAccount -AccountInactive -TimeSpan 30.00:00:00 -UsersOnly |
    Select-Object Name, SamAccountName, LastLogonDate, Enabled |
    Export-Csv -Path $archivo -NoTypeInformation -Encoding UTF8

Write-Host "Reporte de inactivos generado en: $archivo" -ForegroundColor Green
