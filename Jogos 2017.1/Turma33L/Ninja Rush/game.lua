local game = {}

local tempo = 0
 
local gravity = 1000

local collidedwith = 0

local death={}

-- Cenário
 local cenario = {
   image_tunel,
   pos_x = 0,
   vel_x = 100,
   acel_x = 0.13
 }

-- Ninja
 local ninja = {
   images = {},
   isJumping = false,
   anim_frame = 1,
   anim_time = 0,
   pos_x = 150,
   pos_y = 470,
   scale = 0.22,
   vel_y = 50,
   n_jumps = 0,
   max_jumps = 2,
   w=70,
   h=92,
   collided = false
 }
 
-- Carros
 local carros = {
   image = {},
   timer = 0,
   vel_x = -300,
   acel_x = 0.2,
   posicoes = {
     {x=1100, y=466.7},
     {x=1100, y=442.7},
     {x=1100, y=450.7},
     {x=1100, y=421.7},
     {x=1100, y=451.7},
     {x=1100, y=423.7},
     {x=1100, y=411.7}
   },
   morte = {
    {x=16, y=484.7, w=82,  h=82}, --0
    {x=07, y=464.7, w=84,  h=93}, --1
    {x=09, y=468.7, w=103, h=87}, --2
    {x=10, y=490.7, w=98,  h=66}, --3
    {x=12, y=487.7, w=90,  h=78}, --4
    {x=10, y=470.7, w=105, h=111},--5
    {x=19, y=446.7, w=68,  h=144} --6
  },
    dimensoes = {
    {x=98,  y=483.7, w=156, h=69}, --0
    {x=84,  y=463.7, w=140, h=93}, --1
    {x=112, y=469.7, w=129, h=87}, --2
    {x=108, y=490.7, w=98,  h=66}, --3
    {x=102, y=486.7, w=126, h=78}, --4
    {x=115, y=440.7, w=176, h=111},--5
    {x=87,  y=424.7, w=77,  h=171} --6
   }
 }
 
  function game.unload(id)
    
    
collidedwith = 0
    
gravity = 1000
    
 tempo = 0
 
 cenario = {
   image_tunel,
   pos_x = 0,
   vel_x = 100,
   acel_x = 0.13
 }

 
 ninja = {
   images = {},
   isJumping = false,
   anim_frame = 1,
   anim_time = 0,
   pos_x = 150,
   pos_y = 470,
   scale = 0.22,
   vel_y = 50,
   n_jumps = 0,
   max_jumps = 2,
   w=70,
   h=92,
   collided = false
 }

carros = {
   image = {},
   timer = 0,
   vel_x = -300,
   acel_x = 0.2,
   posicoes = {
     {x=1100, y=466.7},
     {x=1100, y=442.7},
     {x=1100, y=450.7},
     {x=1100, y=421.7},
     {x=1100, y=451.7},
     {x=1100, y=423.7},
     {x=1100, y=411.7}
     },
    morte = {
    {x=16, y=484.7, w=82,  h=82}, --0
    {x=07, y=464.7, w=84,  h=93}, --1
    {x=09, y=468.7, w=103, h=87}, --2
    {x=10, y=490.7, w=98,  h=66}, --3
    {x=12, y=487.7, w=90,  h=78}, --4
    {x=10, y=470.7, w=105, h=111},--5
    {x=19, y=446.7, w=68,  h=144} --6
  },
    dimensoes = {
    {x=98,  y=483.7, w=156, h=69}, --0
    {x=84,  y=463.7, w=140, h=93}, --1
    {x=112, y=469.7, w=129, h=87}, --2
    {x=108, y=490.7, w=98,  h=66}, --3
    {x=102, y=486.7, w=126, h=78}, --4
    {x=115, y=435.7, w=176, h=111},--5
    {x=87,  y=424.7, w=77,  h=171} --6
  }
 } 
 
   game.load()
   game.loadCharacter(id)
 end
 
function game.load()
  love.graphics.setNewFont(30)
  
  cenario.image_tunel = love.graphics.newImage('Background 2.3.png')
 
  for i = 0, 6 do
    carros.image[i+1]= love.graphics.newImage('carro__'..i..'.png')
  end
end
function game.loadCharacter(id)
  local ini,fim
  if id == 1 then
    ini = 0
    fim = 9
  else
    ini = 10
    fim = 19
  end
  for k = ini, fim, 1 do
    table.insert(ninja.images, love.graphics.newImage('Run__'..k..'.png'))
  end
end

function spawn(x, y, tipo)
  table.insert(carros, {x = carros.posicoes[tipo].x, y = carros.posicoes[tipo].y, image = carros.image[tipo], hitbox = carros.dimensoes[tipo]})
  table.insert(death, carros.morte[tipo])
end

function CheckBoxCollision (x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end


function game.update(dt)
 -- Cronômetro
  tempo = tempo + dt
 
 -- Velocidade e Repetição do Cenário
  cenario.pos_x = cenario.pos_x - (cenario.vel_x * dt) - ((cenario.acel_x * tempo)/2)
  if cenario.pos_x < -1272 then
    cenario.pos_x = cenario.pos_x + 1272
  end
 
 -- Tempo da Animação do Ninja
 ninja.anim_time = ninja.anim_time + dt
 if(not ninja.isJumping) then
  if ninja.anim_time > 0.07 then
    ninja.anim_frame = ninja.anim_frame + 1
    if ninja.anim_frame > 10 then
      ninja.anim_frame = 1
    end
    ninja.anim_time = 0
  end
 else
   ninja.anim_frame = 3
 end
 
 -- Salto do Ninja
  if ninja.isJumping then
    ninja.vel_y = ninja.vel_y + gravity * dt
    ninja.pos_y = ninja.pos_y + ninja.vel_y*dt
  end
 
  if ninja.pos_y > 470 then
    ninja.pos_y = 470
    ninja.n_jumps = 0
    ninja.isJumping = false
  end
 
 -- Velocidade e Repetiçaõ dos Carros
 local v
 for i=#carros,1,-1 do
   v = carros[i]
  v.x = v.x + carros.vel_x*dt - ((carros.acel_x * tempo)/2)
  if v.x < -300 then
    table.remove(carros,i)
    table.remove(death, I)
  end
 end
 
  carros.timer = carros.timer + dt
 
  ninja.collided = false
  for i=#carros, 1 ,-1 do
    local hc = carros[i].hitbox
    if CheckBoxCollision (carros[i].x+hc.x,hc.y,hc.w,hc.h,ninja.pos_x,ninja.pos_y,ninja.w,ninja.h) then
      ninja.collided = true
    end
  end
 
  if ninja.collided then
    ninja.vel_y = 0
    ninja.n_jumps = 0
  end
  for i=#carros, 1 ,-1 do
    local cd = death[i]
    if cd then
      if CheckBoxCollision (carros[i].x+cd.x,cd.y,cd.w,cd.h,ninja.pos_x,ninja.pos_y,ninja.w,ninja.h) then
        ninja.collided = true
        if ninja.collided then
          ChangeToGameOver()
        end
      end
    end
  end
 
  if carros.timer > 2 then
    local tipo = love.math.random(1,7)
    spawn(1200,480,tipo)
    carros.timer = 0
   --  spawno o carro
   --  reseto o timer
  end
end

function game.keypressed(key)
  if (key == 'up') then
    if ninja.n_jumps < ninja.max_jumps then
      ninja.n_jumps = ninja.n_jumps + 1
      ninja.isJumping = true
      ninja.vel_y = -550
    end
  end
end

function game.draw()
 -- Cenário
  love.graphics.draw(cenario.image_tunel, cenario.pos_x, 0)
  love.graphics.draw(cenario.image_tunel, cenario.pos_x + 1272, 0)

 -- Cronômetro
  love.graphics.print(math.floor(tempo), 480, 10)
 
 -- Ninja
  love.graphics.draw(ninja.images[ninja.anim_frame], ninja.pos_x, ninja.pos_y, 0, ninja.scale, ninja.scale)
 
 -- Carros
 for i,v in ipairs(carros) do
   love.graphics.draw(v.image, v.x, v.y)
    --love.graphics.draw(carros[0], pos_x, pos_y)
  end
end
return game 