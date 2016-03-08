function coral_spawn(vetor)
  y = 800
  w = 198
  h = 497
  s = 0.75
  swidth = w * s
  sheight = h * s
  --scaled width = swidth = width * scale
  --file width = width = width(da imagem, sem alteracoes)
  table.insert(vetor, {
      px = 0,
      py = y,
      rot = 1.57,
      spawn = love.math.random(1, 2),
      hitbox_px = 0,
      hitbox_py = y,
      sx = s,
      sy = s,
      tipo = 2,
      width = swidth,
      height= sheight
    })
end

function coral_move(dt, tab) --movimento + spawn
  if tab.spawn >= 1.5 then
    tab.px = love.graphics.getWidth() - tab.width
    tab.hitbox_px = tab.px
    tab.sy = -0.75
  else
    tab.px = tab.width
    tab.hitbox_px = 0
  end
  
  tab.py = tab.py - (150 * dt * duplicar * slow)
  tab.hitbox_py = tab.py 
end
