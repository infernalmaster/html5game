class App.Player
  constructor: (@positionX, @positionY, @scale) ->
    @sprite = 'img/bunny.png'
    playerTexture = PIXI.Texture.fromImage(@sprite)
    @pixiPlayer = new PIXI.Sprite playerTexture
    @pixiPlayer.anchor = new PIXI.Point 0.5, 0.5
    #@pixiPlayer.pos    this.ition = this.position
    @pixiPlayer.position.x = @positionX
    @pixiPlayer.position.y = @positionY
    @pixiPlayer.scale.x = @scale
    @pixiPlayer.scale.y = @scale
    
    
  setWorld: (@physicWorld) ->
    bodyDef = new B2.BodyDef()
    bodyDef.position.x = @positionX
    bodyDef.position.y = @positionY
    bodyDef.angle = 0
       
    bodyDef.type = B2.Body.b2_dynamicBody
    
    bodyDef.linearDamping = 0.15
    bodyDef.angularDamping = 0.0
    
    bodyDef.userData = @  
  
    fixDef = new B2.FixtureDef()
    fixDef.density = 1.0;
    fixDef.friction = 0.05;
    fixDef.restitution = 0.05;
        
    fixDef.shape = new B2.PolygonShape()
    fixDef.shape.SetAsBox 26, 37  
      
    @physicBody = @physicWorld.CreateBody bodyDef
    @physicBody.CreateFixture fixDef
        
    
  sync: () ->
    @pixiPlayer.rotation = @physicBody.GetAngle()
    @positionX = @pixiPlayer.position.x = @physicBody.GetPosition().x
    @positionY = @pixiPlayer.position.y = @physicBody.GetPosition().y
      
    
      
  moveTo: (@positionX, @positionY) ->
    @pixiPlayer.position.x = @positionX
    @pixiPlayer.position.y = @positionY 
    
  rotation: (deg) ->
    @pixiPlayer.rotation += deg
    
  position: ->
    {x:@positionX , y:@positionY}