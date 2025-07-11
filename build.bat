@echo off
setlocal EnableDelayedExpansion

REM ----------------------
REM Funciones para parsing de pyproject.toml
REM ----------------------

set "PROJECT_NAME="
set "PROJECT_VERSION="

for /f "usebackq tokens=1,2 delims== " %%A in (`findstr /i "[project]" pyproject.toml`) do (
    set IN_PROJECT=1
)

for /f "usebackq tokens=1,2 delims== " %%A in (`findstr /i "name =" pyproject.toml`) do (
    if defined IN_PROJECT if not defined PROJECT_NAME set "PROJECT_NAME=%%~B"
)

for /f "usebackq tokens=1,2 delims== " %%A in (`findstr /i "version =" pyproject.toml`) do (
    if defined IN_PROJECT if not defined PROJECT_VERSION set "PROJECT_VERSION=%%~B"
)

REM Limpiar comillas dobles del TOML
set "PROJECT_NAME=%PROJECT_NAME:"=%"
set "PROJECT_VERSION=%PROJECT_VERSION:"=%"

REM Mostrar valores leídos
echo Proyecto: %PROJECT_NAME%
echo Version : %PROJECT_VERSION%

REM ----------------------
REM Preguntar por icono
REM ----------------------
set /p USE_ICON=¿Quieres usar un icono (.ico)? [s/n]:
if /i "%USE_ICON%"=="s" (
    set /p ICON_PATH=Escribe el nombre del archivo del icono (ej: icon.ico):
    if not exist "%ICON_PATH%" (
        echo ❌ El icono no existe. Saliendo...
        pause
        exit /b
    )
    set "ICON_CMD=--icon=%ICON_PATH%"
) else (
    set "ICON_CMD="
)

REM ----------------------
REM Limpiar carpetas previas
REM ----------------------
echo 🔄 Limpiando carpetas anteriores...

if exist build (
    rmdir /s /q build
)
if exist dist (
    rmdir /s /q dist
)
if exist out (
    rmdir /s /q out
)

REM ----------------------
REM Instalar dependencias
REM ----------------------
echo 📦 Instalando dependencias...
pip install -r requirements.txt

REM ----------------------
REM Compilar el proyecto
REM ----------------------
echo 🛠️  Compilando con PyInstaller...
pyinstaller --onefile --noconsole --name %PROJECT_NAME% %ICON_CMD% apps\Org\OceanicTech\Projects\Main.py

REM ----------------------
REM Mover el .exe a carpeta /out/
REM ----------------------
echo 📁 Moviendo ejecutable a carpeta out...
mkdir out
move dist\%PROJECT_NAME%.exe out\%PROJECT_NAME%-v%PROJECT_VERSION%.exe >nul

REM ----------------------
REM Limpieza extra
REM ----------------------
del /q %PROJECT_NAME%.spec

echo ✅ Build completado.
echo ➜ Ejecutable generado: out\%PROJECT_NAME%-v%PROJECT_VERSION%.exe

pause
