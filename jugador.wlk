import disparo.*
import enemigo.*

object jugador{
  var position = game.at(6, 1)
  var vidas = 3
  var puedeDisparar = true
  var llamasDisparadas = 0
  var cadenciaDisparo = 500
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
      llamasDisparadas += 1
      const llama = new Llama(personajeDisparador = self, idLlama = llamasDisparadas)
      llama.iniciar()
      puedeDisparar = false
      self.recarga()  
    }
    }
  method recarga() {
    game.schedule(cadenciaDisparo,{puedeDisparar = true})
  }
  method recibirImpacto(llama) {
    vidas = 0.max(vidas - 1)
    game.say(self, "Tengo " + vidas.toString() + " vidas")
  }
   method direccionDisparo(){
    return 1
 }
  method posicionFinal() = 12  
  method nombreEvento() = "disparar Aribba"
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