local state = dungeon
local dungeon = {}
local game = require "game"
local camera = require "camera"
local player = require "player"
local imageDungeon = love.graphics.newImage("image/dungeon.png")

function dungeon.load()
  camera.load()
  game.load()
  LoadMap("dungeon.txt")
  LoadTiles(imageDungeon,5,1)
end
function dungeon.update(dt)
DrawTiles(
end
function dungeon.draw()
camera.draw()
end
return dungeon