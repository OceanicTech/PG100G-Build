#!/bin/bash

echo "==============================="
echo "🔍 Ejecutando test_main.py con Pytest"
echo "==============================="

# Activar entorno virtual si existe (opcional)
# source venv/bin/activate

# Verificar que pytest esté instalado
if ! python3 -c "import pytest" &> /dev/null; then
    echo "❌ Pytest no está instalado. Instalando..."
    pip install pytest
fi

# Ejecutar SOLO test_main.py
pytest apps/Test/test_main.py --tb=short --disable-warnings

echo ""
echo "🧪 Pruebas finalizadas."
