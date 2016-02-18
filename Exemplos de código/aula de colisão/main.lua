function love.load()
  --love.window.setMode(1024, 768, {resizable=false})
  --love.window.setFullscreen(true, "normal")
  love.window.setTitle("Aula de colisão do Fernandinho")
  player1 = {
    x = 390,
    y = 300,
    width = 50,
    height = 50,
    collided = false
  }
  box1 = {
    x = 100,
    y = 300,
    width = 50,
    height = 50
  }
  box2 = {
    x = 650,
    y = 275,
    width = 100,
    height = 100
  }
end
function CheckBoxCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end
function love.update(dt)
  if(player1.x < 0) then
    player1.x = 0
  end
  if(player1.x > 750) then
    player1.x = 750
  end
  if(player1.y < 0) then
    player1.y = 0
  end
  if(player1.y > 550) then
    player1.y = 550
  end
  if love.keyboard.isDown("left") and not (CheckBoxCollision(player1.x-(300*dt), player1.y, player1.width,
  player1.height, box1.x, box1.y, box1.width, box1.height) or
  CheckBoxCollision(player1.x-(300*dt) , player1.y, player1.width,
  player1.height, box2.x, box2.y, box2.width, box2.height)) then
    player1.x = player1.x - (300 * dt)
  end
  if love.keyboard.isDown("right") and not (CheckBoxCollision(player1.x+(300*dt), player1.y, player1.width,
  player1.height, box1.x, box1.y, box1.width, box1.height) or
  CheckBoxCollision(player1.x+(300*dt), player1.y, player1.width,
  player1.height, box2.x, box2.y, box2.width, box2.height))then
    player1.x = player1.x + (300 * dt)
  end
  if love.keyboard.isDown("up") and not (CheckBoxCollision(player1.x, player1.y- (300 * dt), player1.width,
  player1.height, box1.x, box1.y, box1.width, box1.height) or
  CheckBoxCollision(player1.x, player1.y- (300 * dt), player1.width,
  player1.height, box2.x, box2.y, box2.width, box2.height))then
    player1.y = player1.y - (300 * dt)
  end
  if love.keyboard.isDown("down") and not (CheckBoxCollision(player1.x, player1.y + (300 * dt), player1.width,
  player1.height, box1.x, box1.y, box1.width, box1.height) or
  CheckBoxCollision(player1.x, player1.y + (300 * dt), player1.width,
  player1.height, box2.x, box2.y, box2.width, box2.height)) then
    player1.y = player1.y + (300 * dt)
  end
  if CheckBoxCollision(player1.x, player1.y, player1.width,
  player1.height, box1.x, box1.y, box1.width, box1.height) or
  CheckBoxCollision(player1.x, player1.y, player1.width,
  player1.height, box2.x, box2.y, box2.width, box2.height) then
    player1.collided = true
  else
    player1.collided = false
  end
  if love.keyboard.isDown("escape") then
    love.event.push("quit")
  end
end
function love.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.rectangle("fill", box1.x, box1.y,box1.width, box1.height)
  love.graphics.rectangle("fill", box2.x, box2.y,box2.width, box2.height)
  if player1.collided == true then
    love.graphics.setColor(255,0,0)
  end
  love.graphics.rectangle("fill", player1.x, player1.y,player1.width, player1.height)
end