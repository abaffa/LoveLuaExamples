local cutscene = {}

function cutscene.load()
  bg3 = love.graphics.newImage("cutscene1.png")
  end

function cutscene.update(dt)
  
end

function cutscene.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(bg3,0,0,0,1,1)
 end
 
 function cutscene.mousepressed(but,x,y)
   
 end
 
 function cutscene.keypressed(key)
   if key == "space" then
   changeToJogo()
  end
 end
 
 return cutscene