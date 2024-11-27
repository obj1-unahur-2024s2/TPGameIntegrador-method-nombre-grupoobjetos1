import main.*
import disparo.*
import enemigo.*

object jugador{
  var position = game.at(6, 1)
  method position() = position
  method image(){
    const parteHerido = if(herido)"herido"else""
    const parteRecargando = if(puedeDisparar)""else"Recarga"
    return "Personaje" + parteHerido + parteRecargando + ".png"
  }

  var property vidas = 3
  var puedeDisparar = true
  var herido = false
  const cadenciaDisparo = 1000
  method velocidadDisparo() = 100
  method colorFuego() = "rojo"
  method objetivo() = "enemigo"
  method posInicialDisparo() = position.up(1) 
  
  method configurarControles(){
    keyboard.left().onPressDo{self.moverIzq()}
    keyboard.right().onPressDo{self.moverDer()}
    keyboard.up().onPressDo{self.disparar()}
  }
  method moverIzq(){
    if(self.position().x() > 0){
      position = position.left(1)
    }
  }
  method moverDer(){
    if(self.position().x() < game.width()-1){
      position = position.right(1)
    }  
  }

  method disparar() {
    if(puedeDisparar){
      const llama = new Llama(personajeDisparador = self)
      llama.iniciar()
      puedeDisparar = false
      self.recarga()  
    }
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
  
  method consumirPowerUp(powerUp){
    vidas += powerUp.vidaQueRecupera()
    powerUp.desaparecer()
  }

   method direccionDisparo(){
    return 1
 }
}