class App.Player extends App.Entity
  constructor: (@params) ->
    @positionX = @params.x or 1
    @positionY = @params.y or 1
    @scale = @params.scale or 2
    @params.type = 'player'
    @params.density = 1.0
    @params.friction = 0.05
    @params.restitution = 0.5
    @params.linearDamping = 0.15
    @params.angularDamping = 0.15
    @params.interactive = true
    @params.boxSize =
      x: 26
      y: 37
    @initPixi()