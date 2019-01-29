local splash = {}

local tela_inicial


function splash.load()
  tela_inicial = love.graphics.newImage("tela_inicial.png")
end

function splash.update(dt)
    if love.keyboard.isDown ("return") then
    changeToMenu()
    end
end

function splash.draw()
   love.graphics.draw(tela_inicial,0,0)
end

function splash.keypressed(key)
  if key == ("return") then
    changeToMenu()
  end
end

return splash
