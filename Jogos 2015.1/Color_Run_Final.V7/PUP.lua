function PUP_load()
PUP2 = 150*love.math.random(13,26)
PUP1 = 150*love.math.random(3,12)
caixa1=love.graphics.newImage("caixa1.jpg")
caixa2=love.graphics.newImage("caixa2.jpg")
end
function PUP_update(dt)

if PUP2 < (bolota_plataforma*180 + bolota_pos_x + px1 + 400) and (PUP2+50) >= (bolota_plataforma*180 + bolota_pos_x + px1 + 400) then
  caixa1_plataforma = bolota_plataforma+11
  camera.speed = 50
end
if bolota_plataforma == caixa1_plataforma then
  camera.speed = (75+20*(fase-1))
end
if PUP1 < (bolota_plataforma*180 + bolota_pos_x + px1 + 400) and (PUP1+50) >= (bolota_plataforma*180 + bolota_pos_x + px1 + 400) then
  for y=bolota_plataforma+2, bolota_plataforma+11, 1 do
  z[y]= 7
end
end
end
function PUP_draw()
love.graphics.draw(caixa1, PUP1,200)
love.graphics.draw(caixa2, PUP2,200)
end 