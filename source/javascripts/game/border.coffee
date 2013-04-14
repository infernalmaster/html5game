class App.Border extends App.BasicEntity
  constructor: (@board) ->
    @createBorder @board.width/2, 0, 0, @board.width, 10
    @createBorder @board.width/2, @board.height, 0, @board.width, 10
    @createBorder 0, @board.height/2, 0, 10, @board.height
    @createBorder @board.width, @board.height/2, 0, 10, @board.height
    super

  createBorder: (x, y, angle, w, h) ->
    bodyDef = new B2.BodyDef()
    bodyDef.position.x = x/ App.scale
    bodyDef.position.y = y/ App.scale
    bodyDef.angle = angle

    bodyDef.type = B2.Body.b2_staticBody

    bodyDef.linearDamping = 0.25
    bodyDef.angularDamping = 0.9
    bodyDef.userData = @

    fixDef = new B2.FixtureDef()
    fixDef.density = 1.0
    fixDef.friction = 0.05
    fixDef.restitution = 0.95
    fixDef.shape = new B2.PolygonShape()
    fixDef.shape.SetAsBox w/2/App.scale, h/2/App.scale

    physicBody = @board.physicWorld.CreateBody bodyDef
    physicBody.CreateFixture fixDef