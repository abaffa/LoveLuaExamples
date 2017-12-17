faca = {}

function faca.load()
	faca.on 	= false
	faca.x		= 0
	faca.y 		= 0
	faca.r 		= 30
	faca.timer 	= 0
end

function faca.update(dt)
	if player.l == "r" then
		faca.x 	= player.x + player.w
	elseif player.l == "l" then
		faca.x 	= player.x
	end

	faca.y 	= player.y + player.h/2

	if love.keyboard.isDown("c") and faca.timer <= 0 then
		if player.l == "r" then
			faca.on = true
			faca.timer = 0.5
		elseif player.l == "l" then
			faca.on = true
			faca.timer = 0.5
		end
	end

	if faca.on and faca.timer < 0.4 then
		-- DAMAGE
		faca.on = false
	end

	if faca.timer > 0 then
		faca.timer = faca.timer - dt
	end
end

function faca.draw()
	love.graphics.setColor(255, 0, 0)
	love.graphics.circle("line", faca.x, faca.y, faca.r)
	if faca.on then
		love.graphics.circle("fill", faca.x, faca.y, faca.r)
	end
end