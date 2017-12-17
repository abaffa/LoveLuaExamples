local bullet = {
  velocity = 400,
  shots = {}
}

function bullet.load()
  bullet.image = love.graphics.newImage("Assets/projetil.png")
end

function bullet.spawn(x, y, dir)
  table.insert(bullet.shots, {x = x, y = y, dir = dir})
end

function bullet.update(dt)
  for i=1, #bullet.shots do
    local b = bullet.shots[i]
    b.x = b.x + bullet.velocity*dt * b.dir
  end
end

function bullet.draw()
  for i=1, #bullet.shots do
    local b = bullet.shots[i]
    love.graphics.draw(bullet.image, b.x, b.y, 0, 2*b.dir, 2)
  end
end

return bullet