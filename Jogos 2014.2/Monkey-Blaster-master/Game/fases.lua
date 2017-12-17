--stages.lua
stage={}
stage.quant=1
function stage.load2(id)   --cada id será uma fase diferente. stage.load será chamada para carregar cada fase
  if id==1 then
  
  elseif id==2 then

  elseif id==3 then
  
  elseif id==4 then
  
  elseif id==5 then
  
  elseif id==6 then
  
  end
end
function stage.load(id)
  maze.image =stage[id].image
  maze.imageWidth = stage[id].imageWidth
  maze.imageHeight = stage[id].imageHeight
  maze.floor = stage[id].floor
  maze.floorWidth = stage[id].floorWidth
  maze.floorHeight = stage[id].floorHeight
  maze.wall = stage[id].wall
  maze.wallWidth = stage[id].wallWidth
  maze.wallHeight = stage[id].wallHeight
  maze.block=stage[id].block
  maze.blockWidth = stage[id].blockWidth
  maze.blockHeight = stage[id].blockHeight
end
function stage.infoLoad()
  for i=1, stage.quant do
    stage[i]={}
  end
  stage[1].image =love.graphics.newImage("/Source/block.png")
  stage[1].imageWidth = size/stage[1].image:getWidth()
  stage[1].imageHeight = size/stage[1].image:getHeight()
  stage[1].floor = love.graphics.newImage("Source/floor.png")
  stage[1].floorWidth = size/stage[1].floor:getWidth()
  stage[1].floorHeight = size/stage[1].floor:getHeight()
  stage[1].wall = love.graphics.newImage("Source/brick_wall.png")
  stage[1].wallWidth = size/stage[1].wall:getWidth()
  stage[1].wallHeight = size/stage[1].wall:getHeight()
  stage[1].block=love.graphics.newImage("/Source/Ice_Block.png")
  stage[1].blockWidth = size/stage[1].block:getWidth()
  stage[1].blockHeight = size/stage[1].block:getHeight()
  stage[1].music = love.audio.newSource("/Source/GameOstwip_64kb_mp3/aaa_64kb.mp3")
end