-- Pega uma módulo necessário para a parte de texto do Debugger
utf8 = require("utf8")

-- Muda o filtro de imagem do jogo para pixelado
love.graphics.setDefaultFilter("nearest", "nearest")

-- Importa os módulos do jogo
require("player")
require("map")
require("grid")
require("map_itens")
require("bullets")
require("melee")
require("attacks")
require("enemy")
require("cheat")
require("menu")
require("keypressed")
require("pause")
require("cutscene")
require("hud")
require("game_over")
require("healer")

function love.load()
	-- Carrega os sons
	click 				= love.audio.newSource("audio/click.wav", "static")
	whoosh 				= love.audio.newSource("audio/whoosh.wav", "static")
	pop 				= love.audio.newSource("audio/pop.wav", "static")
	pop2				= love.audio.newSource("audio/pop2.wav", "static")
	dano1				= love.audio.newSource("audio/damage_hero.wav", "static")
	dano2				= love.audio.newSource("audio/damage_mob.wav", "static")
	death 				= love.audio.newSource("audio/death.wav", "static")
	uplife 				= love.audio.newSource("audio/heal.wav", "static")
	beep 				= love.audio.newSource("audio/beep.wav", "static")

	arcade_song 		= love.audio.newSource("audio/musicas/ARMS.mp3", "stream")
	menu_song			= love.audio.newSource("audio/musicas/BttF.mp3", "stream")
	medieval_song		= love.audio.newSource("audio/musicas/Celtic.mp3", "stream")
	futuro_song			= love.audio.newSource("audio/musicas/Coda.mp3", "stream")
	main_boss_song 		= love.audio.newSource("audio/musicas/Megalovania.mp3", "stream")
	simple_boss_song	= love.audio.newSource("audio/musicas/Saturos.mp3", "stream")
	kadu_song			= love.audio.newSource("audio/musicas/PEEK-A-BOO.mp3", "stream")

	arcade_song:setLooping(true)
	menu_song:setLooping(true)
	medieval_song:setLooping(true)
	futuro_song:setLooping(true)
	main_boss_song:setLooping(true)
	simple_boss_song:setLooping(true)
	kadu_song:setLooping(true)

	arcade_song:setVolume(0.5)
	menu_song:setVolume(0.5)
	medieval_song:setVolume(0.5)
	futuro_song:setVolume(0.5)
	main_boss_song:setVolume(0.5)
	simple_boss_song:setVolume(0.5)
	kadu_song:setVolume(0.5)
	
	click:setVolume(2)
	whoosh:setVolume(2)
	pop:setVolume(2)
	pop2:setVolume(2)
	dano1:setVolume(2)
	dano2:setVolume(2)
	death:setVolume(2)
	uplife:setVolume(2)
	beep:setVolume(2)

	--love.audio.setVolume(0)

	-- Cria as variáveis booleanas de Debug e "Hack" (Easter Eggs & etc)
	debugger 	= false
	hacker 		= false

	-- Carrega as funções 'load' dos módulos
	menu.load()
	game_over.load()
	player.load()
	map.load()
	map_itens.load()
	enemy.load()
	cheat.load()
	pause.load()
	cutscene.load()
	hud.load()
	MOB.load()
	bullet_load()
	healer.load()
end

function love.update(dt)
	game_over.update(dt)

	if not gameover then
		if menu.on then menu.update(dt) end
		if pause.on then pause.update(dt) end
		if cutscene.on then cutscene.update(dt) end
		
		if not menu.on and not pause.on and not cutscene.on then
		-- Carrega as funções 'update' dos módulos	
			player.update(dt)
			map.update(dt)
			map_itens.update(dt)
			bullet_update(dt)
			enemy_bullet_update(dt)
			melee_update(dt)
			enemy.update(dt)
			MOB.update(dt)
			cheat.update(dt)
			hud.update(dt)
			enemy_bullet_load()
			healer.update(dt)
		end
	end
end

function love.draw()
	if not menu.on and not pause.on and not cutscene.on and not gameover then
		--Define a cor do background do jogo
		love.graphics.setBackgroundColor(30,30,30)

		-- Carrega as funções 'draw' dos módulos
		map.draw()
		healer.draw()
		enemy.draw()
		player.draw()
		map_itens.draw()
		attacks.draw()
		enemy_bullet_draw()
		hud.draw()

		-- Cria a condicional para utilização do Debugger
		if debugger then
			--Define a cor do background do jogo para verde quando o debugger está ativado
			love.graphics.setBackgroundColor(92, 168, 103)
			-- Deixa a cor do Debugger Vermelha
			love.graphics.setColor(200, 0, 0)

			-- 'Imprime' as informações do Debugger
			love.graphics.print("map = "..mapcount, 0, 385)
			love.graphics.print("player.x = "..player.x, 0, 400)
			love.graphics.print("player.y = "..player.y, 0, 415)
			love.graphics.print("player.dest_x = "..player.dest_x, 0, 430)
			love.graphics.print("player.dest_y = "..player.dest_y, 0, 445)
			love.graphics.print("map["..(player.y/16).."]["..(player.x/16).."](y,x)", 0, 460)
			love.graphics.print("bullets: "..table.getn(bullets), 550, 0)
			love.graphics.print("melee: "..tostring(melee.attack), 550, 15)
			love.graphics.print("melee: "..tostring(melee.side), 550, 30)
			love.graphics.print("#mobs: "..#random_mobs, 550, 45)
			love.graphics.print("wallhack: "..tostring(wallhack), 550, 60)

			-- Cria uma animação para o comando de excluir todos os inimigos
			if love.keyboard.isDown("lctrl") and love.keyboard.isDown("n") then
				love.graphics.setColor(255,0,0,100)
				love.graphics.rectangle("fill",0,0,640,480)
				love.graphics.setColor(255,0,0)
				love.graphics.printf("NUKE TIMEEEEE", 0, 100, 64, "center", 0, 10,10)
			end

			for i=#random_mobs, 1, -1 do
				random_mob = random_mobs[i]
				love.graphics.scale(0.5, 0.5)
				love.graphics.setColor(255, 100, 255)
				love.graphics.rectangle("fill", random_mob.xPos, random_mob.yPos, 16, 16)
				love.graphics.setColor(255, 0, 0)
				love.graphics.scale(2, 2)
			end

			enemy_bullet_draw_debugger()
		end

		cheat.draw()
		rodrigo()
	end

	if not gameover then
		if menu.on then menu.draw() end
		if pause.on then pause.draw() end
		if cutscene.on then cutscene.draw() end
	else
		game_over.draw()
	end
end

function distancia(x1, x2, y1, y2)
	return math.sqrt(((x2-x1)^2)+((y2-y1)^2))
end