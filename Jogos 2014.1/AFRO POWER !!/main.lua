
require "player"
require "conf"
require "menu"
require "enemie"
require "mapa"
require "arrow"
require "rock"
require "fireball"
require "icemagic"
HC = require "hardoncollider"
require "enemie"
require "background"
local terreno
local s_lago = {}
local mapa_config = {
 size_x = 190, 
 size_y = 26, 
 display_x = 38, 
 display_y = 26
}
camera = { 
 x = 1, 
 y = 1
}
function on_collide(dt, shape_a, shape_b,dx,dy)
  local other
  local fother
   if shape_a.type == "fireball" then
    fother = shape_b
  elseif shape_b.type == "fireball" then
    fother = shape_a
   end
   if shape_a.type == "icemagic" then
    fother = shape_b
  elseif shape_b.type == "icemagic" then
    fother = shape_a
   end
  if shape_a == player.shape then
    other = shape_b
  elseif shape_b == player.shape then
    other = shape_a
   end
  if shape_a == other or shape_b == other then
  if other.type == "grama" then
  for i,v in ipairs(grama) do
  if other == grama[v] then
    player.x = player.x + dx
    player.y = player.y + dy
    player.shape:move(dx,dy)
    player.sword:move(dx,dy)
    if dy ~= 0 then
    player.jump = 0
    player.canjump = true
    end
  end
end
end
  if other.type == "underground" then
  for i,v in ipairs(undergroundt) do
  if other == undergroundt[v] then
    player.x = player.x + dx
    player.y = player.y + dy
    player.shape:move(dx,dy)
    player.sword:move(dx,dy)
    if dy ~= 0 then
    player.jump = 0
    player.canjump = true
    end
    end
  end
end
  if other.type == "lago" then
  for i,v in ipairs(lagot) do
  if other == lagot[v] then
    player.vida = player.vida - 0.5
    if player.class == 0 then
     player.pic = love.graphics.newImage("knight walk/normal/dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 1 then
     player.pic = love.graphics.newImage("knight walk/knight/knight dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 2 then
     player.pic = love.graphics.newImage("knight walk/mage/mage dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 3 then
     player.pic = love.graphics.newImage("knight walk/ranger/ranger dano2.png")
     atacando = false
     jump = false
     end
    end
  end
end
  if other.type == "s_lago" then
  for i,v in ipairs(S_lagot) do
  if other == S_lagot[v] then
    player.vida = player.vida - 0.5
    if player.class == 0 then
     player.pic = love.graphics.newImage("knight walk/normal/dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 1 then
     player.pic = love.graphics.newImage("knight walk/knight/knight dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 2 then
     player.pic = love.graphics.newImage("knight walk/mage/mage dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 3 then
     player.pic = love.graphics.newImage("knight walk/ranger/ranger dano2.png")
     atacando = false
     jump = false
     end
    end
  end
end
  if other.type == "helm" then
  for i,v in ipairs(helmt) do
  if other == helmt[v] then
    player.class = 1
    mapa[v.i][v.j] = X
    Collider:remove(helmt[v])
    end
  end
end
  if other.type == "deathcap" then
  for i,v in ipairs(deathcapt) do
  if other == deathcapt[v] then
    player.class = 2
    mapa[v.i][v.j] = X
    Collider:remove(deathcapt[v])
    end
  end
end
  if other.type == "rangercap" then
  for i,v in ipairs(rangercapt) do
  if other == rangercapt[v] then
    player.class = 3
    mapa[v.i][v.j] = X
    Collider:remove(rangercapt[v])
    end
  end
end
  if other.type == "pente" then
  for i,v in ipairs(pentet) do
  if other == pentet[v] then 
    player.points = player.points + 1
    mapa[v.i][v.j] = X
    Collider:remove(pentet[v])
    --table.remove(pentet,v)
      end
  end
end
  if other.type == "enemie1" then
  for i,v in ipairs(enemie1t) do
  if other == enemie1t[v] then
    player.vida = player.vida - 100
    if player.class == 0 then
     player.pic = love.graphics.newImage("knight walk/normal/dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 1 then
     player.pic = love.graphics.newImage("knight walk/knight/knight dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 2 then
     player.pic = love.graphics.newImage("knight walk/mage/mage dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 3 then
     player.pic = love.graphics.newImage("knight walk/ranger/ranger dano2.png")
     atacando = false
     jump = false
   end
    player.x = player.x - 70
    player.shape: move (- 70,0)
    player.sword:move(-70,0)
  end
  end
end
  if other.type == "enemie2" then
  for i,v in ipairs(enemie2t) do
  if other == enemie2t[v] then
    player.vida = player.vida - 60
    if player.class == 0 then
     player.pic = love.graphics.newImage("knight walk/normal/dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 1 then
     player.pic = love.graphics.newImage("knight walk/knight/knight dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 2 then
     player.pic = love.graphics.newImage("knight walk/mage/mage dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 3 then
     player.pic = love.graphics.newImage("knight walk/ranger/ranger dano2.png")
     atacando = false
     jump = false
   end
    player.x = player.x - 70
    player.shape: move (- 70,0)
    player.sword:move(-70,0)
  end
  end
end
  if other.type == "enemie3" then
  for i,v in ipairs(enemie3t) do
  if other == enemie3t[v] then
    player.vida = player.vida - 20
    if player.class == 0 then
     player.pic = love.graphics.newImage("knight walk/normal/dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 1 then
     player.pic = love.graphics.newImage("knight walk/knight/knight dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 2 then
     player.pic = love.graphics.newImage("knight walk/mage/mage dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 3 then
     player.pic = love.graphics.newImage("knight walk/ranger/ranger dano2.png")
     atacando = false
     jump = false
   end
    player.x = player.x - 70
    player.shape: move (- 70,0)
    player.sword:move(-70,0)
  end
  end
end
  if other.type == "enemie4" then
  for i,v in ipairs(enemie4t) do
  if other == enemie4t[v] then
    player.vida = player.vida - 60
    if player.class == 0 then
     player.pic = love.graphics.newImage("knight walk/normal/dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 1 then
     player.pic = love.graphics.newImage("knight walk/knight/knight dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 2 then
     player.pic = love.graphics.newImage("knight walk/mage/mage dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 3 then
     player.pic = love.graphics.newImage("knight walk/ranger/ranger dano2.png")
     atacando = false
     jump = false
   end
    player.x = player.x - 70
    player.shape: move (- 70,0)
    player.sword:move(-70,0)
  end
  end
end
  if other.type == "enemie5" then
  for i,v in ipairs(enemie5t) do
  if other == enemie5t[v] then
    player.vida = player.vida - 40
    if player.class == 0 then
     player.pic = love.graphics.newImage("knight walk/normal/dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 1 then
     player.pic = love.graphics.newImage("knight walk/knight/knight dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 2 then
     player.pic = love.graphics.newImage("knight walk/mage/mage dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 3 then
     player.pic = love.graphics.newImage("knight walk/ranger/ranger dano2.png")
     atacando = false
     jump = false
   end
    player.x = player.x - 70
    player.shape: move (- 70,0)
    player.sword:move(-70,0)
  end
  end
end
  if other.type == "miniboss1" then
  for i,v in ipairs(miniboss1t) do
  if other == miniboss1t[v] then
    player.vida = player.vida - 200
    if player.class == 0 then
     player.pic = love.graphics.newImage("knight walk/normal/dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 1 then
     player.pic = love.graphics.newImage("knight walk/knight/knight dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 2 then
     player.pic = love.graphics.newImage("knight walk/mage/mage dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 3 then
     player.pic = love.graphics.newImage("knight walk/ranger/ranger dano2.png")
     atacando = false
     jump = false
   end
    player.x = player.x - 70
    player.shape: move (- 70,0)
    player.sword:move(-70,0)
  end
  end
end
  if other.type == "miniboss2" then
  for i,v in ipairs(miniboss2t) do
  if other == miniboss2t[v] then
    player.vida = player.vida - 120
    if player.class == 0 then
     player.pic = love.graphics.newImage("knight walk/normal/dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 1 then
     player.pic = love.graphics.newImage("knight walk/knight/knight dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 2 then
     player.pic = love.graphics.newImage("knight walk/mage/mage dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 3 then
     player.pic = love.graphics.newImage("knight walk/ranger/ranger dano2.png")
     atacando = false
     jump = false
   end
    player.x = player.x - 70
    player.shape: move (- 70,0)
    player.sword:move(-70,0)
  end
  end
end
  if other.type == "miniboss3" then
  for i,v in ipairs(miniboss3t) do
  if other == miniboss3t[v] then
    player.vida = player.vida - 40
    if player.class == 0 then
     player.pic = love.graphics.newImage("knight walk/normal/dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 1 then
     player.pic = love.graphics.newImage("knight walk/knight/knight dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 2 then
     player.pic = love.graphics.newImage("knight walk/mage/mage dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 3 then
     player.pic = love.graphics.newImage("knight walk/ranger/ranger dano2.png")
     atacando = false
     jump = false
   end
    player.x = player.x - 70
    player.shape: move (- 70,0)
    player.sword:move(-70,0)
  end
  end
end
  if other.type == "armadilha" then
  for i,v in ipairs(armadilhat) do
  if other == armadilhat[v] then
    player.vida = player.vida - 20
    if player.class == 0 then
     player.pic = love.graphics.newImage("knight walk/normal/dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 1 then
     player.pic = love.graphics.newImage("knight walk/knight/knight dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 2 then
     player.pic = love.graphics.newImage("knight walk/mage/mage dano2.png")
     atacando = false
     jump = false
     end
    if player.class == 3 then
     player.pic = love.graphics.newImage("knight walk/ranger/ranger dano2.png")
     atacando = false
     jump = false
     end
  end
  end
end
  if other.type == "cogumelo" then
  for i,v in ipairs(cogumelot) do
  if other == cogumelot[v] then
    player.shape:move(0,-500*dt)
    player.sword:move(0,-500*dt)
    player.y = player.y - 500*dt
    player.jump = -700
    player.canjump = true
  end
  end
end
  if other.type == "plataforma" then
  for i,v in ipairs(plataformat) do
  if other == plataformat[v] then
    if player.jump > 0 and player.y - v.y <= 0 then 
    player.y = player.y + dy
    player.shape:move(0,dy)
    player.sword:move(0,dy)
    if dy ~= 0 then
    player.jump = 0
    player.canjump = true
    end
  end
  end
  end
end
  if other.type == "espinhos" then
  for i,v in ipairs(espinhost) do
  if other == espinhost[v] then
    player.vida = player.vida - 1000
  end
  end
end
  if other.type == "escada" then
  for i,v in ipairs(escadat) do
  if other == escadat[v] then
    player.canjump = false
    if love.keyboard.isDown("w") then
      player.jump = -100
      if player.class == 0 then
        if player_escada_num == 1 then
          player.pic = afrosobe[1]
        end
        if player_escada_num == 2 then
          player.pic = afrosobe[2]
        end
      elseif player.class == 1 then
        if player_escada_num == 1 then
          player.pic = knightsobe[1]
        end
        if player_escada_num == 2 then
          player.pic = knightsobe[2]
        end
      elseif player.class == 2 then
        if player_escada_num == 1 then
          player.pic = magesobe[1]
        end
        if player_escada_num == 2 then
          player.pic = magesobe[2]
        end
      elseif player.class == 3 then
        if player_escada_num == 1 then
          player.pic = rangersobe[1]
        end
        if player_escada_num == 2 then
          player.pic = rangersobe[2]
        end
      end
      end
    end
  end 
  end
  if other.type == "pedra" then
  for i,v in ipairs(pedrat) do
  if other == pedrat[v] then
    player.x = player.x +dx 
    player.y = player.y +dy
    player.shape:move(dx,dy)
    player.sword:move(dx,dy)
    if dy ~= 0 then
    player.jump = 0
    player.canjump = true
    end
      end
  end
end
  if other.type == "porta de fogo" then
  for i,v in ipairs(portafogot) do
  if other == portafogot[v] then
    player.x = player.x +dx 
    player.y = player.y +dy
    player.shape:move(dx,dy)
    player.sword:move(dx,dy)
    if dy ~= 0 then
    player.jump = 0
    end
    if player.class == 2 then
      Collider:remove(portafogot[v])
    end
end
end
end
if other.type == "porta de gelo" then
  for i,v in ipairs(portagelot) do
  if other == portagelot[v] then
    player.x = player.x +dx 
    player.y = player.y +dy
    player.shape:move(dx,dy)
    player.sword:move(dx,dy)
    if dy ~= 0 then
    player.jump = 0
    end
    if player.class == 2 then
      Collider:remove(portagelot[v])
    end
end
end
end
end

  if shape_a == fother or shape_b == fother then
    if fother.type == "enemie1" then
      for i,v in ipairs(enemie1t) do
        if fother == enemie1t[v] then
          v.vida = v.vida - 60
          if player.class == 0 then
            v.vida = v.vida - 20
          elseif player.class == 1 then
            v.vida = v.vida - 120
          end
          if v.vida <= 0 then
           mapa[v.i][v.j] = X
           Collider:remove(enemie1t[v])
         end
        end
      end
    end
    if fother.type == "enemie2" then
      for i,v in ipairs(enemie2t) do
        if fother == enemie2t[v] then
          v.vida = v.vida - 60
          if player.class == 0 then
            v.vida = v.vida - 20
          elseif player.class == 1 then
            v.vida = v.vida - 120
          end
          if v.vida <= 0 then
           mapa[v.i][v.j] = X
           Collider:remove(enemie2t[v])
         end
        end
      end
    end
    
    
    if fother.type == "enemie3" then
      for i,v in ipairs(enemie3t) do
        if fother == enemie3t[v] then
          v.vida = v.vida - 60
          if player.class == 0 then
            v.vida = v.vida - 20
          elseif player.class == 1 then
            v.vida = v.vida - 120
          end
          if v.vida <= 0 then
           mapa[v.i][v.j] = X
           Collider:remove(enemie3t[v])
         end
        end
      end
    end
    
    if fother.type == "enemie4" then
      for i,v in ipairs(enemie4t) do
        if fother == enemie4t[v] then
          v.vida = v.vida - 60
          if player.class == 0 then
            v.vida = v.vida - 20
          elseif player.class == 1 then
            v.vida = v.vida - 120
          end
          if v.vida <= 0 then
           mapa[v.i][v.j] = X
           Collider:remove(enemie4t[v])
         end
        end
      end
    end
    
    if fother.type == "enemie5" then
      for i,v in ipairs(enemie5t) do
        if fother == enemie5t[v] then
          v.vida = v.vida - 100
          if player.class == 0 then
            v.vida = v.vida - 50
          elseif player.class == 1 then
            v.vida = v.vida - 200
          end
          if v.vida <= 0 then
           mapa[v.i][v.j] = X
           Collider:remove(enemie5t[v])
         end
        end
      end
    end
    if fother.type == "miniboss1" then
      for i,v in ipairs(miniboss1t) do
        if fother == miniboss1t[v] then
          v.vida = v.vida - 100
          if player.class == 0 then
            v.vida = v.vida - 50
          elseif player.class == 1 then
            v.vida = v.vida - 200
          end
          if v.vida <= 0 then
           mapa[v.i][v.j] = X
           Collider:remove(miniboss1t[v])
         end
        end
      end
    end
    if fother.type == "miniboss2" then
      for i,v in ipairs(miniboss2t) do
        if fother == miniboss2t[v] then
          v.vida = v.vida - 100
          if player.class == 0 then
            v.vida = v.vida - 50
          elseif player.class == 1 then
            v.vida = v.vida - 200
          end
          if v.vida <= 0 then
           mapa[v.i][v.j] = X
           Collider:remove(miniboss2t[v])
         end
        end
      end
    end
    if fother.type == "miniboss3" then
      for i,v in ipairs(miniboss3t) do
        if fother == miniboss3t[v] then
          v.vida = v.vida - 100
          if player.class == 0 then
            v.vida = v.vida - 50
          elseif player.class == 1 then
            v.vida = v.vida - 200
          end
          if v.vida <= 0 then
           mapa[v.i][v.j] = X
           Collider:remove(miniboss3t[v])
         end
        end
      end
    end
  end
end

 function love.load()
   --love.window.setFullscreen(true, "normal") 
   Collider = HC(100, on_collide)
   terreno = {image = love.graphics.newImage("terreno/earth floor.png")}
   terreno_inclinado = love.graphics.newImage("terreno/earth floor inclinado.png")
   underground = {image = love.graphics.newImage("terreno/earth floor2.png")}
   lago = {image = love.graphics.newImage("terreno/poison water floor2.png")}
   pente = love.graphics.newImage("itens/pente.png")
   vida_jogador = love.graphics.newImage("itens/player life.png")
   vida_jogador_borda = love.graphics.newImage("itens/player life borda.png")
   espada_afro = love.graphics.newImage("itens/afro sword.png")
   chapeu_K = love.graphics.newImage("itens/knight.png")
   chapeu_R = love.graphics.newImage("itens/ranger.png")
   chapeu_M = love.graphics.newImage("itens/mage.png")
   interface = love.graphics.newImage("itens/interface-1.png")
   espinhos = love.graphics.newImage("terreno/espinhos.png")
   escada = love.graphics.newImage("terreno/escada.png")
   armadilha = love.graphics.newImage("itens/traps.png")
   pedra = love.graphics.newImage("itens/pedra.png")
   cogumelo = love.graphics.newImage("itens/cogumelo2.png")
   plataforma = love.graphics.newImage("terreno/plataforma.png")
   porta_fogo = love.graphics.newImage("terreno/porta fogo.png")
   porta_gelo = love.graphics.newImage("terreno/porta gelo.png")
   start = love.graphics.newImage("itens/start.png")
   quit = love.graphics.newImage("itens/quit.png")
   medium = love.graphics.newFont(1000)
   gamestate = "menu"
   button_spawn(400, 450, "START", "start")
   button_spawn(400, 500, "QUIT", "quit")
   LoadMap("TUTORIAL.txt",1,1)
   --fasechange("FLORESTA 3.txt",168*23,79*23,502,200)
   initialize()
   s_lago[1] = love.graphics.newImage("terreno/poison water floor1.png")
   s_lago[2] = love.graphics.newImage("terreno/poison water floor3.png")
   s_lago[3] = love.graphics.newImage("terreno/poison water floor3.png")
   s_lagonum = 1
   s_lagopic = s_lago[1]
   s_lagoanimtimer = 0
end

function love.update(dt)
  if camera.x/23 >= mapa_config.size_x - mapa_config.display_x -5 then
    gamestate = "winner"
    --player.vida = 1000
    --player.shape:moveTo(100,300)
    --player.sword:moveTo(120,300)
    --player.x = 50
    --player.y = 200
    --fasechange("FLORESTA 2.1.txt",20*23,39*23,217,73)
    end
  if player.vida <= 0 then
    player.vida = 1000
    player.shape:moveTo(100,300)
    player.sword:moveTo(120,300)
    player.x = 120
    player.y = 210
    fasechange("TUTORIAL.txt",1,1,190,26)
   end
  offset_x = math.floor(camera.x % 23)
  first_tile_x = math.floor(camera.x / 23)
  offset_y = math.floor(camera.y % 23)
  first_tile_y = math.floor(camera.y / 23) 
  Collider:update(dt)
  if camera.x > mapa_config.size_x * 23 - mapa_config.display_x * 23  then
    camera.x = mapa_config.size_x * 23 - mapa_config.display_x * 23
  end
  if gamestate == "winner" then
    if love.keyboard.isDown("return") then
      gamestate = "menu"
    end
  end
  if gamestate == "playing" then
    player.update(dt,mapa_config.size_y,mapa_config.display_y) 
    background_update(dt)
    arrow.update(dt)
    rock.update(dt)
    fireball.update(dt)
    icemagic.update(dt)
    enemies_update(dt)
    s_lagopic = s_lago[s_lagonum]
    s_lagoanimtimer = s_lagoanimtimer + dt
    if s_lagonum > 2 then
      s_lagonum = 1
    end
    s_lagopic = s_lago[s_lagonum]
    s_lagoanimtimer = s_lagoanimtimer + dt
    if s_lagonum == 3 then
      s_lagonum = 1
    end
    if s_lagoanimtimer > 0.6 then
      s_lagonum = s_lagonum + 1
      s_lagoanimtimer = 0
    end
    if s_lagoanimtimer > 0.5 then
      s_lagonum = s_lagonum + 1
      s_lagoanimtimer = 0
    end
  end
  if love.keyboard.isDown("escape") then
    love.event.push("quit")
  end 
  if gamestate == "menu" then
    if love.keyboard.isDown("return") then
      gamestate = "playing"
    end
  end
end

function fasechange(filename,camerax,cameray,mapa_configsize_x,mapa_configsize_y)
  player.points = 0
  for i,v in ipairs(grama) do
    grama[i] = nil
    Collider:remove(grama[v])
    
  end
  for i,v 
    in ipairs(undergroundt) do
    undergroundt[i] = nil
    Collider:remove(undergroundt[v])

  end
  for i,v in ipairs(lagot) do
    lagot[i] = nil
    Collider:remove(lagot[v])

  end
  for i,v in ipairs(pentet) do
    pentet[i] = nil
    Collider:remove(pentet[v])

  end
  for i,v in ipairs(S_lagot) do
   S_lagot[i] = nil
   Collider:remove(S_lagot[v])

  end
  for i,v in ipairs(helmt) do
    helmt[i] = nil
    Collider:remove(helmt[v])

  end
  for i,v in ipairs(deathcapt) do
    deathcapt[i] = nil
    Collider:remove(deathcapt[v])

  end
  for i,v in ipairs(rangercapt) do
    rangercapt[i] = nil
    Collider:remove(rangercapt[v])

  end
  for i,v in ipairs(enemie1t) do
    enemie1t[i] = nil
    Collider:remove(enemie1t[v])

  end
  for i,v in ipairs(enemie2t) do
    enemie2t[i] = nil
    Collider:remove(enemie2t[v])

  end
  for i,v in ipairs(enemie3t) do
    enemie3t[i] = nil
    Collider:remove(enemie3t[v])

  end
  for i,v in ipairs(enemie4t) do
    enemie4[i] = nil
    Collider:remove(enemie4t[v]
      )
  end
  for i,v in ipairs(enemie5t) do
    enemie5t[i] = nil
    Collider:remove(enemie5t[v])

  end
  for i,v in ipairs(armadilhat) do
    armadilhat[i] = nil
    Collider:remove(armadilhat[v])

  end
  for i,v in ipairs(cogumelot) do
    cogumelot[i] = nil
    Collider:remove(cogumelot[v])

  end
  for i,v in ipairs(plataformat) do
    plataformat[i] = nil
    Collider:remove(plataformat[v])

  end
  for i,v in ipairs(espinhost) do
    espinhost[i] = nil
    Collider:remove(espinhost[v])

  end
  for i,v in ipairs(escadat) do
    escadat[i] = nil
    Collider:remove(escadat[v])

  end
  for i,v in ipairs(pedrat) do
    pedrat[i] = nil
    Collider:remove(pedrat[v])

end
  for i,v in ipairs(portafogot) do
    portafogot[i] = nil
    Collider:remove(portafogot[v])

end
  for i,v in ipairs(portagelot) do
    portagelot[i] = nil
    Collider:remove(portagelot[v])

end
  for i,v in ipairs(miniboss1t) do
    miniboss1t[i] = nil
    Collider:remove(miniboss1t[v])

end
  for i,v in ipairs(miniboss2t) do
    miniboss2t[i] = nil
    Collider:remove(miniboss2t[v])

end
  for i,v in ipairs(miniboss3t) do
    miniboss3t[i] = nil
    Collider:remove(miniboss3t[v])

end

  camera.x = camerax
  camera.y = cameray
  mapa_config.size_x = mapa_configsize_x
  mapa_config.size_y = mapa_configsize_y
  LoadMap(filename,camerax,cameray)
  
  end

function love.keyreleased(key)
	--player.animreset(key)
end

function love.draw()
  if gamestate == "playing" then
    background_draw()
    love.graphics.print("Pontos:"..tostring(player.points) ,700,20)     --for i,v in ipairs(grama) do
    player.draw()
    --player.shape:draw('line')
    --mage.draw()
    arrow.draw()
    rock.draw()
    fireball.draw()
    icemagic.draw()
    love.graphics.draw(vida_jogador, 8, 130,0, 2, -5*player.vida/1000)
    love.graphics.draw(vida_jogador_borda, 3, -5, 0, 2, 5)
    for i= 1 , mapa_config.display_y, 1 do
      for j= 1 ,mapa_config.display_x, 1 do
      if (mapa [first_tile_y + i][first_tile_x + j] == "G") then
        love.graphics.draw(terreno.image, ((j-1)*23)-offset_x - 40, ((i-1)*23)+80 -43 - offset_y)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "T") then
        love.graphics.draw(underground.image, ((j-1)*23)-offset_x - 40, ((i-1)*23)+80-43 - offset_y)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "V") then
        love.graphics.draw (lago.image, ((j-1)*23)-offset_x - 40, ((i-1)*23)+80-43 - offset_y)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "L") then
        love.graphics.draw (s_lagopic, ((j-1)*23)-offset_x - 40, ((i-1)*23)+80-43 - offset_y)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "D") then
        love.graphics.draw(pente, ((j-1)*23)-offset_x - 40 + 10, ((i-1)*23) +80-43 - offset_y)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "K") then
        love.graphics.draw(chapeu_K, ((j-1)*23)-offset_x - 40 + 10, ((i-1)*23) +80-43 - offset_y)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "M") then
        love.graphics.draw(chapeu_M, ((j-1)*23)-offset_x - 40 + 10, ((i-1)*23) +80-43 - offset_y)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "A") then
        love.graphics.draw(chapeu_R, ((j-1)*23)-offset_x - 40 + 10, ((i-1)*23) +80-43 - offset_y)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "U") then
        love.graphics.draw (armadilha, ((j-1)*23)-offset_x - 40, ((i-1)*23)+80-20 - offset_y, 0, 2)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "B") then
        love.graphics.draw (cogumelo, ((j-1)*23)-offset_x - 40, ((i-1)*23)+50 - offset_y)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "P") then
        love.graphics.draw (plataforma, ((j-1)*23)-offset_x - 30, ((i-1)*23)+80-32 - offset_y)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "E") then
        love.graphics.draw (espinhos, ((j-1)*23)-offset_x - 40 +11, ((i-1)*23)+80-23 - offset_y)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "H") then
        love.graphics.draw (escada, ((j-1)*23)-offset_x - 40 +12, ((i-1)*23)+80-43 + 10 - offset_y)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "S") then
        love.graphics.draw (pedra, ((j-1)*23)-offset_x - 30, ((i-1)*23)+55 - offset_y,0,1.1,1.1)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "F") then
        love.graphics.draw (porta_fogo, ((j-1)*23)-offset_x - 30, ((i-1)*23)+80-33,0,1.1,1.1)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "I") then
        love.graphics.draw (porta_gelo, ((j-1)*23)-offset_x - 30, ((i-1)*23)+80-33,0,1.1,1.1)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "N") then
        love.graphics.draw (enemie1.pic, ((j-1)*23)-offset_x - 40, ((i-1)*23)+80-43 + 33,0, 1, 1, enemie1.pic:getWidth(), enemie1.pic:getHeight())
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "Y") then
        love.graphics.draw (enemie2.pic, ((j-1)*23)-offset_x - 40, ((i-1)*23)+80-43 + 40, 0, 1, 1, enemie2.pic:getWidth(), enemie2.pic:getHeight())
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "Z") then
        love.graphics.draw (enemie3.pic, ((j-1)*23)-offset_x - 40, ((i-1)*23)+80-43)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "W") then
        love.graphics.draw (enemie4.pic, ((j-1)*23)-offset_x - 40, ((i-1)*23)+80-43+ 35, 0, 1, 1, enemie4.pic:getWidth(), enemie4.pic:getHeight())
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "R") then
        love.graphics.draw (enemie5.pic, ((j-1)*23)-offset_x - 40, ((i-1)*23)+80-43+10, 0, 2, 2)
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "Q") then
        love.graphics.draw (miniboss1.pic, ((j-1)*23)-offset_x+100, ((i-1)*23)+80,0,1,1, miniboss1.pic:getWidth(),miniboss1.pic:getHeight())
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "O") then
        love.graphics.draw (miniboss2.pic, ((j-1)*23)-offset_x+100, ((i-1)*23)+80,0,1,1, miniboss2.pic:getWidth(),miniboss2.pic:getHeight())
      elseif (mapa [first_tile_y +i][first_tile_x + j] == "C") then
        love.graphics.draw (miniboss3.pic, ((j-1)*23)-offset_x-40, ((i-1)*23)+80)
 end
end
end
end
  if gamestate == "menu" then
    love.graphics.draw(interface)
    button_draw()
  end
  if gamestate == "winner" then
    love.graphics.print("VOCÊ COMPLETOU O TUTORIAL,PARABÉNS !!", 100, 300, 0, 2, 2)
    love.graphics.print("< PRESS ENTER >", 300, 400, 0, 2, 2)
  end
end
  
function love.mousepressed(x,y)
  if gamestate == "menu" then
    button_click(x,y)
  end
end