local mapa = require("map")
local mapa2 = require("map2")
local player = require("player")
local inimigo = require("inimigos")
local collision = require("collision")
local current_map = mapa
local platform = {}

function game_reload()
  player.reload()
end

function game_changeToCave()
  current_map = mapa2
  collision.changeToCave()
end

function game_load()
  mapa.load()
  inimigo.load()
  mapa2.load()
  collision.load()
  player.load()
end
function game_update(dt)
  current_map.update(dt)
  collision.update(dt)
  player.update(dt)
  inimigo.update(dt)
   end
function game_draw()
  --if collision.fase_state == mapa1 then
    current_map.draw()
    player.draw()
    inimigo.draw()
    collision.draw(player.x, player.y, player.w, player.h)
   -- elseif collision.fase_state == mapa2 then
     -- mapa2.draw()
     -- player.draw()
     -- collision.draw(player.x, player.y, player.w, player.h)
    --end
end
function game_keypressed(key,unicode)
  player.keypressed(key)
  if key == "t" then
    gamestate = "game2"
  elseif key == "s" then
    love.event.quit()
  end
end
