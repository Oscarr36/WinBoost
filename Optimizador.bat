@echo off
title Optimizador de Sistema - Oscarr36
mode con: cols=70 lines=35
color 0A

:: Comprobar permisos de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    color 0C
    echo.
    echo  [ERROR] Este script necesita permisos de administrador.
    echo  Haz clic derecho y selecciona "Ejecutar como administrador".
    echo.
    pause
    exit /b
)

:: Banner de inicio
cls
echo.
echo  #####################################################################
echo  #                                                                   #
echo  #    ____                            _____  __                      #
echo  #   / __ \                          ^|___ / / /_                     #
echo  #  ^| ^|  ^| ^| ___  ___ __ _ _ __ _ __   __) ^| '_ \                    #
echo  #  ^| ^|  ^| ^|/ __^|/ __/ _` ^| '__^| '__^| ^|__ ^<^| (_) ^|                   #
echo  #  ^| ^|__^| ^|\__ \ (_^| (_^| ^| ^|  ^| ^|    ___) ^|\___/                    #
echo  #   \____/ ^|___/\___\__,_^|_^|  ^|_^|   ^|____/                          #
echo  #                                                                   #
echo  #            S Y S T E M    O P T I M I Z E R                       #
echo  #                                                                   #
echo  #            GitHub: github.com/Oscarr36                            #
echo  #                                                                   #
echo  #####################################################################
echo.
echo                    Pulsa cualquier tecla para empezar...
pause >nul
cls

:: Info del sistema
echo  =====================================================================
echo                       INFORMACION DEL SISTEMA
echo  =====================================================================
echo.
echo   Usuario       : %USERNAME%
echo   Equipo        : %COMPUTERNAME%
echo   Sistema       : %OS%
echo   Fecha/Hora    : %DATE% - %TIME:~0,8%
echo.
echo  =====================================================================
echo.
timeout /t 2 >nul

:: ============================
:: FASE 1 - LIMPIEZA
:: ============================
echo.
echo  [ FASE 1/3 ] LIMPIEZA DEL SISTEMA
echo  ---------------------------------------------------------------------
echo.

echo   [1/8] Limpiando temporales del usuario...
del /q /f /s "%TEMP%\*" >nul 2>&1
for /d %%x in ("%TEMP%\*") do rd /s /q "%%x" >nul 2>&1

echo   [2/8] Limpiando temporales de Windows...
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
for /d %%x in ("C:\Windows\Temp\*") do rd /s /q "%%x" >nul 2>&1

echo   [3/8] Limpiando Prefetch...
del /q /f /s "C:\Windows\Prefetch\*" >nul 2>&1

echo   [4/8] Vaciando papelera de reciclaje...
rd /s /q C:\$Recycle.Bin >nul 2>&1

echo   [5/8] Limpiando cache de miniaturas...
del /q /f /s "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1

echo   [6/8] Limpiando logs antiguos de Windows...
del /q /f /s "C:\Windows\Logs\CBS\*" >nul 2>&1

echo   [7/8] Limpiando descargas pendientes de Windows Update...
net stop wuauserv >nul 2>&1
del /q /f /s "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
net start wuauserv >nul 2>&1

echo   [8/8] Ejecutando limpieza de disco de Windows...
cleanmgr /sagerun:1 >nul 2>&1

echo.
echo   [OK] Limpieza completada.
timeout /t 2 >nul

:: ============================
:: FASE 2 - RED Y RENDIMIENTO
:: ============================
echo.
echo  [ FASE 2/3 ] OPTIMIZACION DE RED Y RENDIMIENTO
echo  ---------------------------------------------------------------------
echo.

echo   [1/4] Limpiando cache DNS...
ipconfig /flushdns >nul

echo   [2/4] Reiniciando catalogo Winsock...
netsh winsock reset >nul

echo   [3/4] Reiniciando pila TCP/IP...
netsh int ip reset >nul 2>&1

echo   [4/4] Liberando memoria RAM no utilizada...
echo. | clip

echo.
echo   [OK] Red y rendimiento optimizados.
timeout /t 2 >nul

:: ============================
:: FASE 3 - INTEGRIDAD
:: ============================
echo.
echo  [ FASE 3/3 ] VERIFICACION DE INTEGRIDAD DEL SISTEMA
echo  ---------------------------------------------------------------------
echo.
echo   Esto puede tardar varios minutos. No cierres la ventana.
echo.

echo   [1/2] Reparando imagen del sistema (DISM)...
DISM /Online /Cleanup-Image /RestoreHealth

echo.
echo   [2/2] Verificando archivos del sistema (SFC)...
sfc /scannow

echo.
echo   [OK] Integridad verificada.

:: ============================
:: FINAL
:: ============================
cls
echo.
echo  #####################################################################
echo  #                                                                   #
echo  #              O P T I M I Z A C I O N   C O M P L E T A            #
echo  #                                                                   #
echo  #####################################################################
echo.
echo   Todas las tareas se han ejecutado correctamente.
echo.
echo   Recomendacion: reinicia el equipo para aplicar todos los cambios.
echo.
echo  ---------------------------------------------------------------------
echo                    Script by Oscarr36
echo                    github.com/Oscarr36
echo  ---------------------------------------------------------------------
echo.

choice /C SN /M "  Quieres reiniciar el equipo ahora"
if errorlevel 2 goto fin
if errorlevel 1 shutdown /r /t 10 /c "Reiniciando para aplicar optimizaciones..."

:fin
echo.
echo   Saliendo...
timeout /t 3 >nul
exit