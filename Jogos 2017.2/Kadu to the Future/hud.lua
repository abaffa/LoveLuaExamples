hud = {}

function hud.load()
	hud.button_d = 50

	bastao = love.graphics.newImage("imagens/misc/bastao.png")
	estilingue = love.graphics.newImage("imagens/misc/estilingue.png")
end

function hud.update(dt)
end

function hud.draw()
	-- Barra de saúde
	love.graphics.setColor(0,0,0, 200)
	love.graphics.rectangle("fill", 10, 10, 100, 25)
	love.graphics.setColor(255, 50, 50, 200)
	love.graphics.rectangle("fill", 10, 10, 10*player.life, 25)
	love.graphics.setColor(0,0,0,255)
	love.graphics.rectangle("line", 10, 10, 100, 25)
	love.graphics.setColor(255,255,255,200)
	love.graphics.printf("Saúde", 10/1.5, 12, 110/1.5, "center", 0, 1.5, 1.5)

	-- Ícone de ataques
	love.graphics.setColor(255,255,255)
	love.graphics.draw(estilingue, menu.width-10-hud.button_d+9, menu.height-10-hud.button_d+9)
	love.graphics.draw(bastao, menu.width-10*2-hud.button_d*2, menu.height-10-hud.button_d)
	love.graphics.setColor(0,0,0,100)
	love.graphics.rectangle("fill", menu.width-10-hud.button_d, menu.height-10-hud.button_d, hud.button_d, hud.button_d)
	love.graphics.rectangle("fill", menu.width-10*2-hud.button_d*2, menu.height-10-hud.button_d, hud.button_d, hud.button_d)
	love.graphics.setColor(0,0,0,255)
	love.graphics.rectangle("line", menu.width-10-hud.button_d, menu.height-10-hud.button_d, hud.button_d, hud.button_d)
	love.graphics.rectangle("line", menu.width-10*2-hud.button_d*2, menu.height-10-hud.button_d, hud.button_d, hud.button_d)
	love.graphics.setColor(255,255,255,255)
	love.graphics.printf("S", menu.width-10-hud.button_d, 448, menu.width-10-hud.button_d+hud.button_d, "left", 0, 2, 1.5, -2)
	love.graphics.printf("A", menu.width-10*2-hud.button_d*2, 448, menu.width-10*2-hud.button_d*2+hud.button_d+hud.button_d, "left", 0, 1.5, 1.5, -2)
end