-- Importa os módulos necessários
require ("mapas/quarto_kadu")
require ("mapas/sala_kadu")
require ("mapas/robercletzon_lab_outside")
require ("mapas/medieval_01")
require ("mapas/medieval_02")
require ("mapas/medieval_03")
require ("mapas/medieval_04")
require ("mapas/medieval_05")
require ("mapas/medieval_06")
require ("mapas/medieval_maze")
require ("mapas/futuro_01")
require ("mapas/futuro_02")
require ("mapas/futuro_03")
require ("mapas/futuro_04")
require ("mapas/futuro_05")
require ("mapas/quarto_kadu_fim")
require ("grid")

-- Cria a tabela 'map'
map = {}


-- Define a função load de 'map'
function map.load()
	-- Cria a variável 'w' (de world, mundo) na tabela 'map'
	map.w = quarto_kadu	
	-- Carrega as imagens dos mapas em variáveis
	quarto_kadu_img 	= love.graphics.newImage("imagens/mapas/Quarto_Kadu_sem_laptop.png")
	quarto_kadu2_img 	= love.graphics.newImage("imagens/mapas/Quarto_Kadu.png")
	quarto_kadu3_img 	= love.graphics.newImage("imagens/mapas/Quarto_Kadu_porta_fechada.png")
	sala_kadu_img 		= love.graphics.newImage("imagens/mapas/Sala_casa_Kadu.png")
	rob_lab_outside_img = love.graphics.newImage("imagens/mapas/robercletzon_lab_outside.png")
	medieval_01_img 	= love.graphics.newImage("imagens/mapas/medieval_01.png")
	medieval_02_img 	= love.graphics.newImage("imagens/mapas/medieval_02.png")
	medieval_03_img 	= love.graphics.newImage("imagens/mapas/medieval_03.png")
	medieval_04_img 	= love.graphics.newImage("imagens/mapas/medieval_04.png")
	medieval_05_img 	= love.graphics.newImage("imagens/mapas/medieval_05.png")
	medieval_06_img 	= love.graphics.newImage("imagens/mapas/medieval_06.png")
	medieval_maze_img 	= love.graphics.newImage("imagens/mapas/medieval_maze.png")
	futuro_01_img	 	= love.graphics.newImage("imagens/mapas/futuro_01.png")
	futuro_02_img	 	= love.graphics.newImage("imagens/mapas/futuro_02.png")
	futuro_03_img	 	= love.graphics.newImage("imagens/mapas/futuro_03.png")
	futuro_04_img	 	= love.graphics.newImage("imagens/mapas/futuro_04.png")
	futuro_05_img	 	= love.graphics.newImage("imagens/mapas/futuro_05.png")

	mapcount = 1

	level_img	= {quarto_kadu_img, medieval_01_img, medieval_02_img, medieval_03_img, medieval_04_img, 
					medieval_05_img, medieval_06_img, medieval_maze_img, futuro_01_img, futuro_02_img, 
					futuro_03_img, futuro_04_img, futuro_05_img, quarto_kadu3_img}
	level 		= {quarto_kadu, medieval_01, medieval_02, medieval_03, medieval_04, 
					medieval_05, medieval_06, medieval_maze, futuro_01, futuro_02, 
					futuro_03, futuro_04, futuro_05, quarto_kadu_fim}

	-- Cria uma variável para carregar a imagem atual da tela
	map_img 			= quarto_kadu_img

	-- Define variáveis para a posição (x, y) da imagem na tela
	map_img_x 			= (320+58)/2
	map_img_y 			= (240+73)/2
end

-- Define a função update de 'map'
function map.update(dt)
	map.w 	= level[mapcount]
	map_img = level_img[mapcount]
	-- Define condicional de posicionamento do player
	if player.dest_x % 16 == 0 and player.dest_y % 16 == 0 then
		-- Define condicionais de mapa, direção e grid
		if map.w == quarto_kadu and player.side == "u" and grid(map.w, (player.dest_x/16), (player.dest_y/16)) == 2 then
			heal_spawn(9, 12)
			heal_spawn(7, 12)
			heal_spawn(5, 12)
			RM_mob_spawn(13, 8, math.random(5, 10)/10, 2)
			player.x = 64
			player.y = 240
			player.dest_x = 64
			player.dest_y = 240
			player.side = "u"
			mapcount = 2
			map_img = level_img[mapcount]
			map.w = level[mapcount]
			kadu_song:stop()
			medieval_song:play()
		elseif map.w == medieval_01 and player.side == "u" and grid(map.w, (player.dest_x/16), (player.dest_y/16)) == 2 then
			heals = {}
			RM_mobs = {}
			enemy_bullets = {}
			heal_spawn(13, 6)
			heal_spawn(14, 6)
			RM_mob_spawn(12, 6, math.random(5, 10)/10, 2)
			RM_mob_spawn(13, 7, math.random(5, 10)/10, 2)
			RM_mob_spawn(14, 7, math.random(5, 10)/10, 2)
			RM_mob_spawn(15, 6, math.random(5, 10)/10, 2)
			player.x = 208
			player.y = 256
			player.dest_x = 208
			player.dest_y = 272
			player.side = "u"
			mapcount = 3
			map_img = level_img[mapcount]
			map.w = level[mapcount]
		elseif map.w == medieval_02 and player.side == "u" and grid(map.w, (player.dest_x/16), (player.dest_y/16)) == 2 then
			heals = {}
			RM_mobs = {}
			enemy_bullets = {}
			heal_spawn(23, 4)
			heal_spawn(10, 4)
			RM_mob_spawn(7, 10, math.random(5, 10)/10, 2)
			RM_mob_spawn(8, 9, math.random(5, 10)/10, 2)
			RM_mob_spawn(12, 14, math.random(5, 10)/10, 2)
			player.x = 208
			player.y = 256
			player.dest_x = 208
			player.dest_y = 272
			player.side = "u"
			mapcount = 4
			map_img = level_img[mapcount]
			map.w = level[mapcount]
		elseif map.w == medieval_03 and player.side == "l" and grid(map.w, (player.dest_x/16), (player.dest_y/16)) == 2 then
			heals = {}
			RM_mobs = {}
			enemy_bullets = {}
			heal_spawn(8, 4)
			RM_mob_spawn(15, 7, math.random(5, 10)/10, 2)
			RM_mob_spawn(23, 15, math.random(5, 10)/10, 2)
			RM_mob_spawn(8, 14, math.random(5, 10)/10, 2)
			player.x = 384
			player.y = 144
			player.dest_x = 400
			player.dest_y = 144
			player.side = "l"
			mapcount = 5
			map_img = level_img[mapcount]
			map.w = level[mapcount]
		elseif map.w == medieval_04 and player.side == "u" and grid(map.w, (player.dest_x/16), (player.dest_y/16)) == 2 then
			heals = {}
			RM_mobs = {}
			enemy_bullets = {}
			heal_spawn(20, 4)
			heal_spawn(23, 13)
			RM_mob_spawn(23, 4, math.random(5, 10)/10, 2)
			RM_mob_spawn(16, 4, math.random(5, 10)/10, 2)
			RM_mob_spawn(11, 4, math.random(5, 10)/10, 2)
			RM_mob_spawn(16, 13, math.random(5, 10)/10, 2)
			player.x = 208
			player.y = 256
			player.dest_x = 208
			player.dest_y = 272
			player.side = "u"
			mapcount = 6
			map_img = level_img[mapcount]
			map.w = level[mapcount]
		elseif map.w == medieval_05 and player.side == "u" and grid(map.w, (player.dest_x/16), (player.dest_y/16)) == 2 then
			heals = {}
			RM_mobs = {}
			enemy_bullets = {}
			heal_spawn(8, 8)
			heal_spawn(16, 6)
			heal_spawn(23, 6)
			RM_mob_spawn(21, 14, math.random(5, 10)/10, 2)
			player.x = 208
			player.y = 256
			player.dest_x = 208
			player.dest_y = 272
			player.side = "u"
			mapcount = 7
			map_img = level_img[mapcount]
			map.w = level[mapcount]
		elseif map.w == medieval_06 and player.side == "u" and grid(map.w, (player.dest_x/16), (player.dest_y/16)) == 2 then
			heals = {}
			--[[RM_mobs = {}
			enemy_bullets = {}
			player.x = 64
			player.y = 496
			player.dest_x = 64
			player.dest_y = 512
			player.side = "u"
			mapcount = 8
			map_img = level_img[mapcount]
			map.w = level[mapcount]
			medieval_song:stop()
			simple_boss_song:play()
		elseif map.w == medieval_maze and player.side == "u" and player.x == 640 and player.y == 64 then
			player.x = 208
			player.y = 256
			player.dest_x = 208
			player.dest_y = 272
			player.side = "u"
			mapcount = 9
			map_img = level_img[mapcount]
			map.w = level[mapcount]
			simple_boss_song:stop()
			futuro_song:play()
		elseif map.w == futuro_01 and player.side == "u" and grid(map.w, (player.dest_x/16), (player.dest_y/16)) == 2 then
			player.x = 208
			player.y = 256
			player.dest_x = 208
			player.dest_y = 272
			player.side = "u"
			mapcount = 10
			map_img = level_img[mapcount]
			map.w = level[mapcount]
		elseif map.w == futuro_02 and player.side == "r" and grid(map.w, (player.dest_x/16), (player.dest_y/16)) == 2 then
			player.x = 48
			player.y = 64
			player.dest_x = 32
			player.dest_y = 64
			player.side = "r"
			mapcount = 11
			map_img = level_img[mapcount]
			map.w = level[mapcount]
		elseif map.w == futuro_03 and player.side == "u" and grid(map.w, (player.dest_x/16), (player.dest_y/16)) == 2 then
			player.x = 384
			player.y = 256
			player.dest_x = 384
			player.dest_y = 272
			player.side = "u"
			mapcount = 12
			map_img = level_img[mapcount]
			map.w = level[mapcount]
		elseif map.w == futuro_04 and player.side == "u" and grid(map.w, (player.dest_x/16), (player.dest_y/16)) == 2 then]]
			heals = {}
			heal_spawn(8, 4)
			heal_spawn(19, 4)
			RM_mobs = {}
			enemy_bullets = {}
			RM_mob_spawn(13, 4, 0.2, 5)
			player.x = 208
			player.y = 256
			player.dest_x = 208
			player.dest_y = 272
			player.side = "u"
			mapcount = 13
			map_img = level_img[mapcount]
			map.w = level[mapcount]
			futuro_song:stop()
			main_boss_song:play()
		elseif map.w == futuro_05 and #RM_mobs == 0 then
			heals = {}
			player.x = 112
			player.y = 64
			player.dest_x = 112
			player.dest_y = 64
			player.side = "u"
			mapcount = 14
			map_img = level_img[mapcount]
			map.w = level[mapcount]
			main_boss_song:stop()
			kadu_song:play()
		end
	end
end

-- Define a função draw de 'map'
function map.draw()
	--[[Define aspectos do jogo:
		scale define fator de expansão de imagem]]
	love.graphics.scale(2, 2)
	love.graphics.setColor(255,255,255)
	-- Desenha o mapa na tela
	love.graphics.draw(map_img, map_img_x -player.dest_x, map_img_y-player.dest_y--[[32, 32]])
	love.graphics.scale(0.5, 0.5)
	love.graphics.scale(0.5, 0.5)
	
	-- Cria condicionais para desenho do Debugger relacionado ao mapa
	if debugger then
		-- Função que itera pela grid do mapa e cria um minimapa no canto superior esquerdo da tela
		for y=1, #map.w do
			for x=1, #map.w[y] do
				if map.w[y][x] == 1 then
					love.graphics.setColor(0,0,0)
					love.graphics.rectangle("line", x * 16, y * 16, 16, 16)
				elseif map.w[y][x] == 2 then
					love.graphics.setColor(0,0,255)
					love.graphics.rectangle("line", x * 16, y * 16, 16, 16)
				elseif map.w[y][x] == 3 then
					love.graphics.setColor(255,0,255)
					love.graphics.rectangle("line", x * 16, y * 16, 16, 16)
				end
			end
		end
	end
	love.graphics.scale(2, 2)
end