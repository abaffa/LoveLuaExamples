local Desafio1 = {}
local Buraco = {}
local w
local h
local s
local wt,ht = love.graphics.getDimensions()
local size = 300
local x1
local x2
local y1
local y2
local aux
local cb
local Sound = love.audio.newSource("PotatoWoosh.wav","static")

local function completa()
  local countz = 1
  for i = 1, 5, 1 do
    for j = 1, 5, 1 do
      if Desafio1[i][j].id ~= countz then
        return false
      end
      countz = countz + 1
    end
  end
  return true
end
function Desafio1.emb(num)
  for x=1, num, 1 do
    x1 = love.math.random(1,5)
    x2 = love.math.random(1,5)
    y1 = love.math.random(1,5)
    y2 = love.math.random(1,5)
    aux = Desafio1[x1][y1]
    Desafio1[x1][y1] = Desafio1[x2][y2]
    Desafio1[x2][y2] = aux
  end
end
function emb2(grid,lin,col)
  local ready = false
  local i,j
  local numbers
  local N
  Desafio1.emb(50)
  while not ready do
    Desafio1.emb(1)
    numbers = {}
    N = 0
    for i = 1,lin do
      for j = 1,col do
        for j = 1,#numbers do
          if grid[i][j] < numbers[i] then
            N = N + 1
          end
        end
      end
    end
    ProBuraco()
    ready = (N+(Buraco.y - 1)*col + Buraco.x)%2 == 0
  end
end

function ProBuraco()
  for y=1, 5, 1 do
    for x=1, 5, 1 do
      if Desafio1[y][x].id == 25 then
        Buraco.x = x
        Buraco.y = y
      end
    end
  end
 end
function move(dx,dy)
  dx = -dx
  dy = -dy
   x1 = Buraco.x
   x2 = Buraco.x + dx
   y1 = Buraco.y
   y2 = Buraco.y + dy
   if x2 > 5 or x2 < 1 then
     return
   end
   if y2 > 5 or y2 < 1 then
     return
   end
   aux = Desafio1[y1][x1]
   Desafio1[y1][x1] = Desafio1[y2][x2]
   Desafio1[y2][x2] = aux
   Buraco.y = y2
   Buraco.x = x2
   Sound:play()
end

function Desafio1.mousepressed()
end

function Desafio1.keypressed(key)
  Sound:setVolume(0.15)
  if key=="left" then
    move(-1,0)
  elseif key=="right" then
    move(1,0)
  elseif key=="up" then
    move(0,-1)
  elseif key=="down" then
    move(0,1)
  end
  if completa() then
    cb()
  end
end

function Desafio1.load(callback)
  cb = callback
  Desafio1.BG = love.graphics.newImage("Desafio1_BG.png")
  Desafio1.img = love.graphics.newImage("Desafio1.png")
  w = Desafio1.img:getWidth()
  h = Desafio1.img:getHeight()
  s = size/w
  local count = 1
  for y = 1, 5, 1 do
    Desafio1[y] = {}
    for x = 1, 5, 1 do
      Desafio1[y][x] = {
        quad = love.graphics.newQuad((x-1)*(w/5),(y-1)*(h/5),w/5,h/5,w,h),
        id = count
      }
      count = count + 1
    end
  end
  Desafio1.emb(50)
  ProBuraco()
end

function Desafio1.update(dt) 
end

 function Desafio1.draw()
   love.graphics.draw(Desafio1.BG, 0, 0, 0, 0.8, 0.8)
   love.graphics.draw(Desafio1.img,550,150,0,0.08,0.08)
   for y = 1, 5, 1 do
     for x = 1, 5, 1 do
       love.graphics.draw(Desafio1.img,Desafio1[y][x].quad,(x-1)*(w/5)*s+(wt-size)/2,s*(y-1)*(h/5)+(ht-size)/2,0,s,s)
     end
   end
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("line", 250, 150, size,size)
  love.graphics.line(250, 210, 550, 210)
  love.graphics.line(250, 270, 550, 270)
  love.graphics.line(250, 330, 550, 330)
  love.graphics.line(250, 390, 550, 390)
  love.graphics.line(310, 150, 310, 450)
  love.graphics.line(370, 150, 370, 450)
  love.graphics.line(430, 150, 430, 450)
  love.graphics.line(490, 150, 490, 450)
  love.graphics.setColor(255,255,255)
end

return Desafio1