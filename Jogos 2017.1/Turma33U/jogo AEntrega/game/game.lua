 print(...)
 z = (...):match("(.-)[^\\/]+$")
 print(z)


 segments    = {};
 local bikep = {}
 
 --local fase       = 1 
 local f = require "game/fases"
 local p = require "player/player"
 local h = require "HUD/HUD"
 local mp = require "menupause/menupause"
 local mudancafase = require "mudancafase/mudancafase"
 
 COLORS = {SKY   =  skyblue}
 
 local game = {}
 local scaleobstcl = 0.5 --- change here the scale of obstacles
 
 local width  = love.window.getWidth();    
 local height = love.window.getHeight(); 
 local scores
 local font = love.graphics.newFont(z.."font.ttf",20)
 local walkS = love.audio.newSource(z.. "walk.wav", "stream")
 local toolS = love.audio.newSource(z.."tool.wav", "static")   
 local waterS = love.audio.newSource(z.."water.wav", "static")
 local wreckS = love.audio.newSource(z.."wreck.wav", "static")
 
 function game.mousepressed(x, y, button)
--   area do botão
  if paused == true and state == game and button == "l"  and x > posxcontinuarp and x < posxcontinuarp + larguracontinuarp and y > posycontinuarp and y < posycontinuarp + alturacontinuarp then
       paused = false
       changelevel = false
  end
  --posxrecordsp, posyrecordsp
  
  if paused == true and state == game and button == "l"  and x > posxrecords and x < posxrecords + largurarecords and y > posyrecords and y < posyrecords + alturarecords then
       gamerec = not gamerec
  end
  
  if paused == true and button == "l" and x > posxmenuinicialp and x < posxmenuinicialp + larguramenuinicialp and y > posymenuinicialp and y < posymenuinicialp + alturamenuinicialp then
   ChangeToMenuinicial()
   paused = false
   changelevel = false
 end
   --if paused == true and button == "l" and x > posxrecords and x < posxrecords + largurarecords and y > posyrecords and y < posyrecords + alturarecords 
     -- Records()
     
  end
  function scoresCreation()
    scoresCreate  = io.open("scores.txt", "w")
    scoresCreate:write(1, "\n")
    scoresCreate:write(9999, "\n")
    scoresCreate:write(9999, "\n")
    scoresCreate:write(9999, "\n")
    scoresCreate:write(9999, "\n")
    scoresCreate:write(9999, "\n")
    scoresCreate:write(9999, "\n")
    scoresCreate:close("scores.txt")
    
    scoresRead = io.open("scores.txt", "r")
    for line in scoresRead:lines() do
 table.insert(fileLines, tonumber(line))
  end
    scoresRead:close("scores.txt")
    
    end
 -- input
function love.keypressed( key )
	if key == "a" or key == "left" then
	   keyLeft   = true;
	end
	if key == "d" or key == "right" then
	   keyRight  = true;
	end
	if key == "w" or key == "up" then
	   keyFaster   = true;
	end
	if key == "s" or key == "down" then
	   keySlower = true;
	end
  if key == "escape" and state == game and mudancafase.auxfase <= 6 then
	 paused = not paused;
   gamerec = false;
   mouse = love.mouse.setVisible(true)
   
   changelevel = false
 end
  if key == ' ' then --space
	 p.jump = true 
 end
 
end

function love.keyreleased( key )
	if key == "a" or key == "left" then
	   keyLeft   = false;
	end
	if key == "d" or key == "right" then
	   keyRight  = false;
	end
	if key == "w" or key == "up" then
	   keyFaster   = false;
	end
	if key == "s" or key == "down" then
	   keySlower = false;
	end
  
end

-- returns length of a table
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end


function randomColorLightness(n)
  
  
  COLORS.LIGHT =  { road = darkgray, grass = f.colors[f.fase].grassL, lane = whitesmoke }
  COLORS.DARK  =  { road = darkgray, grass = f.colors[f.fase].grassD }
  COLORS.START =  { road = white,    grass = f.colors[f.fase].grassL  }

	if n % 2 == 0 then
		return COLORS.DARK
	else
		return COLORS.LIGHT
	end
end


-- build road
-- ROAD GEOMETRY - Segment
function addSegment(curve) 
	n = tablelength(segments)  + 1;
	
	seg = { 
		index =  n, 
		p1 = { world = { z =  (n-1)  * segmentLength }, camera = {}, screen = {} }, 
		p2 = { world = { z = n * segmentLength }, camera = {}, screen = {} } , 
		color = randomColorLightness(math.floor(n/rumbleLength)), 
		looped = false,
		sprites = {},
		cars = {},
		curve = curve,
    collectable = {},
    obstacles = {}
	}

	table.insert(segments, seg)
end

-- interpolação - adiciona ao valor inicial uma porcentagem do que resta para o valor final
function interpolate(a,b,percent)	return a + (b-a)*percent	end

-- Adiciona uma porção da estrada
function addRoad(enter, hold, leave, curve)
	for n =  0, enter-1 do
		addSegment(interpolate(0, curve, n/enter)) -- interpola valores para suavizar entrada da curva
	end
	for n =  0, hold-1 do
		addSegment(curve);
	end
	for n =  0, leave-1 do
		addSegment(interpolate(curve, 0, n/leave)) -- interpola valores para suavizar saida da curva
	end
end

-- Adiciona curvas em S
function addSCurves()
  addRoad(ROAD.LENGTH.MEDIUM, ROAD.LENGTH.MEDIUM, ROAD.LENGTH.MEDIUM,  -ROAD.CURVE.EASY)
  addRoad(ROAD.LENGTH.MEDIUM, ROAD.LENGTH.MEDIUM, ROAD.LENGTH.MEDIUM,   ROAD.CURVE.MEDIUM)
  addRoad(ROAD.LENGTH.MEDIUM, ROAD.LENGTH.MEDIUM, ROAD.LENGTH.MEDIUM,   ROAD.CURVE.EASY)
  addRoad(ROAD.LENGTH.MEDIUM, ROAD.LENGTH.MEDIUM, ROAD.LENGTH.MEDIUM,  -ROAD.CURVE.EASY)
  addRoad(ROAD.LENGTH.MEDIUM, ROAD.LENGTH.MEDIUM, ROAD.LENGTH.MEDIUM,  -ROAD.CURVE.MEDIUM)
end

-- Adiciona retas
function addStraight(size)
	size = size or ROAD.LENGTH.MEDIUM
	addRoad(size, size, size, 0)
end

-- Adiciona curvas
function addCurve(size, curve)
	size   = size    or ROAD.LENGTH.MEDIUM
	curve  = curve  or ROAD.CURVE.MEDIUM
    addRoad(size, size, size, curve)
end
 
 -- build road
function buildRoad()
	segments = {};

  buildFaseRoad(f.fase)

	trackLength = tablelength(segments) * segmentLength;
end

-- sprites add
function addSprite(n, sprite, offset)
	sprite = { source = sprite, offset = offset}
	table.insert(segments[n]["sprites"], sprite)
end

-- build motionless sprites (for trees, billboards, obstacles, pickups...)
function buildSprites()

   -- addSprite(15,  SPRITES.TREE1, -roadWidth)
	--addSprite(20,  SPRITES.TREE1, -roadWidth)
	
	n = 21
	while n < tablelength(segments) do
		if f.fase == 3 then
      if n%27 == 0 then
        for i = 1.5, 18, 3 do
    addSprite(n, f.ambient[f.fase].tree, -i*roadWidth)
    if n%27 == 0 then
		addSprite(n, f.ambient[f.fase].elemcity, 1.2*roadWidth)
    addSprite(n, f.ambient[f.fase].elemcity, 7*roadWidth)
    if n%81 == 0 then
  addSprite(n, f.ambient[f.fase].elemcity2, 3*roadWidth)
  end
end
end
end
    elseif  f.fase == 4 then
      if n%27 == 0 then
        for i = 2, 18, 4 do
    addSprite(n, f.ambient[f.fase].tree, -i*roadWidth)
		addSprite(n, f.ambient[f.fase].tree,  i*roadWidth)
    addSprite(n, f.ambient[f.fase].elemcity, -1.2*i*roadWidth)
    addSprite(n, f.ambient[f.fase].elemcity,  1.2*i*roadWidth)
  end
end
  elseif f.fase == 2 then
    if n%9 ==0 then
      for i = 1.8, 4, 2 do
      addSprite(n, f.ambient[f.fase].tree, -i*roadWidth)
		  addSprite(n, f.ambient[f.fase].tree,  i*roadWidth)
    end
    end
  elseif f.fase ~= 5 and f.fase ~= 6 then
		addSprite(n, f.ambient[f.fase].tree, -2*roadWidth)
		addSprite(n, f.ambient[f.fase].tree,  2*roadWidth)
  elseif f.fase == 5 then
    for i = 0.2, 9, 2 do
    addSprite(n, f.ambient[f.fase].tree, -i*roadWidth)
		addSprite(n, f.ambient[f.fase].tree,  i*roadWidth)
  end
else
  if n%9 == 0 then
    for i = 1, 9, 2 do
    addSprite(n, f.ambient[f.fase].tree, -i*roadWidth)
		addSprite(n, f.ambient[f.fase].tree,  i*roadWidth)
  end
  end
  end
    if n%27 == 0 and  f.fase ~= 3 and f.fase ~= 5 and f.fase ~= 6 then
    addSprite(n, f.ambient[f.fase].elemcity, -1.2*roadWidth)
    addSprite(n, f.ambient[f.fase].elemcity,  1.2*roadWidth)
  elseif n%81 == 0 and f.fase == 5  then
    addSprite(n, f.ambient[f.fase].elemcity, -1.2*roadWidth)
    addSprite(n, f.ambient[f.fase].elemcity2,     roadWidth)
  elseif n%81 == 0 and f.fase == 6 then
    addSprite(n, f.ambient[f.fase].elemcity, -1.2*roadWidth)
    addSprite(n, f.ambient[f.fase].elemcity2, 1.2*roadWidth)
  end
		n = n + (rumbleLength * 2) 
	end
end

function randomChoice(options)            return options[math.random(1, tablelength(options))]            end

function buildCollect()
	collects = {};
  local z

	for n = 0, totaltens do
    active =  1
    typpe  =  love.math.random(1, 2)
		offset =  love.math.random(0,1) *randomChoice({-0.7 * roadWidth, 0.7 * roadWidth}) --math.random() *
		z      =  math.random( 20, tablelength(segments)-20) * segmentLength
		if (typpe == 1) then  sprite = SPRITES.WATER else  sprite = SPRITES.TOOL end
		segment = findSegment(z);
		collect = { offset = offset, z = z, sprite = sprite, segment = segment, active = active, typpe = typpe }
		table.insert(segment["collectable"], collect)
		table.insert(collects, collect)
	end
end

function buildObstacles()
	obstcls = {};
  local z
	for n = 0, totaltens do
    active =  1
		offset =  love.math.random(0,1) *randomChoice({-0.7 * roadWidth, 0.7 * roadWidth}) --math.random() *
    z      =  math.random( 20, tablelength(segments)-20) * segmentLength
		segment = findSegment(z);
    if (segment.curve <= 1 and segment.curve >= -1) then
      typpe = 1
    else
      typpe = 2
    end  
    if (typpe == 1) then  sprite = f.obstc.jumpable[f.fase] else  sprite = f.obstc.njumpable[f.fase] end
		obstcl = { offset = offset, z = z, sprite = sprite, segment = segment, active = active, typpe = typpe}
		table.insert(segment["obstacles"], obstcl)
		table.insert(obstcls, obstcl)
	end
end

function buildCars()
	cars = {};
  local z

	for n = 0, totalCars do
    active =  1
    typpe = 2
		offset = randomChoice({-0.8 * roadWidth, 0.8 * roadWidth}) --math.random() *
    z      = math.floor(math.random() * tablelength(segments)) * segmentLength
		sprite = randomChoice(SPRITES.CARS)
		carspeed  =  0.1 * maxSpeed --math.random()
		segment = findSegment(z);
		car = { offset = offset, z = z, sprite = sprite,  speed = carspeed, percent = 0, segment = segment, active = active, typpe = typpe}
		table.insert(segment["cars"], car)
		table.insert(cars, car)
	end
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
		result = result -  maxValue;
	end
	if (result < 0) then
		result = result + maxValue;
	end
	return result;
 end
 
 function limit(value, minValue, maxValue)   
	return math.max(minValue, math.min(value, maxValue))                     
end

function drawRoad()
	baseSegment = findSegment(position)
	basePercent = percentOf(position, segmentLength)
	dx = -(baseSegment["curve"] * basePercent)
	x  = 0;
  
	for n = 0, (drawDistance)-1 do
		segment = segments[((baseSegment["index"] + n) % tablelength(segments)) + 1];
		segment["looped"] = segment["index"] < baseSegment["index"];
		
		project(segment["p1"], p.playerX, cameraHeight, position - (segment.looped and trackLength or 0), cameraDepth, width, height, roadWidth);
		project(segment["p2"], p.playerX, cameraHeight, position - (segment.looped and trackLength or 0), cameraDepth, width, height, roadWidth);		

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

function game.load()----------------------------------------- 
  auxanimep   = 1
  auxanimet   = 0.2
  mudancafase.load()
  p.load()
  walkS:setVolume(1)
  --mp.load()
     scoresRead  = io.open("scores.txt", "r")
   fileLines = {}
  
  if not scoresRead then 
    scoresCreation()
   else 
 for line in scoresRead:lines() do
 table.insert(fileLines, tonumber(line))
  end
scoresRead.close()
end


  -- adjust window to resolution
	-- disable vsync to avoid performance bugs
  
  fundos = {}
	for x = 1, 6, 1 do
    img = love.graphics.newImage(z .. "fundofase".. x ..".png")  --fundo_portoalegre
    imgscalex = width/img:getWidth()
    imgscaley = height/img:getHeight()
    fundo = { img = img , imgscalex = imgscalex, imgscaley = imgscaley }
     table.insert(fundos, fundo)
  end
  fundos[1].imgscalex = width/fundos[1].img:getWidth()
  fundos[1].imgscaley = height/(1.9*169)
  fundos[2].imgscalex = width/fundos[2].img:getWidth()
  fundos[2].imgscaley = height/(1.9*169)
  fundos[3].imgscalex = width/fundos[3].img:getWidth()
  fundos[3].imgscaley = 0.6*height/fundos[3].img:getHeight()
  fundos[4].imgscalex = width/fundos[4].img:getWidth()
  fundos[4].imgscaley = 1.8*height/fundos[4].img:getHeight()
  fundos[5].imgscalex = width/fundos[5].img:getWidth()
  fundos[5].imgscaley = 0.7*height/fundos[5].img:getHeight()
  fundos[6].imgscalex = width/fundos[6].img:getWidth()
  fundos[6].imgscaley = 1.3*height/fundos[6].img:getHeight()

  fonte_agua = love.graphics.newImage(z .. "fonte_agua.png")
  
  for k = 1, 2, 1 do
    bikep[k] = love.graphics.newImage(z .. "bike" .. k ..".png")
  end
  bikep_largura=bikep[1]:getWidth()/2
  bikep_altura=bikep[1]:getHeight()/2
  
    -- adjust window to resolution
	-- disable vsync to avoid performance bugs
	--love.window.setMode(width, height, {vsync=false})
	
	love.graphics.setBackgroundColor(COLORS.SKY);
	
	-- load sprites image
	sprites = love.graphics.newImage("game/Pseudo3DSpritesExample.png")
	-- height jump
   dy = p.hjump
   
	loadConfig()
	-- build road
	buildRoad()
	-- build sprites (of motionless objects)
	buildSprites()
	-- build cars
	buildCars()
  -- build collectables
  buildCollect()
  -- build obstacles
  buildObstacles()
 end
 
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

-- check collision on x axis
function overlap (x1, w1, x2, w2, percent)
	percent = percent or 1
	min1 = x1
	min2 = x2
	max1 = x1 + (w1*percent)
	max2 = x2 + (w2*percent)
	return  ((max1 > min2) and (min1 < max2))
end
 
function game.update(dt)------------------------------------------
  -- updates player segment
  
	playerSegment = findSegment(position+playerZ)
  
  if speed > 0 and p.jump == false and paused == false then
      walkS:setLooping(true)
      walkS:setVolume(1)
      love.audio.play(walkS)
    else
      love.audio.stop(walkS)
    end
  if paused == false then
    
    
    
      p.update(dt)
      
       if findSegment(position).index > 2 then
         h.update(dt)
       end
  if findSegment(position).index >= tablelength(segments) -2 and findSegment(position).index <= tablelength(segments) then
      table.remove(fileLines, 1)
      table.insert(fileLines, 1, f.fase+1)
      
      table.remove(fileLines, f.fase+1)
      table.insert(fileLines, f.fase+1, p.score)
      
    --if not scoresRead then
      scoresWrite = io.open("scores.txt", "w")
      scoresWrite:write(fileLines[1], "\n")
      scoresWrite:write(fileLines[2], "\n")
      scoresWrite:write(fileLines[3], "\n")
      scoresWrite:write(fileLines[4], "\n")
      scoresWrite:write(fileLines[5], "\n")
      scoresWrite:write(fileLines[6], "\n")
      scoresWrite:write(fileLines[7], "\n")
      scoresWrite:close("scores.txt")
    
    --end
      mudancafase.update(dt)
      paused = true
      changelevel = true
      if (mudancafase.auxfase <= 6) then
        
        game.load()
        mp.load()
      end
      
  end
    
  p.playerX = p.playerX - segment.curve*centrifugal*speed
	-- update AI cars
	if f.fase == 2 then
    updateCars(dt)
	end
	-- updates player segment
  
	--playerSegment = findSegment(position+playerZ)
  
  -- jumping mechanics
  
  if (p.jump == true) then
    dy = dy - 30*dt
    p.yjump = p.yjump - dy
    if (p.yjump >= 0) then
      p.yjump = 1
      p.jump = false
      dy = p.hjump
    end
  end  
  
  if(ncargas == 0 or nivelagua == 0) then
    mouse = love.mouse.setVisible(true)
    love.load()
    
  end  
  
  dx = dt * 5000

  if ( keyLeft == true and  keyRight == true) then
    --keyLeft = false
    --keyRight = false
  else  
    if (keyLeft) and p.playerX >= -1999 then
      p.playerX = p.playerX - dx;
      if p.deg > -20 then
        p.deg = p.deg - 50*dt
       end
    elseif (keyRight) and p.playerX <= 1999 then
      p.playerX = p.playerX + dx;
      if p.deg < 20 then
        p.deg = p.deg + 50*dt
       end
    end
  end

	if (keyFaster) then
		speed = speed + 25
    auxanimet = auxanimet + dt*speed/2000
    if auxanimet > 0.4 then
       if auxanimep == 2 then
         auxanimep = 0
       end  
      auxanimep = auxanimep + 1
      auxanimet = 0
    end
   
	elseif (keySlower)  then  --and speed > 0
		speed = speed - 50
	else
		if speed > 0 then
			speed = speed - 5
		elseif speed < 0 then
			speed = speed + 5
		else
			--speed = 0      --
		end
	end

	speed = limit(speed, -10000, 10000) -- limit speed
	p.playerX = limit(p.playerX, -2000, 2000);     -- dont ever let player go too far out of bounds
	position = increase(position, dt * speed, trackLength);
  
  -- inclinacao a bike
   
   if (keyRight == false or (keyRight and keyLeft)) and p.deg >= 0 or p.playerX >= 1999 --or bike.px >= larguratela*4/5 - bike.largura/2
   then p.deg = p.deg - 80*dt -- "desenclina"
   end
   
   
   if (keyLeft == false or (keyRight and keyLeft)) and p.deg <= 0 or p.playerX <= -1999--or bike.px <= larguratela*1/5 + bike.largura/2
   then p.deg = p.deg + 80*dt -- "desenclina"
   end
end 

-----------COLLISION------------
	
	-- player width 
	playerW       = p.w ;
	
	-- car collision
	lookahead = 1;
	-- looks for collision in a range of (-1,0,1) segements
	for i = -1, lookahead do
		-- gets segment to look for segment
		segment = segments[(playerSegment["index"]+i)%tablelength(segments) + 1];
		-- search for collision with all things in segment
    
    for n = 1,  tablelength(segment["obstacles"])  do
			-- stores the current car to check collision
			car  = segment["obstacles"][n];
			-- gets car width
			carW = car["sprite"]["w"] * SPRITES.SCALE;
			-- checks collision
			if (overlap(p.playerX, playerW, car["offset"], carW, scaleobstcl+0.1) and car.active == 1) then		
				-- collision happened
         if ( car.typpe == 2 or car.typpe == 1 and p.jump == false) then
          speed    = speed * 0.5;
          ncargas  = ncargas - 1
          love.audio.play(wreckS)
          wreckS:setVolume(0.5)
          car.active = 0
         end 
			end
		end
    --collion cars SaoPaulo
   if (f.fase == 2) then
     for n = 1,  tablelength(segment["cars"])  do
        -- stores the current car to check collision
        car  = segment["cars"][n];
        -- gets car width
        carW = car["sprite"]["w"] * SPRITES.SCALE;
        -- checks collision
        if (overlap(p.playerX, playerW, car["offset"], carW, 1.5) and car.active == 1) then		
          -- collision happened
            speed    = speed * 0.5;
            ncargas  = ncargas - 1
            car.active = 0 
        end
      end
    end
		for n = 1,  tablelength(segment["collectable"])  do
			-- stores the current iten to check collision
			item  = segment["collectable"][n];
			-- gets item width
			itemW = item["sprite"]["w"];
			-- checks collision
			if (overlap(p.playerX-200, playerW, item["offset"], itemW, 1)) then		
				-- collision happened
        if (item.typpe == 1 and nivelagua < 10 and item.active == 1) then
          nivelagua = nivelagua + 1
          waterS:setVolume(0.5)
          love.audio.play(waterS)
        end
         if (item.typpe == 2 and ncargas < 8 and item.active == 1) then
          ncargas = ncargas + 1
          love.audio.play(toolS)
          toolS:setVolume(0.5)
        end
        item.active = 0;
			end
		end
	end
end

function game.draw()--------------------------------------------
  -- set new font
  love.graphics.setFont(font)
  
  if paused == true then
  --mouse = love.mouse.setVisible(true)
  end
  if paused == false then 
      mouse = love.mouse.setVisible(false)
      end
  love.graphics.draw(fundos[f.fase].img,0,0,0,fundos[f.fase].imgscalex,fundos[f.fase].imgscaley)
	-- reset color
	love.graphics.setColor(white)
	
	-- road drawing
	drawRoad()
	-- sprites drawing
	drawSprites()
  --love.graphics.print() --tablelength(segments)
  --love.graphics.print(testeScore, 0, 20)
  love.graphics.draw(bikep[auxanimep], width/2, height + p.yjump, math.rad(p.deg),0.7,0.7,bikep_largura,bikep_altura*2)
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
	love.graphics.setColor(color.grass)
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

function percentOf(n, total)		return (n%total)/total	end

function drawRoad()
	baseSegment = findSegment(position)
	basePercent = percentOf(position, segmentLength)
	dx = -(baseSegment["curve"] * basePercent)
	x  = 0;
	
	for n = 0, (drawDistance)-1 do
		segment = segments[((baseSegment["index"] + n) % tablelength(segments)) + 1];
		segment["looped"] = segment["index"] < baseSegment["index"];
		
		project(segment["p1"], p.playerX - x, cameraHeight, position - (segment.looped and trackLength or 0), cameraDepth, width, height, roadWidth);
		project(segment["p2"], p.playerX - x - dx, cameraHeight, position - (segment.looped and trackLength or 0), cameraDepth, width, height, roadWidth);		
		
		x = x + dx
		dx = dx + segment["curve"]
		
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

	quad = love.graphics.newQuad(sprite.x,  sprite.y, sprite.w, sprite.h, sprites:getDimensions())
	
	love.graphics.draw(sprites, quad, destX, destY, 0, (destW)/sprite.w, (destH )/sprite.h)  
 end

-- render all sprites
function drawSprites()
	-- reset color
	love.graphics.setColor(white)
					  
	n = (drawDistance-1)
	while n > 0  do
		segment = segments[((baseSegment["index"] + n) % tablelength(segments)) + 1]
	
		-- render trees, billboards...
		for i = 1 , tablelength(segment["sprites"]) do
			sprite      = segment["sprites"][i]
			spriteScale = segment["p1"]["screen"]["scale"]
			spriteX     = segment["p1"]["screen"]["x"] + (spriteScale * sprite["offset"] * width/2)
			spriteY     = segment["p1"]["screen"]["y"]

			drawSprite(width, height, resolution, roadWidth, sprites, sprite["source"], spriteScale, spriteX, spriteY, (sprite["offset"] < 0 and -1 or 0), -1)
		end
		
		-- render AI cars
		if f.fase == 2 then
      for i =  1 , tablelength(segment["cars"]) do
        car         = segment["cars"][i];
        sprite      = car["sprite"];
        spriteScale = interpolate(segment["p1"]["screen"]["scale"], segment["p2"]["screen"]["scale"], car["percent"]);
        spriteX     = interpolate(segment["p1"]["screen"]["x"],     segment["p2"]["screen"]["x"],     car["percent"]) + (spriteScale * car["offset"] * width/2);
        spriteY     = interpolate(segment["p1"]["screen"]["y"],     segment["p2"]["screen"]["y"],     car["percent"]);
        drawSprite(width, height, resolution, roadWidth, sprites, car["sprite"], spriteScale*1.5, spriteX, spriteY, -0.5, -1);
      end
   end 
		-- render collectable
    
    for i = 1 , tablelength(segment["collectable"]) do
      if (segment["collectable"][i].active == 1) then
        --sprite      = segment["collectable"]
      collect     = segment["collectable"][i];
			sprite      = collect["sprite"];
			spriteScale = segment["p1"]["screen"]["scale"]
			spriteX     = segment["p1"]["screen"]["x"] + (spriteScale * collect["offset"] * width/2)
			spriteY     = segment["p1"]["screen"]["y"]
			drawSprite(width, height, resolution, roadWidth, sprites, collect["sprite"], spriteScale*0.7, spriteX, spriteY, -0.5, -1);
      end
    end  
    
    -- render OBSTACLES
    
    for i = 1 , tablelength(segment["obstacles"]) do
     
        --sprite      = segment["collectable"]
      obstcl     = segment["obstacles"][i];
			sprite      = obstcl["sprite"];
			spriteScale = segment["p1"]["screen"]["scale"]
			spriteX     = segment["p1"]["screen"]["x"] + (spriteScale * obstcl["offset"] * width/2)
			spriteY     = segment["p1"]["screen"]["y"]
			drawSprite(width, height, resolution, roadWidth, sprites, obstcl["sprite"], spriteScale*scaleobstcl, spriteX, spriteY, -0.5, -1);
    end  
    
		-- render player
		--if (segment == playerSegment)  then
			--[[drawSprite(width, height, resolution, roadWidth, sprites, SPRITES.BIKE,
					  cameraDepth*0.55/playerZ,
					  width/2,
					 height/3.5,
					   -0.5,
					  1);
		end]]
		
		n = n - 1
	end

end
return game