button_over = {}
gameover = love.graphics.newImage("gameover.png")
local firsttime = 1

function botao_spawn_over(x,y,text, id)
  table.insert(button_over,{x = x, y = y, text = text, id = id})
end

function botao_draw_over()
  
  for i, v in ipairs(button_over) do
    love.graphics.print(v.text, v.x, v.y)
    fonte = love.graphics.newFont("Beatles.ttf",98)
    
    if firsttime == 1 then
    love.graphics.draw(gameover, 0, 0, 0, .67, .6)
    love.graphics.print("Score:", 330, 500)
    love.graphics.print(math.floor(score), 400, 500)
    end
    
   end
   
end

function checarBotao_over(x,y)
  sub.lives = 3
  for i, v in ipairs(button_over) do
    if x > v.x+1 and
    x < v.x + fonte:getWidth(v.text) and
    y > v.y+1 and
    y < v.y + fonte:getHeight(v.text) then
      if v.id == "Quit" then
        love.event.push("quit")
      end
      if v.id == "Menu" then
        gamestate = "menu"
        firsttime = 1
      end
    end
  end
end