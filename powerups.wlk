class PowerUp{
  var property position
  const image
  method image() = image
  const vidaQueRecupera

  method iniciar(){
    game.addVisual(self)
    self.chequearColisionConJugador()
    game.schedule(5000, {self.desaparecer()})
  }

  method chequearColisionConJugador(){
    game.onCollideDo(self, {j=>j.consumirPowerUp(vidaQueRecupera, self)})
  }

  method desaparecer(){
    game.removeVisual(self)
  }

  method recibirImpacto(arg) {
    
  } 
}