import zipfile
import os

def zip_output(output_dir="out", zip_name="build.zip"):
    if not os.path.exists(output_dir):
        print(f"❌ Carpeta '{output_dir}' no existe, nada que comprimir.")
        return

    zip_path = os.path.join(output_dir, zip_name)
    with zipfile.ZipFile(zip_path, 'w', compression=zipfile.ZIP_DEFLATED) as zipf:
        for root, _, files in os.walk(output_dir):
            for file in files:
                if file == zip_name:
                    continue  # No incluir el zip dentro de sí mismo
                file_path = os.path.join(root, file)
                arcname = os.path.relpath(file_path, output_dir)
                zipf.write(file_path, arcname)
    print(f"✅ Carpeta '{output_dir}' comprimida en '{zip_path}'")
