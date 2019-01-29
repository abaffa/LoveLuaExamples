local Benicio = love.graphics.newImage("image/seguranca.png")
local Icaro = love.graphics.newImage("image/Icaro.png")
local Sarah = love.graphics.newImage("image/Sarah.png")
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
local spiderDamage = 50
local slimeDamage = 75
local fala1=false
local fala2=false
local fala3=false

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
    escalay=0.25
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
  
      local enemy34 = {  -- mini boss slime
    x = 6950,
    y = 200,
    collided = false,
    dano = 75,
    maxLife = 100,
    life = 140,
    damageTaken = 25,
    escalax=1.5,
    escalay=1.5
  }
  
      local enemy35 = {  -- sala 2 dungeon
    x = 6300,
    y = 3500,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy36 = {
    x = 6580,
    y = 3265,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy37 = {
    x = 7300,
    y = 3265,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy38 = {
    x = 6580,
    y = 3500,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy39 = {
    x = 6940,
    y = 3600,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy40 = {
    x = 7150,
    y = 3650,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy41 = {
    x = 6750,
    y = 3650,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }

      local enemy42 = {
    x = 6940,
    y = 3265,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy43 = {
    x = 7300,
    y = 3500,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy44 = {
    x = 6400,
    y = 3650,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy45 = {
    x = 7450,
    y = 3650,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy46 = {
    x = 6760,
    y = 3400,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy47 = {
    x = 7100,
    y = 3400,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy48 = {
    x = 6580,
    y = 3000,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy49 = {
    x = 7300,
    y = 3000,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy50 = {
    x = 6940,
    y = 3000,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy51 = {
    x = 6350,
    y = 3100,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy52 = {
    x = 7450,
    y = 3100,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
      local enemy53 = {
    x = 7450,
    y = 2900,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  

      local enemy54 = {
    x = 6940,
    y = 2800,
    collided = false,
    dano = 100,
    maxLife = 140,
    life = 140,
    damageTaken = 25,
    escalax=1.5,
    escalay=1.5
  }
  
        local enemy55 = { -- sala 3 dungeon
    x = 6670,
    y = 5350,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
        local enemy56 = {
    x = 7180,
    y = 5350,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
        local enemy57 = {
    x = 6940,
    y = 5240,
    collided = false,
    dano = 75,
    maxLife = 50,
    life = 50,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
        local enemy58 = {
    x = 6860,
    y = 5240,
    collided = false,
    dano = 75,
    maxLife = 100,
    life = 100,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
        local enemy59 = {
    x = 7030,
    y = 5240,
    collided = false,
    dano = 75,
    maxLife = 10,
    life = 100,
    damageTaken = 25,
    escalax=0.5,
    escalay=0.5
  }
  
        local enemy60 = {
    x = 6940,
    y = 5100,
    collided = false,
    dano = 75,
    maxLife = 105,
    life = 105,
    damageTaken = 25,
    escalax=1.5,
    escalay=0.75
  }
  
        local enemy61 = {
    x = 6940,
    y = 4950,
    collided = false,
    dano = 75,
    maxLife = 140,
    life = 140,
    damageTaken = 25,
    escalax=1.5,
    escalay=1.5
  }
  
        local enemy62 = {
    x = 6940,
    y = 4780,
    collided = false,
    dano = 100,
    maxLife = 140,
    life = 140,
    damageTaken = 25,
    escalax=1.5,
    escalay=1.5
  }
  
  
  local enemy63 = { --Boss
    x = 6940,
    y = 4550,
    collided = false,
    dano = 125,
    maxLife = 150,
    life = 150,
    damageTaken = 10,
    escalax=3,
    escalay=3
  }
  
  
  

  --loadSprite(enemy1, "image/goo all.png", 1, 4, 16, 16) --sprite inicial
  loadSprite(enemy1, "image/spider all.png", 1, 4, 16, 16)
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
  loadSprite(enemy35, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy36, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy37, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy38, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy39, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy40, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy41, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy42, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy43, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy44, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy45, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy46, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy47, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy48, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy49, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy50, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy51, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy52, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy53, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy54, "image/bat all.png", 1, 4, 16, 16)
  loadSprite(enemy55, "image/spider all.png", 1, 4, 32, 16)
  loadSprite(enemy56, "image/spider all.png", 1, 4, 32, 16)
  loadSprite(enemy57, "image/goo all.png", 1, 4, 32, 16)
  loadSprite(enemy58, "image/Amitaf all.png", 1, 4, 64, 64)
  loadSprite(enemy59, "image/Amitaf all.png", 1, 4, 64, 64)
  loadSprite(enemy60, "image/spider all.png", 1, 4, 32, 16) --mini boss aranha
  loadSprite(enemy61, "image/goo all.png", 1, 4, 32, 16) -- mini boss slime
  loadSprite(enemy62, "image/bat all.png", 1, 4, 16, 16) -- mini boss morcego
  loadSprite(enemy63, "image/Amitaf all.png", 1, 4, 64, 64) -- boss final 
  
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
  table.insert(enemy.enemies, enemy35)
  table.insert(enemy.enemies, enemy36)
  table.insert(enemy.enemies, enemy37)
  table.insert(enemy.enemies, enemy38)
  table.insert(enemy.enemies, enemy39)
  table.insert(enemy.enemies, enemy40)
  table.insert(enemy.enemies, enemy41)
  table.insert(enemy.enemies, enemy42)
  table.insert(enemy.enemies, enemy43)
  table.insert(enemy.enemies, enemy44)
  table.insert(enemy.enemies, enemy45)
  table.insert(enemy.enemies, enemy46)
  table.insert(enemy.enemies, enemy47)
  table.insert(enemy.enemies, enemy48)
  table.insert(enemy.enemies, enemy49)
  table.insert(enemy.enemies, enemy50)
  table.insert(enemy.enemies, enemy51)
  table.insert(enemy.enemies, enemy52)
  table.insert(enemy.enemies, enemy53)
  table.insert(enemy.enemies, enemy54)
  table.insert(enemy.enemies, enemy55)
  table.insert(enemy.enemies, enemy56)
  table.insert(enemy.enemies, enemy57)
  table.insert(enemy.enemies, enemy58)
  table.insert(enemy.enemies, enemy59)
  table.insert(enemy.enemies, enemy60)
  table.insert(enemy.enemies, enemy61)
  table.insert(enemy.enemies, enemy62)
  table.insert(enemy.enemies, enemy63)
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
      if math.sqrt((1282-playerX)*(1282-playerX)+(1670-playerY)*(1670-playerY))<115 then
      fala1 = true
    else
      fala1 = false
    end
    if math.sqrt((3290-playerX)*(3290-playerX)+(370-playerY)*(370-playerY))<115 and player.wallet<40 then
      fala2 = true
    else
      fala2 = false
    end
    if math.sqrt((7000-playerX)*(7000-playerX)+(55-playerY)*(55-playerY))<145 and player.wallet<180 then
      fala3 = true
    else
      fala3 = false
      end
    
  
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
        enemy1.x=enemy1.x+dirx*175*dt
        enemy1.y=enemy1.y+diry*175*dt
        
      updateCollider(enemy1, enemy1.x, enemy1.y, enemy1.sprite:getWidth(), enemy1.sprite:getHeight()) 
      end
      
      if player.runAnimAttack and dist <=50 then
        enemy1.life = enemy1.maxLife-player.strength -- pode ser: enemy1.maxLife - enemy1.damageTaken
        if enemy1.life <= 0 then
          enemy1.life = 0
          player.wallet=player.wallet+5  
          table.remove(enemy.enemies, i)
        end
        elseif player.specialattack and dist <=75 then
        enemy1.life = enemy1.maxLife-(3*player.strength)
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
  love.graphics.setNewFont("Pixel Digivolve.otf",15)
  if fala1 then
    love.graphics.print("        Não se esqueça de comer!!\n Recupere vida e mana apertando L",1282-camera.offx-170,1670-camera.offy-40,0,1.3,1.3)
  end
  if fala2 then
    love.graphics.print("Para entrar na dungeon acumule 30 $$. \n       Cada inimigo lhe dará 5 $$",3290-camera.offx-190,370-camera.offy+60,0,1.3,1.3)
  end
  if fala2==false and player.wallet>=30 then
    love.graphics.print("        Boa sorte, você precisará! \n  Lembre-se, você possui apenas 3 vidas",3290-camera.offx-190,370-camera.offy+60,0,1.3,1.3)
  end
      
  if fala3==true then
    love.graphics.print("Jovem universitário, por favor, me ajude! \n preciso encontrar Benício, o segurança, \n porém muitos monstros estão a me perseguir.\n Por favor, derrote-os!",7000-camera.offx-190,55-camera.offy+60,0,1.3,1.3)
    elseif fala3==false and player.wallet>=180 then
      love.graphics.print("Muito obrigada! Finalmente \n eu e Benício nos reencontraremos. \n Jamais me esquecerei de você, guerreiro!",7000-camera.offx-190,55-camera.offy+60,0,1.3,1.3)
  end
  
  for i = 1, #enemy.enemies do
    local destX = enemy.enemies[i].x - camera.offx
    local destY = enemy.enemies[i].y - camera.offy
    if enemy.enemies[i].life >0 then
      
    love.graphics.draw(enemy.enemies[i].sprite,Quads[anim_frame],destX,destY,0,enemy.enemies[i].escalax,enemy.enemies[i].escalay)
    
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("fill",destX,destY - 15,enemy.enemies[i].life,5) -- vida inimigos
    end

    love.graphics.setColor(250,250,250)
   -- love.graphics.rectangle("line", pHitbox.x, pHitBox.y, pHitbox.w, pHitbox.h)
    --love.graphics.print(tostring(enemy.enemies[i].collided), 0, 100 + i*25)
    
    love.graphics.draw(Icaro, 3290-camera.offx,370-camera.offy,0,2)
    love.graphics.draw(Benicio,1282-camera.offx,1670-camera.offy,0,2)
    love.graphics.draw(Sarah,7000-camera.offx,55-camera.offy,0,2)

  end
end

return enemy