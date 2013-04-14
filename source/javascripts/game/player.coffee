class App.Player extends App.RectEntity
  constructor: (@params) ->
    @params.type = 'player'
    @params.scale = 2
    @params.density = 1.0
    @params.friction = 0.05
    @params.restitution = 0.5
    @params.linearDamping = 0.15
    @params.angularDamping = 0.55
    @params.interactive = true
    super @params