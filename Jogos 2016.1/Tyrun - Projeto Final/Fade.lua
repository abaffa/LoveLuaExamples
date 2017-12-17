local Fade1 = {}

function Fade1.load()
  light = 255
  end

function Fade1.update(dt)
  if score > 600 then
  light = light - dt * 50
  end
end

function Fade1.draw()
  if score < 600 or (score > 800 and score < 2500) then
  love.graphics.setColor(0,0,0,0)
elseif score >= 600 and score < 1000 then
  love.graphics.setColor(0,0,0,light)
  love.graphics.rectangle("fill",0,0,800,600)
elseif score >= 2500 then
  love.graphics.setColor(0,0,0,light)
  love.graphics.rectangle("fill",0,0,800,600)
  end
end

return Fade1