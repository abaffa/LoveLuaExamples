healer = {}

heals = {}

function healer.load()
	heal_img = love.graphics.newImage("imagens/misc/heal.png")
end

function healer.update(dt)
	for i=#heals, 1, -1 do
		heal = heals[i]
		if distancia(player.dest_x+9, heal.xPos+8, player.dest_y+13, heal.yPos+8) < 9 then
			if player.life == 9 then
				uplife:play()
				player.life = 10
				table.remove(heals, i)
			elseif player.life < 9 then
				uplife:play()
				player.life = player.life + 2
				table.remove(heals, i)
			else
				beep:play()
			end
		end
	end
end

function healer.draw()
	love.graphics.scale(2, 2)
	for i=#heals, 1, -1 do
		heal = heals[i]
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(heal_img, heal.xPos-player.dest_x+10*16-3, heal.yPos-player.dest_y+8*16-4)
	end
	love.graphics.scale(0.5, 0.5)
end

function heal_spawn(x, y)
	heal = {xPos = x*16, yPos = y*16}
	table.insert(heals, heal)
end