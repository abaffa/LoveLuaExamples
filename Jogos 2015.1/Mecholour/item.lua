item = {
  speed_plus = love.graphics.newImage("item/movespeedplus.png"),
  speed_minus = love.graphics.newImage("item/movespeedminus.png"),
  width = 0,
  height = 0,
  timeplus= 0,
  timeminus = 0
}
itemplus = {}
itemminus = {}

function item.load()
  item.width = item.speed_plus:getWidth()
  item.height = item.speed_plus:getHeight()
end
function itemplus.spawn()
  table.insert(itemplus, {
      px = love.math.random(player1.distance_border,map_width - player1.distance_border - 30), 
      py = love.math.random(20 + distance_top,distance_top + map_height - player1.distance_border*3), 
      width = item.width, 
      height = item.height
    })
end

function itemminus.spawn()
table.insert(itemminus, {
    px = love.math.random(player1.distance_border,map_width - player1.distance_border - 30), 
    py = love.math.random(20 + distance_top,distance_top + map_height - player1.distance_border*3), 
    width = item.width,
    height = item.height
  })
end
function item.collision()
  if #itemplus ~= 0 then
    if checkCollision(player1, itemplus[1]) then
      table.remove(itemplus, 1)
      item.timeplus = 0
    end
  end
  if #itemminus ~= 0 then
    if checkCollision(player1, itemminus[1]) then
        table.remove(itemminus, 1)
        item.timeminus = 0
    end
  end
end
function item.update(dt)
  item.timeplus = item.timeplus + dt
  item.timeminus = item.timeminus + dt
  if #itemplus == 0 and item.timeplus >= 3 then -- caso haja 0 itens no mapa, ele spawnará um item, caso haja >0, não spawnará nada
    itemplus.spawn()
  end
  if #itemminus == 0 and item.timeminus >= 3 then
    itemminus.spawn()
  end
  if #itemplus == 0 and item.timeplus >=0 and item.timeplus <= 15 then
    if player1.factor_vel == 1 then
      player1.factor_vel = 2
    else
      player1.factor_vel = 1
    end
  elseif #itemminus == 0 and item.timeminus >=0 and item.timeminus <= 15 then
    if player1.factor_vel == 1 then
      player1.factor_vel = 0.5
    else
      player1.factor_vel = 1
    end
  else
    player1.factor_vel = 1
  end
end
function item.draw()
  for i,v in ipairs(itemplus) do
    love.graphics.draw(item.speed_plus, v.px, v.py)
  end
  for i,v in ipairs(itemminus) do
    love.graphics.draw(item.speed_minus, v.px, v.py)
  end
end