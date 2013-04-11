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

    @createBorder @width/2, 0, 0, @width, 10
    @createBorder @width/2, @height, 0, @width, 10
    @createBorder 0, @height/2, 0, 10, @height
    @createBorder @width, @height/2, 0, 10, @height


  addPlayer: (@player) ->
    @player.setStage @stage
    @player.setWorld @physicWorld

  removePlayer: (player) ->
    @stage.removeChild player.pixiSprite

  addGroupOfZombies: (group) ->
    group.setParams
      stage: @stage
      physicWorld: @physicWorld


    #@physicWorld.ClearForces()

    @zombieGroups[group.name] = group

  removeGroupOfZombies: (group) ->
    for name, zombie of @zombieGroups[group.name].zombies
      @stage.removeChild zombie.pixiEntity
    delete @zombieGroups[group.name]


  moveAllGroupsOfZombiesTo: (x, y) ->
    for name, group of @zombieGroups
      group.moveTo x, y

  render: ->
    @renderer.render @stage

  #private:
  createBorder: (x, y, angle, w, h) ->

    bodyDef = new B2.BodyDef()
    bodyDef.position.x = x
    bodyDef.position.y = y
    bodyDef.angle = angle

    bodyDef.type = B2.Body.b2_staticBody

    bodyDef.linearDamping = 0.25
    bodyDef.angularDamping = 0.9


    fixDef = new B2.FixtureDef()
    fixDef.density = 1.0
    fixDef.friction = 0.05
    fixDef.restitution = 0.95

    fixDef.shape = new B2.PolygonShape()
    fixDef.shape.SetAsBox w/2, h/2

    physicBody = @physicWorld.CreateBody bodyDef
    physicBody.CreateFixture fixDef

