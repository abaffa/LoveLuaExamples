--require "tempo"

function diamante_spawn(vetor)
  x = love.math.random(1, 599)
  y = 650
  s = 1
  w = 52
  h = 49
  swidth = (s * w)
  sheight = (s * h)
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
      tipo = 3
      
    })
  end
  
function diamante_move (dt, tab)--movimento
  tab.py= tab.py - (150 * dt * duplicar * slow) --*relogio.poder
  tab.hitbox_py = tab.py
end
