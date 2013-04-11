class App.Zombie
  constructor: (@params) ->
    @positionX = @params.x or 1
    @positionY = @params.y or 1
    @scale = @params.scale or 1
    @name = @params.name
    @initPixi()

  initPixi: ->
    @sprite = 'img/bunny.png'
    playerTexture = PIXI.Texture.fromImage @sprite
    @pixiZombie = new PIXI.Sprite playerTexture
    @pixiZombie.anchor = new PIXI.Point 0.5, 0.5
    #@pixiZombie.position = this.position
    @pixiZombie.position.x = @positionX
    @pixiZombie.position.y = @positionY
    @pixiZombie.scale.x = @scale
    @pixiZombie.scale.y = @scale

  setWorld: (@physicWorld) ->
    bodyDef = new B2.BodyDef()
    bodyDef.position.x = @positionX
    bodyDef.position.y = @positionY
    bodyDef.angle = 0

    bodyDef.type = B2.Body.b2_dynamicBody

    bodyDef.linearDamping = 0.25
    bodyDef.angularDamping = 0.9

    bodyDef.userData = @

    fixDef = new B2.FixtureDef()
    fixDef.density = 1.0;
    fixDef.friction = 0.05;
    fixDef.restitution = 0.5;

    fixDef.shape = new B2.PolygonShape()
    fixDef.shape.SetAsBox 13, 18

    @physicBody = @physicWorld.CreateBody bodyDef
    @physicBody.CreateFixture fixDef

  sync: () ->
    @pixiZombie.rotation = @physicBody.GetAngle()
    @positionX = @pixiZombie.position.x = @physicBody.GetPosition().x
    @positionY = @pixiZombie.position.y = @physicBody.GetPosition().y

  setStage: (@stage) ->
    @stage.addChild @pixiZombie

  moveTo: (x, y) ->
    speed = new B2.Vec2 x-@positionX, y-@positionY
    speed.Normalize()
    speed.Multiply 20
    @physicBody.SetLinearVelocity speed


  rotation: (deg) ->
    @pixiZombie.rotation += deg

  position: ->
    {x:@positionX , y:@positionY}
