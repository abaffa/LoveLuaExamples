bullets 		= {}

function bullet_load()
	bullet_trigger 	= 0

	bullet_speed 	= 160
end

function bullet_update(dt)
	for i=table.getn(bullets), 1, -1 do
		bullet = bullets[i]

		if bullet.side == "u" then
			bullet.yPos = bullet.yPos - dt * bullet_speed
		elseif bullet.side == "d" then
			bullet.yPos = bullet.yPos + dt * bullet_speed
		elseif bullet.side == "l" then
			bullet.xPos = bullet.xPos - dt * bullet_speed
		elseif bullet.side == "r" then
			bullet.xPos = bullet.xPos + dt * bullet_speed
		end

		if bullet.xPos > map_img:getWidth()+48 or bullet.xPos < 16 or bullet.yPos > map_img:getHeight()+48 or bullet.yPos < 16 then
			table.remove(bullets, i)
		end
	end

	if bullet_trigger > 0 then
		bullet_trigger = bullet_trigger - dt
	end
end

function bullet_spawn(x, y, side)
	if bullet_trigger <= 0 then
		pop:play()
		bullet = {xPos = x+8, yPos = y+8, side = side}
		table.insert(bullets, 1, bullet)
		bullet_trigger = 0.5
	end
end

function bullet_draw_debugger()
	love.graphics.setColor(255, 0, 0)
	for i=table.getn(bullets), 1, -1 do
		bullet = bullets[i]
		love.graphics.circle("fill", bullet.xPos, bullet.yPos, 2)
	end
end

function bullet_draw()
	love.graphics.setColor(110, 20, 200)
	for i=table.getn(bullets), 1, -1 do
		bullet = bullets[i]
		love.graphics.circle("fill", bullet.xPos-player.dest_x+156, bullet.yPos-player.dest_y+122, 2)
	end
end