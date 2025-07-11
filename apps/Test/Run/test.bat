@echo off
title Pytest
color 0A

echo ================================
echo 🔍 Ejecutando pruebas con Pytest
echo ================================

REM Activar entorno virtual si existe (opcional)
REM call venv\Scripts\activate

REM Verificar que pytest esté instalado
pip show pytest >nul 2>&1
if errorlevel 1 (
    echo ❌ Pytest no está instalado. Instalando ahora...
    pip install pytest
)

REM Ejecutar solo test_main.py
pytest ../test_main.py --tb=short --disable-warnings

echo.
echo 🧪 Pruebas finalizadas.
pause
