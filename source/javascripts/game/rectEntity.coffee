class App.RectEntity extends App.BasicEntity
  constructor: (@params) ->
    super @params
    @positionX = @params.x or 1
    @positionY = @params.y or 1
    @scale = @params.scale or 1
    @name = @params.name
    @type = @params.type
    @initPixi()

  initPixi: ->
    @sprite = '/images/bunny.png'
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
    bodyDef = new B2.BodyDef
    bodyDef.position.x = @positionX / App.scale
    bodyDef.position.y = @positionY / App.scale
    bodyDef.angle = 0

    bodyDef.type = B2.Body.b2_dynamicBody

    bodyDef.linearDamping = @params.linearDamping or 0.25
    bodyDef.angularDamping = @params.angularDamping or 0.9

    bodyDef.userData = @

    fixDef = new B2.FixtureDef()
    fixDef.density = @params.density or 1.0
    fixDef.friction = @params.friction or 0.05
    fixDef.restitution = @params.restitution or 0.5
    fixDef.filter.categoryBits = @params.categoryBits or 1
    fixDef.filter.maskBits = @params.maskBits or 1

    fixDef.shape = new B2.PolygonShape()
    shapeWidth = @params.shapeWidth or (@pixiEntity.width/2/App.scale * @scale)
    shapeHeight = @params.shapeHeight or (@pixiEntity.height/2/App.scale * @scale)
    fixDef.shape.SetAsBox shapeWidth, shapeHeight

    @physicBody = @physicWorld.CreateBody bodyDef
    @physicBody.CreateFixture fixDef

  initEvents:(params) ->
    @pixiEntity.click = params.click
    @pixiEntity.mouseover = params.mouseover
    @pixiEntity.mouseout = params.params
    @pixiEntity.mousedown = params.mousedown
    @pixiEntity.mouseup = params.mouseup
    @pixiEntity.touchstart = params.touchstart
    @pixiEntity.touchend = params.touchend
    @pixiEntity.tap = params.tap

  sync: () ->
    @pixiEntity.rotation = @physicBody.GetAngle()
    @positionX = @pixiEntity.position.x = @physicBody.GetPosition().x * App.scale
    @positionY = @pixiEntity.position.y = @physicBody.GetPosition().y * App.scale

  setStage: (@stage) ->
    @stage.addChild @pixiEntity

  moveTo: (x, y, maxSpeed = 4) ->
    pos = @physicBody.GetWorldCenter()
    vel = @physicBody.GetLinearVelocity()


    desiredPos = new B2.Vec2(x, y)
    desiredPos.Multiply 1/App.scale

    desiredVel = desiredPos.Copy()
    desiredVel.Subtract(pos)

    neededVel = desiredVel.Copy()
    neededVel.Subtract(vel)

    neededVel.Normalize()
    neededVel.Multiply maxSpeed/App.scale
    neededVel.Multiply @physicBody.GetMass()

    @physicBody.ApplyImpulse neededVel, pos



    angle = @physicBody.GetAngle()
    angleVec = new B2.Vec2(Math.sin(angle), -Math.cos(angle))

    val = (desiredVel.x)*(angleVec.y) - (desiredVel.y)*(angleVec.x)
    #log val

    #@physicBody.ApplyTorque -val * 5

    @physicBody.m_torque = 0
    @physicBody.SetAngularVelocity(0)
    if desiredVel.y >0
      @physicBody.SetAngle(Math.PI + Math.atan(-desiredVel.x/desiredVel.y))
    else
      @physicBody.SetAngle(Math.atan(-desiredVel.x/desiredVel.y))

    #if val > 0.5
    #  @physicBody.m_torque = -val * 5
    #else if val < -0.5
    #  @physicBody.m_torque = val * 5
    #else
    #  @physicBody.m_torque = 0
    #  @physicBody.SetAngularVelocity(0)

    #@physicBody.GetAngularVelocity

    #log teta * 180/Math.PI
    #cosQ = (a.x b.x + a.y b.y) / |a| |b|
    #@physicBody.ApplyTorque 20


    #@physicBody.ApplyImpulse({ x: (x - @positionX)/10000*maxSpeed, y: (y - @positionY)/10000*maxSpeed },
    #  {x: @physicBody.GetWorldCenter().x + 10*Math.sin(@physicBody.GetAngle()), y: @physicBody.GetWorldCenter().y - 10*Math.cos(@physicBody.GetAngle())})

  rotation: (deg) ->
    @pixiEntity.rotation += deg

  position: ->
    {x:@positionX , y:@positionY}