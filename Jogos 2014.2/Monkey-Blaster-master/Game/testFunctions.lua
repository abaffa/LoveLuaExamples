--testfunctions.lua

function showTestText()
  for i,v in ipairs(player) do
    love.graphics.print(v.x, v.x+30, v.y-30)
    love.graphics.print(v.y, v.x+30, v.y+30)
    love.graphics.print(v.xvel, v.x+200, v.y-30)
    love.graphics.print(v.yvel, v.x+200, v.y+30)
    love.graphics.print(hue, v.x+30, v.y+90)
    love.graphics.print(v.yvel, 400, 400)
    love.graphics.print(HAHA,500,400)
  end
end

function showCollision()
  for i=upperTileX-size,finalX+size,5 do
    for j=upperTileY-size,finalY+size,5 do
        if(solidb[i][j]==3) then
          love.graphics.setColor(40,220,40)
        elseif(solidb[i][j]==0) then
          love.graphics.setColor(255,255,255)
        elseif(solidb[i][j]==2) then
          love.graphics.setColor(40,40,220)
        elseif(solidb[i][j]==1) then
          love.graphics.setColor(220,40,40)
        else
          love.graphics.setColor(200,150,100)
        end
          love.graphics.circle("fill",i,j,2,5)
    end
  end
end


function showHitBox()
  for i,v in ipairs(player) do
    if i>quantPlayer then break end
    if not v.dead then
      love.graphics.rectangle("line",v.x,v.y,v.width,v.height)
      love.graphics.rectangle("line",v.centerx,v.centery,v.width/2,v.height/2)
      love.graphics.setColor(220,0,0)
      love.graphics.circle("fill",v.x,v.y,2,10)
      love.graphics.circle("fill",v.x+v.width/2,v.y+v.height/2,2,10)
      love.graphics.rectangle("line",qx[i],qy[i],size,size)
    end
  end
end

function updateHitBox()
  for i,v in ipairs(player) do
    if i>quantPlayer then break end
    if not v.dead then
      qx[i],qy[i]=check_grid_position(v.x+v.width/2,v.y+v.height/2)
      qx[i]=upperTileX+size*qx[i] qy[i]=upperTileY+size*qy[i]
    end
  end
end