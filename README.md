# 🔌 Sistema de Plugins – ExtraSources/plugins

Este directorio contiene todos los plugins dinámicos del proyecto.

Cada plugin debe ser un archivo `.py` con una función `run()` definida.
El sistema los carga dinámicamente desde el loader ubicado en:

```lua
ExtraSources/
```

---

## 🧠 ¿Cómo se usa?

No tengo ni la menor idea

### ▶️ Para cargar un plugin específico:

Usa esta línea en cualquier parte del proyecto:

```python
[__import__('ExtraSources.plugins_loader').load_plugin('nombre_del_plugin')]

### 🧪 ¿Por qué renombramos `Pytest.test` a `test_main.py`?

El archivo original `Pytest.test` no sigue el patrón de nombres que Pytest reconoce para ejecutar pruebas automáticamente.

Pytest detecta únicamente:
- Archivos que comienzan con `test_`
- O que terminan con `_test.py`

Si no se respeta esta convención, las pruebas **no se ejecutan**, aunque estén bien escritas.

Por eso, el archivo fue renombrado a `test_main.py` para integrarlo correctamente en el sistema de pruebas automatizadas.
