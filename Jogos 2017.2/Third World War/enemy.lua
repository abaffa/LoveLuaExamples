enemy = {}

function enemy.load()
	-- enemy width (largura)
	enemy.w = 60
	-- enemy height (altura)
	enemy.h = 100
	-- enemy speed (velocidade)
	enemy.s = 200
	-- enemy velocity (aceleração)
	enemy.v = 0
	-- enemy jump height (altura do pulo)
	enemy.j = -300
	-- enemy gravity (gravidade)
	enemy.g = -800
	-- enemy side (lado)
	enemy.l = "l"
	-- vida do enemy
	enemy.life = 2
	-- timer do enemy
	enemy.timer = 0
  
  enemy.bullet = {}
  
  e_bullet_w = 30
  
  e_bullet_h = 10
  
  enemy.image = love.graphics.newImage("images/enimigos/soldados_149.png")
	mobs = {}
end

function spawnEnemiesBullet(x, y, dir)
  table.insert(enemy.bullet, {x = x, y = y, dir = dir})
end

function enemy.update(dt)
	mob_spawn()

	for i=#mobs, 1, -1 do
		mob = mobs[i]
		mob.x = mob.x - cenario.s * dt
		
		for j=#shots, 1, -1 do
			shot = shots[j]
			if shot.x > mob.x and shot.x < mob.x+enemy.w and shot.y > mob.y and shot.y < mob.y+enemy.h then
				mob.life = mob.life - 1
				table.remove(shots, j)
			end
		end

		if mob.life == 0 then
			table.remove(mobs, i)
		end
		
		if grenade.exp and distancia(grenade.x, mob.x+enemy.w/2, grenade.y, mob.y+enemy.h/2) <= (enemy.w/2 + grenade.r*10) then
			table.remove(mobs, i)
		end

		if faca.on and distancia(faca.x, mob.x+enemy.w/2, faca.y, mob.y+enemy.h/2) <= (enemy.w/2 + faca.r) then
			table.remove(mobs, i)
		end

		if distancia(player.x+player.w/2, mob.x+enemy.w/2, player.y+player.h/2, mob.y+enemy.h/2) <= (enemy.w/2 + player.h/2 - 15) then
			table.remove(mobs, i)
			player.life = player.life - 1
		end
    
    if distancia(player.x+player.w/2, mob.x+enemy.w/2, player.y+player.h/2, mob.y+enemy.h/2) <= 400 then
      mob.bullet_timer = mob.bullet_timer + dt
      if mob.bullet_timer > 1 then
        local side = mob.side == "l" and -1 or 1
        spawnEnemiesBullet(mob.x, mob.y + 10, side)
        mob.bullet_timer = 0
      end
    end
	end
  
  for i=#enemy.bullet, 1, -1 do
    local b = enemy.bullet[i]
    
    b.x = b.x + 400*b.dir*dt
    
    if distancia(player.x+player.w/2, b.x, player.y+player.h/2, b.y) <= 50 then
      table.remove(enemy.bullet, i)
      player.life = player.life - 1
    end
  end
  
	if enemy.timer > 0 then
		enemy.timer = enemy.timer - dt
	end
end

function enemy.draw()
	for i=#mobs, 1, -1 do
		mob = mobs[i]
		--love.graphics.setColor(0, 255, 150)
    love.graphics.setColor(255,255,255)
		--love.graphics.rectangle("fill", mob.x, mob.y, enemy.w, enemy.h)
    love.graphics.draw(enemy.image, mob.x, mob.y, 0, 2.5, 2.5)
	end
  
  for i=#enemy.bullet, 1, -1 do
    local e = enemy.bullet[i]
    love.graphics.setColor(0, 0, 255)
		love.graphics.rectangle("fill", e.x, e.y, e_bullet_w, e_bullet_h)
  end
  
	love.graphics.setColor(255, 255, 255)
  
  
end

function mob_spawn()
	if enemy.timer <= 0 then
		mob = {x = 900, y = 500-enemy.h, side = "l", life = math.random(2,5), bullet_timer = 0}
		table.insert(mobs, 1, mob)
		enemy.timer = 3.5
	end
end

function distancia(x1, x2, y1, y2)
  return math.sqrt(((x2-x1)^2)+((y2-y1)^2))
end