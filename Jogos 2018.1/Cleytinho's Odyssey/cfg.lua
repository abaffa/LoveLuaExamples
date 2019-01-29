------------MENU------------

local cfg = {}

-------Variaveis------
local font1 = "res/fonts/Grobold.ttf"
local font2 = "res/fonts/PerfectlyTogether.otf"
local fontSel = "res/fonts/AmericanCaptain.otf"
local fontTim = "res/fonts/courierNew.ttf"

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

---pseudo-load---
function cfg.load()
    
    menu.load()
    historia.load()
    desafios.load()
    garagem.load()
    opcoes.load()
    creditos.load()
    premio.load()
    
    ---Desafios---
    desafio1.load()
    desafio2.load()
    desafio3.load()
    desafio4.load()
    desafio5.load()
    desafio6.load()
    --------------
    
    love.graphics.setBackgroundColor(rgb(234, 159, 18))
    
    cfg.fonts()
    
end


---funcoes---
function cfg.fonts()
    fontBig1 = love.graphics.setNewFont(font1, WIDTH/20)
    fontMedium1 = love.graphics.setNewFont(font1, WIDTH/30)
    fontSmall1 = love.graphics.setNewFont(font1, WIDTH/50)
    fontBigger1 = love.graphics.setNewFont(font1, WIDTH/15)
    
    fontBig2 = love.graphics.setNewFont(font2, WIDTH/20)
    fontMedium2 = love.graphics.setNewFont(font2, WIDTH/30)
    fontBigger2 = love.graphics.setNewFont(font2, WIDTH/15)
    fontSmall2 = love.graphics.setNewFont(font1, WIDTH/70)
    
    fontSelect = love.graphics.setNewFont(fontSel, WIDTH/20)
    
    fontTime = love.graphics.setNewFont(fontTim, WIDTH/20)
end

--
return cfg