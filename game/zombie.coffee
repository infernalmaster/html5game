class App.Zombie extends App.Entity
  constructor: (@params) ->
    @params.type = 'zombie'
    @params.density = 1.0
    @params.friction = 0.05
    @params.restitution = 0.5
    @params.linearDamping = 0.25
    @params.angularDamping = 0.9
    @params.boxSize =
      x: 13
      y: 18
    super @params
