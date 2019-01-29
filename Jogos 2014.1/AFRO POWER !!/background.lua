background = {}
background[1] = love.graphics.newImage("itens/floresta back1.png")
background[2] = love.graphics.newImage("itens/floresta back2.png")
background[3] = love.graphics.newImage("itens/floresta back3.png")
background.num = 1
background.anitimer = 0
background.pic = background[1]
function background_update(dt)
  if gamestate == "playing" then
    background.pic = background[background.num]
    background.anitimer = background.anitimer + dt
    if background.anitimer > 5 then
      background.anitimer = 0
      background.num = background.num + 1
    end
    if background.num > 3 then
      background.num = 1
    end
  end
end

function background_draw()
  love.graphics.draw(background.pic,0,0)
end
