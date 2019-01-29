local cutscene = {}
local game = require "game"
local cut = {}
local txt = {}
local currentCut = tonumber(1)
local currentText = tonumber(1)
function cutscene.load()
  for i=1, 8 do
    cut[i] = love.graphics.newImage("cutscenes/cut"..i..".png")
  end
  for j=1,8 do
    txt[j] = love.filesystem.newFile("cutscenes/cut"..j..".txt", "r"):read()
  end
end
function cutscene.update(dt)
  if state == "cutscene" then
    function love.keypressed(key)
      if key == "right" or key == "return" then
        currentCut = currentCut + 1 
        currentText = currentText + 1
      end
      if currentCut > 1 then
        if key == "left" then
          currentCut = currentCut - 1 
          currentText = currentText - 1
        end
      end
    end
  end
 
end

function cutscene.draw()
 love.graphics.setNewFont("fonte.ttf",25)
  if currentCut == #cut + 1 then
    changeToGame()
  elseif currentCut == 8 then
    love.graphics.draw(cut[math.min(currentCut, #cut)],0,0)
    love.graphics.print((txt[currentCut]),20,150)
    else
    love.graphics.draw(cut[math.min(currentCut, #cut)],0,0)
    love.graphics.print((txt[currentCut]),20,420)
    state = "cutscene"
  end
end
return cutscene