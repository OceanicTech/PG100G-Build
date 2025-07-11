import pygame
import sys

def launch():
    pygame.init()
    WIDTH, HEIGHT = 640, 480
    screen = pygame.display.set_mode((WIDTH, HEIGHT))
    pygame.display.set_caption("UI básica PyGame")

    font = pygame.font.SysFont(None, 48)
    text = font.render("Hola desde PyGame UI!", True, (255, 255, 255))

    clock = pygame.time.Clock()

    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    running = False

        screen.fill((30, 30, 60))  # Fondo azul oscuro
        screen.blit(text, (50, HEIGHT // 2 - text.get_height() // 2))

        pygame.display.flip()
        clock.tick(60)

    pygame.quit()
    sys.exit()