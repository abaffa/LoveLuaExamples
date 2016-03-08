--require "tempo"

function escudo_spawn(vetor)
  x = love.math.random(60, 540)
  y = 650
  t = 0
  s = 0.33
  h = 158
  w = 162
  swidth = w * s
  sheight = h * s
  table.insert(vetor,{
      px = x,
      py = y,
      hitbox_px = x,
      hitbox_py = y,
      tempo = t,
      sx = s,
      sy = s,
      rot = 0,
      tipo = 1,
      invencibilidade = false,
      width = swidth,
      height = sheight
      
    })
  end
  
  function escudo_move(dt, tab)
    tab.py = tab.py - (150 * dt * duplicar * slow)
    tab.hitbox_py = tab.py
  end
