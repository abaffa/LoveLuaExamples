------------HISTÓRIA------------

local historia = {}

-------Variaveis------
local keys = {
              back = 'escape'
  }

--------Funcoes-------

---pseudo-callbacks---
function historia.load()
    
end

function historia.update(dt)
    
end

function historia.draw()
    love.graphics.setColor(1,0,0)
    love.graphics.setFont(fontBig1)
    love.graphics.printf("Historia", 0, (HEIGHT/1080)*420, WIDTH, "center")
    
end

function historia.keypressed(key)
    if key == keys.back then
      changeToMenu()
    end
    
end

---outras-funcoes---



---gets/sets---





--
return historia