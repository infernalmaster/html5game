class App.Button extends App.BasicEntity
  constructor: (@params) ->
    @params.type = 'sensor'
    super @params


  setWorld: (@physicWorld) ->
    bodyDef = new B2.BodyDef
    bodyDef.position.Set @params.positionX / App.scale, @params.positionY / App.scale

    bodyDef.type = B2.Body.b2_kinematicBody 
    bodyDef.userData = @    
    shapeWidth = @params.shapeWidth or 1/App.scale
    shapeHeight = @params.shapeHeight or 1/App.scale
    #box - kinematic sensor
    fixDefk_s = new B2.FixtureDef
    fixDefk_s.shape = new B2.PolygonShape
    fixDefk_s.shape.SetAsBox shapeWidth, shapeHeight
    fixDefk_s.isSensor = true;
      
    @physicBody = @physicWorld.CreateBody bodyDef
    @physicBody.CreateFixture fixDefk_s

    
  initEvents: (@board) ->
    beginContact = (contact) ->
      fxA = contact.GetFixtureA()
      fxB = contact.GetFixtureB()
      entity1 = fxA.GetBody().GetUserData()
      entity2 = fxB.GetBody().GetUserData()
      sA=fxA.IsSensor()
      sB=fxB.IsSensor()
      if (sA and !sB) or (sB and !sA)
        if entity1.type is 'player' or entity2.type is 'player'
          console.log 'sensor activated'

    @board.events 
      beginContact: beginContact