icemagic = {
  speed = 300,
}
iball = {}
iball[1] =love.graphics.newImage("knight walk/mage/icemagic.png")
iball[2] =love.graphics.newImage("knight walk/mage/icemagic1.png")
iball[3] =love.graphics.newImage("knight walk/mage/icemagic2.png")
iball[4] =love.graphics.newImage("knight walk/mage/icemagic3.png")
iball.pic = iball[1]
iball[5]=love.graphics.newImage("knight walk/mage/explosao gelo1.png")
iball[6]=love.graphics.newImage("knight walk/mage/explosao gelo2.png")
iball[7]=love.graphics.newImage("knight walk/mage/explosao gelo3.png")
iball[8]=love.graphics.newImage("knight walk/mage/explosao gelo4.png")
iball[9]=love.graphics.newImage("knight walk/mage/explosao gelo5.png")
iball[10] =love.graphics.newImage("knight walk/mage/explosao gelo6.png")
iball[11] =love.graphics.newImage("knight walk/mage/explosao gelo7.png")
iball[12]=love.graphics.setColor(255,255,255)
 
 function icemagic.spawn(x,y,dir)
  table.insert(icemagic,{x=x,y=y,dir=dir,anitimer=0,num=1,hitbox = Collider:addRectangle(x,y,69,80)})
end
function icemagic.draw()
  for i,v in ipairs(icemagic) do
    if v.dir == 1 then
    if v.num == 1 then
      love.graphics.draw(iball[1], v.x, v.y, 0 , v.dir,1)
    elseif v.num == 2 then
      love.graphics.draw(iball[2], v.x, v.y, 0 , v.dir,1)
    elseif v.num == 3 then
      love.graphics.draw(iball[3], v.x, v.y, 0 , v.dir,1)
    elseif v.num == 4 then
      love.graphics.draw(iball[4], v.x, v.y, 0 , v.dir,1)
    elseif v.num == 5 then
      love.graphics.draw(iball[5], v.x+25, v.y+10, 0 , v.dir,1,iball[5]:getWidth()/2,iball[5]:getHeight()/2)
    elseif v.num == 6 then
      love.graphics.draw(iball[6],v.x+25, v.y+10, 0 , v.dir,1,iball[6]:getWidth()/2,iball[6]:getHeight()/2)
    elseif v.num == 7 then
      love.graphics.draw(iball[7], v.x+25, v.y+10, 0 , v.dir,1,iball[7]:getWidth()/2,iball[7]:getHeight()/2)
    elseif v.num == 8 then
      love.graphics.draw(iball[8], v.x+25, v.y+10, 0 , v.dir,1,iball[8]:getWidth()/2,iball[8]:getHeight()/2)
    elseif v.num == 9 then
      love.graphics.draw(iball[9], v.x+25, v.y+10, 0 , v.dir,1,iball[9]:getWidth()/2,iball[9]:getHeight()/2)
    elseif v.num == 10 then
      love.graphics.draw(iball[10], v.x+25, v.y+10, 0 , v.dir,1,iball[10]:getWidth()/2,iball[10]:getHeight()/2)
    elseif v.num == 11 then
      love.graphics.draw(iball[11], v.x+25, v.y+10, 0 , v.dir,1,iball[11]:getWidth()/2,iball[11]:getHeight()/2)
    end  
  end
  if v.dir == -1 then
    if v.num == 1 then
      love.graphics.draw(iball[1], v.x, v.y, 0 , v.dir,1)
    elseif v.num == 2 then
      love.graphics.draw(iball[2], v.x, v.y, 0 , v.dir,1)
    elseif v.num == 3 then
      love.graphics.draw(iball[3], v.x, v.y, 0 , v.dir,1)
    elseif v.num == 4 then
      love.graphics.draw(iball[4], v.x, v.y, 0 , v.dir,1)
    elseif v.num == 5 then
      love.graphics.draw(iball[5], v.x-25, v.y+10, 0 , v.dir,1,iball[5]:getWidth()/2,iball[5]:getHeight()/2)
    elseif v.num == 6 then
      love.graphics.draw(iball[6], v.x-25, v.y+10, 0 , v.dir,1,iball[6]:getWidth()/2,iball[6]:getHeight()/2)
    elseif v.num == 7 then
      love.graphics.draw(iball[7], v.x-25, v.y+10, 0 , v.dir,1,iball[7]:getWidth()/2,iball[7]:getHeight()/2)
    elseif v.num == 8 then
      love.graphics.draw(iball[8], v.x-25, v.y+10, 0 , v.dir,1,iball[8]:getWidth()/2,iball[8]:getHeight()/2)
    elseif v.num == 9 then
      love.graphics.draw(iball[9], v.x-25, v.y+10, 0 , v.dir,1,iball[9]:getWidth()/2,iball[9]:getHeight()/2)
    elseif v.num == 10 then
      love.graphics.draw(iball[10], v.x-25, v.y+10, 0 , v.dir,1,iball[10]:getWidth()/2,iball[10]:getHeight()/2)
    elseif v.num == 11 then
      love.graphics.draw(iball[11], v.x-25, v.y+10, 0 , v.dir,1,iball[11]:getWidth()/2,iball[11]:getHeight()/2)
    end  
  end
  end
end
function icemagic.update(dt) 
  for i,v in ipairs(icemagic) do
    if v.dir == 1 then
      v.hitbox.type = "icemagic"
      iball.pic = iball[v.num]
      v.anitimer = v.anitimer + dt
      if v.anitimer > 0.1 then 
        v.num = v.num + 1
        v.anitimer = 0
      end
      if v.num < 4 then
        v.x = v.x + icemagic.speed*dt
        v.hitbox:move(icemagic.speed*dt,0)
      end
      if v.num > 11 then
        icemagic.speed = 300
        v.dir = 0
        Collider:remove(v.hitbox)
      end
    end
    if v.dir == -1 then
      v.hitbox.type = "icemagic"
      iball.pic = iball[v.num]
      v.anitimer = v.anitimer + dt
      if v.anitimer > 0.1 then 
        v.num = v.num + 1
        v.anitimer = 0
      end
      if v.num < 4 then
        v.x = v.x - icemagic.speed*dt
        v.hitbox:move(-icemagic.speed*dt,0)
      end
      if v.num > 11 then
        icemagic.speed = 300
        v.dir = 0
        Collider:remove(v.hitbox)
      end
    end
  end
end