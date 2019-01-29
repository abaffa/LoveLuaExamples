local Benicio = love.graphics.newImage("image/seguranca.png")
local enemy = {}
local BossSize = 64
local Quads={}
local anim_frame=1
local animacaotimer=0
local camera = require "camera"
local player = require "player"
enemy.enemies = {}
enemy.map = {}
local enemyLifeLose = 0
local enemyLife = 35

function updateCollider(enemy, new_x, new_y, w, h)
  enemy.collider = {
    x = new_x,
    y = new_y,
    width = w,
    height = h
  }
end

function animacaox (ini,fin)
  if anim_frame <ini or anim_frame>fin then
      anim_frame=ini
    end
    if animacaotimer>0.1 then
      anim_frame=anim_frame+1
      if anim_frame>fin then
         anim_frame=ini
      end
      animacaotimer=0
    end
end

function loadSprite (enemy, filename, nx, ny, sizex, sizey)
  enemy.sprite = love.graphics.newImage(filename)
  local count=1
  for j=0,nx-1,1 do
    for i=0,ny-1,1 do
      Quads[count]=love.graphics.newQuad(i*sizex,j*sizey,sizex,sizey,enemy.sprite:getWidth(),enemy.sprite:getHeight())
      count=count+1
    end
  end
end 

function loadBoss (enemy, filename, nx, ny)
  enemy.sprite = love.graphics.newImage(filename)
  local count=1
  for j=0,nx-1,1 do
    for i=0,ny-1,1 do
      Quads[count]=love.graphics.newQuad(i*BossSize,j*BossSize,BossSize,BossSize,enemy.sprite:getWidth(),enemy.sprite:getHeight())
      count=count+1
    end
  end
end 
function enemy.load() -- função que cria os inimigos

  local enemy1 = {
    x = 1000,
    y = 1450,
    collided = false,
    dano = 50,
    maxLife = 35,  --vida que será diminuida ao levar dano (por exemplo, vida=35 e maxLife = 350, ao levar um dano, o calculo será 350-dano)
    life = 35,      --tamanho da barra de vida inicialmente (padrao=35, fica bonitinho nas aranhas pequenas)
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  local enemy2 = {
    x = 2000,
    y = 650,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.25
  }
  
    local enemy3 = {
    x = 3300,
    y = 750,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.25
  }
  
    local enemy4 = {
    x = 3700,
    y = 1400,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.25
  }
  
    local enemy5 = {
    x = 350,
    y = 300,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.25
  }
  
    local enemy6 = {
    x = 500,
    y = 500,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.25
  }
  
    local enemy7 = {
    x = 3600,
    y = 650,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.25
  }
  
  local enemy8 = {
    x = 900,
    y = 300,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.25
  }
  
    local enemy9 = {
    x = 400,
    y = 1000,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.25
  }
  
  local enemy10 = {
    x = 400,
    y = 1600,
    collided = false,
    dano = 75,
    maxLife = 105,
    life = 105,
    damageTaken = 25,
    escalax=1.5,
    escalay=0.75
  }
  
  local enemy11 = {
    x = 1470,
    y = 200,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.25
  }
  
  local enemy12 = {
    x = 3200,
    y = 1100,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.25
  }
  
    local enemy13 = {
    x = 4120,
    y = 300,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.25
  }
  
      local enemy14 = { --sala 1 Dungeon 
    x = 6870,
    y = 900,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy15 = {
    x = 7200,
    y = 900,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy16 = {
    x = 7400,
    y = 950,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy17 = {
    x = 6300,
    y = 1050,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy18 = {
    x = 6450,
    y = 800,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy19 = {
    x = 6600,
    y = 650,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy20 = {
    x = 6350,
    y = 500,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy21 = {
    x = 7500,
    y = 300,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy22 = {
    x = 7450,
    y = 600,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy23 = {
    x = 6950,
    y = 700,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy24 = {
    x = 7400,
    y = 750,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
        local enemy25 = { --
    x = 7100,
    y = 625,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
        local enemy26 = {
    x = 6700,
    y = 500,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
        local enemy27 = {
    x = 6500,
    y = 500,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
        local enemy28 = {
    x = 7400,
    y = 250,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
        local enemy29 = {
    x = 7150,
    y = 400,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
        local enemy30 = {
    x = 7500,
    y = 850,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
        local enemy31 = {
    x = 7600,
    y = 650,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
        local enemy32 = {
    x = 6650,
    y = 750,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
        local enemy33 = {
    x = 6700,
    y = 350,
    collided = false,
    dano = 50,
    maxLife = 35,
    life = 35,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
        local enemy34 = {
    x = 6950,
    y = 200,
    collided = false,
    dano = 75,
    maxLife = 100,
    life = 100,
    damageTaken = 25,
    escalax=1.5,
    escalay=1.5
  }
  
  
  local enemy40 = { --Boss
    x = 6500,
    y = 5000,
    collided = false,
    dano = 100,
    maxLife = 150,
    life = 150,
    damageTaken = 10,
    escalax=3,
    escalay=3
  }
  
  
  

  --loadSprite(enemy1, "image/goo all.png", 1, 4, 16, 16) --sprite inicial
  loadSprite(enemy1, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy2, "image/spider all.png", 1, 4, 32, 16)
  --loadSprite(enemy3, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy3, "image/spider all.png", 1, 4, 32, 16)
  loadSprite(enemy4, "image/spider all.png", 1, 4, 32, 16)
  loadSprite(enemy5, "image/spider all.png", 1, 4, 32, 16)
  loadSprite(enemy6, "image/spider all.png", 1, 4, 32, 16)
  --loadSprite(enemy7, "image/goo all.png", 1, 4, 16, 16)
  loadSprite(enemy7, "image/spider all.png", 1, 4, 32, 16)
  loadSprite(enemy8, "image/spider all.png", 1, 4, 32, 16)
  loadSprite(enemy9, "image/spider all.png", 1, 4, 32, 16)
  --loadSprite(enemy10, "image/goo all.png", 1, 6, 16, 16)
  loadSprite(enemy10, "image/spider all.png", 1, 4, 32, 16)
  loadSprite(enemy11, "image/spider all.png", 1, 4, 32, 16)
  loadSprite(enemy12, "image/spider all.png", 1, 4, 32, 16)
  loadSprite(enemy13, "image/spider all.png", 1, 4, 32, 16)
  loadSprite(enemy14, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy15, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy16, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy17, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy18, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy19, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy20, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy21, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy22, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy23, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy24, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy25, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy26, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy27, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy28, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy29, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy30, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy31, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy32, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy33, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy34, "image/goo all.png", 1, 4, 32, 16)
  -- loadSprite(enemy25, "image/spider all.png", 1, 4, 32, 16)
  -- loadSprite(enemy26, "image/spider all.png", 1, 4, 32, 16)
  
  
  loadSprite(enemy40, "image/Amitaf all.png", 1, 4, 64, 64)
  
  updateCollider(enemy1, enemy1.x, enemy1.y, enemy1.sprite:getWidth(), enemy1.sprite:getHeight()) --collider na posição inicial
  updateCollider(enemy2, enemy2.x, enemy2.y, enemy2.sprite:getWidth(), enemy2.sprite:getHeight())
  
  table.insert(enemy.enemies, enemy1)
  table.insert(enemy.enemies, enemy2)
  table.insert(enemy.enemies, enemy3)
  table.insert(enemy.enemies, enemy4)
  table.insert(enemy.enemies, enemy5)
  table.insert(enemy.enemies, enemy6)
  table.insert(enemy.enemies, enemy7)
  table.insert(enemy.enemies, enemy8)
  table.insert(enemy.enemies, enemy9)
  table.insert(enemy.enemies, enemy10)
  table.insert(enemy.enemies, enemy11)
  table.insert(enemy.enemies, enemy12)
  table.insert(enemy.enemies, enemy13)
  table.insert(enemy.enemies, enemy14)
  table.insert(enemy.enemies, enemy15)
  table.insert(enemy.enemies, enemy16)
  table.insert(enemy.enemies, enemy17)
  table.insert(enemy.enemies, enemy18)
  table.insert(enemy.enemies, enemy19)
  table.insert(enemy.enemies, enemy20)
  table.insert(enemy.enemies, enemy21)
  table.insert(enemy.enemies, enemy22)
  table.insert(enemy.enemies, enemy23)
  table.insert(enemy.enemies, enemy24)
  table.insert(enemy.enemies, enemy25)
  table.insert(enemy.enemies, enemy26)
  table.insert(enemy.enemies, enemy27)
  table.insert(enemy.enemies, enemy28)
  table.insert(enemy.enemies, enemy29)
  table.insert(enemy.enemies, enemy30)
  table.insert(enemy.enemies, enemy31)
  table.insert(enemy.enemies, enemy32)
  table.insert(enemy.enemies, enemy33)
  table.insert(enemy.enemies, enemy34)
  --table.insert(enemy.enemies, enemy25)
  --table.insert(enemy.enemies, enemy26)
  --table.insert(enemy.enemies, enemy27)
  --table.insert(enemy.enemies, enemy28)
  
  table.insert(enemy.enemies, enemy30)
end

function CheckBoxCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

pHitbox = {
  x = 1,
    y = 1,
    w = 1,
    h = 1
}

function enemy.update(dt)
  
  animacaotimer=animacaotimer+dt
    animacaox(1,4)

  playerX = player.hitboxx -- camerapos_x -16
  playerY = player.hitboxy -- camerapos_y
  
  pHitBox = {
    x = playerX,
    y = playerY,
    w = player.getW(),
    h = player.getH()
  }
  
  for i = 1, #enemy.enemies do
    enemy1 = enemy.enemies[i]
    --enemy1.life=enemy1.life-enemy1.maxLife
    if enemy1 then
      enemy1.collided = false
      
      --if CheckBoxCollision (playerX, playerY, player.getW(),player.getH(),enemy1.x, enemy1.y, enemy1.sprite:getWidth(), enemy1.sprite:getHeight()) and not player.godMode then
     if CheckBoxCollision (playerX, playerY, 16,32,enemy1.x, enemy1.y, 32*enemy1.escalax, 16*enemy1.escalay) and not player.godMode then
        enemy1.collided = true
        player.godMode = true
        --[[if enemy1.x>playerX then
        enemy1.x= enemy1.x+10
      else
        enemy1.x= enemy1.x-10
      end
      if enemy1.y>playerY then
      enemy1.y= enemy1.y+10
      else
        enemy1.y=enemy1.y-10
      end]]
      end
      
      dist = math.sqrt(((playerX-enemy1.x)*(playerX-enemy1.x))+((playerY-enemy1.y)*(playerY-enemy1.y)))
      dir = {x = (playerX-enemy1.x), y = (playerY-enemy1.y)}
      
      dirx=dir.x/dist
      diry=dir.y/dist
      
      if dist <= 250 then
        enemy1.x=enemy1.x+dirx*250*dt
        enemy1.y=enemy1.y+diry*250*dt
        
      updateCollider(enemy1, enemy1.x, enemy1.y, enemy1.sprite:getWidth(), enemy1.sprite:getHeight()) 
      end
      
      if player.runAnimAttack and dist <=50 then
        enemy1.life = enemy1.maxLife-player.strength -- pode ser: enemy1.maxLife - enemy1.damageTaken
        if enemy1.life <= 0 then
          enemy1.life = 0
          player.wallet=player.wallet+5  
          table.remove(enemy.enemies, i)
        end
      end
      if enemy1.collided then
        if enemy.enemies[i].life>0 then
          player.life = player.life - enemy1.dano
        end
        
       --[[ function love.keypressed(key)   -- Substituida para melhorar o alcance do dano
          if key == "j" then]]
                --[[if love.keyboard.isDown ("j") then
          enemy1.life = enemy1.maxLife-player.strength
          if enemy1.life <= 0 then
            enemy1.life = 0
            
            table.remove(enemy.enemies, i)
          end]]
          
          enemy1.maxLife = enemy1.life
        end
      end
    end
  end

  

function enemy.draw()
  for i = 1, #enemy.enemies do
    local destX = enemy.enemies[i].x - camera.offx
    local destY = enemy.enemies[i].y - camera.offy
    if enemy.enemies[i].life >0 then
      
    love.graphics.draw(enemy.enemies[i].sprite,Quads[anim_frame],destX,destY,0,enemy.enemies[i].escalax,enemy.enemies[i].escalay)
    
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("fill",destX,destY - 15,enemy.enemies[i].life,5) -- vida inimigos
    end

    love.graphics.setColor(250,250,250)
    love.graphics.rectangle("line", pHitbox.x, pHitBox.y, pHitbox.w, pHitbox.h)
    love.graphics.print(tostring(enemy.enemies[i].collided), 0, 100 + i*25)
    
    love.graphics.draw(Benicio,1282-camera.offx,1670-camera.offy,0,2)
  end
end

return enemy