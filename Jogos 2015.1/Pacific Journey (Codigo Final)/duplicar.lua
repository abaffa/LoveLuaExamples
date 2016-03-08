function duplicar_spawn(vetor)
  x = love.math.random(60, 540)
  y = 650
  s = 0.2
  w = 240
  h = 225
  swidth = s * w
  sheight = s * h
  table.insert(vetor,{
      px = x,
      py = y,
      hitbox_px = x,
      hitbox_py = y,
      sx = s,
      sy = s,
      rot = 0,
      width = swidth,
      height = sheight,
      tipo = 4
    })
  end
  
function duplicar_move(dt, tab)
  tab.py = tab.py - (150 * dt * duplicar * slow)
  tab.hitbox_py = tab.py
end
