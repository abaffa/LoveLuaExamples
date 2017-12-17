function gameover_load()
gameOver = love.graphics.newImage("Assets/gameOver.jpg")
fontAumentada = love.graphics.newFont(72) 
fontMedia = love.graphics.newFont(42)
end
function gameover_draw()
  love.graphics.draw(gameOver, 125,200)
  --love.graphics.setFont(fontAumentada)
--  love.graphics.print("Game Over",screen_w/3,screen_h/10)
 -- love.graphics.setFont(fontMedia)
 -- love.graphics.print("J-Jogar",screen_w/2,screen_h/2)
 -- love.graphics.print("S-Sair",screen_w/2,screen_h)
end

function gameover_keypressed(key,unicode)
  if key == "j" then
    gamestate = "init"
    game_reload()
    init_load()
  elseif key == "s" then
    love.event.quit()
  end
end