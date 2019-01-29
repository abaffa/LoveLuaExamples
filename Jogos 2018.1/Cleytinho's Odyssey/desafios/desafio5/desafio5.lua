------------DESAFIO 5------------

local desafio5 = {}

-------Variaveis------
local keys = {
              back = 'escape'
  }

--------Funcoes-------

---pseudo-callbacks---
function desafio5.load()
    
end

function desafio5.update(dt)
    
end

function desafio5.draw()
    love.graphics.setColor(1,0,0)
    love.graphics.setFont(fontBig1)
    love.graphics.printf("Desafio 5", 0, (HEIGHT/1080)*420, WIDTH, "center")
    
end

function desafio5.keypressed(key)
    if key == keys.back then
      changeToMenu()
    end
    
end

---outras-funcoes---



---gets/sets---





--
return desafio5