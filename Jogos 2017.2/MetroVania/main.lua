require "init_"
require "game_"
require "game2_"
require "gameover_"
music = require "music"
gamestate = "init"

local w,h = 800,600
min_scale = math.min(w/1600, h/900)
max_scale = math.max(w/1600, h/900)

function love.load()
  gamestate = "init"
  screen_w = love.graphics.getWidth()
  screen_h = love.graphics.getHeight()
  print(screen_w)
  print(screen_h)
  init_load()
  game_load()
  --game2_load()
  music.load()
  gameover_load()
end
function love.update(dt)
  if gamestate == "init" then
    init_update(dt)
  elseif gamestate == "game" then
    game_update(dt)
  --elseif gamestate == "game2" then
    --game2_update(dt)
  end
    music.update(gamestate)
end

function love.draw()
  love.graphics.scale(min_scale)
  if gamestate == "init" then
    init_draw()
  elseif gamestate == "game" then
    game_draw()
  --elseif gamestate == "game2" then
    --game2_draw()
  elseif gamestate == "gameover" then
    gameover_draw()
  end
end

function love.keypressed(key,unicode)
  if gamestate == "init" then
    init_keypressed(key,unicode)
  elseif gamestate == "game" then
    game_keypressed(key,unicode)
  elseif gamestate == "gameover" then
    gameover_keypressed(key,unicode)
  end
end