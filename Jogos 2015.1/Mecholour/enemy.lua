enemy = {
  walk_blue = {},
  walk_green = {},
  walk_red = {},
  walk_superred = {},
  walk_superblue = {},
  walk_supergreen = {},
  walk_boss3_blue = {},
  walk_boss3_green = {},
  walk_boss3_red = {},
  mov_time = 0.085,
  start_attack_time = false,
  walk_time = 0.05,
  spawn_between = 5, -- Tempo entre o spawn de cada inimigo
  spawn_type = 1,
  mecholour_width = 0,
  mecholour_height = 0,
  boss3_width = 0,
  boss3_height = 0,
  quantity = 20,
  boss3_time = 0,
  boss3_max_time = 3,
  remove_all = false,
  mecholour_life = 2,
  supercholour_life = 3,
  boss3_life = 30,
  mecholour_speed = 85,
  supercholour_speed = 110,
  boss3_speed = 95,
  mecholour_max_attack_time = 2,
  supercholour_max_attack_time = 1,
  boss3_max_attack_time = 0.3,
  red_px = 140,
  red_py = 300,
  green_px = 500,
  green_py = 50,
  blue_px = 900,
  blue_py = 340,
  boss_px = 472,
  boss_py = 280,
  distance_border = 100, -- Distância do spawn do inimigo da borda do jogo
  mov_extra = 3
}
enemies = {}

function enemy.load()
  for x = 1, 14, 1 do -- Imagens redcholour
    enemy.walk_red[x] = love.graphics.newImage("enemy/mecholourRedMoves/mecholourRed_" .. x .. ".png")
  end
  for x = 1, 14, 1 do -- Imagens greencholour
    enemy.walk_green[x] = love.graphics.newImage("enemy/mecholourGreenMoves/mecholourGreen_" .. x .. ".png")
  end
  for x = 1, 14, 1 do -- Imagens bluecholour
    enemy.walk_blue[x] = love.graphics.newImage("enemy/mecholourBlueMoves/mecholourBlue_" .. x .. ".png")
  end
  for x = 1, 14, 1 do -- Imagens superred
    enemy.walk_superred[x] = love.graphics.newImage("enemy/superred/superRed_" .. x .. ".png")
  end
  for x = 1, 14, 1 do -- Imagens supergreen
    enemy.walk_supergreen[x] = love.graphics.newImage("enemy/supergreen/supergreen_" .. x .. ".png")
  end
  for x = 1, 14, 1 do -- Imagens superblue
    enemy.walk_superblue[x] = love.graphics.newImage("enemy/superblue/superblue_" .. x .. ".png")
  end
  for x = 1, 14, 1 do -- Imagens boss3Red
    enemy.walk_boss3_red[x] = love.graphics.newImage("enemy/boss3red/boss3Red_" .. x .. ".png")
  end
  for x = 1, 14, 1 do -- Imagens boss3Green
    enemy.walk_boss3_green[x] = love.graphics.newImage("enemy/boss3green/boss3Green_" .. x .. ".png")
  end
  for x = 1, 14, 1 do -- Imagens boss3Blue
    enemy.walk_boss3_blue[x] = love.graphics.newImage("enemy/boss3blue/boss3Blue_" .. x .. ".png")
  end
  enemy.mecholour_width = enemy.walk_blue[5]:getWidth()
  enemy.mecholour_height = enemy.walk_blue[5]:getHeight()
  enemy.boss3_width = enemy.walk_boss3_blue[5]:getWidth()
  enemy.boss3_height = enemy.walk_boss3_blue[5]:getHeight()
end
function enemy.spawn(px, py, pref_axis, colour, max_attack_time, life, speed, width, height)
  table.insert(enemies,
    {
      life = life,
      dirx = 0,
      diry = 0,
      px = px,
      px_map = math.ceil(px),
      px_next_move = 0,
      py = py,
      py_map = math.ceil(py),
      py_next_move = 0,
      equal_px = false,
      equal_py = false,
      spawn_time=0,
      speed = speed, 
      width = width, 
      height = height, 
      alive = true, 
      collided = false,
      anim_frame = 1,
      anim_time = 0,
      attack_time = 0,
      max_attack_time = max_attack_time,
      moving = 0,
      pref_axis = pref_axis, -- Eixo que o inimigo andará preferencialmente
      pref_axis_time = 0, -- Tempo que o inimigo está andando num eixo antes de mudar
      pref_axis_max_time = 0.5, -- Tempo máximo que o inimigo andará num eixo antes de mudar
      colour = colour
    })
end

function enemy.spawn_colour(colour_px,colour_py, number_colour, max_attack_time, life, speed, width, height, dt)
  spawn_collided = false
  if map[colour_py][colour_px] == 0 then
    spawn_collided = false
  else
    spawn_collided = true
  end
  if #enemies == 0 then
    if spawn_collided == false then
      enemy.spawn(colour_px,colour_py, math.ceil(love.math.random(1,2)), number_colour, max_attack_time, life, speed, width, height)
    end
  elseif #enemies < enemy.quantity then -- caso haja 0 inimigos no mapa, ele spawnará um inimigo, caso haja mais de 5, não spawnará nada
    if spawn_collided == false then
      for i,v in ipairs(enemies) do
        enemies[i].spawn_time = enemies[i].spawn_time + dt
        if enemies[i].spawn_time >= enemy.spawn_between and enemies[i].spawn_time <= enemy.spawn_between + dt then
          enemy.spawn(colour_px,colour_py, math.ceil(love.math.random(1,2)), number_colour, max_attack_time, life, speed, width, height)
        end
      end
    end
  end
end

function enemy:move(dt, pos) -- Movimentação dos inimigos. Essa função é válida para n inimigos.
  self.px_next_move = self.px + ( self.speed  * self.dirx * dt)
  self.py_next_move = self.py + ( self.speed * self.diry * dt)
  self.px_map = math.ceil(self.px)
  self.py_map = math.ceil(self.py)
  self.attack_time = self.attack_time + dt
  self.pref_axis_time = self.pref_axis_time + dt
  if enemy.remove_all == true then
      set_pos(self,0, self.width, self.height)
      table.remove(enemies, pos)
      if #enemies == 0 then
        enemy.remove_all = false
      end
      return 0
  end
  if self.life <= 0 then
    if self.speed == enemy.mecholour_speed then
      score = score + 100
    elseif self.speed == enemy.supercholour_speed then
      score = score + 200
    elseif self.speed == enemy.boss3_speed then
      score = score + 1000
      wave = wave + 1
      gamestate = 10
    end
    set_pos(self,0, self.width, self.height)
    table.remove(enemies, pos)
    return 0   
  end
  if self.pref_axis_time >  self.pref_axis_max_time then
    if self.pref_axis == 1 then
      self.pref_axis = 2 -- Preferência por um movimento na vertical
    else
       self.pref_axis = 1 -- Preferência por um movimento na horizontal
    end
    self.pref_axis_time = 0
  end
  
  if self.px_map < player1.px_map and (self.equal_py == true  or self.pref_axis == 1) then -- DIREITA
    if self.py_map < player1.py_map + enemy.mov_extra and self.py_map > player1.py_map - enemy.mov_extra then
      self.equal_py = true
      self.pref_axis = 0
    else
      self.pref_axis =  1
    end
    set_pos(self,0, self.width, self.height)
    self.dirx = 1
    self.diry = 0
    for i=self.py_map + 1, self.py_map + self.height, 1 do
      for j=math.ceil(self.px_next_move), math.ceil(self.px_next_move) + self.width, 1 do
        if map[i][j] == 0 then
          self.collided = false
        elseif map[i][j] == 1 then
          set_pos(self,1, self.width, self.height)
          self.collided = true
          break
        else
          self.collided = true
          set_pos(self,1, self.width, self.height)
          if self.attack_time > self.max_attack_time then
            self.anim_frame = 13
            player1.current_life = player1.current_life - player1.lost_life
            self.attack_time = 0
          end
          break
        end
        if self.collided == true then
          break
        end
      end
    end
    if self.collided == false then
      self.anim_time = self.anim_time + dt
      self.px = self.px_next_move
      if self.anim_time > enemy.mov_time then -- quando acumular mais de player1.mov_time
        self.anim_frame = self.anim_frame + 1 -- avança para proximo frame
        if self.anim_frame > 2 then
          self.anim_frame = 1
        end
        self.anim_time = 0 -- reinicializa a contagem do tempo
      end
      for i=self.py_map, self.py_map + self.height, 1 do
        for j=math.ceil(self.px), math.ceil(self.px)+self.width, 1 do
          map[i][j] = 1
        end
      end
    else
      set_pos(self,1, self.width, self.height)
    end
  elseif self.px_map > player1.px_map and ( self.equal_py == true or self.pref_axis == 1) then -- ESQUERDA
    if self.py_map < player1.py_map + enemy.mov_extra and self.py_map > player1.py_map - enemy.mov_extra then
      self.equal_py = true
      self.pref_axis = 0
    else
      self.pref_axis = 1
    end
    set_pos(self,0, self.width, self.height)
    self.dirx = -1
    self.diry = 0
    if self.anim_frame < 3 or self.anim_frame > 4 then
        self.anim_frame = 3
    end
    for i=self.py_map + 1, self.py_map + self.height, 1 do
      for j=math.ceil(self.px_next_move), math.ceil(self.px_next_move)+self.width, 1 do
        if map[i][j] == 0 then
          self.collided = false
        elseif map[i][j] == 1 then
          set_pos(self,1, self.width, self.height)
          self.collided = true
          break
        else
          set_pos(self,1, self.width, self.height)
          self.collided = true
          if self.attack_time > self.max_attack_time then
            self.anim_frame = 14            
            player1.current_life = player1.current_life - player1.lost_life
            self.attack_time = 0
          end
          break
        end
      end
      if self.collided == true then
        break
      end
    end
    if self.collided == false then
      self.anim_time = self.anim_time + dt
      self.px = self.px_next_move
      if self.anim_time > enemy.mov_time then -- quando acumular mais de player1.mov_time
        self.anim_frame = self.anim_frame + 1 -- avança para proximo frame
        if self.anim_frame > 4 then
          self.anim_frame = 3
        end
        self.anim_time = 0 -- reinicializa a contagem do tempo
      end
      for i=self.py_map, self.py_map+self.height, 1 do
        for j=math.ceil(self.px), math.ceil(self.px)+self.width, 1 do
          map[i][j] = 1
        end
      end
    else
      set_pos(self,1, self.width, self.height)
    end
  elseif self.py_map > player1.py_map and (self.equal_px == true  or self.pref_axis == 2) then -- CIMA
    if self.px_map > player1.px_map - enemy.mov_extra and self.px_map < player1.px_map + enemy.mov_extra then
      self.equal_px = true
      self.pref_axis = 0
    else
      self.pref_axis = 2
    end
    set_pos(self,0, self.width, self.height)
    self.dirx = 0
    self.diry = -1
    if self.anim_frame < 5 or self.anim_frame > 8 then
        self.anim_frame = 5
    end
    for i=math.ceil(self.py_next_move), math.ceil(self.py_next_move)+self.height, 1 do
      for j=self.px_map + 1, self.px_map+self.width, 1 do
        if map[i][j] == 0 then
          self.collided = false
        elseif map[i][j] == 1 then
          set_pos(self,1, self.width, self.height)
          self.collided = true
          break
        else
          set_pos(self,1, self.width, self.height)
          self.collided = true
          if self.attack_time > self.max_attack_time then
            player1.current_life = player1.current_life - player1.lost_life
            self.attack_time = 0
          end
          break
        end
      end
      if self.collided == true then
        break
      end
    end
    if self.collided == false then
      self.anim_time = self.anim_time + dt
      self.py = self.py_next_move
      if self.anim_time > enemy.mov_time then -- quando acumular mais de player1.mov_time
        self.anim_frame = self.anim_frame + 1 -- avança para proximo frame
        if self.anim_frame > 8 then
          self.anim_frame = 5
        end
        self.anim_time = 0 -- reinicializa a contagem do tempo
      end
      for i=math.ceil(self.py), math.ceil(self.py) + self.height, 1 do
        for j=self.px_map, self.px_map + self.width, 1 do
          map[i][j] = 1
        end
      end
    else
      set_pos(self,1, self.width, self.height)
    end
  elseif self.py_map < player1.py_map and ( self.equal_px == true or self.pref_axis == 2) then -- BAIXO
    if self.px_map > player1.px_map - enemy.mov_extra and self.px_map < player1.px_map + enemy.mov_extra then
      self.equal_px = true
      self.pref_axis = 0
    else
      self.pref_axis = 2
    end
    set_pos(self,0, self.width, self.height)
    self.dirx = 0
    self.diry = 1
    if self.anim_frame < 9 or self.anim_frame > 12 then
        self.anim_frame = 9
    end
    for i = math.ceil(self.py_next_move), math.ceil(self.py_next_move)+self.height, 1 do
      for j = self.px_map + 1,self.px_map+self.width, 1 do
        if map[i][j] == 0 then
          self.collided = false
        elseif map[i][j] == 1 then
          set_pos(self,1, self.width, self.height)
          self.collided = true
          break
        else
          self.collided = true
          set_pos(self,1, self.width, self.height)
          if self.attack_time > self.max_attack_time then
            player1.current_life = player1.current_life - player1.lost_life
            self.attack_time = 0
          end
          break
        end
      end
      if self.collided == true then
        break
      end
    end
    if self.collided == false then
      self.anim_time = self.anim_time + dt
      self.py = self.py_next_move
      if self.anim_time > enemy.mov_time then -- quando acumular mais de player1.mov_time
        self.anim_frame = self.anim_frame + 1 -- avança para proximo frame
        if self.anim_frame > 12 then
          self.anim_frame = 9
        end
        self.anim_time = 0 -- reinicializa a contagem do tempo
      end
      for i=math.ceil(self.py), math.ceil(self.py) + self.height, 1 do
        for j=self.px_map, self.px_map + self.width, 1 do
          map[i][j] = 1
        end
      end
    else
      set_pos(self,1, self.width, self.height)
    end
  end
end
function enemy.update(dt)
  if wave == 1 then
    enemy.spawn_between = 1.2
    enemy.spawn_type = math.ceil(love.math.random(1,2))
    if enemy.spawn_type == 1 then
      enemy.spawn_colour(enemy.red_px,enemy.red_py + distance_top, 1, enemy.mecholour_max_attack_time, enemy.mecholour_life, enemy.mecholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    else
      enemy.spawn_colour(enemy.green_px,enemy.green_py + distance_top, 2, enemy.mecholour_max_attack_time, enemy.mecholour_life, enemy.mecholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    end
  end
  if wave == 2 then
    enemy.spawn_between = 0.9
    enemy.spawn_type = math.ceil(love.math.random(1,2))
    if enemy.spawn_type == 1 then
      enemy.spawn_colour(enemy.red_px,enemy.red_py + distance_top, 1, enemy.mecholour_max_attack_time, enemy.mecholour_life, enemy.mecholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    else
      enemy.spawn_colour(enemy.green_px,enemy.green_py + distance_top, 2, enemy.mecholour_max_attack_time, enemy.mecholour_life, enemy.mecholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    end
  end
  if wave == 3 then
    enemy.spawn_between = 0.9
    enemy.spawn_type = math.ceil(love.math.random(1,3))
    if enemy.spawn_type == 1 then
      enemy.spawn_colour(enemy.red_px,enemy.red_py + distance_top, 1, enemy.mecholour_max_attack_time, enemy.mecholour_life, enemy.mecholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    elseif enemy.spawn_type == 2 then
      enemy.spawn_colour(enemy.green_px,enemy.green_py + distance_top, 2, enemy.mecholour_max_attack_time, enemy.mecholour_life, enemy.mecholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    else
      enemy.spawn_colour(enemy.blue_px,enemy.blue_py + distance_top, 3, enemy.mecholour_max_attack_time, enemy.mecholour_life, enemy.mecholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    end
  end
  if wave == 4 then
    enemy.boss3_time = enemy.boss3_time + dt
    enemy.quantity = 1
    enemy.spawn_colour(enemy.boss_px,enemy.boss_py + distance_top, 7, enemy.boss3_max_attack_time, enemy.boss3_life, enemy.boss3_speed, enemy.boss3_width, enemy.boss3_height, dt)
    for i,v in ipairs(enemies) do
      if enemy.boss3_time > enemy.boss3_max_time then
        --if v.colour >= 9 then
          --v.colour = 7
        --else
          --v.colour = v.colour + 1
        --end
        v.colour = math.random(7,9)
        enemy.boss3_time = 0
      end
    end
  end
  if wave == 5 then
    enemy.quantity = 30
    enemy.spawn_between = 1.2
    enemy.spawn_type = math.ceil(love.math.random(1,5))
    if enemy.spawn_type == 1 then
      enemy.spawn_colour(enemy.red_px,enemy.red_py + distance_top, 1, enemy.mecholour_max_attack_time, enemy.mecholour_life, enemy.mecholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    elseif enemy.spawn_type == 2 then
      enemy.spawn_colour(enemy.green_px,enemy.green_py + distance_top, 2, enemy.mecholour_max_attack_time, enemy.mecholour_life, enemy.mecholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    elseif enemy.spawn_type == 3 then
      enemy.spawn_colour(enemy.blue_px,enemy.blue_py + distance_top, 3, enemy.mecholour_max_attack_time, enemy.mecholour_life, enemy.mecholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    elseif enemy.spawn_type == 4 then
      enemy.spawn_colour(enemy.red_px,enemy.red_py + distance_top, 4, enemy.supercholour_max_attack_time, enemy.supercholour_life, enemy.supercholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt) 
    else
      enemy.spawn_colour(enemy.green_px,enemy.green_py + distance_top, 5, enemy.supercholour_max_attack_time, enemy.supercholour_life, enemy.supercholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    end
  end
  if wave == 6 then
    enemy.spawn_between = 0.9
    enemy.spawn_type = math.ceil(love.math.random(1,5))
    if enemy.spawn_type == 1 then
      enemy.spawn_colour(enemy.red_px,enemy.red_py + distance_top, 1, enemy.mecholour_max_attack_time, enemy.mecholour_life, enemy.mecholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    elseif enemy.spawn_type == 2 then
      enemy.spawn_colour(enemy.green_px,enemy.green_py + distance_top, 2, enemy.mecholour_max_attack_time, enemy.mecholour_life, enemy.mecholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    elseif enemy.spawn_type == 3 then
      enemy.spawn_colour(enemy.blue_px,enemy.blue_py + distance_top, 3, enemy.mecholour_max_attack_time, enemy.mecholour_life, enemy.mecholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    elseif enemy.spawn_type == 4 then
      enemy.spawn_colour(enemy.red_px,enemy.red_py + distance_top, 4, enemy.supercholour_max_attack_time, enemy.supercholour_life, enemy.supercholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt) 
    else
      enemy.spawn_colour(enemy.green_px,enemy.green_py + distance_top, 5, enemy.supercholour_max_attack_time, enemy.supercholour_life, enemy.supercholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    end
  end
  if wave == 7 then
    enemy.spawn_between = 0.9
    enemy.spawn_type = math.ceil(love.math.random(1,6))
    if enemy.spawn_type == 1 then
      enemy.spawn_colour(enemy.red_px,enemy.red_py + distance_top, 1, enemy.mecholour_max_attack_time, enemy.mecholour_life, enemy.mecholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    elseif enemy.spawn_type == 2 then
      enemy.spawn_colour(enemy.green_px,enemy.green_py + distance_top, 2, enemy.mecholour_max_attack_time, enemy.mecholour_life, enemy.mecholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    elseif enemy.spawn_type == 3 then
      enemy.spawn_colour(enemy.blue_px,enemy.blue_py + distance_top, 3, enemy.mecholour_max_attack_time, enemy.mecholour_life, enemy.mecholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
     elseif enemy.spawn_type == 4 then
      enemy.spawn_colour(enemy.red_px,enemy.red_py + distance_top, 4, enemy.supercholour_max_attack_time, enemy.supercholour_life, enemy.supercholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    elseif enemy.spawn_type == 5 then
      enemy.spawn_colour(enemy.green_px,enemy.green_py + distance_top, 5, enemy.supercholour_max_attack_time, enemy.supercholour_life, enemy.supercholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    else
      enemy.spawn_colour(enemy.blue_px,enemy.blue_py + distance_top, 6, enemy.supercholour_max_attack_time, enemy.supercholour_life, enemy.supercholour_speed, enemy.mecholour_width, enemy.mecholour_height, dt)
    end
  end
end
function enemy.draw()
  for i,v in ipairs(enemies) do
    if v.colour == 1 then
      love.graphics.draw(enemy.walk_red[v.anim_frame], v.px, v.py)
    end
    if v.colour == 2 then
      love.graphics.draw(enemy.walk_green[v.anim_frame], v.px, v.py)
    end
    if v.colour == 3 then
      love.graphics.draw(enemy.walk_blue[v.anim_frame], v.px, v.py)
    end
    if v.colour == 4 then
      love.graphics.draw(enemy.walk_superred[v.anim_frame], v.px, v.py)
    end
    if v.colour == 5 then
      love.graphics.draw(enemy.walk_supergreen[v.anim_frame], v.px, v.py)
    end
    if v.colour == 6 then
      love.graphics.draw(enemy.walk_superblue[v.anim_frame], v.px, v.py)
    end
    if v.colour == 7 then
      love.graphics.draw(enemy.walk_boss3_red[v.anim_frame], v.px, v.py)
    end
    if v.colour == 8 then
      love.graphics.draw(enemy.walk_boss3_green[v.anim_frame], v.px, v.py)
    end
    if v.colour == 9 then
      love.graphics.draw(enemy.walk_boss3_blue[v.anim_frame], v.px, v.py)
    end
  end
end