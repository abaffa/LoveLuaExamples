
function final_load()
  fontefinal = love.graphics.newFont("fonte_arcade.ttf",30)
  bg_final = love.graphics.newImage("final/final.png")
  final_click = 0
end
function final_check_mouse(mousex,mousey,x,hx,y,hy)
    return mousex < x + hx and mousey < y + hy and x < mousex + 1 and y < mousey + 1
end
function final_mousepressed(x,y,button)
  if final_click == 0 and button == "l" then
    final_click = 1
  end
end
function final_mousereleased(x,y,button)
  if final_click == 1 and button == "l" then
   final_click = 0
  end
end
function final_update(dt)
  if final_check_mouse(love.mouse.getX(),love.mouse.getY(),270,75,130,10) then
    gamestate = 6
  end
end
function final_draw()
  love.graphics.setFont(fontefinal)
  love.graphics.setColor(255,255,255)
  love.graphics.draw(bg_final,0,0)
  love.graphics.setColor(0,0,0)
  love.graphics.print("CONGRATULATIONS",270,130)
end