local texto1 = {
  estaNoTexto1 = false
               }

function texto1.load()
fonte = love.graphics.newFont("INVASION2000.TTF",50)
end
function texto1.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.print("O QUE?!! Ja sao 7:18?!", 80,40)
  love.graphics.print("Preciso chegar na escola", 40, 80)
  love.graphics.print("rapido, senao mamae", 95,120)
  love.graphics.print("me mata!!!",250,160)
  love.graphics.print("Espaco para continuar", 75, 520)
  love.graphics.print(",", 220, 527)
end
return texto1