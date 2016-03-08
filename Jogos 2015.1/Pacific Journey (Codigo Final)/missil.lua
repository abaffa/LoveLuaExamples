function quant_missel()
  quant_missel=10
  end
function missil_spawn(vetor)
  x = sub.px + (sub.width)/2
  y = sub.py + (sub.height)/2
  w = 60
  h = 55
  s = 0.3
  swidth = w * s
  sheight = h * s
  table.insert(vetor, {
      px = x,
      py = y,
      rot = 2.25,
      hitbox_px = x - swidth/2,
      hitbox_py = y - sheight/2,
      sx = s,
      sy = s,
      width = swidth,
      height = sheight
    })
end

function missil_move(dt, tab)
  tab.py = tab.py + 500 * dt
  tab.hitbox_py = tab.py
end
