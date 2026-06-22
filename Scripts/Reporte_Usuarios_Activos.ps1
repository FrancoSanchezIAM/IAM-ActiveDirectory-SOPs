# Reporte_Usuarios_Activos.ps1
# Franco Sanchez
# Descripción: Genera un reporte de usuarios activos en AD y lo exporta a CSV.

$fecha = Get-Date -Format "yyyy-MM-dd"
$carpeta = "C:\Reportes_$fecha"
$archivo = "$carpeta\Usuarios_Activos.csv"

if (-not (Test-Path $carpeta)) { New-Item -ItemType Directory -Path $carpeta -Force | Out-Null }

Get-ADUser -Filter {Enabled -eq $true} -Properties Name, SamAccountName, LastLogonDate, Created | 
    Select-Object Name, SamAccountName, LastLogonDate, Created |
    Export-Csv -Path $archivo -NoTypeInformation -Encoding UTF8

Write-Host "Reporte generado en: $archivo" -ForegroundColor Green
