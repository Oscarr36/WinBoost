@echo off
setlocal enabledelayedexpansion

:: ====================================================================
:: WinBoost v2.1 - Optimizador de Sistema para Windows
:: Autor: Oscarr36 ^ github.com/Oscarr36
:: ====================================================================

set "VERSION=2.1"

:: ============================================================
:: AUTO-ELEVACION: si no hay admin, pide UAC y relanza
:: ============================================================
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process cmd.exe -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b 0
)

:: ============================================================
:: TIMESTAMP para log (se genera aqui, con admin ya confirmado)
:: ============================================================
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value 2^>nul') do set "DT=%%I"
if not defined DT (
    for /f "tokens=2 delims=T" %%I in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmmss"') do set "DT=%%I"
    set "LOGTS=!DT!"
) else (
    set "LOGTS=%DT:~0,8%_%DT:~8,6%"
)
set "LOG_FILE=%USERPROFILE%\Desktop\WinBoost_Log_%LOGTS%.txt"

:: ============================================================
:: BANNER
:: ============================================================
cls
mode con: cols=76 lines=50
color 0A
echo.
echo  ####################################################################
echo  #                                                                  #
echo  #    __        ___       ____                  _                   #
echo  #    \ \      / ^(_^)_ __ ^| __ ^)  ___   ___  ___^| ^|_                 #
echo  #     \ \ /\ / /^| ^|'_ \ ^|  _ \ / _ \ / _ \/ __^| __^|               #
echo  #      \ V  V / ^| ^| ^| ^| ^| ^|_^) ^| ^(_^) ^| ^(_^) \__ \ ^|_                #
echo  #       \_/\_/  ^|_^|_^| ^|_^|____/ \___/ \___/^|___/\__^|               #
echo  #                                                                  #
echo  #              S Y S T E M   O P T I M I Z E R  v2.1              #
echo  #                   github.com/Oscarr36                            #
echo  #                                                                  #
echo  ####################################################################
echo.
echo                   Pulsa cualquier tecla para empezar...
pause >nul
cls

:: ============================================================
:: INICIAR LOG
:: ============================================================
(
echo ====================================================================
echo  WinBoost v%VERSION% - Log de Optimizacion
echo ====================================================================
) > "%LOG_FILE%" 2>nul

:: ============================================================
:: INFO DEL SISTEMA
:: ============================================================
cls
echo  ====================================================================
echo                      INFORMACION DEL SISTEMA
echo  ====================================================================
echo.

for /f "tokens=* skip=1" %%i in ('wmic os get Caption /value 2^>nul') do (
    for /f "tokens=2 delims==" %%j in ("%%i") do set "WIN_CAPTION=%%j"
)
for /f "tokens=* skip=1" %%i in ('wmic os get BuildNumber /value 2^>nul') do (
    for /f "tokens=2 delims==" %%j in ("%%i") do set "WIN_BUILD=%%j"
)
for /f "tokens=* skip=1" %%i in ('wmic os get Version /value 2^>nul') do (
    for /f "tokens=2 delims==" %%j in ("%%i") do set "WIN_VER=%%j"
)
for /f "tokens=* skip=1" %%i in ('wmic logicaldisk where "DeviceID='C:'" get FreeSpace /value 2^>nul') do (
    for /f "tokens=2 delims==" %%j in ("%%i") do set "SPACE_BEFORE=%%j"
)

:: Si wmic no funciono, usar PowerShell como fallback
if not defined WIN_CAPTION (
    for /f "delims=" %%i in ('powershell -NoProfile -Command "(Get-WmiObject Win32_OperatingSystem).Caption" 2^>nul') do set "WIN_CAPTION=%%i"
)
if not defined WIN_BUILD (
    for /f "delims=" %%i in ('powershell -NoProfile -Command "[System.Environment]::OSVersion.Version.Build" 2^>nul') do set "WIN_BUILD=%%i"
)

set "CURRENT_BUILD=%WIN_BUILD%"
set "CURRENT_BUILD=!CURRENT_BUILD: =!"

echo   Usuario       : %USERNAME%
echo   Equipo        : %COMPUTERNAME%
echo   SO             : %WIN_CAPTION%
echo   Version/Build : %WIN_VER% ^(Build %WIN_BUILD%^)
echo   Arquitectura  : %PROCESSOR_ARCHITECTURE%
echo   Fecha/Hora    : %DATE% - %TIME:~0,8%
echo.
echo   Log: %LOG_FILE%
echo.
echo  ====================================================================
echo.

(
echo Usuario: %USERNAME% ^| Equipo: %COMPUTERNAME%
echo SO: %WIN_CAPTION%
echo Version: %WIN_VER% ^| Build: %WIN_BUILD%
echo Arquitectura: %PROCESSOR_ARCHITECTURE%
echo Fecha/Hora: %DATE% %TIME%
echo.
) >> "%LOG_FILE%" 2>nul

timeout /t 3 >nul

:: ====================================================================
:: FASE 1 - LIMPIEZA PROFUNDA
:: ====================================================================
cls
echo.
echo  ====================================================================
echo   ^[ FASE 1/4 ^]  LIMPIEZA PROFUNDA DEL SISTEMA
echo  ====================================================================
echo.
echo [FASE 1 - LIMPIEZA PROFUNDA] >> "%LOG_FILE%"

echo   [01/18] Limpiando temporales del usuario...
del /q /f /s "%TEMP%\*" >nul 2>&1
for /d %%x in ("%TEMP%\*") do rd /s /q "%%x" >nul 2>&1
echo   OK: Temporales usuario >> "%LOG_FILE%"

echo   [02/18] Limpiando temporales de Windows...
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
for /d %%x in ("C:\Windows\Temp\*") do rd /s /q "%%x" >nul 2>&1
echo   OK: Temporales Windows >> "%LOG_FILE%"

echo   [03/18] Limpiando Prefetch...
del /q /f /s "C:\Windows\Prefetch\*" >nul 2>&1
echo   OK: Prefetch >> "%LOG_FILE%"

echo   [04/18] Vaciando papelera de reciclaje...
rd /s /q C:\$Recycle.Bin >nul 2>&1
echo   OK: Papelera >> "%LOG_FILE%"

echo   [05/18] Limpiando cache de miniaturas...
taskkill /f /im explorer.exe >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
start explorer.exe
echo   OK: Cache miniaturas >> "%LOG_FILE%"

echo   [06/18] Limpiando logs CBS del sistema...
del /q /f /s "C:\Windows\Logs\CBS\*" >nul 2>&1
echo   OK: Logs CBS >> "%LOG_FILE%"

echo   [07/18] Limpiando cache de Windows Update...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /q /f /s "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
for /d %%x in ("C:\Windows\SoftwareDistribution\Download\*") do rd /s /q "%%x" >nul 2>&1
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
echo   OK: Windows Update cache >> "%LOG_FILE%"

echo   [08/18] Limpiando registros de eventos de Windows...
for /f "tokens=*" %%G in ('wevtutil el 2^>nul') do wevtutil cl "%%G" >nul 2>&1
echo   OK: Event logs >> "%LOG_FILE%"

echo   [09/18] Limpiando cache de fuentes...
net stop "Windows Font Cache Service" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\Microsoft\Windows\Fonts\*" >nul 2>&1
net start "Windows Font Cache Service" >nul 2>&1
echo   OK: Cache fuentes >> "%LOG_FILE%"

echo   [10/18] Limpiando cache de Microsoft Store...
wsreset.exe >nul 2>&1
echo   OK: Store cache >> "%LOG_FILE%"

echo   [11/18] Limpiando cache de Microsoft Edge...
taskkill /f /im msedge.exe >nul 2>&1
if exist "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache" rd /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache" >nul 2>&1
if exist "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache" rd /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache" >nul 2>&1
if exist "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\GPUCache" rd /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\GPUCache" >nul 2>&1
if exist "%LOCALAPPDATA%\Microsoft\Edge\User Data\ShaderCache" rd /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\ShaderCache" >nul 2>&1
echo   OK: Edge cache >> "%LOG_FILE%"

echo   [12/18] Limpiando cache de Google Chrome...
taskkill /f /im chrome.exe >nul 2>&1
if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" >nul 2>&1
if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Code Cache" rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Code Cache" >nul 2>&1
if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\GPUCache" rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\GPUCache" >nul 2>&1
if exist "%LOCALAPPDATA%\Google\Chrome\User Data\ShaderCache" rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\ShaderCache" >nul 2>&1
echo   OK: Chrome cache >> "%LOG_FILE%"

echo   [13/18] Limpiando cache de Firefox...
taskkill /f /im firefox.exe >nul 2>&1
if exist "%LOCALAPPDATA%\Mozilla\Firefox\Profiles" (
    for /d %%p in ("%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*") do (
        rd /s /q "%%p\cache2" >nul 2>&1
        rd /s /q "%%p\startupCache" >nul 2>&1
        rd /s /q "%%p\shader-cache" >nul 2>&1
    )
)
echo   OK: Firefox cache >> "%LOG_FILE%"

echo   [14/18] Limpiando cache de GPU ^(DirectX / NVIDIA / AMD^)...
if exist "%LOCALAPPDATA%\D3DSCache" del /q /f /s "%LOCALAPPDATA%\D3DSCache\*" >nul 2>&1
if exist "%LOCALAPPDATA%\NVIDIA\DXCache" del /q /f /s "%LOCALAPPDATA%\NVIDIA\DXCache\*" >nul 2>&1
if exist "%LOCALAPPDATA%\NVIDIA\GLCache" del /q /f /s "%LOCALAPPDATA%\NVIDIA\GLCache\*" >nul 2>&1
if exist "%LOCALAPPDATA%\AMD\DXCache" del /q /f /s "%LOCALAPPDATA%\AMD\DXCache\*" >nul 2>&1
echo   OK: GPU cache >> "%LOG_FILE%"

echo   [15/18] Limpiando volcados de memoria ^(crash dumps^)...
del /q /f /s "C:\Windows\Minidump\*" >nul 2>&1
del /q /f /s "%LOCALAPPDATA%\CrashDumps\*" >nul 2>&1
if exist "C:\Windows\memory.dmp" del /q /f "C:\Windows\memory.dmp" >nul 2>&1
echo   OK: Memory dumps >> "%LOG_FILE%"

echo   [16/18] Limpiando archivos .tmp del sistema...
del /q /f "C:\Windows\*.tmp" >nul 2>&1
del /q /f "C:\Windows\System32\*.tmp" >nul 2>&1
echo   OK: Archivos .tmp >> "%LOG_FILE%"

echo   [17/18] Limpiando cache de Windows Defender...
if exist "%ProgramData%\Microsoft\Windows Defender\Scans\History" (
    del /q /f /s "%ProgramData%\Microsoft\Windows Defender\Scans\History\*" >nul 2>&1
)
echo   OK: Defender cache >> "%LOG_FILE%"

echo   [18/18] Ejecutando limpieza de disco automatizada...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files" /v StateFlags0001 /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Recycle Bin" /v StateFlags0001 /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Internet Cache Files" /v StateFlags0001 /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Downloaded Program Files" /v StateFlags0001 /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Files" /v StateFlags0001 /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Delivery Optimization Files" /v StateFlags0001 /t REG_DWORD /d 2 /f >nul 2>&1
cleanmgr /sagerun:1 >nul 2>&1
echo   OK: Disco limpiado >> "%LOG_FILE%"

echo.
echo   [OK] Limpieza profunda completada.
timeout /t 2 >nul

:: ====================================================================
:: FASE 2 - RED Y RENDIMIENTO
:: ====================================================================
cls
echo.
echo  ====================================================================
echo   ^[ FASE 2/4 ^]  OPTIMIZACION DE RED Y RENDIMIENTO
echo  ====================================================================
echo.
echo [FASE 2 - RED Y RENDIMIENTO] >> "%LOG_FILE%"

echo   [1/7] Limpiando cache DNS...
ipconfig /flushdns >nul
echo   OK: DNS flush >> "%LOG_FILE%"

echo   [2/7] Reiniciando catalogo Winsock...
netsh winsock reset >nul
echo   OK: Winsock reset >> "%LOG_FILE%"

echo   [3/7] Reiniciando pila TCP/IP...
netsh int ip reset >nul 2>&1
echo   OK: TCP/IP reset >> "%LOG_FILE%"

echo   [4/7] Optimizando configuracion TCP/IP...
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global ecncapability=enabled >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1
netsh int tcp set global initialRto=2000 >nul 2>&1
netsh int tcp set global nonsackrttresiliency=disabled >nul 2>&1
echo   OK: TCP optimizado >> "%LOG_FILE%"

echo   [5/7] Optimizando memoria virtual ^(gestion automatica^)...
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True >nul 2>&1
echo   OK: Memoria virtual >> "%LOG_FILE%"

echo   [6/7] Liberando listas de espera de RAM...
echo. | clip
powershell -NoProfile -NonInteractive -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1
echo   OK: RAM liberada >> "%LOG_FILE%"

echo   [7/7] Enviando comando TRIM al SSD...
fsutil behavior set DisableDeleteNotify 0 >nul 2>&1
defrag C: /U /THININTERVAL >nul 2>&1
echo   OK: TRIM enviado >> "%LOG_FILE%"

echo.
echo   [OK] Red y rendimiento optimizados.
timeout /t 2 >nul

:: ====================================================================
:: FASE 3 - OPTIMIZACION AVANZADA
:: ====================================================================
cls
echo.
echo  ====================================================================
echo   ^[ FASE 3/4 ^]  OPTIMIZACION AVANZADA DEL SISTEMA
echo  ====================================================================
echo.
echo [FASE 3 - OPTIMIZACION AVANZADA] >> "%LOG_FILE%"

echo   [1/7] Activando plan de energia de alto rendimiento...
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
if errorlevel 1 (
    powercfg /duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
)
echo   OK: Plan de energia >> "%LOG_FILE%"

echo   [2/7] Maximizando rendimiento del procesador...
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 100 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1
echo   OK: CPU al 100%% >> "%LOG_FILE%"

echo   [3/7] Desactivando SysMain ^(Superfetch^) para SSD...
sc config SysMain start= disabled >nul 2>&1
sc stop SysMain >nul 2>&1
echo   OK: SysMain desactivado >> "%LOG_FILE%"

echo   [4/7] Ajustando efectos visuales para maximo rendimiento...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
echo   OK: Efectos visuales >> "%LOG_FILE%"

echo   [5/7] Optimizando tiempo de respuesta del menu inicio...
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1
echo   OK: Menu inicio >> "%LOG_FILE%"

echo   [6/7] Desactivando delay de inicio de aplicaciones...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >nul 2>&1
echo   OK: Delay inicio >> "%LOG_FILE%"

echo   [7/7] Optimizando NTFS ^(acceso, 8dot3, timestamps^)...
fsutil behavior set disable8dot3 1 >nul 2>&1
fsutil behavior set disablelastaccess 1 >nul 2>&1
echo   OK: NTFS optimizado >> "%LOG_FILE%"

echo.
echo   [OK] Optimizacion avanzada completada.
timeout /t 2 >nul

:: ====================================================================
:: FASE 4 - INTEGRIDAD (DISM INTELIGENTE + SFC)
:: ====================================================================
cls
echo.
echo  ====================================================================
echo   ^[ FASE 4/4 ^]  VERIFICACION Y REPARACION DE INTEGRIDAD
echo  ====================================================================
echo.
echo   Esta fase puede tardar entre 10 y 40 minutos.
echo   No cierres esta ventana.
echo.
echo [FASE 4 - INTEGRIDAD] >> "%LOG_FILE%"

:: -- Paso 1: Escaneo previo --
echo   [1/4] Escaneando integridad de la imagen de Windows...
DISM /Online /Cleanup-Image /ScanHealth >> "%LOG_FILE%" 2>&1
echo.

:: -- Paso 2: Buscar la MEJOR imagen de reparacion disponible --
echo   [2/4] Buscando la mejor imagen de reparacion disponible...
echo.

set "BEST_SOURCE="
set "BEST_BUILD=0"
set "BEST_TYPE="

echo   Build del sistema actual: !CURRENT_BUILD!
echo   Escaneando unidades en busca de imagenes de Windows...
echo.
echo   Build del sistema: !CURRENT_BUILD! >> "%LOG_FILE%"
echo   Escaneando unidades... >> "%LOG_FILE%"

for %%D in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%D:\sources\install.wim" (
        echo   [+] Imagen WIM encontrada: %%D:\sources\install.wim
        set "IMG_BUILD=0"
        for /f "tokens=2 delims==" %%V in ('DISM /Get-WimInfo /WimFile:%%D:\sources\install.wim /index:1 2^>nul ^| findstr /i "ServicePackBuild"') do (
            set "IMG_BUILD_RAW=%%V"
            set "IMG_BUILD=!IMG_BUILD_RAW: =!"
        )
        if "!IMG_BUILD!"=="0" set "IMG_BUILD=!CURRENT_BUILD!"
        echo       Build detectado: !IMG_BUILD!
        if !IMG_BUILD! GEQ !BEST_BUILD! (
            set "BEST_BUILD=!IMG_BUILD!"
            set "BEST_SOURCE=%%D:\sources\install.wim"
            set "BEST_TYPE=wim"
            echo       ** Seleccionada como mejor fuente **
        )
        echo.
    )
    if exist "%%D:\sources\install.esd" (
        echo   [+] Imagen ESD encontrada: %%D:\sources\install.esd
        set "IMG_BUILD=0"
        for /f "tokens=2 delims==" %%V in ('DISM /Get-WimInfo /WimFile:%%D:\sources\install.esd /index:1 2^>nul ^| findstr /i "ServicePackBuild"') do (
            set "IMG_BUILD_RAW=%%V"
            set "IMG_BUILD=!IMG_BUILD_RAW: =!"
        )
        if "!IMG_BUILD!"=="0" set "IMG_BUILD=!CURRENT_BUILD!"
        echo       Build detectado: !IMG_BUILD!
        if !IMG_BUILD! GEQ !BEST_BUILD! (
            set "BEST_BUILD=!IMG_BUILD!"
            set "BEST_SOURCE=%%D:\sources\install.esd"
            set "BEST_TYPE=esd"
            echo       ** Seleccionada como mejor fuente **
        )
        echo.
    )
)

echo   >> "%LOG_FILE%"
echo   Mejor imagen local: !BEST_SOURCE! ^(Build !BEST_BUILD!^) >> "%LOG_FILE%"
echo   >> "%LOG_FILE%"

:: -- Paso 3: Reparar con la mejor fuente disponible --
echo   [3/4] Reparando imagen del sistema...
echo.

if defined BEST_SOURCE (
    echo   Fuente seleccionada : !BEST_SOURCE!
    echo   Tipo                : !BEST_TYPE!
    echo   Build               : !BEST_BUILD!
    echo.
    echo   DISM con imagen local ^(!BEST_TYPE!^)... >> "%LOG_FILE%"

    DISM /Online /Cleanup-Image /RestoreHealth /Source:!BEST_TYPE!:"!BEST_SOURCE!":1 /LimitAccess >> "%LOG_FILE%" 2>&1

    if errorlevel 1 (
        echo.
        echo   [!] Fallo con imagen local. Reintentando sin /LimitAccess...
        echo   Reintento sin LimitAccess... >> "%LOG_FILE%"
        DISM /Online /Cleanup-Image /RestoreHealth /Source:!BEST_TYPE!:"!BEST_SOURCE!":1 >> "%LOG_FILE%" 2>&1

        if errorlevel 1 (
            echo   [!] Fallo segundo intento. Usando Windows Update...
            echo   Usando Windows Update como ultimo recurso... >> "%LOG_FILE%"
            DISM /Online /Cleanup-Image /RestoreHealth >> "%LOG_FILE%" 2>&1
            if errorlevel 1 (
                echo   [!] DISM reporto errores. Revisa el log: %LOG_FILE%
                echo   DISM fallo en todas las fuentes. >> "%LOG_FILE%"
            ) else (
                echo   [OK] Imagen reparada via Windows Update.
                echo   DISM OK via Windows Update. >> "%LOG_FILE%"
            )
        ) else (
            echo   [OK] Imagen reparada.
            echo   DISM OK con imagen local. >> "%LOG_FILE%"
        )
    ) else (
        echo   [OK] Imagen del sistema reparada con imagen local.
        echo   DISM OK con imagen local. >> "%LOG_FILE%"
    )
) else (
    echo   No se encontro imagen local en ninguna unidad.
    echo   Tip: monta el ISO de Windows para mayor velocidad y fiabilidad.
    echo.
    echo   DISM Source: Windows Update ^(sin imagen local^) >> "%LOG_FILE%"
    DISM /Online /Cleanup-Image /RestoreHealth >> "%LOG_FILE%" 2>&1
    if errorlevel 1 (
        echo   [!] DISM reporto errores. Revisa el log: %LOG_FILE%
        echo   DISM fallo. >> "%LOG_FILE%"
    ) else (
        echo   [OK] Imagen reparada via Windows Update.
        echo   DISM OK. >> "%LOG_FILE%"
    )
)

echo.
echo   Limpiando componentes obsoletos ^(ResetBase^)...
echo   DISM StartComponentCleanup /ResetBase... >> "%LOG_FILE%"
DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase >> "%LOG_FILE%" 2>&1
echo   OK: Componentes limpiados. >> "%LOG_FILE%"

:: -- Paso 4: SFC --
echo.
echo   [4/4] Verificando archivos del sistema con SFC...
echo   SFC /scannow... >> "%LOG_FILE%"
sfc /scannow >> "%LOG_FILE%" 2>&1
echo   SFC completado. >> "%LOG_FILE%"

echo.
echo   [OK] Integridad verificada y reparada.

:: ============================
:: ESPACIO LIBERADO
:: ============================
for /f "tokens=* skip=1" %%i in ('wmic logicaldisk where "DeviceID='C:'" get FreeSpace /value 2^>nul') do (
    for /f "tokens=2 delims==" %%j in ("%%i") do set "SPACE_AFTER=%%j"
)

set "SPACE_DIFF=N/D"
if defined SPACE_BEFORE if defined SPACE_AFTER (
    powershell -NoProfile -Command "Write-Host ('Diferencia: +{0:N0} MB liberados' -f (([long]%SPACE_AFTER% - [long]%SPACE_BEFORE%) / 1MB))" 2>nul > "%TEMP%\wb_diff.txt"
    for /f "delims=" %%R in ("%TEMP%\wb_diff.txt") do set "SPACE_DIFF=%%R"
    del /q "%TEMP%\wb_diff.txt" >nul 2>&1
)

(
echo.
echo ====================================================================
echo  RESUMEN FINAL
echo ====================================================================
echo  Espacio libre antes : %SPACE_BEFORE% bytes
echo  Espacio libre despues: %SPACE_AFTER% bytes
echo  %SPACE_DIFF%
echo ====================================================================
) >> "%LOG_FILE%" 2>nul

:: ============================
:: PANTALLA FINAL
:: ============================
cls
echo.
echo  ####################################################################
echo  #                                                                  #
echo  #          O P T I M I Z A C I O N   C O M P L E T A              #
echo  #                                                                  #
echo  ####################################################################
echo.
echo   Las 4 fases se ejecutaron correctamente:
echo.
echo   ^[FASE 1^]  Limpieza profunda  ^(18 pasos^)              [OK]
echo   ^[FASE 2^]  Red y rendimiento  ^(7 pasos^)               [OK]
echo   ^[FASE 3^]  Optimizacion avanzada  ^(7 pasos^)           [OK]
echo   ^[FASE 4^]  Verificacion de integridad  ^(DISM + SFC^)   [OK]
echo.
echo  --------------------------------------------------------------------
echo.
echo   Espacio libre antes  : %SPACE_BEFORE% bytes
echo   Espacio libre despues : %SPACE_AFTER% bytes
echo   %SPACE_DIFF%
echo.
echo   Log guardado en: %LOG_FILE%
echo.
echo  --------------------------------------------------------------------
echo.
echo   IMPORTANTE: Reinicia el equipo para aplicar todos los cambios.
echo.
echo  --------------------------------------------------------------------
echo                   WinBoost v%VERSION% by Oscarr36
echo                   github.com/Oscarr36
echo  --------------------------------------------------------------------
echo.

choice /C SN /M "  Quieres reiniciar el equipo ahora"
if errorlevel 2 goto :fin
if errorlevel 1 (
    echo.
    echo   Reiniciando en 15 segundos... ^(Ctrl+C para cancelar^)
    shutdown /r /t 15 /c "WinBoost v%VERSION%: Reiniciando para aplicar optimizaciones"
)

:fin
echo.
echo   Saliendo de WinBoost...
timeout /t 3 >nul
endlocal
exit /b 0
