
local mapa1= require("map")
local mapa2= require("map2")
local fase_state = mapa1
local tile_dirt = {}
local tile_grass = {}
local tile_plataforma = {}
local tile_stone = {}
local collision = {
  collided = false,
  faseID = 1
} 

function collision.changeToCave()
  fase_state = mapa2
  collision.faseID = 2
end

function collision.CheckBoxCollision(x1,y1,w1,h1,x2,y2,w2,h2) 
      return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end


function collision.load()

  --if fase_state == mapa1 then
--Criação da Tabela de tiles
	for i=1, 27, 1 do
    for j=1, 48, 1 do
 			if (mapa1[i][j] == "P") then
 				table.insert(tile_dirt, { tileX = (j-1)*34, tileY= (i-1)*34, width = 34, height = 34 })
			end
        if (mapa1[i][j] == "G") then
          table.insert(tile_grass, { tileX = (j-1)*34, tileY= (i-1)*34, width = 34, height = 34 })
        end
          if (mapa1[i][j] == "C") then
           table.insert(tile_plataforma, { tileX = (j-1)*34, tileY= (i-1)*34, width = 34, height = 34 })
          end
		end
	end
--elseif 
  --fase_state == mapa2 then
  for i=1, 27, 1 do
    for j=1, 48, 1 do
 			if (mapa2[i][j] == "P") then
 				table.insert(tile_stone, { tileX = (j-1)*34, tileY= (i-1)*34, width = 34, height = 34 })
			end
		end
	end
--end
end

function collision.update()

 --[[ player.collided = false
  if fase_state==mapa1 then
	for i=1, #tile_dirt do
    -- Confere se está colidindo
    if collision.CheckBoxCollision(player.x + player.moveX, player.y + player.moveY, player.w, player.h, tile_dirt[i].tileX , tile_dirt[i].tileY, tile_dirt[i].width, tile_dirt[i].height) then 
			player.collided=true
    end
	end 
elseif fase_state==mapa2 then
  	for i=1, #tile_stone do
    -- Confere se está colidindo
    if collision.CheckBoxCollision(player.x + player.moveX, player.y + player.moveY, player.w, player.h, tile_stone[i].tileX , tile_stone[i].tileY, tile_stone[i].width, tile_stone[i].height) then 
			player.collided=true
end
end
end--]]
end

function collision.checkCollision(x, y, w, h)
  collision.collided = false
  if fase_state==mapa1 then
    for i=1, #tile_dirt do
      -- Confere se está colidindo
      if collision.CheckBoxCollision(x, y, w, h, tile_dirt[i].tileX , tile_dirt[i].tileY, tile_dirt[i].width, tile_dirt[i].height) then 
        collision.collided=true
      end
    end
      for i=1, #tile_grass do
        if collision.CheckBoxCollision(x, y, w, h, tile_grass[i].tileX , tile_grass[i].tileY, tile_grass[i].width, tile_grass[i].height) then 
          collision.collided=true
        end 
      end
        for i=1, #tile_plataforma do
            if collision.CheckBoxCollision(x, y, w, h, tile_plataforma[i].tileX , tile_plataforma[i].tileY, tile_plataforma[i].width, tile_plataforma[i].height) then 
          collision.collided=true
          end
        end  
  elseif fase_state==mapa2 then
    for i=1, #tile_stone do
      -- Confere se estÃ¡ colidindo
      if collision.CheckBoxCollision(x, y, w, h, tile_stone[i].tileX , tile_stone[i].tileY, tile_stone[i].width, tile_stone[i].height) then 
        collision.collided=true
      end
    end
  end
  
  return collision.collided;
end

function collision.draw(x, y, w, h)
  if fase_state==mapa1 then
   for i=1, #tile_dirt do
  love.graphics.rectangle("line", tile_dirt[i].tileX, tile_dirt[i].tileY, tile_dirt[i].width, tile_dirt[i].height)
  
end 
       for i=1,#tile_grass do
         love.graphics.rectangle("line", tile_grass[i].tileX, tile_grass[i].tileY, tile_grass[i].width, tile_grass[i].height)
       end
    for i=1,#tile_plataforma do
       love.graphics.rectangle("line", tile_plataforma[i].tileX, tile_plataforma[i].tileY, tile_plataforma[i].width, tile_plataforma[i].height)
    end
elseif fase_state==mapa2 then
  for i=1, #tile_stone do
    love.graphics.rectangle("line", tile_stone[i].tileX, tile_stone[i].tileY,           tile_stone[i].width, tile_stone[i].height)
  end
end
  if collision.collided == true then 
   -- love.graphics.setColor( 255 , 0, 0) 
  else 
    love.graphics.setColor( 255, 255, 255) 
  end 
   love.graphics.rectangle("line", x, y, w, h)
    --love.graphics.polygon ("line", x , y , x+ w ,y , x + w , y + h , x , y + h )
end
return collision