class PowerUp{
  var property position
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