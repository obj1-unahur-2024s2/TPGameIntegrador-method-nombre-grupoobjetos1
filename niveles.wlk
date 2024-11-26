import jugador.*
import enemigo.*
import main.levelManager
import menus.*


object nivel1 {
  method siguiente() = nivel2
  method iniciar() {
    jugador.vidas(3)
    levelManager.nivelActual(self)
    game.addVisual(jugador)
    jugador.controlar()

    const enemigo1 = new Enemigo(id = 1, position = game.at(6, 12), vida = 1, velocidad = 500)
    enemigo1.iniciar()

    levelManager.enemigosVivos(1)
  }
}

object nivel2 {
  method siguiente() = nivel3
  method iniciar() {
    levelManager.nivelActual(self)

    const enemigo2 = new Enemigo(id = 825, position = game.at(0, 12), vida = 3, velocidad = 300)
    enemigo2.iniciar()

    levelManager.enemigosVivos(1)
  }
}

object nivel3 {
  method siguiente() = pantallaFinal
  method iniciar() {
    levelManager.nivelActual(self)

    const enemigo4 = new Enemigo(id = 333, position = game.at(0, 12), vida = 3, velocidad = 300)
    enemigo4.iniciar()
    
    const enemigo5 = new Enemigo(id = 444, position = game.at(11, 10), vida = 3, velocidad = 300)
    enemigo5.iniciar()

    levelManager.enemigosVivos(2)
  }
}