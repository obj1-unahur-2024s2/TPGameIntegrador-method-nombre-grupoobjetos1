import wollok.game.*
import personajes.*

object juego {

  method configurar(){
    game.width(13)
    game.height(13)
    game.boardGround("Background_forest.png")

    game.addVisual(jugador)
    jugador.controlar()

    game.addVisual(enemigo)
    enemigo.controlar()
  }

}
