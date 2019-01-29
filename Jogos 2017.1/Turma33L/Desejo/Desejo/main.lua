-- Aquele desejo: Jogo desenvolvido inteiramente por alunos da Pontifícia Universidade Católica do Rio de janeiro

-- Essa função é executada uma vez assim que o jogo é iniciado, é usada para definições importantes
local utf8 = require("utf8")

function love.load()
  -- Define quantos pixels de tela equivalem a um metro (64px/1m)
  love.physics.setMeter(64)
  -- Cria o mundo com gravidade vertical semelhante a da Terra
  world = love.physics.newWorld(0, 9.8*128, true)
  -- Definie quais são as callbacks para esse mundo
  world:setCallbacks(collisions)

  -- Deixa o jogo em tela cheia
  love.window.setFullscreen(false)
  love.window.setTitle('Desejo: 1330 linhas de pura confusão!')
  --love.window.setMode(800, 600, {resizable=true, vsync=false, minwidth=400, minheight=1100})
  love.window.maximize()
  -- Armazena as dimensões da tela do monitor, e cria constantes para melhorar a consistência gráfica em monitores de resoluções variadas
  windowWidth, windowHeight = love.window.getDesktopDimensions(1)
  constWidth = windowWidth/1920
  constHeight = windowHeight/1080

  maxProjectileNumber = 0
  currentFrame = 0
  zukFrames = {}
  orcFrames = {}

  globalDt = 0
  spriteTransitionTime = 0
  nextLetterDt = 0
  nextProjectileDt = 0
  introSongPlayTime = 0

  monsterSpawnDt = 0
  isMonsterSpawning = true

  waitingDt = 0
  haveToWait = false

  introAlpha = 0
  timeToFadeOut = false
  fadeOutFirstStage = false
  doneFading = false

  collisionsWereChecked = false

  -- Guardam as teclas que foram pressionadas e soltas no ultimo dt
  love.keyboard.keysPressed = { }
  love.keyboard.keysReleased = { }
  structuresFrames = {}

  -- Guardam todas as informações dos corpos importantes
	projectiles = {}
	enemies = {}

  logoWasShowed = false
  iconeWasShowed = false
  introduction = false
  startGame = false
  transitionAlpha = 0
  makeAChoice = false
  rankingMode = false


  introductionText1 = "Havia um menino loiro, Zuk, cujo pai havia sido morto por um grande e poderoso slime."
  introductionText1WasPrinted = false
  introductionText2 = "Anos apos isso, quando ia para a casa de uma parente comer uma deliciosa manga, a vila em que vivia foi invadida por orcs furiosos . . ."
  introductionText2WasPrinted = false
  introductionText3 = "Depois de defender sua vila da primeira onda de orcs, Zuk volta a fazer o que estava fazendo"
  introductionText3WasPrinted = false
  introductionText4 = "quando ouve gritos vindo de sua vila e volta para defende-la novamente . . ."
  introductionText4WasPrinted = false
  introductionText5 = "Zuk salva o dia novamente, mas nao percebe um orc que havia ficado vivo no chao e recebe"
  introductionText5WasPrinted = false
  introductionText6 = "um golpe de machado nas pernas seguido por um fatal golpe na cabeca. Zuk jamais comera sua manga novamente . . ."
  introductionText6WasPrinted = false

  name = ''
  score = 0

  nameTable = {}
  for i = 1, 20, 1 do
    table.insert(nameTable, 'AAAAAAAAAA')
  end
  scoreTable = {}
  for i = 1, 20, 1 do
    table.insert(scoreTable, '000')
  end

  amountOfLetters1 = #introductionText1
  amountOfLetters2 = #introductionText2
  amountOfLetters3 = #introductionText3
  amountOfLetters4 = #introductionText4
  amountOfLetters5 = #introductionText5
  amountOfLetters6 = #introductionText6

  lettersOnScreen1 = 0
  lettersOnScreen2 = 0
  lettersOnScreen3 = 0
  lettersOnScreen4 = 0
  lettersOnScreen5 = 0
  lettersOnScreen6 = 0

  introductionText1Table = {}
  introductionText2Table = {}
  introductionText3Table = {}
  introductionText4Table = {}
  introductionText5Table = {}
  introductionText6Table = {}

  for i = 1, #introductionText1 do
    introductionText1Table[i] = introductionText1:sub(i, i)
  end
  for i = 1, #introductionText2 do
    introductionText2Table[i] = introductionText2:sub(i, i)
  end
  for i = 1, #introductionText3 do
    introductionText3Table[i] = introductionText3:sub(i, i)
  end
  for i = 1, #introductionText4 do
    introductionText4Table[i] = introductionText4:sub(i, i)
  end
  for i = 1, #introductionText5 do
    introductionText5Table[i] = introductionText5:sub(i, i)
  end
  for i = 1, #introductionText6 do
    introductionText6Table[i] = introductionText6:sub(i, i)
  end

  -- Variáveis de controle do tempo
  firstTime, secondTime, elapsedTime = 0

  -- Constantes dos grupos de corpos
  IS_ENEMY = -1
  IS_PROJECTILE_OR_PLAYER = -2

  zukFrames[1] = love.graphics.newImage('zuk1Left.png')
  zukFrames[2] = love.graphics.newImage('zuk2Left.png')
  zukFrames[3] = love.graphics.newImage('zuk3Left.png')
  zukFrames[4] = love.graphics.newImage('zuk1Right.png')
  zukFrames[5] = love.graphics.newImage('zuk2Right.png')
  zukFrames[6] = love.graphics.newImage('zuk3Right.png')

  orcFrames[1] = love.graphics.newImage('orcSprite1Left.png')
  orcFrames[2] = love.graphics.newImage('orcSprite2Left.png')
  orcFrames[3] = love.graphics.newImage('orcSprite3Left.png')
  orcFrames[4] = love.graphics.newImage('orcSprite1Right.png')
  orcFrames[5] = love.graphics.newImage('orcSprite2Right.png')
  orcFrames[6] = love.graphics.newImage('orcSprite3Right.png')

  activeFrame = love.graphics.newImage('zuk1Left.png')

  background1 = love.graphics.newImage('Fase1.png')
  background1a = love.graphics.newImage('Fase1a.png')
  background1b = love.graphics.newImage('Fase1b.png')
  logo = love.graphics.newImage('logo.png')
  icone = love.graphics.newImage('icone.png')

  something_that_are_not_between_human = love.audio.newSource('something_that_are_not_between_human.mp3')
  opinion_leader_s_values = love.audio.newSource('opinion_leader_s_values.mp3')
  bloom_of_anxiety = love.audio.newSource('bloom_of_anxiety.mp3')
  incarnation_of_devil_radiata_version = love.audio.newSource('incarnation_of_devil_radiata_version.mp3')
  the_boundary = love.audio.newSource('the_boundary.mp3')
  scarlet_wind = love.audio.newSource('scarlet_wind.mp3')

  firstStageEnemies = 20
  firstStageCleared = false
  firstStageClearedHistory = false
  secondStageEnemies = 30
  secondStageCleared = false
  secondStageClearedHistory = false
  thirdStageEnemies = 100
  thirdStageCleared = false
  thirdStageClearedHistory = false
  nameCleared = false

  amountOfEnemies = 0

  startGameFadeHappened = false
  introAlphaIsSetted = false

  --Strings para debug
  DEBUG_STRING_1 = 1
  DEBUG_STRING_2 = 0
  DEBUG_STRING_3 = 0

  enemiesDead = 0
  scoresFile = nil

  -- Serão feitas as definições de vários elementos do jogo nas linhas abaixo, mas sempre com o mesmo padrão:
  -- body: é dado um corpo a um elemento abstrato e diz que mundo é responsável por reger o seu movimento
  -- shape: é dado uma forma ao elemento antes abstrato
  -- fixture: junta-se o corpo com a forma para permitir colisões com outros corpos
  -- friction: atrito do corpo com todos os outros corpos
  -- rotation: permitir que o corpo rode em torno de um eixo que passa pelo seu centro de massa e saindo da tela
  -- userData: usado na hora de fazer checagem de colisões
  -- Com um pouco de esforço fica fácil entender os elementos que não foram definidos aqui

  ground = {}
  ground.body = love.physics.newBody(world, windowWidth/2, windowHeight - (100/2*constHeight))
  ground.shape = love.physics.newRectangleShape(windowWidth + 400*constWidth, 150*constHeight)
  ground.fixture = love.physics.newFixture(ground.body, ground.shape)
  ground.fixture:setUserData("Ground")

  invisibleLeftWall = {}
  invisibleLeftWall.body = love.physics.newBody(world, -10, windowHeight/2)
  invisibleLeftWall.shape = love.physics.newRectangleShape(0,0, 20, windowHeight)
  invisibleLeftWall.fixture = love.physics.newFixture(invisibleLeftWall.body, invisibleLeftWall.shape,500)
  invisibleLeftWall.fixture:setFriction(0)
  invisibleLeftWall.fixture:setUserData("invisible_left_wall")
  invisibleLeftWall.fixture:setGroupIndex(IS_ENEMY)

  invisibleRightWall = {}
  invisibleRightWall.body = love.physics.newBody(world, windowWidth+10, windowHeight/2)
  invisibleRightWall.shape = love.physics.newRectangleShape(0,0, 20, windowHeight)
  invisibleRightWall.fixture = love.physics.newFixture(invisibleRightWall.body, invisibleRightWall.shape,500)
  invisibleRightWall.fixture:setFriction(0)
  invisibleRightWall.fixture:setUserData("invisible_right_wall")
  invisibleRightWall.fixture:setGroupIndex(IS_ENEMY)


  invisibleCeiling = {}
  invisibleCeiling.body = love.physics.newBody(world, windowWidth/2, -10 )
  invisibleCeiling.shape = love.physics.newRectangleShape(0,0, windowWidth, 20)
  invisibleCeiling.fixture = love.physics.newFixture(invisibleCeiling.body, invisibleCeiling.shape,500)
  invisibleCeiling.fixture:setFriction(0)
  invisibleCeiling.fixture:setUserData("invisible_ceiling")

  player = {}
  player.body = love.physics.newBody(world, windowWidth/2, 900*constHeight, "dynamic")
  player.body:setFixedRotation(true)
  player.shape = love.physics.newRectangleShape(0, 0, 60*constWidth, 100*constHeight)
  player.fixture = love.physics.newFixture(player.body, player.shape, 10)
  player.fixture:setFriction(0.9)
  player.fixture:setUserData("Player")
  player.speed = 450*constWidth
  player.hp = 100
  player.hpMax = 100
  player.fixture:setGroupIndex(IS_PROJECTILE_OR_PLAYER)
  player.activeWeapon = 1
  player.activeSkill = 1
  player.arrowDamage = 125
  player.facingDirection = 1
  player.isDead = false
  player.archerBuff = false

  gimmo = {}
  gimmo.body = love.physics.newBody(world, 12000*constWidth, 900*constHeight, "dynamic")
  gimmo.body:setFixedRotation(true)
  gimmo.shape = love.physics.newRectangleShape(0, 0, 60*constWidth, 100*constHeight)
  gimmo.fixture = love.physics.newFixture(gimmo.body, gimmo.shape, 100)
  gimmo.fixture:setFriction(0.9)
  gimmo.fixture:setUserData("Gimmo")
  gimmo.hp = 1000000
  gimmo.hpMax = 1000000
  gimmo.facingDirection = 1

  castle = {}
  castle.body = love.physics.newBody(world, windowWidth/2, windowHeight - (200/2*constHeight))
  castle.shape = love.physics.newRectangleShape(400*constWidth, 900*constHeight)
  castle.fixture = love.physics.newFixture(castle.body, castle.shape)
  castle.fixture:setUserData("Castle")
  castle.hp = 5000
  castle.hpMax = 5000
  castle.fixture:setGroupIndex(IS_PROJECTILE_OR_PLAYER)

  shotTime = love.timer.getTime()

end

-- Onde toda a mágica acontece, é chamado a cada dt e é onde a maior parte dos cálculos são feitos
function love.update(dt)
  globalDt = globalDt + dt
  nextLetterDt = nextLetterDt + dt
  spriteTransitionTime = spriteTransitionTime + dt
  nextProjectileDt = nextProjectileDt + dt
  introSongPlayTime = opinion_leader_s_values:tell()

  local playerXLinearVelocity, playerYLinearVelocity = player.body:getLinearVelocity()
  local playerXPosition = player.body:getX()

  if (spriteTransitionTime > 0.25) then
    if (player.facingDirection == 0) then
      if (playerXLinearVelocity < 0) then
        if (currentFrame == 2) then
          currentFrame = 3
        else
          currentFrame = 2
        end
      else
        currentFrame = 1
      end
    elseif (player.facingDirection == 1) then
      if (playerXLinearVelocity > 0) then
        if (currentFrame == 5) then
          currentFrame = 6
        else
          currentFrame = 5
        end
      else
        currentFrame = 4
      end
    end
    spriteTransitionTime = 0
    activeFrame = zukFrames[currentFrame]
  end

  for i = 1, #enemies, 1 do
    if (enemies[i] ~= nil) then
      enemies[i].dt = enemies[i].dt + dt
      x = enemies[i].body:getLinearVelocity()
      if (enemies[i].dt > 0.25) then
        if (enemies[i].facingDirection == 0) then
          if (x < 0) then
            if (enemies[i].currentFrame == 2) then
              enemies[i].currentFrame = 3
            else
              enemies[i].currentFrame = 2
            end
          else
            enemies[i].currentFrame = 1
          end
        elseif (enemies[i].facingDirection == 1) then
          if (x > 0) then
            if (enemies[i].currentFrame == 5) then
              enemies[i].currentFrame = 6
            else
              enemies[i].currentFrame = 5
            end
          else
            enemies[i].currentFrame = 4
          end
        end
        enemies[i].dt = 0
        enemies[i].activeFrame = orcFrames[enemies[i].currentFrame]
      end
    end
  end

  if (isMonsterSpawning == true) then
    monsterSpawnDt = monsterSpawnDt + dt
  end

  if (haveToWait == true) then
    waitingDt = waitingDt + dt
  end

  if (startGame == true and firstStageCleared == false and secondStageCleared == false and makeAChoice == false) then
    sweepDeadBodies()

    -- Guarda as componentes da velocidade
    if (player.hp <= 0) then
      player.isDead = true
    end
    -- Coloca o mundo para funcionar
    world:update(dt)
    local  currentTime = love.timer.getTime()

    -- Essa sequência de ifs até o próximo comentário regem o movimento do personagem
    -- e restringe ele a andar apenas na tela (ele não pode sair do campo de visão do jogador)
    if (playerXPosition <= (windowWidth - 30*constWidth)) then
      if playerXLinearVelocity <= player.speed then
        if love.keyboard.isDown("d") then
          player.body:applyForce(20000*constWidth, 0)
          player.facingDirection = 1
        end
      end
    end
    if (playerXPosition >= 30*constWidth) then
      if playerXLinearVelocity >= -player.speed then
        if love.keyboard.isDown("a") then
          player.body:applyForce(-20000*constWidth, 0)
          player.facingDirection = 0
        end
      end
    end
    if playerYLinearVelocity < 1.0 and playerYLinearVelocity > -1.0  then
      if love.keyboard.wasPressed("space") then
        player.body:applyForce(0, -600000*constHeight)
      end
    end
    if love.keyboard.wasPressed("return") then
      if (string.len(name) < 10) then
        for i = 1, 10-(string.len(name)), 1 do
          name = name .. ' '
        end
      elseif (string.len(name) > 10) then
        name = string.sub(name, -10, 0)
      end
      --name = name..'\\'
      if (score < 10) then
        strscore = '00'..score
      elseif (score < 100) then
        strscore = '0'..score
      elseif (score > 100) then
      strscore = score
      end
      --strscore = strscore..'|'
      --saveScoreToFile(name, strscore)
      rankingMode = false
      makeAChoice = true
      player.hp = player.hpMax
      castle.hp = castle.hpMax

      maxPosition = #scoreTable
      for i = #scoreTable, 1, -1 do
        if (tonumber(strscore) > tonumber(scoreTable[i])) then
          maxPosition = i
        end
      end
      table.insert(nameTable, maxPosition, name)
      table.insert(scoreTable, maxPosition, score)
    end

    if (love.keyboard.wasPressed("1")) then
      player.activeWeapon = 1
      DEBUG_STRING_1 = 1
    elseif (love.keyboard.wasPressed("2")) then
      player.activeWeapon = 2
      DEBUG_STRING_1 = 2
    elseif (love.keyboard.wasPressed("3")) then
      player.activeWeapon = 3
      DEBUG_STRING_1 = 3
    end

    -- Confere se o player clicou, se for o caso dispara um projétil na direção do mouse
    if (buttonClicked ~= nil) then
      if (buttonClicked.button == 1) then
        if (nextProjectileDt > 0.1) then
          if (player.activeWeapon == 1) then
    		    local playerXPosition, playerYPosition = player.body:getPosition()
    			  projectile = {}
      			projectile.body = love.physics.newBody(world, playerXPosition, playerYPosition, "dynamic")
            projectile.body:setBullet(true)
      			projectile.shape = love.physics.newRectangleShape(0, 0, 35*constWidth, 8*constHeight)
      			projectile.fixture = love.physics.newFixture(projectile.body, projectile.shape, 10)
            projectile.fixture:setUserData("Projectile " .. (maxProjectileNumber + 1))
            projectile.fixture:setGroupIndex(IS_PROJECTILE_OR_PLAYER)
            projectile.type = 1

      			applyBetterLinearImpulse(projectile, getRelativeMouseAngle(), 1500)

      			table.insert(projectiles, projectile)
          elseif (player.activeWeapon == 2) then
            local playerXPosition, playerYPosition = player.body:getPosition()

    			  projectile = {}
      			projectile.body = love.physics.newBody(world, playerXPosition, playerYPosition, "dynamic")
            projectile.body:setBullet(true)
      			projectile.shape = love.physics.newCircleShape(17)
      			projectile.fixture = love.physics.newFixture(projectile.body, projectile.shape, 10)
            projectile.fixture:setUserData("Projectile " .. (maxProjectileNumber + 1))
            projectile.fixture:setGroupIndex(IS_PROJECTILE_OR_PLAYER)
            projectile.type = 2

      			applyBetterLinearImpulse(projectile, getRelativeMouseAngle(), 4500)

      			table.insert(projectiles, projectile)
          elseif (player.activeWeapon == 3) then
            --mecânica da segunda skill do arqueiro
            if(player.archerBuff == false) then
              player.archerBuff = true
              buffBegin = love.timer.getTime()
              player.arrowDamage = 250
              player.speed = player.speed*1.4
              px, py = player.body:getLinearVelocity()
              if(px <= player.speed/1.4 ) then
                player.body:setLinearVelocity(px*1.4, py)
              end
            end
          end
          maxProjectileNumber = maxProjectileNumber + 1
          nextProjectileDt = 0
    		end
      end
    end
      --Tira o buff depois da sua duração
    if(buffBegin ~= nil) then
      if(currentTime - buffBegin >= 8 and player.archerBuff == true) then
        player.archerBuff = false
        player.arrowDamage = 30
        player.speed = player.speed/1.4
        px, py = player.body:getLinearVelocity()
        if(px > player.speed) then
          player.body:setLinearVelocity(px/1.4, py)
        end
      end
    end

    -- Confere se já passou um determinado tempo desde a ultima checagem, se já tiver passado
    -- spawna um novo inimigo no mapa e zera os contadores
    if (monsterSpawnDt > 0.4) then
  		enemy = {}
      enemy.speed = 200*constWidth
      enemy.body = love.physics.newBody(world, setRandomSpawn(), (1080-200)*constHeight, "dynamic")
      enemy.body:setFixedRotation(true)
      enemy.shape = love.physics.newRectangleShape(0, 0, 60*constWidth, 100*constHeight)
      enemy.fixture = love.physics.newFixture(enemy.body, enemy.shape, 10)
      enemy.fixture:setFriction(0.9)
      enemy.fixture:setUserData("Enemy " .. (#enemies + 1))
      enemy.fixture:setGroupIndex(IS_ENEMY)
      enemy.hp = 250
      enemy.hpMax = 250
      enemy.isFrozen = false
      enemy.frozenTime = 0
      enemy.ID = #enemies + 1
      enemy.dt = 0
      enemy.facingDirection = 0
      enemy.currentFrame = 0
      enemy.activeFrame = orcFrames[1]
      enemy.isDead = false
      enemy.damageDt = 0
      amountOfEnemies = amountOfEnemies + 1
      if (firstStageClearedHistory == false and amountOfEnemies <= 20) then
		    table.insert(enemies, enemy)
      elseif (firstStageClearedHistory == true and secondStageClearedHistory == false and amountOfEnemies <= 30) then
        table.insert(enemies, enemy)
      elseif (rankingMode == true) then
        enemy.speed = 400*constWidth
        table.insert(enemies, enemy)
      end
      monsterSpawnDt = 0
      collisionsWereChecked = false
      DEBUG_STRING_1 = 'false'
    end

    -- Faz com que os monstros que estão no jogo corram atrás do jogador
    for i = 1, #enemies, 1 do
      if (enemies[i] ~= nil) then
        chase(enemies[i], castle, dt)
      end
    end

    -- Atualiza o ângulo das flechas
    for i = 1, #projectiles, 1 do
      if(projectiles[i].type == 1) then
        projectiles[i].body:setAngle(setArrowAngle(projectiles[i]))
      end
    end

    -- Se o jogador pressionar a tecla ESC fecha o jogo
    if (love.keyboard.wasPressed('escape')) then
      love.event.quit()
    end

    -- Zera as teclas que foram pressionadas e os botões do mouse para evitar ações indesejadas
    love.keyboard.updateKeys()
    -- Realiza a contagem do tempo
    count()
    for i = 1, #projectiles, 1 do
      x = projectiles[i].body:getLinearVelocity()
      if (x == 0) then
        projectiles[i].fixture:destroy()
        projectiles[i] = nil
      end
    end

    for i = 1, #enemies, 1 do
      x, y = enemies[i].body:getLinearVelocity()
      if (x == 0) then
        if (enemies[i].damageDt > 0.5) then
          castle.hp = castle.hp - 50
        end
      end
    end
  elseif (firstStageCleared == true) then
    firstStageClearedHistory = true
    incarnation_of_devil_radiata_version:stop()
  elseif (secondStageCleared == true) then
    secondStageClearedHistory = true
    incarnation_of_devil_radiata_version:stop()
  elseif (thirdStageCleared == true) then
    thirdStageClearedHistory = true
  elseif (makeAChoice == true) then
    if (love.keyboard.wasPressed("1")) then
      logoWasShowed = false
      iconeWasShowed = false
      introduction = false
      startGame = false
      transitionAlpha = 0
      makeAChoice = false
      rankingMode = false
      score = 0
      amountOfEnemies = 0
      startGameFadeHappened = false
      introAlphaIsSetted = false
      maxProjectileNumber = 0
      currentFrame = 0
      globalDt = 0
      spriteTransitionTime = 0
      nextLetterDt = 0
      nextProjectileDt = 0
      introSongPlayTime = 0
      monsterSpawnDt = 0
      isMonsterSpawning = true
      waitingDt = 0
      haveToWait = false
      introAlpha = 0
      timeToFadeOut = false
      fadeOutFirstStage = false
      doneFading = false
      enemiesDead = 0
      projectiles = {}
      enemies = {}
    elseif (love.keyboard.wasPressed("2")) then
      scarlet_wind:stop()
      rankingMode = true
      makeAChoice = false
      score = 0
      amountOfEnemies = 0
      maxProjectileNumber = 0
      globalDt = 0
      enemiesDead = 0
      player.activeWeapon = 1
      projectiles = {}
      enemies = {}
    end
  end
end

-- Função responsável por desenhar tudo o que existe na tela, é chamada sempre após o love.update(dt)
function love.draw()
  if (player.hp <= 0 or castle.hp <= 0) then
    if (rankingMode == false) then
      incarnation_of_devil_radiata_version:stop()
      love.graphics.setColor(0, 0, 0)
      love.graphics.rectangle('fill', 0, 0, windowWidth, windowHeight)
      love.graphics.setColor(255, 0, 0)
      love.graphics.print("Você falhou!", 128*constWidth, 128*constHeight, 0, 3, 3)
      love.graphics.print("Pressione esc para sair do jogo", 128*constWidth, 128*constHeight + 60, 0, 3, 3)
    else
      incarnation_of_devil_radiata_version:stop()
      if (nameCleared == false) then
        name = ''
        nameCleared = true
      end
      love.graphics.setColor(255, 0, 0)
      love.graphics.print("Você morreu!", 128*constWidth, 128*constHeight, 0, 3, 3)
      love.graphics.print("Sua pontuação foi: "..score, 128*constWidth, 128*constHeight + 60, 0, 3, 3)
      love.graphics.print("Entre com o seu nome:"..name, 128*constWidth, 128*constHeight + 120, 0, 3, 3)
    end
  elseif (makeAChoice == false) then

    local introductionText1 = ''
    local introductionText2 = ''
    local introductionText3 = ''
    local introductionText4 = ''
    local introductionText5 = ''
    local introductionText6 = ''
    if (logoWasShowed == false) then
      if (opinion_leader_s_values:isPlaying() == false) then
        if (scarlet_wind:isPlaying() == true) then
          scarlet_wind:stop()
        end
        opinion_leader_s_values:play()
      end
      love.graphics.setColor(255, 255, 255, introAlpha)
      love.graphics.draw(logo, 0, 0, 0, constWidth, constHeight)
      if (timeToFadeOut == false) then
        introAlpha = introAlpha + 1
        if (introAlpha == 255) then
          timeToFadeOut = true
        end
      elseif (timeToFadeOut == true) then
        introAlpha = introAlpha - 1
        if (introAlpha == 0) then
          logoWasShowed = true
          timeToFadeOut = false
          opinion_leader_s_values:stop()
        end
      end
    elseif (iconeWasShowed == false) then
      if (opinion_leader_s_values:isPlaying() == false) then
        opinion_leader_s_values:play()
      end
      love.graphics.setColor(255, 255, 255, introAlpha)
      love.graphics.draw(icone, 0, 0, 0, constWidth, constHeight)
      if (timeToFadeOut == false) then
        introAlpha = introAlpha + 1
        if (introAlpha == 255) then
          timeToFadeOut = true
        end
      elseif (timeToFadeOut == true) then
        introAlpha = introAlpha - 1
        if (introAlpha == 0) then
          iconeWasShowed = true
          timeToFadeOut = false
          introAlpha = 255
          opinion_leader_s_values:stop()
        end
      end
    elseif (introduction == false) then
      if (bloom_of_anxiety:isPlaying() == false) then
        bloom_of_anxiety:play()
      end
      if (introductionText2WasPrinted == true) then
        introAlpha = introAlpha - 5
        if (introAlpha == 0) then
          introduction = true
          bloom_of_anxiety:stop()
        end
      end
      if (nextLetterDt > 0.04 and lettersOnScreen1 ~= amountOfLetters1) then
        lettersOnScreen1 = lettersOnScreen1 + 1
        nextLetterDt = 0
        if (lettersOnScreen1 == amountOfLetters1) then
          introductionText1WasPrinted = true
        end
      end
      for i = 1, lettersOnScreen1, 1 do
        introductionText1 = introductionText1..introductionText1Table[i]
      end
      if ((nextLetterDt > 0.04 and lettersOnScreen2 ~= amountOfLetters2) and introductionText1WasPrinted == true) then
        lettersOnScreen2 = lettersOnScreen2 + 1
        nextLetterDt = 0
        if(lettersOnScreen2 == amountOfLetters2) then
          haveToWait = true
        end
      end
      for j = 1, lettersOnScreen2, 1 do
        introductionText2 = introductionText2..introductionText2Table[j]
      end
      love.graphics.setColor(120, 165, 230, introAlpha)
      love.graphics.print(introductionText1, 128*constWidth, 256*constHeight, 0, 2*constWidth, 2*constHeight)
      love.graphics.print(introductionText2, 128*constWidth, 256*constHeight + 40, 0, 2*constWidth, 2*constHeight)
      if (haveToWait == true and waitingDt > 5) then
        introductionText2WasPrinted = true
        haveToWait = false
        waitingDt = 0
      end
    elseif ((introduction == true and firstStageCleared == false and secondStageCleared == false and thirdStageCleared == false) or rankingMode == true) then
        love.graphics.rectangle('fill', 0, 0, windowWidth, windowHeight)
        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(background1, 0, 0, 0, constWidth, constHeight)

        if(incarnation_of_devil_radiata_version:isPlaying() == false) then
          incarnation_of_devil_radiata_version:play()
        end

        -- Pinta as bordas do mapa que impedem o jogador de sair da tela
        love.graphics.setColor(100, 100, 100)
        love.graphics.polygon("fill", invisibleLeftWall.body:getWorldPoints(invisibleLeftWall.shape:getPoints()))
        love.graphics.setColor(100, 100, 100)
        love.graphics.polygon("fill", invisibleRightWall.body:getWorldPoints(invisibleRightWall.shape:getPoints()))
        love.graphics.setColor(100, 100, 100)
        love.graphics.polygon("fill", invisibleCeiling.body:getWorldPoints(invisibleCeiling.shape:getPoints()))



        -- Pinta os inimigos presentes no jogo e a barra de vida acima de suas cabeças
        for i = 1, #enemies, 1 do
          if (enemies[i] ~= nil) then
            love.graphics.setColor(255, 255, 255)
            orcX, orcY = enemies[i].body:getWorldPoints(enemies[i].shape:getPoints())
          	love.graphics.draw(enemies[i].activeFrame, orcX, orcY, 0, 1.5, 1.5)

            love.graphics.setColor(255,0,0)
            local enemyX1, enemyY1, enemyX2, enemyY2, enemyX3, enemyY, enemyX4, enemyY4 = enemies[i].body:getWorldPoints(enemies[i].shape:getPoints())
            love.graphics.polygon("fill", enemyX1, (enemyY1 - 28*constHeight), enemyX1 , (enemyY1 - 20*constHeight), enemyX2, (enemyY1 - 20*constHeight), enemyX2, (enemyY1 - 28*constHeight))

            if enemies[i].hp > 0 then
           	  love.graphics.setColor(0,255,0)
           	  love.graphics.polygon("fill", enemyX1, (enemyY1 - 28*constHeight), enemyX1 , (enemyY1 - 20*constHeight), enemyX1 + (enemyX2-enemyX1)*enemies[i].hp/enemy.hpMax, (enemyY1 - 20*constHeight), enemyX1 + (enemyX2-enemyX1)*enemies[i].hp/enemy.hpMax, (enemyY1 - 28*constHeight))
            end
          end
        end

        love.graphics.setColor(255,0,0)
        local castleX1, castleY1, castleX2, castleY2, castleX3, castleY, castleX4, castleY4 = castle.body:getWorldPoints(castle.shape:getPoints())
        love.graphics.polygon("fill", castleX1, (castleY1 - 28*constHeight), castleX1 , (castleY1 - 20*constHeight), castleX2, (castleY1 - 20*constHeight), castleX2, (castleY1 - 28*constHeight))
        if castle.hp > 0 then
        love.graphics.setColor(0,255,0)
        love.graphics.polygon("fill", castleX1, (castleY1 - 28*constHeight), castleX1 , (castleY1 - 20*constHeight), castleX1 + (castleX2-castleX1)*castle.hp/castle.hpMax, (castleY1 - 20*constHeight), castleX1 + (castleX2-castleX1)*castle.hp/castle.hpMax, (castleY1 - 28*constHeight))
        end
        -- Pinta o jogador na tela e a sua barra de vida
        love.graphics.setColor(255, 255, 255)
        zukX, zukY = player.body:getWorldPoints(player.shape:getPoints())

        love.graphics.draw(activeFrame, zukX, zukY, 0, 0.1, 0.1)

        local playerX1, playerY1, playerX2, playerY2, playerX3, playerY, playerX4, playerY4 = player.body:getWorldPoints(player.shape:getPoints())
        love.graphics.setColor(255,0,0)
        love.graphics.polygon("fill", playerX1, (playerY1 - 28*constHeight), playerX1 , (playerY1 - 20*constHeight), playerX2, (playerY1 - 20*constHeight), playerX2, (playerY1 - 28*constHeight))

        if player.hp > 0 then
      		love.graphics.setColor(0,255,0)
      		love.graphics.polygon("fill", playerX1, (playerY1 - 28*constHeight), playerX1 , (playerY1 - 20*constHeight), playerX1 + (playerX2-playerX1)*player.hp/player.hpMax, (playerY1 - 20*constHeight), playerX1 + (playerX2-playerX1)*player.hp/player.hpMax, (playerY1 - 28*constHeight))
        end

        -- Pinta todos os projéteis presentes no jogo nos lugares certos
      	love.graphics.setColor(0, 0, 0)
      	for i = 1, #projectiles, 1 do
          if (projectiles[i].type == 1) then
        		love.graphics.polygon("fill", projectiles[i].body:getWorldPoints(projectiles[i].shape:getPoints()))
          elseif (projectiles[i].type == 2) then
            x1, y1 = projectiles[i].body:getPosition()
        		love.graphics.circle("fill", x1, y1, 17)
          end
      	end

        --interface do jogador
          --HUD do jogador
        love.graphics.setColor(1, 1, 1)
        love.graphics.polygon("fill", 25*constWidth, 25*constHeight, 25*constWidth, 185*constHeight, 175*constWidth, 185*constHeight,175*constWidth, 25*constHeight)
        love.graphics.setColor(150, 150, 150)
        love.graphics.polygon("fill", 25*constWidth, 25*constHeight, 25*constWidth, 50*constHeight, 175*constWidth, 50*constHeight, 175*constWidth, 25*constHeight)
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("Zuk", 40*constWidth, 30*constHeight )
        love.graphics.setColor(255, 0, 0)
          love.graphics.polygon("fill", 25*constWidth, 165*constHeight, 25*constWidth , 185*constHeight, 175*constWidth, 185*constHeight, 175*constWidth, 165*constHeight)

        if player.hp > 0 then
          love.graphics.setColor(0,255,0)
          love.graphics.polygon("fill", 25*constWidth, 165*constHeight, 25*constWidth , 185*constHeight, 25*constWidth + 150*player.hp/player.hpMax*constWidth, 185*constHeight, 25*constWidth + 150*player.hp/player.hpMax*constWidth, 165*constHeight)
        end
        love.graphics.setColor(0, 0, 0)
        if player.hp>=0 then
          love.graphics.print(player.hp.."/"..player.hpMax, 75*constWidth, 167*constHeight)
        else
          love.graphics.print("0/"..player.hpMax, 78*constWidth, 167*constHeight)
        end

          --Armas do jogador
        love.graphics.setColor(255,255,255)
        love.graphics.setLineWidth(8)
        if player.activeWeapon == 1 then
          love.graphics.circle("line", windowWidth - 320 , 70*constHeight , 40*constWidth)
        elseif player.activeWeapon == 2 then
          love.graphics.circle("line", windowWidth - 200 , 70*constHeight , 40*constWidth)
        elseif player.activeWeapon == 3 then
          love.graphics.circle("line", windowWidth - 80*constWidth , 70*constHeight ,40)
        end
        love.graphics.setColor(150,150,150)
        love.graphics.circle("fill", windowWidth - 80*constWidth , 70*constHeight , 40*constWidth)
        love.graphics.circle("fill", windowWidth - 200 , 70*constHeight , 40*constWidth)
        love.graphics.circle("fill", windowWidth - 320 , 70*constHeight , 40*constWidth)

        love.graphics.setColor(255, 255, 255, introAlpha)
        love.graphics.rectangle("fill", 0, 0, windowWidth, windowHeight)
        if (introAlphaIsSetted == false) then
          introAlpha = 255
          introAlphaIsSetted = true
          timeToFadeOut = true
        end
        if (startGameFadeHappened == false) then
          if (timeToFadeOut == true) then
            introAlpha = introAlpha - 5
            if (introAlpha == 0) then
              timeToFadeOut = false
              startGame = true
              startGameFadeHappened = true
              if(incarnation_of_devil_radiata_version:isPlaying()) then
                incarnation_of_devil_radiata_version:play()
              end
            end
          end
        end

        if (firstStageCleared == true or secondStageCleared == true or thirdStageCleared == true) then
          if (timeToFadeOut == false) then
            love.graphics.setColor(0, 0, 0, introAlpha)
            love.graphics.rectangle("fill", 0, 0, windowWidth, windowHeight)
            introAlpha = introAlpha + 5
            if (introAlpha == 255) then
              if (firstStageCleared == true) then
              elseif (secondStageCleared == true) then
              elseif (thirdStageCleared == true) then
                thirdStageClearedHistory = true
              end
            end
          end
        end
        -- Essas três linhas abaixo são usadas no processo de debugging
         love.graphics.setColor(255, 0, 0)
         --love.graphics.print(DEBUG_STRING_1, windowWidth/2, windowHeight/2)
         --love.graphics.print(DEBUG_STRING_2, windowWidth/2, windowHeight/2 + 30)
         love.graphics.print(DEBUG_STRING_3, windowWidth/2, windowHeight/2 + 120)
    elseif (firstStageCleared == true and firstStageClearedHistory == true) then
      if (fadeOutFirstStage == false) then
        if (introAlpha == 0 and doneFading == false) then
          introAlpha = 255
        end
        introAlpha = introAlpha - 5
        if (introAlpha == 0) then
          doneFading = true
        end
        if (the_boundary:isPlaying() == false) then
          the_boundary:play()
        end
        love.graphics.setColor(255, 255, 255, introAlpha)
        love.graphics.rectangle("fill", 0, 0, windowWidth, windowHeight)
        if (nextLetterDt > 0.04 and lettersOnScreen3 ~= amountOfLetters3 and doneFading == true) then
          lettersOnScreen3 = lettersOnScreen3 + 1

          nextLetterDt = 0
          if (lettersOnScreen3 == amountOfLetters3) then
            introductionText3WasPrinted = true
          end
        end
        for i = 1, lettersOnScreen3, 1 do
          introductionText3 = introductionText3..introductionText3Table[i]
        end
        if ((nextLetterDt > 0.04 and lettersOnScreen4 ~= amountOfLetters4) and introductionText3WasPrinted == true) then
          lettersOnScreen4 = lettersOnScreen4 + 1
          nextLetterDt = 0
          if(lettersOnScreen4 == amountOfLetters4) then
            haveToWait = true
          end
        end
        for j = 1, lettersOnScreen4, 1 do
          introductionText4 = introductionText4..introductionText4Table[j]
        end
        love.graphics.setColor(120, 165, 230)
        love.graphics.print(introductionText3, 128*constWidth, 256*constHeight, 0, 2*constWidth, 2*constHeight)
        love.graphics.print(introductionText4, 128*constWidth, 256*constHeight + 40, 0, 2*constWidth, 2*constHeight)
        if (haveToWait == true and waitingDt > 3) then
          introductionText4WasPrinted = true
          haveToWait = false
          waitingDt = 0
          firstStageCleared = false
          startGameFadeHappened = false
          introAlphaIsSetted = false
          amountOfEnemies = 0
          enemies = {}
          the_boundary:stop()
        end
      end
    elseif (secondStageCleared == true and secondStageClearedHistory == true) then
      if (fadeOutFirstStage == false) then
        if (introAlpha == 0 and doneFading == false) then
          introAlpha = 255
        end
        introAlpha = introAlpha - 5
        if (introAlpha == 0) then
          doneFading = true
        end
        if (something_that_are_not_between_human:isPlaying() == false) then
          something_that_are_not_between_human:play()
        end
        love.graphics.setColor(255, 255, 255, introAlpha)
        love.graphics.rectangle("fill", 0, 0, windowWidth, windowHeight)
        if (nextLetterDt > 0.04 and lettersOnScreen5 ~= amountOfLetters5 and doneFading == true) then
          lettersOnScreen5 = lettersOnScreen5 + 1

          nextLetterDt = 0
          if (lettersOnScreen5 == amountOfLetters5) then
            introductionText5WasPrinted = true
          end
        end
        for i = 1, lettersOnScreen5, 1 do
          introductionText5 = introductionText5..introductionText5Table[i]
        end
        if ((nextLetterDt > 0.04 and lettersOnScreen6 ~= amountOfLetters6) and introductionText5WasPrinted == true) then
          lettersOnScreen6 = lettersOnScreen6 + 1
          nextLetterDt = 0
          if(lettersOnScreen6 == amountOfLetters6) then
            haveToWait = true
          end
        end
        for j = 1, lettersOnScreen6, 1 do
          introductionText6 = introductionText6..introductionText6Table[j]
        end
        love.graphics.setColor(120, 165, 230)
        love.graphics.print(introductionText5, 256*constWidth, 256*constHeight, 0, 2*constWidth, 2*constHeight)
        love.graphics.print(introductionText6, 256*constWidth, 256*constHeight + 40, 0, 2*constWidth, 2*constHeight)
        if (haveToWait == true and waitingDt > 4) then
          introductionText6WasPrinted = true
          haveToWait = false
          waitingDt = 0
          startGameFadeHappened = false
          introAlphaIsSetted = false
          amountOfEnemies = 0
          enemies = {}
          something_that_are_not_between_human:stop()
          secondStageCleared = false
          makeAChoice = true
        end
      end
    elseif (thirdStageCleared == true and thirdStageClearedHistory == true) then

    end
  end
  if (makeAChoice == true) then
    if (scarlet_wind:isPlaying() == false) then
      scarlet_wind:play()
      scarlet_wind:setLooping(true)
    end
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle('line', 512*constWidth, 512*constHeight, 310, 100)
    love.graphics.print('Reiniciar o jogo (1)', 512*constWidth + 20, 512*constHeight + 20, 0, 1, 1)
    love.graphics.print('O jogo será carregado novamente do início', 512*constWidth + 20, 512*constHeight + 60, 0, 1, 1)
    love.graphics.rectangle('line', 512*constWidth + 600, 512*constHeight, 320, 100)
    love.graphics.print('Entrar no Modo Ranking (2)', 512*constWidth + 620, 512*constHeight + 20, 0 , 1, 1)
    love.graphics.print('Dispute o topo com outros alunos da PUC-Rio', 512*constWidth + 620, 512*constHeight + 60, 0, 1, 1)
    love.graphics.rectangle('line', 820*constWidth, 20*constHeight, 290, 400)
    love.graphics.print('Classificacao', 820*constWidth + 100, 20*constHeight + 20)
    love.graphics.print(nameTable[1], 820*constWidth + 10, 20*constHeight + 40)
    love.graphics.print(nameTable[2], 820*constWidth + 10, 20*constHeight + 60)
    love.graphics.print(nameTable[3], 820*constWidth + 10, 20*constHeight + 80)
    love.graphics.print(nameTable[4], 820*constWidth + 10, 20*constHeight + 100)
    love.graphics.print(nameTable[5], 820*constWidth + 10, 20*constHeight + 120)
    love.graphics.print(nameTable[6], 820*constWidth + 10, 20*constHeight + 140)
    love.graphics.print(nameTable[7], 820*constWidth + 10, 20*constHeight + 160)
    love.graphics.print(nameTable[8], 820*constWidth + 10, 20*constHeight + 180)
    love.graphics.print(nameTable[9], 820*constWidth + 10, 20*constHeight + 200)
    love.graphics.print(nameTable[10], 820*constWidth + 10, 20*constHeight + 220)
    love.graphics.print(nameTable[11], 820*constWidth + 10, 20*constHeight + 240)
    love.graphics.print(nameTable[12], 820*constWidth + 10, 20*constHeight + 260)
    love.graphics.print(nameTable[13], 820*constWidth + 10, 20*constHeight + 280)
    love.graphics.print(nameTable[14], 820*constWidth + 10, 20*constHeight + 300)
    love.graphics.print(nameTable[15], 820*constWidth + 10, 20*constHeight + 320)
    love.graphics.print(nameTable[16], 820*constWidth + 10, 20*constHeight + 340)
    love.graphics.print(nameTable[17], 820*constWidth + 10, 20*constHeight + 360)
    love.graphics.print(nameTable[18], 820*constWidth + 10, 20*constHeight + 380)

    love.graphics.print(scoreTable[1], 820*constWidth + 260, 20*constHeight + 40)
    love.graphics.print(scoreTable[2], 820*constWidth + 260, 20*constHeight + 60)
    love.graphics.print(scoreTable[3], 820*constWidth + 260, 20*constHeight + 80)
    love.graphics.print(scoreTable[4], 820*constWidth + 260, 20*constHeight + 100)
    love.graphics.print(scoreTable[5], 820*constWidth + 260, 20*constHeight + 120)
    love.graphics.print(scoreTable[6], 820*constWidth + 260, 20*constHeight + 140)
    love.graphics.print(scoreTable[7], 820*constWidth + 260, 20*constHeight + 160)
    love.graphics.print(scoreTable[8], 820*constWidth + 260, 20*constHeight + 180)
    love.graphics.print(scoreTable[9], 820*constWidth + 260, 20*constHeight + 200)
    love.graphics.print(scoreTable[10], 820*constWidth + 260, 20*constHeight + 220)
    love.graphics.print(scoreTable[11], 820*constWidth + 260, 20*constHeight + 240)
    love.graphics.print(scoreTable[12], 820*constWidth + 260, 20*constHeight + 260)
    love.graphics.print(scoreTable[13], 820*constWidth + 260, 20*constHeight + 280)
    love.graphics.print(scoreTable[14], 820*constWidth + 260, 20*constHeight + 300)
    love.graphics.print(scoreTable[15], 820*constWidth + 260, 20*constHeight + 320)
    love.graphics.print(scoreTable[16], 820*constWidth + 260, 20*constHeight + 340)
    love.graphics.print(scoreTable[17], 820*constWidth + 260, 20*constHeight + 360)
    love.graphics.print(scoreTable[18], 820*constWidth + 260, 20*constHeight + 380)
  end
end

-- Diz se alguma tecla foi pressionada no ultimo dt
function love.keyboard.wasPressed(key)
  if (love.keyboard.keysPressed[key]) then
    return true
  else
    return false
  end
end

-- Diz se alguma tecla foi solta no ultimo dt
function love.keyboard.wasReleased(key)
  if (love.keyboard.keysReleased[key]) then
    return true
  end
end

-- Adiciona esse código à callback love.keypressed se já existir
function love.keypressed(key, unicode)
  love.keyboard.keysPressed[key] = true

  if key == "backspace" then
    local byteoffset = utf8.offset(name, -1)
    if byteoffset then
      name = string.sub(name, 1, byteoffset - 1)
    end
  end
end

-- Adiciona esse código à callback love.keyreleased se já existir
function love.keyreleased(key)
  love.keyboard.keysReleased[key] = true
end

-- Armazena as informações referentes ao click do mouse e
-- adiciona esse código à callback love.mousepressed se já existir
function love.mousepressed(x, y, button, istouch)
  buttonClicked = {x = x, y = y, button = button}
end

-- Armazena as informações referentes ao botão do mouse que foi solto e
-- adiciona esse código à callback love.mousereleased se já existir
function love.mousereleased(x, y, button, istouch)
  buttonReleased = {x = x, y = y, button = button}
end

-- Chamada no final de todo love.update(dt) para resetar os botões que foram pressionados no ultimo dt
function love.keyboard.updateKeys()
  love.keyboard.keysPressed = { }
  love.keyboard.keysReleased = { }
  buttonClicked = { }
  buttonReleased = { }
end

-- Retorna a distância X e a distância Y do jogador até o mouse (pode retornar valores negativos)
function getRelativeMouseXYDistance()
  playerPositionX, playerPositionY = player.body:getPosition()
  mousePositionX, mousePositionY = love.mouse.getPosition()

  mouseDistanceX = mousePositionX - playerPositionX
  mouseDistanceY = mousePositionY - playerPositionY

  return mouseDistanceX, mouseDistanceY
end

-- Retorna a distância X do jogador até o mouse (pode retornar valores negativos)
function getRelativeMouseXDistance()
  playerPositionX = player.body:getX()
  mousePositionX = love.mouse.getX()

  mouseDistanceX = (mousePositionX - playerPositionX)

  return mouseDistanceX
end

-- Retorna a distância Y do jogador até o mouse (pode retornar valores negativos)
function getRelativeMouseYDistance()
  playerPositionY = player.body:getY()
  mousePositionY = love.mouse.getY()

  mouseDistanceX = (mousePositionX - playerPositionX)

  return mouseDistanceX
end

-- Retorna o angulo MÔX (M = mouse, Ô = Centro de massa do jogador, X = eixo X com início no CMJ)
function getRelativeMouseAngle()
  mouseDistanceX, mouseDistanceY = getRelativeMouseXYDistance()
  relativeMouseAngle = math.atan(mouseDistanceY/mouseDistanceX)

  return relativeMouseAngle
end

-- Aperfeiçoa o já existente método de aplicação de impulso linear
function applyBetterLinearImpulse(body, angle, impulse)
  mouseXDistance = getRelativeMouseXDistance()

  if (mouseXDistance >= 0) then
    xComponent = (math.cos(angle)*impulse)
    yComponent = (math.sin(angle)*impulse)

    body.body:applyLinearImpulse(xComponent, yComponent)
    elseif ( mouseXDistance < 0) then
      angle = math.pi - angle

      xComponent = (math.cos(angle)*impulse)
      yComponent = (math.sin(angle)*impulse)

      body.body:applyLinearImpulse(xComponent, -yComponent)
    end
end

-- Responsável pela contagem do tempo entre cada spawn de inimigo
function count()
	if (firstTime == 0) then
		firstTime = love.timer.getTime()
	else
		secondTime = love.timer.getTime()
		elapsedTime = secondTime - firstTime
	end
end

-- Retorna o tempo que passou entre as duas ultimas execuções do método count()
function getElapsedTime()
	return elapsedTime
end

-- Randomiza o spawn dos monstros (na esquerda ou na direita aleatóriamente)
function setRandomSpawn()
  math.randomseed(os.time())
	randomSpawn = math.random()
	if randomSpawn < 0.5 then
	   return  -200*constWidth
	elseif randomSpawn >= 0.5 then
	   return windowWidth + 200*constWidth
	end
	firstTime = secondTime
end

-- Faz com que o corpo passado no primeiro argumento persiga o corpo passado no segundo argumento
function chase(body1, body2)
  if (body1 ~= nil and body2 ~= nil) then
    xBody1, yBody1 = body1.body:getPosition()
    xBody2, yBody2 = body2.body:getPosition()
    xDist = xBody1 - xBody2

    local body1XLinearVelocity,body1YLinearVelocity = body1.body:getLinearVelocity()
    relativeForce = (1 - math.abs(body1XLinearVelocity/body1.speed))
    if xDist >= 50*constWidth then --persegue pra direita
      body1.body:applyForce(-relativeForce*50000*constWidth, 0)
      body1.facingDirection = 0
    end
    if xDist <= -50*constWidth then --persegue pra esquerda
      body1.body:applyForce(relativeForce*50000*constWidth, 0)
      body1.facingDirection = 1
    end
  end
end

-- Checagem de colisões (WIP)
function collisions(a, b, coll)
  aName = a:getUserData()
  bName = b:getUserData()

  -- Colisões de todos os inimigos com o jogador
  if (#enemies ~= 0) then
    if ((aName == player.fixture:getUserData()) or (bName == player.fixture:getUserData())) then
      for i = 1, #enemies, 1 do
        if (enemies[i] ~= nil) then
          if ((aName == enemies[i].fixture:getUserData()) or (bName == enemies[i].fixture:getUserData())) then
            local playerX, playerY = player.body:getPosition()
            local enemyX, enemyY = enemies[i].body:getPosition()
            if (playerX > enemyX) then
              player.body:setLinearVelocity(250*constWidth,-200*constHeight)
              player.hp = player.hp - 20
            elseif playerX < enemyX then
              player.body:setLinearVelocity(-250*constWidth,-200*constHeight)
              player.hp = player.hp - 20
            end
          end
        end
      end
    end
  end

  -- Colisões de todas as balas com todos os inimigos
  for i = 1, #enemies, 1 do
    for j = 1, #projectiles, 1 do
      if (enemies[i] ~= nil and projectiles[j] ~= nil) then
        if ((aName == enemies[i].fixture:getUserData() and bName == projectiles[j].fixture:getUserData()) or (aName == projectiles[j].fixture:getUserData() and bName == enemies[i].fixture:getUserData())) then
          if (projectiles[j].type == 1) then
            enemies[i].hp = (enemies[i].hp - player.arrowDamage)
            projectiles[j].fixture:destroy()
            projectiles[j] = nil
            table.remove(projectiles, j)
            if (enemies[i].hp <= 0) then
              enemies[i].isDead = true
              break
            end
          elseif (projectiles[j].type == 2) then
            enemies[i].hp = (enemies[i].hp - 10)
            projectiles[j].fixture:destroy()
            table.remove(projectiles, j)
            if(enemies[i].isFrozen == false) then
              enemies[i].isFrozen = true
              enemies[i].speed = enemies[i].speed*0.5
            end
            if (enemies[i].hp <= 0) then
              enemy[i].isDead = true
              break
            end
          end
        end
      end
    end
  end

  -- Checa colisão dos projéteis com os limites do mapa
  for i = 1, #projectiles, 1 do
    if (projectiles[i] ~= nil) then
      if (aName == projectiles[i].fixture:getUserData()) then
        if (bName == ground.fixture:getUserData() or bName == invisibleLeftWall.fixture:getUserData() or bName == invisibleRightWall.fixture:getUserData() or bName == invisibleCeiling.fixture:getUserData()) then
          projectiles[i].fixture:destroy()
          projectiles[i] = nil
          table.remove(projectiles, i)
        end
      elseif (aName == ground.fixture:getUserData() or aName == invisibleLeftWall.fixture:getUserData() or aName == invisibleRightWall.fixture:getUserData() or aName == invisibleCeiling.fixture:getUserData()) then
        if (bName == projectiles[i].fixture:getUserData()) then
          projectiles[i].fixture:destroy()
          projectiles[i] = nil
          table.remove(projectiles, i)
        end
      end
    end
  end

  for i = 1, #enemies, 1 do
    if ((aName == enemies[i].fixture:getUserData() and bName == "Castle") or (aName =="Castle" and bName == enemies[i].fixture:getUserData())) then
      castle.hp = castle.hp - 100
    end
  end
  collisionsWereChecked = true
  DEBUG_STRING_1 = 'true'
end

function setArrowAngle(projectile)
  local vx, vy = projectile.body:getLinearVelocity()
  return math.atan2(vy,vx)
end

function sweepDeadBodies()
  for i = #enemies, 1, -1 do
    if (enemies[i] ~= nil) then
      if (enemies[i].isDead == true) then
        enemies[i].fixture:destroy()
        enemies[i] = nil
        table.remove(enemies, i)
        enemiesDead = enemiesDead + 1
        if (rankingMode == true) then
          score = enemiesDead
        elseif (firstStageClearedHistory == false) then
          firstStageEnemies = firstStageEnemies - 1
          DEBUG_STRING_3 = firstStageEnemies
          if (firstStageEnemies == 0) then
            firstStageCleared = true
          end
        elseif (secondStageClearedHistory == false) then
          secondStageEnemies = secondStageEnemies - 1
          if (secondStageEnemies == 0) then
            secondStageCleared = true
          end
        end
      end
    end
  end
end

function love.textinput(t)
    name = name .. t
end

--[[function saveScoreToFile(name, score)
  if (not love.filesystem.exists('scores')) then
    love.filesystem.setIdentity("monkey_doom_2")
    scoresFile = love.filesystem.newFile('scores.lua')
    love.filesystem.open(scoresFile)
    love.filesystem.write(scoresFile, name..score)
    love.filesystem.close(scoresFile)
  else
    love.filesystem.setIdentity("monkey_doom_2")
    love.filesystem.append('scores.lua', name..score, 16)
  end
end]]
