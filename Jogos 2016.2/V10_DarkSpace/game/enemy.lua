enemy = {}

local second = 0

function enemy.walk(dt)
  second = second + dt
  if(second > 0.2) then
    if(mobFrameAtual < 6) then
      mobFrameAtual = mobFrameAtual + 1
    else
      mobFrameAtual = 1
    end
    second = 0
  end
end


function enemy.geraInimigos (dt)
  tempoCriarInimigo = tempoCriarInimigo - (1 * dt)  -- Mesmo esquema do "Cooldown" do tiro
  if (tempoCriarInimigo < 0) then 
    tempoCriarInimigo = delayInimigo            
    local tipo = 1           
    local posY = ground - 10
    
    if(background.image == stage1 or background.image == stage5 or background.image == stage8) then
      tipo = math.random(1,3)
    elseif(background.image == stage2 or background.image == stage6 or background.image == stage9 or background.image == stage7) then
      tipo = math.random(4,6)
    elseif(background.image == stage3 or background.image == stage4) then
      tipo = math.random(8,10)
      if(tipo == 9) then
        tipo = 1
      end
    else
      tipo = math.random(1,10)
    end
    
    if(tipo == 8) then
      posY = ground + 26
    elseif(tipo == 6) then
      posY = ground - 40 
    elseif(tipo == 5) then
      posY = ground + 10 
    elseif(tipo == 2) then
      posY = math.random(200, ground - 50) 
    end
    novoInimigo = { x = 750, y = posY , image = imgInimigos[tipo], hp = 100}  
    table.insert(inimigos, novoInimigo) 
  end
  
  for i, inimigo in ipairs (inimigos) do     -- Esse 'for' percorre a tabela de inimigos 
      if(background.image == stage1) then
        inimigo.x = inimigo.x - 20 *dt     
      elseif(background.image == stage2 or background.image == stage3) then
        delayInimigo = 2
        inimigo.x = inimigo.x - 120 * dt
      elseif(background.image == stage4) then
        inimigo.x = inimigo.x - 130 * dt
      elseif(background.image == stage5) then
        delayInimigo = 1.5
        inimigo.x = inimigo.x - 130 * dt
      elseif(background.image == stage12) then
        inimigo.x = inimigo.x - 150 * dt
      else
        inimigo.x = inimigo.x - 120 * dt
      end
      if(inimigo.x < 0) then   -- Se o inimigo "sair" da tela.
        table.remove(inimigos, i)   
      end
  end
  
end

function enemy.bossMoves(dt)
  if((qtdStage ~= 7 and qtdStage ~= 10) and boss.y >= 400) then
    boss.y = 399
    boss.up = true
  elseif((qtdStage == 7 or qtdStage == 10) and boss.y >= 450) then
    boss.y = 449
    boss.up = true
  elseif(boss.y <= 200) then
    boss.y = 201;
    boss.up = false
  end
  
  if(boss.up) then
    if(boss.image == imgBossRaven) then
      boss.y = boss.y - 150*dt
    else
      boss.y = boss.y - 50*dt
    end
  else
    if(boss.image == imgBossRaven) then
      boss.y = boss.y + 150*dt
    else
      boss.y = boss.y + 50*dt
    end
  end
end
  


function enemy.bossShoot (dt)
  bossTempoAtirar = bossTempoAtirar - (1*dt)
  if(bossTempoAtirar < 0) then
    bossAtira = true
  end
  if(bossAtira) then
    if(background.image == stage1) then -- Ajuste do Tiro do Boss 1
      
      bossNovoTiro = {x = boss.x - 50 , y = boss.y + 50, image = imgBossBlast}
    elseif(background.image == stage3) then -- Ajuste do Tiro do Boss 2
      bossNovoTiro = {x = boss.x - 70 , y = boss.y + 95, image = imgBossBlast}
    elseif(background.image == stage5) then -- Ajuste do Tiro do Boss 3
      bossNovoTiro = {x = boss.x - 70 , y = boss.y, image = imgBossBlast}
    elseif(background.image == stage9) then -- Ajuste do Tiro do Boss 4
      bossNovoTiro = {x = boss.x - 70 , y = boss.y, image = imgBossBlast}
    elseif(background.image == stage21) then -- Ajuste do Tiro do Boss 5
     bossNovoTiro = {x = boss.x + 50 , y = boss.y + 15, image = imgBossBlast}
    elseif(background.image == stage4) then     -- Ajuste do Tiro do Jackal
      bossNovoTiro = {x = boss.x - 50 , y = boss.y + 15, image = imgBossBlast}
      somBlast:play()
    elseif(background.image == stage7) then     -- Ajuste do Tiro do Wolf
      bossNovoTiro = {x = boss.x - 50 , y = boss.y, image = imgBossBlast}
      somBlast2:play()
    elseif(background.image == stage10) then     -- Ajuste do Tiro do Raven
      bossNovoTiro = {x = boss.x - 50 , y = boss.y, image = imgBossBlast}
      somBlast3:play()
    elseif(background.image == stage12) then -- Ajuste do Tiro do Boss Fox
      bossNovoTiro = {x = boss.x - 64 , y = boss.y + 12, image = imgBossBlast}
      somBlast:play()
    elseif(background.image == stage17 or background.image == stage22 or background.image == stage23) then -- Ajuste do Tiro do Boss Hawk
      bossNovoTiro = {x = boss.x + 100 , y = hero.y + 15, image = imgBossBlast}
      if(qtdStage == 17) then
        somBlast2:play()
      else
        somBlast3:play()
      end
    end
    table.insert(bossTiros, bossNovoTiro)
    
    bossAtira = false                
    bossTempoAtirar = bossDelayTiro        
  end
  for i, bossTiro in ipairs (bossTiros) do 
    if(boss.image == imgBossFox or boss.image == imgBoss or boss.image == imgBoss2) then
      bossTiro.x = bossTiro.x - (200 * dt)     
    elseif(boss.image == imgBoss3 or boss.image == imgBoss4 or boss.image == imgBoss5) then
       bossTiro.x = bossTiro.x - (250 * dt) 
    elseif(boss.image == imgBossJackal) then
      bossTiro.x = bossTiro.x - (300 * dt)
    elseif(boss.image == imgBossWolf) then
      bossTiro.x = bossTiro.x - (600 * dt)
    elseif(boss.image == imgBossRaven) then
      bossTiro.x = bossTiro.x - (300 * dt)
    elseif(boss.image == imgBossHawk) then
      bossTiro.x = bossTiro.x - (450 * dt)
    end
    if(bossTiro.x < 0) then            -- Se o tiro "sair" da tela, precisamos remover da tabela!
      table.remove(bossTiros, i)
    end
  end
end



return enemy