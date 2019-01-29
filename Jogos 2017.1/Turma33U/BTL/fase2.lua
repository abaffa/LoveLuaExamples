pxf2=100
pyf2=350
chao2=500
local pulof1 = require "pulof1"
local god = require "god"
local fase2 = {
  estaNaFase2 = false,
  speed=0,
  x=250,
  x2,
  img,
  obst,
  tileQuads3={},
  tileSize3=44,
  tileQuads4={},
  tileSize4=62.5,
  anim_time=0,
  criança_frame=1,
  obst_frame=1,
  lim_cima=240,
  lim_baixo=500,
  vida=2,
  fade_out=0,
}
 function LoadTiles3(filename,nx,ny)
  fase2.img=love.graphics.newImage(filename)
  for j=0,nx-1,1 do
    for i=0,ny-1,1 do
      fase2.tileQuads3[fase2.criança_frame]=love.graphics.newQuad(i*fase2.tileSize3,j*fase2.tileSize3,fase2.tileSize3,fase2.tileSize3,fase2.img:getWidth(),fase2.img:getHeight())
fase2.criança_frame=fase2.criança_frame+1
    end
  end
end
function LoadTiles4(filename,nx,ny)
  fase2.obst=love.graphics.newImage(filename)
  for j=0,nx-1,1 do
    for i=0,ny-1,1 do
      fase2.tileQuads4[fase2.obst_frame]=love.graphics.newQuad(i*fase2.tileSize4,j*fase2.tileSize4,fase2.tileSize4,fase2.tileSize4,fase2.obst:getWidth(),fase2.obst:getHeight())
      fase2.obst_frame=fase2.obst_frame+1
    end
  end
end
function fase2.load()
coracao_fase2=love.graphics.newImage("coracao_cheio.png")
fundo_fase2=love.graphics.newImage("cenario_tiazinha.png")
fundo_fase2_final=love.graphics.newImage("cenario_tiazinha.png")
LoadTiles3 ("jovem.png",4,4)
LoadTiles4("lixeiras.png",2,2)
fase2.criança_frame=9
end
function fase2.update(dt)
  
  -------------------------------------------------CAMERA
  fase2.x=fase2.x+0.25
  if fase2.x>1000 then
    fase2.x=1000
  end 
  fase2.speed=fase2.speed+(fase2.x*(dt))
  -----------------------------------------PERSONAGEM
  fase2.anim_time=fase2.anim_time+(dt)
 if fase2.anim_time>0.1 then
   fase2.criança_frame=fase2.criança_frame+1
    if fase2.criança_frame>12 then
      fase2.criança_frame=9
    end
    fase2.anim_time=0
    end
  if love.keyboard.isDown("d") and not pulof1.estaPulando then   --  move o personagem para direita
    pxf2=pxf2+(200*dt)
    if pxf2>=704 then
      pxf2=704
    end
  elseif love.keyboard.isDown("a") and not pulof1.estaPulando then   --  move o personagem pra esquerda
    pxf2=pxf2-(150*dt)
    if pxf2<=10 then
      pxf2=10
    end
  end
  if love.keyboard.isDown("w") and not pulof1.estaPulando then   --  move o personagem pra cima
    pyf2=pyf2-(200*dt)
    if pyf2<=fase2.lim_cima then
      pyf2=fase2.lim_cima
    end
  end
  if love.keyboard.isDown("s") and not pulof1.estaPulando then   --  move o personagem pra baixo
    pyf2=pyf2+(200*dt)
    if pyf2>=fase2.lim_baixo then
      pyf2=fase2.lim_baixo
    end
  end
  if pulof1.estaPulando then
    pysombra=pysombra
  else pysombra=pyf2
  end
  if fase2.speed > 31600 then
    fase2.fade_out=fase2.fade_out+(200*dt)
  end
  
  if god.god then
    god.update(dt)
  end
  
  
  ----------------------------------------------------------COLISÃO LAYER 1
  ----------------------------------------PULANDO
  if chao2 < 275 and chao2 > 217 and pulof1.estaPulando and not god.god then
    for k=1,24,1 do
      if pxf2 > k*1312-80-fase2.speed and pxf2 < k*1312+80-fase2.speed then
        if pyf2 > 240-30 and pyf2 < 240+32 then
          if fase2.x > 300  then
            fase2.x=300
          else fase2.x=250
          end
          fase2.vida=fase2.vida-1
          god.god=true
          love.audio.play(sfx)
        end
      end
    end
  end
  --------------------------------SEM PULAR
  for k=1,24,1 do
    if pxf2 > k*1312-80-fase2.speed and pxf2 < k*1312+80-fase2.speed and not pulof1.estaPulando and not god.god then
      if pyf2 > 240-23 and pyf2 < 240+32 then
        if fase2.x > 300  then
          fase2.x=300
        else fase2.x=250
        end
        fase2.vida=fase2.vida-1
        god.god=true
        love.audio.play(sfx)
      end
    end
  end
  ----------------------------------------------------------COLISÃO LAYER 2
  ----------------------------------------PULANDO
  if chao2 < 335 and chao2 > 277 and pulof1.estaPulando and not god.god then
    for k=1,26,1 do
      if pxf2 > k*1215-80-fase2.speed and pxf2 < k*1215+80-fase2.speed then
        if pyf2 > 300-30 and pyf2 < 300+32 then
          if fase2.x > 300  then
          fase2.x=300
          else fase2.x=250
          end
          fase2.vida=fase2.vida-1
          god.god=true
          love.audio.play(sfx)
        end
      end
    end
  end
  --------------------------------SEM PULAR
  for k=1,26,1 do
    if pxf2 > k*1215-80-fase2.speed and pxf2 < k*1215+80-fase2.speed and not pulof1.estaPulando and not god.god then
      if pyf2>300-23 and pyf2<300+32 then
        if fase2.x > 300  then
          fase2.x=300
        else fase2.x=250
        end
        fase2.vida=fase2.vida-1
        god.god=true
        love.audio.play(sfx)
      end
    end
  end
  ----------------------------------------------------------COLISÃO LAYER 3
  ----------------------------------------PULANDO
  if chao2 < 392 and chao2 > 337 and pulof1.estaPulando and not god.god then
    for k=1,42,1 do
      if pxf2 > k*743-80-fase2.speed and pxf2 < k*743+80-fase2.speed then
        if pyf2 > 360-30 and pyf2 < 360+32 then
          if fase2.x > 300  then
            fase2.x=300
          else fase2.x=250
          end
          fase2.vida=fase2.vida-1
          god.god=true
          love.audio.play(sfx)
        end
      end
    end
  end
  --------------------------------SEM PULAR
  for k=1,42,1 do
    if pxf2 > k*743-80-fase2.speed and pxf2 < k*743+80-fase2.speed and not pulof1.estaPulando and not god.god then
      if pyf2 > 360-23 and pyf2 < 360+32 then
        if fase2.x > 300  then
          fase2.x=300
        else fase2.x=250
        end
        fase2.vida=fase2.vida-1
        god.god=true
        love.audio.play(sfx)
      end
    end
  end
 -----------------------------------------------------------COLISÃO LAYER 4
  ----------------------------------------PULANDO
  if chao2 < 452 and chao2 > 397 and pulof1.estaPulando and not god.god then
    for k=1,27,1 do
      if pxf2 > k*1154-80-fase2.speed and pxf2 < k*1154+80-fase2.speed then
        if pyf2 > 420-30 and pyf2 < 420+32 then
          if fase2.x > 300  then
            fase2.x=300
          else fase2.x=250
          end
          fase2.vida=fase2.vida-1
          god.god=true
          love.audio.play(sfx)
        end
      end
    end
  end
  --------------------------------SEM PULAR
  for k=1,27,1 do
    if pxf2 > k*1154-80-fase2.speed and pxf2 < k*1154+80-fase2.speed and not pulof1.estaPulando and not god.god then
      if pyf2 > 420-23 and pyf2 < 420+32 then
        if fase2.x > 300  then
          fase2.x=300
        else fase2.x=250
        end
        fase2.vida=fase2.vida-1
        god.god=true
        love.audio.play(sfx)
      end
    end
  end
  ----------------------------------------------------------COLISÃO LAYER 5
  ----------------------------------------PULANDO
  if chao2 < 512 and chao2 > 457 and pulof1.estaPulando and not god.god then
    for k=1,25,1 do
      if pxf2 > k*1245-80-fase2.speed and pxf2 < k*1245+80-fase2.speed then
        if pyf2 > 480-30 and pyf2 < 480+32 then
          if fase2.x > 300  then
            fase2.x=300
          else fase2.x=250
          end
          fase2.vida=fase2.vida-1
          god.god=true
          love.audio.play(sfx)
        end
      end
    end
  end
  --------------------------------SEM PULAR
  for k=1,25,1 do
    if pxf2 > k*1245-80-fase2.speed and pxf2 < k*1245+80-fase2.speed and not pulof1.estaPulando and not god.god then
      if pyf2 > 480-23 and pyf2 < 480+32 then
        if fase2.x > 300  then
          fase2.x=300
        else fase2.x=250
        end
        fase2.vida=fase2.vida-1
        god.god=true
        love.audio.play(sfx)
      end
    end
  end

end


function fase2.draw()
  love.graphics.setColor(255,255,255)
  ---------------------------------------------------------MAPA
  for k=0,20,1 do
    fase2.x2=k
    love.graphics.draw(fundo_fase2,(fase2.x2*2908)-fase2.speed,0,0,1.9)
    love.graphics.draw(fundo_fase2_final,(21*2908)-fase2.speed,0,0,1.9)
  end
----------------------------------------------------------PERSONAGEM E OBSTACULOS
  if not god.god then
   for k=1,fase2.vida,1 do
    love.graphics.draw(coracao_fase2,(k*60)+600,0,0,0.1)
   end
  else 
    for k=1,fase2.vida,1 do
    love.graphics.draw(coracao_fase2,(k*60)+600,0,0,0.08)
    end
  end
  
  love.graphics.setColor(0,0,0,100)
  love.graphics.circle("fill",pxf2+50,pysombra+95,38)-- desenha a sombra do personagem

-----------------------------------------------------------LAYER 1

  love.graphics.setColor(255,255,255)
  if pyf2 < 235 and pyf2 > 0 or chao2 <235 and chao2 > 0 and pulof1.estaPulando then -- se o y do player estiver entre  0 e 220 desenha o player nesse intervalo
    love.graphics.draw(fase2.img,fase2.tileQuads3[fase2.criança_frame],pxf2,pyf2,0,2)
  end
love.graphics.setColor(255,255,255)
  for k=1,24,1 do
    love.graphics.draw(fase2.obst,fase2.tileQuads4[1],k*1312-fase2.speed,240,0,2)-- desenha o obstaculo
  end

-----------------------------------------------------------LAYER 2

  if pyf2 < 295 and pyf2 > 235 or chao2 <395 and chao2 > 235 and pulof1.estaPulando then-- se o y do player estiver entre 220 e 300 desenha o player nesse intervalo
    love.graphics.draw(fase2.img,fase2.tileQuads3[fase2.criança_frame],pxf2,pyf2,0,2)
  end

  for k=1,26,1 do
    love.graphics.draw(fase2.obst,fase2.tileQuads4[1],k*1215-fase2.speed,300,0,2)-- desenha o obstaculo
  end

-----------------------------------------------------------LAYER 3

  if pyf2 < 355 and pyf2 > 295 or chao2 <355 and chao2 > 295 and pulof1.estaPulando then-- se o y do player estiver entre 300 e 380 desenha o player nesse intervalo
    love.graphics.draw(fase2.img,fase2.tileQuads3[fase2.criança_frame],pxf2,pyf2,0,2)
  end

  for k=1,42,1 do
    love.graphics.draw(fase2.obst,fase2.tileQuads4[1],k*743-fase2.speed,360,0,2)-- desenha o obstaculo
  end

-----------------------------------------------------------LAYER 4

  if pyf2 < 415 and pyf2 > 355 or chao2 <415 and chao2 > 355 and pulof1.estaPulando then-- se o y do player estiver entre 380 e 460 desenha o player nesse intervalo
    love.graphics.draw(fase2.img,fase2.tileQuads3[fase2.criança_frame],pxf2,pyf2,0,2)
  end

  for k=1,27,1 do
    love.graphics.draw(fase2.obst,fase2.tileQuads4[1],k*1154-fase2.speed,420,0,2)-- desenha o obstaculo
  end

-----------------------------------------------------------LAYER 5

  if pyf2 < 475 and pyf2 > 415 or chao2 < 475 and chao2 >415 and pulof1.estaPulando then-- se o y do player for maior que 460 desenha o player
    love.graphics.draw(fase2.img,fase2.tileQuads3[fase2.criança_frame],pxf2,pyf2,0,2)
  end
  for k=1,25,1 do
    love.graphics.draw(fase2.obst,fase2.tileQuads4[1],k*1245-fase2.speed,480,0,2)-- desenha o obstaculo
  end

-----------------------------------------------------------LAYER 6

  if pyf2 > 475 or chao2 >475 and pulof1.estaPulando then-- se o y do player for maior que 460 desenha o player
    love.graphics.draw(fase2.img,fase2.tileQuads3[fase2.criança_frame],pxf2,pyf2,0,2)
  end
  love.graphics.setColor(0,0,0,fase2.fade_out)
  love.graphics.rectangle("fill",0,0,800,600)
  
  
    
end
return fase2