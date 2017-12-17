i = 0
j = 0
k = 0
l = 0
tamx = 14
tamy = 12  --MUDAR SIZE O JOGAR PRA 12 / 10  ??
--size = upperTileX*8/tam
maze = {}
maze.enemyQntd={}

solidb = {}
destruct = {}
exit = {}

function prepareUpper()
	upperTileX = math.floor(love.graphics.getWidth()/2-(tamx+1)*size/2)
	upperTileY = math.floor(love.graphics.getHeight()/2-(tamy+1)*size/2)
  finalX=upperTileX+size*(tamx+1)
	finalY=upperTileY+size*(tamy+1)
  for i=1, quantPlayer do
    initial.x = {}
    initial.y = {}
  end
  initial.x[1] = upperTileX+5
	initial.y[1] = upperTileY+5
  initial.x[2] = finalX - size +5
	initial.y[2] = upperTileY+5
  initial.x[3] = upperTileX+5
	initial.y[3] = finalY - size +5
  initial.x[4] = finalX - size +5
	initial.y[4] = finalY - size +5
  
end

function maze.load(quantBlock)
	--size = upperTileX*8/tam
	for i=0, 800 do
		solidb[i]={}
		for j=0, 750 do
			solidb[i][j]=1
		end
	end
	for i=0, tamx do
		maze[i] = {}
		for j=0, tamy do
			if(i%2==0 or j%2==0) then
				maze[i][j]=0
				for k=i*size, (i+1)*size-1 do
					for l=j*size, (j+1)*size-1 do
						solidb[k+upperTileX][l+upperTileY]=0
					end
				end
      else
        maze[i][j]=1
			end
		end
	end
  --for i=upperTileX, finalX, size do
    --solidb[i][upperTileY]=1
    --solidb[i][
  --end
  maze_generate_blocks(quantBlock)
  if not versus then
    maze_generate_enemies()
  end
end

function maze_draw()
	love.graphics.setColor(255,255,255)
	draw_grid()
	draw_wall()
end

function draw_grid()
	for i=0, tamx do
		for j=0, tamy do
			if(maze[i][j]==1) then
				--love.graphics.rectangle("fill",size*i+upperTileX,size*j+upperTileY,size,size)
				love.graphics.draw(maze.image, size*i+upperTileX,size*j+upperTileY,0,maze.imageWidth,maze.imageHeight)
			elseif(maze[i][j]==0) then
				love.graphics.draw(maze.floor, size*i+upperTileX, size*j+upperTileY,0,maze.floorWidth,maze.floorHeight)
      else
        if(maze[i][j]==5) then
          love.graphics.draw(maze.floor, size*i+upperTileX, size*j+upperTileY,0,maze.floorWidth,maze.floorHeight)
          love.graphics.setColor(240,20,20)
          love.graphics.draw(maze.block,size*i+upperTileX, size*j+upperTileY, 0, maze.blockWidth, maze.blockHeight)
          love.graphics.setColor(255,255,255)
        else
          love.graphics.draw(maze.floor, size*i+upperTileX, size*j+upperTileY,0,maze.floorWidth,maze.floorHeight)
          love.graphics.draw(maze.block,size*i+upperTileX, size*j+upperTileY, 0, maze.blockWidth, maze.blockHeight)
        end
      end
		end
	end
  if not versus and fase~=lastFase then
    if maze[exit.i][exit.j]==0 then
      if maze.enemyTotal==0 then
        love.graphics.draw(maze.portal,exit.x,exit.y,0,maze.portalWidth,maze.portalHeight)
      else
        love.graphics.setColor(200,20,20)
        love.graphics.draw(maze.portal,exit.x,exit.y,0,maze.portalWidth,maze.portalHeight)
        love.graphics.setColor(255,255,255)
      end
    else
      love.graphics.rectangle("fill",exit.x,exit.y,20,20)  --NAO DESENHAR NADA
    end
  end
end

function draw_wall()
	for i=-1, tamy+1 do  -- Relativo a diferenca entre os tamanhos horizontal e vertical
		love.graphics.draw(maze.wallx, size*i+upperTileX, upperTileY-size, 0, maze.wallxWidth, maze.wallxHeight) --cima
		love.graphics.draw(maze.wallx, size*i+upperTileX+size/2, finalY+size/2, math.pi, maze.wallxWidth, maze.wallxHeight, maze.wallx:getWidth()/2, maze.wally:getHeight()/2) --baixo
		love.graphics.draw(maze.wally, finalX+size/2, size*i+upperTileY+size/2, math.pi, maze.wallyWidth, maze.wallyHeight, maze.wallx:getWidth()/2, maze.wally:getHeight()/2) --direita
		love.graphics.draw(maze.wally, upperTileX-size, size*i+upperTileY, 0, maze.wallyWidth, maze.wallyHeight) --esquerda
	end
	for i=tamy+2, tamx do
		love.graphics.draw(maze.wallx, size*i+upperTileX, upperTileY-size, 0, maze.wallxWidth, maze.wallxHeight) --cima
		love.graphics.draw(maze.wallx, size*i+upperTileX+size/2, finalY+size/2, math.pi, maze.wallxWidth, maze.wallxHeight,maze.wallx:getWidth()/2, maze.wallx:getHeight()/2) --chao
	end
end

function maze_generate_blocks(quantDestruct)
  nLinha = tamy+1
  nCol = tamx+1  --para teste
  for j=0, tamy do
    for i=0, tamx do
      if (i%2==0 or j%2==0) then
        --table.insert(destruct,{num=i*nCol+j})
        table.insert(destruct,{i=i,j=j})
      end
    end
  end
  table.remove(destruct,#destruct-tamx+1) -- 3 player
  table.remove(destruct,#destruct-tamx+1) -- 3 player
  table.remove(destruct,#destruct-tamx-math.ceil(tamx/2)+1) -- 3 player
  table.remove(destruct,#destruct-tamx+1) -- 4 player
  table.remove(destruct,#destruct) -- 4 player
  table.remove(destruct,#destruct) -- 4 player
  table.remove(destruct,tamx + math.ceil(tamx/2) + 2) -- 2 player
  table.remove(destruct,tamx+2) -- 1 player
  table.remove(destruct,tamx+1) -- 2 player
  table.remove(destruct,tamx) -- 2 player
  table.remove(destruct,2) -- 1 player
  table.remove(destruct,1) -- 1 player           remoções de posição inicial
  quantTable = #destruct
  for cont=1, quantDestruct do
    randBlock=table.remove(destruct,math.random(1,quantTable))
    quantTable = quantTable - 1
    change_maze_space(randBlock.i, randBlock.j, 4)
    table.insert(exit, randBlock)
  end
  randBlock = table.remove(exit,math.random(1,#exit))
  if randBlock ~= nil and not versus and fase~=lastFase then
    generatePortal(randBlock)
  end
  for i,v in ipairs(exit) do
    table.remove(exit,i)
  end
end

function change_maze_space(mazeX, mazeY, modifier)
  maze[mazeX][mazeY]=modifier
  for i=size*mazeX, size*(mazeX+1)-1 do
    for j=size*mazeY, size*(mazeY+1)-1 do
      solidb[upperTileX+i][upperTileY+j]=modifier
    end
  end
end

function change_space(x,y,modifier)
  for i=x, x+size-1 do
    for j=y, y+size-1 do
      solidb[i][j]=modifier
    end
  end
end

function generatePortal(v)
  exit.x=v.i*size+upperTileX
  exit.y=v.j*size+upperTileY
  exit.i=v.i
  exit.j=v.j
end

function maze_generate_enemies()
  quantTable = #destruct
  for i=1, enemy.qntd do
    quant=maze.enemyQntd[i]
    for cont=1, quant do
      randBlock=table.remove(destruct,math.random(1,quantTable))
      quantTable = quantTable - 1
      enemy.spawn(randBlock.i, randBlock.j, i, i%2, (i+1)%2)
    end
  end
  i=1
  while #destruct>0 do
    table.remove(destruct, i)
  end
  maze.enemyTotal = #enemy
end