local mapa = {}
local tile_dirt 
local background
local tile_platform
local tile_dirt_grass
local water
local waterB
local tile_agua
local agua= {}
function LoadMap(filename)
  local file = io.open(filename)
  local i = 1
  for line in file:lines() do
    mapa[i] = {}
    for j = 1, #line, 1 do
      mapa[i][j] = line:sub(j,j)
    end
    i = i + 1
  end
  file:close()
end

function mapa.load()
  LoadMap("FASE1.0.txt")
  tile_dirt = love.graphics.newImage("Assets/dirt1.png")
  tile_platform = love.graphics.newImage("Assets/platform2.png")
  tile_dirt_grass = love.graphics.newImage("Assets/grass.png")
  background = love.graphics.newImage("Assets/BG.png")
  water = love.graphics.newImage("Assets/water.png")
  waterB = love.graphics.newImage("Assets/waterB.png")
  tile_agua = love.graphics.newImage("Assets/aguaParada.png")


  agua.agua_frame = 1
  agua.agua_time  = 0 -- variavel para controle do tempo da animação
  agua.state = 'mexendo' 
  agua.state = {}
  agua.mexendo= {}

  for x = 1, 3, 1 do
    agua.mexendo[x] = love.graphics.newImage ("Assets/agua" .. x .. ".png")--Percorre as Sprites da agua
  end
  
  agua.state = agua.mexendo  -- Declara o estado do Herói como andando
end

function mapa.update(dt)

    agua.agua_time = agua.agua_time + dt -- Incrementa o tempo usando dt
    if agua.agua_time > 0.2 then -- Quando acumular mais de 0.1
     agua.agua_frame =agua.agua_frame + 1 -- Avança para proximo frame
      if agua.agua_frame > 3 then
        agua.agua_frame = 1
      end
      agua.agua_time = 0 -- Reinicializa a contagem do tempo
   end
end

function mapa.draw()
  love.graphics.draw(background)
  for i=1, 27, 1 do
      for j=1, 48, 1 do
        if (mapa[i][j] == "P") then
        love.graphics.draw(tile_dirt, ((j-1)*34),((i-1)*34))
        elseif (mapa[i][j] == "G") then
        love.graphics.draw(tile_dirt_grass, ((j-1)*34),((i-1)*34))
        elseif (mapa[i][j] == "C") then
        love.graphics.draw(tile_platform, ((j-1)*34),((i-1)*34))
        elseif (mapa[i][j] == "W") then
        love.graphics.draw(agua.state[agua.agua_frame], ((j-1)*34),((i-1)*34))
        elseif (mapa[i][j] == "B") then
        love.graphics.draw(waterB, ((j-1)*34),((i-1)*34))  
        end
      end
    end
end
return mapa
  