local Menu = {}
local enemy, count, botao, btholder
-- enemy -> música de fundo; count -> contador de tempo para reiniciar a música
-- botao -> verificador de qual botao está para ser ativado pelo usuário
local images, texto, fonte

function Menu:new(fonte1, fonte2)
  images = {love.graphics.newImage("menu/background.png"), love.graphics.newImage("menu/jogar.png"), love.graphics.newImage("menu/opcao.png"), love.graphics.newImage("menu/creditos.png")}
  fonte = love.graphics.setNewFont(fonte2, 40)
  texto = {"JOGAR", "AJUSTES", "AGRADECIMENTOS"}
  botao = 0
  btholder = 0
end

function Menu:keyreleased(key)
  if key == "down" or key == "s" then
    if botao ~= 3 then
      botao = botao + 1
    else
      botao = 1
    end
    return 0
  elseif key == "up" or key == "w" then
    if botao > 1 then
      botao = botao - 1
    else
      botao = 3
    end
    return 0
  elseif (key == "space" or key == "kp0") and botao ~= 0 then
    btholder = botao
    botao = 0
    return btholder
  else
    return 0
  end
end

function Menu:mousereleased(button, x, y, prop, extraX, extraY)
  if botao ~= 0 and button == 1 then
    if (x > extraX+230*prop and x < extraX+575*prop) then
      if (y > extraY+260*prop and y < extraY+310*prop) then
        botao = 1
      elseif (y > extraY+360*prop and y < extraY+410*prop) then
        botao = 2
      elseif(y > extraY+460*prop and y < extraY+510*prop) then
        botao = 3
      else
        botao = 0
      end
      btholder = botao
      botao = 0
      return btholder
    else
      return 0
    end
  else
    return 0
  end
end

function Menu:mousemoved(x, y, dx, dy, prop, extraX, extraY)
  if (dx ~= 0 or dy ~= 0) then
    if (x > extraX+230*prop and x < extraX+575*prop) then
      if (y > extraY+260*prop and y < extraY+310*prop) then
        botao = 1
      elseif (y > extraY+360*prop and y < extraY+410*prop) then
        botao = 2
      elseif (y > extraY+460*prop and y < extraY+510*prop) then
        botao = 3
      else
        botao = 0
      end
    else
        botao = 0
    end
  end
end

function Menu:draw(prop, extraX, extraY)
  love.graphics.draw(images[1], extraX, extraY, 0, prop)
  
  for i = 2,4 do
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("fill", extraX+215*prop, extraY+(45+100*i)*prop, 375*prop, 80*prop)
    if i == botao+1 then
      love.graphics.setColor(0,0,0)
    else
      love.graphics.setColor(255,255,0)
    end
    love.graphics.rectangle("fill", extraX+230*prop, extraY+(100*i+60)*prop, 345*prop, 50*prop)
    love.graphics.setColor(255,255,255)
  end
  love.graphics.setFont(fonte)
  love.graphics.setColor(0,150,0)
  love.graphics.print(texto[1], extraX+343*prop, extraY+265*prop, 0, prop)
  love.graphics.print(texto[2], extraX+328*prop, extraY+365*prop, 0, prop)
  love.graphics.print(texto[3], extraX+235*prop, extraY+465*prop, 0, prop)
  love.graphics.setColor(255,255,255)
  
end

return Menu