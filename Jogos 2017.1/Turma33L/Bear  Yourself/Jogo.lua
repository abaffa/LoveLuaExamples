local player = require("player")
local enemies = require("enemiesDECENTE")
local bullets = require("bullets")
local mapa = require("mapa")
--local mico = require("mico")
local Jogo = {}

function Jogo.load()
  bgm2 = love.audio.newSource("gamemusic.mp3")
  bgm2:setLooping(true)
  --Create player
  player.create()
  bullets.load()
    -- Create Mico
  --mico.create()
  --timer pros inimigos
  time = love.timer.getTime()
  enemies.load()
  --kills
  killed = 0
end

function Jogo.update(dt)
  if player.vida<=0 then
    changeToMenu()
  end
  mapa.update(dt)
  love.audio.stop(bgm)
  love.audio.play(bgm2)
  --atualiza player
  player.update(dt)
  bullets.update(dt)
  --cria novo inimigo a cada 3s
  if math.floor(love.timer.getTime() - time) >= 3 then
    --adiciona inimigos à tabela
    tipo = love.math.random(1,2) -- tipo de inimigo aleatorio
    ex = love.math.random(0,love.graphics.getWidth())-- x aleatorio para o inimigo
    ey = love.math.random(0,love.graphics.getHeight())-- y aleatorio para o inimigo
    --enemies.new(ex,ey,tipo)--insere inimigo na tabela
    enemies.spawn(ex,ey)
    time = love.timer.getTime()
  end
  --update enemeis
  enemies.update(dt)
  
  for j=#enemies,1,-1 do
    for i=#bullets,1,-1 do
      if bullets[i] ~= nil and enemies[j] ~= nil then
        if collision(i,j) then
          enemies.die(j)
          bullets.die(i)
          killed = killed+1
        end
      end
    end
  end
end

function collision(i,j)
  if bullets[i].x > enemies[j].x - 39.15 and bullets[i].x < enemies[j].x +39.15 then
    if bullets[i].y > enemies[j].y - 24.7 and bullets[i].y < enemies[j].y + 24.7 then
      return true
    end
  else
    return false
  end
end

function Jogo.draw()
  mapa.draw()
  player.draw()
  --draw enemy
  enemies.draw()
  
  bullets.draw()
  
  -- Mico
  --mico.draw()

  love.graphics.print("Killed: "..killed,30,70)
  
  px= 10
  v=math.floor(player.vida/2)
  for i=1,v do
   love.graphics.rectangle("fill",px,10,20,20)
   px = px + 30
  end
  if player.vida%2 == 1 then
    love.graphics.rectangle("fill",px,10,10,20)
  end

end

function Jogo.keypressed(key)
 
  end

function Jogo.keypressed(key)
  if key == "escape" then
    config.destiny = Jogo
    changeToConfig()
  end
 end

function Jogo.mousepressed(button, x, y)
  
end

return Jogo