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