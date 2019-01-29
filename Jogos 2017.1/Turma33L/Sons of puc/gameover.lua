local gameover = {}
function gameover.load()
end
function gameover.update(dt)
  function love.keypressed(key)
    if key == "return" then
      changeToMenu()
    end
  end
end
function gameover.draw()
love.graphics.setBackgroundColor(0,0,0)
--love.graphics.Image(love.graphics.newImage("image/gameover.png")0,0)
end
return gameover