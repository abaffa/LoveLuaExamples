function player_load()
  hero_walk = {}
  hero_anim_frame = 1
  hero_pos_x = 100
  hero_pos_y = 600
  hero_velocidade_y = 0
  hero_anim_time = 0
  hero_dir_x = 1
  hero_dir_y = 1
  hero_collided = false
  hero_width = 10
  hero_height = 50
  g= 100

  for x = 1, 4, 1 do
    hero_walk[x] = love.graphics.newImage("walking_0" .. x .. ".png")
  end
end
function player_draw()
   love.graphics.setColor(255,255,255)
   love.graphics.draw(hero_walk[hero_anim_frame], hero_pos_x, hero_pos_y, 0, hero_dir_x*0.080, 0.080, hero_walk[hero_anim_frame]:getWidth()/2, hero_walk[hero_anim_frame]:getHeight()/2)
 end

function player_move(dt)
  if love.keyboard.isDown("d") then
    hero_dir_x = 1
    hero_pos_x = hero_pos_x + (250 *(hero_dir_x)* dt)
    hero_anim_time = hero_anim_time + dt 
    if hero_anim_time > 0.1 then 
      hero_anim_frame = hero_anim_frame + 1 
      if hero_anim_frame > 4 then
        hero_anim_frame = 1
      end
      hero_anim_time = 0 
    end
  elseif love.keyboard.isDown("a") then
    hero_dir_x = -1
    hero_pos_x = hero_pos_x + (250 *hero_dir_x* dt)
    hero_anim_time = hero_anim_time + dt 
    if hero_anim_time > 0.1 then 
      hero_anim_frame = hero_anim_frame + 1 
      if hero_anim_frame > 4 then
        hero_anim_frame = 1
      end
      hero_anim_time = 0 
    end
  elseif love.keyboard.isDown("w") then
    hero_dir_y = -1
    hero_pos_y = hero_pos_y + (250 *(hero_dir_y)* dt)
    hero_anim_time = hero_anim_time + dt 
    if hero_anim_time > 0.1 then 
      hero_anim_frame = hero_anim_frame + 1 
      if hero_anim_frame > 4 then
        hero_anim_frame = 1
      end
      hero_anim_time = 0 
    end
  elseif love.keyboard.isDown("s") then
    hero_dir_y = 1
    hero_pos_y = hero_pos_y + (250 *hero_dir_y* dt)
    hero_anim_time = hero_anim_time + dt 
    if hero_anim_time > 0.1 then 
      hero_anim_frame = hero_anim_frame + 1 
      if hero_anim_frame > 4 then
        hero_anim_frame = 1
      end
      hero_anim_time = 0 
    end
  end
  
  if hero_pos_y >= 560 then
    hero_pos_y = 560
  end
  if hero_pos_y <= 150 then
    hero_pos_y = 150
  end
  if hero_pos_x >= 520 then
    hero_pos_x = 520
  end
  if hero_pos_x <= 30 then
    hero_pos_x = 30
  end 
end

function player_keyreleased(key)
  if(key == 'a' or key == 'd')then
    hero_anim_frame= 1
  end
end