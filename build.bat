@echo off
setlocal EnableDelayedExpansion

REM Agregar Scripts de Python instalado en usuario al PATH
set "PATH=%USERPROFILE%\AppData\Roaming\Python\Python313\Scripts;%PATH%"

REM ----------------------
REM Preguntar por nombre y versión
REM ----------------------
set /p "PROJECT_NAME=Escribe el nombre del proyecto: "
if "%PROJECT_NAME%"=="" (
    echo ❌ Nombre del proyecto no puede estar vacío.
    pause
    exit /b 1
)

set /p "PROJECT_VERSION=Escribe la versión del proyecto: "
if "%PROJECT_VERSION%"=="" (
    echo ❌ Versión del proyecto no puede estar vacía.
    pause
    exit /b 1
)

echo Proyecto: !PROJECT_NAME!
echo Versión : !PROJECT_VERSION!

REM ----------------------
REM Preguntar por icono
REM ----------------------
:ask_icon
set /p "USE_ICON=¿Quieres usar un icono (.ico)? [s/n]: "
if /i "!USE_ICON!"=="s" (
    set /p "ICON_PATH=Escribe el nombre del archivo del icono, ej: icon.ico: "
    if not exist "!ICON_PATH!" (
        echo ❌ El icono no existe. Intenta otra vez.
        goto :ask_icon
    )
    set "ICON_CMD=--icon=!ICON_PATH!"
) else if /i "!USE_ICON!"=="n" (
    set "ICON_CMD="
) else (
    echo Opción no válida, responde con 's' o 'n'.
    goto :ask_icon
)

REM ----------------------
REM Limpiar carpetas previas
REM ----------------------
echo 🔄 Limpiando carpetas anteriores...
for %%D in (build dist out) do (
    if exist %%D rmdir /s /q %%D
)

REM ----------------------
REM Instalar dependencias
REM ----------------------
echo 📦 Instalando dependencias...
pip install -r requirements.txt || (
    echo ❌ Falló la instalación de dependencias. Checa pip.
    pause
    exit /b 1
)

Rem Cambien la linea de apps\Org\Com\Projects\Main.py que dice com por su compania

REM ----------------------
REM Compilar el proyecto
REM ----------------------
echo 🛠️  Compilando con PyInstaller...
if defined ICON_CMD (
    pyinstaller --onefile --noconsole --name "!PROJECT_NAME!" !ICON_CMD! apps\Org\Com\Projects\Main.py || (
        echo ❌ Error al compilar con PyInstaller.
        pause
        exit /b 1
    )
) else (
    pyinstaller --onefile --noconsole --name "!PROJECT_NAME!" apps\Org\Com\Projects\Main.py || ( 
        echo ❌ Error al compilar con PyInstaller.
        pause
        exit /b 1
    )
)

REM ----------------------
REM Mover el ejecutable a /out/
REM ----------------------
echo 📁 Moviendo ejecutable a carpeta out...
if not exist out mkdir out

if exist dist\!PROJECT_NAME!.exe (
    move /y dist\!PROJECT_NAME!.exe out\!PROJECT_NAME!-v!PROJECT_VERSION!.exe >nul
) else (
    echo ❌ Ejecutable no encontrado. Build falló.
    pause
    exit /b 1
)

REM ----------------------
REM Limpieza extra
REM ----------------------
if exist !PROJECT_NAME!.spec del /q !PROJECT_NAME!.spec

echo ✅ Build completado
echo ➜ Ejecutable generado: out\!PROJECT_NAME!-v!PROJECT_VERSION!.exe

pause
exit /b 0
