py = 400
local menu = {
  estaNoMenu = true
  }

function menu.load()
fonte = love.graphics.newFont("INVASION2000.TTF",50)
fundo_menu = love.graphics.newImage("fundo.png")

end

function menu.update(dt)
  if py > 500 then
    py = 400
  end
  if py < 400 then
    py = 500
  end
end

function menu.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(fundo_menu, 0, 0, 0, 0.5, 0.5)
  love.graphics.setFont(fonte)
  love.graphics.print("BTL", 350, 100)
  love.graphics.print("Bike Through Life", 160, 150)
  love.graphics.print("Iniciar \n\nSair", 60, 400)
  love.graphics.print(">", 40, py)

 
end
return menu