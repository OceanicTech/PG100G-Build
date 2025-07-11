import os

def list_dir(path="."):
    try:
        files = os.listdir(path)
        print(f"Contenido de {os.path.abspath(path)}:")
        for f in files:
            print(" -", f)
    except Exception as e:
        print(f"Error listando {path}: {e}")