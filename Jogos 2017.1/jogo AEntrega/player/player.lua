 b = (...):match("(.-)[^\\/]+$")
 local h = require "HUD/HUD"
 local player = {}

function player.load()
h.load()
--segments      = {};                     -- array of road segments
roadWidth     = 2000;                    -- actually half the roads width, easier math if the road spans from -roadWidth to +roadWidth
segmentLength = 200;                     -- length of a single segment
rumbleLength  = 3;                       -- number of segments per rumble strip
trackLength   = nil;                     -- z length of entire track (computed)
lanes         = 3;                       -- number of lanes
cameraHeight  = 1400;                    -- z height of camera
cameraDepth   = 1;                       -- z distance camera is from screen  *if we were to use FOV -> 1 / math.tan((fieldOfView/2) * math.pi/180)
drawDistance  = 300;                     -- number of segments to draw
player.playerX  = 0;                     -- player x offset from center of road (-1 to 1 to stay independent of roadWidth)
player.playerZ  = nil;                   -- player relative z distance from camera (computed)
position      = 0;                       -- current camera Z position (add playerZ to get player's absolute Z position)
speed         = 0;                       -- current speed
totalCars	    = 70;                    
totaltens     = 90;
maxSpeed      = segmentLength * 60
centrifugal   = 0.0005
lap           = 0
finallap      = 1
--fase          = 1                        -- initial fase
  love.graphics.setFont(love.graphics.newFont(20))
  timesec     = 0
  formsec     = 0
  timemin     = 0
  formin      = 0
  timehora    = 0
  formho      = 0
  local fundo_portoalegre
  local fonte_agua
  local bikep
  local bikep_largura
  local bikep_altura
  player.deg   = 0
  player.score = 0
 -- player.highscore = 0
  player.w     = 400
  player.jump  = false   -- juping state
  player.yjump = 1
  player.hjump = 6       --jump height
-- input booleans
keyLeft = false;
keyRight = false;
keyFaster = false;
keySlower = false;


-- Load config
function loadConfig()
	playerZ                = (cameraHeight * cameraDepth);
	resolution             = width/height;
end
end

function player.update(dt)
     player.score = h.timesec2
end

function player.draw()
end

return player