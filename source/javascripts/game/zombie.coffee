class App.Zombie extends App.RectEntity
  constructor: (@params) ->
    @params.type = 'zombie'
    @params.density = 1.0
    @params.friction = 0.05
    @params.restitution = 0.5
    @params.linearDamping = 0.25
    @params.angularDamping = 0.9
    @params.categoryBits = App.groups.zombie
    @params.maskBits = App.groups.walls + App.groups.player
    super @params
