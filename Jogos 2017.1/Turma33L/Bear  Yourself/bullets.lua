local enemies = require("enemies")

local bullets = {}
local index = 1

function bullets.new(x,y,dx,dy)
  table.insert(bullets,
    {
      x = x,
      y = y,
      dx = dx,
      dy = dy
    })
end

function bullets.load()
  spd = 10
end

function bullets.update(dt)
  for i=1, #bullets do
    if bullets[i] ~= nil then
      local b = bullets[i]
      b.x = b.x + b.dx*dt 
      b.y = b.y + b.dy*dt
    end
  end
end

function bullets.draw()
  love.graphics.setColor(255,255,255)
  for i=1, #bullets do
    local b = bullets[i]
    love.graphics.circle("fill",b.x,b.y,5)
  end
  love.graphics.setColor(255,255,255)
end

function bullets.die(i)
  table.remove(bullets,i)
end
return bullets