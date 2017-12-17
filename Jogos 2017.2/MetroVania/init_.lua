function init_load()
menu=love.graphics.newImage("Assets/menu.png")
end
function init_update(dt)
end

function init_draw()
  love.graphics.draw(menu,0,0)
end

function init_keypressed(key,unicode)
  if key == "j" then
    gamestate = "game"
  elseif key == "s" then
    love.event.quit()
  end
end