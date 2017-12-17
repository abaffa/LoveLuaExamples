require "player"
require "menu"
require "enemy"
require "collision"
require "life"
local bullet = require "bullet"

function love.load()
  player_load()
  font = love.graphics.setNewFont("Bubblegum.ttf",50)
  gamestate = "menu"
  button_spawn(340,300,"Jogar","jogar")
  button_spawn(360,460,"Sair","sair")
  troquei = false
  menu_load()
  background = love.graphics.newImage("academia.png")
  musica_menu =  love.audio.newSource("musica_menu.mp3")
  musica_menu:setLooping(true)
  musica_ingame = love.audio.newSource("musica_ingame.mp3")
  musica_ingame:setLooping(true)
  enemy_load()
  bullet.load(enemy_getx(),enemy_gety())
  life_load()
end

function reset()
  player_load()
  menu_load()
  musica_menu:stop()
  musica_ingame:stop()
  enemy_load()
  life_load()
  bullet.reset()
end

function love.update(dt)
  if troquei then
    gamestate = "playing"
  end
  if gamestate == "menu" then
    mousex = love.mouse.getX()
    mousey = love.mouse.getY()
    button_check(mousex, mousey)
    musica_menu:play()
  end 
  if gamestate == "playing" then
    player_move(dt) 
    musica_menu:stop()
    musica_ingame:play()
    bullet.update(dt)
    collision_update(dt)
  end  
end
 
function love.draw()
  if gamestate == "menu" then
    menu_draw()
    button_draw()
    title_draw()
  elseif gamestate == "playing" then
    love.graphics.draw(background)
    player_draw()
    enemy_draw()
    bullet.draw()
  end 
end

function love.keyreleased(key)
  if gamestate == "playing" then
    player_keyreleased(key)
  end
end

function love.mousepressed(x,y)
  if gamestate == "menu" then
    button_click(x,y)
    troquei = true
  end 
end