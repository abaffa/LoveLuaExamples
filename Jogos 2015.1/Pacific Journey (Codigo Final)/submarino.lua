function sub_load()
  w = 155
  h = 89
  x = love.graphics.getWidth()/2 - w
  y = 100
  s = 0.75
  swidth = s * w
  sheight = s * h

  sub = {
    px = x, 
    py = y,
    sx = s,
    sy = s,
    ox = 0,
    oy = 0,
    width = swidth,
    height = sheight,
    speed = 200, 
    anim = {}, 
    anim_frame = 1, 
    lives = 3,
    invencibilidade = false,
    lanterna = false,
    duplicar = false,
    relogio = false,
    i_tempo = 0,
    l_tempo = 0,
    d_tempo = 0,
    r_tempo = 0
  }
end

function sub_move(dt, dir)
  if dir == 1 then
    if sub.px + sub.width < love.graphics.getWidth() then
      if sub.invencibilidade == true then
        sub.anim_frame = 4
        sub.ox = 10
        sub.oy = 60
        sub.sx = 0.71
        sub.sy = 0.71
      else
        sub.anim_frame = 2
        sub.ox = 0
        sub.oy = 0
        sub.sx = 0.75
        sub.sy = 0.75
      end
      sub.px = sub.px + (sub.speed * dt)
    end
  else
    if sub.px + 5 > 0 then
      sub.px = sub.px - (sub.speed * dt)
      if sub.invencibilidade == true then
        sub.anim_frame = 3
        sub.ox = 10
        sub.oy = 60
        sub.sx = 0.71
        sub.sy = 0.71
      else
        sub.anim_frame=1
        sub.ox = 0
        sub.oy = 0
        sub.sx = 0.75
        sub.sy = 0.75
      end
    end
  end
end