function alga_spawn(vetor)
  s = 0.5
  x = 0
  y = 900
  h = 208
  w = 439
  swidth = s * w
  sheight = s * h
  table.insert(vetor, { 
      px = x, 
      py = y, 
      rot = 1.57, 
      hitbox_px = x, 
      hitbox_py = y, 
      spawn = love.math.random(1, 2), 
      sx = s, 
      sy = s, 
      tipo = 1, 
      width = swidth, 
      height = sheight
    })
end

function alga_move(dt, tab) --movimento + spawn
  if tab.spawn >= 1.5 then
    tab.px = love.graphics.getWidth() - tab.width + 30
    tab.sy = -0.5
    tab.hitbox_px = tab.px
  else
    tab.px = tab.width -30
    tab.sy = 0.5
    tab.hitbox_px = tab.px - tab.width
  end
  
  tab.py = tab.py - (150 * dt * duplicar * slow)
  tab.hitbox_py = tab.py
end
