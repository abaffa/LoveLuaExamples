------------DESAFIOS------------

local desafios = {}

-------Variaveis------
local keys = {
              back = 'escape',
              selectUp = 'up',
              selectDown = 'down',
              selectSelection = 'return'
  }
  selection = 1

--------Funcoes-------

---pseudo-callbacks---
function desafios.load()
    tick = love.graphics.newImage("res/images/menu/tick.png")
    nah = love.graphics.newImage("res/images/menu/nah.png")
    
end

function desafios.update(dt)
    
end

function desafios.draw()
    love.graphics.setColor(1,0,0)
    love.graphics.setFont(fontBigger2)
    love.graphics.printf("Desafios", 0, (HEIGHT/1080)*130, WIDTH, "center")
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fontMedium1)
    love.graphics.printf("Desafio 1", 0, (HEIGHT/1080)*330, WIDTH, "center")
    love.graphics.printf("Desafio 2", 0, (HEIGHT/1080)*440, WIDTH, "center")
    love.graphics.printf("Desafio 3", 0, (HEIGHT/1080)*550, WIDTH, "center")
    love.graphics.printf("Desafio 4", 0, (HEIGHT/1080)*660, WIDTH, "center")
    love.graphics.printf("Desafio 5", 0, (HEIGHT/1080)*770, WIDTH, "center")
    love.graphics.printf("Desafio 6", 0, (HEIGHT/1080)*880, WIDTH, "center")
    
    love.graphics.setFont(fontSelect)
    if selection == 1 then
      love.graphics.printf(">", (WIDTH/1920)*-200, (HEIGHT/1080)*320, WIDTH, "center")
    elseif selection == 2 then
      love.graphics.printf(">", (WIDTH/1920)*-200, (HEIGHT/1080)*430, WIDTH, "center")
    elseif selection == 3 then
      love.graphics.printf(">", (WIDTH/1920)*-200, (HEIGHT/1080)*540, WIDTH, "center")
    elseif selection == 4 then
      love.graphics.printf(">", (WIDTH/1920)*-200, (HEIGHT/1080)*650, WIDTH, "center")
    elseif selection == 5 then
      love.graphics.printf(">", (WIDTH/1920)*-200, (HEIGHT/1080)*760, WIDTH, "center")
    elseif selection == 6 then
      love.graphics.printf(">", (WIDTH/1920)*-200, (HEIGHT/1080)*870, WIDTH, "center")
    end
    
    
end

function desafios.keypressed(key)
    if key == keys.back then
      changeToMenu()
    end
    
    if key == keys.selectUp and selection ~= 1 then
      selection = selection - 1
    elseif key == keys.selectUp then
      selection = 6
    end
    
    if key == keys.selectDown and selection ~= 6 then
      selection = selection + 1
    elseif key == keys.selectDown then
      selection = 1
    end
    
    if key == keys.selectSelection then
      if selection == 1 then
        changeToDesafio1()
      elseif selection == 2 then
        changeToDesafio2()
      elseif selection == 3 then
        changeToDesafio3()
      elseif selection == 4 then
        changeToDesafio4()
      elseif selection == 5 then
        changeToDesafio5()
      elseif selection == 6 then
        changeToDesafio6()
      end
      
    end
    
end

---outras-funcoes---



---gets/sets---





--
return desafios