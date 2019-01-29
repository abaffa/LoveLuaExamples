config = {}
local configbuttons
som=1.0
slide = 180

function config.load()
  bg2 = love.graphics.newImage("config2.png")
  configbuttons = {
    {
      x= 295,
      y= 130,
      width= 220,
      height = 50
    },
    {
      x= 295,
      y= 240,
      width= 220,
      height = 45
    },
    {
      x= 295,
      y= 340,
      width= 220,
      height = 45
    },
    {
      x= 295,
      y= 335,
      width= 220,
      height = 45
    },
    {
      x=230,
      y=130,
      width= 50,
      height= 50
    },
    {
      x=530,
      y=130,
      width=50,
      height=50
    }
  }
end

function config.update(dt)
  
end

function config.mousepressed(x,y,but)

 end


 function config.mousepressed(x, y, but)
  if checkPoint(configbuttons[5], x, y) and but == 1 then --Diminui o Som
    som = som - 0.1
    som = math.max(0, math.min(som, 1.0))
    bgm:setVolume(som)
    bgm2:setVolume(som)
    slide = 180 * som
  end
  if checkPoint(configbuttons[6], x, y) and but == 1 then --Aumenta o Som
    som = som + 0.1
    som = math.max(0, math.min(som, 1.0))
    bgm:setVolume(som)
    bgm2:setVolume(som)
    slide = 180 * som
  end
  if checkPoint(configbuttons[4], x, y) and but == 1 then
    --changeToMenu()
    love.transitionTo(config.destiny)
    love.audio.play(rugido)
    
  if checkPoint(configbuttons[2], x ,y) and but == 1 then
    love.audio.stop(bgm)
    love.audio.stop(bgm2)
  end
   
  end
  end
  
  function config.draw()
 love.graphics.setBackgroundColor(153,76,0)
  
 love.graphics.setColor(255,255,255)
 
    love.graphics.setColor(255,255,255)
    love.graphics.draw(bg2,0,0,0,0.8,0.8)
 --if actualButton > 0 then
 
 --end
 
  for i=1, #configbuttons do
   local b= configbuttons[i]
   
    love.graphics.setColor(64,64,64)
    love.graphics.rectangle('fill',315,138,slide,32.5)
    love.graphics.setColor(255,255,255)
    
    
end
    function config.keypressed(key)
    
  end

end
  
 return config