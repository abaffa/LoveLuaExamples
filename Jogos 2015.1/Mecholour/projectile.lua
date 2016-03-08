projectile = {
  global_colour = 1, --Cor que muda quando o jogador aperta q, w ou e
  gun = {}, -- Vetor que guarda os 3 tipo de projéteis (vermelho, verde e azul)
  gun_upgraded = {},
  red_upgrade = false,
  green_upgrade = false,
  blue_upgrade = false,
  time = 0, -- Tempo desde que o projétil foi spawnado até ele ser removido da tabela
  max_time = 0.4, -- Tempo entre o spawn de um projétil e o próximo
  x_dist_player = 15, -- Distância que o projétil spawnará do ponto de origem do player em x
  y_dist_player = 15, -- Distância que o projétil spawnará do ponto de origem do player em y
  width = 0, -- Largura do projétil
  height = 0 -- Altura do projétil
}

projectiles = {}
function projectile.load()
  for x = 1, 3, 1 do
    projectile.gun[x] = love.graphics.newImage("projectile/gun_" .. x .. ".png")
  end
  for x = 1, 3, 1 do
    projectile.gun_upgraded[x] = love.graphics.newImage("projectile/gun_upgraded_" .. x .. ".png")
  end
  projectile.width = projectile.gun[1]:getWidth()
  projectile.height = projectile.gun[1]:getHeight()
end
function projectile.spawn(px, py, dir, axis, rotate, colour)
  table.insert(projectiles, 
  {
    px = px + projectile.x_dist_player, 
    px_map = 0,
    py = py + projectile.y_dist_player, 
    py_map = 0,
    dir = dir, 
    axis = axis, 
    rotate=rotate, 
    speed = 500, 
    width = projectile.width, 
    height = projectile.height, 
    alive = true, 
    colour = colour
  })
end
function projectile.update(dt)
  if love.keyboard.isDown("q") then
    projectile.global_colour = 1
  elseif love.keyboard.isDown("w") then
    projectile.global_colour = 2
  elseif love.keyboard.isDown("e") then
    projectile.global_colour = 3
  end
  projectile.time = projectile.time + dt
  if love.keyboard.isDown("space") then
    if player1.dirx == 1 and player1.diry == 0 and projectile.time > projectile.max_time then
      projectile.spawn(player1.px, player1.py, 1, 0, math.pi/2, projectile.global_colour )
      projectile.time = 0
    elseif player1.dirx == -1 and player1.diry == 0 and projectile.time > projectile.max_time then
      projectile.spawn(player1.px, player1.py, -1, 0, -math.pi/2, projectile.global_colour )
      projectile.time = 0
    elseif player1.dirx == 0 and player1.diry == -1 and projectile.time > projectile.max_time then
      projectile.spawn(player1.px, player1.py, -1, 1, 0, projectile.global_colour )
      projectile.time = 0
    elseif player1.dirx == 0 and player1.diry == 1 and projectile.time > projectile.max_time then
      projectile.spawn(player1.px, player1.py, 1, 1, math.pi, projectile.global_colour)
      projectile.time = 0
    end
  end
  for i,v in ipairs(projectiles) do
    v.px_map = math.ceil(v.px)
    v.py_map = math.ceil(v.py)
    if v.axis == 0 then -- Axis = 0 representa que o projétil deve mover no eixo x
      v.px = v.px + (v.speed * v.dir * dt)
      if v.px > map_width - player1.distance_border - 30 or v.px < player1.distance_border then
        table.remove(projectiles, i)
      end
    end
    if v.axis == 1 then
      v.py = v.py + (v.speed * v.dir * dt) -- Axis = 1 representa que o projétil deve mover no eixo x
      if v.py > distance_top + map_height - player1.distance_border*3 or v.py < 20 + distance_top then
        table.remove(projectiles, i)
      end
    end
    for j,u in ipairs(enemies) do
      if v.py < map_height and v.py > 0 and v.px < map_width and v.px > 0 then
        if checkCollision(u,v) and v.alive == true and u.alive == true and (u.colour == v.colour or u.colour-3 == v.colour or u.colour-6 == v.colour)then
          v.alive = false
          if projectile.red_upgrade == true and (u.colour == 1 or u.colour == 4 or u.colour == 7) then
            u.life = u.life - 2
          elseif projectile.green_upgrade == true and (u.colour == 2 or u.colour == 5 or u.colour == 8) then
            u.life = u.life - 2
          elseif projectile.blue_upgrade == true and (u.colour == 3 or u.colour == 6 or u.colour == 9) then
            u.life = u.life - 2
          else
            u.life = u.life - 1
          end
        elseif checkCollision(u,v) and v.alive == true and u.alive == true and u.colour ~= v.colour then
          v.alive = false
        end
      end
--      if u.alive == false then
--        set_pos(u,0)
--        table.remove(enemies, j)
--      end
    end
    if v.alive == false then
      table.remove(projectiles, i)
    end
  end
end
function projectile.draw()
  for i,v in ipairs(projectiles) do
    if projectile.red_upgrade == true and v.colour == 1 then
      love.graphics.draw(projectile.gun_upgraded[v.colour], v.px, v.py, v.rotate)
    elseif projectile.green_upgrade == true and v.colour == 2 then
      love.graphics.draw(projectile.gun_upgraded[v.colour], v.px, v.py, v.rotate)
    elseif projectile.blue_upgrade == true and v.colour == 3 then
      love.graphics.draw(projectile.gun_upgraded[v.colour], v.px, v.py, v.rotate)
    else
      love.graphics.draw(projectile.gun[v.colour], v.px, v.py, v.rotate)
    end
  end
end