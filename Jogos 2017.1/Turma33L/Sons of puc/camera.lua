camera={
mapa = {}
}
--local tilesetImage
local tileQuads = {}
local tileSize = 64
--[[local imageDungeon = love.graphics.newImage("image/dungeon.png")
local imageFloor = love.graphics.newImage("image/pisos.png")
local imageTrees = love.graphics.newImage("image/arvores.png")
local imageGrama = love.graphics.newImage("image/grama.png")
local imageAgua = love.graphics.newImage("image/agua.png")]]
local imageTudo =love.graphics.newImage("image/tudo3.png")
camerapos_x = 1
camerapos_y = 1
local player = require'player'


 map_config={
  tam_x = 78,
  tam_y = 31,
  display_x = 14,
  display_y = 11
  --display_x = 14,
  --display_y = 11
 }
function LoadTiles(filename,nx,ny)
  tilesetImage = love.graphics.newImage(filename)
  local count=1
  for i=0,nx-1,1 do
    for j=0,ny-1,1 do
      tileQuads[count]=love.graphics.newQuad(i*tileSize,j*tileSize,tileSize,tileSize,tilesetImage:getWidth(),tilesetImage:getHeight())
      count=count+1
    end
  end
end
function LoadMap(filename)
  local file = io.open(filename)
  local i=1 
  for line in file:lines() do 
    camera.mapa[i]={}
    for j=1, #line,1 do
      camera.mapa[i][j]= line:sub(j,j)
    end
    i=i+1
  end
  file:close()
end

function camera.load()
  local camerapos_x 
  local camerapos_y
  player.load()
  LoadMap("mapa.txt")
  --LoadMap("enemymap.txt")
  LoadTiles("image/tudo3.png",5,10)
  love.graphics.setBackgroundColor(162,209,250)
end

function camera.update(dt)
 camerapos_x=player.px-love.graphics.getWidth()/2 
 camerapos_y=player.py- love.graphics.getHeight()/2
 if camerapos_x<0 then
    camerapos_x=0
  end
  if camerapos_y<0 then
    camerapos_y=0
  end
  if camerapos_x>map_config.tam_x*tileSize-map_config.display_x*tileSize-1 then
    camerapos_x=map_config.tam_x*tileSize-map_config.display_x*tileSize-1
  end
  if camerapos_y>map_config.tam_y*tileSize-map_config.display_y*tileSize-1 then
    camerapos_y=map_config.tam_y*tileSize-map_config.display_y*tileSize-1
  end
end
      
function camera.draw()
  offset_x=math.floor(camerapos_x%tileSize)
  offset_y=math.floor(camerapos_y%tileSize)
  camera.offx=camerapos_x
  camera.offy=camerapos_y
  first_tile_x=math.floor(camerapos_x/tileSize)
  first_tile_y=math.floor(camerapos_y/tileSize)
  for y= 1, map_config.display_y,1 do
    for x=1, map_config.display_x, 1 do
      
      function DrawTiles(tileset,coord)
        love.graphics.draw (tileset,tileQuads[coord],((x-1)*tileSize)-offset_x,((y-1)*tileSize)-offset_y)
      end
      
      if (camera.mapa[first_tile_y+y][first_tile_x+x]=="C") then
        DrawTiles(imageTudo,1)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="L") then
        DrawTiles(imageTudo,1)
        DrawTiles(imageTudo,14)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="A") then
        DrawTiles(imageTudo,4)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="R") then
        DrawTiles(imageTudo,1)
        DrawTiles(imageTudo,24)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="M") then
        DrawTiles(imageTudo,20)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="W") then 
        DrawTiles(imageTudo,13)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="T") then
        DrawTiles(imageTudo,1)
        DrawTiles(imageTudo,3)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="Q") then
        DrawTiles(imageTudo,22)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="U") then
        DrawTiles(imageTudo,12)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="D") then
        DrawTiles(imageTudo,6)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="Z") then
        DrawTiles(imageTudo,7)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="X") then
        DrawTiles(imageTudo,25)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="J") then
        DrawTiles(imageTudo,23)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="I") then
        DrawTiles(imageTudo,4)
        DrawTiles(imageTudo,9)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="K") then
        DrawTiles(imageTudo,4)
        DrawTiles(imageTudo,10)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="F") then
        DrawTiles(imageTudo,4)
        DrawTiles(imageTudo,29)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="V") then
        DrawTiles(imageTudo,4)
        DrawTiles(imageTudo,30)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="Y") then
        DrawTiles(imageTudo,4)
        DrawTiles(imageTudo,19)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="E") then
        DrawTiles(imageTudo,5)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="P") then
        DrawTiles(imageTudo,26)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="N") then
        DrawTiles(imageTudo,27)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="H") then
        DrawTiles(imageTudo,18)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="G") then
        DrawTiles(imageTudo,28)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="B") then
        DrawTiles(imageTudo,6)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="S") then
        DrawTiles(imageTudo,2)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="@") then
        DrawTiles(imageTudo,39)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="6") then
        DrawTiles(imageTudo,35)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="7") then
        DrawTiles(imageTudo,36)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="1") then
        DrawTiles(imageTudo,34)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="2") then
        DrawTiles(imageTudo,33)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="!") then
        DrawTiles(imageTudo,37)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="9") then
        DrawTiles(imageTudo,39)
        DrawTiles(imageTudo,38)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="3") then
        DrawTiles(imageTudo,37)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="4") then
        DrawTiles(imageTudo,37)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="<") then
        DrawTiles(imageTudo,47) 
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]==">") then
        DrawTiles(imageTudo,46) 
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="$") then
        DrawTiles(imageTudo,43)  
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="%") then
        DrawTiles(imageTudo,48) 
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="(") then
        DrawTiles(imageTudo,44) 
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]==")") then
        DrawTiles(imageTudo,42)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="+") then
        DrawTiles(imageTudo,40)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="-") then
        DrawTiles(imageTudo,41)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="=") then
        DrawTiles(imageTudo,45)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="&") then
        DrawTiles(imageTudo,45)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="5") then
        DrawTiles(imageTudo,6)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="i") then
        DrawTiles(imageTudo,6)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="p") then
        DrawTiles(imageTudo,6)
      elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="b") then
        DrawTiles(imageTudo,6)
      
      
      
      
      --elseif (camera.mapa[first_tile_y+y][first_tile_x+x]=="I") then
        --tilesetImage= imageFloor
        --love.graphics.draw(tilesetImage,tileQuads[1],((x-1)*tileSize)-offset_x,((y-1)*tileSize)-offset_y)
      end
    end
  end
player.draw(-camerapos_x,-camerapos_y)
 end
return camera