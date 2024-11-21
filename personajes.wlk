import disparo.*

object jugador{
  var position = game.at(6, 1)
  var vidas = 3
  var puedeDisparar = true
  method position() = position
  method image() = "Personaje"+self.recargaNombre()+".png"
  method posInicialDisparo() = position.up(1) 

  method recargaNombre() = if(puedeDisparar)""else "Recarga"   

  method controlar(){
    keyboard.left().onPressDo{self.moverIzq()}
    keyboard.right().onPressDo{self.moverDer()}
    keyboard.up().onPressDo{self.disparar()}
  }
 
  method disparar() {
    const llama = new Llama(personajeDisparador = self)
    if(puedeDisparar){
      llama.iniciar()
      puedeDisparar = false
      self.recarga()  
    }
    }
  method recarga() {
    game.schedule(1000,{puedeDisparar = true})
  }
  method recibirImpacto(llama) {
    vidas = 0.max(vidas - 1)
    game.say(self, "Tengo " + vidas.toString() + " vidas")
  }
   method direccionDisparo(pos){
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
  method posInicialDisparo() = position.down(1) 
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
  method direccionDisparo(pos){
    return pos.down(1)
  } 
  method disparar() {
    const llama = new Llama(personajeDisparador = self)
    llama.iniciar()
  }
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