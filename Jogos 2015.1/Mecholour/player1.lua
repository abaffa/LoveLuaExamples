player1 = {
  current_life = 200,
  max_life = 200,
  lost_life = 20,
  max_stamina = 3,
  current_stamina = 3,
  anim_frame = 1,
  anim_time = 0,
  walk_red = {},
  walk_green = {},
  walk_blue = {},
  mov_time = 0.085,
  walk_time = 0.05,
  has_taken_damage = false,
  dirx = 1,
  diry = 0,
  speed = 0,
  px = 30,
  px_map = 0,
  px_next_move = 0,
  py = 40,
  py_map = 0,
  py_next_move = 0,
  collided = false,
  distance_border = 65, -- Distância das bordas do jogo que o player não poderá andar
  width = 0,
  height = 0,
  factor_vel = 1,
  runtime = 10
}
function player1.load()
  for x = 1, 10, 1 do -- Imagens com a arma vermelha
    player1.walk_red[x] = love.graphics.newImage("frank_walk/red/frankRed_" .. x .. ".png")
  end
  for x = 1, 10, 1 do -- Imagens com a arma vermelha
    player1.walk_green[x] = love.graphics.newImage("frank_walk/green/frankGreen_" .. x .. ".png")
  end
  for x = 1, 10, 1 do -- Imagens com a arma vermelha
    player1.walk_blue[x] = love.graphics.newImage("frank_walk/blue/frankBlue_" .. x .. ".png")
  end
end

function player1.update(dt)
  if player1.current_life <= 0 then
    gamestate = 8
  end
  player1.px_next_move = player1.px + ( player1.speed* player1.dirx * player1.factor_vel * dt)
  player1.py_next_move = player1.py + ( player1.speed* player1.diry * player1.factor_vel* dt)
  player1.px_map = math.ceil(player1.px)
  player1.py_map = math.ceil(player1.py)
  set_pos(player1, 2, player1.width, player1.height)
  if love.keyboard.isDown("lshift") == true then -- se aperta o left shift
    player1.current_stamina = player1.current_stamina - dt
    if player1.current_stamina > 0 then
      player1.mov_time = 0.05 -- a troca de frames é mais rápida
      player1.speed = 300 -- o frank corre mais rápido (aumenta o incremento do speed)
    else 
      player1.mov_time = 0.085
      player1.speed = 100
    end
  else
    player1.mov_time = 0.085
    player1.speed = 100
    player1.current_stamina = player1.current_stamina + dt/2
  end
  if player1.current_stamina >= player1.max_stamina then
    player1.current_stamina = player1.max_stamina
  end
  if player1.current_stamina <= 0 then
    player1.current_stamina = 0
  end

  if love.keyboard.isDown("right") then -- MOVER PARA A DIREITA
    set_pos(player1, 0, player1.width, player1.height)
    player1.dirx = 1
    player1.diry = 0
    if player1.anim_frame > 2 then
        player1.anim_frame = 1
    end
    for i=player1.py_map, player1.py_map+player1.height, 1 do
      for j=math.ceil(player1.px_next_move), math.ceil(player1.px_next_move)+player1.width, 1 do
        if map[i][j] == 0 then
          player1.collided = false
        else
          player1.collided = true
          break
        end
      end
      if player1.collided == true then
        break
      end
    end
    if player1.collided == false then
      player1.anim_time = player1.anim_time + dt -- incrementa o tempo usando dt
      player1.px = player1.px_next_move
      if player1.anim_time > player1.mov_time then -- quando acumular mais de player1.mov_time
        player1.anim_frame = player1.anim_frame + 1 -- avança para proximo frame
        if player1.anim_frame > 2 then
          player1.anim_frame = 1
        end
        player1.anim_time = 0 -- reinicializa a contagem do tempo
      end
      for i=player1.py_map, player1.py_map+player1.height, 1 do
        for j=math.ceil(player1.px), math.ceil(player1.px)+player1.width, 1 do
          map[i][j] = 2
        end
      end
    else
      set_pos(player1, 2, player1.width, player1.height)
    end
  elseif love.keyboard.isDown("left") then -- MOVER PARA A ESQUERDA
    set_pos(player1, 0, player1.width, player1.height)
    player1.dirx = -1
    player1.diry = 0
    if player1.anim_frame < 3 or player1.anim_frame > 4 then
        player1.anim_frame = 3
    end
    for i=player1.py_map, player1.py_map+player1.height, 1 do
      for j=math.ceil(player1.px_next_move), math.ceil(player1.px_next_move)+player1.width, 1 do
        if map[i][j] == 0 then
          player1.collided = false
        else
          player1.collided = true
          break
        end
      end
      if player1.collided == true then
        break
      end
    end
    if player1.collided == false then
      player1.px = player1.px_next_move
      player1.anim_time = player1.anim_time + dt -- incrementa o tempo usando dt
      if player1.anim_time > player1.mov_time then -- quando acumular mais de player1.mov_time
        player1.anim_frame = player1.anim_frame + 1 -- avança para proximo frame
        if player1.anim_frame > 4 then
          player1.anim_frame = 3
        end
        player1.anim_time = 0 -- reinicializa a contagem do tempo
      end
      for i=player1.py_map, player1.py_map+player1.height, 1 do
        for j=math.ceil(player1.px), math.ceil(player1.px)+player1.width, 1 do
          map[i][j] = 2
        end
      end
    else
      set_pos(player1, 2, player1.width, player1.height)
    end
  elseif love.keyboard.isDown("up") then -- MOVER PARA CIMA
    set_pos(player1, 0, player1.width, player1.height)
    player1.dirx = 0
    player1.diry = -1
    if player1.anim_frame < 5 or player1.anim_frame > 7 then
        player1.anim_frame = 5
    end
    for i=math.ceil(player1.py_next_move), math.ceil(player1.py_next_move) + player1.height, 1 do
      for j=player1.px_map, player1.px_map+player1.width, 1 do
        if map[i][j] == 0 then
          player1.collided = false
        else
          player1.collided = true        
          break
        end
      end
      if player1.collided == true then
        break
      end
    end
    if player1.collided == false then
      player1.py = player1.py_next_move
      player1.anim_time = player1.anim_time + dt -- incrementa o tempo usando dt
      if player1.anim_time > player1.mov_time then -- quando acumular mais de player1.mov_time
        player1.anim_frame = player1.anim_frame + 1 -- avança para proximo frame
        if player1.anim_frame > 7 then
          player1.anim_frame = 5
        end
        player1.anim_time = 0 -- reinicializa a contagem do tempo
      end
      for i=math.ceil(player1.py), math.ceil(player1.py) + player1.height, 1 do
        for j=player1.px_map, player1.px_map + player1.width, 1 do
          map[i][j] = 2
        end
      end
   else
      set_pos(player1, 2, player1.width, player1.height)
    end
  elseif love.keyboard.isDown("down") then -- MOVER PARA BAIXO
    set_pos(player1, 0, player1.width, player1.height)
    player1.dirx = 0
    player1.diry = 1
    if player1.anim_frame < 8 then
        player1.anim_frame = 8
    end
    for i=math.ceil(player1.py_next_move), math.ceil(player1.py_next_move) + player1.height, 1 do
      for j=player1.px_map, player1.px_map+player1.width, 1 do
        if map[i][j] == 0 then
          player1.collided = false
        else
          player1.collided = true
          break
        end
      end
      if player1.collided == true then
        break
      end
    end
    if player1.collided == false then
      player1.py = player1.py_next_move
      player1.anim_time = player1.anim_time + dt -- incrementa o tempo usando dt
      if player1.anim_time > player1.mov_time then -- quando acumular mais de player1.mov_time
        player1.anim_frame = player1.anim_frame + 1 -- avança para proximo frame
        if player1.anim_frame > 10 then
          player1.anim_frame = 8
        end
        player1.anim_time = 0 -- reinicializa a contagem do tempo
      end
      for i=math.ceil(player1.py), math.ceil(player1.py) + player1.height, 1 do
        for j=player1.px_map, player1.px_map + player1.width, 1 do
          map[i][j] = 2
        end
      end
    else
      set_pos(player1, 2, player1.width, player1.height)
    end
  end
  if player1.px <= player1.distance_border then
    player1.px = player1.distance_border
  end
  if player1.px >= map_width - player1.distance_border - 30 then
    player1.px = map_width -player1.distance_border - 30
  end
  if player1.py <= 20 + distance_top then
    player1.py = 20 + distance_top
  end
  if player1.py >= distance_top + map_height - player1.distance_border*3  then
    player1.py = distance_top + map_height - player1.distance_border*3
  end
end

function player1.draw()
  if projectile.global_colour == 1 then
    love.graphics.draw(player1.walk_red[player1.anim_frame], player1.px,  player1.py)
  elseif projectile.global_colour == 2 then
     love.graphics.draw(player1.walk_green[player1.anim_frame], player1.px,  player1.py)
  elseif projectile.global_colour == 3 then
     love.graphics.draw(player1.walk_blue[player1.anim_frame], player1.px,  player1.py)
  end
  love.graphics.rectangle("fill", 22, 12, 205, 25)
  love.graphics.rectangle("fill", 22, 42, 205, 25)
  love.graphics.setColor( 255, 0, 0 )
  love.graphics.rectangle("fill", 25, 15, player1.current_life*(200/player1.max_life),20)
  love.graphics.setColor( 0, 255, 0 )
  love.graphics.rectangle("fill", 25, 45,player1.current_stamina*(200/player1.max_stamina),20)
  love.graphics.setColor( 255, 255, 255 )
end
