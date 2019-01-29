opendoor = {}
local  opendoor = require 'camera'
local dungeoncount=0
local enemy=require'enemy'
local player = require 'player'
function opendoor (posy,posx)
  if camera.mapa[posy][posx] == "B" and player.wallet>=30 then
    love.graphics.setBackgroundColor(0,0,0)
    LoadMap("dungeon1.txt")
    map_config.tam_x=141
    map_config.tam_y= 21
    player.px=6952
    player.py=1125
    player.respawx=6952
    player.respawy=1125
    map_config.display_x = 14
    map_config.display_y = 11
  elseif camera.mapa[posy][posx] == "5" then
    LoadMap("dungeon2.txt")
    map_config.tam_x=141
    map_config.tam_y= 62
    player.px=6952
    player.py=3735
    player.respawx=6952
    player.respawy=3700
  elseif camera.mapa[posy][posx] == "i" then
    LoadMap("boss.txt")
    map_config.tam_x=141
    map_config.tam_y= 89
    player.px=6952
    player.py=5470
    player.respawx=6952
    player.respawy=5470
  elseif camera.mapa[posy][posx] == "D" then
    LoadMap("mapa.txt")
    map_config.tam_x=78
    map_config.tam_y=31
    player.px=3360
    player.py=410
    player.respawx=3360
    player.respawy=410
    elseif camera.mapa[posy][posx] == "p" then
    LoadMap("mapa.txt")
    map_config.tam_x=78
    map_config.tam_y=31
    player.px=3360
    player.py=410
    player.respawx=3360
    player.respawy=410
    elseif camera.mapa[posy][posx] == "b" then
    LoadMap("mapa.txt")
    map_config.tam_x=78
    map_config.tam_y=31
    player.px=3360
    player.py=410
    player.respawx=3360
    player.respawy=410
  end
end
return opendoor