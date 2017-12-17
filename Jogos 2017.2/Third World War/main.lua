-- Muda o filtro de imagem do jogo para pixelado
love.graphics.setDefaultFilter("nearest", "nearest")

-- Importa os módulos do jogo
require("menu")
require("pause")
require("cutscene")
require("keypressed")
require("cenario")
require("player")
require("shooting")
require("faca")
require("grenade")
require("hud")
require("enemy")
require("gameover")

-- Carrega as variáveis
function love.load()
	menu.load()
	pause.load()
	cenario.load()
	player.load()
	shooting.load()
	faca.load()
	grenade.load()
	cutscene.load()
	hud.load()
	enemy.load()
	gameover.load()
end

-- Atualiza as variáveis
function love.update(dt)
	menu.update(dt)
	pause.update(dt)
	cutscene.update(dt)
	gameover.update(dt)
	-- condicional para o jogo não atualizar em 2º plano (por trás dos menus)
	if not menu.on and not pause.on and not cutscene.on then
		cenario.update(dt)
		enemy.update(dt)
		player.update(dt)
		shooting.update(dt)
		faca.update(dt)
		grenade.update(dt)
		hud.update(dt)
	end
end

function love.draw()
	-- condicional para o jogo não "ser desenhado" em 2º plano
	if not menu.on and not pause.on and not cutscene.on and not game_over then
		cenario.draw()
		shooting.draw()
		faca.draw()
		enemy.draw()
		grenade.draw()
		player.draw()
		hud.draw()
	end
	if menu.on then menu.draw() end
	if pause.on then pause.draw() end
	if cutscene.on then cutscene.draw() end
	if game_over then gameover.draw() end
end