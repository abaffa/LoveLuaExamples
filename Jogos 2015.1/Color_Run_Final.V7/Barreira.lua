function Barreira_load() 
 px4 = -550-- Posição inicial da "barreira" da tela pela esquerda
 px5 = 600 -- Posição inicial da "barreira" da tela pela direita
end
function Barreira_update(dt)
px4 = px4 + (camera.speed*dt) -- incrementa a posição da "barreira" esquerda de acordo com a velocidade da câmera
px5 = px5 + (camera.speed*dt) -- incrementa a posição da "barreira" direita de acordo com a velocidade da câmera
if (bolota_plataforma*180 + bolota_pos_x + px1) < px4 then -- Impede que o personagem "fuja" da tela pela esquerda
 inicia_fase() -- reinicia o resto
 muda_musica()
if(bolota_plataforma*180 + bolota_pos_x + px1) > px5 then -- Impede que o personagem "fuja" da tela pela direita
   bolota_pos_x = bolota_pos_x - (200 * dt)
end
end
end