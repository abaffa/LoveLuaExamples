love.graphics.setDefaultFilter("nearest", "nearest")

local Cenario = require ("Cenario")
local cleyton = require ("cleyton_movimentos")
local audio = require ("Musicas")
local Platform = require ("Platform")


function love.load()
	love.window.setTitle("Slide Down")
	Cenario.load()
	audio.load()
	Platform.load()
	cleyton.load()
	logo = love.graphics.newImage("Assets//Image//logo.png")
	darkBG = love.graphics.newImage("Assets//Image//darkBG.png")
	BG = love.graphics.newImage("Assets//Image//BackGround.png")

	menu = true
	gameover = false
	paused = false
	score = 0
	hstxt = love.filesystem.read("HighScore.txt")
	high = tonumber(hstxt)
	score_factor = 1
end

function checkcollision(x1, y1, w1, h1, x2, y2, w2, h2)
	return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end

function love.update(dt)
	if not gameover and not paused and not menu then
			--set scoring
			score = score + (score_factor * (dt))
			cleyton.update(dt)
			Platform.update(dt)
			Cenario.update(dt)
		
		elseif score > high then
			high = score
			love.filesystem.write("HighScore.txt", high)

	end

	audio.update(gameover, paused, menu)
end

function love.draw()
	if not gameover and not paused and not menu then
			love.graphics.scale(0.234375)
			Cenario.draw()
			Platform.draw(cleyton)
			cleyton.draw()
			love.graphics.printf(math.floor(score), 100, 0, 250, "right", 0, 5, 6)
		
		elseif menu then
			love.graphics.scale(0.234375)

			--draw menu settings
			love.graphics.draw(BG)
			love.graphics.draw(logo)
			love.graphics.printf("Press to play", -40, 1800, 200, "center", 0, 8, 8)

		elseif gameover then
			love.graphics.scale(0.234375)

			--changes background
			Cenario.draw()
			Platform.draw()
			love.graphics.draw(darkBG)

			--changes how the score is shown
			love.graphics.printf(math.floor(score), -80, 900, 100, "center", 0, 16, 16)
			love.graphics.printf("HightScore: "..math.floor(high), 450, 1200, 100, "center", 0, 6, 6)
			love.graphics.printf("Press Enter to restart", -40, 1800, 200, "center", 0, 8, 8)

		elseif paused then
			love.graphics.scale(0.234375)

			--changes background
			Cenario.draw()
			Platform.draw()
			cleyton.draw()
			love.graphics.draw(darkBG)
			love.graphics.draw(logo)
			love.graphics.setColor(255,255,255)
			love.graphics.printf("Press \"P\" to continue", -40, 1300, 200, "center", 0, 8, 8)
	end
end

function love.keypressed(key)
	if menu then
		if key == "return" or key == "space" then
			menu = false
		else
			menu = true
		end
	end

	if key == "p" and not gameover then
		if paused then
			paused = false
		else
			paused = true
		end
	end

	if gameover then
		if key == "return" then
			score = 0 
			score_factor = score_factor
			
			cleyton.x = 700
			cleyton.y = 30
			cleyton.speed = 1500
			gameover = false
			Platform.reload()
			audio.reload()
			
		end
	end

	if key == "b" then
		
	end
end