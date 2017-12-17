gameover = {}
function gameover.load()
  game_over_img = love.graphics.newImage("images/menu/GameOver.png")
  game_over = false
end

function gameover.update(dt)
	if player.life <= 0 then
		game_over = true 	
	end
end

function gameover.draw()
love.graphics.setBackgroundColor(255,255,255)
love.graphics.draw(game_over_img,0,0,0,1.5,1.5)
end