local Desafio2 = {}
local t1
local t11
local id
local d = {}
local scale = 0.333
local Sound2 = love.audio.newSource("PotatoBlop.mp3","static")

local function completa()
  local countz = 2
  for i = 1, 3, 1 do
    for j = 1, 3, 1 do
      if Desafio2[i][j].id == 1 then
        return false
      end
    end
  end
  love.graphics.print("Parabens!",300,100,0,3,3)
  love.graphics.print("\nA Proxima Fase Começara Em 3 Segundos",300,100)
  return true
end


function Desafio2.keypressed()
end

function change(i,j)
  
  if i > 3 or  i < 1 then
    return
  end
  if j > 3 or j < 1 then
    return
  end
  local x = Desafio2[i][j]
  if x.id == 1 then
    x.id = 2
  else
    x.id = 1
  end
end

function mouseAction(i,j)
  change(i,j)
  change(i+1,j)
  change(i,j+1)
  change(i-1,j)
  change(i,j-1)
end

function Desafio2.mousepressed(x,y,button)
  if button == 1 then
    for i = 1, 3 , 1 do
      for j = 1, 3, 1 do
        if (x >= 250+(j-1)*t1*scale and x <= 250+(j)*t1*scale) and (y >= 150+(i-1)*t11*scale and y <= 150+(i)*t11*scale) then
          mouseAction(i,j)
          Sound2:setVolume(0.3)
          Sound2:play()
        end
      end
    end
  end
  if completa() then
    love.timer.sleep(3)
    cb()
  end
end

function Desafio2.load(callback)
  cb = callback
  Desafio2.BG = love.graphics.newImage("Desafio2_BG.png")
  Desafio2.img1 = love.graphics.newImage("Desafio21.png")
  Desafio2.img2 = love.graphics.newImage("Desafio22.png")
  d = {Desafio2.img1,Desafio2.img2}
  t1 = Desafio2.img1:getWidth()
  t11 = Desafio2.img1:getHeight()
  for y = 1, 3, 1 do
    Desafio2[y] = {}
    for x = 1, 3, 1 do
      Desafio2[y][x] = {id = love.math.random(1,2)}
    end
  end
end

function Desafio2.update(dt)
end

function Desafio2.draw()
  love.graphics.draw(Desafio2.BG, 0, 0, 0, 0.8, 0.8)
  local img
  for y = 1, 3, 1 do
    for x = 1, 3, 1 do
      if Desafio2[y][x].id == 1 then
        img = d[1]
      else
        img = d[2]
      end
       love.graphics.draw(img,250+(x-1)*t1*scale,150+(y-1)*t11*scale,0,scale,scale)
    end
  end
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("line", 250, 150, 300,300)
    love.graphics.line(250, 250, 550, 250)
    love.graphics.line(250, 350, 550, 350)
    love.graphics.line(350, 150, 350, 450)
    love.graphics.line(450, 150, 450, 450)
    love.graphics.setColor(255,255,255)
 end
return Desafio2
