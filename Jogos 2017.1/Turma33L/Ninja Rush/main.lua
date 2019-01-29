local state

local menu = require'menu'
local characters = require'characters'
local game = require'game'
local gameover = require 'gameover'

function ChangeToCharacters()
  state = characters
end
function ChangeToGame(id)
  state = game
  state.unload(id)
  love.audio.stop(menu_music)
  love.audio.play(game_music)
end

function ChangeToMenu()
  state = menu
  love.audio.play(menu_music)
  love.audio.stop(game_music)
end
function ChangeToGameOver()
  state = gameover
  love.audio.stop(game_music)
  love.audio.play(menu_music)
end
function love.load()
  love.window.setMode(1000, 600)
  love.window.setTitle('NINJA RUSH')
  love.window.getTitle()
  
  music = love.sound.newSoundData('Theme of Ninja of A Great Sausag.ogg')
  musica = love.sound.newSoundData('Out of placemidi MSX.wav')
  menu_music = love.audio.newSource(musica)
  game_music = love.audio.newSource(music)
  menu_music:setLooping(true)
  game_music:setLooping(true)
  
  menu.load()
  characters.load()
  game.load()
  gameover.load()
  ChangeToMenu()
end  
function love.draw()
  state.draw()
end

function love.keypressed(key)
  state.keypressed(key)  
end

function love.update (dt)
  state.update(dt)
end