grenade = {}

function grenade.load()
	grenade.on 	= false
	grenade.exp = false
	grenade.x 	= 0
	grenade.y 	= 0
	grenade.s 	= 300
	grenade.j 	= -400
	grenade.g 	= -800
	grenade.v 	= 0
	grenade.l 	= "r"
	grenade.t 	= 0
	grenade.T 	= 0
	grenade.r 	= 8
end

function grenade.update(dt)
	if love.keyboard.isDown("x") and grenade.t <= 0 then
		player.state = "granada" 
		grenade.on 	= true
		grenade.t 	= 3
		grenade.x 	= player.x + player.w/2 - grenade.r
		grenade.y 	= player.y
		grenade.v 	= grenade.j
		grenade.l 	= player.l
	end

	if grenade.on then
		if grenade.l == "r" then
			grenade.x = grenade.x + grenade.s * dt
		elseif grenade.l == "l" then
			grenade.x = grenade.x - (grenade.s + cenario.s) * dt
		end
		if grenade.v ~= 0 then
			grenade.y = grenade.y + grenade.v * dt
			grenade.v = grenade.v - grenade.g * dt
		end
	else
		grenade.x = grenade.x - cenario.s * dt
	end

	if grenade.t > 0 then
		grenade.t = grenade.t - dt
	end

	if grenade.T > 0 then
		grenade.T = grenade.T - dt
	else
		grenade.exp = false
	end

	if grenade.y > 500-player.h/2 - grenade.r and grenade.on then
		grenade.v 	= 0
    	grenade.on 	= false
    	grenade.exp = true
    	grenade.T 	= 0.2
	end
end

function grenade.draw()
	love.graphics.setColor(255,0,0)
	if grenade.on then
		love.graphics.circle("fill", grenade.x, grenade.y, grenade.r)
	end
	
	if grenade.exp then
		love.graphics.circle("line", grenade.x, grenade.y, grenade.r*10)
	end
end