player = {}

function player.load()
	-- player width (largura)
	player.w = 30*2.5
	-- player height (altura)
	player.h = 39*2.5
	-- player x coordinate (coordenada x)
	player.x = 200
	-- player y coordinate (coordenada y)
	player.y = 500-player.h
	-- player speed (velocidade)
	player.s = 200
	-- player velocity (aceleração)
	player.v = 0
	-- player jump height (altura do pulo)
	player.j = -500
	-- player gravity (gravidade)
	player.g = -800
	-- player side (lado)
	player.l = "r"
  -- player scale
  player.scale = 2.5
  -- player direction
   player.dir = 1

	-- vida do player
	player.life = 5
  -- imagem do player
  --player.image_parado = love.graphics.newImage("images/jogador/CorpoParado_01.png")
  --
  -- player centro x
  --player.centrox = player.image_parado:getWidth()/2
  
  -- player centro y
  --player.centroy = player.image_parado:getHeight()/2
  player.state = "walk"
  player.count = 0
  player.animado = {}
  player.animtiro = {}

  player.time = 0
  player.move = false
  	-- animação do jogador

  player.frame = 0
  player.atira = false
   --[[ for x = 0, 4, 1 do
   player.animado[x] = love.graphics.newImage("images/jogador/CorpoAndando_0".. x ..".png")
   end 
   
   for x = 1, 3, 1 do
   	player.animtiro[x] = love.graphics.newImage("images/jogador/CorpoAtirando_0".. x .. ".png")
   end]]
 for x = 0, 4, 1 do
   player.animado[x] = love.graphics.newImage("images/jogador/CorpoAndando_0".. x ..".png") --frames de 0 a 4 
 end
  for x = 1, 3 , 1 do
   player.animado[x+4] = love.graphics.newImage("images/jogador/CorpoAtirando_0".. x ..".png") --frames de 5 a 7
 end
 
 for x = 1, 3 , 1 do
   player.animado[x+7] = love.graphics.newImage("images/jogador/CorpoJogandoGranada_0".. x ..".png") --frames de 8 a 10 
 end
 
 for x = 1, 5 , 1 do
   player.animado[x+10] = love.graphics.newImage("images/jogador/ShotgunSocoAgachado_0".. x ..".png") -- frames de 11 a 15 
 end

end
function player.update(dt)
  -- movimentação do jogador
	if love.keyboard.isDown("right") then
    	player.dir = 1
		player.x = player.x + player.s*dt
		player.l = "r"
		if player.x > 850 - player.h then
			game_over = true
		end
		if player.state == "walk" then
			player.time = player.time + dt
			if player.time > 0.1 then
			    player.frame = player.frame + 1
			    if player.frame > 4 then
			      player.frame = 1
			    end
			    player.time = 0
			end
		end
	elseif love.keyboard.isDown("left") then
    	player.dir = -1
		player.x = player.x - (player.s + cenario.s)*dt
		player.l = "l"
		if player.x < -player.h then
			game_over = true
		end
		if player.state == "walk" then
			player.time = player.time + dt
			if player.time > 0.1 then
			    player.frame = player.frame + 1
			    if player.frame > 4 then
			      player.frame = 1
			    end
			    player.time=0
			end
		end
	else
		player.frame = 0
		player.x = player.x - cenario.s * dt
		if player.x < -player.h then
			game_over = true
		end
	end
	--[[if player.move == true then
		player.frame = player.frame + 1
			if player.frame > 4 then
				player.frame = 1
			end
		img = player.animado[player.frame]
	else 
		player.move = false
		player.x = player.x - cenario.s * dt
		player.frame = 0
		img = player.image_parado
	end]]
	if player.state == "tiro" or player.state == "granada" or player.state == "faca" then 
            if player.state == "tiro" then 
              if player.frame < 5 or player.frame > 7  then
                 player.frame = 5 
              end 
            elseif player.state == "granada"  then 
              if grenade.on == true  then 
                if player.frame < 8 or player.frame >10 then
                   player.frame = 8
                end 
              else 
                 player.state = "walk" 
                end 
            else 
                if player.frame < 11 or player.frame >15 then
                   player.frame = 11
              
                end 
            end 
      player.time = player.time + 0.1
      if player.time > 1.5 then
          player.count = player.count - 1 
          player.frame = player.frame + 1
          player.time = 0       
           
           if player.count < 5  then
             player.state = "walk" 
            end 
		    end
	end 

	if love.keyboard.isDown('space') then
		if player.v == 0 then
			player.v = player.j
		end
	end
 
	if player.v ~= 0 then
		player.y = player.y + player.v * dt
		player.v = player.v - player.g * dt
	end
 
	if player.y > 500-player.h then
		player.v = 0
    	player.y = 500-player.h
	end
	--[[if love.keyboard.isDown("z") then
		player.atira = true
		player.frame = 1
		if player.time > 0.1 then
		    player.frame = player.frame + 1
		    if player.frame > 3 then
		      player.frame = 1
		    end
		    player.time=0
		end
	else
		player.atira = false
		player.frame = 0
	end]]

end

function player.draw()
	love.graphics.setColor(255,255,255)

	if player.state == "tiro"   then 
     player.y = player.y + 5
    
   end
   if player.state == "faca" then 
     player.y = player.y + 30
   end 

  	io.write ( player.count )
	
	if player.l == "r" --[[and player.atira == false]] then
		love.graphics.draw(player.animado[player.frame], player.x, player.y, 0, player.scale * player.dir, player.scale)
	--elseif player.l == "r" and player.atira == true then
	--		love.graphics.draw(player.animtiro[player.frame], player.x, player.y -10, 0, player.scale * player.dir, player.scale)
	elseif player.l == "l" --[[and player.atira == false]] then
		love.graphics.draw(player.animado[player.frame], player.x, player.y, 0, player.scale * player.dir, player.scale, player.w/2)
	--elseif player.l == "l" and player.atira == true then
	--	love.graphics.draw(player.animtiro[player.frame], player.x, player.y -10, 0, player.scale * player.dir, player.scale, player.w/2)
	end
	love.graphics.setColor(255,0,0)
	if player.l == "r" then
		love.graphics.rectangle("fill", player.x+player.w-10, player.y+player.h/2-5, 10, 10)
	else
		love.graphics.rectangle("fill", player.x, player.y+player.h/2-5, 10, 10)
	end
	love.graphics.setColor(255,255,255)
end