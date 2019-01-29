local game = require "game"
local menu = require "menu"
local credits = require "credits"
local state = menu

width         = 1280;                    -- logical canvas width
height        = 720;

function love.load()
  beep = love.audio.newSource("beep.wav")
  font = love.graphics.newFont("Montserrat-Bold.otf",50)
  love.window.setMode(width,height)
  credits.load()
  menu.load()
  game.load()
  
end

function love.update(dt)
  if state ~= menu then
    love.audio.stop(menu_music)  
  end
  
  state.update(dt)
end

function love.draw()
  state.draw()
end

function love.keypressed(key)
  love.audio.play(beep)
  state.keypressed(key)
  end


function love.keyreleased(key)
  state.keyreleased(key)
end


function love.changetoGame()
  state = game
end

function love.changeToMenu()
  state = menu
end

function love.changeToCredits()
  state = credits
end

function love.mute()
  love.audio.setVolume(0)
end

function love.unmute()
  love.audio.setVolume(1)
end
