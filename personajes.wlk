import disparo.*

object jugador{
  var position = game.at(6, 1)
  method position() = position
  method image() = "Personaje.png"
  method bolaDeFuego() = position.up(1) 
  method controlar(){
    keyboard.left().onPressDo{self.moverIzq()}
    keyboard.right().onPressDo{self.moverDer()}
    keyboard.up().onPressDo{self.disparar()}
  }
  method recargarEnergia() {
    game.onTick(400,"recarga",{carga.cambiarEstado()})
  }
  method disparar() {
    const llama = new Llama(personajeDisparador = self)
    llama.iniciar()

  }
  method recibirImpacto(llama) {
    game.stop()
  }
   method direccion(pos){
    return pos.up(1)
  }
  method posicionFinal() = 12  
  method nombreEvento() = "disparar Aribba"
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
    self.dispararBolaFuego()
  }
  method dispararBolaFuego() {
    game.onTick((1000),"disparar abajo",{self.disparar()})
  }
  method estaVivo() = vida > 0

  method controlar(){
    game.onTick((1..500).anyOne(),"movimiento",{self.irYVolver()})
  }

  method burlarse(){
    game.onTick(2000,"burlas",{game.say(self, burlas.anyOne())})
  }

  method recibirImpacto(llama) {
    vida -= 1 
    game.say(self, "me quedan " + vida.max(0).toString() + " vidas")
    game.removeVisual(llama)
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
  method direccion(pos){
    return pos.down(1)
  } 
  method disparar() {
    const llama = new Llama(personajeDisparador = self)
    llama.iniciar()
  }
  method bolaDeFuego() = position.down(1) 
  method posicionFinal() = 1 
  method nombreEvento() = "disparar Abajo" 
}
object derecha{
  method opuesto() = izquierda
  method position(obj) = obj.position().right(1)
}
object izquierda{
  method opuesto() = derecha
  method position(obj) = obj.position().left(1)
}