local cleyton = {
x = 652,
y = 15,
H = 232,
W = 136,
collided = false,
walk = {} ,
right = 1 ,
left = 3,
sprite = right,
time_right = 0,
time_left = 0,
time_change = 0.1,
speed = 1500,
state = 0,
dirX = 1,
falling_speed = 800,
foot = 0,
currentPUP = "empty"
}
local Platform = require ("Platform")

local PUPTime = tonumber(10)
local pup_timer = tonumber(0)

function cleyton.load()

  Pizza_Layout = love.graphics.newImage("Assets//Image//Pizza_Layout.png")
  Apple_Layout = love.graphics.newImage("Assets//Image//Apple_Layout.png")
  Hamburger_Layout = love.graphics.newImage("Assets//Image//Hamburger_Layout.png")


  love.graphics.setDefaultFilter( "nearest", "nearest", 0.234375 ) -- The image gets Prettier
  
    for x = 1, 2, 1 do
      cleyton.walk[x] = love.graphics.newImage("Assets//Image//D" .. x .. ".png") -- right
    end

    for x = 3, 4 ,1 do 
      cleyton.walk[x] = love.graphics.newImage("Assets//Image//E" .. x .. ".png") -- left
end

birl = love.audio.newSource("Assets//Musicas//Bambam.mp3")
    
end



function cleyton.update(dt)

  --set game over
  if cleyton.y < 0 - cleyton.H or cleyton.y > 2560 then
    gameover = true
    removePUP()
  else
    gameover = false
  end

  local rightPressed = love.keyboard.isDown("right")
  local leftPressed = love.keyboard.isDown("left")

  cleyton.time_right = cleyton.time_right + dt
  cleyton.time_left = cleyton.time_left + dt

  --Move to the RIGHT--
  if not (rightPressed and leftPressed) then   
    if rightPressed then
      
     cleyton.dirX = 1
     cleyton.x = cleyton.x + (cleyton.speed * dt)
     
      if cleyton.time_right > cleyton.time_change then
       
        cleyton.right = cleyton.right + 1
       
        if cleyton.right > 2 then 
         
          cleyton.right = 1
     
        end
     
        cleyton.time_right = 0
        cleyton.sprite = cleyton.right
      end
    --Move to the LEFT--
    elseif leftPressed then 
      cleyton.dirX = -1
      cleyton.x = cleyton.x + (-cleyton.speed*dt)
     
      if cleyton.time_left > cleyton.time_change then
       
        cleyton.left = cleyton.left + 1
        
        if cleyton.left > 4 then 
         
          cleyton.left = 3
     
        end

        cleyton.time_left = 0
        cleyton.sprite = cleyton.left
      end
    end
  end

  if (not(rightPressed) and not(leftPressed)) or
        (rightPressed and leftPressed) then
    if cleyton.dirX == -1 then    
      cleyton.sprite = 3
    elseif cleyton.dirX == 1 then
       cleyton.sprite = 1
    end
  end

  if cleyton.x <= 0 then
    cleyton.x = 0 
  end

  if cleyton.x >= 1304 then
    cleyton.x = 1304
  end

cleyton.collided = false
  for i = 1, #Platform.platforms do
    if checkcollision(cleyton.x + 30, cleyton.y  + cleyton.H / 1.01, cleyton.W - 60, 
      cleyton.H - cleyton.H / 1.01, Platform.platforms[i].xPos, Platform.platforms[i].yPos, Platform.Width, Platform.Height) then
      cleyton.collided = true
    end

    -- checks collision with powerups
    checkPUPCollision(Platform.platforms[i])
  end

    if cleyton.collided == true then
      cleyton.y = cleyton.y - (platform_speed * dt)
    else
      --cleyton.y = cleyton.y + (cleyton.speed * dt)
      cleyton.y = cleyton.y + (cleyton.falling_speed * dt)
      cleyton.falling_speed = cleyton.falling_speed + (2 * dt)
    end


  -- if a powerup is enabled, increases timer and checks if it has finished
  if not (cleyton.currentPUP == "empty") then
    -- increases power up timer
    pup_timer = pup_timer + dt

    if pup_timer > PUPTime then
      -- removes power up from cleyton
      removePUP()
      -- resets timer
      pup_timer = 0
    end
  end
end

-- removes powerup from cleyton if there is any
function removePUP()
  if cleyton.currentPUP == "empty" then
    return 
  end  

  -- removes effect
  if cleyton.currentPUP.type == "score" then
    score_factor = score_factor / 2
  end

  if cleyton.currentPUP.type == "speedup" then
    cleyton.speed = cleyton.speed / 2
  end

  if cleyton.currentPUP.type == "slowdown" then
    cleyton.speed = cleyton.speed * 2
  end

  -- empty cleyton PUP
  cleyton.currentPUP = "empty"

end

-- checks collision with power ups (if there is any in platform received in parameter)
function checkPUPCollision(platform)
  local pup = platform.powerup

  if pup == "empty" or not (cleyton.currentPUP == "empty") then
    return
  end

  local pupX = platform.xPos + Platform.Width / 2 - platform.powerup.img:getWidth() / 2
  local pupY = platform.yPos - platform.powerup.img:getHeight()
  local pupW = platform.powerup.img:getWidth()
  local pupH = platform.powerup.img:getHeight()

    if checkcollision(cleyton.x, cleyton.y, cleyton.W, cleyton.H, pupX, pupY, pupW, pupH) then
      -- performs powerup effects and saves in case of timed effects
      performPUP(pup)
      -- removes powerup obtained from platform
      platform.powerup = "empty"  
    end
end

function performPUP(pup)
  cleyton.currentPUP = pup
--Score x2
  if pup.type == "score" then
    score_factor = score_factor * 2
    love.audio.play(birl) 
  end
--Speed x2
  if pup.type == "speedup" then
    cleyton.speed = cleyton.speed * 2
    love.audio.play(birl) 
  end
--Speed  /2
  if pup.type == "slowdown" then
    cleyton.speed = cleyton.speed / 2
    love.audio.play(birl) 
  end
end

function cleyton.draw()

  if cleyton.currentPUP ~= "empty" then
    love.graphics.printf(round(PUPTime - pup_timer, 0), 300, 10, 250, "left", 0, 5, 6)

    if cleyton.currentPUP.type == "score" then
      love.graphics.draw(Hamburger_Layout, 10, 5)
    end

    if cleyton.currentPUP.type == "speedup" then
      love.graphics.draw(Pizza_Layout, 10, 5)
    end
    
    if cleyton.currentPUP.type == "slowdown" then
      love.graphics.draw(Apple_Layout, 10, 5)
    end

  end

  love.graphics.draw(cleyton.walk[cleyton.sprite], cleyton.x, cleyton.y)
end 

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

return cleyton