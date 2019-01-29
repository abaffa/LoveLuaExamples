local Character_Selection = {}
local cs_image, cs_player, cs_char, cs_name, cs_font, cs_voltar, cs, cs_botao, cs_charImg, cs_charImgSize, cs_charNum

--Adicionar resetador de botoes antes do end

function Character_Selection:new(fonte1, fonte3)
  cs_charNum = {1,8}
  cs = "char_selection/"
  cs_botao = {1,8,0,0,false}
  cs_image = love.graphics.newImage(cs.."backgroundnovo.png")
  cs_voltar = {}
  for i=1,2 do
    cs_voltar[i] = love.graphics.newImage(cs.."voltar"..i..".png")
  end
  cs_name = {110, 190}
  cs_charImg = {}
  cs_charImgSize = {1.25,1.25,1,1.2,0.52,1.5,1.3,1}
  for i=1,8 do
    cs_charImg[i] = love.graphics.newImage(cs..i..".png")
  end
  -- INICIALIZANDO A SEMI-MATRIZ PARA O JOGADOR
  cs_count = 0
  cs_player = {}
  for i=1,3 do
    if (i<3) then
      cs_player[i] = {}
      for j=1,2 do
        cs_player[i][j]=love.graphics.newImage(cs.."player"..i..j..".png")
      end
    else
      cs_player[i]=love.graphics.newImage(cs.."player"..i..".png")
    end
  end
  --INICIALIZANDO A MATRIZ DE PERSONAGENS
  cs_char = {}
  for i=1,4 do
    cs_char[i] = {}
    for j=1,2 do
      cs_char[i][j] = love.graphics.newImage(cs.."char"..i..j..".png")
    end
  end
  -- SETANDO AS FONTES
  cs_font = {love.graphics.setNewFont(fonte3, 15), love.graphics.setNewFont(fonte1, 40), love.graphics.setNewFont(fonte1, 25), love.graphics.setNewFont(fonte3, 10), love.graphics.setNewFont(fonte1, 32)}
end

function Character_Selection:keyreleased(key)
  -- -- -- INTERFACE -- -- --
  if (key == "n" and cs_botao[3] < 9) or (key == "=" and cs_botao[4] < 9) then
    cs_botao[5] = not cs_botao[5]

  elseif (key == "space" or key == "p") and cs_botao[5] then
    cs_botao = {1,8,0,0,false}
    return 0
    -- -- -- PLAYER 1 -- -- --
  elseif key == "d" and cs_botao[3] < 9 then
    if cs_botao[1] ~= 8 then
      if cs_botao[1]+1 ~= cs_botao[2] then
        cs_botao[1] = cs_botao[1]+1
      elseif cs_botao[1]+1 == cs_botao[2] and cs_botao[2] ~= 8 then
        cs_botao[1] = cs_botao[1]+2
      else
        cs_botao[1] = 1
      end
    else
      if cs_botao[2] ~= 1 then
        cs_botao[1] = 1
      else
        cs_botao[1] = 2
      end
    end

  elseif key == "a" and cs_botao[3] < 9 then
    if cs_botao[1] ~= 1 then
      if cs_botao[1]-1 ~= cs_botao[2] then
        cs_botao[1] = cs_botao[1]-1
      elseif cs_botao[1]-1 == cs_botao[2] and cs_botao[2] ~= 1 then
        cs_botao[1] = cs_botao[1]-2
      else
        cs_botao[1] = 8
      end
    else
      if cs_botao[2] ~= 8 then
        cs_botao[1] = 8
      else
        cs_botao[1] = 7
      end
    end

  elseif (key == "s" or key == "w") and cs_botao[3] < 9 then
    if cs_botao[1]<5 and cs_botao[1]+4 ~= cs_botao[2] then
      cs_botao[1] = cs_botao[1]+4
    elseif cs_botao[1]>=5 and cs_botao[1]-4 ~= cs_botao[2] then
      cs_botao[1] = cs_botao[1]-4
    end
  elseif key == "space" and not cs_botao[5] then
    if cs_botao[3] < 9 then
      cs_botao[3] = 9
    else
      cs_botao[3] = 10
    end
  elseif key == "n" and cs_botao[3] > 8 then
    cs_botao[3] = cs_botao[3]-1
    
    -- -- -- PLAYER 2 -- -- --
  elseif key == "l" and cs_botao[4] < 9 then
    if cs_botao[2] ~= 8 then
      if cs_botao[2]+1 ~= cs_botao[1] then
        cs_botao[2] = cs_botao[2]+1
      elseif cs_botao[2]+1 == cs_botao[1] and cs_botao[1] ~= 8 then
        cs_botao[2] = cs_botao[2]+2
      else
        cs_botao[2] = 1
      end
    else
      if cs_botao[1] ~= 1 then
        cs_botao[2] = 1
      else
        cs_botao[2] = 2
      end
    end

  elseif key == "j" and cs_botao[4] < 9 then
    if cs_botao[2] ~= 1 then
      if cs_botao[2]-1 ~= cs_botao[1] then
        cs_botao[2] = cs_botao[2]-1
      elseif cs_botao[2]-1 == cs_botao[1] and cs_botao[1] ~= 1 then
        cs_botao[2] = cs_botao[2]-2
      else
        cs_botao[2] = 8
      end
    else
      if cs_botao[1] ~= 8 then
        cs_botao[2] = 8
      else
        cs_botao[2] = 7
      end
    end

  elseif (key == "k" or key == "i") and cs_botao[4] < 9 then
    if cs_botao[2]<5 and cs_botao[2]+4 ~= cs_botao[1] then
      cs_botao[2] = cs_botao[2]+4
    elseif cs_botao[2]>=5 and cs_botao[2]-4 ~= cs_botao[1] then
      cs_botao[2] = cs_botao[2]-4
    end
  elseif key == "p" and not cs_botao[5] then
    if cs_botao[4] < 9 then
      cs_botao[4] = 9
    else
      cs_botao[4] = 10
    end
    elseif key == "=" and cs_botao[4] > 8 then
    cs_botao[4] = cs_botao[4]-1
  end
  -- TROCA DE TELA --
  if cs_botao[3]==10 and cs_botao[4]==10 then
    cs_botao = {cs_botao[1], cs_botao[2],0,0,false}
    return 4, cs_botao[1], cs_botao[2]
  else
    return 1
  end
end

function Character_Selection:characterNumber()
  for i=1,2 do
    cs_charNum[i] = cs_botao[i]
  end
  return charNum
end

function Character_Selection:draw(prop, extraX, extraY)
  love.graphics.setFont(cs_font[1])
  -- -- -- -- -- -- IMAGENS -- -- -- -- -- -- -- --
  love.graphics.draw(cs_image, extraX, extraY, 0, prop)

  for i=1,2 do
    love.graphics.draw(cs_player[i][1], extraX+(200*i-150)*prop, extraY+290*prop, 0, prop) -- RET MAIOR
    love.graphics.draw(cs_player[i][2], extraX+(200*i-180)*prop, extraY+251*prop, 0, prop) -- RET DE TEXTO
    love.graphics.print("JOGADOR "..i, extraX+(200*i-179)*prop, extraY+260*prop, 0, prop) -- TEXTO DO RET ANTERIOR
    love.graphics.draw(cs_player[3], extraX+(200*i-164)*prop, extraY+440*prop, 0, prop) -- BOTAO CONFIRMAR
  end

  if not cs_botao[5] then
    love.graphics.draw(cs_voltar[1], extraX, extraY+44*prop, 0, prop)
  else
    love.graphics.draw(cs_voltar[2], extraX, extraY+44*prop, 0, prop)
  end

  for i=1,4 do
    for j=1,2 do
      love.graphics.draw(cs_char[i][j], extraX+(150+80*i)*prop, extraY+(80*j-30)*prop, 0, 1.5*prop)
    end
  end
-- -- -- ESCOLHA DO PLAYER 1 -- -- --
  love.graphics.setColor(255,0,0)
  for i=0,2 do
    love.graphics.rectangle("line", extraX+(150-i+80*(((cs_botao[1]-1)%4)+1))*prop, extraY+(80*(math.floor((cs_botao[1])/5)+1)-30-i)*prop, (1.5*cs_char[((cs_botao[1]-1)%4)+1][((cs_botao[1]-1)%2)+1]:getWidth()+2*i)*prop, (1.5*cs_char[((cs_botao[1]-1)%4)+1][((cs_botao[1]-1)%2)+1]:getHeight()+2*i)*prop, 20)
  end
  love.graphics.setColor(255,255,255)
  love.graphics.draw(cs_charImg[cs_botao[1]], extraX+(50+(cs_player[1][1]:getWidth()-cs_charImgSize[cs_botao[1]]*cs_charImg[cs_botao[1]]:getWidth())/2)*prop, extraY+(430-(cs_charImgSize[cs_botao[1]]*cs_charImg[cs_botao[1]]:getHeight()))*prop, 0, cs_charImgSize[cs_botao[1]]*prop)

love.graphics.setFont(cs_font[5])
if cs_botao[3] == 9 then  
  love.graphics.print("CONFIRMA?", extraX+55*prop, extraY+(425+cs_player[3]:getHeight()/2)*prop, 0, prop)
elseif cs_botao[3] == 10 then
  love.graphics.print("OK", extraX+100*prop, extraY+(425+cs_player[3]:getHeight()/2)*prop, 0, prop)
end

-- -- -- ESCOLHA DO PLAYER 2 -- -- --
love.graphics.setColor(0,0,255)
for i=0,2 do
  love.graphics.rectangle("line", extraX+(150-i+80*(((cs_botao[2]-1)%4)+1))*prop, extraY+(80*(math.floor((cs_botao[2])/5)+1)-30-i)*prop, (1.5*cs_char[((cs_botao[2]-1)%4)+1][((cs_botao[2]-1)%2)+1]:getWidth()+2*i)*prop, (1.5*cs_char[((cs_botao[2]-1)%4)+1][((cs_botao[2]-1)%2)+1]:getHeight()+2*i)*prop, 20)
end
love.graphics.setColor(255,255,255)
love.graphics.draw(cs_charImg[cs_botao[2]], extraX+(250+(cs_player[2][1]:getWidth()+cs_charImgSize[cs_botao[2]]*cs_charImg[cs_botao[2]]:getWidth())/2)*prop, extraY+(430-(cs_charImgSize[cs_botao[2]]*cs_charImg[cs_botao[2]]:getHeight()))*prop, 0, -cs_charImgSize[cs_botao[2]]*prop, cs_charImgSize[cs_botao[2]]*prop)

if cs_botao[4] == 9 then
  love.graphics.print("CONFIRMA?", extraX+255*prop, extraY+(425+cs_player[3]:getHeight()/2)*prop, 0, prop)
elseif cs_botao[4] == 10 then
  love.graphics.print("OK", extraX+300*prop, extraY+(425+cs_player[3]:getHeight()/2)*prop, 0, prop)
end

-- -- -- -- -- -- TEXTO -- -- -- -- -- -- -- -- --
love.graphics.setFont(cs_font[2])
love.graphics.print("ESCOLHA DE PERSONAGEM", extraX+50*prop, extraY+5*prop, 0, prop)
love.graphics.setFont(cs_font[3])
love.graphics.print("VOLTAR", extraX+50*prop, extraY+93*prop, 0, prop)
love.graphics.setFont(cs_font[4])
love.graphics.print("Chun-Li", extraX+240*prop, extraY+cs_name[1]*prop, 0, prop)
love.graphics.print("Cirno", extraX+327*prop, extraY+cs_name[1]*prop, 0, prop)
love.graphics.print("Dio", extraX+415*prop, extraY+cs_name[1]*prop, 0, prop)
love.graphics.print("Morgiana", extraX+474*prop, extraY+cs_name[1]*prop, 0, prop)
love.graphics.print("Ky Kiske", extraX+236*prop, extraY+cs_name[2]*prop, 0, prop)
love.graphics.print("Bowser", extraX+320*prop, extraY+cs_name[2]*prop, 0, prop)
love.graphics.print("Popeye", extraX+400*prop, extraY+cs_name[2]*prop, 0, prop)
love.graphics.print("Archer", extraX+480*prop, extraY+cs_name[2]*prop, 0, prop)
end

return Character_Selection