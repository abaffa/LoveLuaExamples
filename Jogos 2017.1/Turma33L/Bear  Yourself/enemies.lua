local enemies = {}
local index = 1
function enemies.load()
  enemyImage = {love.graphics.newImage("enemy1.png"), love.graphics.newImage("enemy2.png")}
  vida = {2,1}
  dano = {1,2}
  bodyX ={enemyImage[1]:getWidth()*0.1,enemyImage[2]:getWidth()}
  bodyY ={enemyImage[1]:getHeight()*0.1,enemyImage[2]:getHeight()}
end

function enemies.update(dt)
  local x,y
  for i=1, #enemies do
    x,y = enemies[i].body:getPosition(x,y)
    
    --coordenada x
    if math.floor(player.body:getX() - x) ~= 0 then
      -- se a diferença for < 0, inimigo está a esquerda do player, se >0 à direita
      --move esquerda
      if(player.body:getX() - x) < 0 then
        x = x - 20*dt
      else
        x = x + 20*dt
      end
    end
  
    --coordenada y
    if math.floor(player.body:getY() - y) ~= 0 then
      --se a dif < 0 move pra cima
      if(player.body:getY() - y) < 0 then
        y = y - 20*dt
      --se > 0 move pra baixo
      else
        y = y + 20*dt
      end
    end
    enemies[i].body:setPosition(x,y)
  end

end

function enemies.draw()
  
  local draw_x,draw_y
  
  for i=1,#enemies do
    if enemies[i].tipo == 1 then
      draw_x,draw_y = enemies[i].body:getWorldPoint(142.5,142.5)
      love.graphics.draw(enemyImage[1],draw_x,draw_y,0,0.1,0.1,enemyImage[1]:getWidth()/2,enemyImage[1]:getHeight()/2)
    elseif enemies[i].tipo == 2 then
      draw_x,draw_y = enemies[i].body:getWorldPoint(135,135)
      love.graphics.draw(enemyImage[2],draw_x,draw_y,0,1,1,enemyImage[2]:getWidth()/2,enemyImage[2]:getHeight()/2)
    end
  end
end

function checkImgWidth(t)
  if t==1 then
    return enemyImage[t]:getWidth()*0.2
  else
    return enemyImage[t]:getWidth()
  end
end

function checkImgHeight(t)
  if t==1 then
    return enemyImage[t]:getHeight()*0.2
  else
    return enemyImage[t]:getHeight()
  end
end

function enemies.new(ex,ey,tipo)
  local near_player = true
  local x,y = ex,ey
  table.insert(enemies,{
    vida = vida[tipo],
    dano = dano[tipo],
    body = love.physics.newBody(world,bodyX[tipo],bodyY[tipo],"dynamic"),
    shape = love.physics.newRectangleShape(checkImgWidth(tipo),checkImgHeight(tipo)),
    tipo = tipo
  })
  enemies.create(index)
  index = index + 1
end

function enemies.create(i)
    enemies[i].fix = love.physics.newFixture(enemies[i].body,enemies[i].shape,5)
    enemies[i].fix:setUserData("enemy")
end

function enemies.destroy(i)

  table.remove(enemies, i)
  index = index - 1
end

return enemies