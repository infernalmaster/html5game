(function(){App.groupOfZombies=function(){function e(e){this.name=e,this.zombies={}}return e.prototype.addZombie=function(e){return this.zombies[e.name]=e},e.prototype.removeZombie=function(e){return delete this.zombies[e.name]},e.prototype.setParams=function(e){var t,n,r,i;this.params=e,r=this.zombies,i=[];for(t in r)n=r[t],this.params.stage.addChild(n.pixiEntity),i.push(n.setWorld(this.params.physicWorld));return i},e.prototype.moveTo=function(e,t){var n,r,i,s;i=this.zombies,s=[];for(n in i)r=i[n],s.push(r.moveTo(e,t));return s},e.prototype.createGroup=function(e){var t,n,r,i,s,o,u,a,f;this.params=e,this.size=this.params.size,this.positionX=this.params.x,this.positionY=this.params.y,r=this.params.radius,f=[];for(t=u=0,a=this.size;u<=a;t=u+=1)i=Math.random()*2*r-r,o=Math.sqrt(r*r-i*i),s=Math.random()*2*o-o,i+=this.positionX,s+=this.positionY,n=this.name+"_zombie_"+t,f.push(this.addZombie(new App.Zombie({x:i,y:s,scale:1,name:n})));return f},e}()}).call(this);