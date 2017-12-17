local DesafioS = {}
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
local SoundS = love.audio.newSource("PotatoWoosh.wav","static")
local tempo = 0
local r
local g
local b
local MusicaS = love.audio.newSource("PotatoMetal.wav", "static")
local laughS = love.audio.newSource("PotatoLaugh.mp3", "static")

local times = {60,120,180,240}
local timeInd = 0

local function completaS()
  local countz = 1
  for i = 1, 5, 1 do
    for j = 1, 5, 1 do
      if DesafioS[i][j].id ~= countz then
        return false
      end
      countz = countz + 1
    end
  end
  return true
end
function DesafioS.emb(num)
  for x=1, num, 1 do
    x1 = love.math.random(1,5)
    x2 = love.math.random(1,5)
    y1 = love.math.random(1,5)
    y2 = love.math.random(1,5)
    aux = DesafioS[x1][y1]
    DesafioS[x1][y1] = DesafioS[x2][y2]
    DesafioS[x2][y2] = aux
  end
end
function emb2S(grid,lin,col)
  local ready = false
  local i,j
  local numbers
  local N
  DesafioS.emb(50)
  while not ready do
    DesafioS.emb(1)
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
    ProBuracoS()
    ready = (N+(Buraco.y - 1)*col + Buraco.x)%2 == 0
  end
end
function ProBuracoS()
  for y=1, 5, 1 do
    for x=1, 5, 1 do
      if DesafioS[y][x].id == 25 then
        Buraco.x = x
        Buraco.y = y
      end
    end
  end
 end
function moveS(dx,dy)
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
   aux = DesafioS[y1][x1]
   DesafioS[y1][x1] = DesafioS[y2][x2]
   DesafioS[y2][x2] = aux
   Buraco.y = y2
   Buraco.x = x2
   SoundS:play()
end

function DesafioS.mousepressed()
end

function DesafioS.keypressed(key)
  if key=="left" then
    moveS(-1,0)
  elseif key=="right" then
    moveS(1,0)
  elseif key=="up" then
    moveS(0,-1)
  elseif key=="down" then
    moveS(0,1)
  end
  if completaS() then
    cb()
  end
end

function DesafioS.load(callback)
  cb = callback
  DesafioS.BG = love.graphics.newImage("Desafio1_BG.png")
  DesafioS.img = love.graphics.newImage("Desafio1.png")
  w = DesafioS.img:getWidth()
  h = DesafioS.img:getHeight()
  s = size/w
  local count = 1
  for y = 1, 5, 1 do
    DesafioS[y] = {}
    for x = 1, 5, 1 do
      DesafioS[y][x] = {
        quad = love.graphics.newQuad((x-1)*(w/5),(y-1)*(h/5),w/5,h/5,w,h),
        id = count
      }
      count = count + 1
    end
  end
  DesafioS.emb(50)
  ProBuracoS()
end

function DesafioS.update(dt)
  MusicaS:setVolume(0.2)
  MusicaS:play()
  tempo = tempo + dt
  r = love.math.random(0,255)
  g = love.math.random(0,255)
  b = love.math.random(0,255)
  if tempo > 300 then
    cb()
  end
  if timeInd < #times then
    if tempo>times[timeInd+1] then
      laughS:play()
      timeInd = timeInd+1
    end
  end
end

 function DesafioS.draw()
  love.graphics.setColor(r,g,b)
  love.graphics.draw(DesafioS.BG, 0, 0, 0, 0.8, 0.8)
  love.graphics.draw(DesafioS.img,550,150,0,0.08,0.08)
  for y = 1, 5, 1 do
    for x = 1, 5, 1 do
      love.graphics.draw(DesafioS.img,DesafioS[y][x].quad,(x-1)*(w/5)*s+(wt-size)/2,s*(y-1)*(h/5)+(ht-size)/2,0,s,s)
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
  love.graphics.rectangle("fill",250,150,300,60*timeInd)
  
  love.graphics.setColor(255,0,0)
  local fonteS = love.graphics.newFont("bloodlust.ttf", 48)
  love.graphics.setFont(fonteS)
  love.graphics.print("Não tem pause",225,30,0,2,2)
  love.graphics.rectangle("fill",550,150,72,72)
  love.graphics.setColor(255,102,255)
  love.graphics.rectangle("fill",700,10,75,20)
  love.graphics.setColor(255,255,255)
 end
 
return DesafioS