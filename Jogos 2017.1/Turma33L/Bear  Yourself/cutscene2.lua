local cutscene2 = {}

function cutscene2.load()
  bg4 = love.graphics.newImage("cutscene2.png")
  end

function cutscene2.update(dt)
  love.audio.stop(bgm2)
  love.audio.play(bgm)
end

function cutscene2.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(bg4,0,0,0,1,1)
 end
 
 function cutscene2.mousepressed(but,x,y)
   
 end
 
 function cutscene2.keypressed(key)
   if key == "space" then
   changeToMenu()
  end
 end
 
 return cutscene2