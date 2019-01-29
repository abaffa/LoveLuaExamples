local enemycollision = {}
local  player = require 'player'


function enemycollision.load()
  
player1 = {
x = player.hitboxx,
y = player.hitboxy,
width = 8,
height = 16,
collided = false
}


enemy1 = {
x = 500,
y = 300,
width = 50,
height = 50
}
--box2 = {     INATIVADA
--x = 650,
--y = 275,
--width = 100,
--height = 100
--}

  movx=1
  distx = player1.x-enemy1.x
  desty = player1.y-enemy1.y
  dist = math.sqrt(((player1.x-enemy1.x)*(player1.x-enemy1.x))+((player1.y-enemy1.y)*(player1.y-enemy1.y)))
  dir = {x = (player1.x-enemy1.x), y = (player1.x-enemy1.x)}
end
function CheckBoxCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end
function enemycollision.update(dt)
  player1.x=player.hitboxx
  player1.y=player.hitboxy
  
  --if CheckBoxCollision (player1.x, player1.y, player1.width,player1.height, box1.x, box1.y, box1.width, box1.height) or CheckBoxCollision(player1.x, player1.y, player1.width,player1.height, box2.x, box2.y, box2.width, box2.height) then
  
  if CheckBoxCollision (player1.x, player1.y, player1.width,player1.height, enemy1.x, enemy1.y, enemy1.width, enemy1.height) then
    player1.collided = true 
    player.life=player.life-10
    if player.life<=0 then
      player1.collided = false --resetar a colisão
    end
    enemy1.x=enemy1.x - movx*30 -- mover o inimigo/(ou o player) para trás
    enemy1.y=enemy1.y- movx*30 
  else
    player1.collided = false
  end
  if player1.collided == true then
    movx=0 --movx*(-1)
  else
    movx=1
  end
  
  dist = math.sqrt(((player1.x-enemy1.x)*(player1.x-enemy1.x))+((player1.y-enemy1.y)*(player1.y-enemy1.y)))
  dir = {x = (player1.x-enemy1.x), y = (player1.y-enemy1.y)}
  
  dirx=dir.x/dist
  diry=dir.y/dist
  
  --box1.x=box1.x+100*dt*movx  -- movimento em x
  --box1.x=box1.x + dir.x*dt *movx
  if dist <= 250 then
  enemy1.x=enemy1.x+dirx*movx*250*dt
  enemy1.y=enemy1.y+diry*movx*250*dt
  --[[if box1.x > 800 then
    box1.x=0
  elseif box1.x < -50 then
    box1.x=800
  end
 -- box1.y=box1.y+100*dt*movx
 --box1.y=box1.y+dir.y*dt
  box1.y=box1.y+diry*movx*110*dt
  if box1.y >620 then
    box1.y=-20
   elseif box1.y < -20 then
    box1.y = 620
  end ]]
  end
    
--[[if love.keyboard.isDown("left") then
   --if not( CheckBoxCollision (player1.x - (120 * dt),player1.y,player1.width,player1.height, box1.x, box1.y, box1.width, box1.height)or CheckBoxCollision(player1.x - (120 * dt), player1.y, player1.width,player1.height, box2.x, box2.y, box2.width, box2.height)) then
   if not( CheckBoxCollision (player1.x - (120 * dt),player1.y,player1.width,player1.height, box1.x, box1.y, box1.width, box1.height)) then
  player1.x = player1.x -(120*dt)
end
end
if love.keyboard.isDown("right") then
  --if not( CheckBoxCollision (player1.x + (120 * dt),player1.y,player1.width,player1.height, box1.x, box1.y, box1.width, box1.height)or CheckBoxCollision(player1.x + (120 * dt), player1.y, player1.width,player1.height, box2.x, box2.y, box2.width, box2.height)) then
  if not( CheckBoxCollision (player1.x + (120 * dt),player1.y,player1.width,player1.height, box1.x, box1.y, box1.width, box1.height)) then
  player1.x = player1.x + (120*dt)
end
end
if love.keyboard.isDown ("up") then
  --if not( CheckBoxCollision (player1.x,player1.y - (120 * dt),player1.width,player1.height, box1.x, box1.y, box1.width, box1.height)or CheckBoxCollision(player1.x, player1.y - (120 * dt), player1.width,player1.height, box2.x, box2.y, box2.width, box2.height)) then
  if not( CheckBoxCollision (player1.x,player1.y - (120 * dt),player1.width,player1.height, box1.x, box1.y, box1.width, box1.height)) then
  player1.y = player1.y-(120*dt)
end
end
if love.keyboard.isDown("down") then
  --if not( CheckBoxCollision (player1.x,player1.y + (120 * dt),player1.width,player1.height, box1.x, box1.y, box1.width, box1.height)or CheckBoxCollision(player1.x, player1.y + (120 * dt), player1.width,player1.height, box2.x, box2.y, box2.width, box2.height)) then
    if not( CheckBoxCollision (player1.x,player1.y + (120 * dt),player1.width,player1.height, box1.x, box1.y, box1.width, box1.height)) then
    player1.y = player1.y + (120*dt)
  end
end]]
end
function enemycollision.draw (cx,cy)
love.graphics.setColor(255,255,255)
love.graphics.rectangle("fill", enemy1.x-cx, enemy1.y-cy,enemy1.width, enemy1.height)
--love.graphics.rectangle("fill", box2.x, box2.y,box2.width, box2.height)
if player1.collided == true then
  love.graphics.setColor (255,0,0)
end
love.graphics.rectangle("fill", player1.x-cx, player1.y-cy,player1.width, player1.height)
end

return enemycollision