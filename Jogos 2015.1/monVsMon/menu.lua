function menu_load()
  gameState = -1;
  pagina_inicial = love.graphics.newImage("logo.png");
  novo_jogo = love.graphics.newImage("botao_1.png");
  continuar = love.graphics.newImage("botao_2.png");
  sair = love.graphics.newImage("botao_3.png");
  pressionado = 1;
  menuAudio = love.audio.newSource("sounds/menuSong.wav");
  pikachuSound = love.audio.newSource("sounds/pikachu.wav", "static");
end
function menu_keypressed(key)
  if key == "down" then
    if pressionado == 2 then
      pressionado = 3
    elseif pressionado == 1 then
      pressionado = 2
    else
      pressionado = 1
    end
  end
  if key == "up" then
    if pressionado == 2 then
      pressionado = 1
    elseif pressionado == 3 then
      pressionado = 2
    else
      pressionado = 3
    end
  end
  if key == "return" and pressionado == 3 then
    love.event.push ("quit")
  end
  if key == "return" and pressionado == 1 then
    love.audio.stop(menuAudio);
    love.audio.play(pikachuSound);
    gameState = 0.5;

  end
end
function menu_draw()
  love.audio.play(menuAudio);
  love.graphics.draw(pagina_inicial, 0, 0)
  if pressionado == 1 then
    love.graphics.draw(novo_jogo, 35, 375, 0, 0.5,0.5)
  elseif pressionado == 2 then
    love.graphics.draw(continuar, 35, 500, 0, 0.5,0.5)
  elseif pressionado == 3 then
    love.graphics.draw(sair, 48, 620, 0, 0.5, 0.5)
  end
end