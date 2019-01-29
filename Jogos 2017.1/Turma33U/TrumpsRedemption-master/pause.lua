-- voltar pro menu inicial
-- voltar a jogar
-- instruções
width, height = love.graphics.getDimensions()
local menu = require "menu"

pause = {
  imgs={}, 
  x = width/4,
  y = height/5,
  n = 1,
  instrucao = {
      instru = false,
      instruimg = nil,
      x =  width / 4, 
      y = height/4 
  },
  onPause = false
}


function pause.load()
  pause.instrucao.instruimg = love.graphics.newImage("Menu/Pause/inst.png") 
  for i = 1, 3 do
    pause.imgs[i] = love.graphics.newImage("Menu/Pause/pause"..i..".png") 
  end
end

function pause.update(dt)
end

function pause.draw()
 if pause.onPause then 
  love.graphics.draw(pause.imgs[pause.n], pause.x, pause.y, 0, --400x300
                    (width/2)/pause.imgs[pause.n]:getWidth(), (width/2)/pause.imgs[pause.n]:getHeight())
 end
 
  if pause.instrucao.instru then 
    love.graphics.draw(pause.instrucao.instruimg,
                        pause.instrucao.x, pause.instrucao.y,0,
                        (width/2)/pause.instrucao.instruimg:getWidth(), (height/2)/pause.instrucao.instruimg:getHeight())
  --200x150
  --
  end

end

return pause