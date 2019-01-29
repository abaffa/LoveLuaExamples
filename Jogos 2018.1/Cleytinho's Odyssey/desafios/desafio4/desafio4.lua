------------DESAFIO 4------------

local desafio4 = {}

-------Variaveis------
local keys = {
              back = 'escape'
  }

--------Funcoes-------

---pseudo-callbacks---
function desafio4.load()
    
end

function desafio4.update(dt)
    
end

function desafio4.draw()
    love.graphics.setColor(1,0,0)
    love.graphics.setFont(fontBig1)
    love.graphics.printf("Desafio 4", 0, (HEIGHT/1080)*420, WIDTH, "center")
    
end

function desafio4.keypressed(key)
    if key == keys.back then
      changeToMenu()
    end
    
end

---outras-funcoes---



---gets/sets---





--
return desafio4