--stages.lua
stage={}
stage.quant=5
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
  maze.wallx = stage[id].wallx
  maze.wallxWidth = stage[id].wallxWidth
  maze.wallxHeight = stage[id].wallxHeight
  maze.wally = stage[id].wally
  maze.wallyWidth = stage[id].wallyWidth
  maze.wallyHeight = stage[id].wallyHeight
  maze.block=stage[id].block
  maze.blockWidth = stage[id].blockWidth
  maze.blockHeight = stage[id].blockHeight
  maze.blockQuant = stage[id].blockQuant
  for i=1, enemy.qntd do
    maze.enemyQntd[i]=stage[id].enemyQntd[i]
  end
  maze.load(maze.blockQuant)
  audio.play(id) -- ARRUMAR PARA ID
end

function stage.infoLoad()
  for i=1, stage.quant do
    stage[i]={}
    for j=1, enemy.qntd do
      stage[i].enemyQntd={}
    end
  end
  maze.portal=love.graphics.newImage("/Source/Stage/portal.png")
  maze.portalWidth = size/maze.portal:getWidth()
  maze.portalHeight = size/maze.portal:getHeight()
  
  stage[1].image =love.graphics.newImage("/Source/Stage/img_01.png")
  stage[1].imageWidth = size/stage[1].image:getWidth()
  stage[1].imageHeight = size/stage[1].image:getHeight()
  stage[1].floor = love.graphics.newImage("Source/Stage/floor_01.png")
  stage[1].floorWidth = size/stage[1].floor:getWidth()
  stage[1].floorHeight = size/stage[1].floor:getHeight()
  stage[1].wallx = love.graphics.newImage("Source/Stage/wall_01.png")
  stage[1].wallxWidth = size/stage[1].wallx:getWidth()
  stage[1].wallxHeight = size/stage[1].wallx:getHeight()
  stage[1].wally = love.graphics.newImage("Source/Stage/wall_01.png")
  stage[1].wallyWidth = size/stage[1].wally:getWidth()
  stage[1].wallyHeight = size/stage[1].wally:getHeight()
  stage[1].block=love.graphics.newImage("/Source/Stage/block_01.png")
  stage[1].blockWidth = size/stage[1].block:getWidth()
  stage[1].blockHeight = size/stage[1].block:getHeight()
  stage[1].music = love.audio.newSource("Go Cart.mp3")
  stage[1].blockQuant = 60
  stage[1].enemyQntd[1] = 4
  stage[1].enemyQntd[2] = 0
  stage[1].enemyQntd[3] = 0
  stage[1].enemyQntd[4] = 0
  
  stage[2].image =love.graphics.newImage("/Source/Stage/img_02.png")
  stage[2].imageWidth = size/stage[2].image:getWidth()
  stage[2].imageHeight = size/stage[2].image:getHeight()
  stage[2].floor = love.graphics.newImage("Source/Stage/floor_02.png")
  stage[2].floorWidth = size/stage[2].floor:getWidth()
  stage[2].floorHeight = size/stage[2].floor:getHeight()
  stage[2].wallx = love.graphics.newImage("Source/Stage/wallx_02.png")
  stage[2].wallxWidth = size/stage[2].wallx:getWidth()
  stage[2].wallxHeight = size/stage[2].wallx:getHeight()
  stage[2].wally = love.graphics.newImage("Source/Stage/wally_02.png")
  stage[2].wallyWidth = size/stage[2].wally:getWidth()
  stage[2].wallyHeight = size/stage[2].wally:getHeight()
  stage[2].block=love.graphics.newImage("/Source/Stage/block_02.png")
  stage[2].blockWidth = size/stage[2].block:getWidth()
  stage[2].blockHeight = size/stage[2].block:getHeight()
  stage[2].music = love.audio.newSource("/Source/GameOstwip_64kb_mp3/ccc2_64kb.mp3")
  stage[2].blockQuant = 60
  stage[2].enemyQntd[1] = 2
  stage[2].enemyQntd[2] = 3
  stage[2].enemyQntd[3] = 0
  stage[2].enemyQntd[4] = 0
  
  stage[3].image =love.graphics.newImage("/Source/Stage/img_03.png")
  stage[3].imageWidth = size/stage[3].image:getWidth()
  stage[3].imageHeight = size/stage[3].image:getHeight()
  stage[3].floor = love.graphics.newImage("Source/Stage/floor_03.png")
  stage[3].floorWidth = size/stage[3].floor:getWidth()
  stage[3].floorHeight = size/stage[3].floor:getHeight()
  stage[3].wallx = love.graphics.newImage("Source/Stage/wallx_03.png")
  stage[3].wallxWidth = size/stage[3].wallx:getWidth()
  stage[3].wallxHeight = size/stage[3].wallx:getHeight()
  stage[3].wally = love.graphics.newImage("Source/Stage/wally_03.png")
  stage[3].wallyWidth = size/stage[3].wally:getWidth()
  stage[3].wallyHeight = size/stage[3].wally:getHeight()
  stage[3].block=love.graphics.newImage("/Source/Stage/block_03.png")
  stage[3].blockWidth = size/stage[3].block:getWidth()
  stage[3].blockHeight = size/stage[3].block:getHeight()
  stage[3].music = love.audio.newSource("/Source/GameOstwip_64kb_mp3/aaa_64kb.mp3")
  stage[3].blockQuant = 60
  stage[3].enemyQntd[1] = 1
  stage[3].enemyQntd[2] = 2
  stage[3].enemyQntd[3] = 2
  stage[3].enemyQntd[4] = 0
  
  stage[4].image =love.graphics.newImage("/Source/Stage/img_04.png")
  stage[4].imageWidth = size/stage[4].image:getWidth()
  stage[4].imageHeight = size/stage[4].image:getHeight()
  stage[4].floor = love.graphics.newImage("Source/Stage/floor_04.png")
  stage[4].floorWidth = size/stage[4].floor:getWidth()
  stage[4].floorHeight = size/stage[4].floor:getHeight()
  stage[4].wallx = love.graphics.newImage("Source/Stage/wallx_04.png")
  stage[4].wallxWidth = size/stage[4].wallx:getWidth()
  stage[4].wallxHeight = size/stage[4].wallx:getHeight()
  stage[4].wally = love.graphics.newImage("Source/Stage/wally_04.png")
  stage[4].wallyWidth = size/stage[4].wally:getWidth()
  stage[4].wallyHeight = size/stage[4].wally:getHeight()
  stage[4].block=love.graphics.newImage("/Source/Stage/block_04.png")
  stage[4].blockWidth = size/stage[4].block:getWidth()
  stage[4].blockHeight = size/stage[4].block:getHeight()
  stage[4].music = love.audio.newSource("/Source/GameOstwip_64kb_mp3/aaa_64kb.mp3")
  stage[4].blockQuant = 60
  stage[4].enemyQntd[1] = 0
  stage[4].enemyQntd[2] = 2
  stage[4].enemyQntd[3] = 2
  stage[4].enemyQntd[4] = 3
  
  stage[5].image =love.graphics.newImage("/Source/Stage/img_04.png")
  stage[5].imageWidth = size/stage[5].image:getWidth()
  stage[5].imageHeight = size/stage[5].image:getHeight()
  stage[5].floor = love.graphics.newImage("Source/Stage/floor_04.png")
  stage[5].floorWidth = size/stage[5].floor:getWidth()
  stage[5].floorHeight = size/stage[5].floor:getHeight()
  stage[5].wallx = love.graphics.newImage("Source/Stage/wallx_04.png")
  stage[5].wallxWidth = size/stage[5].wallx:getWidth()
  stage[5].wallxHeight = size/stage[5].wallx:getHeight()
  stage[5].wally = love.graphics.newImage("Source/Stage/wally_04.png")
  stage[5].wallyWidth = size/stage[5].wally:getWidth()
  stage[5].wallyHeight = size/stage[5].wally:getHeight()
  stage[5].block=love.graphics.newImage("/Source/Stage/block_04.png")
  stage[5].blockWidth = size/stage[5].block:getWidth()
  stage[5].blockHeight = size/stage[5].block:getHeight()
  stage[5].music = love.audio.newSource("/Source/sounds/Sonic3ChaosAngelAct3.mp3")
  stage[5].blockQuant = 0
  stage[5].enemyQntd[1] = 0
  stage[5].enemyQntd[2] = 0
  stage[5].enemyQntd[3] = 0
  stage[5].enemyQntd[4] = 0
  
end