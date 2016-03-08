require "fase_do_onibus/fase_onibus"
require "fase_corrida/fase_corrida"
require "fase_beerpong/fase_beerpong"
require "fase _ basquete/fase_basquete"
require "final/easteregg"
require "final/final"
function love.load()
  onibus_load()
  corrida_load()
  beerpong_load()
  basquete_load()
  easteregg_load()
  final_load()
  fonte = love.graphics.newFont("fonte_arcade.ttf",60)
  tela_inicio = love.graphics.newImage("tela_inicio.png")
  quit = love.graphics.newImage("quit.png")
  start = love.graphics.newImage("start.png")
  love.window.setTitle("college rivals")
  love.window.setFullscreen(true,"exclusive")
  click = 0
  gamestate = 0
end
function love.mousepressed(x,y,button)
  if gamestate == 1 then
   onibus_mousepressed(x,y,button)
  elseif gamestate == 2 then
   corrida_mousepressed(x,y,button)
  elseif gamestate == 4 then 
   beerpong1_mousepressed(x,y,button)
   beerpong2_mousepressed(x,y,button)
  elseif gamestate == 3 then
   basquete1_mousepressed(x,y,button)
   basquete2_mousepressed(x,y,button)
  elseif gamestate == 5 then
   final_mousepressed(x,y,button)
  end
  if click == 0 and button == 1 then
    click = 1
  end
end
function love.mousereleased(x,y,button)
  if gamestate == 1 then
   onibus_mousereleased(x,y,button)
  elseif gamestate == 0 then
    if click == 1 and button == 1 then
     click = 0
    end
  elseif gamestate == 2 then
   corrida_mousereleased(x,y,button)
  elseif gamestate == 4 then
   beerpong_mousereleased(x,y,button)
  elseif gamestate == 3 then
   basquete_mousereleased(x,y,button)
  elseif gamestate == 5 then
   final_mousereleased(x,y,button)
  end
end
function check_start(mousex,mousey,x,hx,y,hy)
    return mousex < x + hx and mousey < y + hy and x < mousex + 1 and y < mousey + 1
end
function love.keypressed(key)
  if gamestate == 1 then
    onibus_keypressed(key)
  elseif gamestate == 2 then
   corrida_keypressed(key)
  end
end
function love.update(dt)
  if gamestate == 1 then 
    onibus_update(dt)
  elseif gamestate == 0 then
    if check_start(love.mouse.getX(),love.mouse.getY(),245,300,410,60) then
      if click == 1 then 
       gamestate = 1
      end 
    elseif check_start(love.mouse.getX(),love.mouse.getY(),245,300,490,60) then 
      if click == 1 and gamestate == 0 then 
       love.event.push("quit")
      end 
    end
  elseif gamestate == 2 then
   corrida_update(dt) 
  elseif gamestate == 4 then
   beerpong_update(dt)
  elseif gamestate == 3 then
   basquete_update(dt)
  elseif gamestate == 5 then
   final_update(dt)
  elseif gamestate == 6 then
   easteregg_update(dt)
  end
end
function love.draw()
  love.graphics.setFont(fonte)
  if gamestate == 1 then 
    onibus_draw()
  elseif gamestate == 0 then
    if check_start(love.mouse.getX(),love.mouse.getY(),245,300,410,60) then
     love.graphics.draw(tela_inicio,0,0)
     love.graphics.draw(start,150,400)
    elseif check_start(love.mouse.getX(),love.mouse.getY(),245,300,490,60) then
     love.graphics.draw(tela_inicio,0,0)
     love.graphics.draw(quit,150,470)
    else
     love.graphics.draw(tela_inicio,0,0)
    end
  elseif gamestate == 2 then
   corrida_draw()
  elseif gamestate == 4 then
    beerpong_draw()
  elseif gamestate == 3 then
    basquete_draw()
  elseif gamestate == 6 then
    easteregg_draw()
  elseif gamestate == 5 then
    final_draw()
  end
end