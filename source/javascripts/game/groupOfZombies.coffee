class App.groupOfZombies
  constructor: (@name) ->
    @zombies = {}

  addZombie: (zombie) ->
    @zombies[zombie.name] = zombie

  removeZombie: (zombie) ->
    delete @zombies[zombie.name]

  setParams: (@params) ->
    for name, zombie of @zombies
      @params.stage.addChild zombie.pixiEntity
      zombie.setWorld @params.physicWorld

  moveTo: (x, y) ->
    for name, zombie of @zombies
      zombie.moveTo x, y

  createGroup: (@params) ->
    @size = @params.size
    @positionX = @params.x
    @positionY = @params.y
    radius = @params.radius
    for i in [0..@size] by 1
      x = Math.random() * 2 * radius - radius
      ylim = Math.sqrt radius * radius - x * x
      y = Math.random() * 2 * ylim - ylim
      x += @positionX
      y += @positionY
      name = @name + '_zombie_' + i
      @addZombie new App.Zombie {x: x, y: y, scale: 0.5, name: name}