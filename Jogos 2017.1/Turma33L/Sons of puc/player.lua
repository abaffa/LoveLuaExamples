player = {}
local playerQuads={}
local playerSizex=32
local playerSizey=32
local anime_frame=1
local animacaotimer=0
local staminacronometer = 0
local lifecronometer = 0
local collision = require "collison"

function LoadPlayer (filename,nx,ny)
  playerImage= love.graphics.newImage(filename)
  local count=1
  for j=0,nx-1,1 do
    for i=0,ny-1,1 do
      playerQuads[count]=love.graphics.newQuad(i*playerSizex,j*playerSizey,playerSizex,playerSizey,playerImage:getWidth(),playerImage:getHeight())
      count=count+1
    end
  end
end

function player.getW()
  return playerImage:getWidth()
end

function player.getH()
  return playerImage:getHeight()
end

function animacao (ini,fin,dt) 
  if anime_frame <ini or anime_frame>fin then
    anime_frame=ini
  end
  animacaotimer=animacaotimer+dt
  if animacaotimer>0.1 then
    anime_frame=anime_frame+1
    if anime_frame>fin then
       anime_frame=ini
    end
    animacaotimer=0
    player.idle=ini
  end
end

function animacaoataque (ini,fin, dt)
  playerImage=imageAttack
  if anime_frame <ini or anime_frame>fin then
    anime_frame=ini
  end
  animacaotimer=animacaotimer+dt
  if animacaotimer>0.1 then
     anime_frame=anime_frame+1
    if anime_frame>fin then
       playerImage= imageWalk
       anime_frame=player.idle
       player.runAnimAttack = false
    end
    
    animacaotimer=0
  end
end

function player.load() 
  
  LoadPlayer("image/ataque.png",4,4)
  LoadPlayer("image/andando.png",4,4)
  --love.graphics.setBackgroundColor(255,255,255)
  imageAttack = love.graphics.newImage("image/ataque.png")
  imageWalk=love.graphics.newImage("image/andando.png")
  player.px=1171
  player.py=1700
  player.width=playerSizex
  player.height=playerSizey
  player.speed=300
  player.escalax=2
  player.escalay=2
  player.dirx = 0
  player.diry = 1
  player.runAnimAttack = false
  player.runAnimWalk=true
  player.idle=1
  player.life=500
  player.strength=50
  player.hitboxx=0
  player.hitboxy=0
  player.respawx=1171
  player.respawy=1720
  player.godMode = false
  player.godAnimTimer=0
  player.lifemax=500
  player.life=500
  player.stamina = 100
  player.staminamax = 100
  player.bombstaminalose = 20
  player.wallet = 0
  player.potion=3
  player.specialattack=false
end

function player.update(dt)
  player.oldPosX = player.px
  player.oldPosY = player.py
  player.hitboxx=player.px--camerapos_x -16
  player.hitboxy=player.py--camerapos_y
  player.attackx=player.px-camerapos_x+player.dirx*10-10
  player.attacky=player.py-camerapos_y+player.diry*10-10
  player.attackwidth = 30
  player.attackheigth = 30  
  
  if player.godMode then
    player.godAnimTimer = player.godAnimTimer + 3*dt
    if player.godAnimTimer > 5 then
      player.godMode = false
      player.godAnimTimer = 0
    end
  end
  
 if player.stamina<100 then
    staminacronometer = staminacronometer+10*dt
    if staminacronometer>=10 then
      player.stamina= player.stamina+1
      staminacronometer=0
    end
  end
 if player.stamina <=0 then
    player.stamina=1
 end
 if player.life<500 then
   lifecronometer=lifecronometer+15*dt
   if lifecronometer>=10 then
     player.life=player.life+1
     lifecronometer=0
   end
 end
  if player.life<=0 then
    player.px=player.respawx
    player.py=player.respawy
    player.life=500
    player.stamina=100
    --player.wallet=0
    player.potion=3
    life = life - 1
  end
  if player.life>player.lifemax then
     player.life=player.lifemax
  end
  if player.stamina > player.staminamax then
     player.stamina = player.staminamax
  end
  if player.runAnimAttack then
    if player.dirx == 1 and player.diry == 0 then
      animacaoataque(9,12,dt)
    elseif player.dirx == -1 and player.diry == 0 then
      animacaoataque(13,16,dt)
    elseif player.dirx == 0 and player.diry == 1 then
      animacaoataque(1,4,dt)
    elseif player.dirx == 0 and player.diry == -1 then
      animacaoataque(5,8,dt)
    end
  end
if player.runAnimAttack==false then 
  if love.keyboard.isDown ("down") then
    playerImage=imageWalk
    player.dirx=0
    player.diry = 1
    player.py = player.py + player.speed*player.diry*dt
    animacao(1,4, dt)
  elseif love.keyboard.isDown ("right") then
    playerImage=imageWalk
    player.dirx = 1
    player.diry = 0
    player.px = player.px + player.speed*player.dirx*dt
    animacao(5,8, dt)
  elseif love.keyboard.isDown ("up") then
    playerImage=imageWalk
    player.dirx = 0
    player.diry = -1
    player.py = player.py + player.speed*player.diry*dt
    animacao(9,12, dt)
  elseif love.keyboard.isDown ("left") then
    playerImage=imageWalk
    player.dirx = -1
    player.diry = 0
    player.px = player.px + player.speed*player.dirx*dt
    animacao(13,16, dt)
  end
end
  
 end
function love.keypressed(key)
  if key == "j" then
    player.runAnimAttack = true
    imageAttack= love.graphics.newImage("image/ataque.png")
  elseif key == "k" and player.stamina>=player.bombstaminalose then
    player.runAnimAttack = true
    imageAttack= love.graphics.newImage("image/bomba.png")
    player.stamina=player.stamina-player.bombstaminalose
  elseif key == "l" then
    player.life=player.life+100
    player.potion=player.potion-1
  end
end

function player.draw(offx,offy)
  if player.godMode then
    love.graphics.setColor(255,255,255,255*(math.min(math.floor(player.godAnimTimer)%2, 1)))
  end
  --love.graphics.print(player.potion,0,50)
  
  love.graphics.draw(playerImage,playerQuads[anime_frame],player.px+offx,player.py+offy,0,player.escalax,player.escalay,playerSizex/2,playerSizey/2)
  
  love.graphics.setColor(255,255,255)
end

return player 