class App.Entity
  constructor: (@params) ->
    @positionX = @params.x or 1
    @positionY = @params.y or 1
    @scale = @params.scale or 1
    @name = @params.name
    @type = @params.type
    @initPixi()

  initPixi: ->
    @sprite = 'img/bunny.png'
    playerTexture = PIXI.Texture.fromImage @sprite
    @pixiEntity = new PIXI.Sprite playerTexture
    @pixiEntity.setInteractive @params.interactive or false
    @pixiEntity.anchor = new PIXI.Point 0.5, 0.5
    #@pixiEntity.position = this.position
    @pixiEntity.position.x = @positionX
    @pixiEntity.position.y = @positionY
    @pixiEntity.scale.x = @scale
    @pixiEntity.scale.y = @scale

  setWorld: (@physicWorld) ->
    bodyDef = new B2.BodyDef()
    bodyDef.position.x = @positionX
    bodyDef.position.y = @positionY
    bodyDef.angle = 0

    bodyDef.type = B2.Body.b2_dynamicBody

    bodyDef.linearDamping = @params.linearDamping or 0.25
    bodyDef.angularDamping = @params.angularDamping or 0.9

    bodyDef.userData = @

    fixDef = new B2.FixtureDef()
    fixDef.density = @params.density or 1.0
    fixDef.friction = @params.friction or 0.05
    fixDef.restitution = @params.restitution or 0.5

    fixDef.shape = new B2.PolygonShape()
    fixDef.shape.SetAsBox @params.boxSize.x, @params.boxSize.y

    @physicBody = @physicWorld.CreateBody bodyDef
    @physicBody.CreateFixture fixDef

  initEvents:(params) ->
    @pixiEntity.mouseover = params.mouseover
    @pixiEntity.click = params.click
    @pixiEntity.mouseout = params.params
    @pixiEntity.mousedown = params.mousedown
    @pixiEntity.mouseup = params.mouseup
    @pixiEntity.touchstart = params.touchstart
    @pixiEntity.touchend = params.touchend
    @pixiEntity.tap = params.tap

  sync: () ->
    @pixiEntity.rotation = @physicBody.GetAngle()
    @positionX = @pixiEntity.position.x = @physicBody.GetPosition().x
    @positionY = @pixiEntity.position.y = @physicBody.GetPosition().y

  setStage: (@stage) ->
    @stage.addChild @pixiEntity

  moveTo: (x, y) ->
    speed = new B2.Vec2 x-@positionX, y-@positionY
    speed.Normalize()
    speed.Multiply 20
    @physicBody.SetLinearVelocity speed


  rotation: (deg) ->
    @pixiEntity.rotation += deg

  position: ->
    {x:@positionX , y:@positionY}
