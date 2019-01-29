------------DESAFIO 6------------

desafio6 = {}


-------Variaveis------
local keys = {
              back = 'escape',
               'z',
               'x',
               'c',
               'v',
              continue = 'return'
  }

local background

local y = HEIGHT
local velocity = (HEIGHT/1080)*350
local range = (HEIGHT/1080)*30
local cleytinho = (HEIGHT/1080)*150
local winAlpha = 1
local won = false
local lost = false

local matriz = {} 
local matrizSize = 44
local R= 0
local G= 1

--------Funcoes-------

---pseudo-callbacks---
function desafio6.load()
    for i = 1, 4 do
      matriz[i] = {}
      for j = 1, matrizSize do
        
        if love.math.random(0, 1) < 0.8 then
          matriz[i][j] = {0, 0}
        else
          matriz[i][j] = {1, 1}
        end
        
      end
    end
    
    background = love.graphics.newImage("res/images/desafio6/background.png")
    
end

function desafio6.update(dt)
    y = y - velocity*dt 
    
    for i=1, 4, 1 do 
      for j=1, matrizSize, 1 do
        if matriz[i][j][2] == 1 and cleytinho + range > (j*150)+y and (j*150)+y > cleytinho - range*4 and love.keyboard.isDown(keys[i]) then
          matriz[i][j][2] = 0
        elseif matriz[i][j][2] == 0 and matriz[i][j][1] == 0 and cleytinho + range > (j*150)+y and  (j*150)+y > cleytinho - range and love.keyboard.isDown(keys[i]) then
          matriz[i][j][2] = 1
          lost = true
        end
        
        if matriz[i][j][2] == 1 and cleytinho - 4*range > (j*150)+y then
          lost = true
        end
        
      end
    end
    
    if won or lost then
      winAlpha = winAlpha - dt/2
    end
end

function desafio6.draw()
    love.graphics.setFont(fontBig2)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", 0, 0, WIDTH, HEIGHT)
    love.graphics.setColor(1,1,1, 0.8)
    love.graphics.draw(background, 0, 0, 0, 1.5, 1.5)
    
    
    love.graphics.setColor(0,0,0)
    for i=1, 4, 1 do 
      for j=1, matrizSize, 1 do
        if (matriz[i][j][1] == 1) then
          if i == 1 then
            if matriz[i][j][2] == 1 then
              love.graphics.setColor(1,0,0)
            else
              love.graphics.setColor(0.45,0.45,0.45)
            end
            love.graphics.printf(keys[1], -(WIDTH/1920)*650 + i*(WIDTH/1920)*cleytinho, (j*150)+y, WIDTH, "center", 0, 1, 1)
            
          elseif i == 2 then
            if matriz[i][j][2] == 1 then
              love.graphics.setColor(1,0.5,0)
            else
              love.graphics.setColor(0.45,0.45,0.45)
            end
            
            love.graphics.printf(keys[2], -(WIDTH/1920)*650 + i*(WIDTH/1920)*cleytinho, (j*150)+y, WIDTH, "center", 0, 1, 1)
          elseif i == 3 then
            if matriz[i][j][2] == 1 then
              love.graphics.setColor(0,0,1)
            else
              love.graphics.setColor(0.45,0.45,0.45)
            end
            
            love.graphics.printf(keys[3], -(WIDTH/1920)*650 + i*(WIDTH/1920)*cleytinho, (j*150)+y, WIDTH, "center", 0, 1, 1)
          else
            if matriz[i][j][2] == 1 then
              love.graphics.setColor(0,1,0)
            else
              love.graphics.setColor(0.45,0.45,0.45)
            end
            
            love.graphics.printf(keys[4], -(WIDTH/1920)*650 + i*(WIDTH/1920)*cleytinho, (j*150)+y, WIDTH, "center", 0, 1, 1)
          end
          
        end
        
        if j == matrizSize and (j*150)+y<0 then
          
          won=true
          
        end
        
      end
    end 
    
    
    love.graphics.setFont(fontBig2)
    if love.keyboard.isDown(keys[1]) then
      love.graphics.setColor(rgb(225, 0, 255))
    else
      love.graphics.setColor(0.45,0.45,0.45)
    end
    love.graphics.printf(keys[1], -(WIDTH/1920)*650 + 1*(WIDTH/1920)*cleytinho, (HEIGHT/1080)*75, WIDTH, "center", 0, 1, 1)
    
    if love.keyboard.isDown(keys[2]) then
      love.graphics.setColor(rgb(225, 0, 255))
    else
      love.graphics.setColor(0.45,0.45,0.45)
    end
    love.graphics.printf(keys[2], -(WIDTH/1920)*650 + 2*(WIDTH/1920)*cleytinho, (HEIGHT/1080)*75, WIDTH, "center", 0, 1, 1)
    
    if love.keyboard.isDown(keys[3]) then
      love.graphics.setColor(rgb(225, 0, 255))
    else
      love.graphics.setColor(0.45,0.45,0.45)
    end
    love.graphics.printf(keys[3], -(WIDTH/1920)*650 + 3*(WIDTH/1920)*cleytinho, (HEIGHT/1080)*75, WIDTH, "center", 0, 1, 1)
    
    if love.keyboard.isDown(keys[4]) then
      love.graphics.setColor(rgb(225, 0, 255))
    else
      love.graphics.setColor(0.45,0.45,0.45)
    end
    love.graphics.printf(keys[4], -(WIDTH/1920)*650 + 4*(WIDTH/1920)*cleytinho, (HEIGHT/1080)*75, WIDTH, "center", 0, 1, 1)
    
    if lost then
      love.graphics.setColor(rgb(234, 159, 18, 1-winAlpha))
      love.graphics.rectangle("fill", 0, 0, WIDTH, HEIGHT)
      love.graphics.setColor(1,0,0, 1-winAlpha)
      love.graphics.setFont(fontBigger2)
      love.graphics.printf("Voce Perdeu!!!", 0, (HEIGHT/1080)*420, WIDTH, "center")
      love.graphics.setFont(fontSelect)
      love.graphics.printf("< voltar >", 0, (HEIGHT/1080)*600, WIDTH, "center")
      
    elseif won then
      love.graphics.setColor(rgb(234, 159, 18, 1-winAlpha))
      love.graphics.rectangle("fill", 0, 0, WIDTH, HEIGHT)
      love.graphics.setColor(1,0,0, 1-winAlpha)
      love.graphics.setFont(fontBigger2)
      love.graphics.printf("Voce Ganhou!!!", 0, (HEIGHT/1080)*420, WIDTH, "center")
      love.graphics.setFont(fontSelect)
      love.graphics.printf("< continuar >", 0, (HEIGHT/1080)*600, WIDTH, "center")
    end
end

function desafio6.keypressed(key)
    if key == keys.back then
      changeToMenu()
    end
    
    if key == keys.continue and won and winAlpha < 0 then
      changeToDesafios()
    elseif key == keys.continue and lost and winAlpha < 0 then
      changeToMenu()
    end
    
    
end

---outras-funcoes---
function desafio6.reset()
  
  won = false
  lost = false
  y = HEIGHT
  winAlpha = 1
  desafio6.load()
  
end




---gets/sets---

function desafio6.getWon()
  return won
end

function desafio6.getLost()
  return lost
end



--
return desafio6