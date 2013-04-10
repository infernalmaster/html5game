$ ->
  board = new App.Board window.innerWidth, window.innerHeight
  player = new App.Player 400, 300, 2
  game = new App.Game board, player

  group1 = new App.groupOfZombies 'group1'

  #for i in [0..100]
    #group1.addZombie new App.Zombie Math.random()*600, Math.random()*400, 1, 'test'+i
  #

  group1.createGroup 100, 500, 400, 100
  board.addGroupOfZombies group1

  group2 = new App.groupOfZombies 'group2'
  group2.createGroup 20, 100, 200, 80
  board.addGroupOfZombies group2

  game.animate()


  player.moveTo 100, 100