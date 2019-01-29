local creditos = {}
local creditosbuttons

function creditos.load()
  bg1 = love.graphics.newImage("creditos2.png")
  creditosbuttons = {
    {
      x= 33,
      y= 390,
      width= 150,
      height = 35
    }
  }
 end
function creditos.update(dt)
  
end

function checkPoint(botao,x,y)
  return botao.x < x + 1 and x < botao.x + botao.width
    and botao.y < y + 1 and y < botao.y + botao.height
  end

  function creditos.draw()
  love.graphics.setFont(font)
  love.graphics.setColor(255,255,255)
  love.graphics.draw(bg1,0,0,0,0.8,0.8)
  love.graphics.setBackgroundColor(153,76,0)
  love.graphics.setColor(0,0,0)
  love.graphics.print('Criadores:',30,30)
  love.graphics.print('Luiz Fellipe Augusto',30,60)
  love.graphics.print('Bruce Barbosa',30,90)
  love.graphics.print('Rafaella Calvente',30,120)
  love.graphics.print('Gustavo Sampaio',30,150)
  love.graphics.print('Pedro Henrique Teixeira',30,180)
  love.graphics.print('Agradecimentos Especiais:',450,30)
  love.graphics.print('Luis Fernando',450,60)
  love.graphics.print('Pietro Pepe',450,90)
  love.graphics.print('Enrick Diniz',450,120)
  love.graphics.print('Pedro Igor Sampaio',450,150)
  love.graphics.print('Pedro Wolter',450,180)
  love.graphics.print('Kevin Leal Chiappetta',450,210)
  love.graphics.setColor(255,255,255)
  
   for i=1, #creditosbuttons do
     local b= creditosbuttons[i]
     
    end
 end
 
 function creditos.mousepressed(x,y,but)
   if checkPoint(creditosbuttons[1], x, y) and but == 1 then --retorna ao menu
     changeToMenu()
     love.audio.play(rugido)
  end
  function creditos.keypressed(key)
    end
 end
 return creditos