class PowerUp{
  var property position
  const image
  method image() = image
  const vidaQueRecupera

  method iniciar(){
    game.addVisual(self)
    self.chequearColisionConJugador()
  }

  method chequearColisionConJugador(){
    game.onCollideDo(self, {j=>j.consumirPowerUp(vidaQueRecupera, self)})
  }

  method recibirImpacto(arg) {
    
  } 
}