function onibus_load()
--carrega as imagens 
--love.window.setFullscreen(true,"normal")
love.window.setTitle("college rivals")
fundo_do_onibus= love.graphics.newImage("fase_do_onibus/fundo_do_onibus.png")
onibusimg = love.graphics.newImage("fase_do_onibus/onibus.png")
latinha = love.graphics.newImage("fase_do_onibus/latinha.png")
engradado = love.graphics.newImage("fase_do_onibus/engradado.png")
buraco = love.graphics.newImage("fase_do_onibus/buraco.png")
onibus_instruções = love.graphics.newImage("fase_do_onibus/instruções.png")
resultados = love.graphics.newImage("fase_do_onibus/resultados.png")
  cerva = {
   image = love.graphics.newImage("fase_do_onibus/cerva.png"),
   p={},
   y={},
    }
pista02 = love.graphics.newImage("fase_do_onibus/pista02.png")
medidor = love.graphics.newImage("fase_do_onibus/medidor_de_posição.png")
x=350-- variavel para definir inicialização do onibus no eixo x
y=430
v=510
u = love.math.random(1,3)
pista = 2
tempo = 0
py=0
buraco_y = 0
cleytinho = 0
p = love.math.random(1,3)
bla = 0
cerva_y=0
cervas = {}
buracos = {}
onibus_state = 0
onibus_click = 0
end
function onibus_check_colision_buraco(pistabu,pistaca,ybu,hca,yca,hbu)
   return pistaca == pistabu and yca < ybu + hbu and ybu < yca + hca
end
function onibus_checkcolision(pistaca,pistace,yca,hca,yce,hce) -- checar a colisão das cervas
   return pistaca == pistace and yca < yce + hce and yce < yca + hca
end
function onibus_keypressed(key)  -- movimentações do onibus
  if key == "right" then 
    if pista == 2 then 
       pista = 3
    end
    if pista == 1 then 
       pista = 2 
    end
  end
  if key == "left" then
    if pista == 2 then
       pista = 1
    end
    if pista == 3 then
       pista = 2
    end
  end
end
function onibus_score_calculator(x)
  local y
  if x >= 12 then
   y = cleytinho*504/12 + (497 - 41*(x - 12))
  end
  return y
end
function onibus_mousepressed(x,y,button)
  if onibus_click == 0 and button == 1 then
   onibus_click = 1
  end
end
function onibus_mousereleased(x,y,button)
  if onibus_click == 1 and button == 1 then
   onibus_click = 0
  end
end
function check_mouse(mousex,mousey,x,hx,y,hy)
    return mousex < x + hx and mousey < y + hy and x < mousex + 1 and y < mousey + 1
end
function onibus_update(dt)
  if onibus_state == 0 then -- MUDANÇA DE ESTADO
   tempo = tempo + dt
    if tempo >= 1.5 then
     onibus_state = 1
     tempo = 0
    end
  elseif onibus_state == 1 then -- MUDANÇA DE ESTADO
   tempo = tempo + dt
   buraco_y = buraco_y + dt*360 -- spawn dos buracos 
   cerva_y = cerva_y + dt*410 -- definir movimentação da cerva em y
   v = v-dt*10 -- mudar a posição do medidor no y
   py= py + dt*400 -- animação da pista, corrigido bug de animação
    if buraco_y >= 340 then 
     buraco_y = 0
     table.insert(buracos,{u = love.math.random(1,3),y=-100})
    end
    for i,v in ipairs(buracos) do
     v.y = v.y + dt*400
      if onibus_check_colision_buraco(v.u,pista,v.y,170,y,30) then 
       cleytinho = cleytinho - 1
       table.remove(buracos,i)
        if cleytinho <= 0 then
         cleytinho = 0 
        end
      end
    end
    if cerva_y >= 340 then -- spawn ajustado, spawna 12 cervas em aproximadamente 11.7 seg
     cerva_y = 0
     table.insert(cervas,{p=love.math.random(1,3),y=-100})
    end
    for i,v in ipairs(cervas) do
     v.y=v.y+dt*400
      if onibus_checkcolision(pista,v.p,y,170,v.y,20) then 
       table.remove(cervas, i)
       cleytinho = cleytinho +1
      end
    end
    if p == 1 then --definir a coordenada x da cerva
     i = 255
    elseif p == 2 then
     i = 386
    elseif p == 3 then
     i = 517
    end
    if v <= 70 then 
     v= 70
    end
    if py >= 390 then 
     py= 0
    end
    if (tempo >= 12 and cleytinho == 12) or tempo >= 24 then
     onibus_state = 2
    end 
  elseif onibus_state == 2 then -- MUDANÇA DE ESTADO
    if check_mouse(love.mouse.getX(),love.mouse.getY(),190,260,330,40) then
     if onibus_click == 1 then
       gamestate = 2
      end
    end
    if check_mouse(love.mouse.getX(),love.mouse.getY(),500,120,330,40) then
     if onibus_click == 1 then
       love.event.push("quit")
      end
    end
  end
end
function onibus_draw()
  if onibus_state == 0 then -- MUDANÇA DE ESTADO
   love.graphics.draw(onibus_instruções,0,0)
  elseif onibus_state == 1 then -- MUDANÇA DE ESTADO
   -- imagens onibus e fundo
   love.graphics.draw(fundo_do_onibus,0,0)
   love.graphics.draw(medidor,754,v)
   --desenha animação da pista
   love.graphics.draw(pista02,192,py)
   love.graphics.draw(pista02,192,py-595)
   -- desenha os buracos
    for i,v in ipairs(buracos) do 
      if v.u == 1 then
       love.graphics.draw(buraco,220,v.y)
      elseif v.u == 2 then
       love.graphics.draw(buraco,350,v.y)
      elseif v.u == 3 then
       love.graphics.draw(buraco,480,v.y)
      end
    end
   -- desenha as cervas
    for i,v in ipairs(cervas) do
      if v.p == 1 then --definir a coordenada x da cerva
       love.graphics.draw(cerva.image,255,v.y)
      elseif v.p == 2 then
       love.graphics.draw(cerva.image,386,v.y)
      elseif v.p == 3 then
       love.graphics.draw(cerva.image,517,v.y)
      end
    end
   love.graphics.draw(engradado,10,200) -- desenha o engradado
    for x = 1,cleytinho,1 do
      if x < 4 then
       love.graphics.draw(latinha, 10 + (x-1)*31, 200)
      elseif x < 7 then
       love.graphics.draw(latinha, 10 + (x-1)*31 - 93, 231)
      elseif x < 10 then
       love.graphics.draw(latinha, 10 + (x-1)*31 - 186, 262)
      elseif x < 13 then
       love.graphics.draw(latinha, 10 + (x-1)*31 - 279, 293)
      end
    end
   -- desenha o onibus
    if pista == 1 then
     love.graphics.draw(onibusimg,219,y)
    elseif pista == 2 then
     love.graphics.draw(onibusimg,348,y)
    elseif pista == 3 then
     love.graphics.draw(onibusimg,481,y)
    end
  elseif onibus_state == 2 then -- MUDANÇA DE ESTADO
   love.graphics.setColor(255,255,255)
   love.graphics.draw(resultados,0,0)
   love.graphics.setColor(0,0,0)
   -- DESCOBRIR COMO FAZ PARA PRINTAR SEM CASAS DECIMAIS
   love.graphics.print("SCORE    "..math.ceil(tonumber(onibus_score_calculator(tempo))).."",250,250) 
    if check_mouse(love.mouse.getX(),love.mouse.getY(),190,260,330,40) then
     love.graphics.setColor(255,255,0)
     love.graphics.print("CONTINUE",190,330)
    else
     love.graphics.print("CONTINUE",190,330)
    end
    if check_mouse(love.mouse.getX(),love.mouse.getY(),500,120,330,40) then
     love.graphics.setColor(255,255,0)
     love.graphics.print("QUIT",500,330)
    else
     love.graphics.setColor(0,0,0)
     love.graphics.print("QUIT",500,330) 
    end  
  end
end