

--Load sprite
enemy_sprite = love.graphics.newImage("enemy.png")

enemies = {}

EnemyClass = {}
function EnemyClass:new()
  local new_obj = {}
  self.__index = self
  return setmetatable(new_obj,self)
end

function EnemyClass:create()
  
  local x,y
  
  local near_player = true
  while near_player do
    --coordenadas aleatórias
    x = love.math.random(0,love.graphics.getWidth())
    y = love.math.random(0,love.graphics.getHeight())
    
    --distancia entre player e inimigo
    local dist_x = math.abs(player.body:getY() - y)
    local dist_y = math.abs(player.body:getX() - x)
    
    --se a distancia > 100 por x e y, sai do loop
    if dist_x > 100 and dist_y > 100 then
      near_player = false
    end
  end
  
  --body,shape,fixture
  self.body = love.physics.newBody(world,x,y,"dynamic")
  self.shape = love.physics.newCircleShape(25)
  self.fix = love.physics.newFixture(self.body,self.shape,5)
  self.fix:setUserData("enemy")
  
  self.destroy = function()
    for i = 1, #enemies, 1 do
      if enemies[i] == self then
        enemies[i] = nil
      end
    end
  end
  
end
  
function EnemyClass:draw()
  
  local draw_x,draw_y = self.body:getWorldPoint(-40,-40)
  
  love.graphics.draw(enemy_sprite,draw_x,draw_y,self.body:getAngle())
  
end

function  EnemyClass:update(dt)
  
  local x,y = self.body:getPosition()
  
  
  --se userData do fixture é falso, inimigo foi morto
  if not self.fix:getUserData() then
    self:destroy()
   --else inimigo anda pro player
  else
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
  
    --angulo do inimigo para o player
    local direction = math.atan2(player.body:getY() - y, player.body:getX() - x)
    self.body:setAngle(direction)
    --atualiza posição
    self.body:setPosition(x,y)
  end
end   