class App.Player extends App.Entity
  constructor: (@params) ->
    @params.type = 'player'
    @params.scale = 2
    @params.density = 1.0
    @params.friction = 0.05
    @params.restitution = 0.5
    @params.linearDamping = 0.15
    @params.angularDamping = 0.15
    @params.interactive = true
    @params.boxSize =
      x: 26
      y: 37
    super @params