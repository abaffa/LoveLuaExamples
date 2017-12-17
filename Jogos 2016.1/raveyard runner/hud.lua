local hud = {}

local timerX = 750
local timerY = 50

local scoreX = 20
local scoreY = 20

local timerRadius = 30

function hud.drawWolfTimer(currentTime, totalTime)
  love.graphics.setColor(255,255,255)
  love.graphics.circle("fill", timerX, timerY, timerRadius)
  love.graphics.setColor(200,0,0)
  love.graphics.arc("fill", timerX, timerY, timerRadius, -90*math.pi/180, (-90)*math.pi/180 + (currentTime/totalTime)*2*math.pi)
end

function hud.drawScore(score)
  love.graphics.setColor(255,255,255)
  love.graphics.print("SCORE: "..math.floor(score/10), scoreX, scoreY,0,0.6,0.6)
end

function hud.draw(currentTime, totalTime, score)
  hud.drawWolfTimer(currentTime, totalTime)
  hud.drawScore(score)
end

return hud