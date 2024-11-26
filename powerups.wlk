class PowerUp{
  var property position
  const image
  method image() = image
  const property vidaQueRecupera

  method iniciar(){
    game.addVisual(self)
    self.chequearColisionConJugador()
  }

  method chequearColisionConJugador(){
    game.onCollideDo(self, {j=>j.consumirPowerUp(self)})
  }

  method desaparecer(){
    game.removeVisual(self)
  }

  method recibirImpacto(arg) {
    
  } 
}