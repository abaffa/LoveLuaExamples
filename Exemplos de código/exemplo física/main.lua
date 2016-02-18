local mapa = {}
local tilesetImage
local chicken
local tileQuads = {}
local tileSize = 64
local force = 100

function LoadTiles(filename, nx, ny)
  tilesetImage = love.graphics.newImage(filename)
  local count = 1
  for i = 0, nx, 1 do
    for j = 0, ny, 1 do
      tileQuads[count] = love.graphics.newQuad(i * tileSize, 
                                      j * tileSize, tileSize, tileSize,
                                      tilesetImage:getWidth(),
                                      tilesetImage:getHeight())
      count = count + 1
    end
  end
end

function LoadMap(filename)   
  local file = io.open(filename)
  local i = 1
  love.physics.setMeter(64) 
  world = love.physics.newWorld(0, 9.81*64, true)
  for line in file:lines() do
    mapa[i] = {}
    for j=1, #line, 1 do
      local t = line:sub(j,j)      
      if t == "G" or t == "T" then
        mapa[i][j] = {}
        mapa[i][j].body = love.physics.newBody(world, (j * tileSize) - tileSize, (i * tileSize) - tileSize)
        mapa[i][j].shape = love.physics.newRectangleShape(tileSize, tileSize)
        mapa[i][j].fixture = love.physics.newFixture(mapa[i][j].body , mapa[i][j].shape)
        mapa[i][j].tile = t  
      elseif t == "B" then
        mapa[i][j] = {}
        mapa[i][j].body = love.physics.newBody(world, (j * tileSize) - tileSize, (i * tileSize) - tileSize, "dynamic")
        mapa[i][j].shape = love.physics.newRectangleShape(0, 0, tileSize, tileSize)
        mapa[i][j].fixture = love.physics.newFixture(mapa[i][j].body , mapa[i][j].shape, 2)
        mapa[i][j].tile = t
      else
        mapa[i][j] = {}
        mapa[i][j].tile = t 
      end      
    end
    i = i + 1
  end
  file:close()
end

function love.load()
  LoadMap("plataform_map.txt")
  LoadTiles("plataform_tileset.png", 2, 2)
  chicken = love.graphics.newImage("chicken.png")
  love.graphics.setBackgroundColor(152,209,250)  
  chicken_body = {}
  chicken_body.body = love.physics.newBody(world, 300, 100, "dynamic") 
  chicken_body.shape = love.physics.newCircleShape(64) 
  chicken_body.fixture = love.physics.newFixture(chicken_body.body, chicken_body.shape, 0.3)
  chicken_body.fixture:setRestitution(0.9)
  chicken_body.body:setPosition(10, 200) 
  chicken_body.body:setActive(false)  
end

function love.keyreleased(key)
  if key == " " then
    chicken_body.body:applyForce(force, 0)
    force = 100
  end  
end

function love.update(dt)
  world:update(dt)   
  if love.keyboard.isDown(" ") then
    chicken_body.body:setActive(true)
    chicken_body.body:setPosition(10, 200) 
    chicken_body.body:setLinearVelocity(0, 0)
    force = force + 800    
  end   
end

function love.draw()
  for i=1, 10, 1 do    
    for j=1, 14, 1 do      
      if (mapa[i][j].tile == "G") then
        love.graphics.draw(tilesetImage, tileQuads[1], mapa[i][j].body:getX(), mapa[i][j].body:getY(), mapa[i][j].body:getAngle(), 1,1,tileSize/2,tileSize/2)
      elseif (mapa[i][j].tile == "T") then
        love.graphics.draw(tilesetImage, tileQuads[4], mapa[i][j].body:getX(), mapa[i][j].body:getY(), mapa[i][j].body:getAngle(), 1,1,tileSize/2,tileSize/2)
      elseif (mapa[i][j].tile == "B") then
        love.graphics.draw(tilesetImage, tileQuads[6], mapa[i][j].body:getX(), mapa[i][j].body:getY(), mapa[i][j].body:getAngle(),1,1,tileSize/2,tileSize/2)    
      end
    end
  end  
  love.graphics.draw(chicken, chicken_body.body:getX(), chicken_body.body:getY())
  
end
