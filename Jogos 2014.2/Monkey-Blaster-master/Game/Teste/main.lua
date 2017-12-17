

function love.load()
  vx=100
  vy=100
  love.graphics.setColor(0,0,0)
  love.graphics.setBackgroundColor(255, 255, 255)
  px=0
  py=0
end

function love.update(dt)
  px=px + (vx*dt)
  py=py + (vy*dt)
  if(px>600) or (px<0) then
    vx = -1*vx
  end
  if(py>500) or (py<0) then
    vy = -1*vy
  end
end

function love.draw()
  love.graphics.rectangle("fill", px, py, 200, 100)
end