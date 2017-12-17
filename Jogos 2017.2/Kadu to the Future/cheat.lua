require("map")

cheat = 	{
	hack = ""
		}

function love.textinput(t)
	if debugger and hacker then
    	text = text .. t
    end
end

function cheat.load()
	text = ""
	wallhack = false
	love.keyboard.setKeyRepeat(true)
end

function cheat.update(dt)
	if 		cheat.hack == "wallhack" then
		if not wallhack then
			wallhack = true
			cheat.hack = ""
		elseif wallhack then
			wallhack = false
			cheat.hack = ""
		end
	elseif 	cheat.hack == "bruna" then
		bruna_true = true
	elseif 	cheat.hack == "rodrigo" then
		rodrigo_true = true
	end
end

function cheat.draw()
	if debugger and hacker then
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("fill", 0, 0, 100, 15)
		love.graphics.setColor(0,0,0)
		love.graphics.printf(text, 0, 0, love.graphics.getWidth())
	end
end

function rodrigo()
	love.graphics.setColor(255,0,0)
	if rodrigo_true then
		love.graphics.printf("Um cara maneiro", 0, 100, 340, "center", 0, 2, 2)
	end
	if bruna_true then
		love.graphics.printf("Nada acontece...", 0, 100, 340, "center", 0, 2, 2)
	end
end