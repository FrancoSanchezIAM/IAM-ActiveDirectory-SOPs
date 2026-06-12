# Script de onboarding automático
# Crea usuarios en AD a partir de un CSV y los asigna a grupos
# Autor: Franco Sanchez
# Proyecto IAM - Active Directory Lab

# Ruta dinámica: busca el CSV en la misma carpeta que el script
$rutaCSV = Join-Path -Path $PSScriptRoot -ChildPath "onboarding_sample.csv"

# Verificar que el CSV existe
if (-not (Test-Path $rutaCSV)) {
    Write-Host "ERROR: No se encontró el archivo CSV en $rutaCSV" -ForegroundColor Red
    exit 1
}

$usuarios = Import-Csv -Path $rutaCSV

foreach ($user in $usuarios) {
    # Crear el usuario en la OU correspondiente
    New-ADUser -Name "$($user.Nombre) $($user.Apellido)" `
               -SamAccountName $user.Usuario `
               -UserPrincipalName "$($user.Usuario)@francolab.local" `
               -GivenName $user.Nombre `
               -Surname $user.Apellido `
               -Enabled $true `
               -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -Force) `
               -ChangePasswordAtLogon $false `
               -PasswordNeverExpires $true `
               -Path "OU=USUARIOS,OU=_FRANCOCORP,DC=francolab,DC=local"
    
    # Separar los grupos por coma y asignarlos (evitando espacios)
    $grupos = $user.Grupos -split ","
    foreach ($grupo in $grupos) {
        $grupo = $grupo.Trim()  # saca espacios extras
        Add-ADPrincipalGroupMembership -Identity $user.Usuario -MemberOf $grupo
    }
    
    Write-Host "Usuario $($user.Usuario) creado en OU=USUARIOS con grupos: $($user.Grupos)" -ForegroundColor Green
}

Write-Host "`nOnboarding masivo completado." -ForegroundColor Yellow
