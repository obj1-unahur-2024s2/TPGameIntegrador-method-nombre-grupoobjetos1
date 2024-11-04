import personajes.*

class Llama {
    var position = jugador.position() 
    method image() = "Fuego.png"
    method position() = position   
    method arriba() {
        game.addVisualCharacter(self)
        game.onTick(200,"disparar arriba", {self.desplazarse()})
        var sonido = game.sound("DisparoDeFuego1.mp3")
        sonido.play()
    }
    method desplazarse() {
        position = position.up(1)
    }
    method llegoAlEnemigo(enemigo) {
        enemigo.recibirImpacto()
        game.removeVisual(self)
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
