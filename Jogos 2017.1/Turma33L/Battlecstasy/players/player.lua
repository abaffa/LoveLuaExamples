local Player = {}
local player, p_matrizhelp, playerName, hitbox, bump, world, worldBox, p_chao, playerposX, playerside, playerEffects, boxCreated, playerHit, damageApplied, playerFilter
local charName = {"Chun-Li","Cirno","Dio","Morgiana","Ky","Bowser","Popeye","Archer"}
local playerState --primeiro termo é o estado do player2 e o segundo do player1
-- p_matrizhelp ajuda a colocar valores dentro de player sem necessitar de condicionais

function hitboxIntersect(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and
         y1 < y2+h2 and y2 < y1+h1
end

function Player:new(p1, p2, pos_chao, prop, extraX, extraY)
  damageApplied = {false, false}
  playerHit = {false, false} --posicao um checa da dano no player2 e posicao dois da dano no player1
  playerState= {0,0,0,0}
  playerEffects = {0, 0}
  boxCreated = {false, false}
  playerside = {1,-1}
  playerposX = {100,700}
  p_chao = pos_chao
  p_font = love.graphics.newFont(18)
  player, hitbox = {}, {}
  p_matrizhelp = {p1, p2, -1, 1}
  
  -- HITBOXES --
  bump = require("bumplib/bump")
  worldBox = {{x=extraX-prop,y=extraY,w=prop,h=600*prop}, {x=extraX+800*prop,y=extraY,w=prop,h=600*prop}} -- vetor para as limitações de canto de tela
  world = {} -- 1 contém as hitboxes de movimentos, 2 as hitboxes de vida do player1 e dano do player2 e 3 as de vida do player2 e dano do player1.
  world[1] = bump.newWorld()
  -- STOP --
  
  for i=1,2 do
    player[i] = {persNum = p_matrizhelp[i], pers, persImg, lifebar = 100, superbar = 0, side = p_matrizhelp[i+2]}
    player[i].pers = require("characters/char/c"..i)--[[..player[i].persNum.."/char"..player[i].persNum) --Retirar "1/char1" da parte anterior]]
    player[i].persImg = love.graphics.newImage("characters/char"..player[i].persNum..".png")
    
    -- HITBOXES --
    world[1]:add(worldBox[i], worldBox[i].x, worldBox[i].y, worldBox[i].w, worldBox[i].h) --cantos do mundo
    
    hitbox[i] = {movebox, hurtbox, damagebox}
    
    hitbox[i].movebox, hitbox[i].hurtbox, hitbox[i].damagebox = {}, {}, {0,0,0,0}
    hitbox[i].movebox, hitbox[i].hurtbox = player[i].pers:new(pos_chao, prop, extraX, extraY, i)
    for j=1,4 do
    print(hitbox[i].hurtbox[j])
    end
    world[1]:add(hitbox[i].movebox, hitbox[i].movebox[1], hitbox[i].movebox[2], hitbox[i].movebox[3], hitbox[i].movebox[4]) -- 1 é x, 2 é y, 3 é width e 4 é height
  end
end

function Player:update(dt, winner, loser, prop, extraX, extraY)
  --HITBOX--
  for i=1,2 do
    local movebox1, movebox2, hurtbox1, hurtbox2, movebox3, movebox4, pState, pposX, pEfcts, damageboxVect = player[i].pers:update(dt, prop, extraX, extraY, playerState[5-i], playerside[i], winner)
    
    playerState[i], playerposX[i], playerEffects[i] = pState, pposX, pEfcts
    
    --MOVEBOX--
    local newX, newY, cols, len = world[1]:move(hitbox[i].movebox, movebox1, movebox2)
    hitbox[i].movebox[1], hitbox[i].movebox[2] = newX, newY
    world[1]:update(hitbox[i].movebox, hitbox[i].movebox[1], hitbox[i].movebox[2], movebox3, movebox4)
    
    --DAMAGEBOX--
    -- Há um pequeno bug nessa parte, o qual ocorre quando se ataca a primeira vez.
    if playerEffects[i] ~= 0 and playerEffects[i] ~= 9 and not boxCreated[i] and not playerHit[i] then
      hitbox[i].damagebox = damageboxVect
      boxCreated[i] = true
    elseif (playerEffects[i] == 0 or playerEffects[i] == 9 or playerHit[i]) and boxCreated[i] then
      hitbox[i].damagebox = {0,0,0,0}
      boxCreated[i] = false
    end
    
    if playerHit[i] and (playerEffects[i] == 0 or playerEffects[i] == 9) then --ORIGEM DO ERRO --
      playerHit[i], damageApplied[i] = false, false
    end
    
    --HURTBOX--
    hitbox[i].hurtbox[1], hitbox[i].hurtbox[2] = hurtbox1, hurtbox2
    for j=1,4 do
    --  print(hitbox[i].hurtbox[j])
    end
    --print(hitbox[i].damagebox[1].."/"..hitbox[i].damagebox[2].."/"..hitbox[i].damagebox[3].."/"..hitbox[i].damagebox[4])
  
    if not playerHit[i] and hitboxIntersect(hitbox[3-i].hurtbox[1], hitbox[3-i].hurtbox[2], hitbox[3-i].hurtbox[3], hitbox[3-i].hurtbox[4], hitbox[i].damagebox[1], hitbox[i].damagebox[2], hitbox[i].damagebox[3], hitbox[i].damagebox[4]) then
      playerHit[i] = true
    end
    
  end
  
  for i=1,2 do
    playerState[i+2] = playerState[i]
    
    if playerHit[i] and not damageApplied[i] and winner == 0 then
      player[3-i].lifebar = player[3-i].lifebar - 5
      damageApplied[i] = true
    end
  end
  return player[1].lifebar, player[2].lifebar
end

function Player:draw(prop, extraX, extraY)
    
    -- PERSONAGENS NA TELA --
    --player[1].pers:draw(prop, extraX, extraY, hitbox[1].movebox[1], hitbox[1].movebox[2])
    --player[2].pers:draw(prop, extraX, extraY)
  
  for i=1,2 do
    -- PERSONAGENS NA TELA --
    player[i].pers:draw(prop, extraX, extraY, hitbox[i].movebox[1], hitbox[i].movebox[2], playerside[i])
  end
  for i=1,2 do
    -- RETRATO DO PERSONAGEM --
    love.graphics.draw(player[i].persImg, extraX+(50+(i-1)*650)*prop, extraY+60*prop, 0 , prop)
    -- NOME DO PERSONAGEM --
    love.graphics.print(charName[player[i].persNum], extraX+(105+(i-1)*(575-p_font:getWidth(charName[player[i].persNum])))*prop, extraY+72*prop, 0 , prop)
    -- BARRA DE VIDA --
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("fill", extraX+(400*(i-1)+50)*prop, extraY+100*prop, 300*prop, 25*prop, 10)
    love.graphics.setColor(0,255,0)
    love.graphics.rectangle("fill", extraX+(400*(i-1)+3*(100-player[i].lifebar)*(2-i)+50)*prop, extraY+100*prop, 3*player[i].lifebar*prop, 25*prop, 10)
    love.graphics.setColor(0,0,255)
    -- BARRA DE SUPER --
    for j=0,2 do
      love.graphics.rectangle("line", extraX+(500*(i-1)+50-j)*prop, extraY+(150-j)*prop, (200+2*j)*prop, (12+2*j)*prop, 5)
    end
    if player[i].superbar ~= 0 then
      love.graphics.setColor(150,150,255)
      love.graphics.rectangle("fill", extraX+(500*(i-1)+2*(100-player[i].superbar)*(i-1)+50)*prop, extraY+150*prop, 2*player[i].superbar*prop, 12*prop, 5)
    end
    love.graphics.setColor(255,255,255)
  end
  
    --BARRA DE VIDA: O LADO DIREITO VAI AUMENTAR O x E DIMINUIR O WIDTH. O LADO ESQUERDO VAI DIMINUIR O WIDTH APENAS
    --BARRA DE SUPER: OPOSTO DA BARRA DE VIDA
  
  if playerposX[1] >= playerposX[2] then
    playerside[1] = -1
    playerside[2] = 1
  else
    playerside[1] = 1
    playerside[2] = -1
  end

love.graphics.rectangle('line',hitbox[1].hurtbox[1], hitbox[1].hurtbox[2], hitbox[1].hurtbox[3], hitbox[1].hurtbox[4])
love.graphics.rectangle('line',hitbox[2].hurtbox[1], hitbox[2].hurtbox[2], hitbox[2].hurtbox[3], hitbox[2].hurtbox[4])
love.graphics.rectangle('line',hitbox[1].damagebox[1], hitbox[1].damagebox[2], hitbox[1].damagebox[3], hitbox[1].damagebox[4])
love.graphics.rectangle('line',hitbox[2].damagebox[1], hitbox[2].damagebox[2], hitbox[2].damagebox[3], hitbox[2].damagebox[4])
end

return Player