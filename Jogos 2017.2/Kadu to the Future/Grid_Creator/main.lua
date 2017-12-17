love.graphics.setDefaultFilter("nearest", "nearest")

function love.load()

	bg = love.graphics.newImage("mapas/futuro_05.png")

	tile = {
			w = 16,
			h = 16,
			L = 24,
			A = 16
			}
	map = {}
	txt = "map = {\n{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },\n"
	x = 1
	
end

function love.update(dt)
	while x < tile.A do
		for i=1, tile.A, 1 do
			table.insert(map, {})

			for j=1, tile.L, 1 do	
				table.insert(map[i], 0)
			end
		x = x+1
		end
	end
end

function love.draw()
	love.graphics.draw(bg, tile.w, tile.h)
	love.graphics.setColor(0,0,0, 50)
	love.graphics.rectangle("fill", 0, 0, 26*16, 18*16)
	for i=#map, 1, -1 do
		for j=#map[i], 1, -1 do
			love.graphics.setColor(255,0,0, 100)
			love.graphics.rectangle("line", j*tile.w, i*tile.h, tile.w, tile.h)
			love.graphics.setColor(255,255,255,255)
			love.graphics.printf(map[i][j], j*tile.w, i*tile.h, j*tile.w, 'left')
		end	end
end
function love.keypressed(key)
	if key == "return" then
		for i=1, #map, 1 do
			txt = txt.."{ 1, "
			for j=1, #map[i], 1 do
				txt = txt..map[i][j]..", "
			end
			txt = txt.."1 },\n"
		end
		txt = txt.."{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }\n}"

		love.filesystem.write("supa.txt", txt)
	end
end

function love.mousepressed(x, y, button)
	if button == 1 then
		local i = math.floor(y / tile.w)
		local j = math.floor(x / tile.h)
		if i > 0 and i <= tile.A and j > 0  and j <= tile.L then
			map[i][j] = map[i][j] + 1
		end
	elseif button == 2 then
		local i = math.floor(y / tile.w)
		local j = math.floor(x / tile.h)
		if i > 0 and j > 0 then
			map[i][j] = map[i][j] - 1
		end
	end
end