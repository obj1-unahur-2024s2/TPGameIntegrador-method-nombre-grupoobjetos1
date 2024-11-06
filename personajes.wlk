import disparo.*

object jugador{
  var position = game.at(6, 1)
  method position() = position
  method image() = "Personaje.png"

  method controlar(){
    keyboard.left().onPressDo{self.moverIzq()}
    keyboard.right().onPressDo{self.moverDer()}
    keyboard.up().onPressDo{self.disparar()}
  }

  method disparar() {
      const llama = new Llama(personajeDisparador = self)
      llama.iniciar()
    }
  method direccion(pos){
    return pos.up(1)
  } 
  
  method moverIzq() { position = position.left(1) }
  method moverDer() { position = position.right(1) }
}

object enemigo{
  var vida = 3
  var position = game.at(6, 12)
  method position() = position
  var direccion = izquierda
  method image() = "skull.png"
  const burlas = ["Hasta mi abuela juega mejor","Mamita querida estos son nuestros progamadores","Loco no podes fallar tanto","Esa estuvo cerca de darme"] 

  method iniciar(){
    self.controlar()
    self.burlarse()
  }

  method estaVivo() = vida > 0

  method controlar(){
      game.onTick(100,"movimiento", {self.irYVolver()})
  }

  method burlarse(){
    game.onTick(2000,"burlas",{game.say(self, burlas.anyOne())})
  }

  method recibirImpacto() {
    vida -= 1 
    game.say(self, "me quedan " + vida.max(0).toString() + " vidas")
    game.removeVisual(Llama)
  } 

  method irYVolver() {
    self.controlarDireccion()
    self.mover(direccion)
  }

  method controlarDireccion() {
    if (self.estaEnBordeDer()) direccion = direccion.opuesto()
    if (self.estaEnBordeIzq()) direccion = direccion.opuesto()
  }

  method estaEnBordeDer() = position.x() == game.width() - 1
  method estaEnBordeIzq() = position.x() == 0

  method mover(dir) {
    position = dir.position(self)
  }
}

object derecha{
  method opuesto() = izquierda
  method position(obj) = obj.position().right(1)
}

object izquierda{
  method opuesto() = derecha
  method position(obj) = obj.position().left(1)
}