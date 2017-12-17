local bullet = require "bullet"

local player = {
 x = 42  ,
 y = 880,
 w =0 , 
 h =0 , 
 hero_frame = 1,
 dir = 1,
 hero_time  = 0 ,-- variavel para controle do tempo da animação
 state = 'idle' ,
 state = {},
 shoot = {},
 shoot2= {},
 idle  = {},
 idle2  = {},
 walk  = {},
 walk2 = {} ,
 collided = false ,
 ground = 752 ,
   y_velocity = 0 ,
 jump_height = -550,    -- Whenever the character jumps, he can reach this height.
 gravity =-900
}

local agua = {
agua_frame = 1,
 agua_time  = 0 ,-- variavel para controle do tempo da animação
 state = 'mexendo' ,
 state = {},
 mexendo= {}
}

local collision = require ("collision")
local escala_x = 0
local jumping=false
local isGrounded = true

local motionless_timer = 0
local motionlessTime = 1

--FUNÇÕES------------------------------------------------------------------

function player.reload()
 player.x = 42
 player.y = 752
 player.dir = 1
 player.hero_time  = 0 -- variavel para controle do tempo da animação
 player.collided = false
 player.y_velocity = 0
end

function player.load()
  player.state = player.idle -- Declara o estado do Herói como parado
  
  for x = 1, 4, 1 do
    player.idle[x] = love.graphics.newImage ("Assets/Idle _0" .. x .. ".png") --Percorre as Sprites do Personagem parado
  end
  for x = 1, 4, 1 do
    player.idle2[x] = love.graphics.newImage ("Assets/Idle_ 0" .. x .. ".png") --Percorre as Sprites do Personagem parado
  end
  for x = 1, 4, 1 do
    player.walk[x] = love.graphics.newImage ("Assets/Walk _0" .. x .. ".png")--Percorre as Sprites do Personagem andando
  end
  for x = 1, 4, 1 do
    player.walk2[x] = love.graphics.newImage ("Assets/Walk_0" .. x .. ".png")--Percorre as Sprites do Personagem andando para o outro lado
  end
  for x = 1, 4, 1 do
    player.shoot[x] = love.graphics.newImage ("Assets/Shoot_0" .. x .. ".png")--Percorre as Sprites do Personagem atirando
  end
  for x = 1, 4, 1 do
    player.shoot2[x] = love.graphics.newImage ("Assets/Shoot2_0" .. x .. ".png")--Percorre as Sprites do Personagem atirando para o outro lado
  end
 for x = 1, 3, 1 do
    agua.mexendo[x] = love.graphics.newImage ("Assets/agua" .. x .. ".png")--Percorre as Sprites da agua
  end
 
 player.w = player.state[player.hero_frame]: getWidth()
 player.h = player.state[player.hero_frame]: getHeight() 
 
 player.y = player.y - player.idle[1]:getHeight()  
 player.ground = player.y 
 
 bullet.load()
end
function player.update(dt)
  
yCollision = false

if collision.checkCollision(player.x, player.y, player.w, player.h)==false then
    BeforeTheCollisionX=player.x
    BeforeTheCollisionY=player.y
end

if love.keyboard.isDown("right") and not love.keyboard.isDown("a")  then  --andar para a player.direita
  player.state = player.walk  -- Declara o estado do Herói como andando
  player.dir = 1 --Declara a variável player.direção para a player.direita
  escala_x = player.dir
  player.hero_time = player.hero_time + dt -- Incrementa o tempo usando dt
  if player.hero_time > 0.1 then -- Quando acumular mais de 0.1
   player.hero_frame =player.hero_frame + 1 -- Avança para proximo frame
    if player.hero_frame > 4 then
      player.hero_frame = 1
    end
    player.hero_time = 0 -- Reinicializa a contagem do tempo
 end
  
elseif love.keyboard.isDown("left") and not love.keyboard.isDown("a")  then --andar para a esquerda
  player.state = player.walk2
  player.dir = -1
  escala_x = player.dir
  player.hero_time = player.hero_time + dt -- Incrementa o tempo usando dt
  if player.hero_time > 0.1 then -- Quando acumular mais de 0.1
    player.hero_frame = player.hero_frame + 1 -- Avança para proximo frame
    if player.hero_frame > 4 then
    player.hero_frame = 1
    end
    player.hero_time = 0 -- Reinicializa a contagem do tempo    
  end

elseif not love.keyboard.isDown("a")  then 
  player.scale = player.dir
  if player.dir == -1 then
    player.state = player.idle2
  elseif player.dir == 1 then
    player.state = player.idle
  end
  player.dir = 0
end 



  if love.keyboard.isDown("a") then 
    player.dir = 0 
    if player.state == player.walk or player.state == player.shoot or player.state == player.idle then   
      player.state = player.shoot -- Declara o estado do Herói como atirando p direita 
    elseif player.state == player.walk2 or player.state == player.shoot2 then
      player.state = player.shoot2 -- Declara o estado do Herói como atirando p esquerda 
    end

    if player.hero_time > 0.1 then -- Quando acumular mais de 0.1
      player.hero_frame = player.hero_frame + 1 -- Avança para proximo frame
      if player.hero_frame > 4 then
        player.hero_frame = 1
      end
      player.hero_time = 0 -- Reinicializa a contagem do tempo
    end
  end    

  if love.keyboard.isDown('space') then
    --if player.y_velocity == 0 then
    if isGrounded == true then
      player.y_velocity = player.jump_height
      isGrounded = false
    end
  end

  --if player.y_velocity ~= 0 then
    moveY = player.y_velocity * dt
    player.y = player.y + moveY
    player.y_velocity = player.y_velocity - player.gravity * dt
  --end

  if player.y > player.ground then
    player.y_velocity = 0
    player.y = player.ground
    isGrounded = true
  end  

  player.x = player.x + (300 * dt* player.dir) -- Equação de movimento

  if collision.checkCollision(BeforeTheCollisionX, BeforeTheCollisionY + moveY, player.w, player.h) then
    yCollision = true
    player.y=BeforeTheCollisionY
    
    if moveY > 0 then
      player.y_velocity = 0
      isGrounded = true
    else
      player.y_velocity = 1
    end
  end

  if collision.checkCollision(player.x, player.y, player.w, player.h) == true then
    player.x=BeforeTheCollisionX
   -- player.y=BeforeTheCollisionY
  end

  if player.x>237 and player.y>695 then
    gamestate = "gameover"
    --player.x = 46  
    --player.y = 883
  end

  -- door to the cave level
  if collision.faseID == 1 then
    -- gets window width to teleport to new level
    -- only teleports if player is grounded
    if player.x > love.graphics.getWidth()*2 - player.w and isGrounded then
       --collision.fase_state=mapa2
       --gamestate = "gameover"
        
       game_changeToCave()
       game_reload()
    end
  end

  if player.x < 0 or player.x > love.graphics.getWidth()*2 - player.w then
    player.x=BeforeTheCollisionX
  end
  
  bullet.update(dt)
end

function player.draw()
  bullet.draw()
  love.graphics.draw(player.state[player.hero_frame], player.x, player.y)
  --love.graphics.print(player.x,0,50)
  --love.graphics.print(player.y,0,100)
  --love.graphics.line(0,player.y,1600,player.y)
  --love.graphics.line(player.x,0,player.x,900)
  
  --if yCollision then
    --love.graphics.print(player.y_velocity)
  --end

end

function player.keypressed(key)
  if key == "j" then
    if player.state == player.idle then
      bullet.spawn(player.x + player.w/2, player.y+ player.h/2, 1)
    elseif player.state == player.idle2 then
      bullet.spawn(player.x + player.w/2, player.y+ player.h/2, -1)
    end
  end
end

return player
