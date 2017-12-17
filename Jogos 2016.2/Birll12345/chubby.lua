chubby={}
  local Player_anim_frame = 1
  local CPlayer_anim_time = 0 
function chubby.load()
--De 1 a 4 carregar tds as imagens
  for x=1,3,1 do
    chubby[x] = love.graphics.newImage("Sprites/correndo0" .. x .. ".png")
  end
end

function chubby.update(dt)
--animação
  CPlayer_anim_time=CPlayer_anim_time+dt
  if CPlayer_anim_time > vel_frame then -- quando acumular mais de 0.1
    Player_anim_frame = Player_anim_frame + 1 -- avança para proximo frame
    CPlayer_anim_time = 0 -- reinicializa a contagem do tempo
  end
  if Player_anim_frame > 3 then--reinicia os frames
    Player_anim_frame = 1
  end
--Boneco não sair do mapa
  if player.x<=10 then
    player.x=10
  elseif player.x>=1050 then
    player.x=1050
  end
--'gravidade'
  player.ys=player.ys+40
--Player.y agr tem um player.ys. Isso é feito para ele poder pular
  player.y=player.y+(player.ys*dt)
  if player.y >= 490 then
    player.y = 490
    player.ys = 0
  end
--Mover no teclado
  if gamestate==playing  or gamestate==running then
    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
      player.x=player.x+(350*dt)
    --Qnd ele vai pra frente a animação fica mais rapida
    CPlayer_anim_time=CPlayer_anim_time+dt/2
    elseif love.keyboard.isDown("left") or love.keyboard.isDown("a") then 
      player.x=player.x-(500*dt)
    end
  end
end

function chubby.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(chubby[Player_anim_frame], player.x, player.y)
end