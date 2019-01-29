local mapa = {}
local tilesetImage
local tileQuads = {}
local tileSize = 25
local player = require 'player'
local cutscene2 = require 'cutscene2'
local mapa_config = {
mapaSize_x = 32,
mapaSize_y = 120,
mapaDisplay_x = 32,
mapaDisplay_y = 24
}
local camera = {
pos_x = 1,
pos_y = 2400,
speed = 100
}

 function LoadMap(filename)
   local file = io.open(filename)
   local i = 1
   for line in file:lines() do
     mapa [i] = {}
     for j=1, #line, 1 do
       mapa[i][j] = line:sub(j,j)
     end
     i = i + 1
   end
   file:close()
end

function mapa.update(dt)
  if love.keyboard.isDown('s') then
    camera.pos_y = camera.pos_y + (100* dt)
  elseif love.keyboard.isDown('w') then
    camera.pos_y = camera.pos_y - (100 * dt)
  end
  if camera.pos_y < 0 then
    camera.pos_y = 0
  elseif camera.pos_y > mapa_config.mapaSize_y * tileSize - mapa_config.mapaDisplay_y * tileSize - 1 then
    camera.pos_y = mapa_config.mapaSize_y * tileSize - mapa_config.mapaDisplay_y * tileSize - 1
  end
  if camera.pos_y < 5 then
    changeToCutscene2()
  end
end

function mapa.load()
  LoadMap("Mapa_1.txt")
  tile = {
    grama = love.graphics.newImage("chao.png"),
    pedra = love.graphics.newImage("pedra.png"),
    arbusto = love.graphics.newImage("arbusto.png"),
    rua = love.graphics.newImage("rua1.png")
    }
end

function mapa.draw()
  offset_y = math.floor(camera.pos_y % tileSize)
  first_tile_y = math.floor(camera.pos_y / tileSize)
  for y=1, mapa_config.mapaDisplay_y+1, 1 do
   for x=1, mapa_config.mapaDisplay_x+1, 1 do
  --[[ Legenda:
  F=Chão
  D=Porta
  G=Grade
  S=Pedra
  W=Parede
  R=Rua
  ]]

     if(mapa[first_tile_y + y][x] == "F") then
      love.graphics.draw(tile.grama, ((x-1)*tileSize),((y-1)*tileSize) - offset_y)
     elseif(mapa[first_tile_y + y][x] == "D") then
      love.graphics.draw(tile.rua, ((x-1)*tileSize),((y-1)*tileSize) - offset_y)
     elseif(mapa[first_tile_y + y][x] == "S") then
      love.graphics.draw(tile.pedra, ((x-1)*tileSize),((y-1)*tileSize) - offset_y)
     elseif(mapa[first_tile_y + y][x] == "W") then
      love.graphics.draw(tile.arbusto, ((x-1)*tileSize),((y-1)*tileSize) - offset_y)
     elseif(mapa[first_tile_y + y][x] == "R") then
      love.graphics.draw(tile.rua, ((x-1)*tileSize),((y-1)*tileSize) - offset_y)
      end
   end
 end
end

return mapa