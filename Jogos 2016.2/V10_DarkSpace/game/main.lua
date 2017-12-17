local stage = require ("stage")
local player = require ("player")
local enemy = require("enemy")
local speech = require("speech")

largura = love.graphics.getWidth()    -- getWidth() retorna o tamanho da Largura (No caso, 800)
                                        
altura = love.graphics.getHeight()   -- getHeight() retorna o tamanho da altura (No caso, 600)

--A função love.load () é executada apenas uma vez, assim que o jogo abre. Como se fosse um "Loading" inicial.

function love.load ()
  
  --love.window.setFullscreen(true, "exclusive")
  completed = false  -- Indica se o jogador zerou o jogo
  warning = false   -- Controla a mensagem de aviso de chefe.
  qtdtry = 1       -- Quantidade tentativas
  qtdStage = 0     -- Controle de fases
  gameState = "menu"    -- Variáveis de controle de estado
  paused = false
  geraInimigos = false
  bossComment = false
  love.mouse.setVisible (false)    -- Deixa o ponteiro do mouse invisível
  font = love.graphics.newFont("Font/ariblk.ttf", 15)
  love.graphics.setFont(font)
  somMenu = love.audio.newSource("Som/MenuTheme.mp3")  -- Variáveis de som
  somCredits = love.audio.newSource("Som/credits.mp3")   
  somStage = love.audio.newSource("Som/StageTheme5.mp3")
  somStage2 = love.audio.newSource("Som/StageTheme2.mp3")
  somStage3 = love.audio.newSource("Som/StageTheme3.mp3")
  somStage4 = love.audio.newSource("Som/StageTheme4.mp3")
  somStage5 = love.audio.newSource("Som/StageTheme5.mp3")
  somTythonTheme = love.audio.newSource("Som/TythonTheme.mp3")
  somJungleTheme = love.audio.newSource("Som/JungleTheme.mp3")
  somStage6 = love.audio.newSource("Som/StageTheme6.mp3")
  somGameOver = love.audio.newSource("Som/GameOverTheme.mp3")
  somBossTheme1 = love.audio.newSource("Som/BossTheme1.mp3")
  somBossTheme2 = love.audio.newSource("Som/BossTheme2.mp3")
  somBossTheme3 = love.audio.newSource("Som/BossTheme3.mp3")
  somBossTheme4 = love.audio.newSource("Som/BossTheme4.mp3")
  somBossTheme5 = love.audio.newSource("Som/BossTheme5.mp3")
  somFoxTheme = love.audio.newSource("Som/FoxTheme.mp3")
  somBlast = love.audio.newSource("Som/LaserBlast.mp3", "static")
  somBlast2 = love.audio.newSource("Som/LaserBlast2.mp3", "static")
  somBlast3 = love.audio.newSource("Som/LaserBlast3.mp3", "static")
  somMob = love.audio.newSource("Som/mobSound.mp3", "static")
  somMob2 = love.audio.newSource("Som/mobSound2.mp3", "static")
  somMobFat = love.audio.newSource("Som/mobFatSound.mp3", "static")
  somPlayerHit = love.audio.newSource("Som/playerHit.mp3", "static")
  somFoxHurt = love.audio.newSource("Som/FoxHurt.mp3", "static")
  somRavenHurt = love.audio.newSource("Som/RavenHurt.mp3", "static")
  somFoxComment = love.audio.newSource("Som/FoxComment.mp3")
  somRavenComment = love.audio.newSource("Som/RavenComment.mp3")
  somFoxComment:setVolume(1)      -- Ajuste de Volume e repetição
  somRavenComment:setVolume(1)
  somMenu:setVolume(0.6)
  somMenu:setLooping(true)
  somCredits:setVolume(1)
  somPlayerHit:setVolume(0.3)     -- O Volume varia de 0 até 1 (Máximo)
  somFoxHurt:setVolume(0.3)
  somRavenHurt:setVolume(1)
  somStage:setVolume(0.3)
  somStage:setLooping(true)
  somStage2:setVolume(0.4)
  somStage2:setLooping(true)
  somStage3:setVolume(0.4)
  somStage3:setLooping(true)
  somStage4:setVolume(0.7)
  somStage4:setLooping(true)
  somStage5:setVolume(0.4)
  somStage5:setLooping(true)
  somStage6:setVolume(1)
  somStage6:setLooping(true)
  somGameOver:setVolume(0.3)
  somGameOver:setLooping(true)
  somBlast:setVolume(0.2)
  somBlast2:setVolume(0.2)
  somBlast3:setVolume(0.2)
  somMob:setVolume(0.1)
  somMob2:setVolume(0.1)
  somMobFat:setVolume(0.1)
  somBossTheme1:setVolume(0.6)
  somBossTheme1:setLooping(true)
  somBossTheme2:setVolume(0.6)
  somBossTheme2:setLooping(true)
  somBossTheme3:setVolume(1)
  somBossTheme3:setLooping(true)
  somBossTheme4:setVolume(0.8)
  somBossTheme4:setLooping(true)
  somBossTheme5:setVolume(0.2)
  somBossTheme5:setLooping(true)
  somFoxTheme:setVolume(1)
  somFoxTheme:setLooping(true)
  somTythonTheme:setVolume(0.5)
  somTythonTheme:setLooping(true)
  somJungleTheme:setVolume(0.5)
  somJungleTheme:setLooping(true)
  somMenu:play()  
  
  menu = love.graphics.newImage ("Imagens/DarkSpace.png") 
  imgPrologo = nil
  options = love.graphics.newImage ("Imagens/options.png") 
  credits = love.graphics.newImage ("Imagens/speech/St24/credits.png") 
  teclado = love.graphics.newImage ("Imagens/teclado.png")
  stage1 = love.graphics.newImage ("Imagens/stage1.jpg")  
  stage2 = love.graphics.newImage ("Imagens/stage2.jpg") 
  stage2Ground = love.graphics.newImage ("Imagens/stage2Ground.jpg")
  stage3 = love.graphics.newImage ("Imagens/stage3.png")
  stage4 = love.graphics.newImage ("Imagens/stage4.jpg")
  stage5 = love.graphics.newImage ("Imagens/stage5.jpg")
  stage6 = love.graphics.newImage ("Imagens/stage6.jpg")
  stage6Ground = love.graphics.newImage ("Imagens/stage6Ground.jpg")
  stage7 = love.graphics.newImage ("Imagens/stage7.jpg")
  stage8 = love.graphics.newImage ("Imagens/stage8.jpg")
  stage9 = love.graphics.newImage ("Imagens/stage9.jpg")
  stage10 = love.graphics.newImage ("Imagens/stage10.jpg")
  stage11 = love.graphics.newImage ("Imagens/stage11.jpg")
  stage12 = love.graphics.newImage ("Imagens/stage12.png")
  stage13 = love.graphics.newImage ("Imagens/stage13.png")
  stage14 = love.graphics.newImage ("Imagens/stage14.jpg")
  stage15 = love.graphics.newImage ("Imagens/stage15.jpg")
  stage15Ground = love.graphics.newImage ("Imagens/stage15Ground.jpg")
  stage16 = love.graphics.newImage ("Imagens/stage16.jpg")
  stage17 = love.graphics.newImage ("Imagens/stage17.png")
  stage18 = love.graphics.newImage ("Imagens/stage18.jpg")
  stage19 = love.graphics.newImage ("Imagens/stage19.png")
  stage19Ground = love.graphics.newImage ("Imagens/stage19Ground.png")
  stage20 = love.graphics.newImage ("Imagens/stage20.jpg")
  stage21 = love.graphics.newImage ("Imagens/stage21.jpg")
  stage22 = love.graphics.newImage ("Imagens/stage22.png")
  stage23 = love.graphics.newImage ("Imagens/stage23.png")
  stage24 = love.graphics.newImage ("Imagens/stage24.jpg")
  gameOver = love.graphics.newImage ("Imagens/GameOver.png") 
  imgWarning = love.graphics.newImage ("Imagens/warning.png") 
  
  -- Balões de fala
  
  qtdSpeech = 0
  talk = false
  bossTalk = false
  bossConcept = nil
  bossIsTalking = false
  
  prologo0 = love.graphics.newImage ("Imagens/speech/Prologo/Prologo0.png")
  prologo1 = love.graphics.newImage ("Imagens/speech/Prologo/Prologo1.png")
  prologo2 = love.graphics.newImage ("Imagens/speech/Prologo/Prologo2.png")
  
  speech0 = love.graphics.newImage ("Imagens/speech/Speech0.png")
  -- Falas Fase 4
  speech0_St4 = love.graphics.newImage ("Imagens/speech/St4/speech0.png") 
  speech1_St4 = love.graphics.newImage ("Imagens/speech/St4/speech1.png") 
  speech2_St4 = love.graphics.newImage ("Imagens/speech/St4/speech2.png") 
  speech3_St4 = love.graphics.newImage ("Imagens/speech/St4/speech3.png") 
  speech4_St4 = love.graphics.newImage ("Imagens/speech/St4/speech4.png") 
  speech5_St4 = love.graphics.newImage ("Imagens/speech/St4/speech5.png") 
  speech6_St4 = love.graphics.newImage ("Imagens/speech/St4/speech6.png") 
  speech7_St4 = love.graphics.newImage ("Imagens/speech/St4/speech7.png") 
  speech8_St4 = love.graphics.newImage ("Imagens/speech/St4/speech8.png") 
  speech9_St4 = love.graphics.newImage ("Imagens/speech/St4/speech9.png")
  -- Falas Fase 7
  speech0_St7 = love.graphics.newImage ("Imagens/speech/St7/speech0.png") 
  speech1_St7 = love.graphics.newImage ("Imagens/speech/St7/speech1.png") 
  speech2_St7 = love.graphics.newImage ("Imagens/speech/St7/speech2.png") 
  speech3_St7 = love.graphics.newImage ("Imagens/speech/St7/speech3.png") 
  speech4_St7 = love.graphics.newImage ("Imagens/speech/St7/speech4.png") 
  speech5_St7 = love.graphics.newImage ("Imagens/speech/St7/speech5.png") 
  speech6_St7 = love.graphics.newImage ("Imagens/speech/St7/speech6.png") 
  speech7_St7 = love.graphics.newImage ("Imagens/speech/St7/speech7.png") 
  speech8_St7 = love.graphics.newImage ("Imagens/speech/St7/speech8.png") 
  speech9_St7 = love.graphics.newImage ("Imagens/speech/St7/speech9.png")
  speech10_St7 = love.graphics.newImage ("Imagens/speech/St7/speech10.png")
  speech11_St7 = love.graphics.newImage ("Imagens/speech/St7/speech11.png")
  -- Falas Fase 10
  speech0_St10 = love.graphics.newImage ("Imagens/speech/St10/speech0.png") 
  speech1_St10 = love.graphics.newImage ("Imagens/speech/St10/speech1.png") 
  speech2_St10 = love.graphics.newImage ("Imagens/speech/St10/speech2.png") 
  speech3_St10 = love.graphics.newImage ("Imagens/speech/St10/speech3.png") 
  speech4_St10 = love.graphics.newImage ("Imagens/speech/St10/speech4.png") 
  speech5_St10 = love.graphics.newImage ("Imagens/speech/St10/speech5.png") 
  speech6_1_St10 = love.graphics.newImage ("Imagens/speech/St10/speech6_1.png") 
  speech6_2_St10 = love.graphics.newImage ("Imagens/speech/St10/speech6_2.png") 
  speech7_St10 = love.graphics.newImage ("Imagens/speech/St10/speech7.png") 
  speech8_St10 = love.graphics.newImage ("Imagens/speech/St10/speech8.png") 
  speech9_St10 = love.graphics.newImage ("Imagens/speech/St10/speech9.png")
  -- Falas Fase 12
  speech0_St12 = love.graphics.newImage ("Imagens/speech/St12/speech0.png") 
  speech1_St12 = love.graphics.newImage ("Imagens/speech/St12/speech1.png") 
  speech2_St12 = love.graphics.newImage ("Imagens/speech/St12/speech2.png") 
  speech3_St12 = love.graphics.newImage ("Imagens/speech/St12/speech3.png") 
  speech4_St12 = love.graphics.newImage ("Imagens/speech/St12/speech4.png") 
  speech5_St12 = love.graphics.newImage ("Imagens/speech/St12/speech5.png") 
  speech6_St12 = love.graphics.newImage ("Imagens/speech/St12/speech6.png") 
  speech7_St12 = love.graphics.newImage ("Imagens/speech/St12/speech7.png") 
  speech8_St12 = love.graphics.newImage ("Imagens/speech/St12/speech8.png") 
  speech9_St12 = love.graphics.newImage ("Imagens/speech/St12/speech9.png") 
  speech10_St12 = love.graphics.newImage ("Imagens/speech/St12/speech10.png")
  speech11_St12 = love.graphics.newImage ("Imagens/speech/St12/speech11.png")
  speech12_St12 = love.graphics.newImage ("Imagens/speech/St12/speech12.png")
  speech13_St12 = love.graphics.newImage ("Imagens/speech/St12/speech13.png")
  speech14_St12 = love.graphics.newImage ("Imagens/speech/St12/speech14.png")
  speech15_St12 = love.graphics.newImage ("Imagens/speech/St12/speech15.png")
  speech16_St12 = love.graphics.newImage ("Imagens/speech/St12/speech16.png")
  speech17_St12 = love.graphics.newImage ("Imagens/speech/St12/speech17.png")
  speech18_St12 = love.graphics.newImage ("Imagens/speech/St12/speech18.png")
  speech19_St12 = love.graphics.newImage ("Imagens/speech/St12/speech19.png")
  speech20_St12 = love.graphics.newImage ("Imagens/speech/St12/speech20.png")
  speech21_St12 = love.graphics.newImage ("Imagens/speech/St12/speech21.png")
  speech22_St12 = love.graphics.newImage ("Imagens/speech/St12/speech22.png")
  speech23_St12 = love.graphics.newImage ("Imagens/speech/St12/speech23.png")
  -- Falas Fase 13
  speech0_St13 = love.graphics.newImage ("Imagens/speech/St13/speech0.png") 
  speech1_St13 = love.graphics.newImage ("Imagens/speech/St13/speech1.png") 
  speech2_St13 = love.graphics.newImage ("Imagens/speech/St13/speech2.png") 
  speech3_St13 = love.graphics.newImage ("Imagens/speech/St13/speech3.png") 
  speech4_St13 = love.graphics.newImage ("Imagens/speech/St13/speech4.png") 
  speech5_St13 = love.graphics.newImage ("Imagens/speech/St13/speech5.png") 
  speech6_St13 = love.graphics.newImage ("Imagens/speech/St13/speech6.png") 
  speech7_St13 = love.graphics.newImage ("Imagens/speech/St13/speech7.png") 
  speech8_St13 = love.graphics.newImage ("Imagens/speech/St13/speech8.png") 
  speech9_St13 = love.graphics.newImage ("Imagens/speech/St13/speech9.png") 
  speech10_St13 = love.graphics.newImage ("Imagens/speech/St13/speech10.png")
  speech11_St13 = love.graphics.newImage ("Imagens/speech/St13/speech11.png")
  speech12_St13 = love.graphics.newImage ("Imagens/speech/St13/speech12.png")

  speech0_St14 = love.graphics.newImage ("Imagens/speech/St14/speech0.png")
  speech0_St15 = love.graphics.newImage ("Imagens/speech/St15/speech0.png")
  speech0_St16 = love.graphics.newImage ("Imagens/speech/St16/speech0.png")
  -- Falas Fase 17
  speech0_St17 = love.graphics.newImage ("Imagens/speech/St17/speech0.png") 
  speech1_St17 = love.graphics.newImage ("Imagens/speech/St17/speech1.png") 
  speech2_St17 = love.graphics.newImage ("Imagens/speech/St17/speech2.png") 
  speech3_St17 = love.graphics.newImage ("Imagens/speech/St17/speech3.png") 
  speech4_St17 = love.graphics.newImage ("Imagens/speech/St17/speech4.png") 
  speech5_St17 = love.graphics.newImage ("Imagens/speech/St17/speech5.png") 
  speech6_St17 = love.graphics.newImage ("Imagens/speech/St17/speech6.png") 
  speech7_St17 = love.graphics.newImage ("Imagens/speech/St17/speech7.png") 
  speech8_St17 = love.graphics.newImage ("Imagens/speech/St17/speech8.png") 
  speech9_St17 = love.graphics.newImage ("Imagens/speech/St17/speech9.png")
  speech10_St17 = love.graphics.newImage ("Imagens/speech/St17/speech10.png")
  speech11_St17 = love.graphics.newImage ("Imagens/speech/St17/speech11.png")
  
  speech0_St18 = love.graphics.newImage ("Imagens/speech/St18/speech0.png") 
  speech0_St20 = love.graphics.newImage ("Imagens/speech/St20/speech0.png") 
  speech1_St20 = love.graphics.newImage ("Imagens/speech/St20/speech1.png") 
  speech2_St20 = love.graphics.newImage ("Imagens/speech/St20/speech2.png")
  -- Falas Fase 22
  speech0_St22 = love.graphics.newImage ("Imagens/speech/St22/speech0.png") 
  speech1_St22 = love.graphics.newImage ("Imagens/speech/St22/speech1.png") 
  speech2_St22 = love.graphics.newImage ("Imagens/speech/St22/speech2.png") 
  speech3_St22 = love.graphics.newImage ("Imagens/speech/St22/speech3.png") 
  speech4_St22 = love.graphics.newImage ("Imagens/speech/St22/speech4.png") 
  speech5_St22 = love.graphics.newImage ("Imagens/speech/St22/speech5.png") 
  speech6_St22 = love.graphics.newImage ("Imagens/speech/St22/speech6.png") 
  speech7_St22 = love.graphics.newImage ("Imagens/speech/St22/speech7.png") 
  speech8_St22 = love.graphics.newImage ("Imagens/speech/St22/speech8.png") 
  speech9_St22 = love.graphics.newImage ("Imagens/speech/St22/speech9.png")
  speech10_St22 = love.graphics.newImage ("Imagens/speech/St22/speech10.png")
  speech11_St22 = love.graphics.newImage ("Imagens/speech/St22/speech11.png")
  speech12_St22 = love.graphics.newImage ("Imagens/speech/St22/speech12.png")
  speech13_St22 = love.graphics.newImage ("Imagens/speech/St22/speech13.png")
  speech14_St22 = love.graphics.newImage ("Imagens/speech/St22/speech14.png")
  
  speech15_St22 = love.graphics.newImage ("Imagens/speech/St22/speech15.png")
  speech16_St22 = love.graphics.newImage ("Imagens/speech/St22/speech16.png")
  speech17_St22 = love.graphics.newImage ("Imagens/speech/St22/speech17.png")
  speech18_St22 = love.graphics.newImage ("Imagens/speech/St22/speech18.png")
  speech19_St22 = love.graphics.newImage ("Imagens/speech/St22/speech19.png")
  speech20_St22 = love.graphics.newImage ("Imagens/speech/St22/speech20.png")
  speech21_St22 = love.graphics.newImage ("Imagens/speech/St22/speech21.png")
  speech22_St22 = love.graphics.newImage ("Imagens/speech/St22/speech22.png")
  speech23_St22 = love.graphics.newImage ("Imagens/speech/St22/speech23.png")
  speech24_St22 = love.graphics.newImage ("Imagens/speech/St22/speech24.png")
  speech25_St22 = love.graphics.newImage ("Imagens/speech/St22/speech25.png")
  speech26_St22 = love.graphics.newImage ("Imagens/speech/St22/speech26.png")
  speech27_St22 = love.graphics.newImage ("Imagens/speech/St22/speech27.png")
  speech28_St22 = love.graphics.newImage ("Imagens/speech/St22/speech28.png")
  speech29_St22 = love.graphics.newImage ("Imagens/speech/St22/speech29.png")
  speech30_St22 = love.graphics.newImage ("Imagens/speech/St22/speech30.png")
  speech31_St22 = love.graphics.newImage ("Imagens/speech/St22/speech31.png")
  -- Falas Fase 23
  speech0_St23 = love.graphics.newImage ("Imagens/speech/St23/speech0.png") 
  speech1_St23 = love.graphics.newImage ("Imagens/speech/St23/speech1.png") 
  speech2_St23 = love.graphics.newImage ("Imagens/speech/St23/speech2.png") 
  speech3_St23 = love.graphics.newImage ("Imagens/speech/St23/speech3.png") 
  speech4_St23 = love.graphics.newImage ("Imagens/speech/St23/speech4.png") 
  speech5_St23 = love.graphics.newImage ("Imagens/speech/St23/speech5.png") 
  speech6_St23 = love.graphics.newImage ("Imagens/speech/St23/speech6.png") 
  speech7_St23 = love.graphics.newImage ("Imagens/speech/St23/speech7.png") 
  speech8_St23 = love.graphics.newImage ("Imagens/speech/St23/speech8.png") 
  speech9_St23 = love.graphics.newImage ("Imagens/speech/St23/speech9.png")
  speech10_St23 = love.graphics.newImage ("Imagens/speech/St23/speech10.png")
  speech11_St23 = love.graphics.newImage ("Imagens/speech/St23/speech11.png")
  speech12_St23 = love.graphics.newImage ("Imagens/speech/St23/speech12.png")
  -- Falas Epílogo
  speech0_St24 = love.graphics.newImage ("Imagens/speech/St24/speech0.png") 
  speech1_St24 = love.graphics.newImage ("Imagens/speech/St24/speech1.png") 
  speech2_St24 = love.graphics.newImage ("Imagens/speech/St24/speech2.png") 
  -- Imagens Conceituais
  eagleConcept = love.graphics.newImage ("Imagens/speech/EagleConcept.png") 
  jackalConcept = love.graphics.newImage ("Imagens/speech/JackalConcept.png") 
  wolfConcept = love.graphics.newImage ("Imagens/speech/WolfConcept.png")
  ravenConcept = love.graphics.newImage ("Imagens/speech/RavenConcept.png") 
  foxConcept = love.graphics.newImage ("Imagens/speech/FoxConcept.png") 
  heroFoxConcept = love.graphics.newImage ("Imagens/speech/HeroFoxConcept.png") 
  hawkConcept = love.graphics.newImage ("Imagens/speech/HawkConcept.png") 
  speechAtual = speech0
  heroConcept = eagleConcept
  
  -- Player (Imagens e informações do Player)
  
  framesRunRight = {}
  framesRunLeft = {}
  framesFoxRunRight = {}
  framesFoxRunLeft = {}
  framesJetPack = {}
  smallBlastFrames = {}
  bigBlastFrames = {}
  ravenBlastFrames = {}
  deathBlastFrames = {}
  activeFrame = 1
  frameAtual = 1
  
  local x = 0
  for i = 1, 10 do
    deathBlastFrames[i] = love.graphics.newImage("Imagens/BlastSprites/Death/DeathBlast_0" .. i .. ".png")
    ravenBlastFrames[i] = love.graphics.newImage("Imagens/BlastSprites/Raven/BigBlast_0" .. i .. ".png")
    smallBlastFrames[i] = love.graphics.newImage("Imagens/BlastSprites/Blast2_0" .. i .. ".png")
    bigBlastFrames[i] = love.graphics.newImage("Imagens/BlastSprites/BigBlast_0" .. i .. ".png")
    framesJetPack[i] = love.graphics.newImage("Imagens/BlastSprites/JetPackFire_0" .. i .. ".png")
    framesFoxRunRight[i] = love.graphics.newImage("Imagens/BlastSprites/FoxRunRight_0" .. i .. ".png")
    framesFoxRunLeft[i] = love.graphics.newImage("Imagens/BlastSprites/FoxRunLeft_0" .. i .. ".png")
    framesRunRight[i] = love.graphics.newImage("Imagens/BlastSprites/EagleRunRight_0" .. i .. ".png")
    framesRunLeft[i] = love.graphics.newImage("Imagens/BlastSprites/EagleRunLeft_0" .. i .. ".png")
    x = x  + 58
  end
  
  imgPortal = love.graphics.newImage ("Imagens/portal_01.png")
  imgPortal2 = love.graphics.newImage ("Imagens/portal_02.png")
	imgHero = love.graphics.newImage ("Imagens/heroStand.png")
  imgHeroCrouch = love.graphics.newImage ("Imagens/heroCrouch.png")
  imgHeroJump = love.graphics.newImage ("Imagens/heroJump.png")
  imgHeroShoot = love.graphics.newImage ("Imagens/heroShoot.png")
  imgHeroFox = love.graphics.newImage ("Imagens/HeroFox.png")
  imgHeroFoxJump = love.graphics.newImage ("Imagens/HeroFoxJump.png")
  imgHeroFoxShoot = love.graphics.newImage ("Imagens/HeroFoxShoot.png")
  imgHeroFoxCrouch = love.graphics.newImage ("Imagens/HeroFoxCrouch.png")
  imgHeroTemp = imgHero
  
  px = 600  -- Variável da posição X do Portal
  ground = 450
  
  hero = {
    image = imgHero,  
    x = 100,  
    y = ground,  
    rot = 0, 
    hp = 100, 
    qtm2 = 0,
    qtm3 = 0,
    alive = false, 
    score = 0,  -- Pontuação do Player
    kqtd = 0,   -- Quantidade de inimigos derrotados
    ktot = 0,   -- Quantidade Total de inimigos derrotados
    runRight = false,
    runLeft = false,
  }
  

  -- Tiros do Player (Todas as variáveis relacionadas ao tiro)
  atira = true
  delayTiro = 0.5  -- Intervalo de tempo de cada tiro do Player (Pode atirar no mínimo a cada meio segundo)
  tempoAtirar = delayTiro -- Variável auxiliar
  imgBlast = love.graphics.newImage ("Imagens/HeroBlast.png")  -- Imagem do Laser verde
  imgHeroFoxBlast = love.graphics.newImage ("Imagens/HeroFoxBlast.png")
  imgBlast2 = love.graphics.newImage ("Imagens/HeroBlast2.png")
  imgBlast3 = love.graphics.newImage ("Imagens/BigHeroBlast.png")
    
  imgTiros = {imgBlast, imgBlast2, imgBlast3, imgHeroFoxBlast}     -- Tabela (Conjunto) das imagens dos tiros 
  blastType = imgBlast
  tiros = {}        
  
  --Inimigos (Todas as variáveis relacionadas a inimigo)
  
  boss1Frames = {}
  boss2Frames = {}
  boss3Frames = {}
  boss4Frames = {}
  boss5Frames = {}
  bossHawkFrames = {}
  mob1Frames = {}
  mob2Frames = {}
  mob3Frames = {}
  mob4Frames = {}
  mob5Frames = {}
  mob6Frames = {}
  mob7Frames = {}
  mob8Frames = {}
  mob9Frames = {}
  mob10Frames = {}
  mobFrameAtual = 1
  
  delayInimigo = 3  -- Tempo inicial pro inimigo aparecer na tela (A cada 3 segundos)
  tempoCriarInimigo = delayInimigo   -- Variável auxiliar
  imgMob = love.graphics.newImage("Imagens/mob1.png")  
  imgMob2 = love.graphics.newImage("Imagens/mob2.png") 
  imgMob3 = love.graphics.newImage("Imagens/mob3.png")  
  imgMob4 = love.graphics.newImage("Imagens/mob4.png")
  imgMob5 = love.graphics.newImage("Imagens/mob5.png")
  imgMob6 = love.graphics.newImage("Imagens/mob6.png")
  imgMob7 = love.graphics.newImage("Imagens/mob7.png")
  imgMob8 = love.graphics.newImage("Imagens/mob8.png")
  imgMob9 = love.graphics.newImage("Imagens/mob9.png")
  imgMob10 = love.graphics.newImage("Imagens/mob10.png")
  imgInimigos = {imgMob, imgMob2, imgMob3, imgMob4, imgMob5, imgMob6, imgMob7, imgMob8, imgMob9, imgMob10}
  
  for i = 1, 6 do
    boss1Frames[i] = love.graphics.newImage("Imagens/MobSprites/boss1_0" .. i .. ".png")
    boss2Frames[i] = love.graphics.newImage("Imagens/MobSprites/boss2_0" .. i .. ".png")
    boss3Frames[i] = love.graphics.newImage("Imagens/MobSprites/boss3_0" .. i .. ".png")
    boss4Frames[i] = love.graphics.newImage("Imagens/MobSprites/boss4_0" .. i .. ".png")
    boss5Frames[i] = love.graphics.newImage("Imagens/MobSprites/boss5_0" .. i .. ".png")
    mob1Frames[i] = love.graphics.newImage("Imagens/MobSprites/mob1_0" .. i .. ".png")
    mob2Frames[i] = love.graphics.newImage("Imagens/MobSprites/mob2_0" .. i .. ".png")
    mob3Frames[i] = love.graphics.newImage("Imagens/MobSprites/mob3_0" .. i .. ".png")
    mob4Frames[i] = love.graphics.newImage("Imagens/MobSprites/mob4_0" .. i .. ".png")
    mob5Frames[i] = love.graphics.newImage("Imagens/MobSprites/mob5_0" .. i .. ".png")
    mob6Frames[i] = love.graphics.newImage("Imagens/MobSprites/mob6_0" .. i .. ".png")
    mob7Frames[i] = love.graphics.newImage("Imagens/MobSprites/mob7_0" .. i .. ".png")
    mob8Frames[i] = love.graphics.newImage("Imagens/MobSprites/mob8_0" .. i .. ".png")
    mob9Frames[i] = love.graphics.newImage("Imagens/MobSprites/mob9_0" .. i .. ".png")
    mob10Frames[i] = love.graphics.newImage("Imagens/MobSprites/mob10_0" .. i .. ".png")
    bossHawkFrames[i] = love.graphics.newImage("Imagens/MobSprites/Hawk_0" .. i .. ".png")
  end
  
  
  imgBoss = love.graphics.newImage ("Imagens/boss1.png") 
  imgBoss2 = love.graphics.newImage ("Imagens/boss2.png") 
  imgBoss3 = love.graphics.newImage ("Imagens/boss3.png") 
  imgBoss4 = love.graphics.newImage ("Imagens/boss4.png") 
  imgBoss5 = love.graphics.newImage ("Imagens/boss5.png") 
  imgBossJackal = love.graphics.newImage ("Imagens/Jackal.png")
  imgBossRaven = love.graphics.newImage ("Imagens/Raven.png")
  imgPlat = love.graphics.newImage ("Imagens/plataforma.png")
  imgBossWolf = love.graphics.newImage ("Imagens/Wolf.png")
  imgBossFox = love.graphics.newImage("Imagens/FoxShoot.png")
  imgBossHawk = love.graphics.newImage("Imagens/Hawk.png")
  imgBossFoxStand = love.graphics.newImage("Imagens/Fox.png")
  bossAlive = false 
  inimigos = {}   -- Tabela de inimigos (É preenchida à medida que inimigos aparecem na tela)
  
  --Boss
  boss = { 
    image = imgBoss,
    x = 600, 
    y = ground,
    up = nil,
    hp = 200
  }
  
  -- Tiros Boss
  bossAtira = false
  bossDelayTiro = 1.3
  bossTempoAtirar = bossDelayTiro
  boss4Blast = love.graphics.newImage ("Imagens/boss4Blast.png") 
  imgFoxBlast = love.graphics.newImage ("Imagens/FoxBlast.png")
  imgWolfBlast = love.graphics.newImage ("Imagens/WolfBlast.png")
  imgRavenBlast = love.graphics.newImage ("Imagens/RavenBlast.png")
  imgDeathBlast = love.graphics.newImage ("Imagens/DeathBlast.png")
  imgBossBlast = imgRavenBlast
  bossTiros = {}
  
  --Cenário
  background = {
    image = menu,  -- Imagem de fundo atual
    imageGround = stage2Ground,
    groundY = 0,
    x = 0,         
    y = 0
  }
  
  -- Sistema de Save Score
  highscores = {}
  if( not love.filesystem.exists("scores.lua")) then
    scores = love.filesystem.newFile("scores.lua")
    love.filesystem.write("scores.lua", "highscore\n=\n" .. hero.score)
  end
  for lines in love.filesystem.lines("scores.lua") do
    table.insert(highscores, lines)
  end
  highscore = highscores[3]

end


-- ********************************************************************************

function love.update (dt) 
  
  player.animate(dt)
  
  if(paused) then  
    return 
  end
  if(hero.alive) then
    player.heroMoves(dt)
    player.shoot(dt)
  end
  
  stage.change(dt)
  speech.scenes()
  enemy.walk(dt)
  if(bossAlive and background.image ~= stage23 and background.image ~= stage21 and background.image ~= stage22 and background.image ~= stage17 and background.image ~= stage12 and background.image ~= stage4 and background.image ~= stage5 and background.image ~= stage9 and not talk) then
    enemy.bossMoves(dt)
    enemy.bossShoot(dt)
  elseif(bossAlive and (background.image == stage12 or background.image == stage4 or background.image == stage5 or background.image == stage9 or background.image == stage17 or background.image == stage21 or background.image == stage22 or background.image == stage23) and not talk) then
    enemy.bossShoot(dt)
  end
  if(geraInimigos) then
    enemy.geraInimigos(dt)
  end
  
  colisao (dt)
end 

-- *******************************************************************************

function backMenu()
  delayTiro = 0.5 
  typeBlast = imgTiros[1]
  boss.image = imgBoss
  imgBossBlast = imgRavenBlast
  speechAtual = speech0
  qtdtry = 1
  hero.hp = 100
  hero.score = 0
  hero.ktot = 0
  qtdSpeech = 0
  hero.kqtd = 0
  qtdStage = 0
  ground = 450
  gameState = "menu"
  bossComment = false
  stage.clean()
  background.image = menu
  hero.x = 100
  hero.y = ground
  hero.qtm2 = 0
  hero.qtm3 = 0
  somGameOver:stop()
  somMenu:play()
end

-- Função que verifica se alguma tecla foi pressionada

function love.keypressed(key, unicode)
  if(key == 'y' and background.image == gameOver) then  -- Retry
    qtdtry = qtdtry + 1
    background.groundY = background.groundY - 400
    hero.hp = 100
    hero.alive = true
    if(qtdStage ~= 22 and qtdStage ~= 23) then
      geraInimigos = true
    end
    bossComment = false
    delayTiro = 0.5 
    if(not completed and qtdStage ~= 23) then
      blastType = imgTiros[1]
    else
      blastType = imgTiros[4]
    end
    qtdSpeech = 0
    hero.kqtd = 0
    hero.x = 100
    hero.y = ground
    hero.qtm2 = 5
    hero.qtm3 = 5
    somGameOver:stop()
    if(qtdStage >= 0 and qtdStage <= 3) then
      somStage:play()
    elseif(qtdStage == 4) then
      somBossTheme1:play()
    elseif(qtdStage == 5 or qtdStage == 6) then
      somStage2:play()
    elseif(qtdStage == 7) then
      somBossTheme2:play()
    elseif(qtdStage == 8 or qtdStage == 9) then
      somJungleTheme:play()
    elseif(qtdStage == 10) then
      somBossTheme3:play()
    elseif(qtdStage == 11) then
      somStage3:play()
    elseif(qtdStage == 12) then
      somFoxTheme:play()
    elseif(qtdStage == 13) then
      somStage4:play()
    elseif(qtdStage >= 14 and qtdStage <= 16) then
      somStage5:play()
    elseif(qtdStage == 17) then
      somBossTheme4:play()
    elseif(qtdStage == 18 or qtdStage == 19) then
      somStage2:play()
    elseif(qtdStage == 20 or qtdStage == 21) then
      somTythonTheme:play()
    elseif(qtdStage == 22) then
      somFoxTheme:play()
    elseif(qtdStage == 23) then
      somBossTheme5:play()
    end
    if(qtdStage > 0) then
      qtdStage = qtdStage - 1
      px = 100
    else
      background.image = stage1
    end
  elseif(key == 'n' and background.image == gameOver) then  -- Volta pro Menu
    backMenu()
  elseif(key == '1') then
    delayTiro = 0.5  
    if(not completed and qtdStage ~= 23) then
      blastType = imgTiros[1]
    else
      blastType = imgTiros[4]
    end
  elseif(key == '2' and hero.qtm2 > 0) then
    delayTiro = 1 
    blastType = imgTiros[2]
  elseif(key == '3' and hero.qtm3 > 0) then
    delayTiro = 1
    blastType = imgTiros[3]
  elseif(key == "return" and gameState == "menu") then
    gameState = "historia"
    background.image = options
  elseif(key == "return" and gameState == "historia" and qtdSpeech < 2) then
    qtdSpeech = qtdSpeech + 1
  elseif(key == "return" and gameState == "historia" and qtdSpeech == 2) then 
    background.image = teclado
    gameState = "controles"
    qtdSpeech = 0
  elseif(key == "return" and gameState == "controles") then
    if(completed) then
      blastType = imgTiros[4]
    end
    gameState = "playing"
    stage.clean()
    geraInimigos = true
    hero.alive = true
    somMenu:stop()           
    somStage:play()          -- Toca a música da primeira fase
    background.image = stage1   -- Muda a imagem da tela
  elseif(key == "return" and gameState == "credits") then
    completed = true
    somCredits:stop()
    backMenu()
  elseif(key == "return" and gameState == "playing" and talk) then
    qtdSpeech = qtdSpeech + 1
  elseif(key == "p" and gameState == "playing" and not talk) then
    paused = not paused
  elseif (key == "escape") then    
    love.event.quit()        
    love.filesystem.write("scores.lua", "highscore\n=\n" ..  hero.score)
  end
      
end

function love.keyreleased(key)
   if (key == "d" and hero.y == ground) then
     hero.runRight = false
     if(completed) then
       hero.image = imgHeroFox
     else
       hero.image = imgHero
     end
   elseif(key == "a" and hero.y == ground) then
      hero.runLeft = false
      if(completed) then
        hero.image = imgHeroFox
      else
        hero.image = imgHero
      end
  elseif(key == "s" and hero.y == ground + 30) then
      hero.y = ground
      if(completed) then
        hero.image = imgHeroFox
      else
        hero.image = imgHero
      end
   end
end

-- Função que verifica se houve alguma colisão (Player com inimigo e Tiro com inimigo)

function colisao (dt)
  for i, inimigo in ipairs (inimigos) do   -- Percorre a tabela de inimigos e >> Para cada << inimigo
    for j, tiro in ipairs (tiros) do      -- Percorre a tabela de tiros
      if verificaColisao(inimigo.x, inimigo.y, inimigo.image:getWidth(), inimigo.image:getHeight(), tiro.x, tiro.y, tiro.image:getWidth(), tiro.image:getHeight()) then  
        -- Se houve colisão entre >> inimigo e tiro << 
        if(bossAlive) then
          if(blastType == imgTiros[1]) then
            inimigo.hp = inimigo.hp - 10
          elseif(blastType == imgTiros[2]) then
            inimigo.hp = inimigo.hp - 30
          elseif(blastType == imgTiros[3] or blastType == imgTiros[4]) then
            inimigo.hp = inimigo.hp - 50
          end
          if(boss.hp <= 0) then
            if(boss.image == imgBossRaven) then
              somRavenHurt:play()
            else
              somMob2:play()
            end
            hero.score = hero.score + 50
            hero.kqtd = hero.kqtd + 1
            hero.ktot = hero.ktot + 1
            if(qtdStage == 0) then
              qtdStage = qtdStage + 1
            end
            stage.clean()
            bossAlive = false
            boss.y = ground
            boss.hp = 100
          end
        else   --  >> atingiu inimigo comum  <<
          if(inimigo.image == imgMob or inimigo.image == imgMob4 or inimigo.image == imgMob10 or inimigo.image == imgMob3 or inimigo.image == imbMob5) then
            somMobFat:play()
          elseif(inimigo.image == imgMob2) then
            somMob:play()  
          else
            somMob2:play()
          end
          if(blastType == imgTiros[1]) then
            inimigo.hp = inimigo.hp - 40
          elseif(blastType == imgTiros[2]) then
            inimigo.hp = inimigo.hp - 50
          elseif(blastType == imgTiros[3] or blastType == imgTiros[4]) then
            inimigo.hp = inimigo.hp - 100
          end
          if(inimigo.hp <= 0) then
            table.remove(inimigos, i)  -- Removo o inimigo
            hero.score = hero.score + 10   -- Matou um inimigo, então soma 10 pontos no total. 
            hero.kqtd = hero.kqtd + 1
            hero.ktot = hero.ktot + 1
          end
        end
        table.remove(tiros, j)   -- Remove o tiro
        
      end
    end
    
    if verificaColisao(inimigo.x, inimigo.y, inimigo.image:getWidth(), inimigo.image:getHeight(), hero.x, hero.y, hero.image:getWidth(), hero.image:getHeight()) then  
      -- Se houve colisão entre >> Inimigo e o Player <<
      if(not completed) then
        somPlayerHit:play() 
      else
        somFoxHurt:play()
      end
      if(bossAlive and background.image == stage22 and hero.kqtd == 1) then 
        somFoxHurt:play()
        hero.score = hero.score + 100
        hero.kqtd = hero.kqtd + 1
        hero.ktot = hero.ktot + 1
        stage.clean()
        bossAlive = false
      elseif(bossAlive and background.image == stage12) then 
        somFoxHurt:play()
        hero.score = hero.score + 100
        hero.kqtd = hero.kqtd + 1
        hero.ktot = hero.ktot + 1
        stage.clean()
        bossAlive = false
        boss.hp = 100
      elseif(not bossAlive) then    -- Se enconstou em inimigo comum
        hero.hp = hero.hp - 10
        hero.kqtd = hero.kqtd + 1
        hero.ktot = hero.ktot + 1
        table.remove(inimigos, i)   -- Remove o inimigo (Venceu o inimigo no soco)
      else    -- Se encostar em boss
        hero.hp = hero.hp - 2
      end
      
    end
  end
  
  if(bossAlive) then
    for i, tiro in ipairs (bossTiros) do
      if verificaColisao(hero.x, hero.y, hero.image:getWidth(), hero.image:getHeight(), tiro.x, tiro.y, tiro.image:getWidth(), tiro.image:getHeight()) then
          somPlayerHit:play()
          if(boss.image == imgBoss) then
            hero.hp = hero.hp - 5
          elseif(boss.image == imgBoss2) then
            hero.hp = hero.hp - 10
          elseif(boss.image == imgBoss3 or boss.image == imgBoss4 or boss.image == imgBoss5) then
            hero.hp = hero.hp - 20
          elseif(boss.image == imgBossJackal) then
            hero.hp = hero.hp - 30
          elseif(boss.image == imgBossWolf) then
            hero.hp = hero.hp - 90  
          elseif(boss.image == imgBossRaven) then
            hero.hp = hero.hp - 50
          elseif(boss.image == imgBossFox) then
            hero.hp = hero.hp - 40
          elseif(boss.image == imgBossHawk) then
            hero.hp = hero.hp - 30
          end
          table.remove(bossTiros, i)
      end
    end
  end
end


function verificaColisao(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end


function love.draw()    -- Função que desenha na tela
  love.graphics.setColor(255,255,255) 
  love.graphics.draw(background.image, 0, background.y) 
  if(background.image ~= gameOver and (qtdStage == 2 or  qtdStage == 6 or qtdStage == 15 or qtdStage == 19)) then
     love.graphics.draw(background.imageGround, background.x, background.groundY) 
     love.graphics.draw(background.imageGround, background.x + 790, background.groundY)
  end
  
  if(not bossAlive and qtdStage >= 1 and background.image ~= gameOver and background.image ~= credits and background.image ~= options and not bossTalk) then
    if((px - hero.x) > 150) then
      love.graphics.draw(imgPortal, px, ground - 30)
    else
      love.graphics.draw(imgPortal2, px, ground - 30)
    end
  end
  
  if(background.image == options) then
    love.graphics.draw(imgPrologo, 100, 100)
  end
  
  if(background.image == stage13 and (qtdSpeech >= 1 and qtdSpeech <= 10) and hero.kqtd >= 5) then
     love.graphics.draw(bossHawkFrames[mobFrameAtual], 600, 450)
  end
  
  if(hero.alive) then
    if(not completed) then
      if(hero.runRight) then
        love.graphics.draw(framesRunRight[frameAtual], hero.x, hero.y)  -- Animação Run Right
      elseif(hero.runLeft) then
        love.graphics.draw(framesRunLeft[frameAtual], hero.x, hero.y)  -- Animação Run Left
      else
        love.graphics.draw(hero.image, hero.x, hero.y)
      end
    else
      if(hero.runRight) then
        love.graphics.draw(framesFoxRunRight[frameAtual], hero.x, hero.y)  -- Animação Run Right
      elseif(hero.runLeft) then
        love.graphics.draw(framesFoxRunLeft[frameAtual], hero.x, hero.y)  -- Animação Run Left
      else
        love.graphics.draw(hero.image, hero.x, hero.y)
      end
    end
    
    if(hero.y < ground) then
      love.graphics.draw(framesJetPack[frameAtual], hero.x+13, hero.y + 55)
    end
  end
  
  if(background.image ~= menu and background.image ~= gameOver and background.image ~= teclado and background.image ~= options and background.image ~= credits) then  
    if(not talk) then
      love.graphics.print("Score: " .. hero.score, 50, 50)
      if(hero.hp < 30) then
        love.graphics.setColor(255,0,0)
      end
      love.graphics.print("HP: " .. hero.hp, 50, 80)
      love.graphics.setColor(255,255,255)
      love.graphics.print("M2: " .. hero.qtm2, 50, 100)
      love.graphics.print("M3: " .. hero.qtm3, 50, 120)
    end
  end
  if(background.image == gameOver) then  
    love.graphics.print("Your Score: " .. hero.score, 300, 100)
    love.graphics.print("Highest Score: " .. highscore, 300, 140)
  elseif(background.image == credits) then
    love.graphics.print("Your Score: " .. hero.score, 310, 80)
    love.graphics.print("Highest Score: " .. highscore, 310, 120)
  end
  
  -- Desenha Tiros do Boss
  if(bossAlive) then
    for i, bossTiro in ipairs (bossTiros) do    
      if(imgBossBlast == imgRavenBlast) then
        love.graphics.draw(ravenBlastFrames[frameAtual], bossTiro.x, bossTiro.y)
      elseif(imgBossBlast == imgDeathBlast) then
        love.graphics.draw(deathBlastFrames[frameAtual], bossTiro.x, bossTiro.y)
      else
        love.graphics.draw(imgBossBlast, bossTiro.x, bossTiro.y)
      end
    end
 end
 
 
  
  -- Desenha Tiros
  for i, tiro in ipairs (tiros) do     -- Percorre a tabela de tiros e desenha na tela.
    if(tiro.image == imgBlast3) then
      love.graphics.draw(bigBlastFrames[frameAtual], tiro.x, tiro.y)
    elseif(tiro.image == imgBlast2) then
      love.graphics.draw(smallBlastFrames[frameAtual], tiro.x, tiro.y)
    else 
      love.graphics.draw(tiro.image, tiro.x, tiro.y)
    end
  end
  -- Desenha Inimigos
  for i, inimigo in ipairs(inimigos) do  
    if(inimigo.image == imgBoss) then
      love.graphics.draw(boss1Frames[mobFrameAtual], inimigo.x, inimigo.y)
    elseif(inimigo.image == imgBoss2) then
      love.graphics.draw(boss2Frames[mobFrameAtual], inimigo.x, inimigo.y)
    elseif(inimigo.image == imgBoss3) then
      love.graphics.draw(boss3Frames[mobFrameAtual], inimigo.x, inimigo.y)
    elseif(inimigo.image == imgBoss4) then
      love.graphics.draw(boss4Frames[mobFrameAtual], inimigo.x, inimigo.y)
    elseif(inimigo.image == imgBoss5) then
      love.graphics.draw(boss5Frames[mobFrameAtual], 380, 300)
    elseif(inimigo.image == imgMob) then
      love.graphics.draw(mob1Frames[mobFrameAtual], inimigo.x, inimigo.y)
    elseif(inimigo.image == imgMob2) then
      love.graphics.draw(mob2Frames[mobFrameAtual], inimigo.x, inimigo.y)
    elseif(inimigo.image == imgMob3) then
      love.graphics.draw(mob3Frames[mobFrameAtual], inimigo.x, inimigo.y)
    elseif(inimigo.image == imgMob4) then
      love.graphics.draw(mob4Frames[mobFrameAtual], inimigo.x, inimigo.y)
    elseif(inimigo.image == imgMob5) then
      love.graphics.draw(mob5Frames[mobFrameAtual], inimigo.x, inimigo.y)
    elseif(inimigo.image == imgMob6) then
      love.graphics.draw(mob6Frames[mobFrameAtual], inimigo.x, inimigo.y)
    elseif(inimigo.image == imgMob7) then
      love.graphics.draw(mob7Frames[mobFrameAtual], inimigo.x, inimigo.y)
    elseif(inimigo.image == imgMob8) then
      love.graphics.draw(mob8Frames[mobFrameAtual], inimigo.x, inimigo.y)
    elseif(inimigo.image == imgMob9) then
      love.graphics.draw(mob9Frames[mobFrameAtual], inimigo.x, inimigo.y)
    elseif(inimigo.image == imgMob10) then
      love.graphics.draw(mob10Frames[mobFrameAtual], inimigo.x, inimigo.y)
    elseif(inimigo.image == imgBossWolf) then
      love.graphics.draw(inimigo.image, inimigo.x, inimigo.y)
      love.graphics.draw(imgPlat, inimigo.x + 10, inimigo.y + 20)
    elseif(inimigo.image == imgBossRaven) then
      love.graphics.draw(inimigo.image, inimigo.x, inimigo.y)
      love.graphics.draw(framesJetPack[frameAtual], inimigo.x+30, inimigo.y + 55)
      
    elseif(inimigo.image == imgBossHawk) then  -- test
      love.graphics.draw(bossHawkFrames[mobFrameAtual], 600, ground)
    else
      love.graphics.draw(inimigo.image, inimigo.x, inimigo.y)
    end
  end
  
  
  if(background.image == stage12 and qtdSpeech == 24) then 
   love.graphics.draw(imgBossFoxStand, 700, ground)
 elseif((background.image == stage17 and hero.kqtd >= 4) and qtdSpeech >= 1 ) then
   love.graphics.draw(bossHawkFrames[mobFrameAtual], 600, ground)
  elseif((background.image == stage22 or (background.image == stage23 and qtdSpeech >= 0 and qtdSpeech <= 10)) and talk) then
    love.graphics.draw(bossHawkFrames[mobFrameAtual], 600, ground - 20)
  elseif(background.image == stage22 and not talk) then
     love.graphics.draw(bossHawkFrames[mobFrameAtual], 600, ground)
 end
  
  if(paused and not talk) then
    love.graphics.print("Paused", largura/2 - 50, altura/2)
  end
  if(talk) then
    love.graphics.draw(heroConcept, 0, 250)
    if((qtdStage ~= 12 and qtdStage ~= 22) or (qtdStage == 22 and qtdSpeech < 26)) then
      love.graphics.draw(imgHeroTemp, 100, 450 )
    end
    if(bossTalk) then
      if(boss.image == imgBossJackal) then
        love.graphics.draw(bossConcept, 650, 285)
      elseif(boss.image == imgBossWolf) then
        love.graphics.draw(bossConcept, 600, 250)
      elseif(boss.image == imgBossRaven) then
        love.graphics.draw(bossConcept, 630, 250)
      else
        love.graphics.draw(bossConcept, 600, 250)
      end
    end
    love.graphics.draw(speechAtual, 50, 480)
    if(speechAtual == speech6_1_St10) then
      love.graphics.setColor(0,0,0)
      love.graphics.print(qtdtry, 330, 517)
      love.graphics.setColor(255,0,0)
    end
  end
  
  if(bossAlive and qtdStage ~= 17 and qtdStage ~= 22 and not talk) then
    love.graphics.print("HP: " .. boss.hp, 700, 90)
  elseif(bossAlive and not talk and ((qtdStage == 17 and qtdSpeech >= 10) or (qtdStage == 22 and qtdSpeech >= 15))) then
    love.graphics.print("HP: ? " , 700, 90)
  end
  
  if(warning) then
     love.graphics.draw(imgWarning, 300, 200)
  end
  if(background.image == gameOver) then
    if(qtdStage == 12) then
      love.graphics.print("Dica: Fique atento a fala de Fox.\n", 250, 500)
      love.graphics.print("Fox: \"Você não vai conseguir me derrotar com uma arma desse tipo! Patético...\"", 50, 520)
    elseif(qtdStage == 10) then
      love.graphics.print("Dica: Quanto maior a distância, mais fácil será desviar dos tiros.", 100, 500)
      love.graphics.print("Raven: \"É inútil! Consigo ler todos os seus pensamentos!\"", 100, 520)
    elseif(qtdStage == 17 or qtdStage == 22 or qtdStage == 23) then
      love.graphics.print("Dica: Quanto maior a distância, mais fácil será desviar dos tiros.", 100, 500)
    elseif(qtdStage < 12 and (qtdtry % 2) == 0) then
      love.graphics.print("Dica: Teclas 1, 2 e 3 para trocar de arma.\nEconomize munição especial para os Chefes.", 200, 500)
    else
      love.graphics.print("Dica: Segure a Tecla Q para atirar mais rápido.", 200, 500)
    end
  end
end
  

  