function lula_spawn(vetor)
  x = love.math.random(50, 550)
  w = 121
  h = 351
  s = 1
  swidth = s * w
  sheight = s * h
  
  table.insert(vetor,{
      dirx = 1,
      diry = 1,
      px = x,
      hitbox_px = x,
      py = -550,
      hitbox_py = -550 - sheight/2,
      rot = 0,
      sx = s,
      sy = s,
      tipo = 5,
      espera = 0,
      width = swidth,
      height = sheight
    })
end

function lula_move(dt, tab)
  if tab.py > -5 then
    tab.espera = tab.espera + dt * duplicar
    if tab.espera > 3 then
      tab.diry = -1
      tab.espera = 0
      tab.py = tab.py + (150 * tab.diry * dt * duplicar * slow)
    end
  else 
    tab.py = tab.py + (50 * tab.diry * dt * duplicar * slow)
  end
  tab.hitbox_py = tab.py
end