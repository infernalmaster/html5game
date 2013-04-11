class App.Game
  constructor: (@board, @player) ->
    @board.addPlayer @player

    @mouse =
      x: 0
      y: 0

    document.getElementsByTagName('canvas')[0].addEventListener "mousemove", @onMove, false

    @initEvents()
    @addStats()

  initEvents: ->
    @player.initEvents click: (mouseData) ->
      console.log 'click'

  addStats: =>
    @stats = new Stats()
    @stats.setMode(0) # 0: fps, 1: ms
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

    @player.physicBody.ApplyImpulse
      x: (@mouse.x - @player.positionX) * 1000
      y: (@mouse.y - @player.positionY) * 1000
    , @player.physicBody.GetWorldCenter()

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

    @stats.end()
