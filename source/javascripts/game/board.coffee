class App.Board
  constructor: (@width, @height) ->
    @zombieGroups = {}
    @canvas = document.getElementById 'dynamic'
    #@renderer = new PIXI.autoDetectRenderer @width, @height, @canvas
    @renderer = new PIXI.CanvasRenderer @width, @height, @canvas
    #document.body.appendChild @renderer.view
    @interactive = true
    @stage = new PIXI.Stage 0x000000, @interactive
    gravity = new B2.Vec2 0, 0
    @physicWorld = new B2.World gravity, true
    new App.Border @
    @addButton()

  onPlayerHit: (event) ->
    hit = (contact, oldManifold) =>
      entity1 = contact.GetFixtureA().GetBody().GetUserData()
      entity2 = contact.GetFixtureB().GetBody().GetUserData()
      # return true if entity1 is null or entity2 is null
      if entity1.type is "player" and entity2.type is "zombie"
        event
          player: entity1
          zombie: entity2
      if entity1.type is "zombie" and entity2.type is "player"
        event
          zombie: entity1
          player: entity2

    @events postSolve: hit

  events: (params) ->
    #Add listeners for contact
    listener = new B2.Listener
    listener.BeginContact = params.beginContact or ->
    listener.EndContact = params.endContact or ->
    listener.PostSolve = params.postSolve or ->
    listener.PreSolve = params.preSolve or ->
    @physicWorld.SetContactListener listener

  addPlayer: (@player) ->
    @player.setStage @stage
    @player.setWorld @physicWorld

  removePlayer: (player) ->
    @stage.removeChild player.pixiSprite

  addGroupOfZombies: (group) ->
    group.setParams
      stage: @stage
      physicWorld: @physicWorld

    @zombieGroups[group.name] = group

  addButton: ->
    button = new App.Button
      shapeWidth: 5 / App.scale
      shapeHeight: 5 / App.scale
      positionX: 100
      positionY: 450

    button.setWorld @physicWorld
    button.initEvents @

  removeGroupOfZombies: (group) ->
    for name, zombie of @zombieGroups[group.name].zombies
      @stage.removeChild zombie.pixiEntity
    delete @zombieGroups[group.name]

  moveAllGroupsOfZombiesTo: (x, y) ->
    for name, group of @zombieGroups
      group.moveTo x, y

  render: ->
    @renderer.render @stage