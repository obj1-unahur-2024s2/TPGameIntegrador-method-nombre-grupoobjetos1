import niveles.*
import main.levelManager

object menuInicio{
  var property haIniciado = false
  method iniciar() {
    game.removeVisual(imgpantallagameover)
    game.removeVisual(imgpantallaganaste)
    game.addVisual(imgpantallainicio)
    pantallaGameOver.haIniciado(false)
    levelManager.nivelActual(self)
    self.esperarInput()
  }
  method esperarInput() {
    keyboard.space().onPressDo({self.iniciarJuego()})
  }
  method iniciarJuego() {
    if (not haIniciado){
      haIniciado = true
      nivel1.iniciar()
      game.removeVisual(imgpantallainicio)
    }
  }

}

object pantallaFinal{
  var property haIniciado = false
  method iniciar() {
    game.clear()
    game.addVisual(imgpantallaganaste)
    levelManager.nivelActual(self)
    self.esperarInput()
  }
  method esperarInput(){
    if (not haIniciado){
      haIniciado = true
      menuInicio.haIniciado(false)
      keyboard.space().onPressDo({menuInicio.iniciar()})
    }
  }
}

object pantallaGameOver{
  var property haIniciado = false
  method iniciar() {
    game.clear()
    game.addVisual(imgpantallagameover)
    levelManager.nivelActual(self)
    self.esperarInput()
  }
  method esperarInput(){
    if (not haIniciado){
      haIniciado = true
      menuInicio.haIniciado(false)
      keyboard.space().onPressDo({menuInicio.iniciar()})
    }
  }
}

object imgpantallainicio{
  var frame = 1
  const position = game.origin()
  method position() = position
  method image() = "menu_inicio"+self.cambiarframe()+".png"
  method cambiarframe(){
    game.schedule(1000, {self.cambiarImagen()})
    return frame
  }
  method cambiarImagen() {
    if(frame == 1){
      frame = 2
    }
    else{
      frame = 1
    }
  }
}

object imgpantallagameover{
  const position = game.origin()
  method position() = position
  method image() = "menu_gameOver.png"
}

object imgpantallaganaste{
  var frame = 1 
  const position = game.origin()
  method position() = position
  method image() = "menu_ganaste"+self.cambiarframe()+".png"
  method cambiarframe(){
    game.schedule(1000, {self.cambiarImagen()})
    return frame
  }
  method cambiarImagen() {
    if(frame == 1){
      frame = 2
    }
    else{
      frame = 1
    }
  }
}