local enemies = {}
local enemiesTable = {}
local map = require "map"
local utils = require "utils"
local tipo={a={},b={},c={}}

function enemies.newEnemy(x,ty)
  local minion = {}
  minion.x = x
  minion.y= 150
  
  minion.vel_x = -100
  minion.vel_y = 0
  minion.typ = ty
  minion.anim_time=0
  minion.anim_frame=1
  minion.width = 30
  minion.height = 90
  minion.removed = false
  minion.collided = false
  table.insert(enemiesTable, minion)
end


function enemies.load()
  for x=1,5 do
    tipo.a[x]=love.graphics.newImage("imagens/enemy.01.0"..x..".png")
  end
   for x=1,6 do
    tipo.b[x]=love.graphics.newImage("imagens/enemy.02.0"..x..".png")
  end
    for x=1,7 do
    tipo.c[x]=love.graphics.newImage("imagens/enemy.03.0"..x..".png")
  end
  
  
  enemies.newEnemy(love.math.random(800,900),love.math.random(1,3))
  enemies.newEnemy(love.math.random(1100,1300), love.math.random(1,3))
end

function enemies.init()
  local i=0
  for i in pairs(enemiesTable) do
    table.remove(enemiesTable,i)
  end
end


function enemies.updateFrame(dt)
  for i=#enemiesTable, 1, -1 do
    local toRemove = false
    local enemy = enemiesTable[i]
    if enemiesTable[i].removed==false then
      enemiesTable[i].anim_time=enemiesTable[i].anim_time+dt
      if enemiesTable[i].anim_time > 0.1 then
        enemiesTable[i].anim_frame = enemiesTable[i].anim_frame + 1
        enemiesTable[i].anim_time = 0
      end
      if enemiesTable[i].anim_frame > 5 and enemiesTable[i].typ==1 then
        enemiesTable[i].anim_frame = 1
      elseif enemiesTable[i].anim_frame > 6 and enemiesTable[i].typ==2 then
        enemiesTable[i].anim_frame = 1
      elseif enemiesTable[i].anim_frame > 7 and enemiesTable[i].typ==3 then
        enemiesTable[i].anim_frame = 1
      end-- update enemy
    end

    if #enemiesTable<4 then --gera inimigo fora da tela
      local i = 1
      local maxX = 0
      for i=1,#enemiesTable do
        if enemiesTable[i].x > maxX then
          maxX = enemiesTable[i].x
        end   
      end
      enemies.newEnemy(love.math.random(maxX+300,maxX+600),love.math.random(1,3))
    end
  end
end

function enemies.updatePhysics(dt)
  local tolerance = 25
  local i_init, i_end, j_init, j_end, j, i, k
  for i in pairs(enemiesTable,i) do
    j = math.floor(enemiesTable[i].y / map.getTileSize())
    i_init = math.floor ( ( enemiesTable[i].x - enemiesTable[i].width/2 + map.getCameraOffset() ) / map.getTileSize() )
    i_end = math.floor ( ( enemiesTable[i].x + enemiesTable[i].width/2 + map.getCameraOffset() ) / map.getTileSize() )
    j_init = math.floor ( ( enemiesTable[i].y - enemiesTable[i].height ) / map.getTileSize() )
    j_end = math.floor ( ( enemiesTable[i].y ) / map.getTileSize() )
  
    enemiesTable[i].vel_y = enemiesTable[i].vel_y + 20
  
    local toRemove = false
    if enemiesTable[i].removed==false then
      enemiesTable[i].x=enemiesTable[i].x + (enemiesTable[i].vel_x - utils.getSpeed())*dt
    else
      toRemove = true
    end
    if enemiesTable[i].x<-100 then
      toRemove = true
    end
    if toRemove == true then
      table.remove(enemiesTable,i)
    end
    
    if enemiesTable[i].y % map.getTileSize() == 0 and enemiesTable[i].vel_y >= 0 then --Verifica se o inimigo está andando sobre uma superfície
      for k=i_init, i_end do
        if map.getMap() ~= nil then
          if map.getMap()[j] ~= nil then
            if map.getMap()[j][k] == 1 then
              enemiesTable[i].vel_y = 0
              enemiesTable[i].jumpState = 0
            end
          end
        end
      end
    end
  
    if enemiesTable[i].y % map.getTileSize() <= tolerance and enemiesTable[i].y % map.getTileSize() ~= 0 and enemiesTable[i].vel_y > 0 and (enemiesTable[i].typ ~= 2) then
      for k=i_init, i_end do -- Verifica se o inimigo 'caiu dentro' da terra
        if map.getMap() ~= nil then
          if map.getMap()[j] ~= nil then
            if map.getMap()[j][k] == 1 then
              enemiesTable[i].y = map.getTileSize() * math.floor(enemiesTable[i].y/map.getTileSize())
              enemiesTable[i].vel_y = 0
            end
          end
        end
      end
    end
    if (enemiesTable[i].typ ~= 2) then
      enemiesTable[i].y = enemiesTable[i].y + enemiesTable[i].vel_y*dt
    end
  end
end

function enemies.update(dt)
  enemies.updatePhysics(dt)
  enemies.updateFrame(dt)
end

function enemies.draw()
  for i=#enemiesTable, 1, -1 do
    local scale = 1
    local enemy = enemiesTable[i]
    love.graphics.print(tostring(enemiesTable[i].collided), 200, 50*i)
    if enemiesTable[i].removed==false then
      if enemiesTable[i].typ ==1  then
        
        scale = enemiesTable[i].height / tipo.a[1]:getHeight()
        love.graphics.draw( tipo.a[enemiesTable[i].anim_frame], ( enemiesTable[i].x - ( tipo.a[enemiesTable[i].anim_frame]:getWidth() / 2 ) * scale      ) , ( enemiesTable[i].y - enemiesTable[i].height ), 0, scale, scale)
        
      elseif enemiesTable[i].typ==2 then
        
        scale = enemiesTable[i].height / tipo.b[1]:getHeight()
        love.graphics.draw( tipo.b[enemiesTable[i].anim_frame], ( enemiesTable[i].x + ( tipo.b[enemiesTable[i].anim_frame]:getWidth() / 2 ) * scale      ) , ( enemiesTable[i].y - enemiesTable[i].height ), 0, -1*scale, scale)
        
      elseif enemiesTable[i].typ==3 then
        
        scale = enemiesTable[i].height / tipo.c[1]:getHeight()
        love.graphics.draw( tipo.c[enemiesTable[i].anim_frame], ( enemiesTable[i].x - ( tipo.c[enemiesTable[i].anim_frame]:getWidth() / 2 ) * scale      ) , ( enemiesTable[i].y - enemiesTable[i].height ), 0, scale, scale)
        
      end
    end
  end
end

function enemies.getNumberOfEnemies()
  return #enemiesTable
end

function enemies.getHitbox(i)
  local hb =
  {
    x = enemiesTable[i].x,
    y = enemiesTable[i].y,
    w = enemiesTable[i].width,
    h = enemiesTable[i].height
  }
  return hb
end

function enemies.getCollided(i)
  return enemiesTable[i].collided
end

function enemies.setCollided(i,collided)
  enemiesTable[i].collided = collided
end

function enemies.remove(i)
  enemiesTable[i].removed = true
end

return enemies