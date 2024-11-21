import disparo.*

object jugador{
  var position = game.at(6, 1)
  var puedoDispara = true
  method position() = position
  method image() = "Personaje"+self.recargaNombre()+".png"
  method bolaDeFuego() = position.up(1) 

  method recargaNombre() = if(puedoDispara)""else "Recarga"   

  method controlar(){
    keyboard.left().onPressDo{self.moverIzq()}
    keyboard.right().onPressDo{self.moverDer()}
    keyboard.up().onPressDo{self.disparar()}
  }
 
  method disparar() {
    const llama = new Llama(personajeDisparador = self)
    if(puedoDispara){
      llama.iniciar()
      self.cambiarEstadoDisparo()
      self.recarga()  
    }
    }
  method recarga() {
    game.schedule(1000,{self.cambiarEstadoDisparo()})
  }
  method recibirImpacto(llama) {
    game.stop()
  }
  method cambiarEstadoDisparo() {
    puedoDispara = !puedoDispara
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
  method image() = "skull"+direccion.toString()+".png"
  method iniciar(){
    self.controlar()
    self.dispararBolaFuego()
  }
  method dispararBolaFuego() {
    game.onTick((1000),"disparar abajo",{self.disparar()})
  }
  method estaVivo() = vida > 0

  method controlar(){
    game.onTick((1..500).anyOne(),"movimiento",{self.irYVolver()})
  }

  method recibirImpacto(llama) {
    vida -= 1 
    if(vida > 0){
      game.say(self, "me quedan " + vida.toString() + " vidas")
      game.removeVisual(llama)
    }
    else{
      const exp = new Explosion(pos = self.position()) 
      exp.aparecer()
      game.removeVisual(self)
      exp.desaparecer()
    }

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
class Explosion {
  const pos
  method image() = "algo.png"
  method position() = pos
  method aparecer() {
    game.addVisual(self)
  }
  method desaparecer() {
    game.schedule(500, {game.removeVisual(self)})
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