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
      const llama =new Llama()
      llama.arriba()
    }
  
  method moverIzq() { position = position.left(1) }
  method moverDer() { position = position.right(1) }
}

object enemigo{
  var vida = 2
  var position = game.at(6, 12)
  method position() = position
  var direccion = izquierda
  method image() = "skull.png"
  
  method controlar(){
    game.onTick(100,"Movimiento", {self.irYVolver()})
  }
  method burlas() {
    const descansos = ["Hasta mi abuela juega mejor","Mamita querida estos son nuestros progamadores","Loco tantas no podes errar ","Esa estuvo cerca de darme"]
    game.say(self,descansos.anyone())
  }
  method recibirImpacto() {
    vida = vida - 1 
    if( vida == 0){
      
      game.stop()
    }
    else{
      game.say(self, "me quedan " + vida.max(0).toString() + " vidas")
    }
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