function corrida_load()
 fundo = love.graphics.newImage("fase_corrida/fundo.png")
 corrida_pista = love.graphics.newImage("fase_corrida/pista.png")
 obstaculo = love.graphics.newImage("fase_corrida/obstaculo.png")
 corrida_instruções = love.graphics.newImage("fase_corrida/corrida_instruções.png")
 resultados = love.graphics.newImage("fase_corrida/resultados.png")
 corredor = {} -- vetor para carregar as imagens do personagem correndo
 corredor_pulo = {} -- vetor para carregar as imagens do personagem pulando
 fonte = love.graphics.newFont("fase_corrida/fonte_arcade.ttf",60)
  for x=1,13,1 do
   corredor[x] = love.graphics.newImage("fase_corrida/sprite_"..x..".png")
  end 
  for x = 1,14,1 do 
   corredor_pulo[x] = love.graphics.newImage("fase_corrida/sprite_pulo_"..x..".png")
  end
 linhas_score = {} -- checar colisão do player com linha invisivel para gerar score positivo
 obstaculos = {} -- vetor para inserir os obstaculos
 hero_anim_frame_pulo = 1 -- variavel de animação do pulo
 hero_anim_frame = 1 -- variavel de animação
 hero_anim_time = 0 -- variavel de animação
 pista_x = -100 -- variavel para fazer a pista se mover 
 obstaculos_t = 0 -- variavel para definir o espaçamento entre os obstaculos
 pulo = false -- variavel para checar se o personagem pula
 pulo_tempo = 0 -- define o tempo do pulo do personagem
 corredor_py = 330 -- variavel para definir a posição do personagem no eixo y
 pisca_t = 0
 score = 0
 player_colision = false
 corrida_tempo = 0
 corrida_state = 0
 corrida_click = 0
end
function corrida_check_mouse(mousex,mousey,x,hx,y,hy)
    return mousex < x + hx and mousey < y + hy and x < mousex + 1 and y < mousey + 1
end
function corrida_mousepressed(x,y,button)
  if corrida_click == 0 and button == 1 then
    corrida_click = 1
  end
end
function corrida_mousereleased(x,y,button)
  if corrida_click == 1 and button == 1 then
   corrida_click = 0
  end
end
function corrida_score_calculator(x)
  local y
  if x >= 7 then
   y = score*501/3 + (500 - 62*(x - 7))
  end
  return y
end
function corrida_keypressed(key) -- definição da tecla para pulo
  if key == "space" and pulo == false then
   pulo = true 
   hero_anim_frame_pulo = 1
  end
end
function corrida_checkcolision(corredor_x,hx,corredor_y,hy,obs_x,obs_y,ohy) -- colisão com obstaculos
  return corredor_x <= obs_x and corredor_y <= obs_y + ohy and obs_x <= corredor_x + hx and obs_y <= corredor_y + hy
end
function corrida_update(dt)
  if corrida_state == 0 then -- DEFINIÇÃO DO ESTADO DO JOGO
   corrida_tempo = corrida_tempo + dt
   if corrida_tempo >= 1.5 then
     corrida_state = 1
     corrida_tempo = 0
    end
  elseif corrida_state == 1 then -- MUDANÇA DE ESTADO
   corrida_tempo = corrida_tempo + dt
   hero_anim_time = hero_anim_time + dt -- incrementa o tempo usando dt
   obstaculos_t = obstaculos_t + dt*300
   pisca_t = pisca_t + dt
   pista_x = pista_x - 400*dt -- movimentação da pista
    if obstaculos_t >= 500 then
     table.insert(obstaculos,{x = 800, y = 450})
     table.insert(linhas_score,{x = 800, y = 0})
     obstaculos_t = 0
    end
    for i,v in ipairs(linhas_score) do 
      v.x = v.x - 400*dt
      if corrida_checkcolision(40,100,corredor_py,180,v.x,v.y,220) then
       score = score + 1
       table.remove(linhas_score,i)
      end
    end
    for i,v in ipairs(obstaculos) do
     v.x = v.x - 400*dt
      if corrida_checkcolision(40,100,corredor_py,180,v.x,v.y,140) then
       player_colision = true
       pisca_t = 0
       table.remove(obstaculos,i)
      end
    end
    if pisca_t >= 1 then
     player_colision = false
    end
    if pulo == true then
     pulo_tempo = pulo_tempo + dt
      if pulo_tempo < 0.7 then
       corredor_py = corredor_py - dt*200
      elseif pulo_tempo > 0.7 and corredor_py <= 330 then 
       corredor_py = corredor_py + dt*200
      end
      if hero_anim_time > 0.1 then -- quando acumular mais de 0.1
       hero_anim_frame_pulo = hero_anim_frame_pulo + 1 -- avança para proximo frame
        if hero_anim_frame_pulo > 14 then
         hero_anim_frame_pulo = 1
        end
       hero_anim_time = 0 -- reinicializa a contagem do tempo
      end
    else
      if hero_anim_time > 0.1 then -- quando acumular mais de 0.1
       hero_anim_frame = hero_anim_frame + 1 -- avança para proximo frame
        if hero_anim_frame > 13 then
         hero_anim_frame = 1
        end
       hero_anim_time = 0 -- reinicializa a contagem do tempo
      end
    end
    if pulo_tempo >= 1.4 then
     pulo = false
     pulo_tempo = 0
    end
    if pista_x <= -400 then 
     pista_x = -100
    end
    if pisca_t == 0 then 
     score = score -1
    end
    if (score == 3 and corrida_tempo >= 7) or corrida_tempo >= 14 then
     corrida_state = 2
    end
  elseif corrida_state == 2  then -- MUDANÇA DE ESTADO
    if corrida_check_mouse(love.mouse.getX(),love.mouse.getY(),190,260,330,40) then
     if corrida_click == 1 then
       gamestate = 3
      end
    end
    if corrida_check_mouse(love.mouse.getX(),love.mouse.getY(),500,120,330,40) then
     if corrida_click == 1 then
       love.event.push("quit")
      end
    end
  end
end
function corrida_draw()
  if corrida_state == 0 then -- DEFINIÇÃO DO ESTADO DO JOGO
    love.graphics.setColor(255,255,255)
    love.graphics.draw(corrida_instruções,0,0)
  elseif corrida_state == 1 then -- MUDANÇA DE ESTADO
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(fonte)
    for i,v in ipairs(linhas_score) do
     love.graphics.line(v.x,v.y,v.x,v.y+400)
    end
   love.graphics.draw(fundo,0,0)
   love.graphics.draw(corrida_pista,pista_x,500)
   love.graphics.draw(corrida_pista,pista_x+600,500)
    for i,v in ipairs(obstaculos) do
     love.graphics.draw(obstaculo,v.x,v.y)
    end
    if pulo == true and ((player_colision == false) or (player_colision == true and hero_anim_frame_pulo%3 == 0)) then
     love.graphics.draw(corredor_pulo[hero_anim_frame_pulo],40,corredor_py, 0, 0.9,0.9)
    elseif (player_colision == false) or (player_colision == true and hero_anim_frame%3 == 0) then
     love.graphics.draw(corredor[hero_anim_frame],40,corredor_py, 0, 0.9,0.9)
    end 
    if score < 0 then -- INDICADOR DE PONTUAÇÃO 
      for x = 0,-score,1 do
       love.graphics.setColor(255,0,0)
       love.graphics.print("X",(x-1)*40,0) 
      end
    elseif score > 0 then
      for x = 0,score,1 do
       love.graphics.setColor(0,255,0)
       love.graphics.print("O",(x-1)*40,0) 
      end
    end
  elseif corrida_state == 2 then -- MUDANÇA DE ESTADO
   love.graphics.setColor(255,255,255)
   love.graphics.draw(resultados,0,0)
   love.graphics.setColor(0,0,0)
   love.graphics.print("SCORE    "..math.ceil(tonumber(corrida_score_calculator(corrida_tempo))).."",250,250) 
    if corrida_check_mouse(love.mouse.getX(),love.mouse.getY(),190,260,330,40) then
     love.graphics.setColor(255,255,0)
     love.graphics.print("CONTINUE",190,330)
    else
     love.graphics.print("CONTINUE",190,330)
    end
    if corrida_check_mouse(love.mouse.getX(),love.mouse.getY(),500,120,330,40) then
     love.graphics.setColor(255,255,0)
     love.graphics.print("QUIT",500,330)
    else
     love.graphics.setColor(0,0,0)
     love.graphics.print("QUIT",500,330) 
    end  
  end
end