------------PLAYER-Desafio-1------------

local player = {velocity = 25}

-------Variaveis------
local keys = {
              walk1 = 'right',
              walk2 = 'left',
  }

sprite = {}
currentSprite = 1
velocity = 25

local floorHeight = 230


--------Funcoes-------

---pseudo-callbacks---
function player.load()
    for i = 1, 2, 1 do
      sprite[i] = love.graphics.newImage("res/images/desafio1/walk" .. i .. ".png")
    end
    desafio1 = require "desafios/desafio1/desafio1"
end

function player.update(dt)
    
end

function player.draw()
    love.graphics.setColor(1,1,1,WinAlpha)
    love.graphics.draw(sprite[currentSprite], (WIDTH/1920)*200,
      HEIGHT -  (HEIGHT/1080)*floorHeight - sprite[currentSprite]:getHeight()*(HEIGHT/1080)*10,
      0, (WIDTH/1920)*10, (HEIGHT/1080)*10)
    
end

function player.keypressed(key)
    if key == keys.walk1 and lastClick ~= 1 and not desafio1.getWon() and not desafio1.getLost() then
      currentSprite = 1
      
    elseif key == keys.walk2 and lastClick ~= 2 and not desafio1.getWon() and not desafio1.getLost() then
      currentSprite = 2
      
    end
    
  end

---outras-funcoes---



---gets/sets---





--
return player