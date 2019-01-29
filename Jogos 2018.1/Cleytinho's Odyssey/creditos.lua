------------CREDITOS------------

local creditos = {}

-------Variaveis------
local keys = {
              back = 'escape'
  }

--------Funcoes-------

---pseudo-callbacks---
function creditos.load()
    
end

function creditos.update(dt)
    
end

function creditos.draw()
  
    love.graphics.setColor(1,0,0)
    love.graphics.setFont(fontBigger2)
    love.graphics.printf("Creditos", 0, (HEIGHT/1080)*200, WIDTH, "center")
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(fontMedium1)    
    love.graphics.printf("Daniel Zimmer de Paula Freitas", 0, (HEIGHT/1080)*400, WIDTH, "center")
    love.graphics.printf("Joao Pedro Curvello Fischer", 0, (HEIGHT/1080)*500, WIDTH, "center")
    love.graphics.printf("Katherine Cardoso P. Fernantes", 0, (HEIGHT/1080)*600, WIDTH, "center")
    love.graphics.printf("Leonardo D'Angelo Toledo", 0, (HEIGHT/1080)*700, WIDTH, "center")
    love.graphics.printf("Rachel Elisa Szenberg", 0, (HEIGHT/1080)*800, WIDTH, "center")
    
end

function creditos.keypressed(key)
    if key == keys.back then
      changeToMenu()
    end
    
end

---outras-funcoes---



---gets/sets---





--
return creditos