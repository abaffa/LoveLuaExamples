
local mapa2 = {}
local tile_dirt
local background
local tile_platform
local tile_agua
local agua= {}

function LoadMap(Fase)
  local file = io.open(Fase)
  local i = 1
  for line in file:lines() do
    mapa2[i] = {}
    for j=1, #line, 1 do
    mapa2[i][j] = line:sub(j,j)
  end
  i=i+1
end
file:close()
end

function mapa2.load()
  LoadMap2("Fase12.txt")
  tile_dirt = love.graphics.newImage("Assets/dirt.png")
  tile_stone = love.graphics.newImage("Assets/stone.jpg")
  background = love.graphics.newImage("Assets/BG2.jpg")
  tile_platform = love.graphics.newImage("Assets/platform.png")
  tile_agua = love.graphics.newImage("Assets/aguaParada.png")


agua.agua_frame = 1
 agua.agua_time  = 0 -- variavel para controle do tempo da animação
 agua.state = 'mexendo' 
 agua.state = {}
 agua.mexendo= {}
end


function mapa2.update(dt)

 for x = 1, 3, 1 do
    agua.mexendo[x] = love.graphics.newImage ("Assets/agua" .. x .. ".png")--Percorre as Sprites da agua
  end
agua.state = agua.mexendo  -- Declara o estado do Herói como andando
    agua.agua_time = agua.agua_time + dt -- Incrementa o tempo usando dt
    if agua.agua_time > 0.2 then -- Quando acumular mais de 0.1
     agua.agua_frame =agua.agua_frame + 1 -- Avança para proximo frame
      if agua.agua_frame > 3 then
        agua.agua_frame = 1
      end
      agua.agua_time = 0 -- Reinicializa a contagem do tempo
   end
end

function mapa2.draw()
  love.graphics.setColor(170, 170,170)
  love.graphics.draw(background,0,0,0,max_scale/min_scale)
  --love.graphics.reset()
  love.graphics.setColor(255, 255,255)
  for j=1, 48, 1 do
    for i=1, 27, 1 do
      if (mapa[i][j] == "P") then
        love.graphics.draw(tile_stone, (j-1)*34,(i-1)*34)
      elseif (mapa[i][j] == "C") then
        love.graphics.setColor(100, 100, 100)
        love.graphics.draw(tile_platform,(j*32),(i*32))
        love.graphics.reset()
        elseif (mapa[i][j] == "A") then
        love.graphics.draw(agua.state[agua.agua_frame], ((j-1)*34), ((i-1)*34))
      elseif (mapa[i][j] == "W") then
        love.graphics.draw(tile_agua,((j-1)*34), ((i-1)*34))
        end
      end
    end
  end
return mapa2