import personajes.*

class Llama {
    const personajeDisparador  
    var position = personajeDisparador.posInicialDisparo()
    method image() = "Fuego.png"
    method position() = position   
    method iniciar() {
        game.addVisualCharacter(self)
        game.onTick(200,personajeDisparador.nombreEvento() + position.toString() , {self.desplazarse()})
        game.sound("DisparoDeFuego1.mp3").play()
        self.checkCollisions()
    }
    method desplazarse() {
        if(self.estaFueraDeLimites()){
            game.removeVisual(self)
            game.removeTickEvent(personajeDisparador.nombreEvento() + position.toString())
        }
        else{
            position = personajeDisparador.direccionDisparo(position)
        }
    }
    method checkCollisions(){
        game.onCollideDo(self, {enemigo => enemigo.recibirImpacto(self)})
    }
    method recibirImpacto(algo) {
      game.removeVisual(self)
      game.removeVisual(algo)
    }

    method estaFueraDeLimites() = position.y() >= game.height() or position.y() <= 0
}

