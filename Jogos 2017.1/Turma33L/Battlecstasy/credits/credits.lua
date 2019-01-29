local Credits = {}
local nomes, c_botao, font1, font2, background

function Credits:new(fonte1, fonte2)
  nomes = {"ALEXANDRE HEINE", "BRENO ALBERIGI", "GABRIEL ROCHA", "HENRIQUE PERES", "MARCELO DRUMMOND", "ISABELLA RONCOLI"}
  background = love.graphics.newImage("credits/background.png")
  c_botao = 3
  font1 = love.graphics.newFont(fonte1, 70)
  font2 = love.graphics.newFont(fonte2, 30)
end

function Credits:keyreleased(key)
  if key == "down" or key == "up" or key == "s" or key == "w" then
    c_botao = 0
    return 3
  elseif (key == "space" or key == "kp0") and c_botao == 0 then
    c_botao = 3
    return 0
  else
    return 3
  end
end

function Credits:mousereleased(button, x, y, prop, extraX, extraY)
  if c_botao == 0 and button == 1 and (y>extraY+500*prop and y<extraY+550*prop) and (x>extraX+340*prop and x<extraX+460*prop) then
    c_botao = 3
    return 0
  else
    return 3
  end
end

function Credits:mousemoved(x, y, dx, dy, prop, extraX, extraY)
  if (dx ~= 0  or dy ~= 0) then
    if (y>extraY+500*prop and y<extraY+550*prop) and (x>extraX+340*prop and x<extraX+460*prop)  then
      c_botao = 0
    else
      c_botao = 3
    end
  end
end

function Credits:draw(prop, extraX, extraY)
  love.graphics.draw(background, extraX, extraY, 0 ,prop)
  love.graphics.setColor(0,0,100)
  love.graphics.setFont(font1)
  love.graphics.print("Agradecimentos", extraX+200*prop, extraY+40*prop, 0, prop)
  love.graphics.setFont(font2)
  for i = 1,6 do
    love.graphics.print(nomes[i], extraX+285*prop, extraY+(100+50*i)*prop, 0, prop)
  end
  love.graphics.setColor(255,0,0)  
  love.graphics.rectangle("fill", extraX+330*prop, extraY+490*prop, 140*prop, 70*prop)
  if c_botao ~= 3 then
    love.graphics.setColor(0,0,0)
  else
    love.graphics.setColor(255,225,0)
  end  
  love.graphics.rectangle("fill", extraX+340*prop, extraY+500*prop, 120*prop, 50*prop)
  love.graphics.setColor(0,150,0)
  love.graphics.print("VOLTAR", extraX+345*prop, extraY+510*prop, 0, prop)
  love.graphics.setColor(255,255,255)

end

return Credits