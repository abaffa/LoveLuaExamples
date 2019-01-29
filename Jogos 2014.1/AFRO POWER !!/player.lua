	require "fireball"
	require "arrow"
  require "icemagic"

	local atacando = false
	local atacar = 0 
	local dir = 1

	player = {}
	player.x = 50
	player.y = 290
	player.speed = 200
	player.jump = 0
player.class = 0
player.points = 0
player.vida = 1000
player.canjump = true
player.archerjump = 0

afroR = {}
afroR[1] = love.graphics.newImage('knight walk/normal/afroR.png')
afroR[2] = love.graphics.newImage('knight walk/normal/afro-walk1R.png')
afroR[3] = love.graphics.newImage('knight walk/normal/afro-walk2R.png')

afroL = {}
afroL[1] = love.graphics.newImage('knight walk/normal/afroL.png')
afroL[2] = love.graphics.newImage('knight walk/normal/afro-walk1L.png')
afroL[3] = love.graphics.newImage('knight walk/normal/afro-walk2L.png')

afroAR = {}
afroAR[1] = love.graphics.newImage('knight walk/normal/afro attack1R.png')
afroAR[2] = love.graphics.newImage('knight walk/normal/afro attack2R.png')
afroAR[3] = love.graphics.newImage('knight walk/normal/afro attack3R.png')

afroAL = {}
afroAL[1] = love.graphics.newImage('knight walk/normal/afro attack1L.png')
afroAL[2] = love.graphics.newImage('knight walk/normal/afro attack2L.png')
afroAL[3] = love.graphics.newImage('knight walk/normal/afro attack3L.png')

playerR = {}
playerR[1] = love.graphics.newImage('knight walk/knight/afro knightR.png')
playerR[2] = love.graphics.newImage('knight walk/knight/afro knight - walk 1R.png')
playerR[3] = love.graphics.newImage('knight walk/knight/afro knight - walk 2R.png')

playerL = {}
playerL[1] = love.graphics.newImage('knight walk/knight/afro knightL.png')
playerL[2] = love.graphics.newImage('knight walk/knight/afro knight - walk 1L.png')
playerL[3] = love.graphics.newImage('knight walk/knight/afro knight - walk 2L.png')

playerAR = {}
playerAR[1] = love.graphics.newImage('knight walk/knight/knight-atack1R.png')
playerAR[2] = love.graphics.newImage('knight walk/knight/knight-atack2R.png')
playerAR[3] = love.graphics.newImage('knight walk/knight/knight-atack3R.png')

playerAL = {}
playerAL[1] = love.graphics.newImage('knight walk/knight/knight-atack1L.png')
playerAL[2] = love.graphics.newImage('knight walk/knight/knight-atack2L.png')
playerAL[3] = love.graphics.newImage('knight walk/knight/knight-atack3L.png')

player.DR = love.graphics.newImage("knight walk/knight/afro knight defenseR.png")
player.DL = love.graphics.newImage("knight walk/knight/afro knight defenseL.png")

mageR = {}
mageR[1] = love.graphics.newImage('knight walk/mage/afro mageR.png')
mageR[2] = love.graphics.newImage('knight walk/mage/afro mage - walk 1R.png')
mageR[3] = love.graphics.newImage('knight walk/mage/afro mage- walk 2R.png')

mageL = {}
mageL[1] = love.graphics.newImage('knight walk/mage/afro mageL.png')
mageL[2] = love.graphics.newImage('knight walk/mage/afro mage - walk 1L.png')
mageL[3] = love.graphics.newImage('knight walk/mage/afro mage- walk 2L.png')

mageAR = {}
mageAR[1] = love.graphics.newImage('knight walk/mage/afro mage-attack1R.png')
mageAR[2] = love.graphics.newImage('knight walk/mage/afro mage-attack2R.png')
mageAR[3] = love.graphics.newImage('knight walk/mage/afro mage-attack3R.png')

mageAL = {}
mageAL[1] = love.graphics.newImage('knight walk/mage/afro mage-attack1L.png')
mageAL[2] = love.graphics.newImage('knight walk/mage/afro mage-attack2L.png')
mageAL[3] = love.graphics.newImage('knight walk/mage/afro mage-attack3L.png')

rangerR = {}
rangerR[1] = love.graphics.newImage('knight walk/ranger/afro rangerR.png')
rangerR[2] = love.graphics.newImage('knight walk/ranger/afro ranger - walk 1R.png')
rangerR[3] = love.graphics.newImage('knight walk/ranger/afro ranger - walk 2R.png')

rangerL = {}
rangerL[1] = love.graphics.newImage('knight walk/ranger/afro rangerL.png')
rangerL[2] = love.graphics.newImage('knight walk/ranger/afro ranger - walk 1L.png')
rangerL[3] = love.graphics.newImage('knight walk/ranger/afro ranger - walk 2L.png')

rangerAR = {}
rangerAR[1] = love.graphics.newImage('knight walk/ranger/afro ranger attack1R.png')
rangerAR[2] = love.graphics.newImage('knight walk/ranger/afro ranger attack2R.png')
rangerAR[3] = love.graphics.newImage('knight walk/ranger/afro ranger attack3R.png')

rangerAL = {}
rangerAL[1] = love.graphics.newImage('knight walk/ranger/afro ranger attack1L.png')
rangerAL[2] = love.graphics.newImage('knight walk/ranger/afro ranger attack2L.png')
rangerAL[3] = love.graphics.newImage('knight walk/ranger/afro ranger attack3L.png')

afrosobe = {}
afrosobe[1] = love.graphics.newImage("knight walk/normal/escalada.png")
afrosobe[2] = love.graphics.newImage("knight walk/normal/escalada2.png")

magesobe = {}
magesobe[1] = love.graphics.newImage("knight walk/mage/mage escalada.png")
magesobe[2] = love.graphics.newImage("knight walk/mage/mage escalada2.png")

knightsobe = {}
knightsobe[1] = love.graphics.newImage("knight walk/knight/knight escalada.png")
knightsobe[2] = love.graphics.newImage("knight walk/knight/knight escalada2.png")

rangersobe = {}
rangersobe[1] = love.graphics.newImage("knight walk/ranger/ranger escalada.png")
rangersobe[2] = love.graphics.newImage("knight walk/ranger/ranger escalada2.png")

afrodano = {}
afrodano[1] = love.graphics.newImage("knight walk/normal/dano.png")
afrodano[2] = love.graphics.newImage("knight walk/normal/dano2.png")

magedano = {}
magedano[1] = love.graphics.newImage("knight walk/mage/mage dano.png")
magedano[2] = love.graphics.newImage("knight walk/mage/mage dano2.png")

knightdano = {}
knightdano[1] = love.graphics.newImage("knight walk/knight/knight dano.png")
knightdano[2] = love.graphics.newImage("knight walk/knight/knight dano2.png")

rangerdano = {}
rangerdano[1] = love.graphics.newImage("knight walk/ranger/ranger dano.png")
rangerdano[2] = love.graphics.newImage("knight walk/ranger/ranger dano2.png")

player.animtimer = 0
player.pic = afroR[1]
player.num = 1
player_escada_num = 1
escada_animtimer = 0

function initialize()
	player.shape = Collider:addRectangle(player.x-40,player.y+60,player.pic:getWidth()/2+8,player.pic:getHeight())
  player.sword = Collider:addRectangle(player.x-10,player.y+80,20,40)
  Collider:setGhost(player.sword)
  --player.shape2 = Collider:addRectangle(player.x + 300,player.y,player.pic:getWidth(),player.pic:getHeight()+200)
end

function player.update(dt,mapa_configsize_y,mapa_configdisplay_y)
	if player.class == 1 then
		if love.keyboard.isDown("k") and dir == 1 then
			player.pic = player.DR
		end
		if love.keyboard.isDown("k") and dir == 2 then
			player.pic = player.DL
		end
	end
  if camera.y + player.jump*dt > 0 and  camera.y + player.jump*dt < mapa_configsize_y*23 - mapa_configdisplay_y*23 then
      camera.y = camera.y + player.jump*dt
  else
    player.shape:move(0,player.jump*dt)
    player.sword:move(0,player.jump*dt)
    player.y = player.y + player.jump*dt
  end
	player.jump = player.jump + 10

  
  if player_escada_num > 2 then
    player_escada_num = 1
  end
  if escada_animtimer > 0.1 then
		player_escada_num = player_escada_num + 1
	  escada_animtimer = 0
	end
	if love.keyboard.isDown('d') then
    player.sword:moveTo(player.x,player.y+100)
		dir = 1
		if atacando == false then 
			player.speed = 200
			if dir == 1 then 
				if player.x < (love.graphics.getWidth()/2) then
					player.x = player.x + player.speed * dt
					player.shape:move(player.speed*dt,0)
          player.sword:move(player.speed*dt,0)
				else
					camera.x = camera.x + player.speed * dt
					for i,v in ipairs(grama) do
						grama[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(undergroundt) do
						undergroundt[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(lagot) do
						lagot[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(pentet) do
						pentet[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(S_lagot) do
						S_lagot[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(helmt) do
						helmt[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(deathcapt) do
						deathcapt[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(rangercapt) do
						rangercapt[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(enemie1t) do
						enemie1t[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(enemie2t) do
						enemie2t[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(enemie3t) do
						enemie3t[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(enemie4t) do
						enemie4t[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(enemie5t) do
						enemie5t[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(armadilhat) do
						armadilhat[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(cogumelot) do
						cogumelot[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(plataformat) do
						plataformat[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(espinhost) do
						espinhost[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(escadat) do
						escadat[v]:move(-player.speed*dt,0)
					end
					for i,v in ipairs(pedrat) do
						pedrat[v]:move(-player.speed*dt,0)
					end
          for i,v in ipairs(portafogot) do
            portafogot[v]:move(-player.speed*dt,0)
          end
          for i,v in ipairs(portagelot) do
            portagelot[v]:move(-player.speed*dt,0)
          end
          for i,v in ipairs(miniboss1t) do
            miniboss1t[v]:move(-player.speed*dt,0)
          end
          for i,v in ipairs(miniboss2t) do
            miniboss2t[v]:move(-player.speed*dt,0)
          end
          for i,v in ipairs(miniboss3t) do
            miniboss3t[v]:move(-player.speed*dt,0)
          end
				end
				if player.class == 0 then
					player.pic = afroR[player.num]
				elseif player.class == 1 then
					player.pic = playerR[player.num]
				elseif player.class == 2 then
					player.pic = mageR[player.num]
				elseif player.class == 3 then
					player.pic = rangerR[player.num]
				end
				player.animtimer = player.animtimer + dt
				if player.animtimer > 0.1 then
					player.num = player.num + 1
					player.animtimer = 0
				end
				if player.num > 3 then
					player.num = 1
				end
			end
		end
	end
	if love.keyboard.isDown('a') then
    player.sword:moveTo(player.x - 40,player.y+100)
		if atacando == false then 
			dir = 2
			player.speed = 200
			if player.x > (300) then
				player.x = player.x - player.speed * dt  
				player.shape:move(-player.speed*dt,0)
        player.sword:move(-player.speed*dt,0)
			elseif camera.x > 20 then
				camera.x = camera.x - player.speed * dt
				for i,v in ipairs(grama) do
					grama[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(undergroundt) do
					undergroundt[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(lagot) do
					lagot[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(pentet) do
					pentet[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(S_lagot) do
					S_lagot[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(helmt) do
					helmt[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(deathcapt) do
					deathcapt[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(rangercapt) do
					rangercapt[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(enemie1t) do
					enemie1t[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(enemie2t) do
					enemie2t[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(enemie3t) do
					enemie3t[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(enemie4t) do
					enemie4t[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(enemie5t) do
					enemie5t[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(armadilhat) do
					armadilhat[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(cogumelot) do
					cogumelot[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(plataformat) do
					plataformat[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(espinhost) do
					espinhost[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(escadat) do
					escadat[v]:move(player.speed*dt,0)
				end
				for i,v in ipairs(pedrat) do
					pedrat[v]:move(player.speed*dt,0)
				end 
        for i,v in ipairs(portafogot) do
          portafogot[v]:move(player.speed*dt,0)
        end
        for i,v in ipairs(portagelot) do
          portagelot[v]:move(player.speed*dt,0)
        end
        for i,v in ipairs(miniboss1t) do
          miniboss1t[v]:move(player.speed*dt,0)
        end
        for i,v in ipairs(miniboss2t) do
          miniboss2t[v]:move(player.speed*dt,0)
        end
        for i,v in ipairs(miniboss3t) do
          miniboss3t[v]:move(player.speed*dt,0)
        end
			end
			if player.class == 0 then
				player.pic = afroL[player.num]
			elseif player.class == 1 then
				player.pic = playerL[player.num]
			elseif player.class == 2 then
				player.pic = mageL[player.num]
			elseif player.class == 3 then
				player.pic = rangerL[player.num]
			end
			player.animtimer = player.animtimer + dt
			if player.animtimer > 0.1 then
				player.num = player.num + 1
				player.animtimer = 0
			end
			if player.num > 3 then
				player.num = 1
			end
		end
	end

	if atacar == 1 then
		if player.class == 0 then
			player.pic = afroAR[player.num]
		elseif player.class == 1 then
			player.pic = playerAR[player.num]
		elseif player.class == 2 then
			player.pic = mageAR[player.num]
		elseif player.class == 3 then
			player.pic = rangerAR[player.num]
		end
		player.animtimer = player.animtimer + dt
		if player.animtimer > 0.1 then
			player.num = player.num + 1
			player.animtimer = 0
		end
		if player.num > 3 then
			player.num = 1
			if player.class == 0 then
				player.pic = afroR[player.num]
        
			elseif player.class == 1 then
				player.pic = playerR[player.num]
        Collider:setGhost(player.sword)
			elseif player.class == 2 then
				player.pic = mageR[player.num]
			elseif player.class == 3 then
				player.pic = rangerR[player.num]
			end
			atacar = 0
			atacando = false
		end
	end
	if atacar == 2 then
		if player.class == 0 then
			player.pic = afroAL[player.num]
		elseif player.class == 1 then
			player.pic = playerAL[player.num]
      
		elseif player.class == 2 then
			player.pic = mageAL[player.num]
		elseif player.class == 3 then
			player.pic = rangerAL[player.num]
		end
		player.animtimer= player.animtimer + dt
		if player.animtimer > 0.1 then
			player.num = player.num + 1
			player.animtimer = 0
		end
		if player.num > 3 then
			player.num = 1
			if player.class == 0 then
				player.pic = afroL[player.num]
			elseif player.class == 1 then
				player.pic = playerL[player.num]
        Collider:setGhost(player.sword)
			elseif player.class == 2 then
				player.pic = mageL[player.num]
			elseif player.class == 3 then
				player.pic = rangerL[player.num]
			end
			atacar = 0
			atacando = false
		end
	end
	map_collide()
end
function map_collide()
	if player.x < 0 then
		player.x = 0
	end
end

function player.animreset(key)
	if key == 'd' then
		player.animtimer = 0
		player.num = 1
		if player.class == 0 then
			player.pic = afroR[1]
		elseif player.class == 1 then
			player.pic = playerR[1]
      
		elseif player.class == 2 then
			player.pic = mageR[1]
		elseif player.class == 3 then
			player.pic = rangerR[1]
		end
	end
	if key == 'a' then
		player.animtimer = 0
		player.num = 1
		if player.class == 0 then
			player.pic = afroL[1]
			if player.class == 1 then
				player.pic = playerL[1]
			elseif player.class == 2 then
				player.pic = mageL[1]
			elseif player.class == 3 then
				player.pic = rangerL[1]
			end
		end
	end
end

function player.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(player.pic,player.x ,player.y+120, 0, 1, 1, player.pic:getWidth(), player.pic:getHeight())
  --player.sword:draw('line')
  --player.shape2:draw('line')
end

function love.keypressed(key)
	if atacando == false then
		if key == 'j' and dir == 1 then
			atacar = 1
			player.speed = 0
			player.num = 1
			atacando = true
			if player.class == 0 then
				rock.spawn(player.x - 3, player.y + 90,1)
      elseif player.class == 1 then
        player.sword.type = 'fireball'
        Collider:setSolid(player.sword)
			elseif player.class == 2 then
				fireball.spawn(player.x, player.y +90,1)
			elseif player.class == 3 then
				arrow.spawn(player.x , player.y + 100,1)
			end
		end
	end
	if atacando == false then
		if key == 'j' and dir == 2 then
			atacar = 2
			player.speed = 0
			player.num = 1
			atacando = true
			if player.class == 0 then
				rock.spawn(player.x -13, player.y + 90,-1)
       elseif player.class == 1 then
        player.sword.type = 'fireball'
        Collider:setSolid(player.sword)
			elseif player.class == 2 then
				fireball.spawn(player.x -50 , player.y + 90,-1)
			elseif player.class == 3 then
				arrow.spawn(player.x -50 , player.y + 103,-1)
			end
		end	
	end
  if atacando == false and player.class == 2 then
    if key == 'k' and dir == 1 then
      atacar = 1 
      player.speed = 0
      player.num = 1
      atacando = true
      icemagic.spawn(player.x, player.y + 90,1)
    end
  end
  if atacando == false and player.class == 2 then
    if key == 'k' and dir == 2 then
      atacar = 2 
      player.speed = 0
      player.num = 1
      atacando = true
      icemagic.spawn(player.x-50, player.y + 90,-1)
    end 
  end
	if key == 'w' then
		if atacando == false and player.canjump == true then 
				pular()
		end
	end
end

function pular()
  player.shape:move(0,-2)
  player.sword:move(0,-2)
	player.y = player.y - 2
  player.jump = -700
  if player.class ~= 3 then
  player.canjump = false
  elseif player.class == 3 then
  player.archerjump = player.archerjump + 1
    if player.archerjump == 2 then 
      player.canjump = false
      player.archerjump = 0
    end
  end
end
  