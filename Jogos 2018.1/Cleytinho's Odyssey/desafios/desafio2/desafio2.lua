------------DESAFIO 2------------

local desafio2 = {}

-------Variaveis------
local keys = {
              back = 'escape'
  }

--------Funcoes-------

---pseudo-callbacks---
function desafio2.load()
    
end

function desafio2.update(dt)
    
end

function desafio2.draw()
    love.graphics.setColor(1,0,0)
    love.graphics.setFont(fontBig1)
    love.graphics.printf("Desafio 2", 0, (HEIGHT/1080)*420, WIDTH, "center")
    
end

function desafio2.keypressed(key)
    if key == keys.back then
      changeToMenu()
    end
    
end

---outras-funcoes---



---gets/sets---





--
return desafio2