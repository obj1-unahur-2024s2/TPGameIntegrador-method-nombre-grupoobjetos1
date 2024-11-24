import main.*
import disparo.*
import enemigo.*

object jugador{
  var position = game.at(6, 1)
  var property vidas = 3
  var puedeDisparar = true
  const cadenciaDisparo = 1000
  method velocidadDisparo() = 100
  const colorFuego = "rojo"

  method objetivo() = "enemigo"
  method position() = position
  method image() = "Personaje"+self.recargaNombre()+".png"
  method posInicialDisparo() = position.up(1) 

  method recargaNombre() = if(puedeDisparar)""else "Recarga"   

  method controlar(){
    keyboard.left().onPressDo{if(self.position().x() != 0){self.moverIzq()}}
    keyboard.right().onPressDo{if(self.position().x() != 12){self.moverDer()}}
    keyboard.up().onPressDo{self.disparar()}
  }
 
  method disparar() {
    if(puedeDisparar){
      const llama = new Llama(personajeDisparador = self, idLlama = 0.randomUpTo(10000) ,color = colorFuego)
      llama.iniciar()
      puedeDisparar = false
      self.recarga()  
    }
    }
  method recarga() {
    game.schedule(cadenciaDisparo,{puedeDisparar = true})
  }
  method recibirImpacto(argumentoNoUtilizado) {
    vidas = 0.max(vidas - 1)
    game.say(self, "Tengo " + vidas.toString() + " vidas")
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