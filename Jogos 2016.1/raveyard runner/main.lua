local gameState = 0 --0=mainMenu, 1=mainGame , 2=death
local selectedMenu
local mainMenuBackground
local mouseX
local mouseY
local gameTime = 0
local speed = 0
local gameBackground

local deathMenu = require "deathMenu"
local utils = require "utils"
local map = require "map"
local hero = require "hero"
local hud = require "hud"
local enemies = require "enemy"

function love.load()
  hero.load()
  deathMenu.load()
  mainMenuBackground = love.graphics.newImage("imagens/mainMenuBackground.jpg")
  MenuFont=love.graphics.newFont("font.ttf",42)
  laugh=love.audio.newSource("som/laugh.mp3", "static")
  map.initMap()
  chao=love.graphics.newImage("imagens/chao.png")
  enemies.load()
  gameBackground = love.graphics.newImage ("imagens/background.png")
  menuSong = love.audio.newSource("som/Rhythmortis.mp3","static")
  gameSong = love.audio.newSource("som/The Wight to Remain.mp3","static")
  love.audio.play(menuSong)
end

function CheckBoxCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end


function love.update (dt)
  if gameState == 0 then
    updateMenu()
  elseif gameState == 1 then
    updateMainGame(dt)
    elseif gameState== 2 then
    updateMorte(dt)
  end
end

function love.draw()
  if gameState == 0 then
    drawMenu()
  elseif gameState == 1 then
    drawGame()
  elseif gameState== 2 then
    drawMorte()
  end
end

function love.mousepressed(x,y,button)
  if gameState == 0 then --mainMenu
    if selectedMenu == 1 then
      love.audio.pause()
      love.audio.rewind()
      utils.setDistance(0)
      hero.init()
      map.initMap()
      enemies.init()
      gameState = 1 --mainGame
      love.audio.play(gameSong)
    elseif selectedMenu == 2 then
      os.exit(1)
    end
  end
  
  if gameState == 2 then
    if deathMenu.getState() == 1 then
      love.audio.pause()
      love.audio.rewind()
      utils.setDistance(0)
      hero.init()
      map.initMap()
      enemies.init()
      gameState = 1
      love.audio.play(gameSong)
    elseif deathMenu.getState() == 2 then
      love.audio.pause()
      love.audio.rewind()
      gameState = 0
      love.audio.play(menuSong)
    end
  end
  
end

function love.keypressed(key)
  if key == "up" then
    hero.jump()
  end
  if key == "z" then
    hero.jump()
  end
  if key == "x" then
    hero.attack()
  end
end

function drawMenu ()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(mainMenuBackground,0,0,0,love.graphics.getWidth()/mainMenuBackground:getWidth(),love.graphics.getHeight()/mainMenuBackground:getHeight())
   love.graphics.setFont(MenuFont)
  love.graphics.setColor(200,0,0)
  love.graphics.print("RAVEYARD RUNNER",150,75)
  if selectedMenu == 1 then
    love.graphics.setColor(200,200,200)
    love.graphics.print("INICIAR JOGO",100,200)
    love.graphics.setColor(200,0,0)
  else
    love.graphics.print("INICIAR JOGO",100,200)
  end
  if selectedMenu == 2 then
    love.graphics.setColor(200,200,200)
    love.graphics.print("SAIR",100,250)
    love.graphics.setColor(200,0,0) 
  else
    love.graphics.print("SAIR",100,250)
  end
end

function updateMenu()
  local mouseX = love.mouse.getX()
  local mouseY = love.mouse.getY()
  selectedMenu = 0
  if mouseX < 400 and mouseX > 100 then
    if mouseY > 200 then
      if mouseY < 250 then
        selectedMenu = 1
      elseif mouseY < 300 then
        selectedMenu = 2
      end
    end
  end
end

function updateMainGame(dt)
  local speed = utils.getSpeed()
  local oldDistance = utils.getDistance()
  utils.setDistance( oldDistance + speed*dt )
  hero.update(dt)
  map.updateMapMatrix(dt,speed)
  
  enemies.update(dt)
  
  for i=1, enemies.getNumberOfEnemies() do
    local ehb -- Enemy Hitbox
    ehb = enemies.getHitbox(i)
    if CheckBoxCollision(hero.pos_x,hero.pos_y,hero.width,hero.height,ehb.x,ehb.y,ehb.w,ehb.h) then 
      enemies.setCollided(i,true)
    end
    if enemies.getCollided(i) == true and hero.attackState==1 then
       enemies.remove(i)
       utils.setDistance( utils.getDistance() + 1000 )
    elseif enemies.getCollided(i) == true and hero.attackState~=1 then
       hero.die()
    end
  end
  
  if hero.getAlive() == true then
    if (hero.getAttackState() == 1) then
      utils.atkSpeed(400)
    else
      utils.walkSpeed(200)
    end
  end
  
  
  if ( hero.getActive() == false ) then
    love.audio.pause()
    love.audio.rewind()
    gameState = 2
  end

end

function drawGame ()
  love.graphics.draw(gameBackground,0, 0, 0, 2, 2)
  map.drawMap()
  hero.drawHero()
  hud.draw(hero.getWolfTimer(), hero.getTotalTimer() ,utils.getDistance())
  enemies.draw()
end

function updateMorte(dt)  
  deathMenu.update()
  love.audio.play(laugh)
end

function drawMorte()
  deathMenu.draw()
end


return main