local Desafio3 = {id}
local Questao = {Q1,Q2,Q3}
Desafio3.id = 1
local Certa = false
local Errada = false

 function Desafio3.mousepressed()
end

function Desafio3.keypressed(key)
  if Desafio3.id == 1 then
    if key == 'c' then
      Certa = true
    elseif key == 'a' or key == 'b' or key == 'd' then
      Errada = true
    end
  elseif Desafio3.id == 2 then
    if key == 'd' then
      Certa = true
    elseif key == 'a' or key == 'b' or key == 'c' then
      Errada = true
    end
  elseif Desafio3.id == 3 then
    if key == 'a' then
      Certa = true
    elseif key == 'c' or key == 'b' or key == 'd' then
      Errada = true
    end
  end
end



function Desafio3.load(callback)
  cb = callback
  Desafio3.BG = love.graphics.newImage("Desafio3_BG.png")
  Q1 = love.graphics.newImage("Questao1.png")
  Q2 = love.graphics.newImage("Questao2.png")
  Q3 = love.graphics.newImage("Questao3.png")
end

function Desafio3.update(dt)
  if Desafio3.id == 1 then
    if Certa then
      Desafio3.id = 2
      Certa = false
    elseif Errada then
      aumentatempo()
      Errada = false
    end
  elseif Desafio3.id == 2 then
    if Certa then
      Desafio3.id = 3
      Certa = false
    elseif Errada then
      aumentatempo()
      Errada = false
    end
  elseif Desafio3.id == 3 then
    if Certa then
      Certa = false
      Desafio3.id = 4
    elseif Errada then
      aumentatempo()
      Errada = false
    end
  end
  if Desafio3.id == 4 then
    cb()
  end
end

function Desafio3.draw()
  love.graphics.draw(Desafio3.BG, 0, 0, 0, 0.8, 0.8)
  love.graphics.draw(Q1,160,-5,0,0.5,0.5)
  if Desafio3.id == 2 then
    Q1 = Q2
  end
  if Desafio3.id == 3 then
    Q1 = Q3
  end
end

return Desafio3