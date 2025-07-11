import logging
import time
import os

def run():
    # Configurar logging
    log_file = os.path.join(os.getcwd(), "debug.log")
    logging.basicConfig(
        level=logging.DEBUG,
        format="%(asctime)s [%(levelname)s] %(message)s",
        handlers=[
            logging.FileHandler(log_file),
            logging.StreamHandler()
        ]
    )

    logging.info("⚙️ Debug Plugin iniciado")

    # Simula tareas con logs
    for i in range(5):
        logging.debug(f"Iteración {i}: Ejecutando tarea simulada...")
        time.sleep(0.5)

    logging.info("✅ Debug Plugin terminado correctamente")
    print(f"Logs guardados en: {log_file}")
