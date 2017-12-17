enemy_bullets = {}

function enemy_bullet_load()
	enemy_bullet_speed 	= 160
end

function enemy_bullet_update(dt)
	for i=#enemy_bullets, 1, -1 do
		enemy_bullet = enemy_bullets[i]

		if enemy_bullet.side == "u" then
			enemy_bullet.yPos = enemy_bullet.yPos - dt * enemy_bullet_speed
		elseif enemy_bullet.side == "d" then
			enemy_bullet.yPos = enemy_bullet.yPos + dt * enemy_bullet_speed
		elseif enemy_bullet.side == "l" then
			enemy_bullet.xPos = enemy_bullet.xPos - dt * enemy_bullet_speed
		elseif enemy_bullet.side == "r" then
			enemy_bullet.xPos = enemy_bullet.xPos + dt * enemy_bullet_speed
		end

		if enemy_bullet.xPos > map_img:getWidth()+48 or enemy_bullet.xPos < 16 or enemy_bullet.yPos > map_img:getHeight()+48 or enemy_bullet.yPos < 16 then
			table.remove(enemy_bullets, i)
		end

		if distancia(player.dest_x+9, enemy_bullet.xPos, player.dest_y+4, enemy_bullet.yPos) < 6 then
			dano1:rewind()
			dano1:play()
			table.remove(enemy_bullets, i)
			player.life = player.life - 1
		end
	end



end

function enemy_bullet_spawn(x, y, side)
	pop2:rewind()
	pop2:play()
	enemy_bullet = {xPos = x+8, yPos = y+4, side = side}
	table.insert(enemy_bullets, 1, enemy_bullet)
end

function enemy_bullet_draw_debugger()
	--[[love.graphics.setColor(255, 0, 0)
	for i=table.getn(enemy_bullets), 1, -1 do
		enemy_bullet = enemy_bullets[i]
		love.graphics.circle("fill", enemy_bullet.xPos, enemy_bullet.yPos, 2)
	end]]
end

function enemy_bullet_draw()
	love.graphics.scale(2, 2)
	love.graphics.setColor(255, 0, 0)
	for i=#enemy_bullets, 1, -1 do
		enemy_bullet = enemy_bullets[i]
		love.graphics.circle("fill", enemy_bullet.xPos-player.dest_x+10*16-3, enemy_bullet.yPos-player.dest_y+8*16-4, 2)
	end
	love.graphics.scale(0.5, 0.5)
end