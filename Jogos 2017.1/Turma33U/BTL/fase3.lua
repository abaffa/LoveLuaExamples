pxf3=100
pyf3=400
chao3=500
local pulof1 = require "pulof1"
local god = require "god"
lagTimer_w = 0
lagTimer_a = 0
lagTimer_s = 0
lagTimer_d = 0
retardando_w = true
retardando_a = true
retardando_s = true
retardando_d = true

local fase3 = {
  estaNaFase3 = false,
  speed=0,
  x=250,
  x2,
  img,
  obst,
  tileQuads5={},
  tileSize5=44,
  tileQuads6={},
  tileSize6=62.5,
  anim_time=0,
  criança_frame=1,
  obst_frame=1,
  lim_cima=340,
  lim_baixo=500,
  vida=1,
  fade_out=0,
}
 function LoadTiles5(filename,nx,ny)
  fase3.img=love.graphics.newImage(filename)
  for j=0,nx-1,1 do
    for i=0,ny-1,1 do
      fase3.tileQuads5[fase3.criança_frame]=love.graphics.newQuad(i*fase3.tileSize5,j*fase3.tileSize5,fase3.tileSize5,fase3.tileSize5,fase3.img:getWidth(),fase3.img:getHeight())
fase3.criança_frame=fase3.criança_frame+1
    end
  end
end
function LoadTiles6(filename,nx,ny)
  fase3.obst=love.graphics.newImage(filename)
  for j=0,nx-1,1 do
    for i=0,ny-1,1 do
      fase3.tileQuads6[fase3.obst_frame]=love.graphics.newQuad(i*fase3.tileSize6,j*fase3.tileSize6,fase3.tileSize6,fase3.tileSize6,fase3.obst:getWidth(),fase3.obst:getHeight())
      fase3.obst_frame=fase3.obst_frame+1
    end
  end
end
function fase3.load()
coracao_fase3=love.graphics.newImage("coracao_cheio.png")
fundo_fase3=love.graphics.newImage("cenario_idosa.png")
fundo_fase3_final=love.graphics.newImage("cenario_idosa.png")
LoadTiles5 ("idosa.png",4,4)
LoadTiles6("lixeiras.png",2,2)
fase3.criança_frame=9
end
function fase3.update(dt)
  
  -------------------------------------------------CAMERA
  fase3.x=fase3.x+0.25
  if fase3.x>800 then
    fase3.x=800
  end 
  fase3.speed=fase3.speed+(fase3.x*(dt))
  -----------------------------------------PERSONAGEM
  fase3.anim_time=fase3.anim_time+(dt)
 if fase3.anim_time>0.1 then
   fase3.criança_frame=fase3.criança_frame+1
    if fase3.criança_frame>12 then
      fase3.criança_frame=9
    end
    fase3.anim_time=0
  end
  
  if love.keyboard.isDown("d") and not pulof1.estaPulando then   --  move o personagem para direita
    if retardando_d then
      lagTimer_d = lagTimer_d + dt
      if lagTimer_d > 0.2 then
        pxf3=pxf3+(200*dt)
        if pxf3>=704 then
          pxf3=704
        end
        lagTimer_d = 0
        retardando_d = false
      end
    else
      pxf3=pxf3+(200*dt)
      if pxf3>=704 then
        pxf3=704
      end
    end
  elseif love.keyboard.isDown("a") and not pulof1.estaPulando then--  move o personagem pra esquerda
    if retardando_a then
      lagTimer_a = lagTimer_a + dt
      if lagTimer_a > 0.2 then
        pxf3=pxf3-(150*dt)
        if pxf3<=10 then
          pxf3=10
        end
        lagTimer_a = 0
        retardando_a = false
      end
    else
      pxf3=pxf3-(150*dt)
      if pxf3<=10 then
        pxf3=10
      end
    end
  end
  if love.keyboard.isDown("w") and not pulof1.estaPulando then   --  move o personagem pra cima
    if retardando_w then
      lagTimer_w = lagTimer_w + dt
      if lagTimer_w > 0.2 then
        pyf3=pyf3-(200*dt)
        if pyf3<=fase3.lim_cima then
          pyf3=fase3.lim_cima
        end
        lagTimer_w = 0
        retardando_w = false
      end
    else
      pyf3=pyf3-(200*dt)
      if pyf3<=fase3.lim_cima then
        pyf3=fase3.lim_cima
      end
    end
  end
  if love.keyboard.isDown("s") and not pulof1.estaPulando then   --  move o personagem pra baixo
    if retardando_s then
      lagTimer_s = lagTimer_s + dt
      if lagTimer_s > 0.2 then
        pyf3=pyf3+(200*dt)
        if pyf3>=fase3.lim_baixo then
          pyf3=fase3.lim_baixo
        end
        lagTimer_s = 0
        retardando_s = false
      end
    else
      pyf3=pyf3+(200*dt)
      if pyf3>=fase3.lim_baixo then
        pyf3=fase3.lim_baixo
      end
    end
  end
  if pulof1.estaPulando then
    pysombra=pysombra
  else pysombra=pyf3
  end
  if fase3.speed > 31600 then
    fase3.fade_out=fase3.fade_out+(200*dt)
  end
  
  if god.god then
    god.update(dt)
  end
  
  
  ----------------------------------------------------------COLISÃO LAYER 1
  ----------------------------------------PULANDO
  if chao3 < 392 and chao3 > 337 and pulof1.estaPulando and not god.god then
    for k=1,42,1 do
      if pxf3 > k*743-80-fase3.speed and pxf3 < k*743+80-fase3.speed then
        if pyf3 > 360-50 and pyf3 < 360+32 then
          if fase3.x > 300  then
            fase3.x=300
          else fase3.x=250
          end
          fase3.vida=fase3.vida-1
          god.god=true
          love.audio.play(sfx)
        end
      end
    end
  end
  --------------------------------SEM PULAR
  for k=1,42,1 do
    if pxf3 > k*743-80-fase3.speed and pxf3 < k*743+80-fase3.speed and not pulof1.estaPulando and not god.god then
      if pyf3 > 360-23 and pyf3 < 360+32 then
        if fase3.x > 300  then
          fase3.x=300
        else fase3.x=250
        end
        fase3.vida=fase3.vida-1
        god.god=true
        love.audio.play(sfx)
      end
    end
  end
 -----------------------------------------------------------COLISÃO LAYER 2
  ----------------------------------------PULANDO
  if chao3 < 452 and chao3 > 397 and pulof1.estaPulando and not god.god then
    for k=1,27,1 do
      if pxf3 > k*1154-80-fase3.speed and pxf3 < k*1154+80-fase3.speed then
        if pyf3 > 420-23 and pyf3 < 420+32 then
          if fase3.x > 300  then
            fase3.x=300
          else fase3.x=250
          end
          fase3.vida=fase3.vida-1
          god.god=true
          love.audio.play(sfx)
        end
      end
    end
  end
  --------------------------------SEM PULAR
  for k=1,27,1 do
    if pxf3 > k*1154-80-fase3.speed and pxf3 < k*1154+80-fase3.speed and not pulof1.estaPulando and not god.god then
      if pyf3 > 420-50 and pyf3 < 420+32 then
        if fase3.x > 300  then
          fase3.x=300
        else fase3.x=250
        end
        fase3.vida=fase3.vida-1
        god.god=true
        love.audio.play(sfx)
      end
    end
  end
  ----------------------------------------------------------COLISÃO LAYER 3
  ----------------------------------------PULANDO
  if chao3 < 512 and chao3 > 457 and pulof1.estaPulando and not god.god then
    for k=1,25,1 do
      if pxf3 > k*1245-80-fase3.speed and pxf3 < k*1245+80-fase3.speed then
        if pyf3 > 480-50 and pyf3 < 480+32 then
          if fase3.x > 300  then
            fase3.x=300
          else fase3.x=250
          end
          fase3.vida=fase3.vida-1
          god.god=true
          love.audio.play(sfx)
        end
      end
    end
  end
  --------------------------------SEM PULAR
  for k=1,25,1 do
    if pxf3 > k*1245-80-fase3.speed and pxf3 < k*1245+80-fase3.speed and not pulof1.estaPulando and not god.god then
      if pyf3 > 480-23 and pyf3 < 480+32 then
        if fase3.x > 300  then
          fase3.x=300
        else fase3.x=250
        end
        fase3.vida=fase3.vida-1
        god.god=true
        love.audio.play(sfx)
      end
    end
  end

end


function fase3.draw()
  love.graphics.setColor(255,255,255)
  ---------------------------------------------------------MAPA
  for k=0,22,1 do
    fase3.x2=k
    love.graphics.draw(fundo_fase3,(fase3.x2*1420)-fase3.speed,0,0,1.9)
    love.graphics.draw(fundo_fase3_final,(23*1420)-fase3.speed,0,0,1.9)
  end
----------------------------------------------------------PERSONAGEM E OBSTACULOS
  if not god.god then
   for k=1,fase3.vida,1 do
    love.graphics.draw(coracao_fase3,(k*60)+600,0,0,0.1)
   end
  else 
    for k=1,fase3.vida,1 do
    love.graphics.draw(coracao_fase3,(k*60)+600,0,0,0.08)
    end
  end
  
  love.graphics.setColor(0,0,0,100)
  love.graphics.circle("fill",pxf3+50,pysombra+95,38)-- desenha a sombra do personagem

-----------------------------------------------------------LAYER 1

  love.graphics.setColor(255,255,255)

  if pyf3 < 355 and pyf3 > 295 or chao3 <355 and chao3 > 295 and pulof1.estaPulando then-- se o y do player estiver entre 300 e 380 desenha o player nesse intervalo
    love.graphics.draw(fase3.img,fase3.tileQuads5[fase3.criança_frame],pxf3,pyf3,0,2)
  end

  for k=1,42,1 do
    love.graphics.draw(fase3.obst,fase3.tileQuads6[1],k*743-fase3.speed,360,0,2)-- desenha o obstaculo
  end

-----------------------------------------------------------LAYER 2

  if pyf3 < 415 and pyf3 > 355 or chao3 <415 and chao3 > 355 and pulof1.estaPulando then-- se o y do player estiver entre 380 e 460 desenha o player nesse intervalo
    love.graphics.draw(fase3.img,fase3.tileQuads5[fase3.criança_frame],pxf3,pyf3,0,2)
  end

  for k=1,27,1 do
    love.graphics.draw(fase3.obst,fase3.tileQuads6[1],k*1154-fase3.speed,420,0,2)-- desenha o obstaculo
  end

-----------------------------------------------------------LAYER 3

  if pyf3 < 475 and pyf3 > 415 or chao3 < 475 and chao3 >415 and pulof1.estaPulando then-- se o y do player for maior que 460 desenha o player
    love.graphics.draw(fase3.img,fase3.tileQuads5[fase3.criança_frame],pxf3,pyf3,0,2)
  end
  for k=1,25,1 do
    love.graphics.draw(fase3.obst,fase3.tileQuads6[1],k*1245-fase3.speed,480,0,2)-- desenha o obstaculo
  end

-----------------------------------------------------------LAYER 4

  if pyf3 > 475 or chao3 >475 and pulof1.estaPulando then-- se o y do player for maior que 460 desenha o player
    love.graphics.draw(fase3.img,fase3.tileQuads5[fase3.criança_frame],pxf3,pyf3,0,2)
  end
  love.graphics.setColor(0,0,0,fase3.fade_out)
  love.graphics.rectangle("fill",0,0,800,600)
  
  
    
end
return fase3