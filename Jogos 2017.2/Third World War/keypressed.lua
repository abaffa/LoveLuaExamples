function love.keypressed(key)
	-- Teclas para o menu:
	if key == "down" and menu.on and menu.button < 3 then
		menu.button = menu.button + 1
	end
	if key == "up" and menu.on and menu.button > 1 then
		menu.button = menu.button - 1
	end
	if key == "return" and menu.on then
		if menu.button == 3 then
			love.event.quit()
		elseif menu.button == 1 then
			menu.on = false
		end
	end
	-- ^^ fim ^^ --

	-- Teclas para o pause:
	if not menu.on then
		if key == "p" then
			pause.on = true
		end
		if key == "down" and pause.on and pause.button < 2 then
			pause.button = pause.button + 1
		end
		if key == "up" and pause.on and pause.button > 1 then
			pause.button = pause.button - 1
		end
		if key == "return" and pause.on then
			if pause.button == 2 then
				love.event.quit()
			elseif pause.button == 1 then
				pause.on = false
			end
		end
	end
	-- ^^ fim ^^ --

	-- Teclas para o cutscene:
		if not menu.on and not pause.on then
			if cutscene.on and key == "return" then
				if cutscene == 4 then
					love.event.quit()
				else
					cutscene.on = false
					cutscene.level = cutscene.level + 1
				end
			end
		end
	-- ^^ fim ^^ --

	 --teclas para animacao do player -- 
  
  if key == "z" then 
    if player.y >= 500-player.h then 
    player.state = "tiro"
    end 
  end 
  
   if key == "x" then 
    if player.y >= 500-player.h then 
    player.state = "granada"
    end 
  end 
  
    if key == "c" then 
    if player.y >= 500-player.h then 
    player.state = "faca"
    end 
    end 
-- ^^ fim ^^ --

	if game_over then 
		if key == "return" then
			love.load()
		end
	end

	if key == "q" and player.life > 0 then
		player.life = player.life - 1
	elseif key == "e" and player.life < 5 then
		player.life = player.life + 1
	end
end