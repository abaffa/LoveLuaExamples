------------DESAFIO 1------------

local desafio1 = {}

-------Variaveis------
local keys = {
              back = 'escape',
              walk1 = 'right',
              walk2 = 'left',
              continue = 'return'
  }


local ceu = {
            imagem,
            px1 = 0,
            px2 = 0,
            sizeMult = 1.4,
            distance = 4
  }
  
local hills = {
            imagem,
            px1 = 0,
            px2 = 0,
            sizeMult = 1.6
  }
  local placa = {
            imagem,
            px = 0,
            sizeMult = 8
  }

local time = 0
local floorHeight = 230
local totalClicks = 0
local winClicks = 320
local timeLimit = 30
local lastClick = 1
local won = false
local lost = false
local winAlpha = 1
local placaMetros = 0

local player = require "desafios/desafio1/player"
--------Funcoes-------

---pseudo-callbacks---
function desafio1.load()
    
    player.load()
    
    ceu.imagem = love.graphics.newImage("res/images/desafio1/ceu.png")
    hills.imagem = love.graphics.newImage("res/images/desafio1/hills.png")
    placa.imagem = love.graphics.newImage("res/images/desafio1/placa.png")
    
    ceu.px2 = 2*ceu.imagem:getWidth()*(WIDTH/1920)*ceu.sizeMult
    hills.px2 = hills.imagem:getWidth()*(WIDTH/1920)*hills.sizeMult
    
end

function desafio1.update(dt)
    if ceu.px1 < -ceu.imagem:getWidth()*(WIDTH/1920)*ceu.sizeMult then
      ceu.px1 = ceu.px2 + (WIDTH/1920)*ceu.sizeMult - 1 
    elseif ceu.px2 < 0 then
      ceu.px2 = ceu.px1 + 2*ceu.imagem:getWidth()*(WIDTH/1920)*1.4
    end
    
    if hills.px1 < -hills.imagem:getWidth()*(WIDTH/1920)*hills.sizeMult then
      hills.px1 = hills.px2 + (WIDTH/1920)*hills.imagem:getWidth()*hills.sizeMult
    elseif hills.px2 < -hills.imagem:getWidth()*(WIDTH/1920)*hills.sizeMult then
      hills.px2 = hills.px1 + (WIDTH/1920)*hills.imagem:getWidth()*hills.sizeMult
    end
    
    if placa.px < -placa.imagem:getWidth()*(WIDTH/1920)*placa.sizeMult then
      placa.px = WIDTH
      placaMetros = winClicks - totalClicks
    end
    
    if won or lost then
      winAlpha = winAlpha - dt/2
    end
    
    if totalClicks >= winClicks and time <= timeLimit and not won and not lost then
      won = true
    elseif time > timeLimit and not won and not lost then
      lost = true
    end
    
    if not won and not lost then
      time = time + dt
    elseif lost then
      time = timeLimit
    end
    
    player.update(dt)
end

function desafio1.draw()
    --Desenha o Ceu
    love.graphics.setColor(1,1,1,winAlpha)
    love.graphics.draw(ceu.imagem, ceu.px1, 0, 0, (WIDTH/1920)*ceu.sizeMult, (HEIGHT/1080)*ceu.sizeMult)
    love.graphics.draw(ceu.imagem, ceu.px2, 0, 0, (WIDTH/1920)*-ceu.sizeMult, (HEIGHT/1080)*ceu.sizeMult)
    
    --Desenha as Montanhas
    love.graphics.draw(hills.imagem, hills.px1, 
      HEIGHT -  (HEIGHT/1080)*floorHeight - hills.imagem:getHeight()*(HEIGHT/1080)*hills.sizeMult,
      0, (WIDTH/1920)*hills.sizeMult, (HEIGHT/1080)*hills.sizeMult)
    love.graphics.draw(hills.imagem, hills.px2, 
      HEIGHT -  (HEIGHT/1080)*floorHeight - hills.imagem:getHeight()*(HEIGHT/1080)*hills.sizeMult,
      0, (WIDTH/1920)*hills.sizeMult, (HEIGHT/1080)*hills.sizeMult)
    
    --Desenha a placa
    love.graphics.setFont(fontSmall1)
    love.graphics.draw(placa.imagem, placa.px,
      HEIGHT - (HEIGHT/1080)*floorHeight - placa.imagem:getHeight()*(HEIGHT/1080)*placa.sizeMult,
      0, (WIDTH/1920)*placa.sizeMult, (HEIGHT/1080)*placa.sizeMult)
    love.graphics.print((placaMetros - 41) .. "m", placa.px + (WIDTH/1920)*14,
      HEIGHT - (HEIGHT/1080)*floorHeight - placa.imagem:getHeight()*(HEIGHT/1080)*placa.sizeMult + (HEIGHT/1080)*27)
    
    player.draw()
    
    --Desenha o Chao
    love.graphics.setColor(rgb(232, 126, 34, winAlpha))
    love.graphics.rectangle("fill", 0, HEIGHT - (HEIGHT/1080)*floorHeight, WIDTH, HEIGHT/2)
    
    --Desenha o Tempo
    love.graphics.setFont(fontTime)
    love.graphics.setColor(rgb(229, 0, 0, winAlpha))
    love.graphics.print(tonumber(string.format("%.2f", time)), (WIDTH/1920)*830, (HEIGHT/1080)*80)
    
    if won then
      love.graphics.setColor(1,0,0, 1-winAlpha)
      love.graphics.setFont(fontBigger2)
      love.graphics.printf("Voce Ganhou!!!", 0, (HEIGHT/1080)*420, WIDTH, "center")
      love.graphics.setFont(fontSelect)
      love.graphics.printf("< continuar >", 0, (HEIGHT/1080)*600, WIDTH, "center")
      
      
    elseif lost then
      love.graphics.setColor(1,0,0, 1-winAlpha)
      love.graphics.setFont(fontBigger2)
      love.graphics.printf("Voce Perdeu!!!", 0, (HEIGHT/1080)*420, WIDTH, "center")
      love.graphics.setFont(fontSelect)
      love.graphics.printf("< voltar >", 0, (HEIGHT/1080)*600, WIDTH, "center")
      
    end
    
    --DEBUG
    if DEBUG then
      love.graphics.setColor(1,0,0)
      love.graphics.print(totalClicks, 100, 100)
    end
    
end

function desafio1.keypressed(key)
    if key == keys.back then
      changeToMenu()
    end
    
    player.keypressed(key)
    
    if key == keys.walk1 and lastClick ~= 1 and not won and not lost then
      player.currentSprite = 1
      ceu.px1 = ceu.px1 - (WIDTH/1920)*player.velocity/ceu.distance
      ceu.px2 = ceu.px2 - (WIDTH/1920)*player.velocity/ceu.distance
      
      hills.px1 = hills.px1 - (WIDTH/1920)*player.velocity
      hills.px2 = hills.px2 - (WIDTH/1920)*player.velocity
      
      placa.px = placa.px -  (WIDTH/1920)*player.velocity*3/2
      
      totalClicks = totalClicks + 1
      lastClick = 1
      
    elseif key == keys.walk2 and lastClick ~= 2 and not won and not lost then
      player.currentSprite = 2
      ceu.px1 = ceu.px1 - (WIDTH/1920)*player.velocity/ceu.distance
      ceu.px2 = ceu.px2 - (WIDTH/1920)*player.velocity/ceu.distance
      
      hills.px1 = hills.px1 - (WIDTH/1920)*player.velocity
      hills.px2 = hills.px2 - (WIDTH/1920)*player.velocity
      
      placa.px = placa.px -  (WIDTH/1920)*player.velocity*3/2
      
      totalClicks = totalClicks + 1
      lastClick = 2
    end
    
    if key == keys.continue and won and winAlpha < 0 then
      changeToDesafios()
    elseif key == keys.continue and lost and winAlpha < 0 then
      changeToMenu()
    end
    
end

---outras-funcoes---
function desafio1.reset()
    time = 0
    totalClicks = 0
    lastClick = 1
    won = false
    lost = false
    winAlpha = 1
    
    ceu.px1 = 0
    hills.px1 = 0
    placa.px = 0
    
    ceu.px2 = 2*ceu.imagem:getWidth()*(WIDTH/1920)*ceu.sizeMult
    hills.px2 = hills.imagem:getWidth()*(WIDTH/1920)*hills.sizeMult
end



---gets/sets---
function desafio1.getWinAlpha()
    return winAlpha
end

function desafio1.getWon()
  return won
end

function desafio1.getLost()
  return lost
end

--
return desafio1