local state

local menu = require 'menu'
local cutscene = require 'cutscene'
local config = require 'config'
local creditos = require 'creditos'
local Jogo = require 'Jogo'
local mapa = require 'mapa'
local cutscene2 = require 'cutscene2'

function love.load()
  font = love.graphics.newFont("fonte.ttf",20)
  bgm = love.audio.newSource("menucalm.mp3")
  bgm:setLooping(true)
  rugido = love.audio.newSource("bear-roar.mp3")
   menu.load()
   config.load()
   creditos.load()
   Jogo.load()
   cutscene.load()
   mapa.load()
   cutscene2.load()
   state = menu
   love.graphics.setColor(255,255,255)
   love.audio.play(bgm)
 end
 
 function love.update(dt)
    state.update(dt)
 end
 
 function changeToCutscene()
  state=cutscene
 end
 
 function changeToCutscene2()
   state=cutscene2
  end
 
 function changeToConfig()
   state=config
  end
  
  function changeToCreditos()
    state=creditos
  end
  
  function changeToMenu()
    state=menu
  end
  
  function changeToJogo()
    state=Jogo
  end
 
 function setState(newState)
   state = newState
 end
 
 
 function love.mousepressed(x,y,but)
   state.mousepressed(x,y,but)
 end
 
 function love.keypressed(key)
    state.keypressed(key)
  end
  
 function love.transitionTo(place)
   state = place
  end
  
  function love.draw()
    state.draw()
  end