------------MENU------------

local menu = {}

-------Variaveis------
local keys = {
              quit = 'escape',
              selectUp = 'up',
              selectDown = 'down',
              selectSelection = 'return'
  }
local selection = 1


--------Funcoes-------

---pseudo-callbacks---
function menu.load()
    love.graphics.setBackgroundColor(rgb(234, 159, 18))
    love.graphics.setDefaultFilter("nearest")
    cleytinho = love.graphics.newImage("res/images/cleytinho/lado_direito.png")
    
end

function menu.update(dt)
    
end

function menu.draw()
    love.graphics.setColor(rgb(244, 66, 66))
    love.graphics.setFont(fontBigger2)
    love.graphics.printf("Cleytinho's Odyssey", 0, (HEIGHT/1080)*120, WIDTH, "center")
    
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(fontBig1)
    love.graphics.printf("Historia", 0, (HEIGHT/1080)*340, WIDTH, "center")
    love.graphics.printf("Desafios", 0, (HEIGHT/1080)*470, WIDTH, "center")
    love.graphics.printf("Garagem", 0, (HEIGHT/1080)*600, WIDTH, "center")
    love.graphics.setFont(fontMedium1)
    love.graphics.printf("Opcoes", 0, (HEIGHT/1080)*730, WIDTH, "center")
    love.graphics.printf("Creditos", 0, (HEIGHT/1080)*830, WIDTH, "center")
    love.graphics.printf("Sair", 0, (HEIGHT/1080)*930, WIDTH, "center")
    
    love.graphics.setFont(fontSelect)
    if selection == 1 then
      love.graphics.printf(">", (WIDTH/1920)*-240, (HEIGHT/1080)*340, WIDTH, "center")
    elseif selection == 2 then
      love.graphics.printf(">", (WIDTH/1920)*-240, (HEIGHT/1080)*470, WIDTH, "center")
    elseif selection == 3 then
      love.graphics.printf(">", (WIDTH/1920)*-255, (HEIGHT/1080)*600, WIDTH, "center")
    elseif selection == 4 then
      love.graphics.printf(">", (WIDTH/1920)*-165, (HEIGHT/1080)*725, WIDTH, "center")
    elseif selection == 5 then
      love.graphics.printf(">", (WIDTH/1920)*-180, (HEIGHT/1080)*825, WIDTH, "center")
    elseif selection == 6 then
      love.graphics.printf(">", (WIDTH/1920)*-105, (HEIGHT/1080)*925, WIDTH, "center")
    end
    
    
    love.graphics.draw(cleytinho, (WIDTH/1920)*130, (HEIGHT/1080)*380, 0, (WIDTH/1920)*16, (HEIGHT/1080)*16)
    
end

function menu.keypressed(key)
    if key == keys.quit then
      love.event.quit()
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
        changeToHistoria()
      elseif selection == 2 then
        changeToDesafios()
      elseif selection == 3 then
        changeToGaragem()
      elseif selection == 4 then
        changeToOpcoes()
      elseif selection == 5 then
        changeToCreditos()
      elseif selection == 6 then
        love.event.quit()
      end
      
    end
    
  end


---outras-funcoes---



---gets/sets---





--
return menu