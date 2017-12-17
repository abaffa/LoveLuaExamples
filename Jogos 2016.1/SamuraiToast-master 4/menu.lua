
--configura o menu do jogo

button = {}


function button_clear()
  button = {}
end

function button_spawn(x,y,text,id)
  table.insert(button, {x = x,y = y, text = text, id = id, mouseover = false})
end

function button_draw()
  for i,v in ipairs(button) do
    if v.mouseover == false then
      love.graphics.setColor(59,220,245)
    end
    if v.mouseover == true then
      love.graphics.setColor(love.math.random(255),love.math.random(255),love.math.random(255))
    end
    if v.mouseover == true and v.id == "sair" and gamestate == "menu" then
      love.audio.play(nyan)
      love.graphics.print("NAO SAI",love.math.random(800),love.math.random(600))
      love.graphics.print("NAO SAI",love.math.random(800),love.math.random(600))
    else
      love.audio.pause(nyan)
    end
    love.graphics.setFont(fonte)
    love.graphics.print(v.text,v.x,v.y)
  end
end

function button_click(x,y)
  for i,v in ipairs(button) do
    if x > v.x and x < v.x + fonte:getWidth(v.text) and y > v.y and y < v.y + fonte:getHeight() then
      if v.id == "sair" then
        love.event.quit()
      end
      if v.id == "start" then
        love.audio.play(horadoshow)
        gamestate = "jogando"
        
      end
      if v.id == "restart" then
         love.audio.rewind(gamesong , { channel=0, loops=-1, fadein=5000 } )
        gamestate = "jogando"
        --love.audio.play(queromais)
      end 
      if v.id == "leaderboard" then
        gamestate = "leaderboard"
      end
      if v.id == "pause" then
        love.audio.pause(horadoshow)
        gamestate = "pause"
      end
      if v.id == "menu" then
        gameReset()
        button_clear()
        button_spawn(390,300,"Start","start")
        button_spawn(10,550,"Quit","sair")
        button_draw()
        hero.nameinput = "on"
        hero.name = "" 
        gamestate = "menu"
      end
      if v.id == "resume" then
        love.audio.resume(horadoshow)
        gamestate = "jogando"
      end
    end
  end
end

function button_check()
  for i,v in ipairs(button) do
    if mousex > v.x and mousex < v.x + fonte:getWidth(v.text) and mousey > v.y and mousey < v.y+ fonte:getHeight() then
      v.mouseover = true
    else
      v.mouseover = false
    end
  end
end