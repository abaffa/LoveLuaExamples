local bullet = require "bullet"
require "player"

function CheckBoxCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

function collision_update(dt)
  for i=#bullet, 1, -1 do
    if CheckBoxCollision(hero_pos_x-hero_width/2, hero_pos_y-hero_height/2, hero_width, hero_height, bullet[i].x, bullet[i].y, bullet.width, bullet.height) then
     hero_collided = true
     table.remove(bullet, i)
     vivo = false
     vidas = vidas - 1
     if vidas < 1 then
      gamestate = "menu"
      troquei = false
      reset()
      break
     else 
      hero_collided = false
     end
    end
  end
end