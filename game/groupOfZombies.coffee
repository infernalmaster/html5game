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
      
  addGroup: (@size, @positionX, @positionY, radius) ->
    for i in [0..@size]
      x = Math.random() * ((radius + @positionX) + (radius - @positionX)) + (radius - @positionX)
      y = Math.random() * ((radius + @positionY) + (radius - @positionY)) + (radius - @positionY)
      @addZombie new App.Zombie (x, y, 1, @name+'_zombie_'+i)