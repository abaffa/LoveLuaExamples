rock = {
  speed = 350,
  image=love.graphics.newImage("knight walk/normal/rock.png")
}

function rock.spawn(x,y,dir)
  table.insert(rock,{x=x,y=y,dir=dir,hitbox = Collider:addRectangle(x,y,23,10)})
end

function rock.draw()
  for i,v in ipairs(rock) do
    love.graphics.draw(rock.image, v.x, v.y,0,v.dir)
  end
end
function rock.update(dt) 
  for i,v in ipairs(rock) do
  if v.dir == 1 then
    v.x = v.x + rock.speed*dt
    v.hitbox:move(rock.speed*dt,0)
    v.hitbox.type = "fireball"
  end
  if v.dir == -1 then
    v.x = v.x - rock.speed*dt
    v.hitbox:move(-rock.speed*dt,0)
    v.hitbox.type = "fireball"
  end
end

end