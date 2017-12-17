player = {}

local second = 0


function player.animate(dt)
  second = second + dt
  if(second > 0.2 and not paused) then
    if(frameAtual < 9) then
      frameAtual = frameAtual + 1
    else
      frameAtual = 1
    end
    if(hero.runRight) then
      activeFrame = framesRunRight[frameAtual] 
    elseif(hero.runLeft) then
      activeFrame = framesRunLeft[frameAtual] 
    end
    second = 0
  end
end

function moveStage(dt)
  background.x = background.x - 100 *dt
  px = px - 100 * dt
  if(background.x < -800) then
      background.x = 0
  end
end
      

function player.heroMoves(dt)
  
  if(love.keyboard.isDown("d") and hero.y == ground) then   -- Se apertar a tela "d"
    hero.runRight = true   
    if((background.image == stage2 or background.image == stage6 or background.image == stage15 or background.image == stage19) and (px - hero.x) > 300 and not bossAlive and hero.x > 100) then  
      moveStage(dt)
    else
      hero.x = hero.x + 100 *dt    
    end 
    if (hero.x > 750 and qtdStage ~= 12) then
      hero.x = 750
    elseif(hero.x > 550 and qtdStage == 12 and qtdSpeech <= 5) then
      hero.x = 550
    end
    
  elseif(love.keyboard.isDown("a") and hero.y == ground) then   -- Corre pra esquerda
    hero.runLeft = true
    hero.x = hero.x - 100 *dt
    if(hero.x <= 0) then
      hero.x = 0 
    end
  elseif(love.keyboard.isDown("s") and hero.y == ground) then
    if(completed) then
      hero.image = imgHeroFoxCrouch
    else
      hero.image = imgHeroCrouch
    end
    hero.y = hero.y + 30
  elseif(love.keyboard.isDown("w")) then   -- JetPack Up
    if(completed) then
      hero.image = imgHeroFoxJump
    else
      hero.image = imgHeroJump
    end
    if(hero.y > 200) then
      if(not completed) then
        hero.y = hero.y - 200 *dt
      else
        hero.y = hero.y - 250 *dt
      end
    end
  elseif(love.keyboard.isDown("s") and hero.y < ground) then   -- JetPack Down
    if(not completed) then
      hero.y = hero.y + 200 *dt
    else
      hero.y = hero.y + 250 *dt
    end
    if(hero.y >= ground) then
      hero.y = ground
      if(completed) then
        hero.image = imgHeroFox
      else
        hero.image = imgHero
      end
    end
  elseif(hero.y == ground and not love.keyboard.isDown("q")) then
    if(completed) then
      hero.image = imgHeroFox
    else
      hero.image = imgHero
    end
  elseif( hero.y < ground and not love.keyboard.isDown("w")) then
    hero.y = hero.y + 50 *dt
    if(hero.y >= ground) then
      hero.y = ground
      if(completed) then
        hero.image = imgHeroFox
      else
        hero.image = imgHero
      end
    end
  end
  
end

function resetBlast()
  delayTiro = 0.5
  blastType = imgTiros[1]
  posX = hero.x + 25       
  posY = hero.y + 10 
end

function player.shoot (dt)
  tempoAtirar = tempoAtirar - (1 *dt)
  if(tempoAtirar < 0) then  -- Só podemos atirar quando o tempo de "Cooldown" passar)
    atira = true  -- Essa variável sinaliza que podemos atirar
  end
  if (love.keyboard.isDown("q") and not love.keyboard.isDown("d") and not love.keyboard.isDown("w") and not love.keyboard.isDown("s") and not love.keyboard.isDown("a") and  atira) then  
    if(completed) then
      hero.image = imgHeroFoxShoot
    else
      hero.image = imgHeroShoot 
    end
    
    if((blasType == imgTiros[2] and hero.qtm2 <= 0) or (blasType == imgTiros[3] and hero.qtm3 <= 0) ) then
      blasType = imgTiros[1]
    end
    
    if(blastType == imgTiros[1] or blastType == imgTiros[4]) then
      posX = hero.x + 27        -- Distância tiro comum
      posY = hero.y + 8 
      somBlast:play()   
    elseif(blastType == imgTiros[2]) then
      if(hero.qtm2 <= 0) then
        hero.qtm2 = 0
        resetBlast()
      else
        posX = hero.x + 35
        posY = hero.y + 2
        hero.qtm2 = hero.qtm2 - 1
        somBlast2:play()
      end
    elseif(blastType == imgTiros[3]) then
      if(hero.qtm3 <= 0) then
        hero.qtm3 = 0
        resetBlast()
      else
        hero.qtm3 = hero.qtm3 - 1
        posX = hero.x + 35           
        posY = hero.y
        somBlast3:play()
      end
    end
    
    novoTiro = { x = posX, y = posY, image = blastType }   --Conjunto de informações do tiro
    table.insert(tiros, novoTiro)          -- Add o novo tiro na tabela de tiros
    atira = false                 -- Acabamos de atirar, então agora entra o "Cooldown" de novo
    tempoAtirar = delayTiro        
  end
  
  for i, tiro in ipairs (tiros) do    
    tiro.x = tiro.x + (200 * dt)     -- Velocidade do tiro (Por segundo)
    if(tiro.x > 800) then            -- Se o tiro "sair" da tela, precisamos remover da tabela!
      table.remove(tiros, i)
    end
  end
end

return player