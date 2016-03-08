function easteregg_load()
 gatoraiolaser = love.graphics.newImage("final/gatoraiolaser.jpg")
 gatoraiolaser2 = love.graphics.newImage("final/gatoraiolaser2.jpg")
 gato_vermelho = {255,255,255,128,0,0,0,0,0,127,255,255}
 gato_verde = {0,128,255,255,255,255,255,128,0,0,0,0}
 gato_azul = {0,0,0,0,0,128,255,255,255,255,255,127}
 gato_animador = 0
 gato_piscador = 0
 gato_espelhado = 0
 gato_animador2 = 0
end
function easteregg_update(dt)
  gato_animador = gato_animador + 300*dt
  gato_animador2 = gato_animador2 + dt
  if gato_animador >= 0.5 then
   gato_piscador = gato_piscador + 1
   gato_animador = 0
    if gato_piscador == 12 then
     gato_piscador = 0
    end
  end
  if gato_animador2 >= 0.3 then
   gato_espelhado = gato_espelhado + 1
   gato_animador2 = 0
  end
end
function easteregg_draw()
  for x = 1,gato_piscador,1 do
   love.graphics.setColor(gato_vermelho[x],gato_verde[x],gato_azul[x]) 
  end
  if gato_espelhado%2 == 0 then
   love.graphics.draw(gatoraiolaser,0,0)
  else
   love.graphics.draw(gatoraiolaser2,0,0)
  end
end