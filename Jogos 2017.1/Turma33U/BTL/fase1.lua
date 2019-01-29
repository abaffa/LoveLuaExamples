pxf1=100
pyf1=350
pysombra=350
chao1=500
local pulof1 = require "pulof1"
local god = require "god"
local fase1 = {
  estaNaFase1 = false,
  speed=0,
  x=250,
  x2,
  img,
  obst,
  tileQuads={},
  tileSize=64,
  tileQuads2={},
  tileSize2=62.5,
  anim_time=0,
  criança_frame=1,
  obst_frame=1,
  lim_cima=200,
  lim_baixo=480,
  vida=2,
  fade_out=0,
}
 function LoadTiles(filename,nx,ny)
  fase1.img=love.graphics.newImage(filename)
  for j=0,nx-1,1 do
    for i=0,ny-1,1 do
      fase1.tileQuads[fase1.criança_frame]=love.graphics.newQuad(i*fase1.tileSize,j*fase1.tileSize,fase1.tileSize,fase1.tileSize,fase1.img:getWidth(),fase1.img:getHeight())
fase1.criança_frame=fase1.criança_frame+1
    end
  end
end
function LoadTiles2(filename,nx,ny)
  fase1.obst=love.graphics.newImage(filename)
  for j=0,nx-1,1 do
    for i=0,ny-1,1 do
      fase1.tileQuads2[fase1.obst_frame]=love.graphics.newQuad(i*fase1.tileSize2,j*fase1.tileSize2,fase1.tileSize2,fase1.tileSize2,fase1.obst:getWidth(),fase1.obst:getHeight())
      fase1.obst_frame=fase1.obst_frame+1
    end
  end
end
function fase1.load()
sfx = love.audio.newSource("sfx.wav","static")
coracao_fase1=love.graphics.newImage("coracao_cheio.png")
fundo_fase1=love.graphics.newImage("cenario_garoto_repete.png")
fundo_fase1_final=love.graphics.newImage("cenario_garoto_final.png")
LoadTiles ("criança.png",4,4)
LoadTiles2("lixeiras.png",2,2)
fase1.criança_frame=9
end
function fase1.update(dt)
  
  -------------------------------------------------CAMERA
  fase1.x=fase1.x+0.25
  if fase1.x>800 then
    fase1.x=800
    end 
  fase1.speed=fase1.speed+(fase1.x*(dt))
  -----------------------------------------PERSONAGEM
  fase1.anim_time=fase1.anim_time+(dt)
 if fase1.anim_time>0.1 then
   fase1.criança_frame=fase1.criança_frame+1
    if fase1.criança_frame>12 then
      fase1.criança_frame=9
    end
    fase1.anim_time=0
    end
  if love.keyboard.isDown("d") and not pulof1.estaPulando then   --  move o personagem para direita
    pxf1=pxf1+(200*dt)
    if pxf1>=704 then
      pxf1=704
    end
  elseif love.keyboard.isDown("a") and not pulof1.estaPulando then   --  move o personagem pra esquerda
    pxf1=pxf1-(150*dt)
    if pxf1<=10 then
      pxf1=10
    end
  end
  if love.keyboard.isDown("w") and not pulof1.estaPulando then   --  move o personagem pra cima
    pyf1=pyf1-(200*dt)
    if pyf1<=fase1.lim_cima then
      pyf1=fase1.lim_cima
    end
  end
  if love.keyboard.isDown("s") and not pulof1.estaPulando then   --  move o personagem pra baixo
    pyf1=pyf1+(200*dt)
    if pyf1>=fase1.lim_baixo then
      pyf1=fase1.lim_baixo
    end
  end
  if pulof1.estaPulando then
    pysombra=pysombra
  else pysombra=pyf1
  end
  if fase1.speed > 29330 then
    fase1.speed= 29330
    fase1.fade_out=fase1.fade_out+(200*dt)
  end
  
  if god.god then
    god.update(dt)
  end
  
  
  ----------------------------------------------------------COLISÃO LAYER 1
  ----------------------------------------PULANDO
  if chao1 < 250 and chao1 > 0 and pulof1.estaPulando and not god.god then
    for k=1,18,1 do
      if pxf1 > k*1586-80-fase1.speed and pxf1 < k*1586+80-fase1.speed then
        if pyf1 > 220-60 and pyf1 < 220+32 then
          if fase1.x > 300  then
            fase1.x=300
          else fase1.x=250
          end
          fase1.vida=fase1.vida-1
          god.god=true
          love.audio.play(sfx)
        end
      end
    end
  end
  --------------------------------SEM PULAR
  for k=1,18,1 do
    if pxf1 > k*1586-80-fase1.speed and pxf1 < k*1586+80-fase1.speed and not pulof1.estaPulando and not god.god then
      if pyf1 > 220-23 and pyf1 < 220+32 then
        if fase1.x > 300  then
          fase1.x=300
        else fase1.x=250
        end
        fase1.vida=fase1.vida-1
        god.god=true
        love.audio.play(sfx)
      end
    end
  end
  ----------------------------------------------------------COLISÃO LAYER 2
  ----------------------------------------PULANDO
  if chao1 < 310 and chao1 > 250 and pulof1.estaPulando and not god.god then
    for k=1,22,1 do
      if pxf1 > k*1300-80-fase1.speed and pxf1 < k*1300+80-fase1.speed then
        if pyf1 > 280-60 and pyf1 < 280+32 then
          if fase1.x > 300  then
          fase1.x=300
          else fase1.x=250
          end
          fase1.vida=fase1.vida-1
          god.god=true
          love.audio.play(sfx)
        end
      end
    end
  end
  --------------------------------SEM PULAR
  for k=1,22,1 do
    if pxf1 > k*1300-80-fase1.speed and pxf1 < k*1300+80-fase1.speed and not pulof1.estaPulando and not god.god then
      if pyf1>280-23 and pyf1<280+32 then
        if fase1.x > 300  then
          fase1.x=300
        else fase1.x=250
        end
        fase1.vida=fase1.vida-1
        god.god=true
        love.audio.play(sfx)
      end
    end
  end
  ----------------------------------------------------------COLISÃO LAYER 3
  ----------------------------------------PULANDO
  if chao1 < 370 and chao1 > 310 and pulof1.estaPulando and not god.god then
    for k=1,32,1 do
      if pxf1 > k*894-80-fase1.speed and pxf1 < k*894+80-fase1.speed then
        if pyf1 > 340-60 and pyf1 < 340+32 then
          if fase1.x > 300  then
            fase1.x=300
          else fase1.x=250
          end
          fase1.vida=fase1.vida-1
          god.god=true
          love.audio.play(sfx)
        end
      end
    end
  end
  --------------------------------SEM PULAR
  for k=1,32,1 do
    if pxf1 > k*894-80-fase1.speed and pxf1 < k*894+80-fase1.speed and not pulof1.estaPulando and not god.god then
      if pyf1 > 340-23 and pyf1 < 340+32 then
        if fase1.x > 300  then
          fase1.x=300
        else fase1.x=250
        end
        fase1.vida=fase1.vida-1
        god.god=true
        love.audio.play(sfx)
      end
    end
  end
 -----------------------------------------------------------COLISÃO LAYER 4
  ----------------------------------------PULANDO
  if chao1 < 430 and chao1 > 370 and pulof1.estaPulando and not god.god then
    for k=1,27,1 do
      if pxf1 > k*1058-80-fase1.speed and pxf1 < k*1058+80-fase1.speed then
        if pyf1 > 400-60 and pyf1 < 400+32 then
          if fase1.x > 300  then
            fase1.x=300
          else fase1.x=250
          end
          fase1.vida=fase1.vida-1
          god.god=true
          love.audio.play(sfx)
        end
      end
    end
  end
  --------------------------------SEM PULAR
  for k=1,27,1 do
    if pxf1 > k*1058-80-fase1.speed and pxf1 < k*1058+80-fase1.speed and not pulof1.estaPulando and not god.god then
      if pyf1>400-23 and pyf1<400+32 then
        if fase1.x > 300  then
          fase1.x=300
        else fase1.x=250
        end
        fase1.vida=fase1.vida-1
        god.god=true
        love.audio.play(sfx)
      end
    end
  end
  ----------------------------------------------------------COLISÃO LAYER 5
  ----------------------------------------PULANDO
  if chao1 < 500 and chao1 > 430 and pulof1.estaPulando and not god.god then
    for k=1,20,1 do
      if pxf1 > k*1426-80-fase1.speed and pxf1 < k*1426+80-fase1.speed then
        if pyf1 > 460-60 and pyf1 < 460+32 then
          if fase1.x > 300  then
            fase1.x=300
          else fase1.x=250
          end
          fase1.vida=fase1.vida-1
          god.god=true
          love.audio.play(sfx)
        end
      end
    end
  end
  --------------------------------SEM PULAR
  for k=1,20,1 do
    if pxf1 > k*1426-80-fase1.speed and pxf1 < k*1426+80-fase1.speed and not pulof1.estaPulando and not god.god then
      if pyf1 > 460-23 and pyf1 < 460+32 then
        if fase1.x > 300  then
          fase1.x=300
        else fase1.x=250
        end
        fase1.vida=fase1.vida-1
        god.god=true
        love.audio.play(sfx)
      end
    end
  end

 end
function fase1.draw()
  love.graphics.setColor(255,255,255)
  ---------------------------------------------------------MAPA
  for k=0,20,1 do
    fase1.x2=k
    love.graphics.draw(fundo_fase1,(fase1.x2*1406.7)-fase1.speed,0,0,2.7)
    love.graphics.draw(fundo_fase1_final,(21*1406.7)-fase1.speed,0,0,2.7)
  end
----------------------------------------------------------PERSONAGEM E OBSTACULOS
  if not god.god then
   for k=1,fase1.vida,1 do
    love.graphics.draw(coracao_fase1,(k*60)+600,0,0,0.1)
   end
  else 
    for k=1,fase1.vida,1 do
    love.graphics.draw(coracao_fase1,(k*60)+600,0,0,0.08)
    end
  end
  
  love.graphics.setColor(0,0,0,100)
  love.graphics.circle("fill",pxf1+50,pysombra+95,38)-- desenha a sombra do personagem

-----------------------------------------------------------LAYER 1

  love.graphics.setColor(255,255,255)
  if pyf1 < 235 and pyf1 > 0 or chao1 <235 and chao1 > 0 and pulof1.estaPulando then -- se o y do player estiver entre  0 e 220 desenha o player nesse intervalo
    love.graphics.draw(fase1.img,fase1.tileQuads[fase1.criança_frame],pxf1,pyf1,0,1.5)
  end
love.graphics.setColor(255,255,255)
  for k=1,18,1 do
    love.graphics.draw(fase1.obst,fase1.tileQuads2[1],k*1586-fase1.speed,220,0,2)-- desenha o obstaculo
  end

-----------------------------------------------------------LAYER 2

  if pyf1 < 295 and pyf1 > 235 or chao1 <395 and chao1 > 235 and pulof1.estaPulando then-- se o y do player estiver entre 220 e 300 desenha o player nesse intervalo
    love.graphics.draw(fase1.img,fase1.tileQuads[fase1.criança_frame],pxf1,pyf1,0,1.5)
  end

  for k=1,22,1 do
    love.graphics.draw(fase1.obst,fase1.tileQuads2[1],k*1300-fase1.speed,280,0,2)-- desenha o obstaculo
  end

-----------------------------------------------------------LAYER 3

  if pyf1 < 355 and pyf1 > 295 or chao1 <355 and chao1 > 295 and pulof1.estaPulando then-- se o y do player estiver entre 300 e 380 desenha o player nesse intervalo
    love.graphics.draw(fase1.img,fase1.tileQuads[fase1.criança_frame],pxf1,pyf1,0,1.5)
  end

  for k=1,32,1 do
    love.graphics.draw(fase1.obst,fase1.tileQuads2[1],k*894-fase1.speed,340,0,2)-- desenha o obstaculo
  end

-----------------------------------------------------------LAYER 4

  if pyf1 < 415 and pyf1 > 355 or chao1 <415 and chao1 > 355 and pulof1.estaPulando then-- se o y do player estiver entre 380 e 460 desenha o player nesse intervalo
    love.graphics.draw(fase1.img,fase1.tileQuads[fase1.criança_frame],pxf1,pyf1,0,1.5)
  end

  for k=1,27,1 do
    love.graphics.draw(fase1.obst,fase1.tileQuads2[1],k*1058-fase1.speed,400,0,2)-- desenha o obstaculo
  end

-----------------------------------------------------------LAYER 5

  if pyf1 < 475 and pyf1 > 415 or chao1 < 475 and chao1 >415 and pulof1.estaPulando then-- se o y do player for maior que 460 desenha o player
    love.graphics.draw(fase1.img,fase1.tileQuads[fase1.criança_frame],pxf1,pyf1,0,1.5)
  end
  for k=1,20,1 do
    love.graphics.draw(fase1.obst,fase1.tileQuads2[1],k*1426-fase1.speed,460,0,2)-- desenha o obstaculo
  end

-----------------------------------------------------------LAYER 6

  if pyf1 > 475 or chao1 >475 and pulof1.estaPulando then-- se o y do player for maior que 460 desenha o player
    love.graphics.draw(fase1.img,fase1.tileQuads[fase1.criança_frame],pxf1,pyf1,0,1.5)
  end
  love.graphics.setColor(0,0,0,fase1.fade_out)
  love.graphics.rectangle("fill",0,0,800,600)
  
  
    
end
return fase1