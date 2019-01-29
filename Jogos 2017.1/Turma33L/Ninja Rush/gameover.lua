local gameover = {}

function gameover.load()
  love.graphics.setBackgroundColor(130,34,116)
  Press_Enter = love.graphics.newImage("PressENTER.png")
  Lose = love.graphics.newImage("YOULOSE.png")
end
 
function gameover.update(dt)
end

function gameover.draw()
  love.graphics.setColor(255, 255, 255)
  -- Lose e Press --
  love.graphics.draw(Lose, 300, 200, 0, 1, 1)
  love.graphics.draw(Press_Enter, 300, 300, 0, 1, 1)
 
  end

function gameover.keypressed(key)
  if key == "return" then
      ChangeToMenu()
    end
   end

return gameover