 y = (...):match("(.-)[^\\/]+$")
 local menupause = {}
  formscores = {}
  for x = 1, 6 do
   formscores[x] = {
       min = 0,
       seg = 0,
       mseg = 0
     }
 end  

 
function menupause.load()
    --paused = false
   menupr = love.graphics.newImage(y.."menupauser.png")
   menup  = love.graphics.newImage(y.."menupause.png")
   larguramenup, alturamenup = menup:getDimensions()
   
   blur = love.graphics.newImage(y .. "blur.png")
   largurablur, alturablur = blur:getDimensions()
    
   continuarp = love.graphics.newImage(y .. "continuarp.png") 
   larguracontinuarp, alturacontinuarp = continuarp:getDimensions()
   
   records = love.graphics.newImage(y .. "records.png")
   largurarecords, alturarecords = records:getDimensions()
 
   menuinicialp = love.graphics.newImage(y .. "menuinicialp.png")
   larguramenuinicialp, alturamenuinicialp = menuinicialp:getDimensions()
   
   posxcontinuarp, posycontinuarp = larguratela/2 - largurarecords/2, alturacontinuarp + alturatela/4
   posxmenuinicialp, posymenuinicialp = larguratela/2 - larguracontinuarp/2 , alturatela/2
   posxrecords, posyrecords = larguratela/2 - larguramenuinicialp/2, posycontinuarp + posycontinuarp/3.7
   
   for i = 1, 6 do
    --if (highscores[i] >= 3600)
    formscores[i].min  = math.floor(fileLines[i + 1]/60)
    formscores[i].seg  = math.floor(fileLines[i + 1] - formscores[i].min*60)
    formscores[i].mseg = (fileLines[i + 1] - formscores[i].min*60 - formscores[i].seg)*100
  end  

end

function menupause.update(dt)
     
  end 

function menupause.draw() 
     if paused == true then
     love.graphics.setColor(255,255,255,160)
     love.graphics.draw(blur,0,0)
     love.graphics.setColor(255,255,255)
     if (gamerec == false) then
      love.graphics.draw(menup, larguratela/7, alturatela/9, 0 , 0.7, 0.7)
     else
      love.graphics.draw(menupr, larguratela/7, alturatela/9, 0 , 0.7, 0.7)
      love.graphics.setColor(0,0,0)
 for i = 0, 5 do
   love.graphics.print((i+1)..". ".. string.format("%.2i", formscores[i + 1].min).. ":" ..string.format("%.2i", formscores[i + 1].seg).. ":" ..string.format("%.2i", formscores[i + 1].mseg), width/2.8, height/1.6 + 30*i)
 end  
love.graphics.setColor(255,255,255)
      
     end
     love.graphics.draw(continuarp,  posxcontinuarp, posycontinuarp)
     love.graphics.draw(records, posxrecords, posyrecords)
     love.graphics.draw(menuinicialp, posxmenuinicialp, posymenuinicialp)
   end
 end
 
return menupause
