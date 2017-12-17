local map = {}

local cameraOffset = 0
local mapMatrix = {}
local mapSize = 90
local tileSize = 30
local mapY = 20
local tilesToEndPattern = 0

function map.updateMapMatrix (dt,speed)
  
  cameraOffset = cameraOffset + speed*dt
  
  if cameraOffset >= tileSize then
    tilesToEndPattern = tilesToEndPattern - 1
    cameraOffset = cameraOffset - tileSize
    local i=0
    local j=0
    for i=0,mapY do
      for j=0,mapSize do
        mapMatrix[i][j] = mapMatrix[i][j+1]
      end
      if i > 17 then
        mapMatrix[i][mapSize] = 1
      else
        mapMatrix[i][mapSize] = 0
      end
    end
    if ( tilesToEndPattern <= 0 ) then
      map.createPattern()
    end
  end
end

function map.drawMap()
  local i=0
  local j=0
  for i=0,mapY do
    for j=0, 800/tileSize + 1 do
      if (mapMatrix[i][j] == 1) then
        love.graphics.setColor(0,188,0)
        love.graphics.draw(chao, tileSize*j - cameraOffset, tileSize*i)
      end
    end
  end
end

function map.initMap()
  local i=0
  local j=0
  for i=0,mapY do
    mapMatrix[i] = {}
    for j=0,mapSize do
      if i <= 17 then
        mapMatrix[i][j] = 0
      else
        mapMatrix[i][j] = 1
      end
    end
  end
  --[[mapMatrix[5][4]=1
  mapMatrix[5][5]=1
  mapMatrix[5][6]=1
  mapMatrix[5][30]=1
  
  mapMatrix[14][25]=1
  mapMatrix[15][25]=1
  mapMatrix[16][25]=1
  mapMatrix[17][25]=1]]
end

function map.getTileSize()
  return tileSize
end

function map.getCameraOffset()
  return cameraOffset
end

function map.getMap()
  return mapMatrix
end

function map.createPattern()
  rand = love.math.random(1,2)
  local i, j
  if ( rand == 1 ) then
    tilesToEndPattern = 30
    for i=30,40 do
      mapMatrix[14][i]=1
    end
    
  elseif ( rand == 2 ) then
    tilesToEndPattern = 45
    for i=30, 55 do
      mapMatrix[13][i]=1
    end
    for i=40,50 do
      mapMatrix[8][i]=1
      mapMatrix[8][i+25]=1
    end
  end



end


return map