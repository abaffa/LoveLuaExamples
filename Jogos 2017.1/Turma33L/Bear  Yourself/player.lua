camera = { 
  mapa = {}
}
local bullets =require("bullets")
local player = {
  walk = {},
  lua = {},
  anim_framef = 1,
  anim_frameb = 0,
  pos_x = 480,
  pos_y = 290,
  anim_time = 0,
  vida = 10
}
 -- 33 x 78 16.5 x 39
 -- 264 x 624
function player.create()
  for x = 0, 8, 1 do
    player.walk[x] = love.graphics.newImage("A" ..x.. ".png")
    player.lua[x] = love.graphics.newImage("C" ..x.. ".png")
  end 
  
  shotgun = love.graphics.newImage("arma.png")
  
  w = love.graphics.getWidth()
  h = love.graphics.getHeight()
  bearcenterx = 132 * 0.125
  bearcentery = 312 * 0.125
  shotgunx = player.pos_x
  shotguny = player.pos_y
  player.shoot_time = love.timer.getTime()
end

--desenha o player
function player.draw()
  love.graphics.draw(player.walk[player.anim_framef], player.pos_x, player.pos_y,0, 0.125, 0.125,132,312)
  if((math.deg(direction) >= 90) or (math.deg(direction) <= -90)) then
    love.graphics.draw(shotgun,shotgunx,shotguny,direction, 0.08, -0.08,shotgun:getWidth()/2, shotgun:getHeight()/2)
  elseif ((math.deg(direction) < 90) or (math.deg(direction) > -90)) then
    love.graphics.draw(shotgun,shotgunx,shotguny,direction, 0.08, 0.08, shotgun:getWidth()/2, shotgun:getHeight()/2)
  end
    love.graphics.draw(player.lua[player.anim_frameb], player.pos_x, player.pos_y,0, 0.125, 0.125,132,312)

  --bullets.draw()
end


function player.update(dt)
  
  local is_down_kb = love.keyboard.isDown
  local is_down_m = love.mouse.isDown
  
  if player.pos_x > w - bearcenterx then
    player.pos_x = w - bearcenterx
  elseif player.pos_x < 0 + bearcenterx then
    player.pos_x = 0 + bearcenterx
  end
  
  if player.pos_y > h - bearcentery then
    player.pos_y = h - bearcentery
  elseif player.pos_y < 0 + bearcentery then
    player.pos_y = 0 + bearcentery
  end
  
  --bullets.update(dt)
  
  --pega a posição atual do jogador
  --local x,y = player.body:getPosition()
  
    if player.anim_frameb == 0 and player.anim_framef == 0 then
    player.anim_framef = 1
    end
  
  
   --movimento
 if is_down_kb("a") then
    player.pos_x = player.pos_x - (100 * dt)
    player.anim_time = player.anim_time + dt
    if is_down_kb("w") then
      player.anim_framef = 0
      else
    player.anim_frameb = 0
    end
    if player.anim_time > 0.1 then
      player.anim_framef = player.anim_framef + 1
      if player.anim_framef > 8 then
        player.anim_framef = 1
      end
      player.anim_time = 0
    end
  elseif is_down_kb("d") then
    player.pos_x = player.pos_x + (100 * dt)
    player.anim_time = player.anim_time + dt
    if is_down_kb("w") then
     player.anim_framef = 0
     else
     player.anim_frameb = 0
    end
    if player.anim_time > 0.1 then
      player.anim_framef = player.anim_framef + 1
      if player.anim_framef > 8 then
        player.anim_framef = 1
      end
      player.anim_time = 0
    end
  end
  print(player.vida)
  if is_down_kb("w") then
    player.anim_time = player.anim_time + dt
    player.anim_framef = 0
    if player.anim_time > 0.1 then
      player.anim_frameb = player.anim_frameb + 1
      if player.anim_frameb > 8 then
        player.anim_frameb = 1
      end
      player.anim_time = 0
    end
  elseif is_down_kb("s") then
    player.anim_time = player.anim_time + dt
    player.anim_frameb = 0
    if player.anim_time > 0.1 then
      player.anim_framef = player.anim_framef + 1
      if player.anim_framef > 8 then
        player.anim_framef = 1
      end
      player.anim_time = 0
    end
  end
  shotgunx = player.pos_x
  shotguny = player.pos_y+14
  --atualiza a posição
  
  --angle player to mouse cursor position
 direction = math.atan2(love.mouse.getY() - player.pos_y, love.mouse.getX() - player.pos_x)
 dx = love.mouse.getX() - player.pos_x
 dy = love.mouse.getY() - player.pos_y
  if is_down_kb("q") then
    player.vida = player.vida-1
  end

 --atirar
 --dependendo da versão pode ser 1 ou l
 if is_down_kb("e") then
   if math.floor(love.timer.getTime() - player.shoot_time) >= 1 then
     player.shoot()
     player.shoot_time = love.timer.getTime()
   end
  end
end

--shooting 
function player.shoot()
  bullets.new(player.pos_x,player.pos_y,dx,dy)
end

function player.mousepressed(x,y,but)
  end

return player