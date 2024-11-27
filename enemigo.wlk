import main.*
import disparo.*

class Enemigo{

  method position() = position
  method image() = "skull"+direccion.toString()+herido.toString()+".png"

  var vida
  const id
  var position
  const velocidad
  const cadenciaDisparo = 2000
  method velocidadDisparo() = 200
  var direccion = izquierda
  var herido = "" 
  method colorFuego() = "violeta"
  method posInicialDisparo() = position.down(1) 
  method objetivo() = "jugador"

  method iniciar(){
    game.addVisual(self)
    self.controlar()
    game.onTick((cadenciaDisparo),"disparar abajo"+id.toString(),{self.disparar()})
  }

  method controlar(){
    game.onTick(velocidad,"movimiento"+id.toString(),{self.irYVolver()})
  }

  method disparar() {
    const llama = new Llama(personajeDisparador = self)
    llama.iniciar()
  }

  method irYVolver() {
    self.mover(direccion)

    if (self.estaEnBordeDer()) direccion = izquierda
    if (self.estaEnBordeIzq()) direccion = derecha
  }
  method estaEnBordeDer() = position.x() == game.width() - 1
  method estaEnBordeIzq() = position.x() == 0

  method mover(dir) {
    position = dir.position(self)
  }

  method recibirImpacto(objetivoPersonajeDisparador) {
    if (objetivoPersonajeDisparador == "enemigo"){
      vida -= 1 
      if(vida > 0){
        herido="herido"
        game.schedule(200, {herido = ""})
        game.say(self, "me quedan " + vida.toString() + " vidas")
      }
      else{
        self.morir()
      }
    }
  } 

  method morir() {
    const exp = new Explosion(pos = self.position()) 
    exp.iniciar()

    game.removeVisual(self)
    game.removeTickEvent("disparar abajo"+id.toString())
    game.removeTickEvent("movimiento"+id.toString())

    main.levelManager.eliminarEnemigoDeContador()
  }

  method direccionDisparo(){
    return -1
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

object derecha{
  method position(obj) = obj.position().right(1)
}
object izquierda{
  method position(obj) = obj.position().left(1)
}