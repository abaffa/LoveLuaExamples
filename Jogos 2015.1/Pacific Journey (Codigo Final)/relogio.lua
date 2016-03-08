function relogio_spawn(vetor)
  x = love.math.random(60, 540)
  y = 650
  s = 0.33
  w = 132
  h = 133
  swidth = s * w
  sheight = s * h
  table.insert(vetor, {
      px = x,
      py = y,
      hitbox_px = x,
      hitbox_py = y,
      rot = 0,
      sx = s,
      sy = s,
      width = swidth,
      height = sheight,
      tipo = 5
      
    })
  end
  
  function relogio_move(dt, tab)
    tab.py = tab.py - (150 * dt * duplicar * slow)
    tab.hitbox_py = tab.py
  end