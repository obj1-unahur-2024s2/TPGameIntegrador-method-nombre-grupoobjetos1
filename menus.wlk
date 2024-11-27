import jugador.*
import niveles.*
import main.levelManager

object menuInicio{
    const musica = game.sound("Menu.ogg")
  var frame_count = 1
  method position() = game.origin()
  method image() = "menu_inicio"+frame_count.toString()+".png"

  method iniciar() {
    musica.play()
    game.addVisual(self)
    levelManager.nivelActual(self)
    keyboard.space().onPressDo({self.iniciarJuego()})
    self.iniciarAnimacion()
  }
  method iniciarJuego() {
    musica.stop()
    game.removeVisual(self)
    game.removeTickEvent("animacionInicio")
    nivel1.iniciar()
  }
  method iniciarAnimacion(){
    game.onTick(500, "animacionInicio", {self.alternarFrame()})
  }
  method alternarFrame() {
    if(frame_count == 1){
      frame_count = 2
    }
    else{
      frame_count = 1
    }
  }

}

object pantallaFinal{
    const musica = game.sound("MusicaGanaste.ogg")
  var frame = 1 
  method position() = game.origin()
  method image() = "menu_ganaste"+frame.toString()+".png"

  method iniciar() {
    musica.play()
    game.removeVisual(jugador)
    game.addVisual(self)
    levelManager.nivelActual(self)
    keyboard.space().onPressDo({self.reiniciarJuego()})
    self.iniciarAnimacion()
  }

  method reiniciarJuego(){
    musica.stop()
    game.removeVisual(self)
    game.removeTickEvent("AnimacionGanador")
    menuInicio.iniciar()
  }
  
  method iniciarAnimacion(){
    game.onTick(500, "AnimacionGanador", {self.alternarFrame()})
  }

  method alternarFrame() {
    if(frame == 1){
      frame = 2
    }
    else{
      frame = 1
    }
  }
}

object pantallaGameOver{
    const musica = game.sound("MusicaDerrota.ogg")
  method position() = game.origin()
  method image() = "menu_gameOver.png"  
  var property haIniciado = false
  method iniciar() {
    musica.play()
    game.clear()
    game.addVisual(self)
    levelManager.nivelActual(self)
    self.esperarInput()
  }
  method esperarInput(){
    keyboard.space().onPressDo({self.reiniciarJuego()})
  }

  method reiniciarJuego(){
    musica.stop()
    game.removeVisual(self)
    menuInicio.iniciar()
  }
}