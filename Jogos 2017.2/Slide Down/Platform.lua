local Platform = {
	Height = 90,
	Width = 300,
	platforms = {
		powerup = "empty"
	}
}

-- game powerups
local powerups = {
	{name = "apple", type = "slowdown", img = love.graphics.newImage("Assets//Image//Apple.png"), chance = 2},
	{name = "hamburger", type = "score", img = love.graphics.newImage("Assets//Image//Hamburger.png"), chance = 2},
	{name = "pizza", type = "speedup", img =  love.graphics.newImage("Assets//Image//Pizza.png"), chance = 2}
}


function Platform.load()
	platform_Draw = love.graphics.newImage("Assets//Image//Plataforma.png")
	create_platform(love.math.random(0, 1123))
	platform_speed = 400

end

function Platform.reload()
	Platform.platforms = {}
	create_platform(love.math.random(0, 1123))
	platform_speed = 400
end

function Platform.update(dt)
	if Platform.platforms[1].yPos < 1960 then
		create_platform(math.random(0, 1123))
	end

    for i = #Platform.platforms, 1, -1 do
		platform = Platform.platforms[i]
		platform.yPos = platform.yPos - platform_speed * dt
		platform_speed = platform_speed + (5 * dt)				
		if platform.yPos < -100 then
			table.remove(Platform.platforms, i)
		end

	end

end

function Platform.draw(cleyton)
	for i = #Platform.platforms, 1, -1 do
		platform = Platform.platforms[i]
		love.graphics.draw(platform_Draw, platform.xPos, platform.yPos)

		if not (platform.powerup == "empty") then
			local pupX = platform.xPos + Platform.Width / 2 - platform.powerup.img:getWidth() / 2
			local pupY = platform.yPos - platform.powerup.img:getHeight()

			if cleyton == nil then
				love.graphics.draw(platform.powerup.img, pupX, pupY)
				return
			end

			if cleyton.currentPUP == "empty" then
				love.graphics.draw(platform.powerup.img, pupX, pupY)
			end
		end

	end

end

function create_platform(x)
	-- gets one random power up to try to spawn
	local randomPUP = powerups[math.random(1, #powerups)]
	local chaching = "empty"

	if(math.random(1,100) <= randomPUP.chance) then
		chaching = randomPUP
	end

	platform = {xPos = x, yPos = 2560, powerup = chaching}
	table.insert(Platform.platforms, 1, platform)
end

return Platform