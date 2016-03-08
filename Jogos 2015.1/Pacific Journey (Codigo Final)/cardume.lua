function cardume_spawn(vetor)
  x = love.math.random(0, 600)
  y = 800
  sx = 0.5
  sy = 0.4
  w = 280
  swidth = w * sx
  h = 282
  sheight = h * sy

  table.insert(vetor, {
      dirx = 1,
      diry = -1,
      px = x,
      hitbox_px = x - swidth/2,
      py = y,
      hitbox_py = y - sheight/2,
      sx = sx,
      sy = sy,
      width = swidth,
      height = sheight,
      rot = 0,
      tipo = 3
    })
end

function cardume_move(dt, tab)
  if tab.px > love.graphics.getWidth() + tab.width then
    tab.dirx = -1
    tab.px = love.graphics.getWidth() + tab.width
  elseif tab.px < -tab.width then
    tab.dirx = 1
    tab.px = -tab.width

  end
  if tab.dirx == -1 then
    tab.hitbox_px = tab.px - tab.width
  else
    tab.hitbox_px = tab.px
  end
  
  tab.sx = tab.dirx * 0.5
  tab.px = tab.px +  (300 * tab.dirx * dt * duplicar * slow)
  tab.py = tab.py - (150 * dt * duplicar * slow)
  tab.hitbox_py = tab.py
end
