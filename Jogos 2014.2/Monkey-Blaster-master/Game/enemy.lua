

enemy={}
enemyTipo={}
enemy.qntd=4
enemy.size=0.8
enemy.width=size-1--math.floor(size*enemyNb.size+0.5)   --20
enemy.height=size-1 --math.floor(size*enemyNb.size+0.5)  --28
enemy.speed=size*2
enemy.invTime=1
boost={}

function enemy.infoLoad()
  for i=1, enemy.qntd do
    enemyTipo[i]={}
  end
  enemyTipo[1].charQuads = {}
  enemyTipo[1].img = love.graphics.newImage("/Source/lead-scientist.png")
  enemyScientist()
  enemyTipo[1].frame = 1
  enemyTipo[1].frametime = 0
  enemyTipo[1].health=1
  enemyTipo[1].AI=2
  enemyTipo[1].yAdjust=-12
  enemyTipo[1].downI=1 enemyTipo[1].downF=3
  enemyTipo[1].leftI=4 enemyTipo[1].leftF=6
  enemyTipo[1].rightI=7 enemyTipo[1].rightF=9
  enemyTipo[1].upI=10 enemyTipo[1].upF=12
  
  enemyTipo[2].charQuads = {}
  enemyTipo[2].img = love.graphics.newImage("/Source/cientistaFix.png")
  enemyScientist2()
  enemyTipo[2].frame = 1
  enemyTipo[2].frametime = 0
  enemyTipo[2].health=2
  enemyTipo[2].AI=3
  enemyTipo[2].yAdjust=-14
  enemyTipo[2].downI=1 enemyTipo[2].downF=4
  enemyTipo[2].leftI=5 enemyTipo[2].leftF=8
  enemyTipo[2].rightI=9 enemyTipo[2].rightF=12
  enemyTipo[2].upI=13 enemyTipo[2].upF=16
  
  enemyTipo[3].charQuads = {}
  enemyTipo[3].img = love.graphics.newImage("/Source/Velho.png")
  enemyOldMan()
  enemyTipo[3].frame = 1
  enemyTipo[3].frametime = 0
  enemyTipo[3].health=2
  enemyTipo[3].AI=4
  enemyTipo[3].yAdjust=-8
  enemyTipo[3].downI=1 enemyTipo[3].downF=3
  enemyTipo[3].leftI=4 enemyTipo[3].leftF=6
  enemyTipo[3].rightI=7 enemyTipo[3].rightF=9
  enemyTipo[3].upI=10 enemyTipo[3].upF=12
  
  enemyTipo[4].charQuads = {}
  enemyTipo[4].img = love.graphics.newImage("/Source/Bruce Banner.png")
  enemyBruce()
  enemyTipo[4].frame = 1
  enemyTipo[4].frametime = 0
  enemyTipo[4].health=2
  enemyTipo[4].AI=5
  enemyTipo[4].yAdjust=-8
  enemyTipo[4].downI=1 enemyTipo[4].downF=4
  enemyTipo[4].leftI=5 enemyTipo[4].leftF=8
  enemyTipo[4].rightI=9 enemyTipo[4].rightF=12
  enemyTipo[4].upI=13 enemyTipo[4].upF=16
  
  enemy.alert=love.graphics.newImage("/Source/Exclamation.png")
  enemy.alertfWidth=size/4/enemy.alert:getWidth()
  enemy.alertfHeight=2*size/3/enemy.alert:getHeight()
end

function enemyScientist()
  local count = 1  
  for j = 0, 3, 1 do
    for i = 0, 2, 1 do
      enemyTipo[1].charQuads[count]=love.graphics.newQuad(i * 32, j * 40, 32, 40, enemyTipo[1].img:getWidth(),enemyTipo[1].img:getHeight())
      count = count + 1
    end
  end
end
function enemyScientist2()
  local count = 1  
  for j = 0, 3, 1 do
    for i = 0, 3, 1 do
      enemyTipo[2].charQuads[count]=love.graphics.newQuad(i * 31, j * 54, 31, 54, enemyTipo[2].img:getWidth(),enemyTipo[2].img:getHeight())
      count = count + 1
    end
  end
end
function enemyOldMan()
  local count = 1  
  for j = 0, 3, 1 do
    for i = 0, 2, 1 do
      enemyTipo[3].charQuads[count]=love.graphics.newQuad(i * 32, j * 65, 32, 65,enemyTipo[3].img:getWidth(),enemyTipo[3].img:getHeight())
      count = count + 1
    end
  end
end
function enemyBruce()
  local count = 1  
  for j = 0, 3, 1 do
    for i = 0, 3, 1 do
      enemyTipo[4].charQuads[count]=love.graphics.newQuad(i * 44, j * 45, 44, 45,enemyTipo[4].img:getWidth(),enemyTipo[4].img:getHeight())
      count = count + 1
    end
  end
end

function enemy.spawn(x,y,tipo,vx,vy)
	table.insert(enemy, {img=enemyTipo[tipo].img,x=x*size+upperTileX, y=y*size+upperTileY, xvel=vx*enemy.speed, yvel=vy*enemy.speed, health=enemyTipo[tipo].health, tipo=enemyTipo[tipo].AI, count=0, width=enemy.width, height=enemy.height,frame=1,frametime=0,invTime=0,boostTime=0,alert=love.audio.newSource("/Source/sounds/AlertSound.mp3"),alertTime=0,yAdjust=enemyTipo[tipo].yAdjust,downI=enemyTipo[tipo].downI, downF=enemyTipo[tipo].downF, leftI=enemyTipo[tipo].leftI, leftF=enemyTipo[tipo].leftF, rightI=enemyTipo[tipo].rightI, rightF=enemyTipo[tipo].rightF, upI=enemyTipo[tipo].upI, upF=enemyTipo[tipo].upF,disarm=love.audio.newSource("/Source/sounds/Disarm Sound.mp3"),ti=tipo})
end


function enemy.draw()
	love.graphics.setColor(255,255,255)
	for i,v in ipairs(enemy) do
		--love.graphics.rectangle('fill', v.x, v.y, enemyNb.width, enemyNb.height)
    if(v.invTime>0) then
      love.graphics.setColor(255,40,40)
      love.graphics.draw(v.img,enemyTipo[v.ti].charQuads[v.frame],v.x,v.y+v.yAdjust)
      love.graphics.setColor(255,255,255)
    else
      love.graphics.draw(v.img,enemyTipo[v.ti].charQuads[v.frame],v.x,v.y+v.yAdjust)
      love.graphics.setColor(255,40,40)
      --love.graphics.rectangle("line",v.x,v.y,enemy.width,enemy.height)
      love.graphics.setColor(255,255,255)
    end
    --love.graphics.print(v.xvel, v.x, v.y)
    --love.graphics.print(v.yvel, v.x, v.y+10)
    if v.alertTime>0 then
      love.graphics.draw(enemy.alert,v.x,v.y-size/2,0,enemy.alertfWidth,enemy.alertfHeight)
    end
	end
end

function enemy.update(dt)  --alterei o i e v
  for i,v in ipairs(enemy) do
    if v.invTime==0 then
      player_collision(v, v.tipo, i, dt)
      enemyAnimation(v,dt)
      if v.boostTime>0 then
        v.boostTime = v.boostTime - dt
        if v.boostTime>0 then
          v.xvel = enemy.speed*1.5*math.sign(v.xvel) v.yvel = enemy.speed*1.5*math.sign(v.yvel)
        else
          v.xvel = enemy.speed*math.sign(v.xvel) v.yvel = enemy.speed*math.sign(v.yvel)
        end
      end
    else
      update_invincibility(v,dt)
    end
    for j,w in ipairs(player) do
      if j>quantPlayer then
        break
      end
      if not w.dead then
        enemy_collision(v,w,j)
      end
    end
    if v.alertTime>0 then
      v.alertTime = v.alertTime - dt
    end
	end
end

function enemy_collision(v,player,i)
  if(player.x>v.x) then compx=v.width else compx=player.width end
  if(player.y>v.y) then compy=v.height else compy=player.height end
  
	if (math.abs(player.x - v.x)<= compx and
	math.abs(player.y - v.y)<= compy) and player.invTime==0 then
		player.x=initial.x[i]
		player.y=initial.y[i]
    player.life = player.life-1
    if player.life==0 then
      player.dead=true
      player.bombQuant=0
      if checkdead() then
        menu.tipo=1
        menu.show=true
        menu.status=true
        endTable(boss.shadow)
      end
    else
      player.invTime = invTime
    end
	end
 end