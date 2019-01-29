-- requires
local pause = require "pause"
local menu = require "menu"
local trump = require"trump"
--local fase = require "fase"
local cutscene = require "cutscene"
--local hud = require "hud"

pista={
  speed = 0,
  dx = nil,
  playerX = 0,
  foto = nil,
  fotoX = 0,
  totalCars = 0,
  seila = false,
  acel = 5000
}

width         = 800;                    -- logical canvas width
height        = 720;                     -- logical canvas height
 segments      = {};                      -- array of road segments
local roadWidth     = 2500;                    -- actually half the roads width, easier math if the road spans from -roadWidth to +roadWidth
local segmentLength = 200;                     -- length of a single segment
local rumbleLength  = 3;                       -- number of segments per rumble strip
local trackLength   = nil;                    -- z length of entire track (computed)
local lanes         = 3;                       -- number of lanes
local cameraHeight  = 1300;                    -- z height of camera
local cameraDepth   = 3;                    -- z distance camera is from screen  *if we were to use FOV -> 1 / math.tan((fieldOfView/2) * math.pi/180)
local drawDistance  = 300;                     -- number of segments to draw
--local playerX       = 0;                       -- player x offset from center of road (-1 to 1 to stay independent of roadWidth)
local playerZ       = nil;                    -- player relative z distance from camera (computed)
local position      = 0;                       -- current camera Z position (add playerZ to get player's absolute Z position)

-- input booleans
local keyLeft = false;
local keyRight = false;
local keyFaster = false;
local keySlower = false;

-- colors
local skyblue = {135, 206, 235};
local darkgray = {169, 169, 169};
local greenmedium = {10, 111, 10};
local whitesmoke = {245, 245, 245};
local darkgreen = { 0, 100, 0};
local white = {255, 255, 255};


-- colors scheme
local COLORS = {
  SKY =  skyblue,
  LIGHT =  { road = darkgray, grass = greenmedium, lane = whitesmoke },
  DARK =   { road = darkgray, grass = darkgreen },
  START =  { road = white,   grass = greenmedium  }
};

-- sprites
SPRITES = {
  TREE1 =              { x =    0, y =    50, w =  232, h =  153 },
  CAR01 = 			{ x = 	0, y = 	 0,  w =	   82, h =	 46},
  CAR02 = 			{ x = 180, y = 	 0,  w =	   82, h =	 46}
}
SPRITES.CARS = {SPRITES.CAR01, SPRITES.CAR02}
SPRITES.SCALE = 4.2

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

-- road config
local ROAD = {
  LENGTH = { NONE= 0, SHORT=  25, MEDIUM=  40, LONG=  80 },
  CURVE =  { NONE= 0, EASY=    2, MEDIUM=   4, HARD=    6 }
};

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
		curve = curve
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
	size    = size    or ROAD.LENGTH.MEDIUM
	curve  = curve  or ROAD.CURVE.MEDIUM
    addRoad(size, size, size, curve)
end

 -- build road
function buildRoad()
	segments = {};

	addStraight(ROAD.LENGTH.SHORT/4)
	addStraight(ROAD.LENGTH.LONG)
  addStraight(ROAD.LENGTH.LONG)
  --[[addSCurves()
	addStraight(ROAD.LENGTH.LONG)
	addSCurves()
	addCurve(ROAD.LENGTH.LONG, -ROAD.CURVE.MEDIUM)
	addCurve(ROAD.LENGTH.LONG, ROAD.CURVE.MEDIUM)
	addCurve(ROAD.LENGTH.LONG, -ROAD.CURVE.EASY)--]]

	pSegment = findSegment(playerZ)["index"]
	--[[segments[pSegment + 2]["color"] = COLORS.START;
	segments[pSegment + 3]["color"] = COLORS.START;
    segments[pSegment + 4]["color"] = COLORS.START;
	segments[pSegment + 5]["color"] = COLORS.START;]]

	trackLength = tablelength(segments) * segmentLength;
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

 -- input
function love.keypressed( key )
	if key == "a" or key == "left" then
	   keyLeft   = true;
	end
	if key == "d" or key == "right" then
	   keyRight  = true;
	end
	--[[if key == "w" or key == "up" then
	   keyFaster   = true;
	end
	if key == "s" or key == "down" then
	   keySlower = true;
	end--]]
end

function love.keyreleased( key )
	if key == "a" or key == "left" then
	   keyLeft   = false;
	end
	if key == "d" or key == "right" then
	   keyRight  = false;
	end
	--[[if key == "w" or key == "up" then
	   keyFaster   = false;
	end
	if key == "s" or key == "down" then
	   keySlower = false;
	end--]]
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

-- load
function pista.load()
    -- adjust window to resolution
	-- disable vsync to avoid performance bugs
	love.window.setMode(width, height, {vsync=false})
	pista.foto = love.graphics.newImage("casaBranca.png")
	love.graphics.setBackgroundColor(COLORS.SKY);
  sprites = love.graphics.newImage("Pseudo3DSpritesExample.png")

	loadConfig();
	buildRoad();

  	-- build sprites (of motionless objects)
	buildSprites()
	-- build cars
	buildCars(0)
end

healthLock = false

 -- update
function pista.update(dt)
  if not pause.onPause and not menu.onMenu and not cutscene.onCutscene then
    pista.dx = dt * 5000
    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
      pista.playerX = pista.playerX - pista.dx;

    elseif love.keyboard.isDown("right") or love.keyboard.isDown("d") then
      pista.playerX = pista.playerX + pista.dx;

    end
    
   
     pista.speed = pista.speed + pista.acel *dt
   --[[ if (love.keyboard.isDown("w")) then
      pista.speed = pista.speed + 125
    elseif (love.keyboard.isDown("s")) then
      pista.speed = pista.speed - 125
    else
      if pista.speed > 0 then
        pista.speed = pista.speed - 5
      elseif pista.speed < 0 then
        pista.speed = pista.speed + 5
      else
        pista.speed = 0
      end
    end]]

    playerSegment = findSegment(position + playerZ)

    updateCars(dt)
    
    lookahead = 1
     
    for i=-1, lookahead do 
      segment = segments[(playerSegment["index"]+i)%tablelength(segments) + 1];
      for j = 1,  tablelength(segment["cars"]) do
        car  = segment["cars"][j];
        carW = car["sprite"]["w"] * SPRITES.SCALE;
        
        if (overlap(pista.playerX, trump.tileSize, car["offset"], carW, 2.0)) then		        
        	if not healthLock then
            	hud["hit"]= true --boolean que tira 1 vida
            	healthLock = true -- lockar vidas
          	else
            	hud["hit"] = false 
          	end
          	pista["speed"] = 0 -- para o player
          	car["speed"] = 0 --para o carro
          	trump["colidindo"] = true -- variavel para parar animação
        else
        	trump["colidindo"] = false
            hud.hit = false
            healthLock = false
        end
      end
    end
  
    pista.speed = limit(pista.speed, -10000, 20000) -- limit speed
    pista.playerX = limit(pista.playerX, -2000, 2000);     -- dont ever let player go too far out of bounds
    position = increase(position, dt * pista.speed, trackLength);
    
  end
end

 -- draw
function pista.draw()
  if not menu.onMenu and not cutscene.onCutscene then
    -- reset color
    love.graphics.setColor(white)
    --background drawing
    love.graphics.draw(pista.foto, pista.fotoX, 0, 0, 0.39, 0.202)

    -- road drawing
    drawRoad();

    -- draw sprites
    drawSprites();
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
	p.screen.y     = round((height * 0.32) - (proj.y  * height/2))
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

		project(segment["p1"], pista.playerX - x, cameraHeight, position - (segment.looped and trackLength or 0), cameraDepth, width, height, roadWidth);
		project(segment["p2"], pista.playerX - x - dx, cameraHeight, position - (segment.looped and trackLength or 0), cameraDepth, width, height, roadWidth);

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

-- return the first integer index holding the value
function indexOf(t,val)
    for k,v in ipairs(t) do
        if v == val then return k end
    end
end


-- sprites add
function addSprite(n, sprite, offset)
	sprite = { source = sprite, offset = offset}
	table.insert(segments[n]["sprites"], sprite)
end

-- build motionless sprites (for trees, billboards, obstacles, pickups...)
function buildSprites()

  addSprite(15,  SPRITES.TREE1, -roadWidth)
	addSprite(20,  SPRITES.TREE1, -roadWidth)

	n = 21
	while n < tablelength(segments) do
		addSprite(n, SPRITES.TREE1, -roadWidth)
		addSprite(n, SPRITES.TREE1, roadWidth)
		n = n + 20+ (rumbleLength * 2)
	end
end

function randomChoice(options)            return options[math.random(1, tablelength(options))]            end


maxSpeed = segmentLength * 60

function buildCars(ncars)
	cars = {};
 -- print(pista.totalCars)
	for n = 0, ncars--[[pista.totalCars]] do
		offset = math.random() * randomChoice({-0.8 * roadWidth, 0.8 * roadWidth})
		z      = math.floor(math.random() * tablelength(segments)) * segmentLength
		sprite = randomChoice(SPRITES.CARS)
		carspeed  = -(maxSpeed/4 + math.random() * maxSpeed)
		segment = findSegment(z);
		car = { offset = offset, z = z, sprite = sprite,  speed = carspeed, percent = 0, segment = segment}
		table.insert(segment["cars"], car)
		table.insert(cars, car)
	end

end


function pista.updateStages(cars, valor)
  cars = valor
  print(cars)
  buildCars(cars)
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

function drawSprite(width, height, resolution, roadWidth, sprites, sprite, scale, destX, destY, offsetX, offsetY)
    destW  = (sprite.w * scale * width) * SPRITES.SCALE
    destH  = (sprite.h * scale * width) * SPRITES.SCALE

    destX = destX + (destW * offsetX)
    destY = destY + (destH * offsetY)

	quad = love.graphics.newQuad(sprite.x,  sprite.y, sprite.w, sprite.h, sprites:getDimensions())

	love.graphics.draw(sprites, quad, destX, destY, 0, (destW)/sprite.w, (destH )/sprite.h)
 end

function overlap (x1, w1, x2, w2, percent)
	percent = percent or 1
	min1 = x1
	min2 = x2
	max1 = x1 + (w1*percent)
	max2 = x2 + (w2*percent)
	return  ((max1 > min2) and (min1 < max2))
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
		for i =  1 , tablelength(segment["cars"]) do
			car         = segment["cars"][i];
			sprite      = car["sprite"];
			spriteScale = interpolate(segment["p1"]["screen"]["scale"], segment["p2"]["screen"]["scale"], car["percent"]);
			spriteX     = interpolate(segment["p1"]["screen"]["x"],     segment["p2"]["screen"]["x"],     car["percent"]) + (spriteScale * car["offset"] * width/2);
			spriteY     = interpolate(segment["p1"]["screen"]["y"],     segment["p2"]["screen"]["y"],     car["percent"]);
			drawSprite(width, height, resolution, roadWidth, sprites, car["sprite"], spriteScale, spriteX, spriteY, -0.5, -1);
		end

		-- render player
		--[[if (segment == playerSegment)  then
			drawSprite(width, height, resolution, roadWidth, sprites, SPRITES.CAR02,
					  cameraDepth/playerZ,
					  width/2,
					 (height/2),
					   -0.5,
					  1);
		end]]

		n = n - 1
	end
end

return pista
