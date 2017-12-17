speech = {}

function cleanTiros()
  while(next(tiros) ~= nil) do
    for i, tiro in ipairs (tiros) do
        table.remove(tiros, i)
    end
  end
end

function clean()
  while(next(inimigos) ~= nil) do
    for i, inimigo in ipairs (inimigos) do  
      table.remove(inimigos, i)
    end
  end
end

function freeze ()
  talk = true
  hero.alive = false
  geraInimigos = false
end

function unfreeze()
  talk = false
  hero.alive = true
  if(not bossAlive) then
    geraInimigos = true
  end
end

function ajustaImagemHero ()
  hero.x = 100
  hero.y = ground
  if(not completed) then
    imgHeroTemp = imgHero
  else
    imgHeroTemp = imgHeroFox
  end
end

function speech.scenes()
  -- Prólogo
  
  if(background.image == options and qtdSpeech == 0) then
    imgPrologo = prologo0
  elseif(background.image == options and qtdSpeech == 1) then
    imgPrologo = prologo1
  elseif(background.image == options and qtdSpeech == 2) then
    imgPrologo = prologo2
  end
  
  
  if(background.image == stage1 and qtdSpeech == 0) then
    ajustaImagemHero()
    freeze()
  elseif(background.image == stage1 and qtdSpeech == 1 and hero.kqtd == 0 and talk) then
    unfreeze()
    
    --Falas Stage 4  
  elseif(background.image == stage4 and qtdSpeech == 0 and not talk) then
    ajustaImagemHero()
    bossConcept = jackalConcept
    freeze()
    speechAtual = speech0_St4
  elseif(background.image == stage4 and qtdSpeech == 1 and hero.kqtd == 0 and talk) then
    unfreeze()
  elseif(background.image == stage4 and qtdSpeech == 1 and bossAlive and not talk) then
    cleanTiros()
    freeze()
    ajustaImagemHero()
    speechAtual = speech1_St4
    bossTalk = true
  elseif(background.image == stage4 and qtdSpeech == 2 and talk) then
    speechAtual = speech2_St4
  elseif(background.image == stage4 and qtdSpeech == 3 and talk) then
    speechAtual = speech3_St4
  elseif(background.image == stage4 and qtdSpeech == 4 and talk) then
    speechAtual = speech4_St4
   elseif(background.image == stage4 and qtdSpeech == 5 and talk) then  
    speechAtual = speech5_St4
  elseif(background.image == stage4 and qtdSpeech == 6 and talk) then
    speechAtual = speech6_St4
   elseif(background.image == stage4 and qtdSpeech == 7 and talk) then
    speechAtual = speech7_St4
  elseif(background.image == stage4 and qtdSpeech == 8 and talk) then
    speechAtual = speech8_St4
  elseif(background.image == stage4 and qtdSpeech == 9 and talk) then
    speechAtual = speech9_St4
  elseif(background.image == stage4 and qtdSpeech == 10 and bossAlive and talk) then
    bossTalk = false
    unfreeze()
    
  -- Falas Stage 7
  
  elseif(background.image == stage7 and qtdSpeech == 0 and not talk) then
    ajustaImagemHero()
    bossConcept = wolfConcept
    freeze()
    speechAtual = speech0_St7
  elseif(background.image == stage7 and qtdSpeech == 1 and hero.kqtd == 0 and talk) then
    unfreeze()
  elseif(background.image == stage7 and qtdSpeech == 1 and bossAlive and not talk) then
    cleanTiros()
    freeze()
    ajustaImagemHero()
    speechAtual = speech1_St7
    bossTalk = true
  elseif(background.image == stage7 and qtdSpeech == 2 and talk) then
    speechAtual = speech2_St7
  elseif(background.image == stage7 and qtdSpeech == 3 and talk) then
    speechAtual = speech3_St7
  elseif(background.image == stage7 and qtdSpeech == 4 and talk) then
    speechAtual = speech4_St7
   elseif(background.image == stage7 and qtdSpeech == 5 and talk) then  
    speechAtual = speech5_St7
    if(not bossComment) then
      somBlast2:play()
      bossComment = true
    end
  elseif(background.image == stage7 and qtdSpeech == 6 and talk) then
    speechAtual = speech6_St7
    bossComment = false
   elseif(background.image == stage7 and qtdSpeech == 7 and talk) then
    speechAtual = speech7_St7
  elseif(background.image == stage7 and qtdSpeech == 8 and talk) then
    speechAtual = speech8_St7
  elseif(background.image == stage7 and qtdSpeech == 9 and talk) then
    speechAtual = speech9_St7
  elseif(background.image == stage7 and qtdSpeech == 10 and talk) then
    speechAtual = speech10_St7
    elseif(background.image == stage7 and qtdSpeech == 11 and talk) then
    speechAtual = speech11_St7
  elseif(background.image == stage7 and qtdSpeech == 12 and bossAlive and talk) then
    bossTalk = false
    unfreeze()
    
  -- Falas Stage 10
  
  elseif(background.image == stage10 and qtdSpeech == 0 and not talk) then
    ajustaImagemHero()
    bossConcept = ravenConcept
    freeze()
    speechAtual = speech0_St10
  elseif(background.image == stage10 and qtdSpeech == 1 and hero.kqtd == 0 and talk) then
    unfreeze()
  elseif(background.image == stage10 and qtdSpeech == 1 and bossAlive and not talk) then
    ajustaImagemHero()
    cleanTiros()
    freeze()
    speechAtual = speech1_St10
    bossTalk = true
  elseif(background.image == stage10 and qtdSpeech == 2 and talk) then
    speechAtual = speech2_St10
  elseif(background.image == stage10 and qtdSpeech == 3 and talk) then
    speechAtual = speech3_St10
  elseif(background.image == stage10 and qtdSpeech == 4 and talk) then
    speechAtual = speech4_St10
   elseif(background.image == stage10 and qtdSpeech == 5 and talk) then  
    speechAtual = speech5_St10
  elseif(background.image == stage10 and qtdSpeech == 6 and talk) then
    if(qtdtry > 1) then
      speechAtual = speech6_1_St10
    else
      speechAtual = speech6_2_St10
    end
   elseif(background.image == stage10 and qtdSpeech == 7 and talk) then
    speechAtual = speech7_St10
  elseif(background.image == stage10 and qtdSpeech == 8 and talk) then
    speechAtual = speech8_St10
  elseif(background.image == stage10 and qtdSpeech == 9 and talk) then
    speechAtual = speech9_St10
  elseif(background.image == stage10 and qtdSpeech == 10 and bossAlive and talk) then
    bossTalk = false
    unfreeze()
    
  -- Falas Stage12
  
  elseif(background.image == stage12 and qtdSpeech == 0 and not talk) then
    bossConcept = foxConcept
    freeze()
    speechAtual = speech0_St12
  elseif(background.image == stage12 and qtdSpeech == 1 and hero.kqtd == 0 and talk) then
    unfreeze()
  elseif(background.image == stage12 and qtdSpeech == 1 and bossAlive and not talk) then
    cleanTiros()
    freeze()
    speechAtual = speech1_St12
    bossTalk = true
  elseif(background.image == stage12 and qtdSpeech == 2 and talk) then
    speechAtual = speech2_St12
  elseif(background.image == stage12 and qtdSpeech == 3 and talk) then
    speechAtual = speech3_St12
  elseif(background.image == stage12 and qtdSpeech == 4 and talk) then
    speechAtual = speech4_St12
   elseif(background.image == stage12 and qtdSpeech == 5 and talk) then  
    speechAtual = speech5_St12
  elseif(background.image == stage12 and qtdSpeech == 6 and talk) then
    speechAtual = speech6_St12
   elseif(background.image == stage12 and qtdSpeech == 7 and talk) then
    speechAtual = speech7_St12
  elseif(background.image == stage12 and qtdSpeech == 8 and talk) then
    speechAtual = speech8_St12
  elseif(background.image == stage12 and qtdSpeech == 9 and talk) then
    speechAtual = speech9_St12
  elseif(background.image == stage12 and qtdSpeech == 10 and talk) then
    speechAtual = speech10_St12
  elseif(background.image == stage12 and qtdSpeech == 11 and talk) then
    speechAtual = speech11_St12
  elseif(background.image == stage12 and qtdSpeech == 12 and talk) then
    speechAtual = speech12_St12  
  elseif(background.image == stage12 and qtdSpeech == 13 and bossAlive and talk) then
    boss.image = imgBossFox
    boss.y = ground
    bossTalk = false
    unfreeze()

  elseif(background.image == stage12 and qtdSpeech == 13 and not talk and not bossAlive) then
    freeze()
    bossTalk = true
    speechAtual = speech13_St12
  elseif(background.image == stage12 and qtdSpeech == 14 and talk) then
    speechAtual = speech14_St12
  elseif(background.image == stage12 and qtdSpeech == 15 and talk) then
    speechAtual = speech15_St12
  elseif(background.image == stage12 and qtdSpeech == 16 and talk) then
    speechAtual = speech16_St12
  elseif(background.image == stage12 and qtdSpeech == 17 and talk) then
    speechAtual = speech17_St12
  elseif(background.image == stage12 and qtdSpeech == 18 and talk) then
    speechAtual = speech18_St12
  elseif(background.image == stage12 and qtdSpeech == 19 and talk) then
    speechAtual = speech19_St12
  elseif(background.image == stage12 and qtdSpeech == 20 and talk) then
    speechAtual = speech20_St12
  elseif(background.image == stage12 and qtdSpeech == 21 and talk) then
    speechAtual = speech21_St12
  elseif(background.image == stage12 and qtdSpeech == 22 and talk) then
    speechAtual = speech22_St12
  elseif(background.image == stage12 and qtdSpeech == 23 and talk) then
    speechAtual = speech23_St12
  elseif(background.image == stage12 and qtdSpeech == 24 and talk) then
    bossTalk = false
    hero.x = 400
    px = 600
    unfreeze()
    geraInimigos = false
    
  -- Falas Stage 13
  
  elseif(background.image == stage13 and qtdSpeech == 0 and not talk) then
    imgHeroTemp = imgHero
    bossConcept = hawkConcept
    freeze()
    speechAtual = speech0_St13
  elseif(background.image == stage13 and qtdSpeech == 1 and hero.kqtd == 0 and talk) then
    unfreeze()
  elseif(background.image == stage13 and qtdSpeech == 1 and hero.kqtd >= 5 and not talk) then
    cleanTiros()
    clean()
    freeze()
    speechAtual = speech1_St13
    bossTalk = true
  elseif(background.image == stage13 and qtdSpeech == 2 and talk) then
    speechAtual = speech2_St13
  elseif(background.image == stage13 and qtdSpeech == 3 and talk) then
    speechAtual = speech3_St13
  elseif(background.image == stage13 and qtdSpeech == 4 and talk) then
    speechAtual = speech4_St13
   elseif(background.image == stage13 and qtdSpeech == 5 and talk) then  
    speechAtual = speech5_St13
  elseif(background.image == stage13 and qtdSpeech == 6 and talk) then
    speechAtual = speech6_St13
   elseif(background.image == stage13 and qtdSpeech == 7 and talk) then
    speechAtual = speech7_St13
  elseif(background.image == stage13 and qtdSpeech == 8 and talk) then
    speechAtual = speech8_St13
  elseif(background.image == stage13 and qtdSpeech == 9 and talk) then
    speechAtual = speech9_St13
  elseif(background.image == stage13 and qtdSpeech == 10 and talk) then
    speechAtual = speech10_St13
  elseif(background.image == stage13 and qtdSpeech == 11 and talk) then
    bossTalk = false
    speechAtual = speech11_St13
  elseif(background.image == stage13 and qtdSpeech == 12 and talk) then
    speechAtual = speech12_St13
  elseif(background.image == stage13 and qtdSpeech == 13 and talk) then
    unfreeze()
    geraInimigos = false
    
  -- Falas Stage 14 até 16  
  elseif(background.image == stage14 and qtdSpeech == 0 and not talk) then
    hero.hp = 100
    imgHeroTemp = imgHeroFox
    heroConcept = heroFoxConcept
    freeze()
    speechAtual = speech0_St14
  elseif(background.image == stage14 and qtdSpeech == 1 and hero.kqtd == 0 and talk) then
    unfreeze()
    
  elseif(background.image == stage15 and qtdSpeech == 0 and not talk) then
    freeze()
    speechAtual = speech0_St15
  elseif(background.image == stage15 and qtdSpeech == 1 and hero.kqtd == 0 and talk) then
    unfreeze()
    
  elseif(background.image == stage16 and qtdSpeech == 0 and not talk) then
    freeze()
    speechAtual = speech0_St16
  elseif(background.image == stage16 and qtdSpeech == 1 and hero.kqtd == 0 and talk) then
    unfreeze()  
    
  -- Falas Stage 17
  
  elseif(background.image == stage17 and qtdSpeech == 0 and not talk) then
    hero.hp = 100
    imgHeroTemp = imgHero
    bossConcept = hawkConcept
    heroConcept = eagleConcept
    freeze()
    speechAtual = speech0_St17
  elseif(background.image == stage17 and qtdSpeech == 1 and hero.kqtd == 0 and talk) then
    unfreeze()
  elseif(background.image == stage17 and qtdSpeech == 1 and bossAlive and not talk) then
    cleanTiros()
    freeze()
    speechAtual = speech1_St17
    bossTalk = true
  elseif(background.image == stage17 and qtdSpeech == 2 and talk) then
    speechAtual = speech2_St17
  elseif(background.image == stage17 and qtdSpeech == 3 and talk) then
    speechAtual = speech3_St17
  elseif(background.image == stage17 and qtdSpeech == 4 and talk) then
    speechAtual = speech4_St17
   elseif(background.image == stage17 and qtdSpeech == 5 and talk) then  
    speechAtual = speech5_St17
  elseif(background.image == stage17 and qtdSpeech == 6 and talk) then
    speechAtual = speech6_St17
   elseif(background.image == stage17 and qtdSpeech == 7 and talk) then
    speechAtual = speech7_St17
  elseif(background.image == stage17 and qtdSpeech == 8 and talk) then
    speechAtual = speech8_St17
  elseif(background.image == stage17 and qtdSpeech == 9 and talk) then
    speechAtual = speech9_St17
  elseif(background.image == stage17 and qtdSpeech == 10 and bossAlive and talk) then
    hero.x = 100
    hero.y = ground
    bossTalk = false
    unfreeze()
    
  elseif(background.image == stage17 and qtdSpeech == 10 and not talk and not bossAlive) then
    cleanTiros()
    freeze()
    bossTalk = true
    speechAtual = speech10_St17
  elseif(background.image == stage17 and qtdSpeech == 11 and talk) then
    speechAtual = speech11_St17
  elseif(background.image == stage17 and qtdSpeech == 12 and talk) then
    bossTalk = false
    unfreeze()
    px = hero.x
    
   -- Falas Stage 18 até 20 
  elseif(background.image == stage18 and qtdSpeech == 0 and not talk) then
    hero.hp = 100
    imgHeroTemp = imgHeroFox
    heroConcept = heroFoxConcept
    freeze()
    speechAtual = speech0_St18
  elseif(background.image == stage18 and qtdSpeech == 1 and talk) then
    unfreeze()
    
  elseif(background.image == stage20 and qtdSpeech == 0 and not talk) then
    freeze()
    speechAtual = speech0_St20
  elseif(background.image == stage20 and qtdSpeech == 1 and talk) then
    speechAtual = speech1_St20
  elseif(background.image == stage20 and qtdSpeech == 2 and talk) then
    speechAtual = speech2_St20
  elseif(background.image == stage20 and qtdSpeech == 3 and talk) then
    unfreeze()
    
  -- Falas Stage 22
  elseif(background.image == stage22 and qtdSpeech == 0 and not talk) then
    heroConcept = heroFoxConcept
    bossConcept = hawkConcept
    freeze()
    speechAtual = speech0_St22
  elseif(background.image == stage22 and qtdSpeech == 1 and talk) then
    heroConcept = eagleConcept
    speechAtual = speech1_St22
  elseif(background.image == stage22 and qtdSpeech == 2 and talk) then
    heroConcept = heroFoxConcept
    bossTalk = true
    speechAtual = speech2_St22
  elseif(background.image == stage22 and qtdSpeech == 3 and talk) then
    speechAtual = speech3_St22
  elseif(background.image == stage22 and qtdSpeech == 4 and talk) then
    speechAtual = speech4_St22
   elseif(background.image == stage22 and qtdSpeech == 5 and talk) then  
    speechAtual = speech5_St22
  elseif(background.image == stage22 and qtdSpeech == 6 and talk) then
    speechAtual = speech6_St22
  elseif(background.image == stage22 and qtdSpeech == 7 and talk) then
    speechAtual = speech7_St22
  elseif(background.image == stage22 and qtdSpeech == 8 and talk) then
    speechAtual = speech8_St22
  elseif(background.image == stage22 and qtdSpeech == 9 and talk) then
    speechAtual = speech9_St22
  elseif(background.image == stage22 and qtdSpeech == 10 and talk) then
    speechAtual = speech10_St22  
  elseif(background.image == stage22 and qtdSpeech == 11 and talk) then
    heroConcept = eagleConcept
    speechAtual = speech11_St22
  elseif(background.image == stage22 and qtdSpeech == 12 and talk) then
    heroConcept = heroFoxConcept
    speechAtual = speech12_St22
  elseif(background.image == stage22 and qtdSpeech == 13 and talk) then
    speechAtual = speech13_St22
  elseif(background.image == stage22 and qtdSpeech == 14 and talk) then
    speechAtual = speech14_St22
  elseif(background.image == stage22 and qtdSpeech == 15 and bossAlive and talk) then
    boss.y = ground
    bossTalk = false
    unfreeze()
  elseif(background.image == stage22 and qtdSpeech == 15 and hero.kqtd == 1 and not talk) then
    cleanTiros()
    freeze()
    bossTalk = true
    speechAtual = speech15_St22
  elseif(background.image == stage22 and qtdSpeech == 16 and talk) then
    speechAtual = speech16_St22
  elseif(background.image == stage22 and qtdSpeech == 17 and talk) then
    heroConcept = eagleConcept
    speechAtual = speech17_St22
  elseif(background.image == stage22 and qtdSpeech == 18 and talk) then
    heroConcept = heroFoxConcept
    speechAtual = speech18_St22
  elseif(background.image == stage22 and qtdSpeech == 19 and talk) then
    speechAtual = speech19_St22
  elseif(background.image == stage22 and qtdSpeech == 20 and talk) then
    speechAtual = speech20_St22
  elseif(background.image == stage22 and qtdSpeech == 21 and talk) then
    heroConcept = eagleConcept
    speechAtual = speech21_St22
  elseif(background.image == stage22 and qtdSpeech == 22 and talk) then
    heroConcept = heroFoxConcept
    speechAtual = speech22_St22
  elseif(background.image == stage22 and qtdSpeech == 23 and talk) then
    speechAtual = speech23_St22
  elseif(background.image == stage22 and qtdSpeech == 24 and talk) then
    heroConcept = eagleConcept
    speechAtual = speech24_St22
  elseif(background.image == stage22 and qtdSpeech == 25 and talk) then
    heroConcept = heroFoxConcept
    speechAtual = speech25_St22
    hero.x = 100
    hero.y = ground
  elseif(background.image == stage22 and qtdSpeech == 26 and bossAlive and talk) then
    boss.y = ground
    bossTalk = false
    unfreeze()
    
  elseif(background.image == stage22 and qtdSpeech == 26 and hero.kqtd == 2 and not talk) then
    freeze()
    bossTalk = true
    speechAtual = speech26_St22
  elseif(background.image == stage22 and qtdSpeech == 27 and talk) then
    speechAtual = speech27_St22
  elseif(background.image == stage22 and qtdSpeech == 28 and talk) then
    speechAtual = speech28_St22
  elseif(background.image == stage22 and qtdSpeech == 29 and talk) then
    speechAtual = speech29_St22
  elseif(background.image == stage22 and qtdSpeech == 30 and talk) then
    heroConcept = eagleConcept
    speechAtual = speech30_St22
   elseif(background.image == stage22 and qtdSpeech == 31 and talk) then
    speechAtual = speech31_St22
  elseif(background.image == stage22 and qtdSpeech == 32 and talk) then
    completed = false
    px = hero.x
    
  -- Falas Stage 23
elseif(background.image == stage23 and qtdSpeech == 0) then
    imgHeroTemp = imgHero
    talk = true
    hero.hp = 100
    blastType = imgTiros[4]
    boss.y = 450
    speechAtual = speech0_St23
  elseif(background.image == stage23 and qtdSpeech == 1 and talk) then
    speechAtual = speech1_St23
  elseif(background.image == stage23 and qtdSpeech == 2 and talk) then
    speechAtual = speech2_St23
  elseif(background.image == stage23 and qtdSpeech == 3 and talk) then
    speechAtual = speech3_St23
  elseif(background.image == stage23 and qtdSpeech == 4 and talk) then
    speechAtual = speech4_St23
   elseif(background.image == stage23 and qtdSpeech == 5 and talk) then  
    speechAtual = speech5_St23
  elseif(background.image == stage23 and qtdSpeech == 6 and talk) then
    speechAtual = speech6_St23
  elseif(background.image == stage23 and qtdSpeech == 7 and bossAlive and talk) then
    boss.y = ground
    bossTalk = false
    unfreeze()
  elseif(background.image == stage23 and qtdSpeech == 7 and not bossAlive and not talk) then
    cleanTiros()
    freeze()
    bossTalk = true
    speechAtual = speech7_St23
  elseif(background.image == stage23 and qtdSpeech == 8 and talk) then
    speechAtual = speech8_St23
  elseif(background.image == stage23 and qtdSpeech == 9 and talk) then
    speechAtual = speech9_St23
  elseif(background.image == stage23 and qtdSpeech == 10 and talk) then
    speechAtual = speech10_St23
  elseif(background.image == stage23 and qtdSpeech == 11 and talk) then
    speechAtual = speech11_St23
  elseif(background.image == stage23 and qtdSpeech == 12 and talk) then
    bossTalk = false
    speechAtual = speech12_St23
  elseif(background.image == stage23 and qtdSpeech == 13 and talk) then
    unfreeze()
    geraInimigos = false
    hero.y = ground
    somBossTheme5:stop()
    somStage4:play()
    px = 600
    
  elseif(background.image == stage24 and qtdSpeech == 0 and not talk) then
    freeze()
    speechAtual = speech0_St24
  elseif(background.image == stage24 and qtdSpeech == 1 and talk) then
    speechAtual = speech1_St24
  elseif(background.image == stage24 and qtdSpeech == 2 and talk) then
    speechAtual = speech2_St24 
  elseif(background.image == stage24 and qtdSpeech == 3 and talk) then
     if(hero.score > tonumber(highscore)) then
       highscore = hero.score
       love.filesystem.write("scores.lua", "highscore\n=\n" .. hero.score)
    end
    talk = false
    gameState = "credits"
    background.image = credits
    somStage4:stop() 
    somCredits:play()
  end
end


return speech