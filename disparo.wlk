class Llama {
    const personajeDisparador  
    var position = personajeDisparador.posInicialDisparo()
    method image() = "Fuego"+personajeDisparador.colorFuego().toString()+".png"
    method position() = position 

    const idLlama = 0.randomUpTo(1000000)
    method idLlama() = idLlama
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
    method estaFueraDeLimites() = position.y() >= game.height() or position.y() <= 0

    method checkCollisions(){
        game.onCollideDo(self, {enemigo => enemigo.recibirImpacto(personajeDisparador.objetivo())})
    }
    
    method recibirImpacto(argumentoNoUtilizado) {
        game.removeTickEvent("llama"+idLlama.toString())
        game.removeVisual(self)
    }
    
    method consumirPowerUp(powerup) {
        game.removeTickEvent("llama"+idLlama.toString())
        game.removeVisual(self)
    }
}

