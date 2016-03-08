function muda_fase()
  fase=fase+1
  inicia_fase()
end

function inicia_fase()
  PUP_load()
  Barreira_load()
  Movimentacao_load()
  px1= -180
  px2= 0
  px3= -200
  botao= 0 
  cores = 0
  score = 0
  random = 0
  bolota_score=0
  cont_score=0
  offset=0
  qtd_plataformas=75+25*(fase-1)
  camera.speed= 75+20*(fase-1)
  bolota_plataforma = 1 -- reinicia posição personagem
  bolota_anim_frame = 1
  bolota_pos_x = -35
  bolota_pos_y = 220
  bolota_anim_time = 0 -- variavel para controle do tempo da animação
  camera.x = -100
  for random = 1, qtd_plataformas, 1 do
  if fase < 3 then
    z[random] = love.math.random(1,3)
  else
    z[random] = love.math.random(1,6)
  end
end
end
function carrega_fundo()
  for c = 1, 9, 1 do
    fundo2[c] = love.graphics.newImage("Egito_camada_"..c..".png") --- primeira camada de fundo 
end
for c = 1, 4, 1 do
    fundo3[c] = love.graphics.newImage("Egito_fundo_"..c..".jpg") --- primeira camada de fundo 
end
  for c = 1, 10, 1 do
    fundo4[c] = love.graphics.newImage("Floresta_camada_"..c..".png") --- primeira camada de fundo 
end
  for c = 1, 4, 1 do
    fundo5[c] = love.graphics.newImage("Floresta_fundo_"..c..".jpg") --- primeira camada de fundo 
end
  for c = 2, 10, 1 do
    fundo6[c] = love.graphics.newImage("Medieval_camada_"..c..".png") --- primeira camada de fundo 
end
  for c = 1, 4, 1 do
    fundo7[c] = love.graphics.newImage("Medieval_fundo_"..c..".jpg") --- primeira camada de fundo 
end
  for c = 1, 9, 1 do
    fundo8[c] = love.graphics.newImage("Japao_camada_"..c..".png") --- primeira camada de fundo 
end
  for c = 1, 4, 1 do
    fundo9[c] = love.graphics.newImage("Japao_fundo_"..c..".jpg") --- primeira camada de fundo 
end
  for c = 1, 5, 1 do
    fundo10[c] = love.graphics.newImage("Farwest_camada_"..c..".png") --- primeira camada de fundo 
end
  for c = 1, 4, 1 do
    fundo11[c] = love.graphics.newImage("Farwest_fundo_"..c..".jpg") --- primeira camada de fundo 
end
end
function muda_fundo()
  if fase == 1 then
  for y = 1, 4, 1 do  
    love.graphics.draw(fundo5[y], px3+(y*500)-500, 0)
  end
  for y = 1, 10, 1 do  
    love.graphics.draw(fundo4[y], px2+(y*800)-900, -1)
  end  
  elseif fase == 2 then
  for y = 1, 4, 1 do  
    love.graphics.draw(fundo3[y], px3+(y*550)-550, 0)
  end
  for y = 1, 9, 1 do  
    love.graphics.draw(fundo2[y], px2+(y*800)-800, 500)
  end 
  elseif fase == 3 then
  for y = 1, 4, 1 do  
    love.graphics.draw(fundo7[y], px3+(y*600)-500, 0)
  end
  for y = 2, 10, 1 do  
    love.graphics.draw(fundo6[y], px2+(y*1040)-3120, 375)
  end  
  elseif fase == 4 then
  for y = 1, 4, 1 do  
    love.graphics.draw(fundo9[y], px3+(y*640)-640, 0)
  end
  for y = 1, 9, 1 do  
    love.graphics.draw(fundo8[y], px2+(y*1040)-1040, 400)
  end 
  elseif fase == 5 then
  for y = 1, 4, 1 do  
    love.graphics.draw(fundo11[y], px3+(y*700)-700, 0)
  end
  for y = 1, 5, 1 do  
    love.graphics.draw(fundo10[y], px2+(y*402)-402, 250, 0, 0.3, 0.4)
  end 
end
end
function carrega_musica()
  music1 = love.audio.newSource("Floresta.mp3")
  music2 = love.audio.newSource("egito.mp3")
  music3 = love.audio.newSource("Medieval.mp3")
  music4 = love.audio.newSource("Japao.mp3")
  music5 = love.audio.newSource("Farwest.mp3")
end
function muda_musica()
  music1:stop()
  music2:stop()
  music3:stop()
  music4:stop()
  music5:stop()
  if gamestate==4 and musica==0 then
  if fase == 1 then
    music1:play() ---manda tocar a música da fase
  elseif fase == 2 then
    music2:play() ---manda tocar a música da fase
  elseif fase == 3 then
    music3:play() ---manda tocar a música da fase
  elseif fase == 4 then
    music4:play() ---manda tocar a música da fase
  elseif fase == 5 then
    music5:play() ---manda tocar a música da fase
  end
end
end
