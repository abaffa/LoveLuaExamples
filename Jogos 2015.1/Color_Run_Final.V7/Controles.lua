function controle_keypressed(key)
  --Cores Primárias
  if key == "a" and z[bolota_plataforma+1] == 1 then
    botao = 1
    if botao == 1 then
      cont_score = cont_score + 1
    end
    
  end
  
  if key == "s" and z[bolota_plataforma+1] == 2 then
    botao = 2
    if botao == 2 then
      cont_score = cont_score + 1
    end
  end
  
  if key == "d" and z[bolota_plataforma+1] == 3 then
    botao = 3
    if botao == 3 then
      cont_score = cont_score + 1
    end
  end
  
  --Cores Secundárias
  if (love.keyboard.isDown("a") and love.keyboard.isDown("s") and z[bolota_plataforma+1]) == 4 then
    botao = 4
    if botao == 4 then
      cont_score = cont_score + 1
    end
  end
  
  if (love.keyboard.isDown("a") and love.keyboard.isDown("d") and z[bolota_plataforma+1]) == 6 then
    botao = 6
    if botao == 6 then
      cont_score = cont_score + 1
    end
  end
  
  if (love.keyboard.isDown("s") and love.keyboard.isDown("d") and z[bolota_plataforma+1]) == 5 then
    botao = 5
    if botao == 5 then
      cont_score = cont_score + 1
    end
  end

-- Três butões juntos
  if (love.keyboard.isDown("s") and love.keyboard.isDown("d") and love.keyboard.isDown("a") and z[bolota_plataforma+1]) == 1 then
    botao = 0
    if botao == 0 then
      score = score - 500
    end
  end
  

  if (love.keyboard.isDown("s") and love.keyboard.isDown("d") and love.keyboard.isDown("a") and z[bolota_plataforma+1]) == 2 then
    botao = 0
    if botao == 0 then
      score = score - 500
    end
  end
  
  if (love.keyboard.isDown("s") and love.keyboard.isDown("d") and love.keyboard.isDown("a") and z[bolota_plataforma+1]) == 3 then
    botao = 0
    if botao == 0 then
      score = score - 500
    end
  end
  
  if (love.keyboard.isDown("s") and love.keyboard.isDown("d") and love.keyboard.isDown("a") and z[bolota_plataforma+1]) == 4 then
    botao = 0
    if botao == 0 then
      score = score - 500
    end
  end
  
  if (love.keyboard.isDown("s") and love.keyboard.isDown("d") and love.keyboard.isDown("a") and z[bolota_plataforma+1]) == 5 then
    botao = 0
    if botao == 0 then
      score = score - 500
    end
  end
  
  if (love.keyboard.isDown("s") and love.keyboard.isDown("d") and love.keyboard.isDown("a") and z[bolota_plataforma+1]) == 6 then
    botao = 0
    if botao == 0 then
      score = score - 500
    end
  end
  
  -- Dois butões errados
  if (love.keyboard.isDown("a") and love.keyboard.isDown("d") and z[bolota_plataforma+1]) == 1 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  
  if (love.keyboard.isDown("a") and love.keyboard.isDown("d") and z[bolota_plataforma+1]) == 4 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  
  if (love.keyboard.isDown("a") and love.keyboard.isDown("d") and z[bolota_plataforma+1]) == 5 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  
  if (love.keyboard.isDown("a") and love.keyboard.isDown("s") and z[bolota_plataforma+1]) == 1 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  
  if (love.keyboard.isDown("a") and love.keyboard.isDown("s") and z[bolota_plataforma+1]) == 5 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  
  if (love.keyboard.isDown("a") and love.keyboard.isDown("s") and z[bolota_plataforma+1]) == 6 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  
  if (love.keyboard.isDown("s") and love.keyboard.isDown("d") and z[bolota_plataforma+1]) == 2 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  
  if (love.keyboard.isDown("s") and love.keyboard.isDown("d") and z[bolota_plataforma+1]) == 4 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  
  if (love.keyboard.isDown("s") and love.keyboard.isDown("d") and z[bolota_plataforma+1]) == 6 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  
  if (love.keyboard.isDown("s") and love.keyboard.isDown("a") and z[bolota_plataforma+1]) == 2 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  
  if (love.keyboard.isDown("d") and love.keyboard.isDown("s") and z[bolota_plataforma+1]) == 3 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  
  if (love.keyboard.isDown("d") and love.keyboard.isDown("a") and z[bolota_plataforma+1]) == 3 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  
  if (love.keyboard.isDown("d") and z[bolota_plataforma+1]) == 1 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  
  if (love.keyboard.isDown("d") and z[bolota_plataforma+1]) == 2 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  
  if (love.keyboard.isDown("s") and z[bolota_plataforma+1]) == 1 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  
  if (love.keyboard.isDown("s") and z[bolota_plataforma+1]) == 3 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  
  if (love.keyboard.isDown("a") and z[bolota_plataforma+1]) == 2 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  
  if (love.keyboard.isDown("a") and z[bolota_plataforma+1]) == 3 then
    botao = 0
    if botao == 0 then
      score = score - 500
      cont_score = 0
    end
  end
  if score <=0 then
  score = 0
end
  -- cor branca
  if  key == "a" and z[bolota_plataforma+1] == 7 then
    botao = 1
    if botao == 1 then
      cont_score = cont_score + 1
    end
  end
  if key == "s" and z[bolota_plataforma+1] == 7 then
    botao = 2
    if botao == 2 then
      cont_score = cont_score + 1
    end
  end
  
  if key == "d" and z[bolota_plataforma+1] == 7 then
    botao = 3
    if botao == 3 then
      cont_score = cont_score + 1
    end
  end
  if (love.keyboard.isDown("a") and love.keyboard.isDown("s") and z[bolota_plataforma+1]) == 7 then
    botao = 4
    if botao == 4 then
      cont_score = cont_score + 1
    end
  end
  
  if (love.keyboard.isDown("a") and love.keyboard.isDown("d") and z[bolota_plataforma+1]) == 7 then
    botao = 6
    if botao == 6 then
      cont_score = cont_score + 1
    end
  end
  
  if (love.keyboard.isDown("s") and love.keyboard.isDown("d") and z[bolota_plataforma+1]) == 7 then
    botao = 5
    if botao == 5 then
      cont_score = cont_score + 1
    end
  end
end