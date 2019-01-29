local Arena_Selection = {}
local as_image, as_arena, as_arncount, as_voltar, as_botao, as_player, as_arnQuad, as_arnQuadW, as_arnQuadH, as_arnNames, as_randomN, as_time
math.randomseed(os.time())

function Arena_Selection:new(fonte1, fonte3)
  as_time = 0
  as = "arena_selection/"
  as_image = love.graphics.newImage(as.."background.png")
  as_arena = love.graphics.newImage(as.."arena.png")
  as_arnQuadW = as_image:getWidth()/6
  as_arnQuadH = as_image:getHeight()/3
  as_arnNames = {"CRATERA VULCANICA", "CASTELO DO BOWSER", "MONTANHA DA NOITE", "TORRE DO DIO", "CHRONO CITY", "COLISEU", "MILLS HOUSE", "ROTA 66", "PONTE TRIBAL", "LAR DE HADES", "FRANKFURT", "PORTO", "XANGAI", "TERRAÇO NOTURNO", "AEROPORTO", "NEPAL", "LITTLE TONY CLEITH", "DESERTO DE NEVADA"}
  as_arncount = 1
  as_botao = {2,1,false,false,false, 0} -- 1-Mapa Player1; 2-Mapa Player2; 3-Player1: Confirma?; 4-Player2: Confirma?; 5-Os dois confirmam?; 6- Mapa aleatório entre os dois escolhidos pelos jogadores.
  as_time = 0
  as_arnQuad = {}
  for i = 0,2 do
    for j = 0,5 do
      as_arnQuad[as_arncount] = love.graphics.newQuad(2*j*as_arnQuadW, i*as_arnQuadH, as_arnQuadW*2, as_arnQuadH, as_arnQuadW*12, as_arnQuadH*3)
      as_arncount = as_arncount+1
    end
  end

  as_player = {}
  for i = 1,2 do
    --for j = 1,3 do
    as_player[i] = love.graphics.newImage(as.."player"..i.."1.png")
    --end
  end

  as_voltar = {}
  for i=1,2 do
    as_voltar[i] = love.graphics.newImage(as.."voltar"..i..".png")
  end

  as_font = {love.graphics.setNewFont(fonte3, 15), love.graphics.setNewFont(fonte1, 40), love.graphics.setNewFont(fonte1, 25), love.graphics.setNewFont(fonte1, 32)}
end

function Arena_Selection:keyreleased(key, dt)
  if not as_botao[3] or not as_botao[4] then
    -- PLAYER 1 --
    if not as_botao[3] then
      if key == "a" then
        if as_botao[1] ~= 1 then
          as_botao[1] = as_botao[1]-1
        else
          as_botao[1] = 18
        end
      elseif key == "d" then
        if as_botao[1] ~= 18 then
          as_botao[1] = as_botao[1]+1
        else
          as_botao[1] = 1
        end
      elseif key == "w" then
        if as_botao[1] >= 7 then
          as_botao[1] = as_botao[1]-6
        else
          as_botao[1] = as_botao[1]+12
        end
      elseif key == "s" then
        if as_botao[1] < 13 then
          as_botao[1] = as_botao[1]+6
        else
          as_botao[1] = as_botao[1]-12
        end
      elseif key == "space" then
        if not as_botao[5] then
          as_botao[3] = true
        else
          as_botao = {1,1,false,false,false, 0}
          return 1
        end
      elseif key == "n" then
        as_botao[5] = not as_botao[5]
      end
    end

    -- PLAYER 2 --
    if not as_botao[4] then
      if key == "j" then
        if as_botao[2] ~= 1 then
          as_botao[2] = as_botao[2]-1
        else
          as_botao[2] = 18
        end
      elseif key == "l" then
        if as_botao[2] ~= 18 then
          as_botao[2] = as_botao[2]+1
        else
          as_botao[2] = 1
        end
      elseif key == "k" then
        if as_botao[2] < 13 then
          as_botao[2] = as_botao[2]+6
        else
          as_botao[2] = as_botao[2]-12
        end
      elseif key == "i" then
        if as_botao[2] > 6 then
          as_botao[2] = as_botao[2]-6
        else
          as_botao[2] = as_botao[2]+12
        end
      elseif key == "p" then
        if not as_botao[5] then
          as_botao[4] = true
        else
          as_botao = {1,1,false,false,false,0}
          return 1
        end
      elseif key == "=" then
        as_botao[5] = not as_botao[5]
      end
    end
  end    
  return 4
end

function Arena_Selection:update(dt)
  if as_botao[3] and as_botao[4] then
    as_time = as_time+dt
    if as_time < 0.5 then
      as_randomN = math.random(1,2)
      as_botao[6] = as_botao[as_randomN]
    elseif as_time >= 2.5 then
      as_botao = {1,1,false,false,false,as_botao[6]}
      return 5, as_botao[6]
    end
  end
  return 4
end

function Arena_Selection:draw(prop, extraX, extraY)
  -- BACKGROUND E IMAGEM DAS ARENAS --
  love.graphics.draw(as_image, extraX, extraY, 0, prop)
  love.graphics.draw(as_arena, extraX+162.5*prop, extraY+44*prop, 0, 0.85*prop)
  
  -- RETANGULO E TITULO DA TELA --
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill", extraX, extraY, 800*prop, 44*prop)
  love.graphics.setColor(255,255,255)
  love.graphics.setFont(as_font[2])
  love.graphics.print("ESCOLHA DE ARENA", extraX+50*prop, extraY+5*prop, 0, prop)
  
  -- -- -- BOTAO VOLTAR -- -- --
  if not as_botao[5] then
    love.graphics.draw(as_voltar[1], extraX, extraY+44*prop, 0, prop)
  else
    love.graphics.draw(as_voltar[2], extraX, extraY+44*prop, 0, prop)
  end
  love.graphics.setFont(as_font[3])
  love.graphics.print("VOLTAR", extraX+50*prop, extraY+93*prop, 0, prop)
  
  -- INTERFACE DOS JOGADORES --
  love.graphics.setFont(as_font[1])
  for i=0,1 do
    love.graphics.draw(as_player[i+1], extraX+(162.5+(as_player[1]:getWidth()+110)*i)*prop, extraY+369*prop, 0, prop)
    love.graphics.print("JOGADOR "..(i+1), extraX+(163.5+(as_player[1]:getWidth()+110)*i)*prop, extraY+378*prop, 0, prop)
  
    love.graphics.draw(as_arena, as_arnQuad[as_botao[i+1]], extraX+(160+(as_player[1]:getWidth()+110)*i+(128-as_arnQuadW)/2)*prop, extraY+420*prop, 0, prop/2)
  end
  -- COMPUTADOR RANDOM --
  love.graphics.setColor(0,255,0)
  love.graphics.draw(as_player[1], extraX+(162.5+(as_player[1]:getWidth()+110)*2)*prop, extraY+369*prop, 0, 1.2*prop, prop)
  love.graphics.setColor(255,255,255)
  if as_botao[5] then as_botao[7] = 1 else as_botao[7] = 0 end
  love.graphics.print("COMPUTADOR", extraX+(163.5+(as_player[1]:getWidth()+110)*2)*prop, extraY+378*prop, 0, prop)
  if as_botao[3] and as_botao[4] then
    love.graphics.draw(as_arena, as_arnQuad[as_botao[6]], extraX+(162.5+(as_player[1]:getWidth()+110)*2+(1.2*128-as_arnQuadW)/2)*prop, extraY+420*prop, 0, prop/2)
  end
  -- ESCOLHA DOS JOGADORES --
  --[[love.graphics.setColor(255,0,0)
  for i=0,2 do
    love.graphics.rectangle("line", extraX+()*prop, extraY+()*prop, (1.2*as_arnQuadW[]:getWidth()+2*i)*prop, (1.2*as_arnQuadH[]:getHeight()+2*i)*prop, 20)
  end]]
  --love.graphics.print(as_botao[6], 400, 100, 0, 10) -- VÊ O NÚMERO DO MAPA
end

return Arena_Selection