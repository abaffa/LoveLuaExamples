local utils = {}

local atk = false
local speed = 200
local distance = 0
local lastSpeedBump = 0

function utils.atkSpeed()
  if atk == false then
    atk = true
    speed = speed + 200
  end
end

function utils.walkSpeed()
  if atk == true then
    atk = false
    speed = speed - 200
  end
end

function utils.getSpeed()
  return speed
end

function utils.setSpeed(s)
  speed = s
end

function utils.getDistance()
  return distance
end

function utils.setDistance(d)
  distance = d
  speed = speed + 0.1
  if speed > 600 then
    speed = 600
  end
  
end


return utils