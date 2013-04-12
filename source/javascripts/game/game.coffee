class App.Game
  constructor: (@board, @player) ->
    @board.addPlayer @player

    @mouse =
      x: 0
      y: 0

    document.getElementById('dynamic').addEventListener "mousemove", @onMove, false
    @initEvents()
    @addStats()

  initEvents: ->
    @player.initEvents click: (mouseData) ->
      console.log 'click'
    @board.onPlayerHit ->
      # console.log 'ough'

  debug: (canvas2dContext) ->
    @debug = true
    sCanvas = document.getElementById('static').getContext('2d') or canvas2dContext
    sCanvas.canvas.width = @board.width
    sCanvas.canvas.height = @board.height
    debugDraw = new B2.DebugDraw()
    debugDraw.SetSprite sCanvas
    debugDraw.SetFillAlpha 0.5
    debugDraw.SetLineThickness 1.0
    debugDraw.SetDrawScale(App.scale);
    debugDraw.SetFlags B2.DebugDraw.e_shapeBit | B2.DebugDraw.e_jointBit
    @board.physicWorld.SetDebugDraw debugDraw

  addStats: =>
    @stats = new Stats()
    @stats.setMode 0  # 0: fps, 1: ms
    @stats.domElement.style.position = 'absolute'
    @stats.domElement.style.left = '0px'
    @stats.domElement.style.top = '0px'
    document.body.appendChild @stats.domElement

  onMove: (e) =>
    if e.pageX or e.pageY
      @mouse.x = e.pageX
      @mouse.y = e.pageY
    else
      @mouse.x = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft
      @mouse.y = e.clientY + document.body.scrollTop + document.documentElement.scrollTop

  animate: =>
    requestAnimationFrame @animate

    @stats.begin()

#    @player.physicBody.ApplyImpulse
#      x: (@mouse.x - @player.positionX) * 1000
#      y: (@mouse.y - @player.positionY) * 1000
#    , @player.physicBody.GetWorldCenter()

    @player.moveTo @mouse.x, @mouse.y, 40

    @board.moveAllGroupsOfZombiesTo @player.positionX, @player.positionY

    now = (new Date()).getTime()

    delta = if time_last_run
      ( now - time_last_run ) / 1000
    else 1 / 60

    time_last_run = now

    @board.physicWorld.Step(
        delta * 2, # double the speed of the simulation
        10,        # velocity iterations
        10         # position iterations
    )

    object = @board.physicWorld.GetBodyList()

    while object
      entity = object.GetUserData()
      entity.sync() if entity
      object = object.GetNext()
      
    @board.render()

    if @debug
      @board.physicWorld.DrawDebugData()
      @board.physicWorld.ClearForces()
    @stats.end()