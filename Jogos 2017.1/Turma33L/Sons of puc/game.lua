local game = {}
local pausa = require "pausa"
local camera = require "camera"
local player = require "player"
local enemy = require "enemy"
local CollisionBlocks =require "CollisionBlocks"
local opendoor = require "opendoor"
local enemycollision = require "enemycollision"
local hud = require "hud"
local vida_1
function game.load()
  player.load()
  enemy.load()
  camera.load()
  enemycollision.load()
  pausa.load()
  --vida_1 = love.graphics.newImage("vida_1.png")
end
function game.update(dt)
  function love.keypressed(key)
    if key == "escape" then
      changeToPausa()
    end  
    if key == "j" then
      player.runAnimAttack = true
      imageAttack= love.graphics.newImage("image/ataque.png")
    elseif key == "k" and player.stamina>=player.bombstaminalose then
      player.specialattack= true
      player.runAnimAttack = true
      imageAttack= love.graphics.newImage("image/bomba.png")
      player.stamina=player.stamina-player.bombstaminalose
      
       player.specialattack=false
    elseif key == "l" and player.potion>0 then
      player.life=player.life+150
      player.stamina=player.stamina+25
      player.potion=player.potion-1
    end
    if state == "gameover" then
      if key == "return" then
        button_timer=0
        changeToMenu()
      end
    end
end
  player.update(dt)
  camera.update(dt)
  hud.update(dt)
  enemy.update(dt)
  --enemycollision.update(dt)
  tileI = math.floor((player.py+10*player.diry)/64) + 1
  tileJ = math.floor((player.px+10*player.dirx)/64) + 1
  opendoor(tileI,tileJ)
  
  if CollisionCheck(tileI,tileJ) then
    player.px=player.oldPosX
    player.py=player.oldPosY
  end
  if life == 0 then
    state = "gameover"
    end
end
function game.draw()
  if state == "gameover" then
  love.graphics.setBackgroundColor(0,0,0)
  love.graphics.setNewFont("fonte.ttf",30)
  love.graphics.print("      Fim de Jogo\n\n\n Aperte Enter para\n   voltar ao menu",220,200)
  else
  camera.draw()
  enemy.draw()
 -- enemycollision.draw(camera.offx,camera.offy)
  --love.graphics.print(math.floor(player.px/64))
  --love.graphics.print(math.floor(player.py/64),0,11)
  --love.graphics.print(math.floor(
  --love.graphics.print(player.px,0,22)
  --love.graphics.print(player.py,0,33)
  love.graphics.setColor(120,120,120,200)
  --love.graphics.rectangle("fill",player.attackx,player.attacky,player.attackwidth,player.attackheigth)
  love.graphics.setColor(300,120,120,200)
  --love.graphics.rectangle("fill",player.hitboxx,player.hitboxy,player.width,player.height-8)
  love.graphics.setColor(255,255,255)
  --love.graphics.draw(vida_1,0,0)
  hud.draw()
end
end
return game