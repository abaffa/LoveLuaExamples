local tela, windX, windX2, windY, windY2, proporcao, count, fonte1, fonte2, enemy, count2, charNum, arenaNum, tela2, tela_count, winner
-- tela -> número da tela desenhada; windX2 e windY2 -> centralizadores de tela;
-- proporcao -> proporção da tela windX/windY; count -> contador para o modo de fullscreen;
-- fonte1 e fonte2 -> fontes de texto;
-- count2 -> para as músicas;

local menu, option, credits, char_selection, arena_selection, game


function proportionalResize()
  windX = love.graphics.getWidth()
  windY = love.graphics.getHeight()
  windX2 = windX
  windY2 = windY

  if (windX/windY > 4/3) then
    windX = windY*(4/3)
  elseif (windX/windY < 4/3) then
    windY = windX*(3/4)
  end
  windX2 = (windX2 - windX)/2
  windY2 = (windY2 - windY)/2
  proporcao = windX/800
end


function love.load()
  --TELA
  tela = 0 -- -- -- -- -- -- -- -- -- -- MUDA A TELA PARA TESTES -- -- -- -- -- -- -- -- -- --
  tela2 = 0 -- VERIFICA O VALOR DA TELA ANTERIOR A ALGUMA MUDANÇA (SOMENTE PARA ALGUMAS CLASSES)
  tela_count = 0 -- CONTADOR PARA INICIAR A TELA DE GAME DO ZERO, TODA VEZ QUE OCORRER UMA PARTIDA NOVA (O GAME SÓ PODE SER INICIADO APÓS TERMOS OS VALORES DA ARENA E DOS PERSONAGENS)
  love.window.setMode(800,600,{resizable=true, minwidth = 800, minheight = 600});
  love.window.setTitle("Battlecstasy")
  proportionalResize()
  --CHAMADA DE CLASSES
  game = require("game/game")
  arena_selection = require("arena_selection/arena_selection")
  char_selection = require("char_selection/char_selection")
  credits = require("credits/credits")
  menu = require("menu/menu")
  option = require("option/option")
  --MUSICA
  enemy = love.audio.newSource("menu/enemy.mp3", "stream")
  smash = love.audio.newSource("char_selection/smash.mp3", "stream")
  enemy:setLooping(true)
  smash:setLooping(true)
  enemy:play()
  count2 = 0
  --TEXTO (Dica da noite: crie uma variavel para cada fonte que recebe um valor em função da tela.)
  fonte1 = "feast.ttf"
  fonte2 = "bumrush.ttf"
  fonte3 = "swissek.ttf"
  --CHAMADA DO NEW DAS OUTRAS CLASSES
  arena_selection:new(fonte1, fonte3)
  char_selection:new(fonte1, fonte3)
  menu:new(fonte1, fonte2)
  option:new(fonte1, fonte2)
  credits:new(fonte1, fonte2)
  count = 0
  --ARENA E PERSONAGEM
  charNum = {}
  arenaNum = 0
end

function love.keyreleased(key)

  if tela == 0 then
    tela = menu:keyreleased(key)
  elseif tela == 1 then
    tela, charNum[1], charNum[2] = char_selection:keyreleased(key)
  elseif tela == 2  then
    tela = option:keyreleased(key)
  elseif tela == 3 then
    tela = credits:keyreleased(key)
  elseif tela == 4 then
    tela = arena_selection:keyreleased(key)
  end

  if key == "f12" then
    if not love.window.getFullscreen() then
      love.window.setFullscreen(true, "desktop")
    else
      love.window.setFullscreen(false)
    end
  end

  if key == "escape" then
    love.event.quit()
  end
end

function love.keypressed(key)
  if tela == 5 then
    game:keypressed(key)
  end
end


function love.mousereleased(x, y, button)
  if tela == 0 then
    tela = menu:mousereleased(button, x, y, proporcao, windX2, windY2)
  elseif tela == 2 then
    tela = option:mousereleased(button, x, y, proporcao, windX2, windY2)
  elseif tela == 3 then
    tela = credits:mousereleased(button, x, y, proporcao, windX2, windY2)
  end
end

function love.mousemoved(x, y, dx, dy)
  if tela == 0 then
    menu:mousemoved(x, y, dx, dy, proporcao, windX2, windY2)
  elseif tela == 2 then
    option:mousemoved(x, y, dx, dy, proporcao, windX2, windY2)
  elseif tela == 3 then
    credits:mousemoved(x, y, dx, dy, proporcao, windX2, windY2)
  end
end

function love.update(dt)
  deltaT = dt
  --TROCA DE MUSICA
  if tela == 1 and count2 == 0 then
    enemy:pause()
    enemy:rewind()
    smash:play()
    count2 = 1
  elseif tela == 0 and count2 == 1 then
    smash:pause()
    smash:rewind()
    enemy:play()
    count2 = 0
  end
  --GRAFICOS E TEXTOS
  proportionalResize()
  --Lembrete: faltam os botoes da tela 1 e 2, e mais tarde da tela 4 e 5.
  --Lembrete2: ponderar sobre a criação da tela 6 e 7, onde a 6 seria o menu de pause que pode ou não ser na frente da tela 5, e a tela 7 seria a tela de instruções do jogo.
  --Lembrete3: montar a história antes da tela 0, de modo que caso o jogador queira pular, é só pressionar "return" (enter) no teclado, botao esquerdo no mouse e start no joystick.
  --TELAS
  if tela == 2 then
    option:update(dt)
  elseif tela == 4 then
    tela, arenaNum = arena_selection:update(dt)
    if tela == 5 then
      game:new(arenaNum, charNum[1], charNum[2], proporcao, windX2, windY2)
    end
    
  elseif tela == 5 then
    tela = game:update(dt, proporcao, windX2, windY2)
    if tela ~= 5 then
      char_selection:new(fonte1, fonte3)
      arena_selection:new(fonte1, fonte3)
    end
  end
end

function love.draw()
  --print(tela)
  if tela == 0 then
    menu:draw(proporcao, windX2, windY2)
  elseif tela == 1 then
    char_selection:draw(proporcao, windX2, windY2)
  elseif tela == 2 then
    option:draw(proporcao, windX2, windY2, fonte1, fonte2)
  elseif tela == 3 then
    credits:draw(proporcao, windX2, windY2, fonte1, fonte2)
  elseif tela == 4 then
    arena_selection:draw(proporcao, windX2, windY2)
  elseif tela == 5 then
    game:draw(proporcao, windX2, windY2)
  end
end
