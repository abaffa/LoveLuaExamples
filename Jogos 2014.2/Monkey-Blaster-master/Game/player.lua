width = love.graphics.getWidth
height = love.graphics.getHeight
player = {}
invTime=3
quantPlayer = 4
controls= {}
 
function player.infoLoad()
  heroLeft = {}
  heroRight = {}
  heroUp = {}
  heroDown = {}
  hero={}
  for i=1, 4 do
    heroLeft[i]={}
    heroRight[i]={}
    heroUp[i]={}
    heroDown[i]={}
  end
  player.heart = love.graphics.newImage("/Source/heart.png")
  player.heartWidth = player.heart:getWidth()
  player.heartHeight = player.heart:getHeight()
	heroLeft[1][1]  = love.graphics.newImage("/Source/Monkey/monkeyleft1.png")
	heroLeft[1][2]  = love.graphics.newImage("/Source/Monkey/monkeyleft2.png")
	heroLeft[1][3]  = love.graphics.newImage("/Source/Monkey/monkeyleft3.png")
	heroLeft[1][4]  = love.graphics.newImage("/Source/Monkey/monkeyleft4.png")
	heroLeft[1][5]  = love.graphics.newImage("/Source/Monkey/monkeyleft5.png")
	heroRight[1][1] = love.graphics.newImage("/Source/Monkey/monkeyright1.png")
	heroRight[1][2] = love.graphics.newImage("/Source/Monkey/monkeyright2.png")
	heroRight[1][3] = love.graphics.newImage("/Source/Monkey/monkeyright3.png")
	heroRight[1][4] = love.graphics.newImage("/Source/Monkey/monkeyright4.png")
	heroRight[1][5] = love.graphics.newImage("/Source/Monkey/monkeyright5.png")
	heroDown[1][1]  = love.graphics.newImage("/Source/Monkey/monkeydown1.png")
	heroDown[1][2]  = love.graphics.newImage("/Source/Monkey/monkeydown2.png")
	heroDown[1][3]  = love.graphics.newImage("/Source/Monkey/monkeydown3.png")
	heroDown[1][4]  = love.graphics.newImage("/Source/Monkey/monkeydown4.png")
	heroDown[1][5]  = love.graphics.newImage("/Source/Monkey/monkeydown5.png")
	heroUp[1][1] = love.graphics.newImage("/Source/Monkey/monkeyup1.png")
	heroUp[1][2] = love.graphics.newImage("/Source/Monkey/monkeyup2.png")
	heroUp[1][3] = love.graphics.newImage("/Source/Monkey/monkeyup3.png")
	heroUp[1][4] = love.graphics.newImage("/Source/Monkey/monkeyup4.png")
	heroUp[1][5] = love.graphics.newImage("/Source/Monkey/monkeyup5.png")
  heroLeft[2][1]  = love.graphics.newImage("/Source/Monkey2/apeleft1.png")
	heroLeft[2][2]  = love.graphics.newImage("/Source/Monkey2/apeleft2.png")
	heroLeft[2][3]  = love.graphics.newImage("/Source/Monkey2/apeleft3.png")
	heroLeft[2][4]  = love.graphics.newImage("/Source/Monkey2/apeleft4.png")
	heroLeft[2][5]  = love.graphics.newImage("/Source/Monkey2/apeleft5.png")
	heroRight[2][1] = love.graphics.newImage("/Source/Monkey2/aperight1.png")
	heroRight[2][2] = love.graphics.newImage("/Source/Monkey2/aperight2.png")
	heroRight[2][3] = love.graphics.newImage("/Source/Monkey2/aperight3.png")
	heroRight[2][4] = love.graphics.newImage("/Source/Monkey2/aperight4.png")
	heroRight[2][5] = love.graphics.newImage("/Source/Monkey2/aperight5.png")
	heroDown[2][1]  = love.graphics.newImage("/Source/Monkey2/apedown1.png")
	heroDown[2][2]  = love.graphics.newImage("/Source/Monkey2/apedown2.png")
	heroDown[2][3]  = love.graphics.newImage("/Source/Monkey2/apedown3.png")
	heroDown[2][4]  = love.graphics.newImage("/Source/Monkey2/apedown4.png")
	heroDown[2][5]  = love.graphics.newImage("/Source/Monkey2/apedown5.png")
	heroUp[2][1] = love.graphics.newImage("/Source/Monkey2/apeup1.png")
	heroUp[2][2] = love.graphics.newImage("/Source/Monkey2/apeup2.png")
	heroUp[2][3] = love.graphics.newImage("/Source/Monkey2/apeup3.png")
	heroUp[2][4] = love.graphics.newImage("/Source/Monkey2/apeup4.png")
	heroUp[2][5] = love.graphics.newImage("/Source/Monkey2/apeup5.png")
  heroLeft[3][1]  = love.graphics.newImage("/Source/Monkey3/chimpleft1.png")
	heroLeft[3][2]  = love.graphics.newImage("/Source/Monkey3/chimpleft2.png")
	heroLeft[3][3]  = love.graphics.newImage("/Source/Monkey3/chimpleft3.png")
	heroLeft[3][4]  = love.graphics.newImage("/Source/Monkey3/chimpleft4.png")
	heroLeft[3][5]  = love.graphics.newImage("/Source/Monkey3/chimpleft5.png")
	heroRight[3][1] = love.graphics.newImage("/Source/Monkey3/chimpright1.png")
	heroRight[3][2] = love.graphics.newImage("/Source/Monkey3/chimpright2.png")
	heroRight[3][3] = love.graphics.newImage("/Source/Monkey3/chimpright3.png")
	heroRight[3][4] = love.graphics.newImage("/Source/Monkey3/chimpright4.png")
	heroRight[3][5] = love.graphics.newImage("/Source/Monkey3/chimpright5.png")
	heroDown[3][1]  = love.graphics.newImage("/Source/Monkey3/chimpdown1.png")
	heroDown[3][2]  = love.graphics.newImage("/Source/Monkey3/chimpdown2.png")
	heroDown[3][3]  = love.graphics.newImage("/Source/Monkey3/chimpdown3.png")
	heroDown[3][4]  = love.graphics.newImage("/Source/Monkey3/chimpdown4.png")
	heroDown[3][5]  = love.graphics.newImage("/Source/Monkey3/chimpdown5.png")
	heroUp[3][1] = love.graphics.newImage("/Source/Monkey3/chimpup1.png")
	heroUp[3][2] = love.graphics.newImage("/Source/Monkey3/chimpup2.png")
	heroUp[3][3] = love.graphics.newImage("/Source/Monkey3/chimpup3.png")
	heroUp[3][4] = love.graphics.newImage("/Source/Monkey3/chimpup4.png")
	heroUp[3][5] = love.graphics.newImage("/Source/Monkey3/chimpup5.png")
  heroLeft[4][1]  = love.graphics.newImage("/Source/Monkey4/macacoleft1.png")
	heroLeft[4][2]  = love.graphics.newImage("/Source/Monkey4/macacoleft2.png")
	heroLeft[4][3]  = love.graphics.newImage("/Source/Monkey4/macacoleft3.png")
	heroLeft[4][4]  = love.graphics.newImage("/Source/Monkey4/macacoleft4.png")
	heroLeft[4][5]  = love.graphics.newImage("/Source/Monkey4/macacoleft5.png")
	heroRight[4][1] = love.graphics.newImage("/Source/Monkey4/macacoright1.png")
	heroRight[4][2] = love.graphics.newImage("/Source/Monkey4/macacoright2.png")
	heroRight[4][3] = love.graphics.newImage("/Source/Monkey4/macacoright3.png")
	heroRight[4][4] = love.graphics.newImage("/Source/Monkey4/macacoright4.png")
	heroRight[4][5] = love.graphics.newImage("/Source/Monkey4/macacoright5.png")
	heroDown[4][1]  = love.graphics.newImage("/Source/Monkey4/macacodown1.png")
	heroDown[4][2]  = love.graphics.newImage("/Source/Monkey4/macacodown2.png")
	heroDown[4][3]  = love.graphics.newImage("/Source/Monkey4/macacodown3.png")
	heroDown[4][4]  = love.graphics.newImage("/Source/Monkey4/macacodown4.png")
	heroDown[4][5]  = love.graphics.newImage("/Source/Monkey4/macacodown5.png")
	heroUp[4][1] = love.graphics.newImage("/Source/Monkey4/macacoup1.png")
	heroUp[4][2] = love.graphics.newImage("/Source/Monkey4/macacoup2.png")
	heroUp[4][3] = love.graphics.newImage("/Source/Monkey4/macacoup3.png")
	heroUp[4][4] = love.graphics.newImage("/Source/Monkey4/macacoup4.png")
	heroUp[4][5] = love.graphics.newImage("/Source/Monkey4/macacoup5.png")
  speed= 80*size/35
  for i=1, quantPlayer do
    player[i]={}
    controls[i]={}
  end
  --player[1].right='d'
  --player[1].left='a'
  --player[1].up='w'
  --player[1].down='s'
  --player[1].b=' '
  controls[1].right='d'
  controls[1].left='a'
  controls[1].up='w'
  controls[1].down='s'
  controls[1].b=' '
  controls[2].right='right'
  controls[2].left='left'
  controls[2].up='up'
  controls[2].down='down'
  controls[2].b='p'
  for i=joy.count+1,quantPlayer do
    player[i].right=controls[i-joy.count].right
    player[i].left=controls[i-joy.count].left
    player[i].up=controls[i-joy.count].up
    player[i].down=controls[i-joy.count].down
    player[i].b=controls[i-joy.count].b
  end
end 

 function player.load(player,ind)
	player.life=3 --Quantidade de vidas
  player.dead=false
	--player.invSet=false  --invencibilidade (power-up ou on-hit)
	player.invTime=0  --pode ser usado sozinho sem o set(sugestão)
  player.x=initial.x[ind]
  player.y=initial.y[ind]
	player.xvel = 0
	player.yvel = 0
	--player.speed = 20
	player.speed= speed
	player.friction = 10
	player.cont=0
	player.animate=3
	player.yAdjust=-10
  player.xAdjust=-5
  player.decre=5
  player.size=0.72*size
  player.tipo=0
  player.width = player.size*0.8
	player.height = (player.size+player.yAdjust)*0.9
  player.fWidth = player.size/heroDown[ind][2]:getWidth()
  player.fHeight = player.size/heroDown[ind][2]:getHeight()
  player.centerx = player.x+player.width/2
	player.centery = player.y+player.height/2
	hero[ind] = heroDown[ind][player.animate]
  if versus then
    player.life=1
  end
 end
 
 function player_draw()
  w=love.graphics.getWidth()
  h=love.graphics.getHeight()
  for i,v in ipairs(player) do
    if i>quantPlayer then
      break
    end
    if not v.dead then
      if(v.invTime>0) then
        love.graphics.setColor(255,40,40)
        love.graphics.draw(hero[i], v.x+v.xAdjust, v.y+v.yAdjust, 0, v.fWidth, v.fHeight)
        love.graphics.setColor(255,255,255)
      else
        love.graphics.draw(hero[i], v.x+v.xAdjust, v.y+v.yAdjust, 0, v.fWidth, v.fHeight)
      end
    end
    showInterface(v,i,w,h)
  end
end
   
function showInterface(v,i,w,h)
  if i==1 then
    ix=upperTileX/2
    iy=upperTileY
  elseif i==2 then
    ix=(finalX+w)/2
    iy=upperTileY
  elseif i==3 then
    ix=upperTileX/2
    iy=finalY-2*size
  elseif i==4 then
    ix=(finalX+w)/2
    iy=finalY-2*size
  end
  love.graphics.draw(hero[i], ix, iy, 0, v.fWidth, v.fHeight)
  for z=1, v.life do
    love.graphics.draw(player.heart, ix-z*size, iy+size, 0, size/player.heartWidth, size/player.heartHeight)
  end
end
   
function player_control(dt)
  for i,v in ipairs(player) do
    if i>quantPlayer then
      break
    end
    if not v.dead then
      player_animation(v,i,dt)
      player_collision(v, 0, i, dt)
      v.centerx=v.x+v.width/2
      v.centery=v.y+v.height/2
      --player.xvel = player.xvel * (1 - math.min(dt*player.friction, 1))
      --player.yvel = player.yvel * (1 - math.min(dt*player.friction, 1))
      if joy[i]~=nil then
        v.xvel = joy[i]:getGamepadAxis("leftx")*v.speed
        v.yvel = joy[i]:getGamepadAxis("lefty")*v.speed
      else
        if love.keyboard.isDown(v.right) then
          v.xvel = v.speed
        else if love.keyboard.isDown(v.left) then
          v.xvel =  -1* v.speed
          else
            v.xvel = 0
          end
        end
        if love.keyboard.isDown(v.down) then
          v.yvel = v.speed
        else if love.keyboard.isDown(v.up) then
          v.yvel =  -1* v.speed
          else
            v.yvel = 0
          end
        end
      end
      update_invincibility(v, dt)
        if not versus and fase~=lastFase then
          check_portal(v)
        end
    end
  end
end

function player_animation(player,ind,dt)
	
	--if love.keyboard.isDown(player.right) or love.keyboard.isDown(player.left) or love.keyboard.isDown(player.down) or love.keyboard.isDown(player.up) then
  if player.xvel~=0 or player.yvel ~=0 then
		player.cont = player.cont+dt
		if player.cont>0.26 then
			player.cont = 0
			player.animate = player.animate+1
			if player.animate > 5 then
				player.animate = 1
			end
		end
		--if love.keyboard.isDown(player.right) then
    if player.xvel>0 then
			hero[ind] = heroRight[ind][player.animate]
		--elseif love.keyboard.isDown(player.left) then
    elseif player.xvel<0 then
			hero[ind] = heroLeft[ind][player.animate]
		--elseif love.keyboard.isDown(player.up) then
    else if player.yvel<0 then
		  hero[ind] = heroUp[ind][player.animate]
		elseif player.yvel>0 then
			hero[ind] = heroDown[ind][player.animate]
      end
		end
	end
end

function player_collision(obj, tipo, indice,dt)
	inv=0
  
  if(obj.xvel~=0 or tipo==0)then
   --SCAN PARA MOVIMENTO
    z=math.sign(obj.xvel)
    check1 = solidb[math.floor(obj.x + obj.width/2 + obj.width/2*z + obj.xvel*dt)][math.floor(obj.y)]
    check2 = solidb[math.floor(obj.x + obj.width/2 + obj.width/2*z + obj.xvel*dt)][math.floor(obj.y+obj.height)]
    if(obj.x + obj.width/2 + obj.width/2*z + obj.xvel*dt < finalX and obj.x + obj.width/2 + obj.width/2*z + obj.xvel*dt > upperTileX) then
      if((check1 == 0 or check1 == 6) and (check2 == 0 or check2 == 6)) then
        moveX(obj,dt)
      else
        if(check1 == 2 or check2 == 2) then
          moveX(obj,dt)
          if(obj.invTime==0) then
            bomb.kill(obj, tipo, indice)
            return
          end
        else
          if(check1 == 3 or check2 == 3)and(tipo==0) then
            if(check_placement(obj.centerx,obj.centery,bomb)) then
              moveX(obj,dt)
            end
          else
            inv=1
          end
        end
      end
    else
      inv=1
    end
    if inv~=0 and tipo ~=0 then
      --obj.x=obj.x-(obj.x+obj.width/2-upperTileX)%size
      obj.x=getXposition(obj.x+obj.width/2)*size+upperTileX
    end
  end

  Tinv=inv
  inv=0
  if(obj.yvel~=0 or tipo==0)then
    --scan movimento
    z=math.sign(obj.yvel)
    check1 = solidb[math.floor(obj.x)][math.floor(obj.y + obj.height/2 + obj.height/2*z + obj.yvel*dt)]
    check2 = solidb[math.floor(obj.x+obj.width)][math.floor(obj.y + obj.height/2 + obj.height/2*z + obj.yvel*dt)]
    if(obj.y + obj.height/2 + obj.height/2*z + obj.yvel*dt < finalY and obj.y + obj.height/2 + obj.height/2*z + obj.yvel*dt > upperTileY) then
      if((check1 == 0 or check1 == 6) and (check2 == 0 or check2 == 6)) then
        moveY(obj,dt)
      else
        if(check1 == 2 or check2 == 2) then
          moveY(obj,dt)
          if(obj.invTime==0) then
            bomb.kill(obj, tipo, indice)
          end
        else
          if(check1 == 3 or check2 == 3)and(tipo==0) then
            if(check_placement(obj.centerx,obj.centery,bomb)) then
              moveY(obj,dt)
            end
          else
            inv=1
          end
        end
      end
    else
      inv=1
    end
    if inv~=0 and tipo ~=0 then
      obj.y=getYposition(obj.y+obj.height/2)*size+upperTileY
    end
  end
	
  Tinv=Tinv+inv
  --verificar jogador mais proximo
  
  if tipo~=0 then
    jorge=nearest_player(obj)
    IA(obj,tipo,Tinv,jorge)
  end
	
end

function moveX(obj,dt)
  if(obj.tipo==0)then
        obj.x = obj.x + obj.xvel*dt
  else
    newPos=obj.x+obj.xvel*dt
    if(obj.xvel>0)then
      canto=getXposition(newPos)*size+upperTileX
    else
      canto=getXposition(obj.x)*size+upperTileX
    end
    if math.abs(newPos-canto)<math.abs(obj.xvel*dt) then
      obj.x = canto
      HAHA=HAHA+1
    else
      obj.x = newPos
    end
  end
end
function moveY(obj,dt)
  if(obj.tipo==0)then
    obj.y = obj.y + obj.yvel*dt
  else
    newPos=obj.y+obj.yvel*dt
    if(obj.yvel>0)then
      canto=getYposition(newPos)*size+upperTileY
    else
      canto=getYposition(obj.y)*size+upperTileY
    end
    if math.abs(newPos-canto)<math.abs(obj.yvel*dt) then
      obj.y = canto
      HUEHUE=HUEHUE+1
    else
      obj.y = newPos
    end
  end
end

function math.sign(number)
	if(number<0) then
		return -1
	elseif(number>0) then
		return 1
  else
    return 0
	end
end

function check_portal(p)
  if maze.enemyTotal==0 then
    if p.centerx>exit.x and p.centerx<exit.x+size then
      if p.centery>exit.y and p.centery<exit.y+size then
        --Rodar animação, dar um tempo, mostrar textor, etc
        pausePortal = 2
        love.audio.play(audio.portal)
      end
    end
  end
end