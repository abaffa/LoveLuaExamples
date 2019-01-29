hud={}
local player = require 'player'
local enemy = require 'enemy'
local lifelosesize = 0
local staminalose = 0
local menu = require "menu"
local px = 630
function hud.load()
  
  end

function hud.update(dt) 
  lifelosesize=140-(player.life/player.lifemax)*140
  staminalose=140-(player.stamina/player.staminamax)*140      

end

function hud.draw()
  love.graphics.draw(love.graphics.newImage("image/bolo.png"),685,115,0,1/2,1/2)
  for x=1,life,1 do
  love.graphics.draw(love.graphics.newImage("image/vida_1.png"),px+x*36,150,0,1/4,1/4)
  end
  love.graphics.setColor(0,0,0,150)
  love.graphics.rectangle("fill",655,10,140,35,10)
  love.graphics.rectangle("fill",655,50,140,35,10)
  love.graphics.setColor(255,0,0,150)
  love.graphics.rectangle("fill",655,10,140-lifelosesize,35,10)
  love.graphics.setColor(0,0,255,150)
  love.graphics.rectangle("fill",655,50,140-staminalose,35,10)
  love.graphics.setColor(255,255,255,255)
  love.graphics.setFont(love.graphics.newFont(20))
  love.graphics.print("X"..player.potion,715,125)
  love.graphics.print(player.life.."/"..player.lifemax,685,18)
  love.graphics.print(player.stamina.."/"..player.staminamax, 685, 58)
  love.graphics.setFont(love.graphics.newFont(19))
  love.graphics.print("$"..player.wallet..",00",685,90)
  love.graphics.setFont(love.graphics.newFont(14))
end
return hud