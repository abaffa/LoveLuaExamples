function love.load()
  gamestate = 1
  px = 0
  py = 0
  pr = 64
  pg = 212
  pb = 214
 end
function love.update(dt)
  if love.keyboard.isDown("right") then
    px = px + 100*(dt)
  end
  if love.keyboard.isDown("left") then
    px = px - 100*(dt)
  end
  if love.keyboard.isDown("up") then
    py = py - 100*(dt)
  end
  if love.keyboard.isDown("down") then
    py = py + 100*(dt)
  end
  if py >= 450 and pr >= 0 and pg >= 0 and pb >= 0 then
    pr = pr - 20*(dt)
    pg = pg - 20*(dt)
    pb = pb - 20*(dt)
    love.graphics.setBackgroundColor(pr,pg,pb)
  elseif pr <= 64 and pg <= 212 and pb <= 214 then
    pr = pr + 20*(dt)
    pg = pg + 20*(dt)
    pb = pb + 20*(dt)
    love.graphics.setBackgroundColor(pr,pg,pb)
  end
end

function love.draw()
  love.graphics.setColor(255, 255, 0)
  love.graphics.circle("fill", px + 80, py + 80, 40)
  love.graphics.setBackgroundColor(64,212,214)
  love.graphics.setColor(109, 214, 64)
  love.graphics.rectangle("fill", 0, 450, 800, 200)
  
end

 