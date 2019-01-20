pys = 250
local seleção = {
  estaNaSeleção = false
  }

function seleção.load()
fonte = love.graphics.newFont("INVASION2000.TTF",50)
fundo_menu = love.graphics.newImage("fundo.png")

end

function seleção.update(dt)
  if pys > 550 then -- impede a seta de sair dos limites
    pys = 250
  end
  if pys < 250 then
    pys = 550
end
end

function seleção.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(fundo_menu, 0, 0, 0, 0.5, 0.5)
  love.graphics.setFont(fonte)
  love.graphics.print("Selecione a fase", 180, 100)
  love.graphics.print("Fase 1\n\nFase 2\n\nFase 3\n\nVoltar",300,250)
  love.graphics.print(">", 270, pys)
  love.graphics.setColor(100,100,100) -- considerar colocar fotinhas

end
return seleção