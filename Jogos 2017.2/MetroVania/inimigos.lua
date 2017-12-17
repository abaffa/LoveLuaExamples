local inimigo= {}
local collision = require "collision"
local player = require "player"
local bullet = require "bullet"
local escala_x
local origem_x
local origem_y
alturaTela  = love.graphics.getHeight()
larguraTela = love.graphics.getWidth()
local x = 200
local speed = 128
local y = 750
local elapsedTime = 0

local aranha = {
  walk = {},
  coll_percent_x = 0.5,
  coll_percent_y = 0.5,
  speedx = 200,
  speedy = 0,
  origem_x = 0,
  origem_y = 0, 
  spawn = {}
}

local boomer = {
  walk = {},
  coll_percent_x = 0.5,
  coll_percent_y = 0.5,
  speedx = 200,
  speedy = 0,
  origem_x = 0,
  origem_y = 0, 
  spawn = {}
}
   
function inimigo.load()
--lado = 'd'
  for x = 1, 4, 1 do
    aranha.walk[x] = love.graphics.newImage ("Assets/Spider_0" .. x .. ".png")--Percorre as Sprites do Personagem andando
  end
--Para criar inimigo
--inimigo.spawn("nome",dir,x,y,quanto que ele percorre)
--primeira aranha
  inimigo.spawn("spider", 1, 300, 750, 50)
--segunda aranha(Primeira Plataforma)
  inimigo.spawn("spider", -1, 400, 580, 50)
--terceira aranha(Segunda Plataforma)
  inimigo.spawn("spider", 1, 1200, 580, 50)
--quarta aranha 
  inimigo.spawn("spider", -1, 1350, 750, 230)

  
  inimigo.spawn("boomer", 1, 200 + 600, 300, 200)
  inimigo.spawn("boomer", 1, 400, 780, 100)
  --inimigo.spawn(1, 200 + 1000, 750 - 150, 100)
  
  aranha.width = aranha.walk[1]:getWidth() * aranha.coll_percent_x
  aranha.height = aranha.walk[1]:getWidth() * aranha.coll_percent_y
  
  aranha.origem_x = aranha.walk[1]:getWidth()/2 -- Muda a origem da imagem do personagem
  aranha.origem_y = aranha.walk[1]:getHeight()/2-- Muda a origem da imagem do personagem
  
  for x = 1, 4, 1 do
    boomer.walk[x] = love.graphics.newImage ("Assets/boomer1.png")--Percorre as Sprites do Personagem andando
  end
  
  boomer.width = boomer.walk[1]:getWidth() * boomer.coll_percent_x
  boomer.height = boomer.walk[1]:getHeight() * boomer.coll_percent_y
  
  boomer.origem_x = boomer.walk[1]:getWidth()/2 -- Muda a origem da imagem do personagem
  boomer.origem_y = boomer.walk[1]:getHeight()/2-- Muda a origem da imagem do personagem
  
end

function inimigo.spawn(enemy, direction, xInit, yInit, max_movement)
  if enemy == "spider" then
    table.insert(aranha.spawn, {
                    anim_time = 0,
                    anim_frame = 1,
                    dir = direction,
                    x_init = xInit,
                    y_init = yInit,
                    x = xInit,
                    y = yInit,
                    move_limit = max_movement
                })
  elseif enemy == "boomer" then
    table.insert(boomer.spawn, {
                anim_time = 0,
                anim_frame = 1,
                dir = direction,
                x_init = xInit,
                y_init = yInit,
                x = xInit,
                y = yInit,
                move_limit = max_movement
            })
  end
end

function inimigo.update(dt)
  local enemy_class = aranha
  
  if collision.faseID == 1 then
    enemy_class = aranha
  else
    enemy_class = boomer
  end
  
  for i = #enemy_class.spawn, 1, -1 do
      local enemy = enemy_class.spawn[i]
    
      if enemy.dir == 1 then
        if enemy.x > enemy.x_init + enemy.move_limit then
          enemy.dir = -1
        end
      else
        if enemy.x < enemy.x_init - enemy.move_limit then
          enemy.dir = 1
        end
      end
    
      enemy.x = enemy.x + enemy_class.speedx * dt * enemy.dir
      
      if collision.CheckBoxCollision(player.x, player.y, player.w, player.h, enemy.x - enemy_class.width/2, enemy.y - enemy_class.height/2, enemy_class.width,enemy_class.height) then
        gamestate = "gameover"
      end
      
      if enemy_class == boomer then
        if distancia(player.x, player.y, enemy.x, enemy.y) <= 200 then
          --enemy.explode()
        end
      end
      
      verify_enemy_collision(enemy, i, enemy_class, dt)
    end
  
  animation(dt)  

end

function distancia(p_x, p_y, e_x, e_y)
  return (p_x - e_x)^2 + (p_y - e_y)^2 
end

function verify_enemy_collision(enemy, i, enemy_class, dt)
  
  for j = #bullet.shots, 1, -1 do
    local b = bullet.shots[j]
    if collision.CheckBoxCollision(enemy.x - enemy_class.width/2, enemy.y - enemy_class.height/2, enemy_class.width,enemy_class.height, b.x, b.y, bullet.image:getWidth(), bullet.image:getHeight()) then
      table.remove(bullet.shots, j)
      table.remove(enemy_class.spawn, i)
    end
  end
end

function animation(dt)
  local enemy_class = aranha
  
  if collision.faseID == 1 then
    enemy_class = aranha
  else
    enemy_class = boomer
  end
  
  for i = #enemy_class.spawn, 1, -1 do
    local enemy = enemy_class.spawn[i]
    enemy.anim_time = enemy.anim_time + dt -- Incrementa o tempo usando dt

    if enemy.anim_time > 0.1 then -- Quando acumular mais de 0.1
      enemy.anim_frame = enemy.anim_frame + 1 -- Avança para proximo frame
      if enemy.anim_frame > 4 then
        enemy.anim_frame = 1
      end
      enemy.anim_time = 0 -- Reinicializa a contagem do tempo
    end  
  end
  
end

function inimigo.draw()
  love.graphics.setColor(255,0,0)
  
  love.graphics.setColor(255,255,255)
  
  local enemy_class = aranha
  
  if collision.faseID == 1 then
    enemy_class = aranha
  else
    enemy_class = boomer
  end
  
  for i = 1, #enemy_class.spawn do
    enemy = enemy_class.spawn[i]
    love.graphics.draw(enemy_class.walk[enemy.anim_frame], enemy.x, enemy.y,0,-enemy.dir, 1, enemy_class.origem_x,enemy_class.origem_y)
    --love.graphics.rectangle("line", enemy.x - enemy_class.width/2, enemy.y - enemy_class.height/2, enemy_class.width,enemy_class.height)
  end

  --love.graphics.draw(aranha.walk[aranha.anim_frame], x+ 900, y,0,aranha.dir, 1,origem_x,origem_y)
  --love.graphics.draw(aranha.walk[aranha.anim_frame], x+ 850, y-150,0,aranha.dir, 1,origem_x,origem_y)
end
return inimigo