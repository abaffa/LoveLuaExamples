width, height = love.graphics.getDimensions()
local menu = require "menu"
local pause = require "pause"

local trump = {
  x = width/2 - 512/4,
  y = height - 10 - 512/2,
  tileQuads = {},
  sprite = nil,
  tileSize = 512/2,
  n = 1,
  timer = 0,
  direita = false,
  esquerda = false,
  roda = 0,
  colidindo = false
 }

function loadSprites(nx, ny) 
  trump.sprite = love.graphics.newImage("trumpSprite.png")
  local count = 1
  for i = 0, nx-1 do
    for j = 0, ny-1 do
      trump.tileQuads[count] = love.graphics.newQuad(i*trump.tileSize, j*trump.tileSize,
      												 trump.tileSize, trump.tileSize,
      												 trump.sprite:getWidth(), trump.sprite:getHeight() )
      count = count + 1
    end
  end
end


function trump.load()
loadSprites(2,2)
end

function trump.update(dt)
  	if not menu.onMenu and not pause.onPause and not cutscene.onCutscene then
	   
      if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        trump.n = 3
        trump.direita = true
        trump.roda = 3.14/6 
       -- trump.y = height - 10 - 512/2 + 30
      else
        trump.direita = false
      end

      if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        trump.n = 4
        trump.esquerda = true
        trump.roda = -3.14/6
      else
        trump.esquerda = false
      end
      
      if not trump.esquerda and not trump.direita then
        trump.roda = 0
        trump.y = height - 10 - 512/2
      end

      trump.timer = trump.timer + dt
      if not trump.colidindo then 
        if trump.timer > 0.1 then
          if trump.n == 1 then 
            trump.n = 3
          elseif trump.n == 3 and not trump.direita then
            trump.n = 2
          elseif trump.n == 2 then
            trump.n = 4
          elseif trump.n == 4 and not trump.esquerda  then
            trump.n = 1
          end
          trump.timer = 0
        end
      else
        trump.n = 1
      end
      
      -- 1 3 2 4
  	end

end

function trump.draw()
  if not menu.onMenu and not cutscene.onCutscene then
    love.graphics.draw(trump.sprite, trump.tileQuads[trump.n], trump.x, trump.y)--, trump.roda, 0, 0, trump.tileSize/2, trump.tileSize/2) 
  end
end


return trump;