function basquete_load() 
 basquete_inst = love.graphics.newImage("fase _ basquete/basqueteinst.png")
 resultados_basquete = love.graphics.newImage("fase _ basquete/resultados_basquete.png")
 basquete_stater = 0
 statetimer = 0
 basquete_click = 0
 pixToMet = 32
 love.physics.setMeter(pixToMet)
 world = love.physics.newWorld(0, 9.81*pixToMet, true)
 --creating ball
 objects = {}
  objects.basquete_ball = {
   Xp = 0,
   Yp = 0,
   r = 20,
   Theta,
   Vo,
   Vy,
   pos_x = 110,
   pos_y = 490,
  }
 objects.basquete_ball.body = love.physics.newBody(world, objects.basquete_ball.Xp, objects.basquete_ball.Yp, "dynamic")
 objects.basquete_ball.shape = love.physics.newCircleShape(objects.basquete_ball.r)
 objects.basquete_ball.fixture = love.physics.newFixture(objects.basquete_ball.body, objects.basquete_ball.shape, 1)
 objects.basquete_ball.fixture:setRestitution(.05)
 objects.basquete_ball.body:setPosition(10, 400) 
 objects.basquete_ball.body:setActive(false) 
 objects.basquete_ball.body:setMass(0.65)
 --creating net
  net = {
   x = 675,
   y = 190,
   width = 6,
   height = 180
  }
 net.body = love.physics.newBody(world, net.x, net.y, "static")
 net.shape = love.physics.newRectangleShape(net.width, net.height)
 net.fixture = love.physics.newFixture(net.body, net.shape, 1)
 net.fixture:setRestitution(.8)
 --creating hoops 
  hoop1 = {
   x = 572.5,
   y = 245,
   width = 2.5,
   height = 5
  }
 hoop1.body = love.physics.newBody(world, hoop1.x, hoop1.y, "static")
 hoop1.shape = love.physics.newRectangleShape(hoop1.width, hoop1.height)
 hoop1.fixture = love.physics.newFixture(hoop1.body, hoop1.shape, 1)
 hoop1.fixture:setRestitution(.7)
  hoop2 = {
   x = 662,
   y = 245,
   width = 12,
   height = 5
  }
 hoop2.body = love.physics.newBody(world, hoop2.x, hoop2.y, "static")
 hoop2.shape = love.physics.newRectangleShape(hoop2.width, hoop2.height)
 hoop2.fixture = love.physics.newFixture(hoop2.body, hoop2.shape, 1)
 hoop2.fixture:setRestitution(.7)
 --creating floor
  floor = {
   x = 400, 
   y = 580,
   width = 800,
   height = 20
  }
 floor.body = love.physics.newBody(world, floor.x, floor.y, "static")
 floor.shape = love.physics.newRectangleShape(floor.width, floor.height)
 floor.fixture = love.physics.newFixture(floor.body, floor.shape, 1)
 floor.fixture:setRestitution(.8)
 
 basket = {}
 change_x = 1       --to shake the hoop when score a point
 basquete_score = 0        --to count how many points was made in this level
 time_score = 0   --if a point is not made in a certain time, reset ball position the throw it again
 basquete_state1 = false         --variable used to control weather the ball is in movement or not 
 basquete_state2 = false         --variable used to help state3 to control the scores
 basquete_state3 = false         --variable used to control the scores
 
 basquete_ball = love.graphics.newImage("fase _ basquete/bola.png")
 basquete_background = love.graphics.newImage("fase _ basquete/fundo.png")
 athlete = love.graphics.newImage("fase _ basquete/atleta.png")
  for x = 1,3, 1 do
   basket[x] = love.graphics.newImage("fase _ basquete/cesta" .. x .. ".png")
  end
end

function basquete_score_calculator(x) 
  local y
  if x >= 15 then
   y = basquete_score*504/6 + (496 - 33*(x - 15))
  end
  return y
end

function basquete_check_mouse(mousex,mousey,x,hx,y,hy)
    return mousex < x + hx and mousey < y + hy and x < mousex + 1 and y < mousey + 1
end

function basquete_CheckBoxCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  if x1 <= x2+w2 and x2 <= x1+w1 and y1 <= y2+h2 and y2 <= y1+h1 then
   return true
  else
   return false
  end
end

function basquete1_mousepressed(x,y,button)
  if button == 1 and basquete_state1 == false then    
   basquete_state1 = true
   time_score = 0
   objects.basquete_ball.Xp = love.mouse.getX()
   objects.basquete_ball.Yp = love.mouse.getY()
   deltaY = math.abs(objects.basquete_ball.Yp - objects.basquete_ball.pos_y)
   objects.basquete_ball.Theta = math.atan((2*deltaY*(1+math.sqrt(1+(objects.basquete_ball.Yp/deltaY)))/objects.basquete_ball.Xp))
   objects.basquete_ball.Vo = math.sqrt(2*9.81*deltaY)/math.sin(objects.basquete_ball.Theta)
   ForceX = objects.basquete_ball.Vo*math.cos(objects.basquete_ball.Theta)*5.9
   ForceY = -objects.basquete_ball.Vo*math.sin(objects.basquete_ball.Theta)*3.75
   objects.basquete_ball.body:applyLinearImpulse(ForceX,ForceY,0,0)
  end
end

function basquete2_mousepressed(x,y,button)
  if basquete_click == 0 and button == 1 then
    basquete_click = 1
  end
end
function basquete_mousereleased(x,y,button)
  if basquete_click == 1 and button == 1 then
   basquete_click = 0
  end
end
function checkscore(state_3)--state_3 get state3
  if state_3 == true then
   basquete_state1 = false
   basquete_state2 = false
   basquete_state3 = false
   objects.basquete_ball.body:setLinearVelocity(0, 0)
  end
end

function basquete_update(dt)
  if basquete_stater == 0 then
    statetimer = statetimer + dt
    if statetimer >= 1.5 then
      basquete_stater = 1
      statetimer = 0
    end
  elseif basquete_stater == 1 then  
    statetimer = statetimer + dt
    world:update(dt)
    time_score = time_score + dt
    checkscore(basquete_state3)
      if basquete_state1 == false then
        objects.basquete_ball.body:setActive(false)
        objects.basquete_ball.body:setPosition(110, 490)
      else
        objects.basquete_ball.body:setActive(true)
      end
    if basquete_CheckBoxCollision(objects.basquete_ball.body:getX(), objects.basquete_ball.body:getY(),10,10,575,240,75,30) == true then
      change_x = change_x + 1
      basquete_state2 = true
        if change_x > 3 then
          change_x = 1
        end
      basquete_state1 = false
    else
      change_x = 1
    end
    if basquete_state2 == true and basquete_state1 == false then
     basquete_score = basquete_score + 1 
     basquete_state3 = true
    end
    
    if time_score >= 6.0 then
     basquete_state3 = true
    end
    
    if (basquete_score == 6 and statetimer >= 15) or statetimer >= 30 then
     basquete_stater = 2
    end
  elseif basquete_stater == 2  then -- MUDANÇA DE ESTADO
    if basquete_check_mouse(love.mouse.getX(),love.mouse.getY(),190,260,330,40) then
      if basquete_click == 1 then 
        gamestate = 4
      end
    end
    
    if basquete_check_mouse(love.mouse.getX(),love.mouse.getY(),500,120,330,40) then
      if basquete_click == 1 then 
       love.event.push("quit")
      end
    end
  end
end

function basquete_draw()
  if basquete_stater == 0 then
   love.graphics.setColor(255,255,255)
   love.graphics.draw(basquete_inst,0,0)
  elseif basquete_stater == 1 then  
   love.graphics.draw(basquete_background)
   love.graphics.print("Score  " .. basquete_score .. "", 10, 10)
   love.graphics.draw(basquete_ball, objects.basquete_ball.body:getX(), objects.basquete_ball.body:getY(), objects.basquete_ball.r, 1, 1, 20,20)
   love.graphics.draw(basket[change_x], 570, 100)
   love.graphics.draw(athlete, 10,400, 0, 0.95, 0.95)
  elseif basquete_stater == 2 then
   love.graphics.setColor(255,255,255)
   love.graphics.draw(resultados,0,0)
   love.graphics.setColor(0,0,0)
   love.graphics.print("SCORE    "..math.ceil(tonumber(basquete_score_calculator(statetimer))).."",250,250) 
    if basquete_check_mouse(love.mouse.getX(),love.mouse.getY(),190,260,330,40) then
     love.graphics.setColor(255,255,0)
     love.graphics.print("CONTINUE",190,330)
    else
     love.graphics.print("CONTINUE",190,330)
    end
    if basquete_check_mouse(love.mouse.getX(),love.mouse.getY(),500,120,330,40) then
     love.graphics.setColor(255,255,0)
     love.graphics.print("QUIT",500,330)
    else
     love.graphics.setColor(0,0,0)
     love.graphics.print("QUIT",500,330) 
    end  
  end
end