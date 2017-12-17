function grid(mapa, x, y)
	if wallhack then
		if mapa[y][x] == 0 then
			return true
		elseif mapa[y][x] == 1 then
			return true
		elseif mapa[y][x] == 2 then
			return 2
		elseif mapa[y][x] == 3 then
			return 3
		end
	else
		if mapa[y][x] == 0 then
			return true
		elseif mapa[y][x] == 1 then
			return false
		elseif mapa[y][x] == 2 then
			return 2
		elseif mapa[y][x] == 3 then
			return 3
		end
	end
end