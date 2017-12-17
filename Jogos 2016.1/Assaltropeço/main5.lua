local mapa={}
local menu
local icon_start
local vida = 3
local audio_escape
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
local tile_invencivel
local tile_vida
local score=0
local offset=0
local audio_pulo
local audio_desvio  
local jogo = {
  start = false
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
  invenc = false}
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
  ladrao.pos_x = 100
  ladrao.pos_y = 360
  ladrao.pista = 1
  pulando = false
  ladrao.anim_frame = 1
  score = 0
  offset = 0
  vida = 3
  for i,v in ipairs (caixas) do
    v.colidiu = false
  end
  for i,v in ipairs (lixeira) do
    v.colidiu = false
  end
  for i,v in ipairs (barril) do
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
  if button == 1 then
    if CheckClick(200,200,443,40,x,y) then
      jogo.start=true
      love.audio.play(audio_escape)
    end
    if CheckClick (240, 350, 104, 104, x,y) then
      jogo.start = false
      reinicia ()
      love.audio.play(audio_escape)
    end
    if CheckClick(450,350,101,101,x,y) then
      reinicia()
    end
  end
end
function love.load()
  love.graphics.setBackgroundColor(39,28,114)
  love.graphics.setColor(255,255,255)
  myfont = love.graphics.newFont("ARDESTINE.ttf",80)
  love.graphics.setFont(myfont)
  icon_start = love.graphics.newImage("start.png")
  audio_escape = love.audio.newSource("escape.wav")
  LoadMap("Mapa01.txt")
  tile_poste = love.graphics.newImage("Poste.png")
  tile_predios2 = love.graphics.newImage("Predios2.png")
  tile_arvore1 = love.graphics.newImage("Arvore1.png")
  tile_arvore2 = love.graphics.newImage("Arvore2.png")
  tile_predios = love.graphics.newImage("Predios.png")
  tile_estrada = love.graphics.newImage("estrada.png")
  tile_caixa = love.graphics.newImage("Caixa.png")
  tile_barril = love.graphics.newImage("barril.png")
  tile_lixeira = love.graphics.newImage("lixeira.png")
  tile_dinheirostart = love.graphics.newImage("dinheiro.png")
  tile_policialstart = love.graphics.newImage("policial01.png")
  tile_ladraostart = love.graphics.newImage("ladrao02.png")
  tile_vida = love.graphics.newImage("coracao.png")
  love.graphics.setBackgroundColor(39,28,114)
  tile_vida = love.graphics.newImage("vida.png")
  tile_invencivel = love.graphics.newImage("speed.png")
  
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
  createCaixa(800,480,1)
  createLixeira(1200,460,1)
  createCaixa(1600,540,2)
  --createBarril(1700,440)
  createCaixa(1800,480,1)
  createCaixa(2000,480,1)
  createCaixa(2400,540,2)
  createLixeira(2600,530,2)
  createBarril(2800,460,1)
  createCaixa(3200,480,1)
  createCaixa(3600,480,1)
  createBarril(3900,540,2)
  createCaixa(4100,480,1)
  --createLixeira(4300,460)
  createLixeira(4400,530,2)
  createCaixa(4500,480,1)
  createCaixa(5200,480,1)
  createBarril(5300,460,1)
  createBarril(5450,540,2)
  --createCaixa(6600,480)
  createCaixa(7000,580,2)
  createCaixa(7400,480,1)
  createBarril(7450,540,2)
  createBarril(7600,460,1)
  createCaixa(7800,480,1)
  createLixeira(7800,530,2)
  createLixeira(8000,460,1)
  createCaixa(8200,480,1)
  createLixeira(8400,460,1)
  createBarril(8400,540,2)
  createCaixa(8600,480,1)
  createLixeira(8700,460,1)
  createVida(1390,470,1)
  createInvencivel(2200,460,1)
  
  audio_pulo=love.audio.newSource("Jump7.wav")
  audio_desvio=love.audio.newSource("Jump3.wav")
  gameover=love.graphics.newImage("gameover.png")
  restart=love.graphics.newImage("restart.png")
  menu=love.graphics.newImage("menu.png")
end
function love.draw()
  
  if jogo.start == false then
  love.graphics.setColor(255,255,255)
  love.graphics.draw(tile_dinheirostart,0,0,0,0.55)
  love.graphics.setBackgroundColor(255,255,255)
  love.graphics.setColor(0,0,0)
  myfont = love.graphics.newFont("ARDESTINE.ttf", 90)
  love.graphics.setFont(myfont)
  love.graphics.print("O ASSALTROPEÇO",50,70)
  love.graphics.draw(icon_start,200,200,0,0.5,0.5)
  love.graphics.setColor(255,255,255)
  love.graphics.draw(tile_ladraostart,560,400)
  love.graphics.draw(tile_policialstart,40,350,0,1.1)
else
  love.graphics.setBackgroundColor(0,0,0)
  myfont = love.graphics.newFont("ARDESTINE.ttf", 20)
  love.graphics.setFont(myfont)
  for i=1,25,1 do
    for j=1,1025,1 do
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
  love.graphics.print(math.floor(score),730,10,0,1.2)
  for i,v in ipairs(caixas) do
    love.graphics.draw(tile_caixa,v.x-offset,v.y,0,0.3)
    love.graphics.rectangle("line", v.x-offset, v.y,181*0.3,175*0.3)
  end
  for i,v in ipairs(barril) do
    love.graphics.draw(tile_barril,v.x-offset,v.y,0,0.33)
     love.graphics.rectangle("line", v.x-offset, v.y,151*0.3,204*0.3)
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
    love.graphics.draw(tile_vida,(i*44)-40,0,0,0.05)
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
    love.graphics.rectangle("line", ladrao.pos_x+170.3, ladrao.pos_y+140, ladrao.l*0.7, ladrao.h*0.7)
  end
 
  if ladrao.pos_x+200 <= 150 then
    love.graphics.draw(tile_dinheirostart,0,0,0,0.55)
    love.graphics.draw(gameover,180,100,0,2)
    love.graphics.draw(restart,430,350,0,0.34)
    love.graphics.draw(menu,240,350,0,0.08)
  end
end
end
function love.update(dt)
  if jogo.start==true then
 offset=offset+(400*dt)
 if offset> 1025*24 then
   offset = 0
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
      
       invencivel.invenc=true
     v.colidiu = true
   end
 end
score = score +10 * dt
end
function love.keypressed(key)
  if key=="space" and       not ladrao.pulando then 
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
end