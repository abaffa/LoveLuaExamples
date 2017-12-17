local hero = {}

local map = require "map"
local utils = require "utils"

local jumpSpeed = -650

local hero=
{
  active = true,
  alive = true, -- 0=morto, 1=vivo
  jumpState = 0, -- 0=on ground, 1=jumping, 2=doubleJumping
  state = 0, --0=man, 1=wolf
  attackState = 0, --0=not attacking, 1=attacking, 2=cooldown
  width = 30,
  height = 80,
  walk={},
  jumpFrame={},
  wolfWalk={},
  wolfAttack={},
  pos_x=100,
  pos_y=150,
  vel_y=0,
  anim_time=0,
  anim_frame=1,
  deathTimer=0,
  deathCooldown=2,
  attackTimer=0,
  attackTotalTime=0.5,
  attackCooldown=0.5,
  wolfTimer=0,
  totalTimer=4
}


function hero.init()
  utils.setSpeed(200)
  hero.active = true
  hero.alive = true -- 0=morto, 1=vivo
  hero.jumpState = 0 -- 0=on ground, 1=jumping, 2=doubleJumping
  hero.state = 0 --0=man, 1=wolf
  hero.attackState = 0 --0=not attacking, 1=attacking, 2=cooldown
  hero.width = 30
  hero.height = 80
  hero.pos_x=100
  hero.pos_y=540
  hero.vel_y=0
  hero.anim_time=0
  hero.anim_frame=1
  hero.attackTimer=0
  hero.deathTimer=0
  hero.attackTotalTime=0.5
  hero.attackCooldown=1
  hero.wolfTimer=0
  hero.totalTimer=4
end


function hero.load()
  for x=1,3 do
    hero.walk[x]=love.graphics.newImage("imagens/Hero_Walk_0"..(x+1)..".png")
  end
  hero.walk[4]=love.graphics.newImage("imagens/Hero_Walk_03.png")

  for x=1,2 do
    hero.wolfWalk[x]=love.graphics.newImage("imagens/lobo_"..(x+1)..".png")
  end
  for x=3,4 do
    hero.wolfWalk[x]=love.graphics.newImage("imagens/lobo_"..(x-1)..".png")
  end

  hero.wolfAttack[1]=love.graphics.newImage("imagens/lobo_5.png")
  hero.jumpFrame[1]=love.graphics.newImage("imagens/hero_Jump.png")
  hero.anim_time = 0
end


function hero.drawHero()
  local scale = 1.0
  local DBG_HITBOX = 0
  love.graphics.setColor(255,255,255)
  if (hero.state == 0) then -- Humano
    if ( hero.jumpState == 0 ) then -- Não pulando
      scale = hero.height / hero.walk[hero.anim_frame]:getHeight()
      love.graphics.draw( hero.walk[hero.anim_frame], ( hero.pos_x - ( hero.walk[hero.anim_frame]:getWidth() / 2 ) * scale ) , ( hero.pos_y - hero.height ), 0, scale, scale)
    elseif ( hero.jumpState == 1 or hero.jumpState == 2 ) then -- Pulando
      scale = hero.height / hero.jumpFrame[1]:getHeight()
      love.graphics.draw( hero.jumpFrame[1], ( hero.pos_x - ( hero.jumpFrame[1]:getWidth() / 2 ) * scale ) , ( hero.pos_y - hero.height ), 0, scale, scale)
    end
  
  elseif (hero.state == 1) then -- Lobo
    if ( hero.attackState ~= 1 ) then -- Não atacando
      scale = hero.height / hero.wolfWalk[hero.anim_frame]:getHeight()
      love.graphics.draw( hero.wolfWalk[hero.anim_frame], ( hero.pos_x - ( hero.wolfWalk[hero.anim_frame]:getWidth() / 2 ) * scale      ) , ( hero.pos_y - hero.height ), 0, scale, scale)
    elseif ( hero.attackState == 1 ) then -- Atacando
      scale = hero.height / hero.wolfAttack[1]:getHeight()
      love.graphics.draw( hero.wolfAttack[1], ( hero.pos_x - ( hero.wolfAttack[1]:getWidth() / 2 ) * scale ) , ( hero.pos_y -      hero.height ), 0, scale, scale)
    end
  end
  
  if DBG_HITBOX == 1 then
    local hb
    hb = hero.getHitbox()
    love.graphics.rectangle("line", hero.pos_x-hero.width/2,hero.pos_y-hero.height, hero.width, hero.height )
  end
    
end

function hero.getHitbox()
  local hitbox = 
  {
    pos_x = hero.pos_x,
    pos_y = hero.pos_y,
    width = hero.width,
    height = hero.height
  }
  return hitbox
end

function hero.update(dt)
  
  hero.updateTimer(dt)
  if hero.alive == false then
    return
  end
  hero.updateHeroPhysics(dt)
  hero.updateHeroFrame(dt)
end

function hero.updateTimer(dt)
  if hero.alive == false then
    hero.deathTimer = hero.deathTimer + dt
    if hero.deathTimer > hero.deathCooldown then
      hero.active = false
      utils.setSpeed(200)
    end
  end
  
  hero.wolfTimer = hero.wolfTimer + dt
  if (hero.attackState ~= 0 ) then
    hero.attackTimer = hero.attackTimer + dt
  end
  
  if (hero.wolfTimer >= hero.totalTimer) then
    hero.transform()
    hero.wolfTimer = hero.wolfTimer - hero.totalTimer
  end
  if (hero.attackTimer >= hero.attackTotalTime and hero.attackTimer < hero.attackCooldown ) then
    hero.attackState = 2
  elseif (hero.attackTimer >= hero.attackCooldown) then
    hero.attackTimer = 0
    hero.attackState = 0
  end
end
  
function hero.updateHeroPhysics(dt)
  local tolerance = 25
  local i_init, i_end, j
  j = math.floor(hero.pos_y / map.getTileSize())
  i_init = math.floor ( ( hero.pos_x - hero.width/2 + map.getCameraOffset() ) / map.getTileSize() )
  i_end = math.floor ( ( hero.pos_x + hero.width/2 + map.getCameraOffset() ) / map.getTileSize() )
  j_init = math.floor ( ( hero.pos_y - hero.height ) / map.getTileSize() )
  j_end = math.floor ( ( hero.pos_y ) / map.getTileSize() )
  
  if hero.attackState ~= 1 then
    hero.vel_y = hero.vel_y + 20
  end
  
  if hero.pos_y % map.getTileSize() == 0 and hero.vel_y >= 0 then --Verifica se o heroi está andando sobre uma superfície
    for i=i_init, i_end do
      if map.getMap()[j][i] == 1 then
        hero.vel_y = 0
        hero.jumpState = 0
      end
    end
  end

  if hero.pos_y % map.getTileSize() <= tolerance and hero.pos_y % map.getTileSize() ~= 0 and hero.vel_y > 0 then
    for i=i_init, i_end do -- Verifica se o herói 'caiu dentro' da terra
      if map.getMap() ~= nil then
        if map.getMap()[j] ~= nil then
          if map.getMap()[j][i] == 1 then
            hero.pos_y = map.getTileSize() * math.floor(hero.pos_y/map.getTileSize())
            hero.vel_y = 0
            hero.jumpState = 0
          end
        end
      end
    end
  end



  for i=i_init, i_end do -- detecta colisão com o cenário
    for j=j_init, j_end-1 do
      if map.getMap() ~= nil then
        if map.getMap()[j] ~= nil then
          if map.getMap()[j][i] == 1 then
            hero.die()
            love.graphics.printf("teste", 300,300,0,"left",0,3,3)
          end
        end
      end
    end
  end

  hero.pos_y = hero.pos_y + hero.vel_y*dt

end

function hero.updateHeroFrame(dt)
  hero.anim_time = hero.anim_time + dt
  if hero.anim_time > 0.1 then
    hero.anim_frame = hero.anim_frame + 1
    hero.anim_time = 0
  end
  if hero.anim_frame > 4 then
    hero.anim_frame = 1
  end
end

function hero.jump()
  if hero.attackState == 1 and hero.state == 1 then
    return
  end
 
  if hero.jumpState == 0 then
    hero.jumpState = 1
    hero.vel_y = jumpSpeed
  elseif hero.jumpState == 1 then
    if hero.state == 0 then
      hero.jumpState = 2
      hero.vel_y = jumpSpeed
    end
  end
end

function hero.getWolfTimer()
  return hero.wolfTimer
end

function hero.getTotalTimer()
  return hero.totalTimer
end

function hero.transform()
  if (hero.state == 0) then
    hero.state = 1
  elseif hero.state == 1 then
    hero.state = 0
  end
end

function hero.attack()
  if hero.state == 0 then
    return
  end
  if (hero.attackState == 0) then
    hero.attackState = 1
    hero.vel_y=0
    
  end
end

function hero.die()
  utils.setSpeed(0)
  hero.alive=false
end

function hero.getAlive()
  return hero.alive
end

function hero.getAttackState()
  return hero.attackState
end

function hero.getActive()
  return hero.active
end

return hero