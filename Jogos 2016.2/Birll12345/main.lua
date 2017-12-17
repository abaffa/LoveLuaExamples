require('chubby')
require('cenario')
require('bambam')
require('inimigo')
--Definindo todos os Game states
playing='playing'
menu='menu'
nome='nome'
ranking='ranking'
instructions='instructions'
dead='dead'
pause='pause'
--Running é o game state dps de voce colidir e o bambam ta atras de voce
running='running'
-- Highscore file
highscoreFile = 'highscore'
--Fonte
font=love.graphics.newFont('Font.ttf',20)
function love.load()
  newVida()
  reset(dt)
  Audio_Volume()
  chubby.load()
  cenario.load()
  bambam.load()
  inim.load()
  Shield=love.graphics.newImage("Sprites/Shield.png")
  --Carregar imagens do menu e HUD
  imenu=love.graphics.newImage('Menu/menu.jpg') 
  iDead=love.graphics.newImage('Menu/Dead.jpg')
  iScore=love.graphics.newImage('HUD/Score.png') 
  iImortal=love.graphics.newImage('HUD/Imortal.png')
  iinstruc=love.graphics.newImage('Menu/instru.jpg')
  ipause=love.graphics.newImage('HUD/Pause.png') 
  volumemute=love.graphics.newImage('HUD/volume-mute.png')
  volume1=love.graphics.newImage('HUD/volume1.png')
  Iboss=love.graphics.newImage('Sprites/BamBamVoadorAlado.png')
  Iwhey=love.graphics.newImage('Cenario/Whey2.png')
 --botar o nome do jogo e o tamanho da tela
 love.window.setTitle('The Birl Fever')
 love.window.setMode(1280,720)
 --O jogo começa no Game state Menu
 gamestate=menu
 --Variavel que define qual o modo do game pause, para poder diferenciar qnd o Game state ta playing ou running
 gamepause=0
 --Variavel do lanche no score
 Score_Lanche=0
 --Carregar sons
 Hora_do_show= love.audio.newSource('Audios/start.mp3', 'static')
 Trilha_sonora= love.audio.newSource('Audios/Musica.mp3', 'stream')
 Birll= love.audio.newSource('Audios/birl.mp3', 'static')
 vai_da_nao=love.audio.newSource('Audios/vai_da_n.mp3','static')
 que_n_vai_da=love.audio.newSource('Audios/que_n_vai_da.mp3','static')
 jaula= love.audio.newSource('Audios/Ta saindo da jaula.mp3', 'static') 
 iuuu= love.audio.newSource('Audios/iuuu.mp3', 'static')
 Bodybuilding= love.audio.newSource('Audios/bodybuilding.mp3', 'static')
  --Variaveis que definem o volume
 var_audio=0.05
 var_audio2=0.01
 heronameinput = "off"
 heroname=''
 heroname_size = 0
 love.keyboard.setKeyRepeat(true)
end


function love.update(dt)
  Audio_Volume()
--Escrever seu nome na tela inicial
  if gamestate==nome then
    heronameinput = "on"
  else  heronameinput = "off"
  end
--Quando estiver rodando o jogo 
  if gamestate==playing then
    onPlaying(dt)
  end
--Quando estiver rodando o jogo e voce ja colidiu uma vez
  if gamestate==running then
    onrunning(dt)
  end
--Musica de fundo
  if gamestate==playing or gamestate==running then
    love.audio.play(Trilha_sonora)
  end
end


function love.draw() 
  love.graphics.setFont(font)
--Desenhar o menu e instruções
  if gamestate==menu then
    love.graphics.setColor(255,255,255)
    love.graphics.draw(imenu,0,0)
  elseif gamestate==instructions then
    love.graphics.setColor(255,255,255)
    love.graphics.draw(iinstruc,0,0)
--Tela para digitar o nome
  elseif gamestate==nome then
    love.graphics.setColor(255,255,255)
    love.graphics.draw(fundo1,0,0)
    love.graphics.draw(fundo2,0,0)
    love.graphics.print('Escreva seu nome',540,365)
    love.graphics.print(heroname, 540,400)
  elseif gamestate==ranking then
    love.graphics.setColor(255,255,255)
    love.graphics.draw(fundo1,0,0)
    love.graphics.draw(fundo2,0,0)
--Tela pausado
  elseif gamestate==pause then
    love.graphics.setColor(255,255,255)
    game_draw()
    Volume_Draw()
    love.graphics.draw(ipause,0,630)
    if gamepause==2 then
      love.graphics.setColor(255,255,255)
      love.graphics.draw(ivida,1150,10) 
      love.graphics.draw(ivida,vida.x,vida.y,0,0.7)
    else love.graphics.setColor(255,255,255) 
      love.graphics.draw(ivida,1150,10)
      love.graphics.draw(ivida,1200,10)
    end
--Qnd morrer mudar a tela
  elseif gamestate==dead  then
    love.graphics.setColor(255,255,255)
    love.graphics.draw(iDead,0,0)
    Volume_Draw()
    love.graphics.setColor(200,200,200)
    love.graphics.print(math.ceil(player.score),125,44) --math.ceil eh para arredondar o numero para cima, tira o bug do numero 1,99999
    love.graphics.print(player.hscore,185,90)
--Desenhar a tela no estado q vc tem 2 vidas
  elseif gamestate==playing then
    game_draw()
    Volume_Draw()
    love.graphics.setColor(255,255,255)
    love.graphics.draw(ivida,1150,10)
    love.graphics.draw(ivida,1200,10)
--Desenhar a tela no estado que vc tem 1 vida
  elseif gamestate==running then
    game_draw()
    Volume_Draw()
    love.graphics.setColor(255,255,255)
    love.graphics.draw(ivida,1150,10)
    love.graphics.draw(ivida,vida.x,vida.y,0,0.7)
  end
--Desenhar o escudo e o contador do tempo imortal
  if Imortal>0 then
    if gamestate==playing or gamestate==running or gamestate==pause then
      love.graphics.draw(iImortal,1070,80,0,0.45)
      love.graphics.print(5-math.ceil(Imortal),1230,83)
      love.graphics.draw(Shield,player.x-55,player.y-10,0,0.4)
    end
  end
end


function love.keypressed(key)
--iniciar o jogo qnd apertar enter 
  if key=='return' then
    if gamestate==menu then
      gamestate=playing
      love.audio.stop(vai_da_nao)
      love.audio.stop(que_n_vai_da)
      love.audio.play(Hora_do_show)
      reset(dt)
    elseif gamestate==dead then
      gamestate=playing
      love.audio.stop(vai_da_nao)
      love.audio.play(que_n_vai_da)
      reset(dt)
    elseif gamestate==nome and heroname~='' then
      gamestate=menu
    end
--Fechar o jogo, ou voltar pro Menu, qnd aperta esc
  elseif key=='escape' then
    if gamestate==instructions or gamestate==dead or gamestate==pause or gamestate==playing or    gamestate==running or gamestate==ranking then
      gamestate=menu
      stop_audio()
    elseif gamestate==menu  then
      love.event.quit()
    end
--pausar o jogo
  elseif key=='p' then
    if gamestate==playing  then
      gamestate=pause
      love.audio.pause( )
      gamepause=1
-- A variavel gamepause serve pra saber se qnd despausar se tem que voltar pro gamestate playing ou running
    elseif gamestate==pause and gamepause==1 then
      gamestate=playing
      love.audio.resume( )
    elseif gamestate==running then
      gamestate=pause
      love.audio.pause( )
      gamepause=2
      stop_audio()
    elseif gamestate==pause and gamepause==2 then 
      gamestate=running
      love.audio.resume( )
    end
--Entrar em instruções
  elseif key=='i' and gamestate==menu then
    gamestate=instructions
  elseif key=='m' then
    if var_audio==0 and var_audio2==0 then
      var_audio=0.05
      var_audio2=0.01
    elseif var_audio==0.05 and var_audio2==0.01 then
      var_audio=0
      var_audio2=0
    end
--Tela de ranking
  elseif key=='l' then
    if gamestate==menu then
      gamestate=ranking
    end
--fazer o chubby pular
  elseif player.y==490 then
    if key=='space' or key=='up'or key=='w' then
      player.ys=-600
    end
  end
  
  if key == 'backspace' then
    if gamestate==nome then
        heroname_size = heroname_size - 1
        heroname = string.sub(heroname, 1, heroname_size)
    end
  end
end


--Função que carrega td que é necessario qnd se da play
function onPlaying(dt)
 --Carregar tds funçoes update
  update(dt)
 --Se ocorrer colisão com inimigo ou obstaculo, o Game State recebe running, onde o bambam aparece
  if Imortal==0 then
    for i, v in ipairs(whey) do
      if CheckCollision(player.x, player.y, player.w,player.h,v.x,v.y,whey.w,whey.h) then
        collide_onPlaying()
      end
    end
    if Collision_Inimigos() then
      collide_onPlaying()
    elseif CheckCollision(player.x, player.y, player.w,player.h, bambam1.x, bambam1.y, bambam1.w, bambam1.h) then
      onDead()
    end
  end
--Esse if serve pra fazer o bambam sempre estar indo pra esquerda, e só ir para direita qnd gamestate ta running, onde o bambam ta na tela. Se o personagem pega a vida, o Game state volta pra playing, e o bambam vai voltar a andar pra esquerda,  até sair da tela
  if bambam1.x<=player.x then
    bambam1.x=bambam1.x-(600*dt)
  end
  if bambam1.x<=-700 then
    bambam1.x=-700
  end
  if CheckCollision(player.x, player.y, player.w,player.h, bambam1.x, bambam1.y, bambam1.w, bambam1.h) then
    onDead()
  end
end

function onrunning(dt)
  update(dt)
--A vida vai começar a se mover
  vida.x=vida.x-(700*dt)
--Se o player n pegar a vida e ela sair da tela, ela volta pra sua posição inicial
  if vida.x<-150 then
    vida.x=10000
  end
--A velocidade de frame do chubby aumenta até o bambam estar na posição dele, isso faz parecer que o chubby desacelerou qnd colidiu
--Vai diminuir a velocidade dos objetos pq o chubby colide e desacelera
  collide_vel()
--Bambam começa a andar na direção do Chubby
  bambam1.x=bambam1.x+(600*dt)
--Bambam qnd chegar nessa posição vai parar, e tds as velocidades voltam ao normal
  if bambam1.x>=300 then
    bambam1.x=300
    difficulty_score(dt)
  end
--Se ele pegar a vida o Game state volta pra playing, e o bambam volta a andar pra esquerda até sair da tela
  if CheckCollision(player.x, player.y, player.w,player.h, vida.x, vida.y, vida.w, vida.h) then
    gamestate=playing
    newVida()
    love.audio.play(iuuu)
  end
--Se o player colidir com o bambam ou obstaculos/inimigos, ele perde
  if Imortal==0 then
    if  bambam1.x==300 then
      for i, v in ipairs(whey) do
        if CheckCollision(player.x, player.y, player.w,player.h,v.x,v.y,whey.w,whey.h) then 
          onDead()
        end
      end
      if Collision_Inimigos() then
        onDead()
      end
    end
  end
  if CheckCollision(player.x, player.y, player.w,player.h, bambam1.x, bambam1.y, bambam1.w, bambam1.h) then
    onDead()
  end
end

--Função para definir td que acontece qnd vc morre
function onDead()
  gamestate=dead
  love.audio.play(vai_da_nao)
  love.audio.stop(Hora_do_show)
--Vai escrever o Hscore se o score for maior q o hscore
  if (player.hscore < player.score) then
    writeHighscore() 
  end
end


--Carrega tds os .update, implementa a soma do score e a dificuldade aumentando conforme o score aumenta
function update(dt)
  chubby.update(dt)
  cenario.update(dt)
  bambam.update(dt)
  inim.update(dt)
  player.score=player.score+0.1+ Score_Lanche
  difficulty_score(dt)
  Collision_Lanches(dt)
  Bboss(dt)
  for i,v in ipairs(whey) do
    v.y = v.y + 400*dt
  end
end


function Bboss(dt)
  if bosspawn>=0 then
    bosspawn=bosspawn+dt
  end
  if bosspawn>15 then
    bosstimer=bosstimer+dt
    boss.x=boss.x+(dir*300*dt)
  end
  
  if bosstimer>0 then
    whey_timer=whey_timer+dt
  end
  
  if whey_timer >= 1 then
    local x=boss.x+100
    table.insert(whey,{x=x, y=115})
    whey_timer = 0
  end
  
  if boss.x>=1000  then
    dir=-1
  elseif boss.x<=-100 and bosstimer<15 then
    dir=1
  end
  
  if boss.x<-294 then
    boss.x=-294
    bosspawn=0
    bosstimer=0
  end
end


--Função para checar colisão
function CheckCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

--Função que checa a colisão de td
function Collision_Inimigos()
  return CheckCollision(player.x, player.y, player.w,player.h, box1.x, box1.y, box1.w, box1.h) or CheckCollision(player.x, player.y, player.w,player.h, inim1.x, inim1.y, inim1.w, inim1.h)
end


--Função colisão lanchinhos
function Collision_Lanches(dt)
  --Se colidir com um lanchinho aumenta 5 no score
  if CheckCollision(player.x, player.y, player.w,player.h, batata1.x, batata1.y, batata1.w, batata1.h) 
  or CheckCollision(player.x, player.y, player.w,player.h, Hamburguer1.x, Hamburguer1.y, Hamburguer1.w, Hamburguer1.h) then
    love.audio.play(Birll)
    batata1.x=5000
    Hamburguer1.x=5000
    BatataBirl.x=5000
    Score_Lanche=5
    Lanche_random=love.math.random(1,7)
  --Se colidir com a batataBirll, vc fica imortal por 6 segundos
  elseif CheckCollision(player.x, player.y, player.w,player.h, BatataBirl.x, BatataBirl.y, BatataBirl.w, BatataBirl.h) then
    BatataBirl.x=5000
    love.audio.play(Bodybuilding)
    Imortal=0.0001
    Lanche_random=love.math.random(1,6)
  else Score_Lanche=0
  end
  --Começar a contar o tempo imortal, dps reseta lo
  if Imortal>0 then
    Imortal=Imortal+dt
  end
  if Imortal>=4 then
    Imortal=0
  end
  if batata1.x<=-40 or Hamburguer1.x<=-40 or BatataBirl.x<=-90 then
    batata1.x=5000
    Hamburguer1.x=5000
    BatataBirl.x=5000
    Lanche_random=love.math.random(1,5)
  end
  if Lanche_random>=1 and Lanche_random<=3 then
    batata1.x=batata1.x-(700*dt)
  elseif Lanche_random>=4 and Lanche_random<=6 then
    Hamburguer1.x=Hamburguer1.x-(700*dt)
  elseif Lanche_random==7 then
    BatataBirl.x=BatataBirl.x-(800*dt)
  end
end


--Função para definir tudo da vida
function newVida()
  vida={
    x=10000,
    y=425,
    w=30,
    h=30,
  }
  vel_vida=700
end

--Função que define a posição inicial de tudo do jogo, ela é chamada no menu e na tela de morto, serve pra resetar a posição de tudo
function reset(dt)
--Chubby
  player={  
    x = 0,
    ys = 0,
    y = 490,
    w = 80,
    h = 140,
    score=0,
    hscore=readHighscore()
  }
  vel_frame=0.11
--Bambam
  bambam1 = {
    x = -700,
    y = 470,
    w = 100,
    h = 105,
  }
--boss
  boss = {
    x = -294,
    y = 100,
    w = 250,
    h = 10,
  }
--whey
  whey= {
    w=50,
    h=67,
  }
--Box1 pedra
  box1 = {
    x = 1300,
    y = 580,
    w = 260,
    h = 90,
  }
--Bambamminion
  inim1 = {
    x = 1800,
    y = 537,
    w = 50,
    h = 105,
  }
--Lanchinhos
  batata1 = {
    x=5000,
    y=425,
    w=35,
    h=40,
  }
  
  Hamburguer1 = {
    x=5000,
    y=430,
    w=35,
    h=40,
  }
  
  BatataBirl = {
    x=5000,
    y=420,
    w=80,
    h=60,
  }
--Tudo do cenario
  birdx=80
  Arvorex=1100
  Arvorex2=1900
  Arvorey=290
  Arvorey1=290
  nuvem1x=1280
  nuvem2x=600
  nuvem3x=900
  nuvem4x=1080
  chaox1=0
  chaox2=1280
  cenariox=0
  cenariox2=1280
  Vel_cenario=50
  newVida()
  --Randomiza os inimigos
  ini_random=love.math.random(1,2)
  --Randomiza o item que virá
  Lanche_random=love.math.random(1,7)
 --Variavel q define se vc ta sem colisão ou não
  Imortal=0
  index_arvore1 = love.math.random(1,4)
  index_arvore = love.math.random(1,4)
  --direção do boss
  dir=1
  --Tempo que o boss fica no mapa
  bosstimer=0
  --Timer pro boss aparecer
  bosspawn=0
  --Timer do whey
  whey_timer=0
end


--Função que aumenta a velocidade conforme o score sobe
function difficulty_score(dt)
  if player.score>340 then
    vel_box=1140
    vel_frame=0.085
  elseif player.score>280 then
    vel_box=1080
    vel_frame=0.09
  elseif player.score>230 then
    vel_box=1020
    vel_frame=0.095
  elseif player.score>180 then
    vel_box=960
    vel_frame=0.10
  elseif player.score>130 then
    vel_box=880
    vel_frame=0.105
  elseif player.score>80 then
    vel_box=820
    vel_frame=0.11
  elseif player.score<80 then
    vel_box=700
    vel_frame=0.115
  end
end

function collide_onPlaying()
  gamestate=running
  love.audio.stop(que_n_vai_da)
  love.audio.stop(vai_da_nao)
  love.audio.stop(Hora_do_show)
  love.audio.play(jaula)
end

--Função que diminui a velocidade dos objetos no momento que voce colidiu e o bambam ainda n esta em sua posição
function collide_vel()
  vel_frame=0.18
  if player.score>340 then
    vel_box=530
  elseif player.score>280 then
    vel_box=500
  elseif player.score>230 then
    vel_box=470
  elseif player.score>180 then
    vel_box=440
  elseif player.score>130 then
    vel_box=410
  elseif player.score>80 then
    vel_box=380
  elseif player.score<80 then
    vel_box=350
  end
end
  
  
--Função que desenha o jogo no pause e playing
function game_draw()
  cenario.draw()
  inim.draw()
  chubby.draw()
  bambam.draw()
  love.graphics.draw(iScore,530,10,0,0.5)
  love.graphics.print(math.ceil(player.score),600,11.3)
  love.graphics.draw(Iboss,boss.x,boss.y,0,0.7)
  love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 40)
  if whey_timer>=0 then
    for i, v in ipairs(whey) do
      love.graphics.draw(Iwhey,v.x,v.y)
    end
  end
end

--Função que desenha o simbolo de som (mutado/desmutado)
function Volume_Draw()
  if var_audio<0.05 and var_audio2<0.01 then 
    love.graphics.draw(volumemute,10,10) 
  elseif var_audio==0.05 and var_audio2==0.01 then
    love.graphics.draw(volume1,10,10)
  end
end


--Função que define o volume dos audios
function Audio_Volume()
  if gamestate ~= nil then 
    Hora_do_show:setVolume(var_audio)
    que_n_vai_da:setVolume(var_audio)
    jaula:setVolume(var_audio)
    vai_da_nao:setVolume(var_audio)
    Trilha_sonora:setVolume(var_audio2)
    iuuu:setVolume(var_audio)
    Birll:setVolume(var_audio)
    Bodybuilding:setVolume(var_audio)
  end
end

--Função que para os audios
function stop_audio()
  love.audio.stop(que_n_vai_da)
  love.audio.stop(vai_da_nao)
  love.audio.stop(Hora_do_show)
  love.audio.stop(Birll)
  love.audio.stop(jaula)
  love.audio.stop(Trilha_sonora)
end


function love.textinput(t)
  heroname_size = #heroname
  if heronameinput == "on" then
    heroname = heroname .. t
    heroname_size = heroname_size + 1
  end
  if heronameinput == "off" then
    heroname = heroname
  end
end

--Função que escreve o highscore
function writeHighscore()
  love.filesystem.write(highscoreFile, math.ceil(player.score), all)
end

--Carrega o hscore que foi salvo no arquivo de texo, e se n existir o arquivo, cria um
function readHighscore()
  if not love.filesystem.exists(highscoreFile) then
    love.filesystem.write(highscoreFile, 0, all)
    return 0
  else
    hscore = love.filesystem.read(highscoreFile, all)
    result = tonumber(hscore)
  end
  return result
end
