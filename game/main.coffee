$ ->
  board = new App.Board window.innerWidth, window.innerHeight
  player = new App.Player 400, 300, 2
  game = new App.Game board, player
  
  group1 = new App.groupOfZombies 'group1'

  for i in [0..100]
    group1.addZombie new App.Zombie Math.random()*600, Math.random()*400, 1, 'test'+i
  
  board.addGroupOfZombies group1
  
    
  game.animate()
  
  
  player.moveTo 100, 100  