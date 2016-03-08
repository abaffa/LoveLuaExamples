require "player1"
require "item"
require "enemy"
require "projectile"
require "cutscene"
require "sound"
require "hud"

function love.load()
  love.graphics.setBackgroundColor(255,255,255)
  love.window.setTitle("Mecholour")
  player1.load()
  projectile.load()
  item.load()
  sound_load()
  cutscene.load()
  player1.width = player1.walk_red[10]:getWidth()
  player1.height = player1.walk_red[10]:getHeight()
  enemy.load()
  love.window.setMode(1024, 768, {resizable=false})
  gamestate = 1
  wave = 1
  boss = 1
  wave_time = 30 -- Tempo que a wave está no momento
  wave_max_time = 30 -- Tempo de duração de uma wave
  time_font = love.graphics.newFont(24)
  wave_img = {}
  boss_img = {}
  transition_time = 0
  transition_max_time = 1.5
  transition_begin = true
  boss3_life = enemy.boss3_life
  start_heal = false
  score = 0
  score_font = love.graphics.newFont(16)
  pause = false
  imageChange = 1
  distance_top = 80
  menuBackground = love.graphics.newImage("Menu/background.png")
  menuNewgame = love.graphics.newImage("Menu/newgame.png")
  menuNewgameToggle = love.graphics.newImage("Menu/newgametoggle.png")
  menuOptions = love.graphics.newImage("Menu/options.png")
  menuOptionsToggle = love.graphics.newImage("Menu/optionstoggle.png")
  menuCredits = love.graphics.newImage("Menu/credits.png")
  menuCreditsToggle = love.graphics.newImage("Menu/creditstoggle.png")
  menuCreditsMenu = love.graphics.newImage("Menu/creditsmenu.png")
  menuPannel = love.graphics.newImage("Menu/pannel.png")
  menuSinglePlayer = love.graphics.newImage("Menu/singleplayer.png")
  menuSinglePlayerToggle = love.graphics.newImage("Menu/singleplayertoggle.png")
  menuMultiPlayer = love.graphics.newImage("Menu/multiplayer.png")
  menuMultiPlayerToggle = love.graphics.newImage("Menu/multiplayertoggle.png")
  gameBackground = love.graphics.newImage("Menu/game_background.png")
  gameOver = love.graphics.newImage("Menu/gameover.png")
  setescmenu = love.graphics.newImage("Menu/escmenu.png")
  setgame = love.graphics.newImage("Menu/voltarprojogo.png")
  setgamemark = love.graphics.newImage("Menu/voltarprojogotoggle.png")
  setmenu = love.graphics.newImage("Menu/voltarpromenu.png")
  setmenumark = love.graphics.newImage("Menu/voltarpromenutoggle.png")
  setoptions = love.graphics.newImage("Menu/opçoes.png")
  setoptionstoggle = love.graphics.newImage("Menu/opçoestoggle.png")
  restartbutton = love.graphics.newImage("Menu/restart.png")
  restartbuttontoggle = love.graphics.newImage("Menu/restarttoggle.png")
  restartmenu = love.graphics.newImage("Menu/restartmenu.png")
  restartmenutoggle = love.graphics.newImage("Menu/restartmenutoggle.png")
  love.graphics.setBackgroundColor(0, 0, 0)
  menuImage = 1
  restartscreen = 1
  upgrademenu = love.graphics.newImage("Menu/upgrademenu.png")
  blueupgrade = love.graphics.newImage("Menu/bluegunupdate.png")
  redupgrade = love.graphics.newImage("Menu/redgunupdate.png")
  greenupgrade = love.graphics.newImage("Menu/greengunupdate.png")
  
  for x = 1, 12, 1 do -- Transições das waves
    wave_img[x] = love.graphics.newImage("transition/wave_" .. x .. ".png")
  end
  for x = 1, 4, 1 do -- Transições dos bosses
    boss_img[x] = love.graphics.newImage("transition/boss_" .. x .. ".png")
  end
  
  map = {}
  map_width = love.graphics.getWidth() -- Largura da matriz
  map_height = love.graphics.getHeight() -- Altura da matriz
  for i=1, map_height, 1 do
    map[i] = {} -- nova linha
    for j=1, map_width, 1 do
      map[i][j] = 0
    end
  end
--  for i=324, 444, 1 do
--    map[i] = {} -- nova linha
--    for j=466, 558, 1 do
--      map[i][j] = 1
--    end
--  end
  itemplus.spawn()
  itemminus.spawn()
end
function set_pos(object, binary, width, height) -- Coloca a posição do objeto(object) no mapa como 0 ou 1(binary)
  for i=object.py_map, object.py_map + height, 1 do
    for j=object.px_map, object.px_map + width, 1 do
      map[i][j] = binary
    end
  end
end
function love.keypressed(key)
  if key == "escape" and gamestate == 2 and pause == false then
    pause = true
  end
end
--function mousepressed(gx, gy, key)
--  if key == "l" and gx == love.mouse.getX() and gy == love.mouse.getY() and gamestate == 4 then
--    gamestate = 2
--  end
--end
function checkCollision(object1, object2) -- colisão (x do frank, x do item, y do frank, y do item)
 return object1.px < object2.px + object2.width and object2.px < object1.px + object1.width and object1.py < object2.py + object2.height and object2.py < object1.py + object1.height
end


function mouseCollision(mx, my, x, y, w, h)
  return mx < x + w and x < mx + 1 and my < y + h and y < my + 1
end
function love.update(dt)
  sound_update(dt)
  cutscene.update(dt)
  if wave == 8 then
    music_wave[2]:stop()
    wave = 1 
  end
  if gamestate == 1 then
    boss = 1
    wave = 1
    player1.current_life = player1.max_life
    player1.current_stamina = player1.max_stamina
    score = 0
    wave_time = wave_max_time
    transition_begin = true
    enemy.remove_all = true
    for i,v in ipairs(enemies) do
      enemy.move(v,dt,i)
    end
    if mouseCollision(love.mouse.getX(), love.mouse.getY(), 340, 230, 350, 70) then
      imageChange = 2
    elseif mouseCollision(love.mouse.getX(), love.mouse.getY(), 340, 340, 350, 70) then
      imageChange = 3
    elseif mouseCollision(love.mouse.getX(), love.mouse.getY(), 340, 450, 350, 70) then
      imageChange = 4
    else
      imageChange = 1
    end
    if mouseCollision(love.mouse.getX(), love.mouse.getY(), 340, 450, 350, 70) and love.mouse.isDown(1) then
      gamestate = 5
      end
    end
    if mouseCollision(love.mouse.getX(), love.mouse.getY(), 340, 230, 350, 70) and love.mouse.isDown(1) and imageChange == 2 then
      gamestate = 4
    end
    if mouseCollision(love.mouse.getX(), love.mouse.getY(), 340, 300, 350, 70) and love.mouse.isDown(1) and gamestate == 4 then
      gamestate = 3
    end
  if gamestate == 4 then
     imageChange = 5
     if mouseCollision(love.mouse.getX(), love.mouse.getY(), 340, 300, 350, 70) then
     imageChange = 6
   elseif mouseCollision(love.mouse.getX(), love.mouse.getY(), 340, 400, 350, 70) then
     imageChange = 7
     end
  end
  if gamestate == 5 then
    if love.keyboard.isDown("escape") then
      gamestate = 1
    end
  end  
  if gamestate == 2 then
    if pause == false then
      wave_time = wave_time - dt
      if (wave ~= 4 and wave ~= 8 and wave ~= 12 and wave ~= 16) and wave_time < 0 then
        wave = wave + 1
        wave_time = wave_max_time
        if  player1.current_life < player1.max_life - player1.max_life/5 then
          player1.current_life = player1.current_life + player1.max_life/5
        end
        player1.current_stamina = player1.max_stamina
        transition_begin = true
        enemy.remove_all = true
      end
      if transition_begin == true then
        gamestate = 9
      end    
      player1.runtime = player1.runtime - dt
      player1.update(dt)
      item.update(dt)
      item.collision()
      enemy.update(dt)
      projectile.update(dt)
      
      for i,v in ipairs(enemies) do
          enemy.move(v,dt,i)
      end
      if wave == 4 then
        if player1.current_life < player1.max_life - player1.max_life/5 and start_heal == false then
          player1.current_life = player1.current_life + player1.max_life/5
          start_heal = true
        elseif player1.current_life > player1.max_life - player1.max_life/5 then
          start_heal = true
        end
        for i,v in ipairs(enemies) do
          boss3_life = v.life
        end
      end
    else
      if mouseCollision(love.mouse.getX(), love.mouse.getY(), 340, 200, 350, 70) then
        menuImage = 2
      elseif mouseCollision(love.mouse.getX(), love.mouse.getY(), 340, 350, 350, 70) then
        menuImage = 3
      elseif mouseCollision(love.mouse.getX(), love.mouse.getY(), 340, 500, 350, 70) then
        menuImage = 4
      else
        menuImage = 1
      end
      if mouseCollision(love.mouse.getX(), love.mouse.getY(), 340, 200, 350, 70) and love.mouse.isDown("l") then
        pause = false
      end
      if mouseCollision(love.mouse.getX(), love.mouse.getY(), 340, 500, 350, 70) and love.mouse.isDown("l") then
        gamestate = 1
        pause = false
      end
    end
  end
  if gamestate == 9 then
    for i,v in ipairs(enemies) do
      enemy.move(v,dt,i)
    end
    transition_time = transition_time + dt
    if transition_time > transition_max_time then
      gamestate = 2
      transition_begin = false
      transition_time = 0
    end
  end
  if gamestate == 8 then
    if mouseCollision(love.mouse.getX(), love.mouse.getY(), 330, 500, 350, 70) then
      restartscreen = 2
    elseif mouseCollision(love.mouse.getX(), love.mouse.getY(), 330, 600, 350, 70) then
      restartscreen = 3
    end
    if mouseCollision(love.mouse.getX(), love.mouse.getY(), 330, 500, 350, 70) and love.mouse.isDown(1) then
      gamestate = 9
      wave = 1
      wave_time = wave_max_time
      player1.current_life = player1.max_life
      player1.current_stamina = player1.max_stamina
      score = 0
      enemy.remove_all = true
    end
    if mouseCollision(love.mouse.getX(), love.mouse.getY(), 330, 600, 350, 70) and love.mouse.isDown(1) then
      gamestate = 1
    end
  end
  if gamestate == 10 then
    wave_time = wave_max_time
    player1.current_life = player1.max_life
    player1.current_stamina = player1.max_stamina
    if mouseCollision(love.mouse.getX(), love.mouse.getY(), 250, 330, 150, 150) and love.mouse.isDown(1) then
      projectile.red_upgrade = true
      gamestate = 9
    elseif mouseCollision(love.mouse.getX(), love.mouse.getY(), 450, 330, 150, 150) and love.mouse.isDown(1) then
      projectile.green_upgrade = true
      gamestate = 9
    elseif mouseCollision(love.mouse.getX(), love.mouse.getY(), 650, 330, 150, 150) and love.mouse.isDown(1) then
      projectile.blue_upgrade = true
      gamestate = 9
    end
  end
end
function love.draw()
  if gamestate == 2 then
    love.graphics.draw(gameBackground, -35, distance_top)
    end
  if gamestate == 1 then
    love.graphics.draw(menuBackground, 0, 0)
    if imageChange == 1 then
        love.graphics.draw(menuNewgame, 340, 230)
        love.graphics.draw(menuOptions, 340, 340)
        love.graphics.draw(menuCredits, 340, 450)
    end
    if imageChange == 2 then
        love.graphics.draw(menuNewgameToggle, 340, 230)
        love.graphics.draw(menuOptions, 340, 340)
        love.graphics.draw(menuCredits, 340, 450)
    end
    if imageChange == 3 then
        love.graphics.draw(menuNewgame, 340, 230)
        love.graphics.draw(menuOptionsToggle, 340, 340)
        love.graphics.draw(menuCredits, 340, 450)
    end
    if imageChange == 4 then
        love.graphics.draw(menuNewgame, 340, 230)
        love.graphics.draw(menuOptions, 340, 340)
        love.graphics.draw(menuCreditsToggle, 340, 450)
    end
  end
  if gamestate == 4 then
    love.graphics.draw(menuBackground, 0, 0)
    if imageChange == 5 then
      love.graphics.draw(menuPannel, 315, 260)
      love.graphics.draw(menuSinglePlayer, 340, 300)
      love.graphics.draw(menuMultiPlayer, 340, 400)
    end
    if imageChange == 6 then
      love.graphics.draw(menuBackground, 0, 0)
      love.graphics.draw(menuPannel, 315, 260)
      love.graphics.draw(menuSinglePlayerToggle, 340, 300)
      love.graphics.draw(menuMultiPlayer, 340, 400)
    end
    if imageChange == 7 then
      love.graphics.draw(menuBackground, 0, 0)
      love.graphics.draw(menuPannel, 315, 260)
      love.graphics.draw(menuSinglePlayer, 340, 300)
      love.graphics.draw(menuMultiPlayerToggle, 340, 400)
    end
  end
  if gamestate == 8 then
    love.graphics.setBackgroundColor(17, 17, 17)
    love.graphics.draw(gameOver, 260, 100)
    love.graphics.setFont(score_font) 
    love.graphics.print("Parabéns! Você conseguiu " .. score .. " pontos", 350, 450 )
    if restartscreen == 1 then
      love.graphics.draw(restartbutton, 330, 500)
      love.graphics.draw(restartmenu, 330, 600)
    end
    if restartscreen == 2 then
      love.graphics.draw(restartbuttontoggle, 330, 500)
      love.graphics.draw(restartmenu, 330, 600)
    end
    if restartscreen == 3 then
      love.graphics.draw(restartbutton, 330, 500)
      love.graphics.draw(restartmenutoggle, 330, 600)
    end
  end
  if gamestate == 9 then
    if wave == 4 or wave == 8 or wave == 12 or wave == 16 then
      love.graphics.draw(boss_img[boss], 350, 300)
    else
      if wave > 4 then
        love.graphics.draw(wave_img[wave-1], 350, 300)
      else
        love.graphics.draw(wave_img[wave], 350, 300)
      end
    end
  end
  if gamestate == 5 then
    love.graphics.draw(menuBackground, 0, 0)
    love.graphics.draw(menuCreditsMenu, 340, 240)
  end
  if gamestate == 2 then
    love.graphics.setColor( 0, 0, 0 )
    love.graphics.rectangle("fill", 0, 0,love.graphics.getWidth(),distance_top)
    love.graphics.setColor( 255, 255, 255 )
    love.graphics.print("HP", 240, 15 )
    love.graphics.print("STA", 240, 45 )
    love.graphics.setFont(score_font) 
    love.graphics.print(score, 900, 50 )
    if wave == 4 or wave == 8 or wave == 12 or wave == 16 then
      love.graphics.print("BOSS ".. boss, 25, 710 )
      love.graphics.print("BOSS HP", 710, 712 )
      love.graphics.rectangle("fill", 792, 712, 205, 15)
      love.graphics.setColor( 255, 0, 0 )
      love.graphics.rectangle("fill", 795, 715, boss3_life*(200/enemy.boss3_life),10)
      love.graphics.setColor( 255, 255, 255 )
    else
      if wave > 4 then
        love.graphics.print("WAVE ".. wave-1, 25, 710 )
      else 
        love.graphics.print("WAVE ".. wave, 25, 710 )
      end
      love.graphics.setFont(time_font)     
      love.graphics.print(math.floor(wave_time+0.5), 500, 40 )-- tempo de cada wave
    end
    player1.draw()
    item.draw()
    enemy.draw()
    projectile.draw()
    if pause == true then
      love.graphics.draw(setescmenu, 270, 100)
      if menuImage == 1 then
        love.graphics.draw(setgame, 340, 200)
        love.graphics.draw(setoptions, 340, 350)
        love.graphics.draw(setmenu, 340, 500)
      end
      if menuImage == 2 then
        love.graphics.draw(setgamemark, 340, 200)
        love.graphics.draw(setoptions, 340, 350)
        love.graphics.draw(setmenu, 340, 500)
      end
      if menuImage == 3 then
        love.graphics.draw(setgame, 340, 200)
        love.graphics.draw(setoptionstoggle, 340, 350)
        love.graphics.draw(setmenu, 340, 500)
      end
      if menuImage == 4 then
        love.graphics.draw(setgame, 340, 200)
        love.graphics.draw(setoptions, 340, 350)
        love.graphics.draw(setmenumark, 340, 500)
      end
    end
  end
  if gamestate == 3 then
    cutscene.draw()
  end
  if gamestate == 10 then
    love.graphics.setBackgroundColor(17, 17, 17)
    love.graphics.draw(upgrademenu, 225, 250)
    love.graphics.draw(redupgrade, 250, 330)
    love.graphics.draw(greenupgrade, 450, 330)
    love.graphics.draw(blueupgrade, 650, 330)
  end
end