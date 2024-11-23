import main.*
import jugador.*
import disparo.*

class Enemigo{
  var vida
  const id
  var position
  const velocidad
  const cadenciaDisparo = 2000
  method velocidadDisparo() = 200
  var direccion = izquierda
  var herido = "" 
  const colorFuego = "violeta"

  method position() = position
  method image() = "skull"+direccion.toString()+herido.toString()+".png"
  method posInicialDisparo() = position.down(1) 
  method objetivo() = "jugador"

  method iniciar(){
    game.addVisual(self)
    self.controlar()
    self.dispararBolaFuego()
  }
  method dispararBolaFuego() {
    game.onTick((cadenciaDisparo),"disparar abajo"+id.toString(),{self.disparar()})
  }
  method controlar(){
    game.onTick(velocidad,"movimiento"+id.toString(),{self.irYVolver()})
  }

  method recibirImpacto(objetivoPersonajeDisparador) {
    if (objetivoPersonajeDisparador == "enemigo"){
      vida -= 1 
      if(vida > 0){
        self.cambiarImagen()
        game.say(self, "me quedan " + vida.toString() + " vidas")
      }
      else{
        self.morir()
      }
    }
  } 

  method cambiarImagen() {
    herido="herido"
    game.schedule(200, {herido = ""})
  } 

  method morir() {
    const exp = new Explosion(pos = self.position()) 
    exp.iniciar()

    game.removeVisual(self)
    game.removeTickEvent("disparar abajo"+id.toString())
    game.removeTickEvent("movimiento"+id.toString())

    main.levelManager.eliminarEnemigoDeContador()
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
    const llama = new Llama(personajeDisparador = self, idLlama = (0..10000).anyOne(), color=colorFuego)
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