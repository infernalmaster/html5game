class App.groupOfZombies
  constructor: (@name) ->
    @zombies = {}
    
  addZombie: (zombie) ->
    @zombies[zombie.name] = zombie
    
  removeZombie: (zombie) ->
    delete @zombies[zombie.name]
  
  moveTo: (x, y) ->
    for name, zombie of @zombies
      zombie.moveTo x, y