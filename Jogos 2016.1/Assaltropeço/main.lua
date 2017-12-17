local mapa={}
local menu
local vida = 3
local tile_invencivel
local tile_vida
local icon_start
local icon_credito
local icon_controle
local icon_pause
local icon_continue
local audio_sirene
local audio_escape
local tile_score
local tile_pause
local tile_credito
local tile_dinheirostart
local tile_ladraostart
local tile_policialstart
local tile_arvore1
local tile_arvore2
local tile_barril
local tile_predios
local tile_predios2
local tile_estrada
local tile_poste
local tile_caixa
local score=0
local offset=0
local audio_pulo
local audio_desvio 
local velocidade = 450
local jogo={
  menu=true,
  start=false,
  pause=false,
  gameover=false,
  credito=false,
  controle=false,
  controlepause=false
  }
local carropolicial={
  anim_time=0,
  walk = {},
  pos_x=100,
  pos_y=400,
  anim_frame = 1
  }
local policial={
  anim_time=0,
  walk = {},
  pos_x=100,
  pos_y=400,
  anim_frame = 1
  }
local ladrao={
  pista = 1,
  anim_time = 0,
  agachado = {},
  walk = {}, -- vetor de imagens
  anim_frame = 1,
  pos_x = 100,
  pos_y = 360,
  h=100,
  l=100,
  v0=0,
  pulando=false,
  pos_y_inicial = 360}
local caixas = {}
local barril = {}
local lixeira = {}
local vidas = {}
local invencivel = {
  invenc = false,
  time = 0,
  powerup = 10,
  }
function createCaixa(x,y,pista)
  table.insert(caixas,{x=x, y=y, colidiu=false, pista =pista})
end
function createBarril(x,y,pista)
  table.insert(barril,{x=x, y=y, colidiu=false, pista = pista})
end
function createLixeira(x,y,pista)
  table.insert(lixeira,{x=x,y=y, colidiu=false, pista = pista})
end
function createVida(x,y,pista)
  table.insert(vidas,{x=x, y=y, colidiu=false, pista = pista})
end
function createInvencivel(x,y,pista)
  table.insert(invencivel,{x=x, y=y, colidiu=false, pista = pista})
end

function reinicia()
  jogo.pause=false
  jogo.gameover=false
  ladrao.pos_x = 100
  ladrao.pos_y = 360
  ladrao.pista = 1
  pulando = false
  ladrao.anim_frame = 1
  score = 0
  offset = 0
  vida = 3
  velocidade = 400
  for i,v in ipairs(caixas) do
    v.colidiu = false
  end
   for i,v in ipairs (lixeira) do
    v.colidiu = false
  end
  for i,v in ipairs (barril) do
    v.colidiu = false
  end
  for i,v in ipairs (invencivel) do
    v.colidiu = false
  end
  for i,v in ipairs (vidas) do
    v.colidiu = false
  end
end
function LoadMap(arq)
  local file=io.open(arq)
  local i=1
  for line in file:lines() do
    mapa[i]={}
    for j=1,#line,1 do
      mapa[i][j]= line:sub(j,j)
    end
    i=i+1
  end
  file:close()
end
function CheckBoxCollision(x1,y1,w1,h1,x2,y2,w2,h2)
return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end
function CheckClick(x1,y1,w1,h1,x2,y2)
  return x1 < x2+1 and x2 < x1+w1 and y1 < y2+1 and y2 < y1+h1
end
function love.mousepressed(x, y, button)
  if button == 1 and jogo.menu==true then
    if CheckClick(200,200,443,40,x,y) then
      jogo.menu=false
      jogo.start=true
      love.audio.play(audio_escape)
    end
    if CheckClick(320,450,206,36,x,y) then
      jogo.menu=false
      jogo.credito=true
    end
    if CheckClick(270,300,306,52,x,y) then
      jogo.menu=false
      jogo.controle=true
    end
  end
  if button == 1 and jogo.start==true then
    if CheckClick(750,10,40,40,x,y) then
      jogo.pause=true
      jogo.start=false
    end
  end
  if button == 1 and jogo.pause==true then
    if CheckClick(200,400,80,80,x,y) then
      jogo.pause=false
      jogo.menu=true
      reinicia()
    end
    if CheckClick(500,400,80,80,x,y) then
      reinicia()
      jogo.pause=false
      jogo.start=true
    end
    if CheckClick(270,250,306,52,x,y) then
      jogo.controlepause=true
      jogo.pause=false
    end
    if CheckClick(350,400,96,96,x,y) then
      jogo.start=true
      jogo.pause=false
    end
  end
  if button == 1 and jogo.controle==true then
    if CheckClick(360,430,80,80,x,y) then
      jogo.controle=false
      jogo.menu=true
    end
  end
  if button == 1 and jogo.controlepause==true then
    if CheckClick(360,430,80,80,x,y) then
      jogo.controlepause=false
      jogo.pause=true
    end
  end
  if button == 1 and jogo.credito==true then
    if CheckClick(360,430,80,80,x,y) then
      jogo.credito=false
      jogo.menu=true
    end
  end
  if button == 1 and jogo.gameover==true then
    if CheckClick(270,400,80,80,x,y) then
      jogo.menu=true
      reinicia()
      love.audio.play(audio_escape)
    end
    if CheckClick(430,400,80,80,x,y) then
      reinicia()
    end
  end
end
function love.load()
  love.graphics.setBackgroundColor(39,28,114)
  love.graphics.setColor(255,255,255)
  icone = love.image.newImageData("ladrao02.png")
  love.window.setIcon(icone)
  icon_escape = love.graphics.newImage("escape.png")
  icon_controle = love.graphics.newImage("controles1.png")
  icon_credito = love.graphics.newImage("créditos1.png")
  icon_pause = love.graphics.newImage("pause.png")
  icon_continue = love.graphics.newImage("play.png")
  audio_escape = love.audio.newSource("escape.wav")
  audio_sirene = love.audio.newSource("sirene2.mp3")
  LoadMap("Mapa01.txt")
  tile_score = love.graphics.newImage("score.png")
  tile_pause = love.graphics.newImage("pause_escrito.png")
  tile_controle = love.graphics.newImage("Controles.png")
  tile_credito = love.graphics.newImage("Créditos.png")
  tile_poste = love.graphics.newImage("Poste.png")
  tile_predios2 = love.graphics.newImage("Predios2.png")
  tile_arvore1 = love.graphics.newImage("Arvore1.png")
  tile_arvore2 = love.graphics.newImage("Arvore2.png")
  tile_predios = love.graphics.newImage("Predios.png")
  tile_estrada = love.graphics.newImage("estrada.png")
  tile_dinheirostart = love.graphics.newImage("dinheiro.png")
  tile_policialstart = love.graphics.newImage("policial01.png")
  tile_ladraostart = love.graphics.newImage("ladrao02.png")
  tile_caixa = love.graphics.newImage("Caixa.png")
  icon_start = love.graphics.newImage("start.png")
  tile_barril = love.graphics.newImage("barril.png")
  tile_lixeira = love.graphics.newImage("lixeira.png")
  audio_pulo = love.audio.newSource("Jump7.wav")
  audio_desvio = love.audio.newSource("Jump3.wav")
  gameover = love.graphics.newImage("gameover.png")
  restart = love.graphics.newImage("restart.png")
  menu = love.graphics.newImage("menu.png")
  tile_vida = love.graphics.newImage("coracao.png")
  tile_vida = love.graphics.newImage("vida.png")
  tile_invencivel = love.graphics.newImage("defense.png")
  
  for x = 1, 2, 1 do -- carrega as imagens da animação
    ladrao.walk[x] = love.graphics.newImage("ladrao0" .. x .. ".png")
  end
  for y = 1, 2, 1 do
    ladrao.agachado[y] = love.graphics.newImage("ladraoagachado0"..y..".png")
  end
  for z=1, 2, 1 do
    policial.walk[z] = love.graphics.newImage("policial0"..z..".png")
  end
  for k = 1, 2, 1 do
    carropolicial.walk[k] = love.graphics.newImage("carropolicial0"..k..".png")
end
  myfont = love.graphics.newFont("ARDESTINE.ttf", 25)
  love.graphics.setFont(myfont)
  love.window.setTitle("O Assaltropeço")
  createInvencivel(4300,480,1)
createInvencivel(28700,480,1)
createVida(2300,480,1)
createCaixa(1700,480,1)
createBarril(2000,460,1)
createCaixa(2400,480,1)
createBarril(2700,540,2)
createCaixa(3100,480,1)
createBarril(3600,460,1)
createCaixa(3900,540,2)
createBarril(4100,460,1)
createCaixa(4500,480,1)
createBarril(4800,540,2)
createCaixa(5200,480,1)
createBarril(5500,540,2)
createCaixa(5900,540,2)
createBarril(6200,460,1)
createCaixa(6600,480,1)
createVida(7400,540,2)
createBarril(6900,460,1)
createCaixa(7300,540,2)
createBarril(7800,540,2)
createBarril(7800,480,1)
createCaixa(8100,540,2)
createBarril(8300,460,1)
createCaixa(8700,480,1)
createBarril(9000,540,2)
createCaixa(9400,540,2)
createBarril(9700,460,1)
createCaixa(10100,480,1)
createBarril(10400,540,2)
createCaixa(10800,480,1)
createBarril(11100,460,1)
createCaixa(11500,480,1)
createBarril(11800,540,2)
createCaixa(12200,540,2)
createBarril(12500,460,1)
createCaixa(12900,480,1)
createBarril(13200,540,2)
createCaixa(13600,540,2)
createBarril(13900,540,2)
createCaixa(14300,480,1)
createBarril(14600,460,1)
createCaixa(15000,540,2)
createBarril(15300,540,2)
createCaixa(15700,480,1)
createVida(15800,540,2)
createBarril(16000,540,2)
createCaixa(16400,480,1)
createBarril(16700,540,2)
createCaixa(17100,540,2)
createBarril(17400,460,1)
createCaixa(17800,540,2)
createBarril(18100,540,2)
createCaixa(18500,480,1)
createVida(18450,480,1)
createInvencivel(18450,540,2)
createBarril(18800,460,1)
createCaixa(19200,540,2)
createBarril(19500,540,2)
createCaixa(19900,480,1)
createBarril(20200,540,2)
createCaixa(20600,540,2)
createBarril(20900,460,1)
createCaixa(21300,540,2)
createBarril(21600,540,2)
createCaixa(22000,480,1)
createBarril(22300,540,2)
createCaixa(22700,540,2)
createCaixa(22850,480,1)
createBarril(23000,540,2)
createCaixa(23400,540,2)
createBarril(23700,460,1)
createCaixa(24100,540,2)
createBarril(24400,540,2)
createCaixa(24800,480,1)
createBarril(25100,540,2)
createCaixa(25500,480,1)
createBarril(25800,460,1)
createCaixa(26200,540,2)
createBarril(26500,540,2)
createCaixa(26900,480,1)
createBarril(27200,460,1)
createCaixa(27600,480,1)
createBarril(27900,540,2)
createCaixa(28300,540,2)
  
end
function love.draw()
  if jogo.menu == true then
  reinicia()
  jogo.gameover=false
  jogo.pause=false
  jogo.credito=false
  jogo.controle=false
  love.graphics.setColor(255,255,255)
  love.graphics.draw(tile_dinheirostart,0,0,0,0.55)
  love.graphics.setBackgroundColor(255,255,255)
  love.graphics.setColor(0,0,0)
  myfont = love.graphics.newFont("ARDESTINE.ttf", 90)
  love.graphics.setFont(myfont)
  love.graphics.print("O ASSALTROPEÇO",50,70)
  love.graphics.draw(icon_start,200,200,0,0.5,0.5)
  love.graphics.draw(icon_credito,320,450)
  love.graphics.draw(icon_controle,270,300)
  love.graphics.setColor(255,255,255)
  love.graphics.draw(tile_ladraostart,560,400)
  love.graphics.draw(tile_policialstart,40,350,0,1.1)
elseif jogo.controle==true then
  jogo.menu=false
  jogo.gameover=false
  love.graphics.draw(tile_dinheirostart,0,0,0,0.55)
  love.graphics.draw(menu,360,430,0,0.4,0.4)
  love.graphics.setColor(0,0,0)
  love.graphics.draw(tile_controle,180,120)
  love.graphics.setColor(255,255,255)
elseif jogo.controlepause==true then
  jogo.menu=false
  jogo.gameover=false
  jogo.pause=false
  love.graphics.draw(tile_dinheirostart,0,0,0,0.55)
  love.graphics.draw(restart,360,430,0,0.4,0.4)
  love.graphics.setColor(0,0,0)
  love.graphics.draw(tile_controle,180,120)
  love.graphics.setColor(255,255,255)
elseif jogo.credito==true then
  jogo.pause=false
  jogo.gameover=false
  love.graphics.setColor(255,255,255)
  love.graphics.draw(tile_dinheirostart,0,0,0,0.55)
  love.graphics.draw(menu,360,430,0,0.4,0.4)
  love.graphics.setColor(0,0,0)
  love.graphics.draw(tile_credito,200,80,0,1.5,1.5)
elseif jogo.gameover==true then
  jogo.pause=false
  jogo.credito=false
  jogo.controle=false
  love.graphics.draw(tile_dinheirostart,0,0,0,0.55)
  love.graphics.setColor(0,0,0)
  love.graphics.print(math.floor(score),500,270,0,2)
  love.graphics.setColor(255,255,255)
  love.graphics.draw(tile_score,200,280)
  love.graphics.draw(gameover,220,50,0,1.5,1.5)
  love.graphics.draw(restart,430,400,0,0.4,0.4)
  love.graphics.draw(menu,270,400,0,0.4,0.4)
elseif jogo.pause==true then
  jogo.start=false
  jogo.menu=false
  love.graphics.draw(tile_dinheirostart,0,0,0,0.55)
  love.graphics.setColor(0,0,0)
  love.graphics.draw(icon_continue,350,400)
  love.graphics.draw(icon_controle,270,250)
  love.graphics.setColor(255,255,255)
  love.graphics.draw(tile_pause,200,25,0,3.5,3.5)
  love.graphics.draw(restart,500,400,0,0.4,0.4)
  love.graphics.draw(menu,200,400,0,0.4,0.4)
elseif jogo.start==true then
  jogo.menu=false
  jogo.pause=false
  jogo.credito=false
  --love.audio.play(audio_sirene)
  love.graphics.draw(icon_pause,750,10,0,0.2,0.2)
  love.graphics.setBackgroundColor(10,10,10)
  myfont = love.graphics.newFont("ARDESTINE.ttf", 20)
  love.graphics.setFont(myfont)
  for i=1,25,1 do
    for j=1,4000,1 do
      if(mapa[i][j]=="E") then
        love.graphics.draw(tile_estrada,(j*24)-24-offset,(i*24),0,0.92)
      end
      if(mapa[i][j]=="P") then
        love.graphics.draw(tile_poste,(j*24)-24-offset,(i*24)-10,0,-1,0.47)
      end
      if(mapa[i][j]=="C") then
        --love.graphics.draw(tile_caixa,(j*24)-24-offset,(i*24),0,0.3)
    end
    if(mapa[i][j]=="U") then
        love.graphics.draw(tile_predios,(j*24)-27-offset,(i*24)-105,0,0.7,0.7)
    end
    if(mapa[i][j]=="K") then
        love.graphics.draw(tile_predios2,(j*24)-35-offset,(i*24)-105,0,-0.7,0.7)
    end
    if(mapa[i][j]=="A") then
        love.graphics.draw(tile_arvore1,(j*24)-24-offset,(i*24)-30)
       end
    if (mapa[i][j]=="Á") then
        love.graphics.draw(tile_arvore2,(j*24)-24-offset,(i*24)-30)
      end
    end
  love.graphics.print(math.floor(score),10,10,0,1.2)
  if invencivel.invenc == true then
  love.graphics.print(math.floor(invencivel.powerup),400, 40, 0, 1.2)
  end
  for i,v in ipairs(caixas) do
    love.graphics.draw(tile_caixa,v.x-offset,v.y,0,0.3)
    --love.graphics.rectangle("line", v.x-offset, v.y,181*0.3,175*0.3)
  end
  for i,v in ipairs(barril) do
    love.graphics.draw(tile_barril,v.x-offset,v.y,0,0.33)
     --love.graphics.rectangle("line", v.x-offset, v.y,151*0.3,204*0.3)
  end
  for i,v in ipairs(lixeira) do
    love.graphics.draw(tile_lixeira,v.x-offset,v.y,0,0.32)
  end
  for i,v in ipairs(vidas) do
    if not v.colidiu then
      love.graphics.draw(tile_vida,v.x-offset,v.y,0,0.07)
    end
  end
  for i,v in ipairs(invencivel) do
    if not v.colidiu then
      love.graphics.draw(tile_invencivel,v.x-offset,v.y,0)
    end
  end
  for i=1,vida do
    love.graphics.draw(tile_vida,(i*44)+280,15,0,0.05)
  end
  love.graphics.draw(policial.walk[policial.anim_frame], policial.pos_x-100, policial.pos_y-20,0,0.7)
  love.graphics.draw(carropolicial.walk[carropolicial.anim_frame], carropolicial.pos_x-130, carropolicial.pos_y-20,0,1.3)
  love.graphics.draw(policial.walk[policial.anim_frame], policial.pos_x-160, policial.pos_y+30,0,0.7)
  love.graphics.draw(policial.walk[policial.anim_frame], policial.pos_x-80, policial.pos_y+70,0,0.7)
  if love.keyboard.isDown("x") then
    love.graphics.draw(ladrao.agachado[ladrao.anim_frame], ladrao.pos_x+160, ladrao.pos_y+80,0,0.7)
    else
      love.graphics.draw(ladrao.walk[ladrao.anim_frame], ladrao.pos_x+200, ladrao.pos_y+75,0,0.65)
    end
    --love.graphics.rectangle("line", ladrao.pos_x+200, ladrao.pos_y+50, ladrao.l*0.7, ladrao.h*0.7)
  end
  
  if ladrao.pos_x+200 <= 150 then
  jogo.gameover=true
  end
end
end
function love.update(dt)
  if jogo.start==true and jogo.gameover==false and jogo.pause==false and jogo.credito==false and jogo.controle==false then
 offset=offset+(velocidade*dt)
 velocidade = velocidade + 4*dt
 if offset> 1025*24 then
   offset = 0
  for i,v in ipairs (caixas) do
    v.colidiu = false
  end
  for i,v in ipairs (lixeira) do
    v.colidiu = false
  end
  for i,v in ipairs (barril) do
    v.colidiu = false
  end
  for i,v in ipairs (invencivel) do
    v.colidiu = false
  end
  for i,v in ipairs (vidas) do
    v.colidiu = false
  end
 end
 policial.pos_x = policial.pos_x
 policial.anim_time = policial.anim_time + dt -- incrementa o tempo usando dt
  if policial.anim_time > 0.1 then
    policial.anim_frame = policial.anim_frame + 1 -- incrementa a animação
    policial.anim_time = 0
    if policial.anim_frame > 2 then
      policial.anim_frame = 1
    end
  end
 ladrao.pos_x = ladrao.pos_x
 ladrao.anim_time = ladrao.anim_time + dt -- incrementa o tempo usando dt
  if ladrao.anim_time > 0.1 then
    ladrao.anim_frame = ladrao.anim_frame + 1 -- incrementa a animação
    ladrao.anim_time = 0
    if (ladrao.anim_frame > 2 and not love.keyboard.isDown("down")) or (ladrao.anim_frame > 2 and love.keyboard.isDown("down")) then -- loop da animação
      ladrao.anim_frame = 1
    end
  end
  invencivel.time = invencivel.time + dt
  invencivel.powerup = invencivel.powerup - dt
  
  if invencivel.time > 6 then
    invencivel.invenc = false
  end
  carropolicial.pos_x = carropolicial.pos_x
 carropolicial.anim_time = carropolicial.anim_time + dt -- incrementa o tempo usando dt
  if carropolicial.anim_time > 0.1 then
    carropolicial.anim_frame = carropolicial.anim_frame + 1 -- incrementa a animação
    carropolicial.anim_time = 0
    if carropolicial.anim_frame > 2 then
      carropolicial.anim_frame = 1
    end 
  end
    
 
  if ladrao.pulando then 
  ladrao.v0 = ladrao.v0 + 380*dt
  ladrao.pos_y = ladrao.pos_y + ladrao.v0*(dt)
  if ladrao.v0 >= 250 then
    ladrao.pulando = false
    ladrao.v0 = 0
    if ladrao.pista == 1 then
      ladrao.pos_y = ladrao.pos_y_inicial
    elseif ladrao.pista == 2 then
      ladrao.pos_y = ladrao.pos_y_inicial + 50
    end
    ladrao.anime_frame = 1
end
end
 if not invencivel.invenc then
 for i,v in ipairs(caixas) do
   if ladrao.pista == v.pista and CheckBoxCollision(ladrao.pos_x+170.3, ladrao.pos_y+140, ladrao.l*0.7, 28, v.x-offset, v.y,50.3,50.3)  and not v.colidiu then
     ladrao.pos_x=ladrao.pos_x - 50
     v.colidiu = true
     vida = vida -1
   end
 end
 for i,v in ipairs(barril) do
   if ladrao.pista == v.pista and CheckBoxCollision(ladrao.pos_x+170.3, ladrao.pos_y+140, ladrao.l*0.7, 28, v.x-offset, v.y,151.3*0.3,204*0.3)  and not v.colidiu then
     ladrao.pos_x=ladrao.pos_x - 50
     v.colidiu = true
     vida = vida - 1
   end
 end
 for i,v in ipairs(lixeira) do
   if ladrao.pista == v.pista  and CheckBoxCollision(ladrao.pos_x+170.3, ladrao.pos_y+140, ladrao.l*0.7, 28, v.x-offset, v.y,155*0.3,217*0.3)  and not v.colidiu then
     ladrao.pos_x=ladrao.pos_x - 50
     v.colidiu = true
     vida = vida -1
   end
 end
 for i,v in ipairs(vidas) do
   if ladrao.pista == v.pista and CheckBoxCollision(ladrao.pos_x+170.3, ladrao.pos_y+140, ladrao.l*0.7, 28, v.x-offset, v.y,155*0.3,217*0.3) and not v.colidiu then
     if ladrao.pos_x < 100 then 
       ladrao.pos_x=ladrao.pos_x + 50
       vida = vida+1
     end
     v.colidiu = true
     
   end
 end
 for i,v in ipairs(invencivel) do
 if ladrao.pista == v.pista and CheckBoxCollision(ladrao.pos_x+170.3, ladrao.pos_y+140, ladrao.l*0.7, 28, v.x-offset, v.y,155*0.3,217*0.3)   and not v.colidiu then
       invencivel.powerup = 6
       invencivel.time = 0
       invencivel.invenc=true
     v.colidiu = true
   end
 end
score = score + (velocidade/40) * dt
end
end
function love.keypressed(key)
  if key=="space" and not ladrao.pulando then 
    ladrao.pulando=true
    ladrao.v0 = -250
    love.audio.play(audio_pulo)
  end
  if (key == "up") and ladrao.pulando == false then
    ladrao.pos_y=360
    ladrao.pista = 1
    love.audio.play(audio_desvio)
  end
  if (key == "down") and ladrao.pulando == false then
    ladrao.pos_y=410
    ladrao.pista = 2
    love.audio.play(audio_desvio)
  end
end
end