import personajes.*

class Llama {
    var position = jugador.position().up(1) 
    var personajeDisparador  
    method image() = "Fuego.png"
    method position() = position   
    method iniciar() {
        game.addVisualCharacter(self)
        game.onTick(200,"disparar arriba", {self.desplazarse()})
        game.sound("DisparoDeFuego1.mp3").play()
        self.checkCollisions()
    }
    method desplazarse() {
        position = personajeDisparador.direccion(position)
    }
    method llegoAlEnemigo(enemigo) {
        enemigo.recibirImpacto()
        game.removeVisual(self)
    }
    method checkCollisions(){
        game.onCollideDo(self, {enemigo => enemigo.recibirImpacto()})
    }
}
object carga {
    var puedoDispar = true 
    var carga = [1,2,3,4] 
    method cambiarEstado() {
        if(carga.first() == 4){
        puedoDispar = true
        carga = [1,2,3,4] 
        }
        else{
        puedoDispar = false
        carga.remove(carga.first())
        }
    }
    method puedoDispar() = puedoDispar 
}
