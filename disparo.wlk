class Llama {
    const personajeDisparador  
    const idLlama
    method idLlama() = idLlama
    var position = personajeDisparador.posInicialDisparo()
    const color
    method image() = "Fuego"+color.toString()+".png"
    method position() = position   
    method iniciar() {
        game.addVisual(self)
        game.onTick(personajeDisparador.velocidadDisparo(), "llama"+idLlama.toString(), {self.desplazarse()})
        game.sound("DisparoDeFuego1.mp3").play()
        self.checkCollisions()
    }
    method desplazarse() {
        if (self.estaFueraDeLimites()){
            game.removeTickEvent("llama"+idLlama.toString())
            game.removeVisual(self)
        } else{
            position = position.up(personajeDisparador.direccionDisparo())
        }
    }
    method checkCollisions(){
        game.onCollideDo(self, {enemigo => enemigo.recibirImpacto(personajeDisparador.objetivo())})
    }
    method recibirImpacto(argumentoNoUtilizado) {
        game.removeTickEvent("llama"+idLlama.toString())
        game.removeVisual(self)
    }
    method estaFueraDeLimites() = position.y() >= game.height() or position.y() <= 0
}

