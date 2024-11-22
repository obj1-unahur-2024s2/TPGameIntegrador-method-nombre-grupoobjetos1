import jugador.*
import disparo.*

class Enemigo{
  var vida
  const id
  var position
  const velocidad

  var llamasDisparadas = 0
  var direccion = izquierda

  method position() = position
  method image() = "skull"+direccion.toString()+".png"
  method posInicialDisparo() = position.down(1) 

  method iniciar(){
    game.addVisual(self)
    self.controlar()
    self.dispararBolaFuego()
  }
  method dispararBolaFuego() {
    game.onTick((1000),"disparar abajo"+id.toString(),{self.disparar()})
  }
  method controlar(){
    game.onTick(velocidad,"movimiento"+id.toString(),{self.irYVolver()})
  }

  method recibirImpacto(llama) {
    vida -= 1 
    if(vida > 0){
      game.say(self, "me quedan " + vida.toString() + " vidas")
    }
    else{
      const exp = new Explosion(pos = self.position()) 
      exp.iniciar()
      game.removeVisual(self)
      game.removeTickEvent("disparar abajo"+id.toString())
      game.removeTickEvent("movimiento"+id.toString())
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
  method direccionDisparo(){
    return -1
  } 
  method disparar() {
    llamasDisparadas += 10
    const llama = new Llama(personajeDisparador = self, idLlama = llamasDisparadas)
    llama.iniciar()
  }
  method posicionFinal() = 1 
  method nombreEvento() = "disparar Abajo" 
}
class Explosion {
  const pos
  method image() = "explosion.png"
  method position() = pos
  method iniciar() {
    game.addVisual(self)
    game.schedule(2000, {game.removeVisual(self)})
  }
  method recibirImpacto(arg){
    
  }
}