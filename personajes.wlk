object jugador{
  var position = game.at(6, 1)
  method position() = position
  method image() = "Personaje.png"

  method controlar(){
    keyboard.left().onPressDo{self.moverIzq()}
    keyboard.right().onPressDo{self.moverDer()}
  }

  method moverIzq() { position = position.left(1) }
  method moverDer() { position = position.right(1) }
}

object enemigo{
  var position = game.at(6, 12)
  method position() = position
  var direccion = izquierda
  method image() = "skull.png"

  method controlar(){
    game.onTick(200, "Movimiento", {self.irYVolver()})
  }

  method irYVolver() {
    self.controlarDireccion()
    if (direccion == derecha) 
      self.moverDer()
    else 
      self.moverIzq()
  }

  method controlarDireccion() {
    if (self.estaEnBordeDer()) direccion = direccion.opuesto()
    if (self.estaEnBordeIzq()) direccion = direccion.opuesto()
  }

  method estaEnBordeDer() = position.x() == game.width() - 1
  method estaEnBordeIzq() = position.x() == 0

  method moverIzq() { position = position.left(1) }
  method moverDer() { position = position.right(1) }
}

object derecha{
  method opuesto() = izquierda
}
object izquierda{
  method opuesto() = derecha
}