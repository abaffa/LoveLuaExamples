local characters = {}

local title = 'CHOOSE A CHARACTER'

local id = 1

local boy = {
   image,
   scale = 0.5,
   x = 100,
   y = 100,
   name = 'KURO',
   x_name = 390,
   y_name = 200
 }

local girl = {
   image,
   x_scale = 0.425,
   y_scale = 0.44,
   x = 97,
   y = 350,
   name = 'HIKARI',
   x_name = 370,
   y_name = 450
 }
 
 local rectangle = {
   x = 87,
   y = 90,
   w = 150,
   h = 240
 }

function characters.load()
  love.graphics.setBackgroundColor(130, 34, 116)
  
  boy.image = love.graphics.newImage('kuro.png')
  girl.image = love.graphics.newImage('hikari.png')
end

function characters.update(dt)
end

function characters.keypressed(key)
  if key == 'down' then
    rectangle.y = 340
    id = 2
  end
  
  if key == 'up' then
    rectangle.y = 90
    id = 1
  end
  
  if key == 'return' then
    love.audio.stop(menu_music)
   ChangeToGame(id)
  end
end

function characters.draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.setNewFont(30)
  love.graphics.print(title, 335, 20)
  
  love.graphics.setNewFont(60)
  love.graphics.print(girl.name, girl.x_name, girl.y_name)
  love.graphics.print(boy.name, boy.x_name, boy.y_name)
  love.graphics.rectangle('line', rectangle.x, rectangle.y, rectangle.w, rectangle.h)
  
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(boy.image, boy.x, boy.y, 0, boy.scale, boy.scale)
  love.graphics.draw(girl.image, girl.x, girl.y, 0, girl.x_scale, girl.y_scale)
end

return characters