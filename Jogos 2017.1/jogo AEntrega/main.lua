local menuinicial = require "menuinicial/menuinicial"
local menupause = require "menupause/menupause"
local game = require "game/game"
local HUD = require "HUD/HUD"
local mudancafase = require "mudancafase/mudancafase"
local f = require "game/fases"
local musics = {}

----musics----
local portoa = love.audio.newSource("portoa.mp3", "stream")
local sp = love.audio.newSource("sp.mp3", "stream")
local rio =  love.audio.newSource("rio.mp3", "stream")
local sertao = love.audio.newSource("sertao.mp3", "stream")
local amazonia = love.audio.newSource("amazonia.mp3", "stream")
local pantanal = love.audio.newSource("pantanal.mp3", "stream")
local ms = love.audio.newSource(q.. "menusound.mp3", "stream")

musics[1] = portoa
 musics[2] = sp
 musics[3] = rio
 musics[4] = sertao
 musics[5] = amazonia
 musics[6] = pantanal
 portoa:setVolume(0.2)
 sp:setVolume(0.05)
 rio:setVolume(0.1)
 sertao:setVolume(0.2)
 amazonia:setVolume(0.4)
 pantanal:setVolume(0.1)


paused      = true
changelevel = true
gamerec = false

function ChangeToGame()
  state = game
end

function ChangeToMenuinicial()
  state = menuinicial
  menuinicial.load()
end


function love.load()
  ---------------------------------SETUP------------------------------
   larguratela, alturatela  = love.window.getDimensions()
   woriginal = 800
   horiginal = 600
   width  = love.window.getWidth();     -- logical canvas width
   height = love.window.getHeight();    -- logical canvas height
   pscalex     = width/800
   pscaley     = height/600
   state = menuinicial
   
    --fileLines = {}
    highscores = {}
   game.load()
   menupause.load()
   menuinicial.load()
   --HUD.load()
   mudancafase.load()
   
   ms:setVolume(0.3)
   
   
end 

function love.update(dt)
  state.update(dt)
  if (paused == true and changelevel == true and state == game) then
    mudancafase.update(dt)
  end  
  
  if state == menuinicial then
    ms:setLooping(true)
    love.audio.play(ms)
  else
    love.audio.stop(ms)
 end
  
  if state == game  and paused == false then
    musics[mudancafase.auxfase]:setLooping(true)
    love.audio.play(musics[f.fase])
  elseif paused == true then
    love.audio.pause(musics[f.fase])
  if changelevel == true and state == game then
    love.audio.stop()
end
end


end

function love.draw() 
  state.draw()
 if state == game then 
  HUD.draw()
  menupause.draw()
 end
 if (paused == true and changelevel == true and state == game) then
    mudancafase.draw()
  end  
 -- love.graphics.print(finalscore)
end

function love.mousepressed(x, y, button)
  state.mousepressed(x, y, button)
end