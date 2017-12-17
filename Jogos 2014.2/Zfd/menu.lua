button = {}
Capa = love.graphics.newImage("Capa.png")
local firsttime = 1

function botao_spawn(x,y,text, id)
  table.insert(button,{x = x, y = y, text = text, id = id})
end

function botao_draw()
  for i, v in ipairs(button) do
    love.graphics.setColor(255,255,255)
    love.graphics.print(v.text, v.x, v.y)
    fonte = love.graphics.newFont("28 Days Later.ttf",24)
    if firsttime == 1 then
      love.graphics.print("Use WASD para movimentar o personagem e as setas para atirar", 50, 600)
      love.graphics.print("Aperte start selecionar Shooter ou 2 para selecionar o Fast ou 3 para selecionar o Strong", 50, 630) 
      love.graphics.draw(Capa, 200, 100)
    else
      love.graphics.print("Game Over ",500, 295)
      love.graphics.print("Score  ".. scorecount, 500, 340) 
      love.graphics.print("Survived until Day " .. dia, 500, 385)
    end
    
  end
end


function checarBotao(x,y)
  for i, v in ipairs(button) do
    if x > v.x and
    x < v.x + fonte:getWidth(v.text) and
    y > v.y and
    y < v.y + fonte:getHeight() then
      if v.id == "quit" then
        love.event.push("quit")
      end
      if v.id == "start" then
        gamestate = "jogando"
        firsttime = 0 
        restart()
      end
    end
  end
end