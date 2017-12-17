function enemy_load()
  enemy_x = 600
  enemy_y = 10
  enemy = love.graphics.newImage("leo_stronda.png")
end

function enemy_draw()
  love.graphics.draw(enemy,enemy_x,enemy_y, 0, 0.4, 0.4)
end

function enemy_getx()
  return enemy_x  
end

function enemy_gety()
  return enemy_y
end