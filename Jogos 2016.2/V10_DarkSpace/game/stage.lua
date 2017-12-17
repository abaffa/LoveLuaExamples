stage = {}

local time = 0
function stage.bossWarning (dt)
  warning = true
  time = time + dt
  
  if(time > 3) then
    bossAlive = true
    warning = false
    table.insert(inimigos, boss)
    time = 0
  end
end
    
  
function stage.reset()   -- Organiza a nova fase (Posição do portal, player, etc)
  bossComment = false
  delayTiro = 0.5 
  if(not completed) then
    blastType = imgTiros[1]
  else
     blastType = imgTiros[4]
  end
  qtdSpeech = 0
  px = 1400
  hero.x = 100
  hero.y = ground
  hero.kqtd = 0        -- Quantidade de inimigos derrotados na fase atual (Começa em zero de novo)
  background.x = 0
  qtdStage = qtdStage + 1   -- Avança pra próxima fase
  stage.clean()
  geraInimigos = true   
  if(qtdStage == 2) then
    hero.qtm2 = hero.qtm2 + 20
  elseif(qtdStage == 4) then
    hero.qtm3 = hero.qtm3 + 20
  elseif(qtdStage > 4) then
    hero.qtm2 = hero.qtm2 + 5
    hero.qtm3 = hero.qtm3 + 5
  end
  
end

function stage.clean()
  while(next(inimigos) ~= nil) do
    for i, inimigo in ipairs (inimigos) do    -- Percorre a tabela de inimigos e deleta todos.
        table.remove(inimigos, i)
    end
  end
  for i, tiro in ipairs (tiros) do
      table.remove(tiros, i)
  end
  if(bossAlive) then
    for i, bossTiro in ipairs (bossTiros) do    -- Percorre a tabela de Tiros do Boss e deleta todos.
      table.remove(bossTiros, i)
    end
  end
end

function stage.cleanBoss()
  while(next(inimigos) ~= nil) do
    for i, inimigo in ipairs (inimigos) do  
      table.remove(inimigos, i)
    end
  end
  while(next(bossTiros) ~= nil) do
    for i, bossTiro in ipairs (bossTiros) do    
      table.remove(bossTiros, i)
    end
  end
  geraInimigos = false
  if(qtdStage ~= 0 and qtdStage ~= 3 and qtdStage ~= 5 and qtdStage ~= 9 and qtdStage ~= 21) then
     bossAlive = true
  end
end


function stage.change(dt) 
  if(hero.kqtd == 4 and qtdStage == 0) then
    if(not bossAlive) then
      stage.cleanBoss()
      stage.bossWarning(dt)
    end
  elseif(hero.x >= px and qtdStage == 1) then 
    stage.reset()
    background.image = stage2 
    background.imageGround = stage2Ground
    background.groundY = ground + 22
  elseif(hero.x >= px and qtdStage == 2) then
    stage.reset()
    background.image = stage3
    background.imageGround = stage3Ground
    background.groundY = ground + 22
  elseif(hero.x >= px and qtdStage == 3) then
    stage.reset()
    background.image = stage4
    somStage:stop()
    somBossTheme1:play()
  elseif(hero.x >= px and qtdStage == 4) then
    stage.reset()
    background.image = stage5
    somBossTheme1:stop()          
    somStage2:play()
  elseif(hero.x >= px and qtdStage == 5) then
    stage.reset()
    background.image = stage6
    background.imageGround = stage6Ground
    background.groundY = ground + 35
  elseif(hero.x >= px and qtdStage == 6) then
    stage.reset()
    background.image = stage7
    somStage2:stop()
    somBossTheme2:play()
  elseif(hero.x >= px and qtdStage == 7) then
    stage.reset()
    background.image = stage8
    somStage:stop()
    somBossTheme2:stop()
    somJungleTheme:play()
  elseif(hero.x >= px and qtdStage == 8) then
    stage.reset()
    background.image = stage9
  elseif(hero.x >= px and qtdStage == 9) then
    stage.reset()
    somJungleTheme:stop()
    somBossTheme3:play()
    background.image = stage10
  elseif(hero.x >= px and qtdStage == 10) then
    stage.reset()
    somBossTheme3:stop()
    somStage3:play()
    background.image = stage11
  elseif(hero.x >= px and qtdStage == 11) then
    background.image = stage12
    ground = 500
    stage.reset()
    somStage3:stop()
    somFoxTheme:play()
  elseif(hero.x >= px and qtdStage == 12) then
    ground = 480
    stage.reset()
    background.image = stage13
    somFoxTheme:stop()
    somStage4:play()
  elseif(hero.x >= px and qtdStage == 13) then
    completed = true
    delayInimigo = 1
    blastType = imgTiros[4]
    ground = 450
    stage.reset()
    background.image = stage14
    somStage4:stop()
    somStage5:play()
   elseif(hero.x >= px and qtdStage == 14) then
    stage.reset()
    background.image = stage15
    background.imageGround = stage15Ground
    background.groundY = ground + 35
  elseif(hero.x >= px and qtdStage == 15) then
    stage.reset()
    background.image = stage16
  elseif(hero.x >= px and qtdStage == 16) then
    ground = 460
    stage.reset()
    completed = false
    delayInimigo = 1.5
    blastType = imgTiros[1]
    background.image = stage17
    somStage5:stop()
    somBossTheme4:play() 
  elseif(hero.x >= px and qtdStage == 17) then
    ground = 450
    stage.reset()
    completed = true
    delayInimigo = 0.7
    blastType = imgTiros[4]
    background.image = stage18
    somBossTheme4:stop()
    somStage2:play()
   elseif(hero.x >= px and qtdStage == 18) then
    stage.reset()
    px = 2500
    background.image = stage19
    background.imageGround = stage19Ground
    background.groundY = ground + 42
  elseif(hero.x >= px and qtdStage == 19) then
    stage.reset()
    somStage2:stop()
    somTythonTheme:play()
    background.image = stage20
  elseif(hero.x >= px and qtdStage == 20) then
    ground = 500
    stage.reset()
    background.image = stage21
  elseif(hero.x >= px and qtdStage == 21) then
    ground = 480
    boss.y = 450
    stage.reset()
    background.image = stage22
    somTythonTheme:stop()
    somFoxTheme:play()
    
  elseif(hero.x >= px and qtdStage == 22) then
    stage.reset()
    background.image = stage23
    somFoxTheme:stop()
    somBossTheme5:play()
    
  elseif(hero.x >= px and qtdStage == 23) then
    stage.reset()
    geraInimigos = false
    background.image = stage24
    somBossTheme5:stop()
    somStage4:play() 
  end
  
  if(hero.kqtd == 5 and (background.image == stage11 or background.image == stage8)) then
    px = 600
  elseif(hero.kqtd == 20 and (background.image == stage14 or background.image == stage16 or background.image == stage18 or background.image == stage20)) then
    px = 600
  elseif(hero.kqtd > 10 and background.image == stage21 and not bossAlive) then
    px = 600
  elseif(hero.kqtd > 4 and (background.image == stage13 or background.image == stage1 or background.image == stage3 or background.image == stage4 or background.image == stage5 or background.image == stage7 or background.image == stage10 or background.image == stage9)  and not bossAlive) then
    px = 600
    
  elseif(hero.kqtd < 4 and (background.image == stage3 or background.image == stage9)) then
    px = hero.x + 3000
    --Bosses
  elseif(hero.kqtd == 4 and background.image == stage3 and not bossAlive) then
    stage.cleanBoss()
    boss.image = imgBoss2
    bossDelayTiro = 1.5
    boss.hp = 200
    stage.bossWarning(dt)
  elseif(hero.kqtd == 4 and background.image == stage5 and not bossAlive) then
    stage.cleanBoss()
    boss.image = imgBoss3
    boss.y = ground - 30
    imgBossBlast = imgRavenBlast
    boss.hp = 800
    stage.bossWarning(dt)
  elseif(hero.kqtd == 4 and background.image == stage4 and not bossAlive) then
    stage.cleanBoss()
    boss.image = imgBossJackal
    imgBossBlast = imgFoxBlast
    bossDelayTiro = 1.5
    boss.hp = 500
    table.insert(inimigos, boss)
    
  elseif(hero.kqtd == 4 and background.image == stage7 and not bossAlive) then
    stage.cleanBoss()
    boss.image = imgBossWolf
    imgBossBlast = imgWolfBlast
    bossDelayTiro = 2.0
    boss.y = 200
    boss.hp = 500
    table.insert(inimigos, boss)
    
  elseif(hero.kqtd == 4 and background.image == stage9 and not bossAlive) then
    stage.cleanBoss()
    boss.image = imgBoss4
    boss.y = ground
    bossDelayTiro = 1.5
    imgBossBlast = boss4Blast
    boss.hp = 800
    stage.bossWarning(dt)
    
  elseif(hero.kqtd == 4 and background.image == stage10 and not bossAlive) then
    stage.cleanBoss()
    boss.image = imgBossRaven
    imgBossBlast = imgRavenBlast
    bossDelayTiro = 1
    boss.y = 200
    boss.hp = 600
    table.insert(inimigos, boss)
  elseif(hero.kqtd == 4 and background.image == stage12 and not bossAlive) then
    stage.cleanBoss()
    bossDelayTiro = 1
    boss.image = imgBossFoxStand
    imgBossBlast = imgFoxBlast
    boss.hp = 2000
    table.insert(inimigos, boss)
    
  elseif(hero.kqtd == 4 and background.image == stage17 and not bossAlive) then
    stage.cleanBoss()
    boss.image = imgBossHawk
    imgBossBlast = imgWolfBlast
    boss.hp = 500
    boss.y = 450
    table.insert(inimigos, boss)
    
  elseif(hero.kqtd == 10 and background.image == stage21 and not bossAlive) then 
    stage.cleanBoss()
    boss.image = imgBoss5
    imgBossBlast = imgDeathBlast
    boss.hp = 800
    stage.bossWarning(dt)
    
  elseif(hero.kqtd == 0 and background.image == stage22 and not bossAlive) then
    stage.cleanBoss()
    boss.image = imgBossHawk
    imgBossBlast = imgRavenBlast
    bossDelayTiro = 0.5
    boss.hp = 500
    table.insert(inimigos, boss)
  
  elseif(hero.kqtd == 1 and qtdSpeech == 16 and background.image == stage22 and not bossAlive) then
    stage.cleanBoss()
    boss.image = imgBossHawk
    imgBossBlast = imgRavenBlast
    bossDelayTiro = 0.8
    boss.y = 450
    boss.hp = 10000
    table.insert(inimigos, boss)
    
  elseif(hero.kqtd == 0 and background.image == stage23 and not bossAlive) then
    stage.cleanBoss()
    bossDelayTiro = 0.5
    boss.hp = 800
    table.insert(inimigos, boss)
  end
    
  if(hero.hp <= 0) then      -- Se o player morreu
    hero.hp = 0      
    stage.clean()
    bossAlive = false
    geraInimigos = false
    somStage:stop()   -- Para a música da fase
    somStage2:stop()
    somStage3:stop()
    somStage4:stop()
    somStage5:stop()
    somTythonTheme:stop()
    somJungleTheme:stop()
    somBossTheme1:stop()
    somBossTheme2:stop()
    somBossTheme3:stop()
    somBossTheme4:stop()
    somBossTheme5:stop()
    somFoxTheme:stop()
    somGameOver:play()  -- Toca a música da tela de Game Over
    hero.alive = false    
    warning = false
    background.groundY = background.groundY + 400
    if(hero.score > tonumber(highscore)) then
      highscore = hero.score
      love.filesystem.write("scores.lua", "highscore\n=\n" .. hero.score)
    end
    background.image = gameOver   
    background.x = 0      -- Ajusta a tela pra ser exibida na posição original
  elseif(hero.hp <= 50 and qtdStage == 10 and bossAlive) then
    if(not bossComment and not talk and qtdSpeech >= 10) then
      somRavenComment:play()
      bossComment = true
    end
  elseif(hero.hp <= 50 and qtdStage == 12 and bossAlive) then
    if(not bossComment and not talk and qtdSpeech >= 13) then
      somFoxComment:play()
      bossComment = true
    end
  end
end

return stage