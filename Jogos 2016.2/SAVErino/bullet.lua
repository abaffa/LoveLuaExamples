local bullet={
  width = 50,
  height = 50
}

function bullet.spawn(x,y,collided,velx,vely, image)
  table.insert(bullet,{x=x,y=y,collided=collided,velx=velx,vely=vely, image = image})
 end
 
function bullet.load(s_x, s_y)
  stronda_x = s_x
  stronda_y = s_y
  timer = 0 
  image = love.graphics.newImage("whey2.png")
end

function bullet.update(dt)
   timer = timer + dt
   if(timer > 2) then
      for i=1, 24 do
        bullet.spawn(stronda_x, stronda_y, false, love.math.random(1,4)*(-100), love.math.random(1,4)*100, image)
      end
    timer = 0
   end
   
   for i=1,#bullet do
     bullet[i].x = bullet[i].x + bullet[i].velx*dt
     bullet[i].y = bullet[i].y + bullet[i].vely*dt
   end
   
end
function bullet.draw()
   for i=1,#bullet do
     love.graphics.draw(bullet[i].image, bullet[i].x-60, bullet[i].y-130, 0, 0.2, 0.2)
   end
end

function bullet.reset()
  for i=#bullet, 1, -1 do
    table.remove(bullet, i)
  end
end

return bullet