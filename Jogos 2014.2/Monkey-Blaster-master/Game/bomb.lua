--bomb.lua

bomb = {}
bomb.aumento = 1.2
bomb.decre=10
bomb.size=size-bomb.decre

function bomb.load()
  for i,v in ipairs(player) do
    v.bombLimit = 1
    v.bombPower=2
    v.bombQuant=0
  end
end

bomb.image = love.graphics.newImage("/Source/BananasSprite.png")
bomb.width = (size-bomb.decre)/bomb.image:getWidth()  -- bomb.width nao seria de fato o tamanho, mas o fator de escala necessario para fazer o tamanho ser 20
bomb.height = (size-bomb.decre)/bomb.image:getHeight()  -- idem para bomb.height

bomb.explosion = love.graphics.newImage("/Source/explosion01.png")
bomb.expWidth = size/bomb.explosion:getWidth()
bomb.expHeight = size/bomb.explosion:getHeight()

function bomb.control(dt)
	bomb.update(dt)
end

function checkArea(procx,procy)  --checa se no espaco ja tem bombas
	for i,v in ipairs(bomb) do
		if (procx==v.gridx and procy==v.gridy) then
			return false
		end
	end
	return true
end

function putBomb(key,j)
  if j~=nil then
    local id=joy.search(j)
    if not player[id].dead then
      bomb.spawn(player[id], player[id].centerx, player[id].centery, id)
    end
  else
    for i,v in ipairs(player) do
      if i>quantPlayer then
        break
      else
        if key == v.b then
          if not v.dead then
            bomb.spawn(v,v.centerx, v.centery,i)
          end
          return
        end
      end
    end
  end
end

function bomb.spawn(player,x,y,i)
	if(player.bombQuant<player.bombLimit) then
		gridx,gridy=check_grid_position(x,y)
		gridx=upperTileX+gridx*size
		gridy=upperTileY+gridy*size
		if checkArea(gridx, gridy) then
			x=gridx+bomb.decre/2
			y=gridy+bomb.decre/2
			table.insert(bomb,{x=x, y=y, gridx=gridx, gridy=gridy, time=3, explode=false, power=player.bombPower, expSound=love.audio.newSource("/Source/Grenade.mp3"), ind=i})
			temp = love.audio.newSource("/Source/Down.mp3")
			love.audio.play(temp)
			player.bombQuant = player.bombQuant+1
			changeCollision(gridx,gridy,3,0)  --Transpassibilidade da banana
		end
	end
end

function bomb.update(dt)
	for i,v in ipairs(bomb) do
		v.time = v.time - dt
		if(v.time<=0) then
			if(not v.explode) then
				love.audio.play(v.expSound)
				v.explode=true
				v.time=1
        for h,j in ipairs(joy) do
          if not player[h].dead then
            j:setVibration(1,1,1)
          end
        end
				changeCollision(v.gridx,v.gridy,2,v.power) --Transpassibilidade da explosao
        if v.ind~=0 then
          player[v.ind].bombQuant = player[v.ind].bombQuant-1
        end
      else
				changeCollision(v.gridx,v.gridy,0,v.power) -- Remoçao do efeito ao fim da explosao
				table.remove(bomb, i)
			end
		end
	end
end

function changeCollision(x,y,action,dist)
	x = math.floor(x)
  y = math.floor(y)
	for i=0, size-1 do
		for j=0, size-1 do
			checkCollision(x+i,y+j,action,true)
		end
	end
	--for k=size, dist*size, size do    --MODELO ANTIGO MAIS EFICIENTE - TIVE QUE MUDAR PARA TER UM BREAK NA EXPLOSAO
		--for i=0, size do               --ASSIM QUE FOR PASSAR POR UM BLOCO FORTE (BREAK É FEITO PELO RETURN +ABAIXO)
			--for j=0, size do
				--checkCollision(x+k+i,y+j,action)
				--checkCollision(x-k+i,y+j,action)
				--checkCollision(x+j,y+k+i,action)
				--checkCollision(x+j,y-k+i,action)
			--end
		--end
	--end
  doCollision(x,y,1,0,action,dist)
  doCollision(x,y,-1,0,action,dist)
  doCollision(x,y,0,1,action,dist)
  doCollision(x,y,0,-1,action,dist)
end

function doCollision(x,y,a,b,action,dist) --a,b = 0/1
  for k=size, dist*size, size do
		for i=0, size-1 do
			for j=0, size-1 do
        if(not checkCollision(x+a*k+i,y+b*k+j,action,false)) then return end --return encerra a iteracao com bloco forte
      end
    end
  end
end

function checkCollision(x,y,action,home)  -- posicao de grid x, posicao de grid y, acao no bloco e se alteracao e no bloco da banana
  if(solidb[x][y]==1) then  --temos bloco forte
    return false
  elseif(solidb[x][y]==4 or solidb[x][y]==5) then  --destroy destructible or destroy red destructible
    a,b=check_grid_position(x,y)
    if(action==2) then
      change_maze_space(a,b,5)  --deixa bloco vermelho
    else
      change_maze_space(a,b,0)  --remove de vez bloco
      powerUp.generate(a*size+upperTileX,b*size+upperTileY)
    end
    return false
  elseif(solidb[x][y]==3 and not home) then --se atingir uma banana
    --search_bomb(x,y).time=0
    v,i=search_item(x,y,bomb)
    if v~=nil then
      v.time = v.time/4  --uma bomba acertou outra e reduziu seu tempo de explosão
    end
    return false
  elseif(solidb[x][y]==6) then   --CERTO
    if(action==2) then
      change_space(x,y,7)
    end
    return false;
  elseif(solidb[x][y]==7) then
    if(action~=2) then
      v,i=search_item(x,y,powerUp)
      change_space(x,y,0)
      table.remove(powerUp,i)
    end
    return false
  else            --temos nada
    solidb[x][y]=action
    return true
  end
end

function bomb.draw()
	for i,v in ipairs(bomb) do
		if(not v.explode) then
			if(v.time-math.floor(v.time)>0.5) then
				love.graphics.draw(bomb.image, v.x, v.y, 0, bomb.width, bomb.height)  --2 ultimos dados fatores de escala
			else
				love.graphics.draw(bomb.image, v.x-(bomb.aumento-1)*bomb.size/2, v.y-(bomb.aumento-1)*bomb.size/2, 0, bomb.width*bomb.aumento, bomb.height*bomb.aumento) --formula para reposicionamento para satisfazer aumento
			end
		else
			bomb.drawExp(v.gridx,v.gridy,v.power)
		end
	end
end

function bomb.drawExp(x,y,dist)
	love.graphics.draw(bomb.explosion, x, y, 0, bomb.expWidth, bomb.expHeight)
  bomb.drawExpCheck(x,y,-1,0,dist) --AQUI TAMBEM HOUVE A MUDANCA INEFICIENTE PARA DAR CONTA DA EXPLOSAO
  bomb.drawExpCheck(x,y,1,0,dist)
  bomb.drawExpCheck(x,y,0,-1,dist)
  bomb.drawExpCheck(x,y,0,1,dist)
end

function bomb.drawExpCheck(px,py,a,b,dist)
  for i=1, dist do
    px=px+a*size py=py+b*size
    if(solidb[px][py]~=0 and solidb[px][py]~=2) then return end  --E AQUI O RETURN QUE ENCERRA O DRAW
		love.graphics.draw(bomb.explosion, px, py, 0, bomb.expWidth, bomb.expHeight)
  end
end

function bomb.kill(obj, tipo, i)
	if(tipo==0) then
		obj.x = initial.x[i]
		obj.y = initial.y[i]
		obj.life = obj.life-1
    if obj.life==0 then
      obj.dead=true
      if tipo==0 then reset(obj) end
      if checkdead() then
        love.audio.stop(music)
        love.audio.play(audio.menu)
        menu.tipo=1
        gamestandby=true
      end
    else
      obj.invTime = invTime
    end
	else
		if(obj.health>1) then
			obj.health = obj.health-1
			obj.invTime = enemy.invTime
      if obj.health==5 then
        boss.hurt=true
      end
		else
      if tipo==10 then
        boss.dead=true
      else
        table.remove(enemy, i)
        maze.enemyTotal = maze.enemyTotal - 1
      end
		end
	end
end