class App.Board
  constructor: (@width, @height) ->
    @zombieGroups = {}
    @renderer = new PIXI.autoDetectRenderer @width, @height
    document.body.appendChild @renderer.view
    @stage = new PIXI.Stage
    
    gravity = new B2.Vec2(0, 0)
    @physicWorld = new B2.World(gravity, true)

  addPlayer: (@player) ->
    @stage.addChild @player.pixiPlayer
    @player.setWorld @physicWorld
    
    
    
  removePlayer: (player) ->
    @stage.removeChild player.pixiSprite
    
  addGroupOfZombies: (group) ->
    @zombieGroups[group.name] = group
    for name, zombie of group.zombies
      @stage.addChild zombie.pixiZombie
      
      zombie.setWorld @physicWorld
    
  removeGroupOfZombies: (group) ->
    for name, zombie of @zombieGroups[group.name].zombies
      @stage.removeChild zombie.pixiZombie
    delete @zombieGroups[group.name]

  render: ->
    @renderer.render @stage