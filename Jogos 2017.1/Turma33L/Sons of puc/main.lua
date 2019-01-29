local game = require "game"
local menu = require "menu"
local splash = require "splash"
local pausa = require "pausa"
local player = require "player"
local CollisionBlocks = require "CollisionBlocks"
local camera = require "camera"
local hud = require "hud"
local enemycollision = require "enemycollision"
local cutscene = require "cutscene"
local gameover = require "gameover"
local state = splash
volume = 5
love.window.setTitle("SONS OF PUC")
--love.window.setFullscreen(true)

function love.load()
  cutscene.load()
  splash.load()
  menu.load()
  game.load()
  pausa.load()
  player.load()
  enemycollision.load()
  gameover.load()
end
function love.update(dt)
  state.update(dt)
end
function love.draw()
  state.draw()
end
function changeToGame()
  state = game
end
function changeToMenu()
  state = menu
end
function changeToPausa()
  state = pausa
end
function changeToCutscene()
  state = cutscene
  end
function changeToDungeon()
  state = dungeon
end
function GameOver()
  state = gameover
end
function love.keypressed(key)
  state.keypressed(key)
end