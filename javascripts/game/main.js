(function(){var e;e=new PIXI.AssetLoader(["/html5game/images/bunny.png"]),e.onComplete=function(){var e,t,n,r,i;return e=new App.Board(window.innerWidth,window.innerHeight),i=new App.Player({x:400,y:300}),t=new App.Game(e,i),n=new App.groupOfZombies("group1"),n.createGroup({size:30,x:500,y:400,radius:30}),e.addGroupOfZombies(n),r=new App.groupOfZombies("group2"),r.createGroup({size:50,x:100,y:200,radius:50}),e.addGroupOfZombies(r),t.animate(),i.moveTo(100,100)},e.load()}).call(this);
