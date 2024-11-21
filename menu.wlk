import personajes.*




object nivel {
  method iniciar() {
    game.addVisual(jugador)
    jugador.controlar()

    game.addVisual(enemigo)
    enemigo.iniciar()
    game.boardGround("Background_forest.png")
  }
}