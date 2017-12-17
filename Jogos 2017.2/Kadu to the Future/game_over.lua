game_over = {}

function game_over.load()
	gameover = false
end

function game_over.update(dt)
	if player.life < 1 and not gameover then
		arcade_song:setVolume(0)
		menu_song:setVolume(0)
		medieval_song:setVolume(0)
		futuro_song:setVolume(0)
		main_boss_song:setVolume(0)
		simple_boss_song:setVolume(0)
		kadu_song:setVolume(0)
		death:play()
		gameover = true 
	end
end

function game_over.draw()
	love.graphics.setBackgroundColor(30,30,30)
	love.graphics.setColor(255,255,255)
	love.graphics.printf("GAME OVER", 0, 200, 640/5, "center", 0, 5, 5)
end