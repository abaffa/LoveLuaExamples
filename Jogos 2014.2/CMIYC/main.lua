 love.window.setTitle("Catch me if you can!")
--inicio
local vetor_plat = {} -- vetor de posições das plataformas
local yc = -1100 -- plataforma e fundo
local forca = 550 --forca do impulso do dicaprio
local forca2 = 5 --forca que eleva a plataforma
local pontos = 0
local ob = 1 -- variavel obstáculo
local vidas = 3
local yi = 1000 -- iceberg
local choro = {} -- choro
local choro_frame = 1
local bgmusic1 -- variavel para iniciar a musica
local descol --colisão do dicaprio com o colete
local yos  -- variave y do oscar
local desenhar -- desenhar quando não colidir
local ycat = 200 -- posições do gato
local xcat = 200
local dircat = 1 -- direção do gato
local yaviao = 200 -- posições do aviao
local xaviao = 200
local diraviao = 1 -- direção do aviao
local xpo
local dirpol1 = 1
local xpo2
local dirpol2 = 1
anim_time = 0 --variavel que controla o tempo (usado pra controlar o tempo das imagens da cutscene)
descol = false
desenhar = true
finalf = false -- variavel de final de jogo
trocap = false --troca de personagens
icebergcollided = false -- colisão do iceberg com o dicaprio
colupa = false -- colisão com o upaupa
desenhoupa = true -- desenho do upaupa
inicio = true -- inicio de fase - menu
fase1 = true -- variável que faz começar a fase1
fase2 = false --variável que faz começar a fase2
fase2midia = false
fase3 = false
fase3midia = false
fase4 = false
fase4midia = false
--fase4meio = false -- verifica se está na fase 4
pause = false
endgame = false
dicaprio = { --Tabela com as caracteristicas do Dicaprio
  xdi = 400,
  ydi = 200, 
  width = 50,
  height = 67,
  collided = false, --colisão do dicaprio com a plataforma
  anim_time = 0,
  jump = false --pulo do personagem torna true quando encosta com a plataforma
}
function love.load()
  -- fase 1
  fundo = love.graphics.newImage("Titanic1.png") --Tela de fundo da fase Titanic
  plat = love.graphics.newImage("plataforma.png") --Imagem da plataforma
  colete = love.graphics.newImage("colete.png") --Imagem do colete
  iceberg = love.graphics.newImage("iceberg.png") --Imagem do iceberg
  bgmusic1 = love.audio.newSource("music.mp3") --Audio da fase Titanic
  -- fase 2
  fundo2= love.graphics.newImage("gilbertgrape.png") -- Fundo da fase 2 (Gilbert Grape)
  cat = love.graphics.newImage("cat.png")  -- Imagem do gato
  apple= love.graphics.newImage("apple.png") -- Imagem da maça
  bgmusic2 = love.audio.newSource("music2.mp3")
  --fase 3
  fundo3 = love.graphics.newImage("catchme.png")
  bgmusic3 = love.audio.newSource("catchme.mp3")
  police1 = love.graphics.newImage("police.png")
  police2 = love.graphics.newImage("police1.png")
  money = love.graphics.newImage("moni.png")
  --fase 4
  fundo4 = love.graphics.newImage("OAviador.jpg")
  bgmusic4 = love.audio.newSource("music3.mp3") -- música temporária 
  aviao = love.graphics.newImage("aviao.png")
  --remedio = love.graphics.newImage("remedio.gif")
  oscarmusic=love.audio.newSource("oscar.mp3") --musica quando ele ganha
  --...
  oscar = love.graphics.newImage("oscar.png")
  upaupa = love.graphics.newImage("upaupa.png") -- Imagem do Upa Upa do Gugu
  caprio = love.graphics.newImage("dicaprio6.png") --Imagem do Dicaprio virado para a esquerda
  caprio2 = love.graphics.newImage("dicaprio1.png") -- Imagem do Dicaprio virado pra direita
  claque = love.graphics.newImage("claquete.png") -- Imagem das claquetes (simbolizam vidas)
  som = love.graphics.newImage("unmute.png") -- Imagem do botão de parar a musica
  mudo = love.graphics.newImage("mute.png") --Imagem do botão quando se aperta para parar a musica
  pausebutton = love.graphics.newImage("pause.png") -- Imagem do botão para pausar o jogo
  fundopause=love.graphics.newImage("TelaPausa.png") --Imagem da Interface de Pause
  gameover = love.graphics.newImage("gameover.png") --Imagem escrito Game Over
  menu = love.graphics.newImage("telamenu.png") -- Imagem da Interface de menu
  refresh = love.graphics.newImage("refresh.png") -- botão de restart
  start = love.graphics.newImage("start.png") -- botão de start
  musicchoro=love.audio.newSource("bebe.mp3")
  win = love.graphics.newImage("win.jpg")
  itemsound=love.audio.newSource("item.mp3")
  cityfont = love.graphics.newFont("STCity.ttf", 48)
  love.graphics.setFont(cityfont)
  for x = 1, 9, 1 do -- carrega as imagens do choro do personagem quando o jogador perde todas as vidas
    choro[x] = love.graphics.newImage("choro" .. x .. ".png")
  end
-- vetor criado para posicionar as plataformas de maneira mais eficiente
  vetor_plat[1] = { posx=400, -- vetor 1 da primeira plataforma
    posy=367,
    width = 1024*0.3,
    height = 172*0.2,
    factor = 0.3} --fator de escala 
  
  for x=2,19,1 do
    vetor_plat[x] = { posx = love.math.random(0,550), -- vetor das outras plataformas do jogo
      posy = 550-x * 150,
      width = 1024*0.3,
      height = 172*0.2,
      factor = 0.3}                 
    vetor_plat[19] ={  posx=0,  -- vetor referente a ultima plataforma do jogo
      posy=550-(19 * 150),
      width = 1024*0.8,
      height = 172*0.2,
      factor = 0.8}                 
  end
  xpo = vetor_plat[5].posx + 60 --coordenadas relativas ao policial
  ypo = vetor_plat[5].posy
  xpo2 = vetor_plat[12].posx + 110 --coordenadas relativas ao policial2
  ypo2 = vetor_plat[12].posy
  function CheckBoxCollision(x1,y1,w1,h1,x2,y2,w2,h2) --funcao base de colisao
    return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
  end
--audio
  function CheckClick(x1,y1,w1,h1,x2,y2) --funcao base para deteccao do click com o mouse
    return x1 < x2+1 and x2 < x1+w1 and y1 < y2+1 and y2 < y1+h1
  end
 end
function love.update(dt)
   if CheckBoxCollision(dicaprio.xdi, dicaprio.ydi+dicaprio.height/2, dicaprio.width,dicaprio.height,xcat,ycat,10,11)and fase2midia== true then --colisão com o gato
 restart()
end
if CheckBoxCollision(dicaprio.xdi, dicaprio.ydi+dicaprio.height/2, dicaprio.width,dicaprio.height,xpo+20,ypo-20,20,35) and fase3midia == true then -- colisão com o policial1
  restart()
end
if CheckBoxCollision(dicaprio.xdi, dicaprio.ydi+dicaprio.height/2, dicaprio.width,dicaprio.height,xpo2+20,ypo2-20,20,35) and fase3midia == true then -- colisão com o policial2
  restart()
end
  if CheckBoxCollision(dicaprio.xdi, dicaprio.ydi+dicaprio.height/2, dicaprio.width,dicaprio.height,xaviao,yaviao,10,11)and fase4midia == true then --colisão com o aviao
    restart()
  end  
  bonusupa(dt)
  xos=400
  yos=vetor_plat[19].posy -100
  if CheckBoxCollision(dicaprio.xdi, dicaprio.ydi+dicaprio.height/2,dicaprio.width,dicaprio.height,xos,yos,36,100) and fase2midia == true then --colisão com o oscar
    fase2 = false
    fase2midia = false
    fase2update(dt)
    fase3 = true
    fase3midia = true
    love.audio.stop(bgmusic2)
    love.audio.play(bgmusic3)
  end
  if pause == false then
    xcat = xcat + (250 * dircat * dt) 
    if xcat >= 790 then
      dircat = -1
    elseif xcat <= 0 then
      dircat = 1
      end
    end
    if pause == false then
      xaviao = xaviao + (250 * diraviao * dt) 
      if xaviao >= 790 then
        diraviao = -1
    elseif xaviao <= 0 then
      diraviao = 1
      end
    end
    if pause == false then
      xpo = xpo + (90 * dirpol1 * dt)
      if xpo <= vetor_plat[5].posx then
        dirpol1 = 1
      elseif xpo >= vetor_plat[5].posx + 307.2 then
        dirpol1 = -1
      end
      xpo2 = xpo2 + (90 * dirpol2 * dt)
      if xpo2 <= vetor_plat[12].posx then
        dirpol2 = 1
      elseif xpo2 >= vetor_plat[12].posx + 307.2 then
        dirpol2 = -1
      end
    end
    if inicio == true then
      if love.keyboard.isDown("space") then
        inicio = false
        love.audio.play(bgmusic1)
      end
    end
    --if fase4midia == true and dicaprio.ydi >= 400 then
      --fase4meio = true
      --end
  if pause == false then
    if  finalf == true  then
      if fase1 then
        fase1 = false
        fase2 = true
        fase2midia = true
        love.audio.stop(bgmusic1)
        love.audio.play(bgmusic2)
      end
      if fase3midia then
        fase3midia = false
        fase4midia = true
        fase4 = true
        love.audio.stop(bgmusic3)
        love.audio.play(bgmusic4)
      end  
    end 
    if fase2 == true then -- voltar ao inicio da 2 fase; 
      fase2update(dt)
      fase2draw()
      colisaoapple()
      fase2 = false
    end 
    if fase3 == true then -- voltar ao inicio da 3 fase; 
      fase3update(dt)
      fase3draw()
      colisaomoney()
      fase3 = false
    end 
    if fase4 == true then -- voltar ao inicio da 4 fase; 
      fase4update(dt)
      fase4draw()
      colisaoremedio()
      fase4 = false
    end 
    if vidas < 1 then
     updatecutscene(dt)
     endgame = true
     love.audio.stop(bgmusic1)
     love.audio.stop(bgmusic2)
     love.audio.stop(bgmusic3)
     love.audio.stop(bgmusic4)
   end
    movecenario(dt,ob) -- função fundo+plataforma
    movdicaprio(dt) --função movim e troca do dicaprio 
    if inicio == true then -- quando for inicio/menu dicaprio não pula
      menujogo(dt)
    end
    if dicaprio.ydi > 600 then -- plataforma
      restart() -- quando o dicaprio cai ele vai para essa função que leva ele para o começo e faz perder uma vida
    end
    xco = vetor_plat[9].posx --coordenadas relativas ao colete
    yco = vetor_plat[9].posy
    dicaprio.collided = false --colisão com a plataforma
    for x = 1,19,1 do
      if CheckBoxCollision(dicaprio.xdi, dicaprio.ydi+dicaprio.height-2, dicaprio.width,2, vetor_plat[x].posx, vetor_plat[x].posy,vetor_plat[x].width, 2) then
        dicaprio.collided = true
      --end
        if x == 18 then
          yi = yi -- iceberg para quando chega na penultima plataforma
        end
        if x == 19 then
          finalf = true
          forca2 = 0
        end
      end
        colisaocolete()
    end
    if CheckBoxCollision(dicaprio.xdi, dicaprio.ydi+dicaprio.height-2, dicaprio.width,2, 0, yi+30, 691,112) and fase1 == true then -- colisáo com o iceberg
      icebergcollided = true
    end
    if fase2 == true or fase3 == true or fase4 == true then -- desabilita iceberg na fase 2,3,4
      icebergcollided = false
    end
    if CheckBoxCollision(dicaprio.xdi, dicaprio.ydi+dicaprio.height-2, dicaprio.width,2, 112, yi+102, 398,80) and fase1 == true then -- colisáo com o iceberg 2
     icebergcollided = true
    end
    if icebergcollided == true then -- colisão com iceberg - volta ao inicio
      restart()
    end
  colisaocolete()
    if fase2 == true then -- voltar ao inicio da 2 fase; 
      for x=2,19,1 do
        vetor_plat[x].posy = 550-x*150
      end
      dicaprio.ydi = 90
      dicaprio.xdi = vetor_plat[1].posx + vetor_plat[1].width/2+50
      yc = -1100  
    end 
    if fase3 == true then -- voltar ao inicio da 3 fase; 
      for x = 2,19,1 do
        vetor_plat[x].posy = 550-x*150
      end
      dicaprio.ydi = 90
      dicaprio.xdi = vetor_plat[1].posx + vetor_plat[1].width/2+50
      yc = -1100  
    end
    if fase4 == true then -- voltar ao inicio da 4 fase; 
      for x = 2,19,1 do
        vetor_plat[x].posy = 550-x*150
      end
      dicaprio.ydi = 90
      dicaprio.xdi = vetor_plat[1].posx + vetor_plat[1].width/2+50
      yc = -1100  
    end 
    if fase == 1 then
      ob = 1
    end
  end
  --if fase4midia == true and dicaprio.ydi >= 400 then
   -- fase4meio = true
 -- end
end
function love.draw()
  -- fundo
  love.graphics.setColor(255,255,255)
  if fase1 == true then
    love.graphics.draw(fundo, 0, yc)
    colisaocolete()
  elseif fase2midia  == true then
    fase2draw()
  elseif fase3midia == true then
    fase3draw()
  elseif fase4midia == true then
    fase4draw()  
  end
  -- plataformas
  for x = 1, 19, 1 do -- repetição das plataformas
    love.graphics.draw (plat, vetor_plat[x].posx, vetor_plat[x].posy, 0, vetor_plat[x].factor, 0.2)
  end
  drawclaquete() -- função de desenho da claquete 
  drawpers() -- função de desenho da troca do personagem    
  bonusupadraw()
  love.graphics.print(pontos, 10, 10, 0, 0.43, 0.43)
  botoestela() -- funções do desenho dos pause,mute, unmute
  if inicio == true then -- se for inicio,desenha a imagem do menu
     love.graphics.draw(menu, 0, 0)
     love.graphics.draw(start, 280, 500)
  end
  if fase1 == true and inicio == false then
   -- iceberg
    love.graphics.draw(iceberg, 0, yi)
  end
  if vidas < 1 then
    drawcutscene()
end
if fase4midia == true then
    if CheckBoxCollision(dicaprio.xdi, dicaprio.ydi+dicaprio.height/2,dicaprio.width,dicaprio.height,xos,yos,36,100) then
    fase4 = false
    love.graphics.draw(win,0,0)
    love.graphics.printf(pontos, 100, 425, 200, "center", 0, 3, 2.3)
    oscarfinal = true
   end 
 end
end
function love.mousepressed(x,y,button)
  if button == "l" then
    if CheckClick(15,565,25.6,25.6,x,y) then -- botão de pausar a música
      love.audio.pause(bgmusic1)
      love.audio.pause(bgmusic2)
      love.audio.pause(bgmusic3)
      love.audio.pause(bgmusic4)
    end
    if CheckClick(15,530,25.6,25.6,x,y) then -- botão de continuar a música
      love.audio.resume(bgmusic1)
      love.audio.resume(bgmusic2)
      love.audio.resume(bgmusic3)
      love.audio.resume(bgmusic4)
    end
    if CheckClick(280,500,257,87,x,y) then -- se apertar start, inicia o jogo
      inicio = false
      love.audio.play(bgmusic1) -- Para poder tocar a musica da primeira fase
    end
    if pause == false then
      if CheckClick(750,50,25.6,25.6,x,y) then -- se apertar o pause pausa o jogo
        pause = true
        love.audio.pause(bgmusic1)
        love.audio.pause(bgmusic2)
        love.audio.pause(bgmusic3)
        love.audio.pause(bgmusic4)
      end
    elseif pause == true then
      if CheckClick(750,50,25.6,25.6,x,y) then
        pause = false
        love.audio.resume(bgmusic1)
        love.audio.resume(bgmusic2)
        love.audio.resume(bgmusic3)
        love.audio.resume(bgmusic4)
      end
    end
  end
end
function menujogo(dt)
-- quando for inicio/menu dicaprio não pula
  forca2 = 0 
  forca = dicaprio.ydi + (220* dt) -- mesmo valor da gravidade
end
function movecenario(dt,ob) -- desenha e move as plataformas, o fundo e o onstáculo.
  yc = yc + ((forca2/3) * dt) -- yc é relativo ao fundo,logo, esse comando move o fundo de acordo com o movimento do Dicaprio
  if dicaprio.ydi < 200 and forca2 < 150 then
    forca2 = forca2 + (40*dt) 
  elseif forca2 > 5 and dicaprio.ydi > 200 then
    forca2 = forca2 - (40*dt) 
  end 
  for x = 1,19,1 do
    vetor_plat[x].posy = vetor_plat[x].posy + (forca2*dt) -- esse comando move as plataformas
  end
-- iceberg
  if ob == 1 then -- obstáculo
    if inicio == false and fase1 == true then
      if yi >= 350 then
        yi = yi - (dt * 25) -- velocidade do iceberg
      end
    end
  end
end
function movdicaprio(dt)
   -- dicaprio
  if love.keyboard.isDown("right") then 
    trocap = false --quando esse botao é apertado a imagem do dicaprio muda pra imagem da direita
    if dicaprio.xdi <= 750 then
      dicaprio.xdi = dicaprio.xdi + (270 * dt)
    end
  end
  if love.keyboard.isDown("left") then
    trocap = true --imagem do dicaprio é a da esquerda
      if dicaprio.xdi >= 0 then
        dicaprio.xdi = dicaprio.xdi - (270 * dt)
      end
  end
-- dicaprio pular
  if dicaprio.ydi >= yc + 33 then
    if dicaprio.jump==false and dicaprio.collided==true and finalf== false then 
      dicaprio.jump = true   -- tirou o comando do espaço e agora pula quando ele colidir
    end
  end
--Programação relativa ao pulo do personagem
  if dicaprio.jump == true then
    forca = forca - (30*dt)
    dicaprio.ydi = dicaprio.ydi - (forca* dt)
    dicaprio.anim_time = dicaprio.anim_time + dt -- incrementa o tempo usando dt
      if dicaprio.anim_time > 0.5 then 
        dicaprio.jump = false
        forca = 550
        dicaprio.anim_time = 0
      end 
      if endgame == false then
    pontos = pontos + 1
    end
  end
  if dicaprio.collided == false then
    dicaprio.ydi = dicaprio.ydi + (220* dt) --aceleração da gravidade
  end
end
function drawpers() -- troca de personagem
  if trocap == false then
    love.graphics.draw(caprio, dicaprio.xdi, dicaprio.ydi,0,0.7,0.7)
  end
  if trocap == true then
    love.graphics.draw(caprio2, dicaprio.xdi, dicaprio.ydi,0,0.7,0.7)
  end
end
function drawclaquete() 
-- desenho da claquete conforme vidas
  if vidas == 3 then
    love.graphics.draw(claque,650,10,0,0.1,0.1)
    love.graphics.draw(claque,700,10,0,0.1,0.1)
    love.graphics.draw(claque,750,10,0,0.1,0.1)
  end
  
  if vidas == 2 then
    love.graphics.draw(claque,650,10,0,0.1,0.1)
    love.graphics.draw(claque,700,10,0,0.1,0.1)
  end
  if vidas == 1 then
      love.graphics.draw(claque,650,10,0,0.1,0.1)
  end  
end
function botoestela()  
--''botões'' da tela
  love.graphics.draw(som, 15, 530, 0, 0.4, 0.4)
  love.graphics.draw(mudo, 15, 565, 0, 0.4, 0.4)
  love.graphics.draw(pausebutton, 750, 50, 0, 0.4, 0.4)
end
function restart()
  forca = 550 --forca do impulso do dicaprio
  forca2 = 5 --forca que eleva a plataforma
  yc = -1100
  yi = 1000
  descol = false
  desenhar = true
  finalf = false
  trocap = false
  icebergcollided = false
  dicaprio = {
    xdi = 400,
    ydi = 200,
    width = 50,
    height = 67,
    collided = false,
    anim_time = 0,
    jump = false
  }
  vetor_plat[1] = { posx=400,
    posy = 367,
    width = 1024*0.3,
    height = 172*0.2,
    factor = 0.3}
  for x = 2,19,1 do
    vetor_plat[x] = { posx = love.math.random(0,550), 
      posy = 550-x * 150,
      width = 1024*0.3,
      height = 172*0.2,
      factor = 0.3}
    vetor_plat[19] = { posx=0,
      posy = 550-(19 * 150),
      width = 1024*0.8,
      height = 172*0.2,
      factor = 0.8}
  end
  vidas = vidas - 1
end
-- Fase 1
function colisaocolete()
  xco = vetor_plat[9].posx --coordenadas relativas ao colete
  yco = vetor_plat[9].posy
  if CheckBoxCollision(dicaprio.xdi, dicaprio.ydi+dicaprio.height/2, dicaprio.width,dicaprio.height,xco,yco,40,61) then
   love.audio.play(itemsound)
    descol = true
  end
  if descol == true then
    if endgame == false then
    pontos = pontos + 10
    end
    desenhar = false
    descol = false
  end
--colete
  xco = vetor_plat[9].posx
  yco = vetor_plat[9].posy-55
  if desenhar == true then --se ele não tiver colidindo com o colete esse colete estará desenhado no jogo
    love.graphics.draw(colete,xco,yco)
  end  
end
--Fase 2
function fase2update(dt)
  forca = 550 --forca do impulso do dicaprio
  forca2 = 5 --forca que eleva a plataforma
  pontos = pontos 
  yc = -1100
  yi = 1000
  descol = false
  finalf = false
  trocap = false
  desenhar = true
  icebergcollided = false
  dicaprio = {
    xdi = 400,
    ydi = 200,
    width = 50,
    height = 67,
    collided = false,
    anim_time = 0,
    jump = false
  }
  vetor_plat[1] = { posx=400,
    posy=367,
    width = 1024*0.3,
    height = 172*0.2,
    factor = 0.3}
  for x=2,19,1 do
    vetor_plat[x] = {posx = love.math.random(0,550), 
      posy = 550-x * 150,
      width = 1024*0.3,
      height = 172*0.2,
      factor = 0.3}
    vetor_plat[19] = { posx=0,
      posy=550-(19 * 150),
      width = 1024*0.8,
      height = 172*0.2,
      factor = 0.8}
    end
end
function fase2draw()
  love.graphics.draw(fundo2, 0, yc) -- fundo2
  if desenhar == true then --se ele não tiver colidindo com o apple esse apple estará desenhado no jogo
    love.graphics.draw(apple,xco,yco + 15) --apple
  end
  xos = 400
   yos = vetor_plat[19].posy - 100
    love.graphics.draw(oscar, xos,yos) --oscar
  love.graphics.draw(cat, xcat, ycat) -- gato
end 
function colisaoapple()
  xco = vetor_plat[8].posx --coordenadas relativas à maçã
  yco = vetor_plat[8].posy
  if CheckBoxCollision(dicaprio.xdi, dicaprio.ydi+dicaprio.height/2, dicaprio.width,dicaprio.height,xco,yco,40,61) then
    descol = true
  end
  if descol == true then
    if endgame == false then
    pontos = pontos + 10
    end
    desenhar = false
    descol = false
  end
--maçã
  xco = vetor_plat[8].posx
  yco = vetor_plat[8].posy-55
  if desenhar == true then --se ele não tiver colidindo com a maçã ela estará desenhado no jogo
    love.graphics.draw(apple,xco,yco)
  end  
end
--Fase 3
function fase3update(dt)
  forca = 550 --forca do impulso do dicaprio
  forca2 = 5 --forca que eleva a plataforma
  pontos = pontos 
  yc = -1100
  yi = 1000
  descol = false
  finalf = false
  trocap = false
  desenhar = true
  icebergcollided = false
  dicaprio = {
    xdi = 400,
    ydi = 200,
    width = 50,
    height = 67,
    collided = false,
    anim_time = 0,
    jump = false
  }
  vetor_plat[1] = { posx=400,
    posy=367,
    width = 1024*0.3,
    height = 172*0.2,
    factor = 0.3}
  for x=2,19,1 do
    vetor_plat[x] = {posx = love.math.random(0,550), 
      posy = 550-x * 150,
      width = 1024*0.3,
      height = 172*0.2,
      factor = 0.3}
    vetor_plat[19] = { posx=0,
      posy=550-(19 * 150),
      width = 1024*0.8,
      height = 172*0.2,
      factor = 0.8}
    end
    police = {
    anim_frame = 1,
    xpo= vetor_plat[5].posx, --coordenadas relativas ao policial
    ypo = vetor_plat[5].posy,
    anim_time = 0
  } 
end
function fase3draw()
  love.graphics.draw(fundo3, 0, yc) -- fundo2
  if desenhar == true then --se ele não tiver colidindo com o dinheiro esse estará desenhado no jogo
    love.graphics.draw(money,xco,yco + 15) --dinheiro
  end
  policedraw()
end 
function colisaomoney()
  xco = vetor_plat[8].posx --coordenadas relativas à maçã
  yco = vetor_plat[8].posy
  if CheckBoxCollision(dicaprio.xdi, dicaprio.ydi+dicaprio.height/2, dicaprio.width,dicaprio.height,xco,yco,50,61) then
    descol = true
  end
  if descol == true then
    if endgame == false then
    pontos = pontos + 10
    end
    desenhar = false
    descol = false
  end
--dinheiro
  xco=vetor_plat[8].posx
  yco=vetor_plat[8].posy-55
  if desenhar==true then --se ele não tiver colidindo ele estará desenhado no jogo
    love.graphics.draw(money,xco,yco)
  end  
end  
--Fase 4
function fase4update(dt)
  forca = 550 --forca do impulso do dicaprio
  forca2 = 5 --forca que eleva a plataforma
  pontos = pontos 
  yc = -1100
  yi = 1000
  descol = false
  finalf = false
  trocap = false
  desenhar = true
  icebergcollided = false
  dicaprio = {
    xdi = 400,
    ydi = 200,
    width = 50,
    height = 67,
    collided = false,
    anim_time = 0,
    jump = false
  }
  vetor_plat[1] = { posx=400,
    posy=367,
    width = 1024*0.3,
    height = 172*0.2,
    factor = 0.3}
  for x=2,19,1 do
    vetor_plat[x] = {posx = love.math.random(0,550), 
      posy = 550-x * 150,
      width = 1024*0.3,
      height = 172*0.2,
      factor = 0.3}
    vetor_plat[19] = { posx=0,
      posy=550-(19 * 150),
      width = 1024*0.8,
      height = 172*0.2,
      factor = 0.8}
    end
end
function fase4draw()
  love.graphics.draw(fundo4, 0, yc) -- fundo2
  if desenhar == true then --se ele não tiver colidindo com o remedio esse estará desenhado no jogo
    love.graphics.draw(remedio,xco,yco + 15) --dinheiro
  end
  love.graphics.draw(oscar, 330,vetor_plat[19].posy - 100) --oscar
  love.graphics.draw(aviao, xaviao, yaviao) -- avião
end 
function colisaoremedio()
  xco = vetor_plat[8].posx --coordenadas relativas à maçã
  yco = vetor_plat[8].posy
  if CheckBoxCollision(dicaprio.xdi, dicaprio.ydi+dicaprio.height/2, dicaprio.width,dicaprio.height,xco,yco,35,35) then
    descol = true
  end
  if descol == true then
    if endgame == false then
    pontos = pontos + 10
    end
    desenhar = false
    descol = false
  end
  xco = vetor_plat[8].posx
  yco = vetor_plat[8].posy-55
  if desenhar == true then --se ele não tiver colidindo com o remedio ela estará desenhado no jogo
    love.graphics.draw(remedio,xco,yco)
  end  
end 
function drawcutscene()
  love.graphics.draw(choro[choro_frame],0,0)
  love.graphics.setColor(232,232,65)
  love.graphics.printf("Game Over", 100, 50, 200, "center", 0, 3, 2.3)
  love.graphics.setColor(53,183,252)
  love.graphics.printf(pontos, 100, 300, 200, "center", 0, 3, 2.3)
end
function updatecutscene(dt)
--Programacao relativa ao cutscene em que o personagem chora no game over
  anim_time = anim_time+dt
  if anim_time > 0.2 then -- quando acumular mais de 0.2 vai para a proxima imagem 
    choro_frame = choro_frame + 1
  if choro_frame > 9 then
    choro_frame = 1 
  end
   anim_time = 0
  end
  love.audio.play(musicchoro)
end
function policedraw()
  xpo = vetor_plat[5].posx + 60 --coordenadas relativas ao policial
  ypo = vetor_plat[5].posy
  xpo2 = vetor_plat[12].posx + 110 --coordenadas relativas ao policial2
  ypo2 = vetor_plat[12].posy
    love.graphics.draw(police1,xpo,ypo - 60)
    love.graphics.draw(police2,xpo2,ypo2 - 60)
end
function bonusupa(dt)
  xup = vetor_plat[3].posx --coordenadas relativas à maçã
  yup = vetor_plat[3].posy
  if CheckBoxCollision(dicaprio.xdi, dicaprio.ydi+dicaprio.height/2, dicaprio.width,dicaprio.height,xup,yup,50,50) then
    colupa = true
  end 
  if colupa == true then
    if love.keyboard.isDown(" ") then
      forca = 650
      forca = forca - (10*dt)
    end
  desenhoupa = false  
  end
end 
function bonusupadraw()
if desenhoupa == true then --se ele não tiver colidindo com o upaupa ele estará desenhado no jogo
    love.graphics.draw(upaupa,xup,yup - 57,0,0.67,0.67)
  end  
end