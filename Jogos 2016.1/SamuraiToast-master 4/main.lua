local menu = require "menu"
local utf8 = require "utf8"
local gamera = require "gamera"
local scoreslib = require "scoreslib"
local isDown = love.keyboard.isDown
local min, max = math.min, math.max

local function updateTarget(dt)
  enemy.pos_x, enemy.pos_y = cam:toWorld(love.mouse.getPosition())
end

local function updateCameras(dt)
  cam:setPosition(hero.pos_x, hero.pos_y)
  local scaleFactor = isDown('home') and -0.8 or (isDown('end') and 0.8 or 0)
  cam:setScale(cam:getScale() + scaleFactor * dt)

  --[[local angleFactor = isDown("3") and -0.8 or (isDown("4") and 0.8 or 0)
  cam:setAngle(cam:getAngle() + angleFactor * dt)]]
end

function gameReset()
  hero.life = 250
  hero.pos_x = 700
  hero.pos_y = 700
  hero.score = 0
  hero.velocidade = 160
  table.remove(shots)
  table.remove(enemy)
  table.remove(powers)
end


function love.load()
  pausado = love.graphics.newImage("menu/paused.png")
  pause = love.graphics.newImage("menu/pause.jpg")
  leaderboard = love.graphics.newImage("menu/leaderboard.png")
  boss3 = love.graphics.newImage("enemies/boss3.png")
  boss2 = love.graphics.newImage("enemies/boss2.png")

  boss = { 
    life = 10 ,
    velocidade = 50 ,
    frame = 1 ,
    on = false ,  
    anim_time = 0 ,
    pos_y = love.math.random(1,1000),
    pos_x = love.math.random(1,1000),
    shoot_time 
  }



  scoreslib.loadHighscores("highscores.txt",5)

  mundo = {
    largura = 1200,
    altura = 1200
  }

  telagameover = love.graphics.newImage("mapa/telagameover.jpg")
  gameover = "Game Over"

  cam = gamera.new(0, 0,mundo.largura,mundo.altura)
  cam:setWindow(0,0,800,600)

  horadoshow = love.audio.newSource("sons/horadoshow.mp3","stream")
  gamesong = love.audio.newSource("sons/pandapo.mp3", "stream")

  shuriken = {
    love.audio.newSource("sons/shuriken1.mp3", "stream") ,
    love.audio.newSource("sons/shuriken2.mp3", "stream")
  }

  enemy1 = love.audio.newSource("sons/die1.mp3", "stream") 
  tasaino = love.audio.newSource("sons/tasaino.mp3","stream")
  grito = love.audio.newSource("sons/grito.mp3","stream")
  comimuito = love.audio.newSource("sons/comimuito.mp3","stream")
  boribilder = love.audio.newSource("sons/boribilder.mp3","stream")
  biur = love.audio.newSource("sons/biur.mp3","stream")
  ajuda = love.audio.newSource("sons/ajuda.mp3","stream")
  nyan = love.audio.newSource("sons/nyan.mp3","stream")
  samuraimenu = love.graphics.newImage ("menu/samuraimenu.png")
  fonte = love.graphics.newFont("fontes/fonteninja.ttf",40)
  gamestate = "menu"
  menu = love.graphics.newImage("menu/backgroundi.png")

  LoadMap("mapa/mapa.txt") -- chama funcao Load Map que carrega mapa do jogo vindo do arquivo txt
  LoadTiles("mapa/sheet.png",13,8)

  for x = 1, 12, 1 do -- carrega instancia "walk" da tabela "hero" com imagens da caminhada do heroi
    hero.walk[x] = love.graphics.newImage("hero/hero0" .. x .. ".png")
  end

-- Butoes

  if gamestate == "menu" then
    button_spawn(390,300,"Start","start")
    button_spawn(10,550,"Quit","sair")
  end

  timer= 0 
  momento = os.time()
  passado = 0 
  intervalo = 3
  count = 0 

end

function love.mousepressed(x,y)
  if gamestate == "menu" or gamestate == "gameover" or gamestate == "leaderboard" or gamestate == "jogando" or gamestate == "pause" then
    button_click(x,y)
  end
end





function love.update(dt)

  if gamestate == "pause" then
    button_clear()
    button_spawn(50,500,"Resume","resume")
    button_spawn(350,500,"Menu","menu")
    button_spawn(650,500,"Quit","sair")
  end 


  if gamestate == "leaderboard" then
    button_clear()
    button_spawn(620,530,"Restart","restart")
    button_spawn(50,530,"Quit","sair")
    button_draw()
  end

  if love.keyboard.isDown("backspace") then
    local byteoffset = utf8.offset(hero.name, -1)
    if byteoffset then
      hero.name = string.sub(hero.name, 1, byteoffset - 1)
    end
  end

  if gamestate == "gameover" then
    button_clear()
    gameReset()
    button_spawn(620,530,"Restart","restart")
    button_spawn(50,530,"Quit","sair")
    button_spawn(260,530,"Leaderboard","leaderboard")

    button_draw()
  end

  updateCameras(dt)
  updateTarget(dt)


  mousex = love.mouse.getX()
  mousey = love.mouse.getY()

  if gamestate == "menu" or gamestate== "gameover" then
    if love.keyboard.isDown("return") then
      gamestate = "jogando"
    end 
    button_check()
  end

  if gamestate == "jogando" then
    button_clear()
    button_spawn(650,100,"PAUSE","pause")
    momento = os.time() 

    enemyGenerator()  

    hero.shot = hero.shot - dt

    if love.keyboard.isDown("right") then
      hero.pos_x = hero.pos_x + (hero.velocidade * dt)
      hero.anim_time = hero.anim_time + dt -- incrementa o tempo usando dt
      if hero.anim_time > 0.1 then -- quando acumular mais de 0.1
        hero.anim_frame = hero.anim_frame + 1 -- avança para proximo frame
        if hero.anim_frame > 4 then 
          hero.anim_frame = 1
        end
        hero.anim_time = 0 -- reinicializa a contagem do tempo
      end
    end

    if love.keyboard.isDown("left") then
      hero.pos_x = hero.pos_x - (hero.velocidade * dt)
      hero.anim_time = hero.anim_time + dt -- incrementa o tempo usando dt
      if hero.anim_time > 0.1 then -- quando acumular mais de 0.1
        hero.anim_frame = hero.anim_frame + 1 -- avança para proximo frame
        if hero.anim_frame<5 or hero.anim_frame > 8 then 
          hero.anim_frame = 5
        end
        hero.anim_time = 0 -- reinicializa a contagem do tempo
      end
    end

    if love.keyboard.isDown("down") then
      hero.pos_y = hero.pos_y + (hero.velocidade * dt)
      hero.anim_time = hero.anim_time + dt -- incrementa o tempo usando dt
      if hero.anim_time > 0.1 then -- quando acumular mais de 0.1
        hero.anim_frame = hero.anim_frame + 1 -- avança para proximo frame
        if hero.anim_frame<5 or hero.anim_frame > 8 then 
          hero.anim_frame = 5
        end
        hero.anim_time = 0 -- reinicializa a contagem do tempo
      end
    end

    if love.keyboard.isDown("up") then
      hero.pos_y = hero.pos_y - (hero.velocidade * dt)
      hero.anim_time = hero.anim_time + dt -- incrementa o tempo usando dt
      if hero.anim_time > 0.1 then -- quando acumular mais de 0.1
        hero.anim_frame = hero.anim_frame + 1 -- avança para proximo frame
        if hero.anim_frame<8 or hero.anim_frame > 12 then 
          hero.anim_frame = 9
        end
        hero.anim_time = 0 -- reinicializa a contagem do tempo
      end
    end

    local dist_x= 1 
    local dist_y= 1

    for i,v in ipairs(enemy) do
      if v.tipo == "onion" then
        v.anim_time = v.anim_time + dt 
        if v.anim_time > 0.2 then 
          v.frame = v.frame +1 
          if v.frame > 2 then 
            v.frame=1
          end 
          v.anim_time= 0 
        end 
      end 

      for i , v in ipairs(enemy) do
        for j= i+1, #enemy-1 do 
          if checkCol(enemy[j].pos_x, enemy[j].pos_y, 3, 3, v.pos_x, v.pos_y, 3, 3) then 
            v.pos_x = v.pos_x + love.math.random(3,10) 
            v.pos_y = v.pos_y + love.math.random(3, 10) 
          end 
        end 
      end 
      dist_x= hero.pos_x - v.pos_x
      dist_y= hero.pos_y - v.pos_y
      if dist_x <= 0 then
        v.pos_x = v.pos_x - (80 *dt) 
      end 
      if dist_y  <= 0  then 
        v.pos_y = v.pos_y - (80 *dt) 
      end 
      if dist_x >= 0  then     
        v.pos_x = v.pos_x + (80 *dt) 
      end
      if dist_y >= 0  then     
        v.pos_y = v.pos_y + (80 *dt) 
      end 
    end

    for j,s in ipairs(shots) do  -- percorre todas instancias da tabela shots
      s.pos_x = s.pos_x + s.dir_x * ( s.vel * dt ) 
      s.pos_y = s.pos_y + s.dir_y * ( s.vel * dt ) 
    end 

    for j,s in ipairs(shots) do  -- checa colisao de inimigos com o shot 
      for i,v in ipairs(enemy) do   
        if  checkCol(s.pos_x, s.pos_y, s.img:getWidth()/2, s.img:getHeight()/2, v.pos_x, v.pos_y, v.img[1]:getWidth()/2, v.img[1]:getHeight()/2)  then -- checando shots com inimigos 
          table.remove(enemy, i)
          love.audio.play(enemy1)
          hero.score = hero.score + 1 
          table.remove(shots, j)
        end
      end 
    end 

    for i,v in ipairs(enemy) do -- percorre tabela de inimigos checa cada um com o heroi 
      if checkCol(hero.pos_x - hero.walk[hero.anim_frame]:getWidth()/2, hero.pos_y - hero.walk[hero.anim_frame]:getHeight()/2, hero.walk[hero.anim_frame]:getWidth(),hero.walk[hero.anim_frame]:getHeight(),
        v.pos_x - v.img[1]:getWidth()/2 , v.pos_y - v.img[1]:getHeight()/2 , v.img[1]:getWidth(), v.img[1]:getHeight()) then -- checando hero com inimigos  
        hero.life = hero.life -  (hero.damage*dt)
      end
    end 

    for i,v in ipairs(shots) do  -- remove shots que alcancam as extremidades da tela 
      if v.pos_x >= mundo.largura  then
        table.remove(shots, i ) 
      elseif v.pos_x <= 0 then 
        table.remove(shots, i)
      end 
      if v.pos_y >= mundo.altura then 
        table.remove(shots, i ) 
      elseif v.pos_y <= 0 then
        table.remove(shots, i)
      end 
    end 

    timer = timer + 1
    --ALGORITMO DE RANDOM PARA GERAR POWER UPS ***MODIFICAR***
    if  timer%50 == 0 then 
      if love.math.random(1,2) == 2 then 
        power()
      end 
    end 

    if hero.name == "mano" or hero.name == "MANO" or hero.name == "bruna" or hero.name == "BRUNA" then
      hero.life = 9999
      hero.velocidade = 2000
      hero.score = 999999
      hero.cooldown = 0.01
    end



    for i,v in ipairs(powers) do -- percorre tabela de powers checa cada um com o heroi 
      if checkCol(hero.pos_x, hero.pos_y, hero.walk[hero.anim_frame]:getWidth()/2,hero.walk[hero.anim_frame]:getHeight()/2,v.pos_x, v.pos_y, v.img:getWidth()/2, v.img:getHeight()/2) then -- checando hero com powers  
        if v.tipo == 1 then -- SE POWER 1 FOI PEGO (de forca) 
          force = true 
          force_timer = timer 
        elseif v.tipo == 2 then  -- SE POWER 2 FOI PEGO AUMENTA A VIDA 
          if hero.life < 400 then
            hero.life = hero.life + 50
          end 
        else   -- SE POWER 3 FOI PEGO(de velocidade) 
          run = timer
          vel = true 
        end 
        table.remove(powers, i ) 
      end
    end 

    if force == true then -- TEMPO DE DURACAO DO POWER UP 1 (forca) 
      hero.damage = 10 
      if (timer - force_timer > 300) then 
        hero.damage = 40 
        force = false 
      end 
    end 

    if vel == true then  -- TEMPO DE DURACAO DO POWER UP 3 (velocidadee) 
      hero.velocidade =  300
      for i,v in ipairs(shots) do  
        v.vel = 390 
      end 
      if (timer - run > 300) then 
        hero.velocidade = 120 
        for i,v in ipairs(shots) do  
          v.vel = 230 
        end 
        vel = false 
      end 
    end 


    for i,v in ipairs(powers) do -- retira power ups que nao foram pegos da tela 
      v.time = v.time+ dt*10 
      if( v.time > 1000) then 
        table.remove(powers ,i ) 
      end 
    end 



    if hero.score%50==0 and hero.score>0 then -- se o heroi ating 50 o BOSS eh ativado
      boss.on = true 
    end 
  end 

  dist_x= 1 
  dist_y= 1 

  if boss.on == true then 
    dist_x= hero.pos_x - boss.pos_x    -- faz inimigo perseguir o heroi checando pos heroi e do inimigo 
    dist_y= hero.pos_y - boss.pos_y
    if dist_x <= 0 then
      boss.pos_x = boss.pos_x - (boss.velocidade *dt) 
    end 
    if dist_y  <= 0  then 
      boss.pos_y = boss.pos_y - (boss.velocidade *dt) 
    end 
    if dist_x >= 0  then     
      boss.pos_x = boss.pos_x + (boss.velocidade *dt) 
    end
    if dist_y >= 0  then     
      boss.pos_y = boss.pos_y + (boss.velocidade *dt) 
    end 

if checkCol(hero.pos_x - hero.walk[hero.anim_frame]:getWidth()/2, hero.pos_y - hero.walk[hero.anim_frame]:getHeight()/2, hero.walk[hero.anim_frame]:getWidth(),hero.walk[hero.anim_frame]:getHeight(),boss.pos_x - boss3:getWidth()/2, boss.pos_y - boss3:getHeight()/2, boss3:getWidth(), boss3:getHeight()) then -- checando hero com boss  
        hero.life = hero.life -  (hero.damage*dt) --tira life do hero
  end
      
for j,s in ipairs(shots) do
  if  checkCol(s.pos_x, s.pos_y, s.img:getWidth()/2, s.img:getHeight()/2, boss.pos_x, boss.pos_y, boss3:getWidth()/2, boss3:getHeight()/2)  then -- checando shots com inimigos 
    table.remove(shots, j)
    love.audio.play(enemy1)
    boss.life = boss.life - 1 
    end 
    if boss.life<=0 then 
      boss.on = false 
      hero.score = hero.score + 20 
      boss.life = 10 
    end
    end 
  end 

  for i,v in ipairs(powers) do -- percorre tabela de powers checa cada um com o heroi 
    if checkCol(hero.pos_x, hero.pos_y, hero.walk[hero.anim_frame]:getWidth()/2,hero.walk[hero.anim_frame]:           getHeight()/2,v.pos_x, v.pos_y, v.img:getWidth()/2, v.img:getHeight()/2) then -- checando hero com powers  
      if v.tipo == 1 then -- SE POWER 1 FOI PEGO 
        force = true 
      elseif v.tipo == 2 then  -- SE POWER 2 FOI PEGO AUMENTA A VIDA 
        if hero.life < 380 then
          hero.life = hero.life + 20
        end 
      else   -- SE POWER 3 FOI PEGO VARIAVEL VEL EH VERDADEIRA 
        run = timer
        vel = true 
      end 
      table.remove(powers, i ) 
    end
  end 

  if vel == true then  -- SE O POWER UP 3 FOI PEGO AUMNTA VELOCIDADE DO HEROI E DOS SHOTS 
    hero.velocidade =  300
    for i,v in ipairs(shots) do  
      v.vel = 370 
    end 
    if (timer - run > 300) then 
      hero.velocidade = 120 
      for i,v in ipairs(shots) do  
        v.vel = 230 
      end 
      vel = false 
    end
  else 
    love.audio.pause(gamesong)
  end

  for i,v in ipairs(powers) do 
    v.time = v.time+ dt*10 
    if( v.time > 1000) then 
      table.remove(powers ,i ) 
    end 
  end 


  

  if hero.life < 1 then
    scoreslib.addHighscore(hero.name,hero.score)
    scoreslib.saveHighscores("highscores.txt")
    gamestate = "gameover"
  end
end 

powers={} 

function power()
  tipo = love.math.random(1,3) -- 3 tipos de power ups 

  if tipo ==1 then 
    img = love.graphics.newImage("hero/star.png") -- imune a dano 
  elseif tipo== 2 then 
    img = love.graphics.newImage("hero/life.png") -- aumenta vida 
  else 
    img = love.graphics.newImage("hero/raio.png") -- aumenta velocidade 
  end 
  table.insert(powers , {img = img , tipo = tipo , pos_x = love.math.random(0,mundo.altura) , pos_y= love.math.random(0,mundo.largura), time=0} )
end 

love.keyboard.keysPressed = { }
love.keyboard.keysReleased = { }

-- returns if specified key was pressed since the last update

function love.keyboard.wasPressed(key)
  if (love.keyboard.keysPressed[key]) then
    return true
  else
    return false
  end
end

-- returns if specified key was released since last update

function love.keyboard.wasReleased(key)
  if (love.keyboard.keysReleased[key]) then
    return true
  else
    return false
  end
end

-- concatenate this to existing love.keypressed callback, if any

function love.keypressed(key, unicode)
  love.keyboard.keysPressed[key] = true
end

-- concatenate this to existing love.keyreleased callback, if any

function love.keyreleased(key)
  love.keyboard.keysReleased[key] = true
end

-- call in end of each love.update to reset lists of pressed\released keys

function love.keyboard.updateKeys()
  love.keyboard.keysPressed = { }
  love.keyboard.keysReleased = { }
end

hero= { 
  anim_frame= 1 , 
  walk = {} ,
  pos_x = 700  , 
  pos_y= 700  , 
  velocidade = 160  ,
  anim_time=0, 
  cooldown = 0.4,
  shot = 0,
  life = 250, 
  name = "",
  nameinput = "on",
  score = 0,
  damage = 40 
}

function love.textinput(t)

  if hero.nameinput == "on" then
    hero.name = hero.name .. t
  end
  if hero.nameinput == "off" then
    hero.name = hero.name
  end
end

local tilesetImage
local tileQuads = {}
local tileSize = 16

function LoadTiles(filename, nx, ny)
  tilesetImage = love.graphics.newImage(filename)
  local count = 1
  for i = 0, nx, 1 do
    for j = 0, ny, 1 do
      tileQuads[count] = love.graphics.newQuad(i * tileSize ,j * tileSize, tileSize, tileSize,tilesetImage:getWidth(), tilesetImage:getHeight())
      count = count + 1
    end
  end
end

local mapa={} 

function LoadMap(filename)
  local file = io.open(filename)
  local i = 1
  for line in file:lines() do
    mapa[i] = {}
    for j=1, #line, 1 do
      mapa[i][j] = line:sub(j,j)
    end
    i = i + 1
  end
  file:close()
end

enemy= {} --tabela com todos os inimigos do jogo

function enemy.spawn() --insert elements on enemy table 
  tipo = love.math.random (1,2) -- dois tipos de inimigos 

  sp = love.math.random(0,1)  -- dEfinem de qual margem da tela inimigos irao surgir 
  sp2 = love.math.random(0,1) 
  if (sp == 1) then 
    if (sp2 == 1 ) then 
      x= love.math.random(0,1000)
      y=0
    else 
      x= love.math.random(0,1000)
      y=600
    end 
  else
    if (sp2 == 1 ) then 
      x= 0
      y= love.math.random(0,1000)
    else 
      x= 800
      y= love.math.random(0,1000)
    end 
  end 

  table.insert(enemy, {pos_x=x, pos_y=y, tipo=tipo, anim_time=0, img={}, frame=1}) -- cria nova instancia de enemy 

  for i, v in ipairs(enemy) do --carrega imagens de acordo com o tipo de inimigo 
    if v.tipo == 1 then         -- DETERMINAR INIMIGO TIPO 1 
      v.img[1] = love.graphics.newImage("enemies/onion1.png") 
      v.img[2] = love.graphics.newImage("enemies/onion2.png")

    elseif v.tipo == 2  then  
      v.img[1] = love.graphics.newImage("enemies/carrot1.png") 
      v.img[2] = love.graphics.newImage("enemies/carrot2.png")
    end 
  end 
end

function enemyGenerator() 
  momento = os.time() 

  if (momento - passado) > intervalo then 
    enemy.spawn() 

    passado = os.time() 
    count = count + 1 
    if math.mod( count, 5 ) == 0 then
      intervalo = intervalo - 0.5 
      if intervalo <=  0.5 then 
        intervalo = 0.6 
      end  
    end 
  end 
end 

shots = {}  -- table with all shurikens 

function shoot(x, y , dirx, diry) -- makes shuriken appear on the screen from pont where hero faces
  table.insert ( shots, {img = love.graphics.newImage("hero/shot.png"), pos_x = x, pos_y = y , 
      dir_x = dirx,   dir_y=diry,collision = false, vel = 230}) 
  --love.audio.play(shuriken[love.math.random(1,2)])
  love.audio.play(biur)
end 

function checkCol( x1, y1, w1,h1, x2,y2,w2,h2) 
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end 

-------------------------------------------------------------------------

function love.draw()

  if boss.on == true then 
    love.graphics.draw(--[[boss.walk[boss.frame]]boss3,boss.pos_y, boss.pos_x, 0, 1, 1 ,--[[boss.walk[boss.frame]]boss3:getWidth()/2, --[[boss.walk[boss.frame]]boss3:getHeight()/2)
  end 

  cam:draw(function(l,t,w,h)

      if gamestate == "jogando" then
         love.audio.play(gamesong , { channel=0, loops=-1, fadein=5000 } )
        for i=1, 75 , 1 do --Percorre a matriz e desenha quadrados imagens
          for j=1, 88, 1 do
            if (mapa[i][j] == "G") then 
              love.graphics.draw(tilesetImage, tileQuads[60], (j * tileSize) - tileSize, (i * tileSize) - tileSize)
            elseif (mapa[i][j] == "D") then
              love.graphics.draw(love.graphics.newImage("hero/tree.png"),(j * tileSize) - tileSize, (i * tileSize) - tileSize)
            elseif (mapa[i][j] == "C") then
              love.graphics.draw(tilesetImage, tileQuads[7], (j * tileSize) - tileSize, (i * tileSize) - tileSize)
            elseif (mapa[i][j] == "P") then
              love.graphics.draw(tilesetImage, tileQuads[8],(j * tileSize) - tileSize, (i * tileSize) - tileSize)
            elseif (mapa[i][j] == "B") then
              love.graphics.draw(tilesetImage, tileQuads[6],(j * tileSize) - tileSize, (i * tileSize) - tileSize)
            end
          end
        end

        love.graphics.setColor(255, 255, 255)
        
        
        if boss.on == true then 
          love.graphics.draw( boss3 , boss.pos_x, boss.pos_y, 0, 1 , 1 , boss3:getWidth()/2 , boss3:getHeight()/2)
          end 
        
        love.graphics.draw(hero.walk[hero.anim_frame], hero.pos_x ,  -- desenha heroi
          hero.pos_y, 0,1,1, hero.walk[hero.anim_frame]:getWidth()/2, hero.walk[hero.anim_frame]:getHeight()/2 )
        

        for i,v in ipairs(enemy) do
          love.graphics.draw( v.img[v.frame] , v.pos_x, v.pos_y)   -- draws enemies onscreen 
        end

        local dir_y= 0  -- control shuriken aiming through hero frame
        local dir_x= 0 
         while (love.keyboard.isDown("space")) and hero.shot <=0 do
        if love.keyboard.isDown("up") or love.keyboard.isDown("down") or love.keyboard.isDown("left") or love.keyboard.isDown("right") then 
         if  love.keyboard.isDown("up") then -- Up 
            dir_y = -1 
          end 
          if  love.keyboard.isDown("down") then  -- Down
            dir_y = 1 
          end 
          if  love.keyboard.isDown("left") then  -- Left 
            dir_x= -1
          end 
          if  love.keyboard.isDown("right") then  -- Righ 
            dir_x= 1   
          end     
        else
          if hero.anim_frame <=4 then 
            dir_x = 1 
          elseif hero.anim_frame>4 and hero.anim_frame <=8 then 
            dir_x = -1 
          elseif hero.anim_frame>8 and hero.anim_frame <=12 then 
           dir_y = -1 
          end 
        end 
          shoot(hero.pos_x, hero.pos_y, dir_x , dir_y ) 
          hero.shot = hero.cooldown
        end 
        for i, v in pairs(shots) do 
          love.graphics.draw( v.img, v.pos_x, v.pos_y, (v.pos_x + v.pos_y)*1/2 , 1.3 ,1.3 , v.img:getWidth()/2, v.img:getHeight()/2 )  -- desenha shots    
          love.keyboard.updateKeys()
        end 

        for i, v in pairs(powers) do  -- desenha power ups  
          love.graphics.draw( v.img, v.pos_x, v.pos_y, 0 , 1 ,1, v.img:getWidth()/2, v.img:getHeight()/2 )   
        end 
        love.graphics.setColor(255,255,255)
        love.graphics.setFont(fonte,50)
      end 
    end)

  if gamestate == "jogando" then
    button_draw()
    love.graphics.print(hero.name, 350,20)
    if vel == true then 
      love.graphics.setColor(0,100,0)
    else 
      love.graphics.setColor(100,0,0)
    end 
    love.graphics.rectangle("fill", 10, 15, hero.life ,15) -- desenha barra de vida 
    love.graphics.setColor(255,255,255)
    love.graphics.print(hero.score, 700, 10 ) 
  end

  if force == true then 
    love.graphics.setColor(0,0,255)
    love.graphics.rectangle("fill", 10, 85, 300+(force_timer-timer) ,15)
  end 
  love.graphics.setColor(255, 255, 255) 
  if vel == true then 
    love.graphics.setColor(255,255,0)
    love.graphics.rectangle("fill", 10, 65, 300+(run-timer) ,15)
  end 
  love.graphics.setColor(255, 255, 255) 

  if gamestate == "gameover" then
    vel = false 
    force = false 
    love.graphics.setNewFont("fontes/fonteninja.ttf",90)
    love.graphics.draw(telagameover,0,0)
    love.graphics.print(gameover,150,20)
    button_draw()

  end

  function love.keypressed(key)
    if love.keyboard.isDown("return") then 
      hero.nameinput = "off"
    end
    if love.keyboard.isDown("escape") and hero.nameinput == "off" then
      love.event.quit()
    end
    
     if love.keyboard.isDown("p") and hero.nameinput == "off" then
      gamestate = "pause"
    end
    if love.keyboard.isDown('n') and hero.nameinput == "off" then
      hero.nameinput = "on"
    end
  end

  if gamestate == "pause" then
    love.graphics.draw(pause,0,0)
    love.graphics.draw(pausado,250,100)
    button_draw()
  end 

  if gamestate == "leaderboard" then
    love.graphics.draw(leaderboard,0,0)
    love.graphics.newFont("fontes/fonteninja.ttf",40)
    scoreslib.draw()
    button_draw()
  end

  if gamestate == "menu" then
    love.graphics.draw(menu,0,0,ox,1.35)
    love.graphics.draw(samuraimenu,140,50)
    button_draw()
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill",190,200,500,80)
    love.graphics.setColor(242,126,24)
    love.graphics.print("De um nome para a sua torrada Samurai!",5,150)
    love.graphics.setColor(31,242,24)
    love.graphics.printf(hero.name, 0, 220,875, "center")
  end
end 