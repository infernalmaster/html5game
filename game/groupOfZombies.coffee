class App.groupOfZombies
  constructor: (@name) ->
    @zombies = {}
    
  addZombie: (zombie) ->
    @zombies[zombie.name] = zombie
    
  removeZombie: (zombie) ->
    delete @zombies[zombie.name]
  
  setStage: (@stage) ->
    for name, zombie of @zombies
      @stage.addChild zombie.pixiZombie
      
  setWorld: (@physicWorld) ->
    for name, zombie of @zombies
      zombie.setWorld @physicWorld
  
  moveTo: (x, y) ->
    for name, zombie of @zombies
      zombie.moveTo x, y
      
  createGroup: (@size, @positionX, @positionY, radius) ->
    for i in [0..@size] by 1
      x = Math.random() * 2 * radius - radius
      ylim = Math.sqrt radius * radius - x * x
      y = Math.random() * 2 * ylim - ylim
      x += @positionX
      y += @positionY  
      name = @name + '_zombie_' + i
      @addZombie new App.Zombie x, y, 1, name