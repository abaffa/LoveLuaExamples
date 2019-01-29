------- A Odisseia de Cleytinho ------
-- PUC-Rio  ENG1000  Grupo1  2018.1 --

----------Integrantes do Grupo--------
--Daniel Zimmer de Paula Freitas
--Leonardo D’Angelo Toledo
--João Pedro Curvello Fischer
--Katherine Cardoso P. Fernandes
--Rachel Elisa Szenberg
--------------------------------------


------Variaveis------
---globais---
local _, _, flags = love.window.getMode()
WIDTH, HEIGHT = love.window.getDesktopDimensions(flags.display)

DEBUG = false
fullScreenState = false
borderlessState = true


volumeGeral = 10

----locais---



--modulos--
local cfg = require "cfg"
local menu = require "menu"
local historia = require "historia"
local desafios = require "desafios"
local garagem = require "garagem"
local opcoes = require "opcoes"
local creditos = require "creditos"
local desafio1 = require "desafios/desafio1/desafio1"
local desafio2 = require "desafios/desafio2/desafio2"
local desafio3 = require "desafios/desafio3/desafio3"
local desafio4 = require "desafios/desafio4/desafio4"
local desafio5 = require "desafios/desafio5/desafio5"
local desafio6 = require "desafios/desafio6/desafio6"
local premio = require "premio"

local state = menu


--------Funcoes-------

----CallBacks----
function love.load()
    love.window.setMode(WIDTH, HEIGHT, {resizable=false, vsync=false, borderless = borderlessState})
    love.window.setFullscreen(fullScreenState, "exclusive")
    love.mouse.setVisible(false)
    
    cfg.load()
    
end

function love.update(dt)
    state.update(dt)
    
end

function love.draw()
    state.draw()    
    
end

function love.keypressed(key)
    state.keypressed(key)
    
end

function love.mousepressed(x, y, button, istouch)
    if state == garagem then
      state.mousepressed(x, y, button, istouch)
    end
    
end

function love.quit()
    love.window.setFullscreen(false, "exclusive")
    
end

---outras-funcoes---
function changeToMenu()
    state = menu
end

function changeToHistoria()
    state = historia
end

function changeToDesafios()
    state = desafios
end

function changeToGaragem()
    love.mouse.setVisible(true)
    state = garagem
end

function changeToOpcoes()
    state = opcoes
end

function changeToCreditos()
    state = creditos
end

function changeToDesafio1()
    desafio1.reset()
    state = desafio1
end

function changeToDesafio2()
    state = desafio2
end

function changeToDesafio3()
    desafio3.reset()
    state = desafio3
end

function changeToDesafio4()
    state = desafio4
end

function changeToDesafio5()
    state = desafio5
end

function changeToDesafio6()
    desafio6.reset()
    state = desafio6
end

--RGB--
function rgb(r, g, b, a)--Pelo amor de satanas, quem inventou de botar o RGB de 0 a 1
    a = a or 1
    return r/255, g/255, b/255, a
end
