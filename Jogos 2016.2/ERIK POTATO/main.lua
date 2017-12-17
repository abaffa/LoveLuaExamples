local desafio = {require "Iniciar", require "Desafio1", require "Desafio2", require "Desafio3", require "DesafioS", require "Score"}
local id = 1
local timer = 0
local timer_seg
local timer_min
local font = love.graphics.newFont("Tasty_Birds.otf", 18)
local pause
local Pause_BG
local Musica = love.audio.newSource("PotatoLand.wav", "static")
local Cursor = love.mouse.newCursor("PotatoCursor.png", 0, 0)
local laugh = love.audio.newSource("PotatoLaugh.mp3", "static")
local SMusicaS = love.audio.newSource("PotatoMetal.wav", "static")

io.stdout:setvbuf("no")

function aumentatempo()
  timer = timer + 30
end

local function trocarFase()
  local isSecret = id==5
  if id > 3 and id < 5 then
    id = id + 2
  else
    id = id + 1
  end
  desafio[id].load(trocarFase,isSecret)
end

function love.load()
  desafio[id].load(trocarFase)
  Pause_BG = love.graphics.newImage("Pause.png")
  love.window.setTitle("Erik the Potato: Quest of Enlightenment")
end

function love.update(dt)
  Musica:setVolume(0.2)
  Musica:play()
  if id > 4 then
    love.audio.stop(Musica)
  end
  if id > 5 then
    Musica:play()
  end
  if pause then
    return
  end
  desafio[id].update(dt)
  if id > 1 and id < 6 then
    timer = timer + dt
  end
  timer_seg = timer%60
  timer_min = timer/60
end

function love.draw()
  love.mouse.setCursor(Cursor)
  desafio[id].draw()
  love.graphics.setFont(font)
  love.graphics.setColor(255,102,255)
  if id > 1 and id < 6 then
    love.graphics.print("Timer: "..(((timer_min/10) < 1) and "0" or "")..math.floor(timer_min)..":"..(((timer_seg/10) < 1) and "0" or "")..math.floor(timer_seg), 700, 10)
  end
  if id > 5 then
    love.graphics.setColor(255,204,204)
    font = love.graphics.newFont("Score.otf", 36)
    love.graphics.print("Erik........................"..(((timer_min/10) < 1) and "0" or "")..math.floor(timer_min)..":"..(((timer_seg/10) < 1) and "0" or "")..math.floor(timer_seg), 245, 120)
  end
  love.graphics.setColor(255,255,255)
  if pause then
    love.graphics.draw(Pause_BG,0,0)
  end
end

function love.mousepressed(x,y,button)
  desafio[id].mousepressed(x,y,button)
  if button == 1 then
    if x > 240 and x < 290 and y > 455 and y < 515 and id == 1 then
      id = 5
      laugh:play()
      desafio[id].load(trocarFase)
    end
  end
end

function love.keypressed(key)
  if not pause then
    if id > 1 and key == 'p' and id < 5 then
      pause = true
    else
      desafio[id].keypressed(key)
    end
  else
    if key == 'p' then
      pause = false
    elseif key=='escape' then
      love.event.quit()
    end
  end
end