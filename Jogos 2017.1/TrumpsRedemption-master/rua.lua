width, height = love.graphics.getDimensions()

rua = {
  img = nil
  }

function rua.load()
  rua.img = love.graphics.newImage("rua.png")
end

function rua.update(dt)
end

function rua.draw()
  love.graphics.draw(rua.img, 0, 0,0, width/rua.img:getWidth(), height/rua.img:getHeight())
end

return rua