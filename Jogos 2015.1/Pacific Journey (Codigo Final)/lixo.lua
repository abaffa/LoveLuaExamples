function lixo_spawn(vetor)
  x = love.math.random(60,540)
  y = 800
  w = 105
  h = 155
  s = 0.5
  swidth = w * s
  sheight = h * s
  range = math.random(1, 3) 
  
  table.insert(vetor, {
      dirx = 1,
      px = x,
      px_ini = x,
      hitbox_px = x - swidth/2,
      py = y,
      hitbox_py = y - sheight/2,
      random = love.math.random(1,3),
      rot = 0,
      sx = s,
      sy = s,
      tipo = 4,
      width = swidth,
      height = sheight,
      random = math.random(1, 3)
    })
end

function lixo_move(dt, tab)
  px_spawn = tab.px
  tab.px = tab.px + (100 * tab.dirx * dt * duplicar * slow)
  
  if tab.px > tab.px_ini + (70 * tab.random) or tab.px > 600 - tab.width then 
    tab.random=love.math.random(1,3)
    tab.dirx=-1
  elseif tab.px < tab.px_ini - (50 * tab.random) or tab.px <0 then
    tab.random=love.math.random(1,3)
    tab.dirx=1
  end
  
  tab.py = tab.py - (50 * dt * duplicar * slow)
  tab.hitbox_px = tab.px
  tab.hitbox_py = tab.py
end