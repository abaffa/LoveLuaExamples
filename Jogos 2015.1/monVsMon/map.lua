function mapBorders()

	if pikachu.x < 287.5 then
		pikachu.x = 287.5
	end

	if pikachu.x > 1444 then
		pikachu.x = 1444
	end

	if pikachu.y < 180 then
		pikachu.y = 180
	end

	if pikachu.y > 1000 then
		pikachu.y = 1000
	end

	for i,v in ipairs(agumons) do
		if v.x < 287.5 then
			v.x = 287.5
		end

		if v.x > 1444 then
			v.x = 1444
		end

		if v.y < 180 then
			v.y = 180
		end

		if v.y > 1000 then
			v.y = 1000
		end
	end	

	for i,v in ipairs(attackQs) do
		if (v.x < 267.5) or (v.x > 1444) or (v.y < 145 + v.image:getHeight()) or (v.y > 1020) then
			v.dirX = 0
			v.dirY = 0
		end
	end
end

function mapLoad()

	map =
	{
		img = love.graphics.newImage("bgs/arena.png"),
		xFriction = 10,
		yFriction = 10,
		enemiesSpawned = 0,
		enemiesKilled = 0,
		song = love.audio.newSource("sounds/arenaSong.wav", "stream"),
		timesWon = 0
	}
end