#!/bin/bash

set -e  # Detener script si ocurre un error

# ----------------------
# Leer valores del project.toml
# ----------------------

PROJECT_NAME=$(grep -E '^name\s*=' project.toml | head -n1 | cut -d= -f2 | tr -d ' "')
PROJECT_VERSION=$(grep -E '^version\s*=' project.toml | head -n1 | cut -d= -f2 | tr -d ' "')

echo "📦 Proyecto: $PROJECT_NAME"
echo "📌 Versión : $PROJECT_VERSION"

# ----------------------
# Preguntar si quiere icono
# ----------------------

read -p "¿Quieres usar un icono (.ico)? [s/n]: " USE_ICON
if [[ "$USE_ICON" =~ ^[sS]$ ]]; then
    read -p "Escribe el nombre del icono (ej: icon.ico): " ICON_PATH
    if [[ ! -f "$ICON_PATH" ]]; then
        echo "❌ El icono no existe. Abortando..."
        exit 1
    fi
    ICON_CMD="--icon=$ICON_PATH"
else
    ICON_CMD=""
fi

# ----------------------
# Limpiar carpetas previas
# ----------------------

echo "🧹 Limpiando carpetas build/, dist/, out/"
rm -rf build dist out

# ----------------------
# Instalar dependencias
# ----------------------

echo "📦 Instalando dependencias..."
pip install -r requirements.txt

# ----------------------
# Compilar con PyInstaller
# ----------------------

echo "⚙️ Compilando proyecto con PyInstaller..."
pyinstaller --onefile --noconsole --name "$PROJECT_NAME" $ICON_CMD apps/Org/OceanicTech/Projects/Main.py

# ----------------------
# Mover ejecutable a carpeta /out/
# ----------------------

echo "📁 Creando carpeta out/ y moviendo ejecutable..."
mkdir -p out
mv "dist/$PROJECT_NAME" "out/${PROJECT_NAME}-v${PROJECT_VERSION}"

# ----------------------
# Limpieza extra
# ----------------------

rm -f "$PROJECT_NAME.spec"

echo "✅ Build completado."
echo "🧠 Ejecutable: out/${PROJECT_NAME}-v${PROJECT_VERSION}"

