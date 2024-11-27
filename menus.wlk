import jugador.*
import niveles.*
import main.levelManager

object menuInicio{
  var frame_count = 1
  method position() = game.origin()
  method image() = "menu_inicio"+frame_count.toString()+".png"

  method iniciar() {
    game.addVisual(self)
    levelManager.nivelActual(self)
    keyboard.space().onPressDo({self.iniciarJuego()})
    self.iniciarAnimacion()
  }
  method iniciarJuego() {
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
  var frame = 1 
  method position() = game.origin()
  method image() = "menu_ganaste"+frame.toString()+".png"

  method iniciar() {
    game.removeVisual(jugador)
    game.addVisual(self)
    levelManager.nivelActual(self)
    keyboard.space().onPressDo({self.reiniciarJuego()})
    self.iniciarAnimacion()
  }

  method reiniciarJuego(){
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
  method position() = game.origin()
  method image() = "menu_gameOver.png"  
  var property haIniciado = false
  method iniciar() {
    game.clear()
    game.addVisual(self)
    levelManager.nivelActual(self)
    self.esperarInput()
  }
  method esperarInput(){
    keyboard.space().onPressDo({self.reiniciarJuego()})
  }

  method reiniciarJuego(){
    game.removeVisual(self)
    menuInicio.iniciar()
  }
}