local Iniciar = {}
local Iniciar_BG
local cb

function Iniciar.mousepressed()
end

function Iniciar.keypressed(key)
  if key == "return" then
    cb()
  elseif key == "escape" then
    love.event.quit()
  end
end

function Iniciar.load(callback)
  cb = callback
  Iniciar_BG = love.graphics.newImage("Inicio.png")
end

function Iniciar.update(dt)
end

function Iniciar.draw()
  love.graphics.draw(Iniciar_BG)
end

return Iniciar