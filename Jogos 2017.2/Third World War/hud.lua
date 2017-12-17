hud = {}

function hud.load()
	core = love.graphics.newImage("images/menu/core.png")
end

function hud.update(dt)
end

function hud.draw()
	if player.life >= 1 then
		love.graphics.draw(core, 10, 10)
	end
	if player.life >= 2 then
		love.graphics.draw(core, 70, 10)
	end
	if player.life >= 3 then
		love.graphics.draw(core, 130, 10)
	end
	if player.life >= 4 then
		love.graphics.draw(core, 190, 10)
	end
	if player.life == 5 then
		love.graphics.draw(core, 250, 10)
	end

	love.graphics.setColor(0,0,0)
	love.graphics.printf("points", 300, 10, 400, "center", 0, 2, 2)
	love.graphics.setColor(255, 255, 255)
end