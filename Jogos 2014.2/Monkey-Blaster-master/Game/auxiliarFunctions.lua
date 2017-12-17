--shared functions
joy={}
function joy.load()
  local joysticks = love.joystick.getJoysticks()
  for i,v in pairs(joysticks) do
    joy[i] = v
  end
  joy.count=love.joystick.getJoystickCount()
end

function joy.search(j)
  for i,v in ipairs(joy) do
    if v==j then
      return i
    end
  end
end

function update_invincibility(obj, dt)
	if(obj.invTime>0) then
		obj.invTime = obj.invTime - dt
		if(obj.invTime<0) then
			obj.invTime = 0
		end
	end
end
function getXposition(px)
  return math.floor((px-upperTileX)/size)
end
function getYposition(py)
  return math.floor((py-upperTileY)/size)
end
function check_grid_position(px,py)
	return getXposition(px), getYposition(py)
end

function check_placement(x,y,tabela) 
	x,y=check_grid_position(x,y)  --aqui o acrescimo upperTile nao e necessario
	for i,v in ipairs(tabela) do
		a,b=check_grid_position(v.x,v.y)
		if( x==a and y==b) then
			return true
		end
	end
	return false
end

function search_item(px,py,tabela)
  a,b=check_grid_position(px,py)
  a=a*size+upperTileX b=b*size+upperTileY
  for i,v in ipairs(tabela) do
    if(v.gridx==a and v.gridy==b) then
      return v,i
    end
  end
  return nil,nil
end

function nearest_player(obj)
  menor_d=1000
  for i,v in ipairs(player) do
    if i>quantPlayer then
      return menor
    end
    if not v.dead then
      d=((v.x-obj.x)^2 + (v.y-obj.y)^2)^0.5
      if d<menor_d then
        menor_d=d
        menor=v
      end
    end
  end
  return menor
end

function endTable(v)
  while #v>0 do
    table.remove(v, 1)
  end
end

function checkdead()
  if not versus then
    for i,v in ipairs(player) do
      if i>quantPlayer then
        return true
      end
      if not v.dead then
        return false
      end
    end
    return true
  else
    cont=0
    for i,v in ipairs(player) do
      if i>quantPlayer then
        break
      end
      if not v.dead then
        cont = cont + 1
      end
    end
    if cont<=1 then
      return true
    else
      return false
    end
  end
end

function reset(v)
  v.speed=speed
  v.bombQuant=0
  v.bombPower=2
  v.bombLimit=1
end