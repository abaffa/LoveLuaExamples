CollisionBlocks ={}
local camera = require 'camera' 
function CollisionCheck(posy,posx)
  if camera.mapa[posy][posx] == "A" or camera.mapa[posy][posx] == "T" or camera.mapa[posy][posx] == "L" or camera.mapa[posy][posx] == "R" or camera.mapa[posy][posx] == "Q" or camera.mapa[posy][posx] == "U"or camera.mapa[posy][posx] == "Z" or camera.mapa[posy][posx] == "X" or camera.mapa[posy][posx] == "E" or camera.mapa[posy][posx] == "N" or camera.mapa[posy][posx] == "H" or camera.mapa[posy][posx] == "P" or camera.mapa[posy][posx] == "S" or camera.mapa[posy][posx] == "J" or camera.mapa[posy][posx] == "G" or camera.mapa[posy][posx] == "!"or camera.mapa[posy][posx] == "1"or camera.mapa[posy][posx] == "2"or camera.mapa[posy][posx] == "3"or camera.mapa[posy][posx] == "4"or camera.mapa[posy][posx] == "9" or camera.mapa[posy][posx] == "6"or camera.mapa[posy][posx] == "7" or camera.mapa[posy][posx] == "D" then
    return true
  end
end
return CollisionBlocks