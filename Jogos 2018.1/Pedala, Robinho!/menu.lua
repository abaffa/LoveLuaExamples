menu = {}

local selector = 1
local mute = false

function menu.load()
  screen = love.graphics.newImage("menu.png")
  soundOFF = love.graphics.newImage("soundOFF.png")
  soundON = love.graphics.newImage("soundON.png")
  font = love.graphics.newFont("Montserrat-Bold.otf",50)
  menu_music = love.audio.newSource("menu_music.mp3")
  
  love.audio.play(menu_music)
end

function menu.update()
 
end

function menu.draw()
  --draws menu screen
  love.graphics.draw(screen,1,0,0)
  love.graphics.setColor(0,0,0)
  love.graphics.setFont(font)
  
  --draws selector on selected option
  if selector == 1 then
    love.graphics.print(">",450,275)
  elseif selector == 2 then
    love.graphics.print(">",450,370)
  elseif selector == 3 then
    love.graphics.print(">",450,465)
  end
  --reset color
  love.graphics.setColor(255,255,255)
  
  --draw sound mode
  if mute then
    love.graphics.draw(soundOFF,947/1.5,539/1.5,0,2/3,2/3)
  else
    love.graphics.draw(soundON,755/1.5,539/1.5,0,2/3,2/3)
  end
  
end

function menu.keypressed(key)
  
  if key == "down" then
    if selector == 3 then
      selector = 3
    else
    selector = selector + 1
  end
  
  elseif key == "up" then
    if selector == 1 then
      selector = 1
    else
      selector = selector - 1
    end
  
  elseif key =="return" then
    if selector == 1 then
      love.changetoGame()
      
    elseif selector == 2 then
      if love.audio.getVolume() == 0 then
        love.unmute()
        mute = false
      else
        love.mute()
        mute = true
      end
        
    elseif selector == 3 then
      love.changeToCredits()
    end
  end
end

function menu.keyreleased(key)
end

return menu