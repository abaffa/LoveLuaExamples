local Option = {}
local o_botao, o_image, font, volume, o_time, o_count

function Option:new(fonte1, fonte2)
  o_botao = 0
  o_count = 0
  o_time = 0
  volume = love.audio.getVolume()*100
  o_image = love.graphics.newImage("option/background.png")
  font = {love.graphics.setNewFont(fonte1, 70), love.graphics.setNewFont(fonte1, 40),   love.graphics.setNewFont(fonte2, 40), love.graphics.setNewFont(fonte2, 30)}
end


function Option:keyreleased(key)
  if key == "s" or key == "down" then
    if o_botao == 0 then
      o_botao = 1
    elseif o_botao > 0 and o_botao < 6 then
      o_botao = o_botao+2
    elseif o_botao == 6 then
      o_botao = 7
    elseif o_botao == 7 then
      o_botao = 1
    end
    return 2
  elseif key == "w" or key == "up" then
    if o_botao == 0 then
      o_botao = 7
    elseif o_botao > 1 and o_botao ~= 2 then
      o_botao = o_botao-2
    elseif o_botao == 1 or o_botao == 2 then
      o_botao = 7
    end
    return 2
  elseif key == "d" or key == "right" then
    if o_botao > 0 and o_botao ~= 7 then
      o_botao = o_botao+1
    else
      o_botao = 1
    end
    return 2
  elseif key == "a" or key == "left" then
    if o_botao>1 then
      o_botao = o_botao-1
    else
      o_botao = 7
    end
    return 2
  elseif key == "space" or key == "kp0" then
    if o_botao ~= 7 then
      if o_botao == 3 then
        volume = 100
      elseif o_botao == 4 then    
        volume = 0
      elseif o_botao == 5 then
        love.window.setFullscreen(true, "desktop")
      elseif o_botao == 6 then
        love.window.setFullscreen(false)
      end
      love.audio.setVolume(volume/100)
      return 2
    elseif o_botao == 7 then
      o_botao = 0
      return 0
    end
  else
    return 2
  end
end


function Option:mousereleased(button)
  if button == 1 then 
    if o_botao ~= 7 then
      if o_botao == 3 then
        volume = 100
      elseif o_botao == 4 then    
        volume = 0
      elseif o_botao == 5 then
        love.window.setFullscreen(true, "desktop")
      elseif o_botao == 6 then
        love.window.setFullscreen(false)
      end
      love.audio.setVolume(volume/100)
      return 2
    elseif o_botao == 7 then
      o_botao = 0
      return 0
    end
  else
    return 2
  end
end

function Option:mousemoved(x, y, dx, dy, prop, extraX, extraY)
  if (dx ~= 0 or dy ~= 0) then
    for i=1,3 do
      for j=1,2 do
        if y>(extraY+((53/2)*(i^2)-(43/2)*i+221)*prop) and y<(extraY+((53/2)*(i^2)-(43/2)*i+267)*prop) and x>(extraX+(228*j-45)*prop) and x<(extraX+(228*j+163)*prop) then
          o_botao = 2*i+j-2
        elseif (y>(extraY+490*prop) and y<(extraY+540*prop) and x>(extraX+340*prop) and x<(extraX+460*prop)) then
          o_botao = 7
        elseif (o_botao==2*i+j-2 or o_botao == 7) then
          o_botao = 0
        end
      end
    end
  end
end

function Option:update(dt)
  if love.mouse.isDown(1) or love.keyboard.isDown("space","kp0") then
    o_time = o_time+dt
    if o_time>0.10 or o_count == 0 then
      if o_botao == 1 and volume~=100 then
        volume = volume+1
      elseif o_botao == 2 and volume~=0 then
        volume = volume-1
      end
      o_time = 0
      o_count = 1
      love.audio.setVolume(volume/100)
    end
  else
    o_time = 0
    o_count = 0
  end
end

function Option:draw(prop, extraX, extraY)
  -- -- -- -- -- -- -- -- -- BACKGROUND -- -- -- -- -- -- -- -- --
  love.graphics.draw(o_image, extraX, extraY, 0 , prop) -- background

  -- -- -- -- -- -- -- -- -- RETANGULOS -- -- -- -- -- -- -- -- --
  love.graphics.setColor(0, 150, 255) -- AZUL
  for i=1,3 do
    for j=1,2 do
      if (o_botao == 2*i+j-2) then --*
        love.graphics.setColor(0, 200, 0)
      end
      love.graphics.rectangle("fill", extraX+(228*j-45)*prop, extraY+((53/2)*(i^2)-(43/2)*i+221)*prop, 208*prop, 46*prop) -- RETANGULO MAIOR i=1:AUMENTAR E DIMINUIR; i=2:MAXIMO E MUDO; i=3 CHEIA E JANELA
      if (o_botao == 2*i+j-2) then --*
        love.graphics.setColor(0, 150, 255)
      end
    end
  end

  love.graphics.setColor(0, 200, 0) -- VERDE
  for i=1,3 do
    for j=1,2 do
      if (o_botao == 2*i+j-2) then --*
        love.graphics.setColor(0, 150, 255)
      end
      love.graphics.rectangle("fill", extraX+(228*j-41)*prop, extraY+((53/2)*(i^2)-(43/2)*i+225)*prop, 200*prop, 38*prop) -- RETANGULO MAIOR i=1:AUMENTAR E DIMINUIR; i=2:MAXIMO E MUDO; i=3 CHEIA E JANELA
      if (o_botao == 2*i+j-2) then --*
        love.graphics.setColor(0, 200, 0)
      end
    end
  end
  -- *= INVERSAO DE CORES
  -- USAR TECNICA COM FOR DO MENU PRINCIPAL! ELA É ÓTIMA!
  love.graphics.setColor(255,0,0)  
  love.graphics.rectangle("fill", extraX+330*prop, extraY+480*prop, 140*prop, 70*prop)
  if o_botao == 7 then
    love.graphics.setColor(0,0,0)
  else
    love.graphics.setColor(255,225,0)
  end  
  love.graphics.rectangle("fill", extraX+340*prop, extraY+490*prop, 120*prop, 50*prop)
  -- -- -- -- -- -- -- -- -- -- TEXTO -- -- -- -- -- -- -- -- -- --

  love.graphics.setFont(font[1]) -- FONTE 1
  love.graphics.setColor(0, 0, 0)

  love.graphics.print("Ajustes", extraX+300*prop, extraY+50*prop, 0, prop) -- AJUSTES

  love.graphics.setFont(font[2]) -- FONTE 2
  love.graphics.print("TELA", extraX+190*prop, extraY+344*prop, 0, prop) --MODO
  love.graphics.print("VOLUME: "..volume, extraX+190*prop, extraY+175*prop, 0, prop) -- VOLUME

  love.graphics.setFont(font[3]) -- FONTE 3
  love.graphics.setColor(255, 255, 0)
  love.graphics.print("AUMENTAR", extraX+189*prop, extraY+228*prop, 0, prop) -- AUMENTAR
  love.graphics.print("DIMINUIR", extraX+439*prop, extraY+228*prop, 0, prop) -- DIMINUIR
  love.graphics.print("MUDO", extraX+460*prop, extraY+286*prop, 0, prop) -- MUDO
  love.graphics.print("MAXIMO", extraX+214*prop, extraY+286*prop, 0, prop) -- MAXIMO
  love.graphics.print("CHEIA", extraX+235*prop, extraY+397*prop, 0, prop) -- TELA CHEIA (ajeitar posicao)
  love.graphics.print("JANELA", extraX+450*prop, extraY+397*prop, 0, prop) -- JANELA (ajeitar posicao)
  love.graphics.setFont(font[4])
  love.graphics.setColor(0,150,0)
  love.graphics.print("VOLTAR", extraX+345*prop, extraY+500*prop, 0, prop) -- VOLTAR
  love.graphics.setColor(255,255,255) -- BRANCO
  -- MAIS, MENOS, MUDO, MAXIMO, TELA CHEIA, JANELA, VOLTAR
end

return Option