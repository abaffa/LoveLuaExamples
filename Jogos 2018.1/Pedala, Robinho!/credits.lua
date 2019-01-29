credits = {}

function credits.load()
  credits_screen = love.graphics.newImage("credits.png")
end

function credits.update(dt)
end

function credits.draw()
  love.graphics.draw(credits_screen,0,0)
end

function credits.keypressed(key)
  if key == "backspace" then
    love.changeToMenu()
  end
end

function credits.keyreleased(key)
end

return credits