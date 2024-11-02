object jugador{
  var position = game.at(6, 1)
  method position() = position
  method image() = "Personaje.png"

  method controlar_jugador(){
    keyboard.left().onPressDo{self.moverIzq()}
    keyboard.right().onPressDo{self.moverDer()}
  }

  method moverIzq() { position = position.left(1) }
  method moverDer() { position = position.right(1) }
}