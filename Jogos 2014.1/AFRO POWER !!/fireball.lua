
fireball = {
  speed = 300,
}
fball = {}
fball[1] =love.graphics.newImage("knight walk/mage/fireballR.png")
fball[2] =love.graphics.newImage("knight walk/mage/fireball1R.png")
fball[3] =love.graphics.newImage("knight walk/mage/fireball2R.png")
fball[4] =love.graphics.newImage("knight walk/mage/fireball3R.png")
fball.pic = fball[1]
fball[5]=love.graphics.newImage("knight walk/mage/explosao1.png")
fball[6]=love.graphics.newImage("knight walk/mage/explosao2.png")
fball[7]=love.graphics.newImage("knight walk/mage/explosao3.png")
fball[8]=love.graphics.newImage("knight walk/mage/explosao4.png")
fball[9]=love.graphics.newImage("knight walk/mage/explosao5.png")
fball[10] =love.graphics.newImage("knight walk/mage/explosao6.png")
fball[11] =love.graphics.newImage("knight walk/mage/explosao7.png")
fball[12]=love.graphics.setColor(255,255,255)
 --fball.num = 1
 --fball.anitimer = 0
 function fireball.spawn(x,y,dir)
  table.insert(fireball,{x=x,y=y,dir=dir,anitimer=0,num=1,hitbox = Collider:addRectangle(x,y,23,10)})
end
function fireball.draw()
  for i,v in ipairs(fireball) do
    if v.dir == 1 then
     if v.num == 1 then
      love.graphics.draw(fball[1], v.x, v.y, 0 , v.dir,1)
     elseif v.num == 2 then
      love.graphics.draw(fball[2], v.x, v.y, 0 , v.dir,1)
     elseif v.num == 3 then
      love.graphics.draw(fball[3], v.x, v.y, 0 , v.dir,1)
     elseif v.num == 4 then
      love.graphics.draw(fball[4], v.x, v.y, 0 , v.dir,1)
     elseif v.num == 5 then
      love.graphics.draw(fball[5], v.x+25, v.y+10, 0 , v.dir,1,fball[5]:getWidth()/2,fball[5]:getHeight()/2)  
     elseif v.num == 6 then
      love.graphics.draw(fball[6],v.x+25, v.y+10, 0 , v.dir,1,fball[6]:getWidth()/2,fball[6]:getHeight()/2)
     elseif v.num == 7 then
      love.graphics.draw(fball[7], v.x+25, v.y+10, 0 , v.dir,1,fball[7]:getWidth()/2,fball[7]:getHeight()/2)
     elseif v.num == 8 then
      love.graphics.draw(fball[8], v.x+25, v.y+10, 0 , v.dir,1,fball[8]:getWidth()/2,fball[8]:getHeight()/2)
     elseif v.num == 9 then
      love.graphics.draw(fball[9], v.x+25, v.y+10, 0 , v.dir,1,fball[9]:getWidth()/2,fball[9]:getHeight()/2)
     elseif v.num == 10 then
      love.graphics.draw(fball[10], v.x+25, v.y+10, 0 , v.dir,1,fball[10]:getWidth()/2,fball[10]:getHeight()/2)
     elseif v.num == 11 then
      love.graphics.draw(fball[11], v.x+25, v.y+10, 0 , v.dir,1,fball[11]:getWidth()/2,fball[11]:getHeight()/2)
     end
   end
   if v.dir == -1 then 
     if v.num == 1 then
      love.graphics.draw(fball[1], v.x, v.y, 0 , v.dir,1)
     elseif v.num == 2 then
      love.graphics.draw(fball[2], v.x, v.y, 0 , v.dir,1)
     elseif v.num == 3 then
      love.graphics.draw(fball[3], v.x, v.y, 0 , v.dir,1)
     elseif v.num == 4 then
      love.graphics.draw(fball[4], v.x, v.y, 0 , v.dir,1)
     elseif v.num == 5 then
      love.graphics.draw(fball[5], v.x-25, v.y+10, 0 , v.dir,1,fball[5]:getWidth()/2,fball[5]:getHeight()/2)  
     elseif v.num == 6 then
      love.graphics.draw(fball[6], v.x-25, v.y+10, 0 , v.dir,1,fball[6]:getWidth()/2,fball[6]:getHeight()/2)
     elseif v.num == 7 then
      love.graphics.draw(fball[7], v.x-25, v.y+10, 0 , v.dir,1,fball[7]:getWidth()/2,fball[7]:getHeight()/2)
     elseif v.num == 8 then
      love.graphics.draw(fball[8], v.x-25, v.y+10, 0 , v.dir,1,fball[8]:getWidth()/2,fball[8]:getHeight()/2)
     elseif v.num == 9 then
      love.graphics.draw(fball[9], v.x-25, v.y+10, 0 , v.dir,1,fball[9]:getWidth()/2,fball[9]:getHeight()/2)
     elseif v.num == 10 then
      love.graphics.draw(fball[10], v.x-25, v.y+10, 0 , v.dir,1,fball[10]:getWidth()/2,fball[10]:getHeight()/2)
     elseif v.num == 11 then
      love.graphics.draw(fball[11], v.x-25, v.y+10, 0 , v.dir,1,fball[11]:getWidth()/2,fball[11]:getHeight()/2)
     end
     end
  end
end
function fireball.update(dt) 
  for i,v in ipairs(fireball) do
    if v.dir == 1 then
      v.hitbox.type = "fireball"
      fball.pic = fball[v.num]
      v.anitimer = v.anitimer + dt
      if v.anitimer > 0.1 then 
        v.num = v.num + 1
        v.anitimer = 0
      end
      if v.num < 4 then
        v.x = v.x + fireball.speed*dt
        v.hitbox:move(fireball.speed*dt,0)
      end
      if v.num > 11 then
        fireball.speed = 300
        v.dir = 0
        Collider:remove(v.hitbox)
      end
    end
    if v.dir == -1 then
      v.hitbox.type = "fireball"
      fball.pic = fball[v.num]
      v.anitimer = v.anitimer + dt
      if v.anitimer > 0.1 then 
        v.num = v.num + 1
        v.anitimer = 0
      end
      if v.num < 4 then
        v.x = v.x - fireball.speed*dt
        v.hitbox:move(-fireball.speed*dt,0)
      end
      if v.num > 11 then
        fireball.speed = 300
        v.dir = 0
        Collider:remove(v.hitbox)
      end
    end
  end
end