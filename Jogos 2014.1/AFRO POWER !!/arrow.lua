
arrow = {
  speed = 350,
  image=love.graphics.newImage("knight walk/ranger/arrowR.png")
}

function arrow.spawn(x,y,dir)
  table.insert(arrow,{x=x,y=y,dir=dir,hitbox = Collider:addRectangle(x,y,23,10)})
end

function arrow.draw()
  for i,v in ipairs(arrow) do
    love.graphics.draw(arrow.image, v.x, v.y,0,v.dir)
  end
end
function arrow.update(dt) 
  for i,v in ipairs(arrow) do
  if v.dir == 1 then
    v.x = v.x + arrow.speed*dt
    v.hitbox:move(arrow.speed*dt,0)
    v.hitbox.type = "fireball"
  end
  if v.dir == -1 then
    v.x = v.x - arrow.speed*dt
    v.hitbox:move(-arrow.speed*dt,0)
    v.hitbox.type = "arrow"
  end
end

end