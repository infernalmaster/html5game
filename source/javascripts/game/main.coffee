preloader = new PIXI.AssetLoader ['/images/bunny.png']
preloader.onComplete = ->
  board = new App.Board window.innerWidth, window.innerHeight
  player = new App.Player
    x: 400
    y: 300

  game = new App.Game board, player

  game.debug()
  group1 = new App.groupOfZombies 'group1'

  #for i in [0..100]
    #group1.addZombie new App.Zombie Math.random()*600, Math.random()*400, 1, 'test'+i
  #

  group1.createGroup
    size: 10
    x: 500
    y: 400
    radius: 10

  board.addGroupOfZombies group1

  group2 = new App.groupOfZombies 'group2'
  group2.createGroup
    size: 20
    x: 100
    y: 200
    radius: 30

  board.addGroupOfZombies group2

  game.animate()



preloader.load()