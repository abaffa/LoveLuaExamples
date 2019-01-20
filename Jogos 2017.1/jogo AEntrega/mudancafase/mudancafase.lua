 b = (...):match("(.-)[^\\/]+$")
 local mudancafase = {}
 local f = require "game/fases"
 --local menui = require "menuinicial/menuinicial"
local lugares = {}
local fases = {}
local tamanho_lugar = {}
local tamanho_fase = {}
 finalscore = 0
local timef = 3

 
 
  function saveHighscore()
  --finalscore = {}
       --finalscore = 0
       scoresRead  = io.open("scores.txt", "r")
 for line in scoresRead:lines() do
 table.insert(fileLines, tonumber(line))
  end
scoresRead.close()
       
       for j = 2, 7, 1 do
         finalscore = finalscore + fileLines[j]
         end
       highscoresRead = io.open("highscores.txt", "r")
       --highscores = {}
       if not highscoresRead then 
          highscoresCreate  = io.open("highscores.txt", "w")
          highscoresCreate:write(finalscore, "\n")
          highscoresCreate:write(9999, "\n")
          highscoresCreate:write(9999, "\n")
          highscoresCreate:write(9999, "\n")
          highscoresCreate:write(9999, "\n")
          
          highscoresCreate:close()
        else
           for line in highscoresRead:lines() do
             table.insert(highscores, tonumber(line))
           end
           highscoresRead:close()
           
         for i = 1, 5 do
      if (finalscore < highscores[i]) then
       for x = 4, i, -1 do
        highscores[x+1] = highscores[x]
        end
        highscores[i] = finalscore
        break
        end
       end
       
       --[[      if finalscore < highscores[5] then 
             table.remove(highscores, 5)
             table.insert(highscores, 5, finalscore)
           end
           if finalscore < highscores[4] then
             table.remove(highscores, 5)
             table.insert(highscores, 5, highscores[4])
             table.remove(highscores, 4)
             table.insert(highscores, 4, finalscore)
           end
           if finalscore < highscores[3] then
             table.remove(highscores, 4)
             table.insert(highscores, 4, highscores[3])
             table.remove(highscores, 3)
             table.insert(highscores, 3, finalscore)
           end
           
          if finalscore < highscores[2] then 
             table.remove(highscores, 3)
             table.insert(highscores, 3, highscores[2])
             table.remove(highscores, 2)
             table.insert(highscores, 2, finalscore)
          end
           
           if finalscore < highscores[1] then
             table.remove(highscores, 2)
             table.insert(highscores, 2, highscores[1])
             table.remove(highscores, 1)
             table.insert(highscores, 1, finalscore)
           end
         ]] 
        highscoresWrite = io.open("highscores.txt", "w")
        highscoresWrite:write(highscores[1], "\n")
        highscoresWrite:write(highscores[2], "\n")
        highscoresWrite:write(highscores[3], "\n")
        highscoresWrite:write(highscores[4], "\n")
        highscoresWrite:write(highscores[5], "\n")
        highscoresWrite:close("highscores.txt")
         end
       end

 function mudancafase.load()
   mudancafase.scoreclass = {otm = 375, act = 385}
  mudancafase.auxfase = f.fase
  mudancafase.auxtimepause = 0
  cscenebck = love.graphics.newImage(b.. "cutscene.png")
  otimo = love.graphics.newImage(b.. "estadootimo.png")
  aceitavel = love.graphics.newImage(b.. "estadoaceitavel.png")
  pessimo = love.graphics.newImage(b.. "estadopessimo.png")
  theend = love.graphics.newImage(b.. "fim.png")
  lugares = {}
  lugares[1] = love.graphics.newImage(b.."porto_alegre.png")
  lugares[2] = love.graphics.newImage(b.."sao_paulo.png")
  lugares[3] = love.graphics.newImage(b.."rio_de_janeiro.png")
  lugares[4] = love.graphics.newImage(b.."sertao_nordestino.png")
  lugares[5] = love.graphics.newImage(b.."floresta_amazonica.png")
  lugares[6] = love.graphics.newImage(b.."pantanal.png")
  
  highscoresRead = io.open("highscores.txt", "r")
  for line in highscoresRead:lines() do
      table.insert(highscores, tonumber(line))
  end
  
  cscene = {}
  for i = 1, 3 do
    cscene[i] = love.graphics.newImage(b.. "cut" ..i.. ".png") 
  end  
  
  fases = {}
  for k = 1, 6, 1 do
    fases[k] = love.graphics.newImage(b .. "fase_" .. k ..".png")
  end
  
  tamanho_lugar = {}
  for k = 1, 6, 1 do 
  tamanho_lugar[k] = lugares[k]:getWidth()
  end

  tamanho_fase = {}
  for k = 1, 6, 1 do
  tamanho_fase[k] = fases[k]:getWidth()
  end
  
 end

function mudancafase.update(dt)
  if (f.fase == 1) then
    timef = 45
  else
    timef = 3
  end 
  if (paused == false) then
    mudancafase.auxfase = mudancafase.auxfase + 1
    if f.fase < 6 then  
      f.fase = f.fase + 1
          --mouse = love.mouse.setVisible(true)
    end
  end
   if (mudancafase.auxfase > 6) then
     
     mudancafase.auxtimepause = mudancafase.auxtimepause + dt
     if (mudancafase.auxtimepause > 5) then
       saveHighscore()
        
       mudancafase.auxtimepause = 0
       mudancafase.auxfase = 1
       paused = false
       changelevel = false
       mouse = love.mouse.setVisible(true)
       ChangeToMenuinicial()
     end  
   else
     mouse = love.mouse.setVisible(false)
     mudancafase.auxtimepause = mudancafase.auxtimepause + dt
     
     if (mudancafase.auxtimepause > timef) then
       paused = false
       changelevel = false
       mudancafase.auxtimepause = 0
       
     end  
     
   end  
end

function mudancafase.draw()
  
   if (mudancafase.auxfase > 6) then
    --finalscore = 385 --teste cutscene
     love.graphics.setColor(50,50,100)
     love.graphics.rectangle("fill", 0, 0,1920, 1080)
     love.graphics.setColor(255,255,255)
     if (finalscore <= mudancafase.scoreclass.otm) then
       love.graphics.draw(otimo, width/2, height/10, 0, 0.6, 0.6, otimo:getWidth()/2)
       love.graphics.print("OTIMO!!", width/2 - 50, height/2)
       love.graphics.draw(theend, width/2, height/1.5, 0, 1, 1, theend:getWidth()/2)
     else
       if (finalscore <= mudancafase.scoreclass.act) then
        love.graphics.draw(aceitavel, width/2, height/10, 0, 0.6, 0.6, aceitavel:getWidth()/2)
        love.graphics.print("ACEITAVEL!!", width/2 - 100, height/2)
        love.graphics.draw(theend, width/2, height/1.5, 0, 1, 1, theend:getWidth()/2)
       else
        love.graphics.draw(pessimo, width/2, height/10, 0, 0.6, 0.6, pessimo:getWidth()/2)
        love.graphics.print("PESSIMO!! :(", width/2 - 110, height/2)
        love.graphics.draw(theend, width/2, height/1.5, 0, 1, 1, theend:getWidth()/2)
       end  
     end  
     love.graphics.print(finalscore)
     love.graphics.print( string.format("%.2i", math.floor(finalscore/60)).. ":" ..string.format("%.2i", math.floor(finalscore - math.floor(finalscore/60)*60)).. ":" ..string.format("%.2i", (finalscore - math.floor(finalscore/60)*60 - math.floor(finalscore - math.floor(finalscore/60)*60))*100), width/2.5, height/1.7)
   else
     if (f.fase == 1) and mudancafase.auxtimepause < 41.5 then
       love.graphics.draw(cscenebck, -50, 0, 0, 0.9, 0.9)
       love.graphics.draw(cscene[math.floor(mudancafase.auxtimepause/14 + 1)], -50, 0, 0, 0.9, 0.9)
     else
     love.graphics.setColor(255,255,255)
     love.graphics.rectangle("fill",0, 0,1920, 1080)
     love.graphics.setColor(255,255,255)
     love.graphics.draw(lugares[f.fase],width/2 - tamanho_lugar[f.fase]/2,height/7)
     love.graphics.draw(fases[f.fase], width/2 - tamanho_fase[f.fase]/4, 2*height/3,0,0.5,0.5)
     end 
    
   end
   
end
return mudancafase