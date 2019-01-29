player = {}
bullets = {}
local bear_walk = {}
local bear_anim_frame = 1
local bear_pos_x = 480
local bear_pos_y = 290
local bear_anim_time = 0

-- player significa arma
function player.create()
    --urso load
  for x = 1, 8, 1 do
    bear_walk[x] = love.graphics.newImage("A" ..x.. ".png")
  end 
  
  --sprite player
  player.img = love.graphics.newImage("arma.png")
  
  --x e y do centro da tela
  local x,y = love.graphics.getDimensions()
  x=x/2
  y=y/2
  
  --forma e corpo
  player.shape = love.physics.newCircleShape(24)
  player.body = love.physics.newBody(world,x,y,"kinematic")
  
  --junsta shape com body e define massa como 5
  player.fix = love.physics.newFixture(player.body,player.shape,5)
  
  --delay entre tiros
  player.shoot_time = love.timer.getTime()
end

--desenha o player
function player.draw()
  love.graphics.draw(bear_walk[bear_anim_frame], bear_pos_x, bear_pos_y,0, 0.25, 0.25)
  local draw_x,draw_y = player.body:getWorldPoint(-21.25,-26.5)
  if((math.deg(player.body:getAngle()) >= 90) or (math.deg(player.body:getAngle()) <= -90)) then
    love.graphics.draw(player.img,draw_x,draw_y,player.body:getAngle(), 0.15, -0.15, 200, 300)
  elseif ((math.deg(player.body:getAngle()) < 90) or (math.deg(player.body:getAngle()) > -90)) then
    love.graphics.draw(player.img,draw_x,draw_y,player.body:getAngle(), 0.15, 0.15, 200, -100)
  end
  love.graphics.print(math.deg(player.body:getAngle()), 60, 60)
end


function player.update(dt)
  
  local is_down_kb = love.keyboard.isDown
  local is_down_m = love.mouse.isDown
  
  --pega a posição atual do jogador
  local x,y = player.body:getPosition()
  
  --movimento
 if is_down_kb("a") and (x>26) then
    x = x - 100*dt --esquerda
    bear_pos_x = bear_pos_x - (100 * dt)
    bear_anim_time = bear_anim_time + dt
    if bear_anim_time > 0.1 then
      bear_anim_frame = bear_anim_frame + 1
      if bear_anim_frame > 8 then
        bear_anim_frame = 1
      end
      bear_anim_time = 0
    end
  elseif is_down_kb("d") and (x <love.graphics.getWidth() - 26) then
    x = x + 100*dt --direita
    bear_pos_x = bear_pos_x + (100 * dt)
    bear_anim_time = bear_anim_time + dt
    if bear_anim_time > 0.1 then
      bear_anim_frame = bear_anim_frame + 1
      if bear_anim_frame > 8 then
        bear_anim_frame = 1
      end
      bear_anim_time = 0
    end
  end

  if is_down_kb("w") and (y>42) then
    y = y - 100*dt --cima
    bear_pos_y = bear_pos_y - (100 * dt)
    bear_anim_time = bear_anim_time + dt
    if bear_anim_time > 0.1 then
      bear_anim_frame = bear_anim_frame + 1
      if bear_anim_frame > 8 then
        bear_anim_frame = 1
      end
      bear_anim_time = 0
    end
  elseif is_down_kb("s") and (y < love.graphics.getHeight() - 42) then
    y = y + 100*dt --baixo
    bear_pos_y = bear_pos_y + (100 * dt)
    bear_anim_time = bear_anim_time + dt
    if bear_anim_time > 0.1 then
      bear_anim_frame = bear_anim_frame + 1
      if bear_anim_frame > 8 then
        bear_anim_frame = 1
      end
      bear_anim_time = 0
    end
  end
  
  --atualiza a posição
  player.body:setPosition(x,y)
  
  --angle player to mouse cursor position
 local direction = math.atan2(love.mouse.getY() - y, love.mouse.getX() - x)
 player.body:setAngle(direction)
 
 --atirar
 if is_down_m("l") then
   if math.floor(love.timer.getTime() - player.shoot_time) >= 1 then
     player.shoot()
     player.shoot_time = love.timer.getTime()
   end
  end
end

--Bullet
bullets = {}

function bullets.new(x,y,lx,ly,i)
  local x,y = x,y
  local lx,ly = lx,ly
  table.insert(bullets,{
      x,
      y,
      lx,
      ly,
      body = love.physics.newBody(world,self.x,self.y,"dynamic"),
      shape = love.physics.newCircleShape(5)}
    enemies.create(i)
end

function enemies.create(i)
  --fixa corpo com shape e densidade = 0.1
  enemies[i].fix = love.physics.newFixture(self.body,self.shape,0.1)
  enemies[i].fix:setUserData("bullet")
  
  --começa movimento com velocidade linear
  enemies[i].body:setLinearVelocity(self.lx,self.ly)
end

function enemies.update(dt)
  
  local x,y = enemies[i].body:getPosition()
  
  --se a bala sair da tela ou colidir com outro corpo é deletada
  if x < -5 or x > (love.graphics.getWidth() + 5) or y < -5 or y > (love.graphics.getHeight() + 5) or not enemies[i].fix:getUserData() then 
    enemies[i]destroy()
  end
  
end

function BulletClass:draw()
  love.graphics.circle("fill",enemies[i].body:getX(),enemies[i].body:getY(),enemies[i].shape:getRadius())
end

function BulletClass:destroy()
  --object = nil destroi o objeto
  for i = 1, #bullets, 1 do 
    if self == bullets[i] then
      bullets[i] = nil
    end
  end
end


--shooting 
function player.shoot()
  local x,y = player.body:getWorldPoint(65,5)
  
  --coordenadas de direção do vetor
  local lx,ly = player.body:getWorldVector(400,0)
  
  --indice para novas balas
  local i = #bullets + 1
  
  --create bullet
  bullets[i].new()
end