import importlib.util
import os

PLUGIN_DIR = os.path.join("ExtraSources", "plugins")

def load_plugin(plugin_name: str):
    """
    Carga y ejecuta un plugin específico con .run()
    """
    file = f"{plugin_name}.py"
    path = os.path.join(PLUGIN_DIR, file)
    if not os.path.exists(path):
        print(f"❌ Plugin '{file}' no existe.")
        return

    spec = importlib.util.spec_from_file_location(plugin_name, path)
    plugin = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(plugin)

    if hasattr(plugin, "run"):
        print(f"✅ Ejecutando plugin '{plugin_name}'...")
        plugin.run()
    else:
        print(f"⚠️  El plugin '{plugin_name}' no tiene función 'run()'.")
