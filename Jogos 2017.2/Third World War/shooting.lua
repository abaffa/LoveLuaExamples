shooting = {}

shots = {}

function shooting.load()
	shooting.timer 	= 0
	shooting.speed 	= 400
	shooting.r 		= 4
end

function shooting.update(dt)
	for i=#shots, 1, -1 do
		shot = shots[i]

		if shot.side == "l" then
			shot.x = shot.x - (shooting.speed + cenario.s) * dt
		elseif shot.side == "r" then
			shot.x = shot.x + shooting.speed * dt
		end

		if shot.x > 800+shooting.r or shot.x < shooting.r then
			table.remove(shots, i)
		end
	end

	if shooting.timer > 0 then
		shooting.timer = shooting.timer - dt
	end

	if love.keyboard.isDown("z") then
		shot_spawn(player.x, player.y, player.l)
	end
end

function shooting.draw()
	love.graphics.setColor(255, 0, 0)
	for i=#shots, 1, -1 do
		shot = shots[i]
		love.graphics.circle("fill", shot.x, shot.y, shooting.r)
	end
end

function shot_spawn(x, y, side)
	if shooting.timer <= 0 and player.state == "tiro" then
		shot = {x = player.x+player.w/2-3, y = player.y+player.h/2-3, side = player.l}
		table.insert(shots, 1, shot)
		shooting.timer = 0.5
	end
end