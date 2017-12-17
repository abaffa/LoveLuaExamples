function love.load()
  
 end

function love.draw()
  love.graphics.setBackgroundColor(0,0,200)
  love.graphics.setColor(0,255,0)
  love.graphics.rectangle("fill", 0, 500, 800, 100) --chao
  love.graphics.setColor(128,64,0)
  love.graphics.rectangle("fill", 100, 300, 200, 200) --casa
  love.graphics.setColor(200,0,0)
  love.graphics.polygon("fill", 100, 300, 300, 300, 200, 200) --teto
  love.graphics.setColor(128,64,0)
  love.graphics.rectangle("fill", 505, 400, 40, 100) --arvore
  love.graphics.setColor(0,200,0)
  love.graphics.circle("fill", 525,350, 70, 100) --folha
  love.graphics.setColor(200, 200, 0)
  love.graphics.circle("fill", 100, 100, 36, 100) --sol
  love.graphics.line(100, 30, 100, 170) --raios de sol
  love.graphics.line(30, 100, 170, 100)
  love.graphics.line(50, 50, 150, 150)
  love.graphics.line(50, 150, 150, 50)
  
  love.graphics.setColor(200,200,200)
  love.graphics.circle("fill", 500, 100, 32, 100) --nuvens
  love.graphics.circle("fill", 538, 98, 32, 100)
  love.graphics.circle("fill", 576, 100, 32, 100)
  love.graphics.circle("fill", 614, 102, 32, 100)
  end