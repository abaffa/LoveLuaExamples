--require "tempo"

function lanterna_load ()--tabela
  lanterna= {
    px= love.math.random(1,599),
    py=650,
    tempo=0,
    colisao=false,
    imagem = love.graphics.newImage ("lanterna.png")    
  }
end
function lanterna_spawn(vetor)
  x = love.math.random(1, 599)
  y = 650
  t = 0
  s = 0.3
  w = 170
  h = 173
  swidth = s * w
  sheight = s * h
  table.insert(vetor,{
      px = x,
      py = y,
      tempo = t,
      hitbox_px = x,
      hitbox_py = y,
      sx = s,
      sy = s,
      rot = 0,
      width = swidth,
      height = sheight,
      activated = false,
      tipo = 2
    })
  end
function lanterna_move (dt, tab)--movimento
  tab.py = tab.py - (150 * dt * duplicar * slow)
  tab.hitbox_py = tab.py
end
