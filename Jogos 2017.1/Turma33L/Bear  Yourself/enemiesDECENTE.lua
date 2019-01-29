local enemies = {}
local player = require "player"

function enemies.spawn(x,y, tipo)
  table.insert(enemies, {x = x, y = y})
end

function enemies.load()
  --783 x 494 391.5 x 247
  --78.3 x 49.4 39.15 x 24.7
  enemyimage = love.graphics.newImage("enemy1.png")
  enemyspd = 70
  timer = 0
  immortal = false
end

function enemies.update(dt)
  timer = timer + dt
  for i=1 , #enemies do
    if enemies[i] ~= nil then
      local e = enemies[i]
      if e.x + 39.15 < player.pos_x - 16.5 or e.x - 39.15 > player.pos_x + 16.5 then
        if e.x + 39.15 < player.pos_x - 16.5 then
          e.x = e.x + enemyspd*dt
        elseif e.x - 39.15 > player.pos_x + 16.5 then
          e.x = e.x - enemyspd*dt
        end
      end
      if e.y + 24.7 < player.pos_y - 39 or e.y - 24.7 > player.pos_y + 39 then
        if e.y + 24.7 < player.pos_y - 39 then
          e.y = e.y + enemyspd*dt
        elseif e.y - 24.7 > player.pos_y + 39 then
          e.y = e.y - enemyspd*dt
        end
      end
      if math.floor(timer - 1) >= 1 then
        immortal = false
        timer = 0
      end
      if e.x + 39.15 > player.pos_x - 30 and e.x - 39.15 < player.pos_x + 30 then
        if e.y + 24.7 > player.pos_y - 55 and e.y - 24.7 < player.pos_y + 55 then
          if immortal == false then
          immortal = true
          player.vida = player.vida - 1
          end
        end
      end
    end
  end
end


function enemies.draw()
  for i=1, #enemies do
    local e = enemies[i]
    if e.x < player.pos_x then
      enemyscale = -0.1
    elseif e.x > player.pos_x + 33 then
      enemyscale = 0.1
    end
    love.graphics.draw(enemyimage,e.x,e.y,0,enemyscale,0.1,391.5,247)
  end
end

function enemies.die(i)
  table.remove(enemies,i)
end

return enemies