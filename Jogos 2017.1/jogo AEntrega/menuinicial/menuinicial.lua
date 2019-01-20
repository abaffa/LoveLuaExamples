 local game = require "game/game"
 local h = require "HUD/HUD"
 local f = require "game/fases"
 local m = require "mudancafase/mudancafase"
 q = (...):match("(.-)[^\\/]+$")
 local menuinicial = {}
 local formtime = {}
  for x = 1, 5 do
   formtime[x] = {
       min,
       seg,
       mseg,
       state
     
     }
 end  
 

function menuinicial.load()
   fontt = love.graphics.newFont(18)
  
  cursor = love.mouse.newCursor(q .."pizzaicon.png")
  love.mouse.setCursor(cursor)
  
  botaoscreen={}
  fscreenNum = false
  
  menu = love.graphics.newImage(q .."menu.png")
  larguramenu, alturamenu = menu:getDimensions()
 
  novojogo = love.graphics.newImage(q .. "novojogo.png")
  larguranovojogo, alturanovojogo = novojogo:getDimensions()
 
  continuar = love.graphics.newImage(q .. "continuar.png")
  larguracontinuar, alturacontinuar = continuar:getDimensions()
 
  sair = love.graphics.newImage(q .. "sair.png")
  largurasair, alturasair = sair:getDimensions()
   
  pizzaicon = love.graphics.newImage(q .. "pizzaicon.png")
  --largurapizzaicon, alturapizzaicon = pizzaicon:getDimensions()
 
  botaoscreen['false'] = love.graphics.newImage(q .. "fullscreen.png")
  botaoscreen['true'] = love.graphics.newImage(q .. "normalscreen.png")
  botaosc = botaoscreen['false']
  largurabotaoscreen, alturabotaoscreen = botaosc:getDimensions()
 
 
  posxnovojogo, posynovojogo = larguratela/2 - larguranovojogo/2 , alturatela/2 + alturatela/8
  posxcontinuar, posycontinuar = larguratela/2 - larguracontinuar/2, 12/10* alturanovojogo + alturatela/2 + alturatela/8
  posxsair, posysair = larguratela/2 - largurasair/2, 12/10*alturacontinuar + posycontinuar
  posxpizzaicon, posypizzaicon = love.mouse.getPosition()
  posxbotaoscreen, posybotaoscreen = larguratela - (3 * largurabotaoscreen), 3*alturabotaoscreen 
  for i = 1, 5 do
    formtime[i].min  = math.floor(highscores[i]/60)
    formtime[i].seg  = math.floor(highscores[i] - formtime[i].min*60)
    formtime[i].mseg = (highscores[i] - formtime[i].min*60 - formtime[i].seg)*100
    if (highscores[i] <= m.scoreclass.otm) then
      formtime[i].state = "Ótimo"
    else
      if (highscores[i] <= m.scoreclass.act) then
        formtime[i].state = "Aceitável"
      else
        formtime[i].state = "Péssimo"
      end  
    end  
  end  
  
end

function menuinicial.update(dt)
 
  menuinicial.resize()
  
end

function menuinicial.draw()
   love.graphics.setFont(fontt)
 love.graphics.draw(menu, 0, 0, 0, love.window.getWidth()/woriginal, love.window.getHeight()/horiginal)
 love.graphics.draw(novojogo,  posxnovojogo, posynovojogo, 0, love.window.getWidth()/woriginal, love.window.getHeight()/horiginal)
 love.graphics.draw(continuar, posxcontinuar, posycontinuar, 0, love.window.getWidth()/woriginal, love.window.getHeight()/horiginal)
 love.graphics.draw(sair, posxsair, posysair, 0, love.window.getWidth()/woriginal, love.window.getHeight()/horiginal)
 love.graphics.draw(botaosc, posxbotaoscreen, posybotaoscreen, 0, love.window.getWidth()/woriginal, love.window.getHeight()/horiginal)
 love.graphics.setColor(0,0,0)
 for i = 0, 4 do
   love.graphics.print( (i+1)..". ".. string.format("%.2i", formtime[i +1 ].min).. ":" ..string.format("%.2i", formtime[i + 1].seg).. ":" ..string.format("%.2i", formtime[i + 1].mseg).. " ".. formtime[i + 1].state, width/2.7, height/3.6 + 30*i)
 end  
love.graphics.setColor(255,255,255)  --string.format("%.2f", formtime[i +1 ].min)
end

function menuinicial.mousepressed(x, y, button)
   -- area do botão
   if button == "l" and x > posxnovojogo and x < posxnovojogo + larguranovojogo and y > posynovojogo and y < posynovojogo + alturanovojogo then
     f.fase      = 1
     table.remove(fileLines, 1)
     table.insert(fileLines, 1, f.fase)
     
     game.load()
     h.load()
     scoresCreation()
     ChangeToGame()
     paused      = true
     changelevel = true
     
     end
    if button == "l" and x > posxcontinuar and x < posxcontinuar + larguracontinuar and y > posycontinuar and y < posycontinuar + alturacontinuar then
     f.fase = fileLines[1]
     paused      = true
     changelevel = true
     if fileLines[1] == 7 then 
       f.fase = 1
       scoresCreation()
       paused      = true
       changelevel = true
       end
     game.load()
     h.load()
     ChangeToGame()
     if (f.fase == 1) then
        m.auxtimepause = 42
     end
     
     end
   if button == "l" and x > posxbotaoscreen and x < posxbotaoscreen + largurabotaoscreen and y > posybotaoscreen and y < posybotaoscreen + alturabotaoscreen then
    -- fscreenNum = -1*fscreenNum + 1
     fscreenNum = not fscreenNum
    botaosc = botaoscreen[tostring(fscreenNum)]
    love.window.setFullscreen(fscreenNum)
  -- if fscreenNum == true then
   -- love.window.setMode(1280, 720, {vsync=false})
  -- else 
  --  love.window.setMode(800, 600, {vsync=false})
  --  end
   end
     
   if button == "l" and x > posxsair and x < posxsair + largurasair and y > posysair and y < posysair + alturasair 
    then
    love.event.quit()
   end
  end

function menuinicial.resize()
   larguratela, alturatela  = love.window.getDimensions()
   posxnovojogo, posynovojogo = larguratela/2 - larguranovojogo/2 , alturatela/2 + alturatela/8
   posxcontinuar, posycontinuar = larguratela/2 - larguracontinuar/2, 12/10* alturanovojogo + alturatela/2 + alturatela/8
   posxsair, posysair = larguratela/2 - largurasair/2, 12/10*alturacontinuar + posycontinuar
  -- posxpizzaicon, posypizzaicon = largurapizzaicon/2, alturapizzaicon/2
   posxbotaoscreen, posybotaoscreen = larguratela - (3 * largurabotaoscreen), 3*alturabotaoscreen 
  end
  
  

return menuinicial