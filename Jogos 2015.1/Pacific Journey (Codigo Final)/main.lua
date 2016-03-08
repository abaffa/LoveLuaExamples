require "alga"
require "coral"
require "lixo"
require "cardume"
require "lula"
require "missil"
require "menu"
require "gameover"
require "submarino"
require "escudo"
require "lanterna"
require "diamante"
require "duplicar"
require "relogio"

love.window.setTitle("Pacific Journey")

musica=love.audio.newSource("(8-Bit) Yellow Submarine.mp3")
musica:setLooping(love.audio.play(musica))

local background
local brilho
screenheight = love.graphics.getHeight()
screenwidth = love.graphics.getWidth()
quant_missel()
textx = screenwidth - 330
missil_image = love.graphics.newImage("missil.png")
imagens={}
p_imagens = {}
duplicar = 1
slow = 1
--[1=alga, 2=coral, 3=cardume, 4=lixo, 5=lula]--
function Check_Collision (x1, y1, w1, h1, x2, y2, w2, h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

function love.load()
--etc
  quant_missel=10
  musica: setLooping(love.audio.play(musica))
  enemies = {}
  misseis = {}
  powers = {}
  timer=0
  score=0
  score_mod=1
  penumbra = 0
  enemy_spawn_timer = 0
  power_spawn_timer = 0
  brilho = 0.1

--carrega o sub--
  sub_load()


--load inicial das imagens
  imagens[1] = love.graphics.newImage("alga.png")
  imagens[2] = love.graphics.newImage("coral.png")
  imagens[3] = love.graphics.newImage("cardume.png")
  imagens[4] = love.graphics.newImage("lixo.png")
  imagens[5] = love.graphics.newImage("lula.png")
  p_imagens[1] = love.graphics.newImage("escudo.png")
  p_imagens[2] = love.graphics.newImage("lanterna.png")
  p_imagens[3] = love.graphics.newImage("diamante.png")
  p_imagens[4] = love.graphics.newImage("duplicar.png")
  p_imagens[5] = love.graphics.newImage("relogio.png")

  --menu--
  gamestate = "menu"
  love.graphics.setFont(love.graphics.newFont("Beatles.ttf", 20))
  botao_spawn(34, 408, "Play", "Play")
  botao_spawn(205, 485, "Quit", "Quit")

  love.window.setMode(600, 650)
  love.graphics.setBackgroundColor(0, 0, 0)

  for i=1, 4, 1 do --carrega as frames da animacao--
    sub.anim[i]=love.graphics.newImage("sub"..i..".png")
  end

  background=love.graphics.newImage("background.png")--define o background--

  -- Game over--
  love.graphics.setFont(love.graphics.newFont("Beatles.ttf", 20))
  botao_spawn_over(100, 408, "Menu", "Menu")
  botao_spawn_over(500, 520, "Quit", "Quit")

end

function love.mousepressed(x, y) -- Checar mouse para apertar Play e Quit

  if gamestate == "menu" then
    checarBotao(x, y)
  end

  if gamestate == "gameover" then
    checarBotao_over(x, y)
    love.load()
  end
end

function love.update(dt)
  if gamestate == "jogando" then

    --brilho
    if brilho <= 255 then
      brilho = 0.1 + (3 * timer * duplicar * slow)
    end
    --penumbra
    if brilho >= 254 and penumbra < 30 then
      penumbra = penumbra + (0.5 * dt * duplicar * slow)
    end

    --timer--
    timer = timer + dt * duplicar * slow

    if timer < 50 then
      score_mod = 1
    elseif timer < 100 and timer > 50 then
      score_mod = 2
    elseif timer < 200 and timer > 100 then
      score_mod = 3
    end
    score = timer * score_mod

    --randomizador de spawn--
    enemy_spawn_timer = enemy_spawn_timer + dt * duplicar * slow

    if enemy_spawn_timer > 2 then
      enemy_spawn = math.random(0, 5)
      if enemy_spawn <= 1 then
        alga_spawn(enemies)
      elseif enemy_spawn > 1 and enemy_spawn <= 2 then
        coral_spawn(enemies)
      elseif enemy_spawn > 2 and enemy_spawn <= 3 then
        cardume_spawn(enemies)
      elseif enemy_spawn > 3 and enemy_spawn <= 4 then
        lixo_spawn(enemies)
      else
        lula_spawn(enemies)
      end
      enemy_spawn_timer = 0
    end

    --randomizador de power--
    power_spawn_timer = power_spawn_timer + dt * duplicar * slow

    if power_spawn_timer > 15 then
      power_spawn = math.random(0,5)
      if power_spawn <= 1 then
        escudo_spawn(powers)
      elseif power_spawn > 1 and power_spawn <= 2 then
        lanterna_spawn(powers)
      elseif power_spawn > 2 and power_spawn <= 3 then
        diamante_spawn(powers)
      elseif power_spawn > 3 and power_spawn <= 4 then
        duplicar_spawn(powers)
      elseif power_spawn > 4 and power_spawn <= 5 then
        relogio_spawn(powers)
      end
      power_spawn_timer = 0
    end

    --movendo os misseis--
    for i, missil in ipairs(misseis) do
      missil_move(dt, missil)
    end

    --movendo os inimigos--
    for i, enemy in ipairs(enemies) do
      if enemy.tipo==1 then
        alga_move(dt, enemy)
      elseif enemy.tipo==2 then
        coral_move(dt, enemy)
      elseif enemy.tipo==3 then
        cardume_move(dt, enemy)
      elseif enemy.tipo==4 then
        lixo_move(dt, enemy)
      elseif enemy.tipo==5 then
        lula_move(dt, enemy)
      end
    end

    --movendo os poderes--
    for i, power in ipairs(powers) do
      if power.tipo == 1 then
        escudo_move(dt, power)
      elseif power.tipo == 2 then
        lanterna_move(dt, power)
      elseif power.tipo == 3 then
        diamante_move(dt, power)
      elseif power.tipo == 4 then
        duplicar_move(dt, power)
      elseif power.tipo == 5 then
        relogio_move(dt, power)
      end
    end

    -- reordena pelo py
    table.sort(enemies, function(e1, e2) return e1.py < e2.py end)
    table.sort(powers, function(e1, e2) return e1.py < e2.py end)


    function love.keypressed(key)
      if key == "space" and quant_missel>0 then
        missil_spawn(misseis)
        quant_missel = quant_missel - 1
      end
    end

    --move p direita--
    if love.keyboard.isDown("right") then
      sub_move(dt, 1)
    end

    --move p esquerda--
    if love.keyboard.isDown("left") then
      sub_move(dt, -1)
    end

--------colisao sub e inimigos----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    sub.collided = false
    for i, enemy in ipairs(enemies) do
      if Check_Collision(sub.px, sub.py, sub.width, sub.height, enemy.hitbox_px, enemy.hitbox_py, enemy.width, enemy.height) then
        sub.collided = true
        if enemy.tipo == 1 or enemy.tipo == 5 then
          if sub.invencibilidade == false then
            sub.lives = sub.lives - 3
          end
        elseif sub.invencibilidade == false then
          sub.lives = sub.lives - 1
        end
        table.remove(enemies, i)
      end
    end

--------------colisao sub e poderes---------------------------------------------------------------------------------------
    for i, power in ipairs(powers) do
      if Check_Collision(sub.px, sub.py, sub.width, sub.height, power.hitbox_px, power.hitbox_py, power.width, power.height) then
        if power.tipo == 1 then
          sub.invencibilidade = true
          sub.i_tempo = 0
        elseif power.tipo == 2 then
          sub.lanterna = true
          sub.l_tempo = 0
        elseif power.tipo == 3 then
          timer = timer + (10 * duplicar)
        elseif power.tipo == 4 then
          sub.duplicar = true
          sub.d_tempo = 0
        elseif power.tipo == 5 then
          sub.relogio = true
          sub.r_tempo = 0
        end
        table.remove(powers, i)
      end
    end

--tempo de duracao de invencibilidade--
    if sub.invencibilidade == true then
      sub.i_tempo = sub.i_tempo + dt * duplicar * slow
      if sub.i_tempo >= 10 then
        sub.invencibilidade = false
        sub.i_tempo = 0
      end
    end
    
--tempo de duracao da lanterna--
    if sub.lanterna == true then
      brilho = 0.1
      sub.l_tempo = sub.l_tempo + dt * duplicar * slow
      if sub.l_tempo >= 10 then
        sub.lanterna = false
        sub.l_tempo = 0
        if 0.1 + (6 * timer) > 255 then
          brilho = 255
        else
          brilho = 0.1 + (6 * timer)
        end
      end
    end
    
--tempo de duracao da duplicacao--
    if sub.duplicar == true then
      duplicar = 2
      sub.d_tempo = sub.d_tempo + dt * duplicar * slow
      if sub.d_tempo >= 10 then
        sub.duplicar = false
        sub.d_tempo = 0
        duplicar = 1
      end
    end

--tempo de slowdown--
if sub.relogio == true then
      slow = 0.5
      sub.r_tempo = sub.r_tempo + dt * duplicar * slow
      if sub.r_tempo >= 10 then
        sub.relogio = false
        sub.r_tempo = 0
        slow = 1
      end
    end


--------------colisao missil inimigos---------------------------------------------------------------------------------------------------------------------------------------------------------------      

    for i, missil in ipairs(misseis) do
      if missil.py > 900 then -- remocao de misseis--     
        table.remove(misseis, i)
      else
        for n, enemy in ipairs(enemies) do
          if  Check_Collision(missil.hitbox_px, missil.hitbox_py, missil.width, missil.height, enemy.hitbox_px, enemy.hitbox_py, enemy.width, enemy.height) then
            table.remove(enemies, n)
            table.remove(misseis, i)
            break
          end
        end
      end
    end
    if sub.lives < 1 then
      gamestate = "gameover"
      sub.lives = 3
    elseif not gamestate == "gameover" then
      gamestate = "menu"
    end
  end

--remoção de objetos q sairam da tela--
  for n, enemy in ipairs(enemies) do
    if enemy.py < -560 then  --remoção de objetos q sairam da tela--
      table.remove(enemies, n)
    end
  end

--gameover

end

--Funcao universal para desenhar os inimigos--
function univ_draw(tab, imagem)
  love.graphics.draw(imagem, tab.px, tab.py, tab.rot, tab.sx, tab.sy, 0, 0)


--  love.graphics.rectangle("line", tab.px, tab.py, tab.width, tab.height)
--  love.graphics.rectangle("line", tab.hitbox_px, tab.hitbox_py, tab.width, tab.height)
--  love.graphics.setColor(255, 0, 0)
--  love.graphics.rectangle("fill", tab.hitbox_px, tab.hitbox_py, 10, 10)
--  love.graphics.setColor(0, 255, 255)
--  love.graphics.rectangle("fill", tab.px, tab.py, 5, 5)
--  love.graphics.setColor(255, 255, 255)
end

function love.draw()
  if gamestate == "menu" then
    botao_draw()

  elseif gamestate == "gameover" then
    botao_draw_over()

  elseif gamestate == "jogando" then
    love.graphics.draw(background, 0, 0, 0, 0.65)--background é desenhado por trás

--Lê os tipos e desenha as imgs--
    for i, enemy in ipairs(enemies) do
      univ_draw(enemy, imagens[enemy.tipo])
    end

    for i, missil in ipairs(misseis) do
      univ_draw(missil, missil_image)
    end

    for i, power in ipairs(powers) do
      univ_draw(power, p_imagens[power.tipo])
    end

    love.graphics.setColor(0, 0, 0, brilho)
    love.graphics.polygon("fill", sub.px + 70, sub.py + 50, sub.px - 530 + penumbra * 9, 1300, -300, 0, 900, 0, sub.px + 600 - penumbra *9, 1300)
    love.graphics.setColor(255 , 255 , 255)
    love.graphics.draw(sub.anim[sub.anim_frame], sub.px, sub.py, 0, sub.sx, sub.sy, sub.ox, sub.oy)

    love.graphics.print("Lives:", textx, screenheight - 90)
    love.graphics.print(sub.lives, textx, screenheight - 70)
    love.graphics.print("Score:", textx, screenheight - 50)
    love.graphics.print("Mísseis:", textx, screenheight - 10)
    love.graphics.print(math.floor(score), textx, screenheight - 30)
    love.graphics.print(math.floor(quant_missel), textx, screenheight +10)

--    love.graphics.rectangle("line", sub.px, sub.py, sub.width, sub.height)

  else
    gamestate = "menu"
  end
end
