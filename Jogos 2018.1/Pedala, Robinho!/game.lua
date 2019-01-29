-- requires
game = {}

segments      = {};                      -- array of road segments
roadWidth     = 2000;                    -- actually half the roads width, easier math if the road spans from -roadWidth to +roadWidth
segmentLength = 500;                     -- length of a single segment
rumbleLength  = 2;                       -- number of segments per rumble strip
trackLength   = nil;                    -- z length of entire track (computed)
lanes         = 3;                       -- number of lanes
cameraHeight  = 1100;                    -- z height of camera
cameraDepth   = 1;                    -- z distance camera is from screen  *if we were to use FOV -> 1 / math.tan((fieldOfView/2) * math.pi/180)
drawDistance  = 100;                     -- number of segments to draw
playerX       = 0;                       -- player x offset from center of road (-1 to 1 to stay independent of roadWidth)
playerZ       = nil;                    -- player relative z distance from camera (computed)
position      = 0;                       -- current camera Z position (add playerZ to get player's absolute Z position)
speed         = 3300;                       -- current speed
fallingEnergy = 0
totalEnergies=10
currentDistance = 0
powerup_create_time = 5
dist_sum_time = 1
anim_time = 0
frame = 1
totalCars	= 15						-- number of total cars in road
maxSpeed = segmentLength * -6  -- be careful not to walk more than one segment in one frame (avoid collision detection errors)
robinho = {}
totalPowerups = 10
coinCount = 0
local selector = 1
powerBars = {}
fallingBar= 0
COINW = math.pi/2

--NEW
totalObstacles = 10
imgObstacles = {}
obstacleTimer = 0

--powerUps variables
timer = 8
drawablePowerUps = {}
contaPwr = 0
drawnPwr = 0

--broke road variables
totalBrokeRoads = 3
brokeRoadTimer = 0
BROKEROADX = -0.6
ramp = {}
ROADLANE = 2

--jumps
currentHeight = 150
gravity       = 780
vel           = 0
jump = false

-- input booleans
keyLeft = false;
keyRight = false;
keyFaster = false;
keySlower = false;
paused = false;
gameover = false;

-- colors
skyblue = {170, 202, 215};
lightgray = {115, 115, 115};
mediumgray = {120, 120, 120};
darkgray = {80, 80, 80};
yellow = {246, 215, 57};
white = {255, 255, 255};

---- colors
--skyblue = {170/255, 202/255, 215/255};
--lightgray = {115/255, 115/255, 115/255};
--mediumgray = {120/255, 120/255, 120/255};
--darkgray = {80/255, 80/255, 80/255};
--yellow = {246/255, 215/255, 57/255};
--white = {255/255, 255/255, 255/255};

-- colors scheme
COLORS = {
  SKY =  skyblue,
  LIGHT =  { road = darkgray, sidewalk = mediumgray, lane = yellow },
  DARK =   { road = darkgray, sidewalk = lightgray }
};

--NEW
--sprites
SPRITES = {
  CAR01  = 			{ x = 	0, y = 	 0,  w =	   381, h =	 297},
  MAGNET =      { x = 	0, y = 	 0,  w =	   215, h =	 215},
  X2     =      { x = 	0, y = 	 0,  w =	   126, h =	 69},
  CONE   =      { x = 	0, y = 	 0,  w =	   108, h =	 122},
  BURACO =      { x = 	0, y = 	 0,  w =	   168, h =	 79},
  LIGHTNING = { x = 0, y = 0 , w = 103 , h = 193},
  COIN = {x = 0, y = 0, w = 5, h = 5},
  BROKEROADS = {x = 0, y = 0, w = 855, h = 107}
}
SPRITES.CARS = {SPRITES.CAR01}
SPRITES.POWERUPS = {SPRITES.MAGNET}
SPRITES.OBSTACLES= {SPRITES.CONE}
SPRITES.ENERGIES = {SPRITES.LIGHTNING}
SPRITES.COINS = {SPRITES.COIN}
SPRITES.BROKEROADS = {SPRITES.BROKEROADS}
SPRITES.SCALE = 1.1

-- returns length of a table
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function randomColorLightness(n)
  if n % 2 == 0 then
    return COLORS.DARK
  else
    return COLORS.LIGHT
  end
end

-- build road
function buildRoad()
  segments = {};

  for n = 1, 500 do -- arbitrary road length
    seg = { 
      index =  n, 
      p1 = { 
        world = { z =  (n-1)  * segmentLength }, 
        camera = { z = 1, y = 1, x = 1, w = 1, scale = 1}, 
        screen = { z = 1, y = 1, x = 1, w = 1, scale = 1} 
      }, 
      p2 = { 
        world = { z = (n) * segmentLength }, 
        camera = { z = 1, y = 1, x = 1, w = 1, scale = 1}, 
        screen = {z = 1, y = 1, x = 1, w = 1, scale = 1} 
      }, 
      color = randomColorLightness(math.floor(n/rumbleLength)),
      powerups = {},
      cars = {},
      energies={},
      coins = {},
      obstacles = {},
      brokeRoads = {},
      looped = false
    }

    table.insert(segments, seg);
  end

  pSegment = findSegment(playerZ)["index"]
  segments[pSegment + 2]["color"] = COLORS.LIGHT;
  segments[pSegment + 3]["color"] = COLORS.LIGHT;
  segments[pSegment + 4]["color"] = COLORS.LIGHT;
  segments[pSegment + 5]["color"] = COLORS.LIGHT;

  trackLength = tablelength(segments) * segmentLength;
end
-- sprites add
function addSprite(n, sprite, offset)
  sprite = { source = sprite, offset = offset}
  table.insert(segments[n]["sprites"], sprite)
end
--
function interpolate(a,b,percent)
  return a + (b-a)*percent	
end
--
function randomChoice(options)
  return options[love.math.random(1, tablelength(options))]            
end

function buildCars()
  cars = {}

  for n = 0, totalCars do
    offset = randomChoice({2/3*roadWidth,0,-2/3*roadWidth})
    z      = math.floor(math.random() * tablelength(segments)) * segmentLength * 3 + 100000
    sprite = randomChoice(SPRITES.CARS)
    carspeed  = maxSpeed/2 + math.random() * maxSpeed
    segment = findSegment(z);
    car = { offset = offset, z = z, sprite = sprite,  speed = carspeed, percent = 0, segment = segment}
    table.insert(segment["cars"], car)
    table.insert(cars, car)
  end
end

function buildEnergy(position)
  energies={}
  offset = randomChoice({-2/3*roadWidth,0,2/3*roadWidth})
  sprite = randomChoice(SPRITES.ENERGIES)
  segment = findSegment(position)
  img = lightning
  energy={offset = offset, z= position, sprite = sprite, percent = 0, segment = segment, img= img}
  table.insert(segment["energies"], energy)
  table.insert(energies, energy)
end

--NEW
--build obstacles
function buildObstacles(position)
  obstacles = {}
  offset = randomChoice({-2/3*roadWidth,0,2/3*roadWidth})
  sprite = randomChoice(SPRITES.OBSTACLES)
  segment = findSegment(position)
  -- choose the obstacle type:
  num  = randomChoice({1,2})  
  img  = imgObstacles[num]
  tipo = num
  --
  obstacle = {offset = offset, z= position, sprite = sprite, percent = 0, segment = segment, img= img, tipo = num}
  table.insert(segment["obstacles"], obstacle)
  table.insert(obstacles, obstacle)
end

function buildBrokeRoad(position)
  brokeRoads = {}
  offset = 0
  sprite = randomChoice(SPRITES.BROKEROADS)
  segment = findSegment(position)
  img = ramp
  brokeRoad={offset = offset, z= position, sprite = sprite, percent = 0, segment = segment, img= img}
  table.insert(segment["brokeRoads"], brokeRoad)
  table.insert(brokeRoads, brokeRoad)
end

function buildPowerups()
  powerups = {}

  for n = 0, totalPowerups do
    offset = randomChoice({-2/3*roadWidth,0,2/3*roadWidth})
    z      = math.floor(math.random() * tablelength(segments)) * segmentLength * 3 + playerZ + position
    sprite = randomChoice(SPRITES.POWERUPS)
    segment = findSegment(z);
    x = randomChoice({1,2,3})
    img = imgPowers[x]
    tipo = x

    power = {offset = offset, z = z, sprite = sprite, percent = 0, segment = segment, img = img, tipo = x}

    table.insert(segment["powerups"], power)
    table.insert(powerups, power)
  end
end

function buildCoins(seg)
  coins = {}
  if playPowered == 1 then
    offset = playerX
  else
    offset = randomChoice({2/3*roadWidth,0,-2/3*roadWidth})
  end
  sprite = randomChoice(SPRITES.COINS)
  coin = { offset = offset, z = 0, sprite = sprite, percent = 0, segment = segments[seg]}
  table.insert(segments[seg].coins, coin)
  table.insert(coins, coin)
end

-- find the segment for any Z value even if it extends beyond the length of the road:
function findSegment(z)
  return segments[(math.floor(z/segmentLength) % tablelength(segments)) + 1];
end

-- Load config
function loadConfig()
  playerZ                = (cameraHeight * cameraDepth);
  resolution             = width/height;
end

function increase(start, increment, maxValue)  -- with looping
  result = start + increment;
  if (result >= maxValue) then
    result = result - maxValue;
  end
  if (result < 0) then
    result = result + maxValue;
  end
  return result;
end

-- input
function game.keypressed( key )
  --player movement
  if not paused and not gameover then
    if key == "a" or key == "left" then
      playerX = playerX - 1333;
    elseif key == "d" or key == "right" then
      playerX = playerX + 1333;
    end
    if key == "space" and not jump then
      jump = true
      vel = 600
    end
  end

  --pause game
  if key == "escape" then
    paused = true
  end
  --paused screen functions
  if paused then
    if key == "down" then
      if selector == 2 then
        selector = 2
      else
        selector = selector + 1
      end
    elseif key == "up" then
      if selector == 1 then
        selector = 1
      else
        selector = selector - 1
      end
    elseif key == "return" then 
      if selector == 1 then
        paused = false
      elseif selector == 2 then
        paused = not paused
        reset_game()
        love.changeToMenu()
      end
    end
  end
  --gameover screen functions
  if gameover then
    if key == "return" then
      gameover = not gameover
      reset_game()
      love.changeToMenu()
    end
  end
end

function reset_game()
  playerX = 0
  playerPowered = 0
  score   = 0
  speed   = 3300
  fallingEnergy = 0
  scoreLoader = 0
  currentDistance = 0
  currentHeight = 0
  coinCount = 0
  energyTimer = 0
  timer = 0
  obstacleTimer = 0
  brokeRoads = {}
  ROADLANE = 2
  brokeRoadTimer = 0
  BROKEROADX = -0.6

  --reset elements from each segment
  for i = 1, 500 do
    segments[i].cars = {}
    segments[i].powerups = {}
    segments[i].coins = {}
    segments[i].obstacles = {}
    segments[i].energies = {}
    segments[i].brokeRoads = {}
    segments[i].looped = false
  end    

  --rebuild elements in the game
  buildCars()
  buildPowerups()   
end

function game.keyreleased( key )
  if key == "a" or key == "left" then
    keyLeft   = false;
  end
  if key == "d" or key == "right" then
    keyRight  = false;
  end
end

-- load
function game.load()
  brokeRoadTimer = 0
  --
  energyTimer=0
  --
  ghostTimer=0
  --
  color=white
  --
  colorTimer=0
  --
  x2Timer=0
  --
  newDistance=0
  --
  scoreLoader=0
  --
  speedI=speed
  --
  playerPowered=0
  --
  obstacleTimer = 10
  -- adjust window to resolution
  -- disable vsync to avoid performance bugs
  love.window.setMode(width, height, {vsync=false})

  love.graphics.setBackgroundColor(COLORS.SKY);

  loadConfig();
  buildRoad();

  --load character frames
  robinho[1] = love.graphics.newImage("robinho1.png")
  robinho[2] = love.graphics.newImage("robinho2.png")
  robinho[3] = love.graphics.newImage("robinho3.png")
  robinho[4] = love.graphics.newImage("robinho4.png")

  -- load sprites image
  sprites = love.graphics.newImage("car.png")

  --load skyline
  skyline = love.graphics.newImage("skyline.png")

  --load energy
  energybar = love.graphics.newImage("energyBar.png")
  lightning= love.graphics.newImage("energy.png")

  --Fonte do score
  font = love.graphics.newFont("Montserrat-Bold.otf",40)

  --spawn cars
  buildCars()

  --load powerups sprites
  imgPowers = {}
  for i=1,3 do 
    imgPowers[i] = love.graphics.newImage('pwr0'..i..'.png')
  end

  --NEW
  --load obstacles sprites
  for i=1,2 do 
    imgObstacles[i] = love.graphics.newImage('obst0'..i..'.png')
  end

  buildPowerups()

  --load coins
  coin_img = love.graphics.newImage("coin.png")


  --load pause screen
  pause = love.graphics.newImage("pause.png")

  --load gameover screen
  gameoverScreen = love.graphics.newImage("gameover.png")

  --load power bars
  for i=1,3 do 
    powerBars[i] = love.graphics.newImage('pwr_bar_0'..i..'.png')
  end

  --load broke road
  for i=1,3 do
    ramp[i] = love.graphics.newImage("brokeRoad"..i..".png")
  end

end

-- return the first integer index holding the value 
function indexOf(t,val)
  for k,v in ipairs(t) do 
    if v == val then return k end
  end
end

function updateCars(dt)
-- update cars (segment stored for performance improve)
  for n = 1, tablelength(cars) do
    car         = cars[n]
    oldSegment  = car["segment"]
    car["z"]       = increase(car["z"],  dt * car["speed"], trackLength)
    car["percent"] = percentOf(car["z"], segmentLength) -- useful for interpolation during rendering phase
    newSegment  = findSegment(car["z"])
    car["segment"] = newSegment

    if (oldSegment ~= newSegment) then
      table.remove(oldSegment["cars"], indexOf(oldSegment["cars"], car))
      table.insert(newSegment["cars"], car)
    end
  end
end
-- update
function game.update(dt)

  COINW = COINW + 0.035

  if not gameover and not paused then
    --updateCars(dt)
    --energy
    energyTimer=energyTimer+dt
    if energyTimer>9*speed/speedI then
      buildEnergy(position+playerZ+speed*7)
      energyTimer=0
    end

    --broke road
    brokeRoadTimer=brokeRoadTimer+dt
    if brokeRoadTimer>20*speed/speedI then
      buildBrokeRoad(position+playerZ+speed*13)
      brokeRoadTimer=0
    end

    --broke road position
    if playerX < 0 then
      ROADLANE = 1
      BROKEROADX = -0.31
    elseif playerX > 0 then
      ROADLANE = 3
      BROKEROADX = -0.58
    else
      ROADLANE = 2
      BROKEROADX = -0.6
    end

    timer = timer + dt
    if timer > 1 then
      buildCoins(math.random(findSegment(position+playerZ).index+30 > 500 and 500 or findSegment(position+playerZ).index+30,500))
      timer = 0
    end

    --saves score
    score=scoreLoader+currentDistance+coinCount*4
    --pauses game
    if paused or gameover then
      return
    end

    anim_time = anim_time + dt  

    --robinho animation
    if anim_time>(210/(0.15*speed)) then
      frame = frame + 1
      if playerPowered == 2 then
        if frame > 4 then
          frame = 3
        end
      else
        if frame > 2 then
          frame = 1
        end
      end
      anim_time = 0
    end

    --pulos
    if jump then
      --robinho ta no chao quando currentHeight = -150        
      vel  = vel - gravity*dt
      currentHeight = currentHeight + vel*dt      
    end
    if currentHeight < 150 then
      jump = false
      currentHeight = 150
    end

    --counter for the next PowerUp
    --[[timer = timer - dt
    if timer <= 0 then    
      buildPowerUps()
      timer = 20
    end]]

    --limits robinho between lanes
    if playerX > 1333 then
      playerX = 1333
    elseif playerX < -1333 then
      playerX = -1333
    end

    --automatic speed increase
    position = increase(position, dt*speed, trackLength)


    dist_sum_time = dist_sum_time - dt
    if dist_sum_time < 0 then
      currentDistance = currentDistance + round(dt*speed*400/speedI)
      if playerPowered==3 then
        newDistance = newDistance + round(dt*speed*400/speedI)
        scoreLoader = newDistance + coinCount*4
      else
        newDistance=newDistance
      end
      dist_sum_time = 1
    end
    if playerPowered==2 or playerPowered==1 then
      ghostTimer=ghostTimer+dt

      if ghostTimer < 10 then
        if fallingBar < 177 then
          fallingBar = fallingBar + 177/10*dt
        end
      end        

      if ghostTimer>10 then
        ghostTimer=0
        playerPowered=0
      end
    end
    if playerPowered==3 then
      x2Timer=x2Timer+dt
      x2Color=true

      if x2Timer < 10 then
        if fallingBar < 177 then
          fallingBar = fallingBar + 177/10*dt
        end
      end 

      if x2Timer<1 then
        colorTimer=colorTimer+dt
        if colorTimer>0.5 then
          color=white
        else
          color={244, 167, 66}
        end
        if colorTimer>1 then
          colorTimer=0
        end
      end
      if x2Timer>10 then
        playerPowered=0
        x2Timer=0
        x2Color=false
        colorTimer=0
      end
    end

    --max speed
    if speed > 10000 then
      speed = 10000
    else
      speed = speed + 0.2
    end

    -- loss of energy
    if fallingEnergy <= 220 then
      fallingEnergy = fallingEnergy + (220/25)*dt
    else
      fallingEnergy = 220
    end

    if fallingEnergy == 220 then
      gameover = true
    end

    --NEW
    --call new obstacles and build them
    obstacleTimer=obstacleTimer+dt
    if obstacleTimer>9*speed/speedI then
      buildObstacles(position+playerZ+speed*7<30 and 30 or position+playerZ+speed*7,30)
      obstacleTimer=0
    end

    local pSegment = findSegment(position+playerZ)
    local inf = pSegment.index+1
    local sup = pSegment.index+1

    if inf <= 0 then
      inf = 1
    end

    if sup > tablelength(segments) then
      sup = tablelength(segments)
    end

    for i=inf, sup do
      if playerPowered~=2 then

        for j=#segments[i].cars,1,-1 do
          local car = segments[i].cars[j]
          if (car.offset < 0 and playerX < 0) or (car.offset>0 and playerX>0) or (playerX==0 and car.offset==0) then
            gameover=true
            break
          end
        end

        --NEW
        --verify the collision with obstacles
        for j=#segments[i].obstacles,1,-1 do
          local obstacle = segments[i].obstacles[j]       
          if (obstacle.offset < 0 and playerX < 0) or (obstacle.offset>0 and playerX>0) or (playerX==0 and obstacle.offset==0) then
            if not (obstacle.tipo == 2 and jump) then
              gameover = true
              break
            end
          end  
        end

      end

      if not jump then              
        for j=#segments[i].powerups,1,-1 do
          local power = segments[i].powerups[j]
          if (power.offset < 0 and playerX < 0) or (power.offset>0 and playerX>0) or (playerX==0 and power.offset==0) then
            fallingBar = 0
            if power.tipo==3 then
              x2Timer=0
              playerPowered=3
            end
            if power.tipo==2 then
              ghostTimer=0
              playerPowered=2
            end
            if power.tipo==1 then
              ghostTimer=0
              playerPowered=1
            end
            table.remove(segments[i].powerups, j)
          end
        end
        for j=#segments[i].energies,1,-1 do
          local energy = segments[i].energies[j]
          if (energy.offset < 0 and playerX < 0) or (energy.offset>0 and playerX>0) or (playerX==0 and energy.offset==0) then
            fallingEnergy=0
          end
          table.remove(segments[i].energies, j)
        end

        for j=#segments[i].brokeRoads,1,-1 do
          local brokeRoad = segments[i].brokeRoads[j]
          if playerPowered ~= 2 then
            if playerX <= 0 then
              gameover = true
            end
          end
          table.remove(segments[i].brokeRoads, j)
        end

        for j=1,#segments[i].coins do
          local coin = segments[i].coins[j]
          --magnet coin count
          if playerPowered == 1 then 
            coinCount = coinCount + 1
          end
          if (coin.offset < 0 and playerX < 0) or (coin.offset>0 and playerX>0) or (playerX==0 and coin.offset==0) then
            coinCount = coinCount + 1
          end
        end
        table.remove(segments[i].coins, j)
      end
    end
  end
end

-- draw
function game.draw()
  -- reset color
  love.graphics.setColor(white)

  -- energy bar
  love.graphics.draw(energybar,980,40,0,1,1)

  -- loss of energy
  love.graphics.setColor(white)
  --sem energia em fallingEnergy = 220
  love.graphics.rectangle("fill",1023,45,fallingEnergy,37)

  -- loss of power
  if playerPowered ~= 0 then
    love.graphics.draw(powerBars[playerPowered],width/2-90,height/2-192)
    if playerPowered == 2 then
      -- blue  ==> ghost
      love.graphics.setColor(171/255,202/255,214/255)      
    else
      -- white ==> others
      love.graphics.setColor(1,1,1)
    end
    love.graphics.rectangle('fill',width/2-90+3,height/2-192+4,fallingBar,6)
  end

  -- distance
  love.graphics.setColor(0,0,0)
  love.graphics.setFont(font)
  love.graphics.print(currentDistance.." m",50,20)
  love.graphics.print(coinCount,100,60)

  --reset color
  love.graphics.setColor(white)
  love.graphics.draw(coin_img,50,70,0,0.16,0.16)

  --player status
  for i=1, 3 do
    if playerPowered==i then
      love.graphics.draw(imgPowers[i],width/2,height*0.15,0,0.75,0.75,imgPowers[i]:getWidth()/2,imgPowers[i]:getHeight()/2)
    end
  end

  -- loss of power
  if playerPowered ~= 0 then
    love.graphics.draw(powerBars[playerPowered],width/2-90,height/2-192)
    if playerPowered == 2 then
      -- blue  ==> ghost
      love.graphics.setColor(171/255,202/255,214/255)      
    else
      -- white ==> others
      love.graphics.setColor(1,1,1)
    end
    love.graphics.rectangle('fill',width/2-90+3,height/2-192+4,fallingBar,6)
  end

  -- road drawing
  drawRoad();

  --skyline
  love.graphics.draw(skyline,0,181)

  -- sprites drawing
  drawSprites()

  -- character
  if x2Color then
    love.graphics.setColor(color)
  else
    love.graphics.setColor(white)
  end
  love.graphics.draw(robinho[frame], width/2, height-currentHeight, 0, 0.48, 0.48, robinho[frame]:getWidth()/2,robinho[frame]:getHeight()/2)

  love.graphics.setColor(white)

  if paused then  
    --draws pause screen
    love.graphics.draw(pause,330,179)
    love.graphics.setColor(0,0,0)
    love.graphics.setFont(font)

    --draws selector on selected option
    if selector == 1 then
      love.graphics.print(">",480,340)
    elseif selector == 2 then
      love.graphics.print(">",480,340+90)
    end
  end

  if gameover then
    --draws gameover screen
    love.graphics.draw(gameoverScreen,330,179)
    love.graphics.setColor(0,0,0)
    --draws selector (gameover)
    love.graphics.print(">",480,340+90)
    love.graphics.print("Pontuação: "..score,490,330)
  end
end


function round(n) 
  return n % 1 >= 0.5 and math.ceil(n) or math.floor(n) 
end

function project(p, cameraX, cameraY, cameraZ, cameraDepth, width, height, roadWidth)
  local proj = {};

  p.camera.x     = (p.world.x or 0) - cameraX;
  p.camera.y     = (p.world.y or 0) - cameraY;
  p.camera.z     = (p.world.z or 0) - cameraZ;

  p.screen.scale = cameraDepth/p.camera.z;

  proj.x = p.screen.scale * p.camera.x;
  proj.y = p.screen.scale * p.camera.y;
  proj.w = p.screen.scale * roadWidth;

  p.screen.x     = round((width/2)  + (proj.x  * width/2))
  p.screen.y     = round((height/2) - (proj.y  * height/2))
  p.screen.w     = round((proj.w  * width/2))
end

function drawPolygon (x1, y1, x2, y2, x3, y3, x4, y4, color)
  love.graphics.setColor( color )
  love.graphics.polygon('fill', x1, y1, x2, y2, x3, y3, x4, y4)
  -- reset color
  love.graphics.setColor(white)
end

function drawSegment (width, lanes, x1, y1, w1, x2, y2, w2, color)
  -- draws offroad scenery for the segment
  love.graphics.setColor(color.sidewalk)
  love.graphics.rectangle("fill", 0, y2, width, y1 - y2)

  -- draw road segment
  drawPolygon(x1-w1, y1, x1+w1, y1, x2+w2, y2, x2-w2,y2, color.road)

  -- draw lanes
  if (color.lane) then -- color.lane only exist in segments that lanes are supposed to be drawn
    l1 = w1 / (8*lanes)
    l2 = w2 / (8*lanes)
    lane_w1 = w1*2/lanes
    lane_w2 = w2*2/lanes
    lane_x1 = x1 - w1 + lane_w1
    lane_x2 = x2 - w2 + lane_w2
    for lane = 1, lanes-1 do
      drawPolygon(lane_x1 - l1/2, y1, lane_x1 + l1/2, y1, lane_x2 + l2/2, y2, lane_x2 - l2/2, y2, color.lane)
      lane_x1 = lane_x1 + lane_w1
      lane_x2 = lane_x2 + lane_w2
    end
  end
end
--
function percentOf(n, total)
  return (n%total)/total	
end
--
function drawRoad()
  baseSegment = findSegment(position);

  for n = 0, (drawDistance)-1 do
    segment = segments[((baseSegment["index"] + n) % tablelength(segments)) + 1];
    segment["looped"] = segment["index"] < baseSegment["index"];

    project(segment["p1"], playerX, cameraHeight, position - (segment.looped and trackLength or 0), cameraDepth, width, height, roadWidth);
    project(segment["p2"], playerX, cameraHeight, position - (segment.looped and trackLength or 0), cameraDepth, width, height, roadWidth);		

    drawSegment(width, lanes,
      segment["p1"]["screen"]["x"],
      segment["p1"]["screen"]["y"],
      segment["p1"]["screen"]["w"],
      segment["p2"]["screen"]["x"],
      segment["p2"]["screen"]["y"],
      segment["p2"]["screen"]["w"],
      segment["color"]);
  end
end

function drawSprite(width, height, resolution, roadWidth, sprites, sprite, scale, destX, destY, offsetX, offsetY)
  destW  = (sprite.w * scale * width) * SPRITES.SCALE
  destH  = (sprite.h * scale * width) * SPRITES.SCALE

  destX = destX + (destW * offsetX)
  destY = destY + (destH * offsetY)

  love.graphics.draw(sprites, destX, destY, 0, (destW)/sprite.w, (destH )/sprite.h)  
end

function drawBrokeRoad(width, height, resolution, roadWidth, sprites, sprite, scale, destX, destY, offsetX, offsetY)
  destW  = (sprite.w * scale * width) * SPRITES.SCALE
  destH  = (sprite.h * scale * width) * SPRITES.SCALE

  destX = destX + (destW * offsetX)
  destY = destY + (destH * offsetY)

  love.graphics.draw(ramp[ROADLANE], destX, destY, 0, (destW)/sprite.w, (destH )/sprite.h)  
end

function drawCoin(width, height, resolution, roadWidth, sprites, sprite, scale, destX, destY, offsetX, offsetY)
  destW  = (sprite.w * scale * width) * SPRITES.SCALE
  destH  = (sprite.h * scale * width) * SPRITES.SCALE

  destX = destX + (destW * offsetX)
  destY = destY + (destH * offsetY)

  love.graphics.draw(sprites, destX, destY, 0, (destW)/sprite.w*math.sin(COINW), (destH )/sprite.h,coin_img:getWidth()/2,coin_img:getHeight()/2)  
end

-- render all sprites
function drawSprites()
  -- reset color
  love.graphics.setColor(white)

  n = (drawDistance-1)
  while n > 0  do
    segment = segments[((baseSegment["index"] + n) % tablelength(segments)) + 1]

    -- render AI cars
    for i =  1 , tablelength(segment["cars"]) do
      car         = segment["cars"][i];
      sprite      = car["sprite"];
      spriteScale = interpolate(segment["p1"]["screen"]["scale"], segment["p2"]["screen"]["scale"], car["percent"]);
      spriteX     = interpolate(segment["p1"]["screen"]["x"],     segment["p2"]["screen"]["x"],     car["percent"]) + (spriteScale * car["offset"] * width/2);
      spriteY     = interpolate(segment["p1"]["screen"]["y"],     segment["p2"]["screen"]["y"],     car["percent"]);
      drawSprite(width, height, resolution, roadWidth, sprites, car["sprite"], spriteScale, spriteX, spriteY, -0.5, -1);
    end

-- draw the PowerUps
    for i=1, tablelength(segment["powerups"]) do
      random = randomChoice({1,2,3,4})
      power = segment["powerups"][i]
      sprite      = power["sprite"];
      spriteScale = interpolate(segment["p1"]["screen"]["scale"], segment["p2"]["screen"]["scale"], power["percent"]);
      spriteX     = interpolate(segment["p1"]["screen"]["x"],     segment["p2"]["screen"]["x"],     power["percent"]) + (spriteScale * power["offset"] * width/2);
      spriteY     = interpolate(segment["p1"]["screen"]["y"],     segment["p2"]["screen"]["y"],     power["percent"]);
      drawSprite(width, height, resolution, roadWidth, power["img"], power["sprite"], spriteScale/1.2, spriteX, spriteY, -0.35, -1);
    end

--draw lightning
    for i=1, tablelength(segment["energies"]) do
      energy      = segment["energies"][i]
      sprite      = energy["sprite"];
      spriteScale = interpolate(segment["p1"]["screen"]["scale"], segment["p2"]["screen"]["scale"], energy["percent"]);
      spriteX     = interpolate(segment["p1"]["screen"]["x"],     segment["p2"]["screen"]["x"],     energy["percent"]) + (spriteScale * energy["offset"] * width/2);
      spriteY     = interpolate(segment["p1"]["screen"]["y"],     segment["p2"]["screen"]["y"],     energy["percent"]);
      drawSprite(width, height, resolution, roadWidth, energy["img"], energy["sprite"], spriteScale/1.2, spriteX, spriteY, -0.35, -1);
    end

    --draw broke road
    for i=1, tablelength(segment["brokeRoads"]) do
      brokeRoad      = segment["brokeRoads"][i]
      sprite      = brokeRoad["sprite"];
      spriteScale = interpolate(segment["p1"]["screen"]["scale"], segment["p2"]["screen"]["scale"], brokeRoad["percent"]);
      spriteX     = interpolate(segment["p1"]["screen"]["x"],     segment["p2"]["screen"]["x"],     brokeRoad["percent"]) + (spriteScale * brokeRoad["offset"] * width/2);
      spriteY     = interpolate(segment["p1"]["screen"]["y"],     segment["p2"]["screen"]["y"],     brokeRoad["percent"]);
      drawBrokeRoad(width, height, resolution, roadWidth, brokeRoad["img"], brokeRoad["sprite"], spriteScale*4, spriteX, spriteY,BROKEROADX,-0.1);
    end

    --NEW
    --draw obstacles:
    for i=1, tablelength(segment["obstacles"]) do
      obstacle    = segment["obstacles"][i]
      sprite      = obstacle["sprite"];
      spriteScale = interpolate(segment["p1"]["screen"]["scale"], segment["p2"]["screen"]["scale"], obstacle["percent"]);
      spriteX     = interpolate(segment["p1"]["screen"]["x"],     segment["p2"]["screen"]["x"],     obstacle["percent"]) + (spriteScale * obstacle["offset"] * width/2);
      spriteY     = interpolate(segment["p1"]["screen"]["y"],     segment["p2"]["screen"]["y"],     obstacle["percent"]);
      if obstacle.tipo==1 then
        drawSprite(width, height, resolution, roadWidth, obstacle["img"], obstacle["sprite"], spriteScale*1.5, spriteX, spriteY, -0.35, -1);
      else
        drawSprite(width, height, resolution, roadWidth, obstacle["img"], obstacle["sprite"], spriteScale, spriteX, spriteY, -0.75, -0.1);
      end
    end

--draw coins
    for i=1, tablelength(segment["coins"]) do
      coin = segment["coins"][i]
      sprite      = coins["sprite"];
      spriteScale = interpolate(segment["p1"]["screen"]["scale"], segment["p2"]["screen"]["scale"], coin["percent"]);
      if playerPowered==1 then
        if coin.offset<playerX then
          coin.offset=coin.offset+8
        else
          coin.offset=coin.offset-8
        end
      else
        if coin.offset<0 then
          coin.offset=-2/3*roadWidth
        elseif coin.offset<1/3*roadWidth then
          coin.offset=0
        else
          coin.offset=2/3*roadWidth
        end
      end
      spriteX     = interpolate(segment["p1"]["screen"]["x"],     segment["p2"]["screen"]["x"],     coin["percent"]) + (spriteScale * coin["offset"] * width/2);
      spriteY     = interpolate(segment["p1"]["screen"]["y"],     segment["p2"]["screen"]["y"],     coin["percent"]);
      drawCoin(width, height, resolution, roadWidth, coin_img, coin["sprite"], spriteScale/2, spriteX, spriteY, -9, -50);
    end

    n = n - 1
  end
end
return game