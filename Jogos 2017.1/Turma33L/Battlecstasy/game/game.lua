local Game = {}
local bump, world, item, pers_posX, pers_posY, playerFilter, arena_bs, pos_chao, bg_images, game_time
local pl1, pl2, winner, loser -- Player Life e Vencedor (3 - empate, 1 - player1 e 2 - player2)
local chao = false

function Game:new(arenaNum, p1, p2, prop, extraX, extraY)
  winner = 0
  loser = 0
  pl1 = 100
  pl2 = 100
  game_time = 100
  arena_bs = require("arenas/arena_base")
  player = require("players/player")
  pos_chao, bg_images = arena_bs:new(arenaNum)
  player:new(p1, p2, pos_chao, prop, extraX, extraY)
  --[[item = {}
  item[1] = {x=0, y=100, w=64, h=64, forca = 0, vely = 300}
  item[2] = {x=700, y=301, w=64, h=63, isItem2 = true}
  item[3] = {x=700, y=300, w=64, h=1, isItem3 = true}
  
  playerFilter = function(item, other)
    if     other.isItem2 then return 'slide'
    elseif other.isItem3 then return 'slide'
    end
  -- else return nil
  end
  
  bump = require("bumplib/bump")
  world = bump.newWorld()
  for i=1,3 do
    world:add(item[i], item[i].x, item[i].y, item[i].w, item[i].h)
  end]] -- USAR NA PARTE DE COLISOES DE CADA PERSONAGEM
end

function Game:update(dt, prop, extraX, extraY)
  pl1, pl2 = player:update(dt, winner, loser, prop, extraX, extraY)
  --print(pl1.."/"..pl2)
  game_time = game_time-dt
  
  -- CONDIÇÕES DE VITÓRIA --
  
  if winner == 0 then
    if pl1 <= 0 then
      game_time = -0.01
    elseif pl2 <= 0 then
      game_time = -0.01
    end
    
    if game_time < 0 then
      if pl1 > pl2 then
        winner = 1
        loser = 2
      elseif pl1 < pl2 then
        winner = 2
        loser = 1
      else
        winner = 3
      end
    elseif pl1 <= 0 then
      winner = 2
      loser = 1
    elseif pl2 <= 0 then
      winner = 1
      loser = 2
    elseif pl2 <= 0 and pl1 <= 0 then
      winner = 3
    end
    -- ASSIM QUE WINNER TROCA DE ZERO PARA OUTRO VALOR, O GAME_TIME É USADO COMO UM TEMPO RESTANTE PARA A TROCA DE TELA.
  -- TROCA DE TELA --
  else
    if game_time < -10 then
      loser, winner = 0, 0
      return 1
    end
  end
  -- MOVIMENTO DO ITEM 1 --
  --[[if love.keyboard.isDown("d") then
    item[1].x = item[1].x+200*dt
    local newX, newY, cols, len = world:move(item[1], item[1].x, item[1].y, playerFilter)
    item[1].x, item[1].y = newX, newY
  elseif love.keyboard.isDown("a") then
    item[1].x = item[1].x-200*dt
    local newX, newY, cols, len = world:move(item[1], item[1].x, item[1].y, playerFilter)
    item[1].x, item[1].y = newX, newY
  end
  
  -- SISTEMA DE GRAVIDADE --
    if not chao then
      item[1].vely = item[1].vely + 981*dt
      item[1].y = item[1].y+item[1].vely*dt+(981/2)*math.pow(dt,2)
    end
    
    if item[1].y+item[1].h>pos_chao then
      item[1].y = pos_chao-item[1].h
      chao = true
    end
    
  -- COLISÃO DO ITEM 1 --
    local newX, newY, cols, len = world:move(item[1], item[1].x, item[1].y, playerFilter)
    
    if item[1].y ~= newY then
      
      if item[1].x > item[2].x+((item[2].w)/2) then
        newX = item[2].x-item[1].w
      elseif item[1].x <= item[2].x+((item[2].w)/2) then
        newX = item[2].x+item[1].w
      end
    end  
    
    item[1].x, item[1].y = newX, newY
  
  -- MOVIMENTO DO ITEM 2 --
  if love.keyboard.isDown("left") then
    for i=2,3 do
      item[i].x = item[i].x-100*dt
      local newX, newY, cols, len = world:move(item[i], item[i].x, item[i].y)
      item[i].x, item[i].y = newX, newY
    end
  end]]
  return 5
end

-- SISTEMA DE GRAVIDADE PARTE 2 --
function Game:keypressed(key)
  --[[if key == "w" and chao then
    chao = false
    item[1].vely = -650
  end]]
end

function Game:draw(prop, extraX, extraY)
  love.graphics.draw(bg_images, extraX, extraY, 0, prop)
  player:draw(prop, extraX, extraY)
  
  local game_text
  if game_time > 10 then
    game_text = math.floor(game_time)
  elseif game_time <= 10 and game_time >= 0 then
    game_text = "0"..math.floor(game_time)
  else
    game_text = "00"
  end
  love.graphics.print(game_text, extraX+380*prop, extraY+100*prop, 0, 1.5*prop)
  --ADICIONAR À COLISÃO NA PARTE DOS PERSONAGENS
  --[[for i=1,2 do
    love.graphics.rectangle("fill", item[i].x, item[i].y, item[i].w, item[i].h)
  end
  love.graphics.setColor(255,0,0)
  love.graphics.rectangle("fill", item[3].x, item[3].y, item[3].w, 1)
  love.graphics.setColor(255,255,255)
  love.graphics.setFont(love.graphics.newFont(18))
  love.graphics.print(tostring(chao))]]
  
end

return Game