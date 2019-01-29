------------DESAFIO 3------------

desafio3 = {}

-------Variaveis------
local keys = {
              back = 'escape',
              r = 'right',
              l = 'left',
              continue = 'return'
  }
  
local player = {
  x = WIDTH/2,
  y = 0,
  sprite = {},
  angle = 0,
  acel = 0
}

local background = {
  size = 0.47,
  image,
  speed = 0.03,
  acel = 0.01,
  h = HEIGHT/2
  }

local time = 0
local time1 = 0
local totaltime = 0

local won = false
local lost = false
local winAlpha = 1
local frame = 1

--------Funcoes-------

---pseudo-callbacks---
function desafio3.load()
    background.image = love.graphics.newImage("res/images/desafio3/background.png")
    
    for i = 1, 2, 1 do
      player.sprite[i] = love.graphics.newImage("res/images/desafio3/cleytinho"..i..".png")
    end
    
    player.y = HEIGHT
    
end

function desafio3.update(dt)
    
    
    
    time = time + dt
    time1 = time1 + dt
    totaltime = totaltime + dt
    
    background.h = background.h + 11*dt
    
    background.size = background.size + dt*background.speed
    background.speed = background.speed + background.acel*dt
    
    player.angle = player.angle + player.acel*dt
    
    if (player.angle > math.pi/2  or player.angle < -math.pi/2) and won == false then
      
      lost = true
    
    end
    
    player.acel = player.acel + (love.math.random(-10^10, 10^10)/10^10)*0.1
    
    if time > 1  then
      frame = frame + 1
      player.acel = player.acel + (love.math.random(-10^10, 10^10)/10^10)*0.5
      time = 0
    end
    
    if time1 > 3.5  then
      player.acel = player.acel + (love.math.random(-10^10, 10^10)/10^10)*1
      time1 = 0
    end
    
    if won or lost then
      winAlpha = winAlpha - dt/4
    end
    
    if totaltime> 30 then
      
      won = true
      
    end
    
    if frame > 2 then
      frame = 1
    end
end

function desafio3.draw()
  
    if lost == false and won == false then
    
    love.graphics.draw(background.image, WIDTH/2, background.h, 0, background.size, background.size, background.image:getWidth()/2, (background.image:getHeight()/2304)*1332)
    
    love.graphics.draw(player.sprite[frame], player.x, player.y, player.angle, 1, 1, player.sprite[1]:getWidth()/2, player.sprite[1]:getHeight())
    
    end
    
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

function desafio3.keypressed(key)
    if key == keys.back then
      changeToMenu()
    end
    
    if key == keys.r then
      player.acel = player.acel + 0.25
    elseif key == keys.l then
      player.acel = player.acel - 0.25
    end
    
    if key == keys.continue and won and winAlpha < 0.5 then
      changeToDesafios()
    elseif key == keys.continue and lost and winAlpha < 0.5 then
      changeToMenu()
    end
    
end

---outras-funcoes---
function desafio3.reset()
  
  won = false
  lost = false
  time = 0
  time1 = 0
  totaltime = 0
  winAlpha = 1
  player.angle = 0
  background.h = HEIGHT / 2
  background.size = 0.47
  background.speed = 0.03
  player.y = HEIGHT
  player.x = WIDTH / 2
  
  
end


---gets/sets---

function desafio3.getWon()
  return won
end

function desafio3.getLost()
  return lost
end



--
return desafio3