from PIL import Image, ImageDraw, ImageFont
import os

def run():
    # Crear una imagen RGB vacía (blanca)
    img = Image.new('RGB', (400, 200), color='white')
    d = ImageDraw.Draw(img)

    # Texto para poner en la imagen
    text = "AI Image Generator"
    
    # Intentar cargar fuente por defecto (puede fallar si no hay)
    try:
        font = ImageFont.truetype("arial.ttf", 24)
    except:
        font = ImageFont.load_default()
    
    # Escribir texto en la imagen (posición, texto, color, fuente)
    d.text((50, 80), text, fill=(0, 0, 0), font=font)

    # Guardar la imagen en la carpeta actual
    output_path = os.path.join(os.getcwd(), "generated_image.png")
    img.save(output_path)

    print(f"Imagen generada y guardada en {output_path}")