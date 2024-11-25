import main.*
import disparo.*
import enemigo.*

object jugador{
  var position = game.at(6, 1)
  var property vidas = 3
  var puedeDisparar = true
  var herido = false
  const cadenciaDisparo = 1000
  method velocidadDisparo() = 100
  const colorFuego = "rojo"

  method objetivo() = "enemigo"
  method position() = position
  method image() = "Personaje"+self.herida()+self.recargaNombre()+".png"
  method posInicialDisparo() = position.up(1) 

  method recargaNombre() = if(puedeDisparar)""else "Recarga"   
  
  method herida() = if(herido)"herido"else""
  method controlar(){
    keyboard.left().onPressDo{if(self.position().x() != 0){self.moverIzq()}}
    keyboard.right().onPressDo{if(self.position().x() != 12){self.moverDer()}}
    keyboard.up().onPressDo{if(puedeDisparar){self.disparar()}}
  }
 
  method disparar() {
    const llama = new Llama(personajeDisparador = self, idLlama = 0.randomUpTo(10000) ,color = colorFuego)
    llama.iniciar()
    puedeDisparar = false
    self.recarga()  
  }
  method recarga() {
    game.schedule(cadenciaDisparo,{puedeDisparar = true})
  }
  method recibirImpacto(argumentoNoUtilizado) {
    vidas = vidas - 1
    herido = true
    game.schedule(500,{herido = false})
    game.say(self, "Tengo " + vidas.toString() + " vida")
    main.levelManager.checkVidasJugador()
  }
  method consumirPowerUp(vidaQueRecupera, powerUp){
    vidas += vidaQueRecupera
    game.removeVisual(powerUp)
  }

   method direccionDisparo(){
    return 1
 }

  method moverIzq() { position = position.left(1) }
  method moverDer() { position = position.right(1) }
}

object derecha{
  method opuesto() = izquierda
  method position(obj) = obj.position().right(1)
}
object izquierda{
  method opuesto() = derecha
  method position(obj) = obj.position().left(1)
}