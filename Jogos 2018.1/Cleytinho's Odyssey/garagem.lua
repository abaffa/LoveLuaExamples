------------GARAGEM------------

local garagem = {}

-------Variaveis------
local keys = {
              back = 'escape'
  }

local quadro = {
  color = {r = 1, g = 1, b = 1},
  draw = false,
  selection = false,
  sx = 400,
  sy = 360,
  imagem,
  quadrotodo,
  banco,
  pedal,
  pedalzinho
}

local roda = {
  color = {r = 1, g = 1, b = 1},
  angle = 0,
  draw = false,
  selection = false,
  sx = 60,
  sy = 420,
  imagem,
  raio,
  pneu
}

local marcha = {
  angle = 0,
  draw = false,
  coroa,
  corrente = {}
}

local guidao = {
  color = {r = 1, g = 1, b = 1},
  angle = 0,
  draw = false,
  selection = false,
  sx = 670,
  sy = 330,
  imagem,
}

local buzina = {
  color = {r = 1, g = 1, b = 1},
  angle = 0,
  draw = false,
  selection = false,
  sx = 730,
  sy = 140,
  imagem,
  sound
}

local freio = {
  angle = 0,
  draw = false,
  selection = true,
  sx = 710,
  sy = 140,
  imagem1,
  imagem2,
  imagem3
}


local partsAngle = 0
local ratio = 2
local spd = 2
--------Funcoes-------

---pseudo-callbacks---
function garagem.load()
    background = love.graphics.newImage("res/images/garagem/garagem.png")
    
    --quadro
    quadro.imagem = love.graphics.newImage("res/images/premios/quadro/quadro.png")
    quadro.quadrotodo = love.graphics.newImage("res/images/premios/quadro/quadrotodo.png")
    quadro.banco = love.graphics.newImage("res/images/premios/quadro/banco.png")
    quadro.pedal = love.graphics.newImage("res/images/premios/quadro/pedal1.png")
    quadro.pedal1 = love.graphics.newImage("res/images/premios/quadro/pedal2.png")
    quadro.pedalzinho = love.graphics.newImage("res/images/premios/quadro/pedalzinho.png")
    
    roda.imagem = love.graphics.newImage("res/images/premios/roda/roda.png")
    roda.raio = love.graphics.newImage("res/images/premios/roda/raio.png")
    roda.pneu = love.graphics.newImage("res/images/premios/roda/pneu.png")
    
    marcha.coroa = love.graphics.newImage("res/images/premios/marcha/coroa.png")
    for i = 1, 3, 1 do
      marcha.corrente[i] = love.graphics.newImage("res/images/premios/marcha/corrente" .. i .. ".png")
    end
    
    guidao.imagem = love.graphics.newImage("res/images/premios/guidao/guidao.png")
    
    buzina.imagem = love.graphics.newImage("res/images/premios/buzina/buzina.png")
    buzina.sound = love.audio.newSource("res/sound/buzina.wav", "static")
    
    freio.imagem1 = love.graphics.newImage("res/images/premios/freio/freio_1.png")
    freio.imagem2 = love.graphics.newImage("res/images/premios/freio/freio_2.png")
    freio.imagem3 = love.graphics.newImage("res/images/premios/freio/freio_3.png")
    
end

function garagem.update(dt)
    if (love.mouse.getX() < (WIDTH/1360)*(quadro.sx-60) or love.mouse.getX() > (WIDTH/1360)*(quadro.sx+300) or love.mouse.getY() < (HEIGHT/860)*(quadro.sy-60) or love.mouse.getY() > (HEIGHT/860)*(quadro.sy+210)) and quadro.selection then
      quadro.selection = false
    end
    
    if (love.mouse.getX() < (WIDTH/1360)*(roda.sx-40) or love.mouse.getX() > (WIDTH/1360)*(roda.sx+320) or love.mouse.getY() < (HEIGHT/860)*(roda.sy-40) or love.mouse.getY() > (HEIGHT/860)*(roda.sy+300)) and roda.selection then
      roda.selection = false
    end
    
    if (love.mouse.getX() < (WIDTH/1360)*(guidao.sx-40) or love.mouse.getX() > (WIDTH/1360)*(guidao.sx+320) or love.mouse.getY() < (HEIGHT/860)*(guidao.sy-40) or love.mouse.getY() > (HEIGHT/860)*(guidao.sy+300)) and guidao.selection then
      guidao.selection = false
    end
    
    if (love.mouse.getX() < (WIDTH/1360)*(buzina.sx) or love.mouse.getX() > (WIDTH/1360)*(buzina.sx+48) or love.mouse.getY() < (HEIGHT/860)*(buzina.sy) or love.mouse.getY() > (HEIGHT/860)*(buzina.sy+48)) and buzina.selection then
      buzina.selection = false
    end
    
     if freio.draw then
        if (love.mouse.getX() > (WIDTH/1360)*(freio.sx) and love.mouse.getX() < (WIDTH/1360)*(freio.sx+100) and love.mouse.getY() > (HEIGHT/860)*(freio.sy-30) and love.mouse.getY() < (HEIGHT/860)*(freio.sy+130)) and love.mouse.isDown(1) then
          freio.selection = false
        else
          freio.selection = true
        end
      end
    
    if buzina.selection then
      love.audio.play(buzina.sound)
    else
      love.audio.stop(buzina.sound)
    end
    
    if freio.selection then
      partsAngle = partsAngle + spd*dt
    else
      if buzina.selection then
        partsAngle = partsAngle + spd*dt
      else
        partsAngle = partsAngle
      end
    end
    
end

function garagem.draw()
  
    garagem.drawHUD()
    
    garagem.partsSelector()
    
    --Draws da roda
    if roda.draw then      
      garagem.drawRoda()
      
      if roda.selection then
        garagem.selection(roda.sx, roda.sy)
        
      end
    end
    
    --Draws do quadro
    if quadro.draw then
      garagem.drawQuadro()
      
    end
    
    --Draw do guidao
    if guidao.draw then
      garagem.drawGuidao()
      
      if guidao.selection then
        garagem.selection(guidao.sx, guidao.sy)
      end
    end
    
    --Draw da marcha
    if marcha.draw then
      garagem.drawMarcha()
    end
    
    if buzina.draw then
      garagem.drawBuzina()
      if buzina.selection then
        --garagem.selection(buzina.sx, buzina.sy)
      end
    end
    
    if quadro.draw then
      if quadro.selection then
        garagem.selection(quadro.sx, quadro.sy)
        
      end
    end
    
    if freio.draw then
      garagem.drawFreio()
    end
    
end

function garagem.keypressed(key)
    if key == keys.back then
      love.mouse.setVisible(false)
      changeToMenu()
    end
    
    if key == 'right' and ratio < 4 then
      ratio = ratio + 0.2
    elseif key == 'left' and ratio > 0.5 then
      ratio = ratio - 0.2
    end
end

function garagem.mousepressed(x, y, button, istouch)
    if button == 1 then 
      if x > (WIDTH/1360)*1020 and x < (WIDTH/1360)*1140 and y > (HEIGHT/860)*130 and y < (HEIGHT/860)*290 then
        if desafio1.getWon() then
          quadro.draw = true
        end
        
      elseif x > (WIDTH/1360)*1060 and x < (WIDTH/1360)*1320 and y > (HEIGHT/860)*130 and y < (HEIGHT/860)*290 then
        if desafio3.getWon() then
          roda.draw = true
        end
      
      elseif x > (WIDTH/1360)*1020 and x < (WIDTH/1360)*1140 and y > (HEIGHT/860)*320 and y < (HEIGHT/860)*480 then
        guidao.draw = true
        
      elseif x > (WIDTH/1360)*1060 and x < (WIDTH/1360)*1320 and y > (HEIGHT/860)*320 and y < (HEIGHT/860)*480 then
        marcha.draw = true
      
      elseif x > (WIDTH/1360)*1020 and x < (WIDTH/1360)*1140 and y > (HEIGHT/860)*510 and y < (HEIGHT/860)*660 then
        if desafio6.getWon() then
          buzina.draw = true
        end
      
      elseif x > (WIDTH/1360)*1060 and x < (WIDTH/1360)*1320 and y > (HEIGHT/860)*510 and y < (HEIGHT/860)*660 then
        freio.draw = true
      end
      
      
      if quadro.draw then 
        if x > (WIDTH/1360)*(quadro.sx-30) and x < (WIDTH/1360)*(quadro.sx+200) and y > (HEIGHT/860)*(quadro.sy-30) and y < (HEIGHT/860)*(quadro.sx+130) and not quadro.selection then
          quadro.selection = true
          
        else
          garagem.selectPress(x, y, quadro.sx, quadro.sy, quadro)
          
        end
      end
      
      if roda.draw then 
        if x > (WIDTH/1360)*(roda.sx) and x < (WIDTH/1360)*(roda.sx+300) and y > (HEIGHT/860)*(roda.sy) and y < (HEIGHT/860)*(roda.sy+250) and not roda.selection then
          roda.selection = true
          
        else
          garagem.selectPress(x, y, roda.sx, roda.sy, roda)
          
        end
      end
      if guidao.draw then
        if x > (WIDTH/1360)*(guidao.sx) and x < (WIDTH/1360)*(guidao.sx+200) and y > (HEIGHT/860)*(guidao.sy-30) and y < (HEIGHT/860)*(guidao.sx+130) and not guidao.selection then
          guidao.selection = true
          
        else
          garagem.selectPress(x, y, guidao.sx, guidao.sy, guidao)
          
        end
      end
      
       if buzina.draw then
        if x > (WIDTH/1360)*(buzina.sx) and x < (WIDTH/1360)*(buzina.sx+48) and y > (HEIGHT/860)*(buzina.sy) and y < (HEIGHT/860)*(buzina.sx+48) and not buzina.selection then
          buzina.selection = true
          
          
        else
          --garagem.selectPress(x, y, buzina.sx, buzina.sy, buzina)
          
        end
      end
      
     
      
        
    end
    
end

---outras-funcoes---
function garagem.selection(x, y)
    love.graphics.setColor(1,1,1, 0.5)
    love.graphics.rectangle ("fill", (WIDTH/1360)*x, (HEIGHT/860)*y, (WIDTH/1360)*170, (HEIGHT/860)*170)
        
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle ("fill", (WIDTH/1360)*(x+10), (HEIGHT/860)*(y+10), (WIDTH/1360)*70, (HEIGHT/860)*70)
        
    love.graphics.setColor(0,1,0)
    love.graphics.rectangle ("fill", (WIDTH/1360)*(x+90), (HEIGHT/860)*(y+10), (WIDTH/1360)*70, (HEIGHT/860)*70)
        
    love.graphics.setColor(0,0,1)
    love.graphics.rectangle ("fill", (WIDTH/1360)*(x+10), (HEIGHT/860)*(y+90), (WIDTH/1360)*70, (HEIGHT/860)*70)
        
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle ("fill", (WIDTH/1360)*(x+90), (HEIGHT/860)*(y+90), (WIDTH/1360)*70, (HEIGHT/860)*70)
    
end

function garagem.selectPress(x, y, dx, dy, parte)
    if x >(WIDTH/1360)*(dx+10) and x < (WIDTH/1360)*(dx+80) and y > (HEIGHT/860)*(dy+10) and y < (HEIGHT/860)*(dy+70) then
            parte.color.r=1
            parte.color.g=0
            parte.color.b=0
            
          elseif x > (WIDTH/1360)*(dx+90) and x < (WIDTH/1360)*(dx+160) and y > (HEIGHT/860)*(dy+10) and y < (HEIGHT/860)*(dy+70) then
            parte.color.r=0
            parte.color.g=1
            parte.color.b=0
            
          elseif x > (WIDTH/1360)*(dx+10) and x < (WIDTH/1360)*(dx+80) and y > (HEIGHT/860)*(dy+90) and y < (HEIGHT/860)*(dy+160) then
            parte.color.r=0
            parte.color.g=0
            parte.color.b=1
            
          elseif x > (WIDTH/1360)*(dx+90) and x < (WIDTH/1360)*(dx+160) and y > (HEIGHT/860)*(dy+90) and y < (HEIGHT/860)*(dy+160) then
            parte.color.r=1
            parte.color.g=1
            parte.color.b=1
            
          end
          
end

function garagem.drawHUD()
    --Background
    love.graphics.setColor(1,1,1)
    love.graphics.draw(background, 0, 0, 0, (WIDTH/1360)*1.8, (HEIGHT/860)*1.8)
    
    --Nome da Tela
    love.graphics.setColor(1,0,0)
    love.graphics.setFont(fontBig1)
    love.graphics.printf("Peças", (WIDTH/1360)*1000, (HEIGHT/860)*20, (WIDTH/1360)*300, "center")
    love.graphics.setColor(0,0,0, 0.2)
    love.graphics.rectangle ("fill", (WIDTH/1360)*1000, (HEIGHT/860)*100, (WIDTH/1360)*300, (HEIGHT/860)*600)
    
    --Parts Select
    love.graphics.setColor(1,1,1)
    
    love.graphics.rectangle ("fill", (WIDTH/1360)*1020, (HEIGHT/860)*130, (WIDTH/1360)*120, (HEIGHT/860)*160)
    love.graphics.rectangle ("fill", (WIDTH/1360)*1020, (HEIGHT/860)*320, (WIDTH/1360)*120, (HEIGHT/860)*160)
    love.graphics.rectangle ("fill", (WIDTH/1360)*1020, (HEIGHT/860)*510, (WIDTH/1360)*120, (HEIGHT/860)*160)
    love.graphics.rectangle ("fill", (WIDTH/1360)*1160, (HEIGHT/860)*130, (WIDTH/1360)*120, (HEIGHT/860)*160)
    love.graphics.rectangle ("fill", (WIDTH/1360)*1160, (HEIGHT/860)*320, (WIDTH/1360)*120, (HEIGHT/860)*160)
    love.graphics.rectangle ("fill", (WIDTH/1360)*1160, (HEIGHT/860)*510, (WIDTH/1360)*120, (HEIGHT/860)*160)
    
end

function garagem.partsSelector()
    love.graphics.setColor(1,1,1)
    
    --Quadro
    if desafio1.getWon() then
      love.graphics.draw(quadro.quadrotodo, (WIDTH/1360)*1020, (HEIGHT/860)*170, 0, (WIDTH/1360)*1.8, (HEIGHT/860)*1.8)
    else
      love.graphics.setFont(fontSmall2)
      love.graphics.setColor(1,0,0)
      love.graphics.printf("Complete o desafio 1", (WIDTH/1360)*1025, (HEIGHT/860)*180, (WIDTH/1360)*110, "center")
      love.graphics.setColor(1,1,1)
    end
    
    --Roda
    if desafio3.getWon () then
      love.graphics.draw(roda.imagem, (WIDTH/1360)*1180, (HEIGHT/860)*170, 0, (WIDTH/1360)*2.4, (HEIGHT/860)*2.4)
    else
      love.graphics.setFont(fontSmall2)
      love.graphics.setColor(1,0,0)
      love.graphics.printf("Complete o desafio 3", (WIDTH/1360)*1165, (HEIGHT/860)*180, (WIDTH/1360)*110, "center")
      love.graphics.setColor(1,1,1)
    end
    
    --Guidao
      love.graphics.draw(guidao.imagem, (WIDTH/1360)*1040, (HEIGHT/860)*360, 0, (WIDTH/1360)*2.4, (HEIGHT/860)*3)
    
    
    --Marcha
    love.graphics.draw(marcha.corrente[1], (WIDTH/1360)*1165, (HEIGHT/860)*340, 0, (WIDTH/1360)*0.9, (HEIGHT/860)*0.9)
    love.graphics.draw(marcha.coroa, (WIDTH/1360)*1180, (HEIGHT/860)*380, 0, (WIDTH/1360)*2, (HEIGHT/860)*2)
    
    --Buzina
    if desafio6.getWon() then
      love.graphics.draw(buzina.imagem, (WIDTH/1360)*1040, (HEIGHT/860)*550, 0, (WIDTH/1360)*8.5, (HEIGHT/860)*8.5)
    else
      love.graphics.setFont(fontSmall2)
      love.graphics.setColor(1,0,0)
      love.graphics.printf("Complete o desafio 6", (WIDTH/1360)*1025, (HEIGHT/860)*560, (WIDTH/1360)*110, "center")
      love.graphics.setColor(1,1,1)
    end
    
    --Freio
    love.graphics.draw(freio.imagem3, (WIDTH/1360)*1175, (HEIGHT/860)*560, 0, (WIDTH/1360)*6, (HEIGHT/860)*6)
    
end


function garagem.drawQuadro()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(quadro.pedalzinho,
      (WIDTH/1360)*550 + (WIDTH/1360)*7.3*math.cos(partsAngle + math.pi/12)*10,
      (HEIGHT/860)*580 + (HEIGHT/860)*8.5*math.sin(partsAngle + math.pi/12)*10,
      0, (WIDTH/1360)*10, (HEIGHT/860)*10, quadro.pedalzinho:getWidth()/2, quadro.pedalzinho:getHeight()/2)
    love.graphics.draw(quadro.pedal1, (WIDTH/1360)*550, (HEIGHT/860)*580, partsAngle, (WIDTH/1360)*10, (HEIGHT/860)*10, quadro.pedal:getWidth()*(8/18), quadro.pedal:getHeight()/2)
    
    
    love.graphics.setColor(quadro.color.r, quadro.color.g, quadro.color.b)
    love.graphics.draw(quadro.imagem, (WIDTH/1360)*250, (HEIGHT/860)*300, 0, (WIDTH/1360)*10, (HEIGHT/860)*10)
    love.graphics.setColor(1, 1, 1)
    
    
    love.graphics.draw(quadro.pedal, (WIDTH/1360)*550, (HEIGHT/860)*580, partsAngle, (WIDTH/1360)*10, (HEIGHT/860)*10, quadro.pedal:getWidth()*(8/18), quadro.pedal:getHeight()/2)
    love.graphics.draw(quadro.pedalzinho,
      (WIDTH/1360)*550 + (WIDTH/1360)*7.3*math.cos(partsAngle + math.pi*13/12)*10,
      (HEIGHT/860)*580 + (HEIGHT/860)*8.5*math.sin(partsAngle + math.pi*13/12)*10,
      0, (WIDTH/1360)*10, (HEIGHT/860)*10, quadro.pedalzinho:getWidth()/2, quadro.pedalzinho:getHeight()/2)
    
    love.graphics.draw(quadro.banco, (WIDTH/1360)*460, (HEIGHT/860)*330, 0, (WIDTH/1360)*10, (HEIGHT/860)*10)
    
    
    
end

function garagem.drawRoda()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(roda.pneu, (WIDTH/1360)*848, (HEIGHT/860)*575, partsAngle*ratio, (WIDTH/1360)*7, (WIDTH/1360)*7, roda.pneu:getWidth()/2, roda.pneu:getHeight()/2)
    love.graphics.draw(roda.pneu, (WIDTH/1360)*260, (HEIGHT/860)*548, partsAngle*ratio, (WIDTH/1360)*7, (WIDTH/1360)*7, roda.pneu:getWidth()/2, roda.pneu:getHeight()/2)
      
    love.graphics.setColor(roda.color.r, roda.color.g, roda.color.b)
    love.graphics.draw(roda.raio, (WIDTH/1360)*848, (HEIGHT/860)*575, partsAngle*ratio, (WIDTH/1360)*7, (WIDTH/1360)*7, roda.raio:getWidth()/2, roda.raio:getHeight()/2)
    love.graphics.draw(roda.raio, (WIDTH/1360)*260, (HEIGHT/860)*548, partsAngle*ratio, (WIDTH/1360)*7, (WIDTH/1360)*7, roda.raio:getWidth()/2, roda.raio:getHeight()/2)
end

function garagem.drawMarcha()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(marcha.coroa, (WIDTH/1360)*550, (HEIGHT/860)*580, partsAngle, (WIDTH/1920)*3.5, (HEIGHT/1080)*3.5, marcha.coroa:getWidth()/2, marcha.coroa:getHeight()/2)
    
    love.graphics.draw(marcha.coroa, (WIDTH/1360)*260, (HEIGHT/860)*548, partsAngle*ratio, (WIDTH/1920)*1.7, (HEIGHT/1080)*1.7, marcha.coroa:getWidth()/2, marcha.coroa:getHeight()/2)
    
    love.graphics.draw(marcha.corrente[math.floor(partsAngle*3.2%3)+1], (WIDTH/1360)*415, (HEIGHT/860)*575, 0.015, (WIDTH/1920)*4.2, (HEIGHT/1080)*4.2, marcha.corrente[1]:getWidth()/2, marcha.corrente[1]:getHeight()/2)
    
    if quadro.draw then
    
      love.graphics.draw(quadro.pedal, (WIDTH/1360)*550, (HEIGHT/860)*580, partsAngle, (WIDTH/1360)*10, (HEIGHT/860)*10, quadro.pedal:getWidth()*(8/18), quadro.pedal:getHeight()/2)
      love.graphics.draw(quadro.pedalzinho,
        (WIDTH/1360)*550 + (WIDTH/1360)*7.3*math.cos(partsAngle + math.pi*13/12)*10,
        (HEIGHT/860)*580 + (HEIGHT/860)*8.5*math.sin(partsAngle + math.pi*13/12)*10,
        0, (WIDTH/1360)*10, (HEIGHT/860)*10, quadro.pedalzinho:getWidth()/2, quadro.pedalzinho:getHeight()/2)
    end
    
end

function garagem.drawGuidao()
  love.graphics.setColor(guidao.color.r, guidao.color.g, guidao.color.b)
  love.graphics.draw(guidao.imagem, (WIDTH/1360)*670, (HEIGHT/860)*130, 0, (WIDTH/1360)*10, (HEIGHT/860)*10)
  
end

function garagem.drawBuzina()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(buzina.imagem, (WIDTH/1360)*730, (HEIGHT/860)*140, 0, (WIDTH/1360)*6, (HEIGHT/860)*6)
end

function garagem.drawFreio()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(freio.imagem1, (WIDTH/1360)*710, (HEIGHT/860)*140, 0, (WIDTH/1360)*8, (HEIGHT/860)*8)
  love.graphics.draw(freio.imagem2, (WIDTH/1360)*820, (HEIGHT/860)*420, 0, (WIDTH/1360)*6, (HEIGHT/860)*6)
end
---gets/sets---





--
return garagem