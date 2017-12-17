inim={}
  local inim_anim_time = 0
  local inim_anim_frame = 1
function inim.load()
  love.graphics.setColor(255,255,255)
  stone=love.graphics.newImage('Cenario/stone.png')
  ini_random=0
  for x=1,4,1 do
    inim[x]=love.graphics.newImage("Sprites/bmcorrendo00" .. x .. ".png")
  end
  vel_box=0
end

function inim.update(dt)
--Dependendo do numero que o ini_random receber, o obstaculo que vira sera diferente
  if ini_random==1 then
    box1.x=box1.x-(vel_box*dt)
  else inim1.x=inim1.x-((vel_box+150)*dt)
  end
--Qnd o obstaculo sair da tela, gerar um novo aleatorio
  if box1.x <=-350 or inim1.x<= -250 then
    ini_random=love.math.random(1,2)
    box1.x=1300
    inim1.x=1300 
 end
  inim_anim_time=inim_anim_time+dt
  if inim_anim_time > 0.09 then -- quando acumular mais de 0.1
    inim_anim_frame = inim_anim_frame + 1 -- avança para proximo frame
    inim_anim_time = 0 -- reinicializa a contagem do tempo
  end
  if inim_anim_frame > 4 then--reinicia os frames
    inim_anim_frame = 1
  end
end

function inim.draw()
 love.graphics.setColor(255,255,255)
 love.graphics.draw(stone,box1.x,box1.y,0,2.5)
 love.graphics.draw(stone,box1.x+80,box1.y,0,2.5)
 love.graphics.draw(stone,box1.x+160,box1.y,0,2.5)
 love.graphics.draw(inim[inim_anim_frame],inim1.x,inim1.y-7)
end