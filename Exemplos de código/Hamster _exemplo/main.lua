 function love.load()
  hamster = love.graphics.newImage("hamster.png")
  background = love.graphics.newImage("interface-3.png")
  buttonis = love.graphics.newImage("start.png")
  quit = love.graphics.newImage("quit.png")
  px = 400
  py = 300
  pr = 0
  pressionado = 1
  gamestate = 2
  dirx = 1
  diry = 1
end
function CheckClick(x1,y1,w1,h1,x2,y2)
  return x1 < x2+1 and x2 < x1+w1 and y1 < y2+1 and y2 < y1+h1
end
function love.mousepressed(x,y,button)
  if CheckClick(px-200-8,py+200-76,434,81,x,y) then
    if button == "l" then
      gamestate = 1
    elseif button == "r" then
      gamestate = 1
    end
  end
  if CheckClick(px-200-8,py+200-76+70,434,81,x,y) then
    if button == "l" then
      love.event.push("quit")
    elseif button == "r" then
      love.event.push("quit")
    end
  end
end
function love.update(dt)
  if gamestate == 1 then
    pr = pr +2*(dt)
    px = px + 150*dirx*(dt)
    py = py + 150*diry*(dt)
    if (px+hamster:getWidth()/2)>= 800 then
      dirx = -1
      love.graphics.setBackgroundColor(love.math.random(0,255),love.math.random(0,255),love.math.random(0,255))
    elseif (px-hamster:getWidth()/2)<= 0 then
      dirx = 1
      love.graphics.setBackgroundColor(love.math.random(0,255),love.math.random(0,255),love.math.random(0,255))
    end
    if (py+hamster:getHeight()/2)>= 600 then
      diry = -1
      love.graphics.setBackgroundColor(love.math.random(0,255),love.math.random(0,255),love.math.random(0,255))
    elseif (py-hamster:getHeight()/2)<= 0 then
      diry = 1
      love.graphics.setBackgroundColor(love.math.random(0,255),love.math.random(0,255),love.math.random(0,255))
    end
  else
    if CheckClick(px-200-8,py+200-76,434,81,love.mouse.getX(),love.mouse.getY()) then
      if love.keyboard.isDown("return") then
        gamestate = 1
      end 
    elseif CheckClick(px-200-8,py+200-76+70,434,81,love.mouse.getX(),love.mouse.getY()) then
      if love.keyboard.isDown("return") then
        love.event.push("quit")
      end
    end 
    if pressionado == 2 then
      if love.keyboard.isDown("return") then
        gamestate = 1
      end
    elseif pressionado == 3 then
      if love.keyboard.isDown("return") then
        love.event.push("quit")
      end
    end
  end
end
function love.keypressed(key)
  if key == "down" then
    if pressionado == 2 then
      pressionado = 3
    else
      pressionado = 2
    end
  end
  if key == "up" then
    if pressionado == 3 then
      pressionado = 2
    elseif pressionado == 2 then
      pressionado = 3
    else
      pressionado = 1
    end
  end
end
function love.draw()
  if gamestate == 1 then
    love.graphics.draw(hamster, px, py, pr, 1, 1, hamster:getWidth()/2, hamster:getHeight()/2)
  else
    love.graphics.draw(background, 0,0)
    if CheckClick(px-200-8,py+200-76,434,81,love.mouse.getX(),love.mouse.getY()) then
      love.graphics.draw(buttonis, px-200-8,py+200-76)
      pressionado = 1
    elseif CheckClick(px-200-8,py+200-76+70,434,81,love.mouse.getX(),love.mouse.getY()) then
      love.graphics.draw(quit, px-200-8-5,py+200-76+60)
      pressionado = 1
    end
    if pressionado == 2 then
      love.graphics.draw(buttonis,px-200-8,py+200-76)
    elseif pressionado == 3 then
      love.graphics.draw(quit,px-200-8,py+200-76+60)
    end
  end
end