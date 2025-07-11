#!/bin/bash
set -e  # Salir si hay error

# ----------------------
# Preguntar por nombre y versión (sin leer pyproject.toml)
# ----------------------
read -p "Escribe el nombre del proyecto: " PROJECT_NAME
if [[ -z "$PROJECT_NAME" ]]; then
    echo "❌ Nombre del proyecto no puede estar vacío."
    exit 1
fi

read -p "Escribe la versión del proyecto: " PROJECT_VERSION
if [[ -z "$PROJECT_VERSION" ]]; then
    echo "❌ Versión del proyecto no puede estar vacía."
    exit 1
fi

echo "Proyecto: $PROJECT_NAME"
echo "Versión : $PROJECT_VERSION"

# ----------------------
# Preguntar si quiere icono
# ----------------------
while true; do
    read -p "¿Quieres usar un icono (.ico)? [s/n]: " USE_ICON
    case "$USE_ICON" in
        [sS])
            read -p "Escribe el nombre del icono (ej: icon.ico): " ICON_PATH
            if [[ ! -f "$ICON_PATH" ]]; then
                echo "❌ El icono no existe. Intenta de nuevo."
                continue
            fi
            ICON_CMD="--icon=$ICON_PATH"
            break
            ;;
        [nN])
            ICON_CMD=""
            break
            ;;
        *)
            echo "Opción no válida, responde con 's' o 'n'."
            ;;
    esac
done

# ----------------------
# Limpiar carpetas previas
# ----------------------
echo "🔄 Limpiando carpetas anteriores..."
rm -rf build dist out

# ----------------------
# Instalar dependencias
# ----------------------
echo "📦 Instalando dependencias..."
pip install -r requirements.txt

# ----------------------
# Compilar el proyecto
# ----------------------
echo "🛠️ Compilando con PyInstaller..."
# Ajusta la ruta al main.py si necesitas (aquí puse igual que batch)
pyinstaller --onefile --noconsole --name "$PROJECT_NAME" $ICON_CMD apps/Org/Com/Projects/Main.py

# ----------------------
# Mover ejecutable a /out/
# ----------------------
echo "📁 Moviendo ejecutable a carpeta out..."
mkdir -p out

if [[ -f dist/$PROJECT_NAME.exe ]]; then
    mv dist/"$PROJECT_NAME".exe out/"$PROJECT_NAME"-v"$PROJECT_VERSION".exe
else
    echo "❌ Ejecutable no encontrado. Build falló."
    exit 1
fi

# ----------------------
# Limpieza extra
# ----------------------
rm -f "$PROJECT_NAME".spec

echo "✅ Build completado"
echo "➜ Ejecutable generado: out/$PROJECT_NAME-v$PROJECT_VERSION.exe"
