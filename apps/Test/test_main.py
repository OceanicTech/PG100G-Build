import sys
import os
import pytest

# Agrega la ruta raíz del proyecto para importar correctamente
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../../")))

# Importar el módulo principal que vamos a testear
from apps.Org.Com.Projects import Main

def test_main_runs_without_errors():
    """
    Verifica que la función main() se ejecute sin lanzar excepciones.
    """
    try:
        Main.main()
    except Exception as e:
        pytest.fail(f"main() lanzó una excepción inesperada: {e}")

def test_example_math():
    """
    Test de ejemplo simple: 1 + 1 debe ser 2
    """
    assert 1 + 1 == 2
