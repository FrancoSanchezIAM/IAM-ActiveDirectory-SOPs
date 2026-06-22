# ==================================================
# SCRIPT DE ONBOARDING MASIVO
# Franco Sanchez
# ==================================================

# --- CONFIGURACIÓN ---
$rutaCSV = Join-Path -Path $PSScriptRoot -ChildPath "onboarding_sample.csv"
$rutaLog = Join-Path -Path $PSScriptRoot -ChildPath "onboarding_log.txt"
$dominio = "francolab.local"
$ouDestino = "OU=USUARIOS,OU=_FRANCOCORP,DC=francolab,DC=local"

# Inicializar variables de reporte
$usuariosCreados = 0
$usuariosExistentes = 0
$errores = 0
$listaErrores = @()

# --- FUNCIÓN: ESCRIBIR EN EL LOG ---
function Write-Log {
    param([string]$mensaje)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $mensaje" | Out-File -FilePath $rutaLog -Append
}

Write-Log "========== INICIO DEL PROCESO DE ONBOARDING =========="

# --- 1. VERIFICAR QUE EL CSV EXISTE ---
if (-not (Test-Path $rutaCSV)) {
    Write-Host "ERROR CRÍTICO: No se encontró el archivo CSV en $rutaCSV" -ForegroundColor Red
    Write-Log "ERROR CRÍTICO: No se encontró el archivo CSV."
    exit 1
}

# --- 2. IMPORTAR CSV ---
$usuarios = Import-Csv -Path $rutaCSV
Write-Log "Se importaron $($usuarios.Count) usuarios del CSV."

# --- 3. PROCESAR CADA USUARIO ---
foreach ($user in $usuarios) {
    $usuario = $user.Usuario.Trim()
    $nombreCompleto = "$($user.Nombre) $($user.Apellido)"
    
    Write-Log "Procesando: $nombreCompleto ($usuario)"

    # 3.1 VERIFICAR SI EL USUARIO YA EXISTE
    try {
        $usuarioExistente = Get-ADUser -Identity $usuario -ErrorAction Stop
        Write-Host "ADVERTENCIA: El usuario '$usuario' ya existe. Saltando..." -ForegroundColor Yellow
        Write-Log "ADVERTENCIA: Usuario '$usuario' ya existe. Saltado."
        $usuariosExistentes++
        continue
    } catch {
        # Si no existe, seguimos
    }

    # 3.2 CREAR EL USUARIO
    try {
        $password = ConvertTo-SecureString $user.Password -AsPlainText -Force
        New-ADUser -Name $nombreCompleto `
                   -SamAccountName $usuario `
                   -UserPrincipalName "$usuario@$dominio" `
                   -GivenName $user.Nombre `
                   -Surname $user.Apellido `
                   -Enabled $true `
                   -AccountPassword $password `
                   -ChangePasswordAtLogon $false `
                   -PasswordNeverExpires $true `
                   -Path $ouDestino `
                   -ErrorAction Stop

        Write-Host "OK: Usuario '$usuario' creado correctamente." -ForegroundColor Green
        Write-Log "OK: Usuario '$usuario' creado exitosamente."
        $usuariosCreados++

    } catch {
        Write-Host "ERROR: No se pudo crear el usuario '$usuario'." -ForegroundColor Red
        Write-Log "ERROR AL CREAR: $usuario - $($_.Exception.Message)"
        $errores++
        $listaErrores += $usuario
        continue
    }

    # 3.3 ASIGNAR GRUPOS
    try {
        $grupos = $user.Grupos -split ","
        foreach ($grupo in $grupos) {
            $nombreGrupo = $grupo.Trim()
            Add-ADPrincipalGroupMembership -Identity $usuario -MemberOf $nombreGrupo -ErrorAction Stop
            Write-Log "ASIGNACIÓN: Usuario '$usuario' agregado al grupo '$nombreGrupo'."
        }
        Write-Host "OK: Grupos asignados a '$usuario'." -ForegroundColor Green

    } catch {
        Write-Host "ERROR: No se pudieron asignar todos los grupos a '$usuario'." -ForegroundColor Red
        Write-Log "ERROR AL ASIGNAR GRUPOS: $usuario - $($_.Exception.Message)"
        $errores++
    }
}

# --- 4. GENERAR REPORTE FINAL ---
Write-Host "`n========== RESUMEN DEL PROCESO ==========" -ForegroundColor Cyan
Write-Host "Usuarios Creados: $usuariosCreados" -ForegroundColor Green
Write-Host "Usuarios Existentes (saltados): $usuariosExistentes" -ForegroundColor Yellow
Write-Host "Errores: $errores" -ForegroundColor Red
Write-Log "========== FIN DEL PROCESO =========="
Write-Log "Resumen: Creados=$usuariosCreados, Existentes=$usuariosExistentes, Errores=$errores"

if ($listaErrores.Count -gt 0) {
    Write-Host "Usuarios con errores: $($listaErrores -join ', ')" -ForegroundColor Red
}
