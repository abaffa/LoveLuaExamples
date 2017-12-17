function love.keypressed(key)
	if gameover then
		if key == "return" then
			click:rewind()
			click:play()
			love.event.quit()
		end
	end

	-- Teclas para o menu:
	if menu.on then
		if key == "down" and menu.button < 3 then
			click:rewind()
			click:play()
			menu.button = menu.button + 1
		end
		if key == "up" and menu.button > 1 then
			click:rewind()
			click:play()
			menu.button = menu.button - 1
		end
		if key == "return" then
			click:rewind()
			click:play()
			if menu.button == 3 then
				love.event.quit()
			elseif menu.button == 1 then
				menu_song:stop()
				menu.on = false
				kadu_song:play()
			end
		end
	end
	-- ^^ fim ^^ --

	-- Teclas para o pause:
	if not menu.on then
		if key == "p" then
			click:rewind()
			click:play()
			pause.on = true
		end
		if pause.on then
			if key == "down" and pause.button < 3 then
				click:rewind()
				click:play()
				pause.button = pause.button + 1
			end
			if key == "up" and pause.button > 1 then
				click:rewind()
				click:play()
				pause.button = pause.button - 1
			end
			if key == "return" then
				click:rewind()
				click:play()
				if pause.button == 3 then
					love.event.quit()
				elseif pause.button == 1 then
					pause.on = false
				end
			end
		end
	end
	-- ^^ fim ^^ --

	-- Teclas para o cutscene:
		if not menu.on and not pause.on then
			if cutscene.on and key == "return" then
				click:rewind()
				click:play()
				if cutscene.level == 4 then
					love.event.quit()
				else
					cutscene.on = false
					cutscene.level = cutscene.level + 1
				end
			end
		end
	-- ^^ fim ^^ --

	if not menu.on and not pause.on and not cutscene.on then
		-- Define o que acontece quando a tecla 'tab' é pressionada
		if key == "tab" and love.keyboard.isDown("lctrl") and love.keyboard.isDown("lshift") then
			click:rewind()
			click:play()
			text = ""
			rodrigo_true = false
			bruna_true = false
			if debugger then
				debugger = false
			else
				debugger = true
			end

		-- Define o que acontece quando a tecla 'h' é pressionada
		elseif key == "h" and debugger and love.keyboard.isDown("lctrl") then
			click:rewind()
			click:play()
			if hacker then
				hacker = false
			else
				hacker = true
			end
		end

		if debugger and not hacker then
			if key == "n" and player.life > 0 then
				click:rewind()
				click:play()
				player.life = player.life - 1
			elseif key == "m" and player.life < 10 then
				click:rewind()
				click:play()
				player.life = player.life + 1
			end

			if key == "q" and mapcount > 1  then
				click:rewind()
				click:play()
				mapcount = mapcount - 1

				if mapcount == 1 then
					medieval_song:stop()
					kadu_song:play()
				elseif mapcount == 7 then
					simple_boss_song:stop()
					medieval_song:play()
				elseif mapcount == 8 then
					futuro_song:stop()
					simple_boss_song:play()
				elseif mapcount == 12 then
					main_boss_song:stop()
					futuro_song:play()
				end

			elseif key == "e" and mapcount < 13 then
				click:rewind()
				click:play()
				mapcount = mapcount + 1

				if mapcount == 2 then
					kadu_song:stop()
					medieval_song:play()
				elseif mapcount == 8 then
					medieval_song:stop()
					simple_boss_song:play()
				elseif mapcount == 9 then
					simple_boss_song:stop()
					futuro_song:play()
				elseif mapcount == 13 then
					futuro_song:stop()
					main_boss_song:play()
				end
			end
		end
		
		-- Define valores para quando a condição é verdadeira
		if debugger and hacker then

			-- Define o que acontece quando a tecla 'backspace' é pressionada
			if key == "backspace" then
				--[[Essa parte do código é complicada e funciona de uma maneira não convencional,
					mas serve para deletar o último caracter do texto de "Hack"]]
			    local byteoffset = utf8.offset(text, -1)
			 
				if byteoffset then
			    	text = string.sub(text, 1, byteoffset - 1)
				end

			-- Define o que acontece quando a tecla 'Enter' é pressionada
			elseif key == "return" then
				click:rewind()
				click:play()
				
				--[[Utiliza o módulo utf8, assim como acima, mas para integra-lo ao texto como string]]
				cheat.hack = text
				text = ""
			end
		end
	end
end