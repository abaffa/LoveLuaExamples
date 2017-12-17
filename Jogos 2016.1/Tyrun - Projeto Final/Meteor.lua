local Meteor1 = {}

function Meteor1.load()
  Meteors = {}
  MeteorImage = love.graphics.newImage("Meteor.png")
  spin = 0
  kaboom = 100
  shine = 255
  shine_factor = 1
end

function Meteor1.update(dt)
  if inicio == false then
    if gameover == false then
      
      if score >= 2500 + kaboom and score < 3500 then
        table.insert(Meteors, {width = 33.5, height = 33.5, speed = love.math.random(300,500), x = love.math.random(1000,2500), y = love.math.random(-400,-70), ang = love.math.random(8000,8500)})
        
        kaboom = kaboom + 100
        
      elseif  score >= 2600 + kaboom and score < 6000  then
        table.insert(Meteors, {width = 33.5, height = 33.5, speed = love.math.random(300,500), x = love.math.random(1000,2500), y = love.math.random(-400,-70), ang = love.math.random(8000,8500)})
        kaboom = kaboom + 100
        
      end
      
      spin = spin + dt * (-10) -- giro dos meteoros
            
      local remMeteor = {}
      for i,v in ipairs(Meteors) do
        if v.y >= 670 then
          table.insert(remMeteor, i)
        end
      end     
      for i,v in ipairs(remMeteor) do
        table.remove(Meteors, v)
        if score >= 2500 and score < 9000 then
          table.insert(Meteors, {width = 33.5, height = 33.5, speed = love.math.random(300,500), x = love.math.random(1000,2500), y = love.math.random(-400,-70), ang = love.math.random(8000,8500)})
          
        end
      end
      
      if estagio == 3 then
      for i,v in ipairs(Meteors) do
        if score <= 3000 then
          v.x = v.x - dt * v.speed * 1 * math.asin(v.ang/10000) -- ANGULOS
          v.y = v.y + dt * v.speed * 1 * math.acos(v.ang/10000)
        elseif score <= 3100 then
          v.x = v.x - dt * v.speed * 1.2 * math.asin(v.ang/10000) -- ANGULOS
          v.y = v.y + dt * v.speed * 1.2 * math.acos(v.ang/10000)
          elseif score <= 3200 then
          v.x = v.x - dt * v.speed * 1.3 * math.asin(v.ang/10000) -- ANGULOS
          v.y = v.y + dt * v.speed * 1.3 * math.acos(v.ang/10000)
          elseif score <= 3300 then
          v.x = v.x - dt * v.speed * 1.4 * math.asin(v.ang/10000) -- ANGULOS
          v.y = v.y + dt * v.speed * 1.4 * math.acos(v.ang/10000)
          elseif score <= 3400 then
          v.x = v.x - dt * v.speed * 1.5 * math.asin(v.ang/10000) -- ANGULOS
          v.y = v.y + dt * v.speed * 1.5 * math.acos(v.ang/10000)
          elseif score <= 3500 then
          v.x = v.x - dt * v.speed * 1.1 * math.asin(v.ang/10000) -- ANGULOS
          v.y = v.y + dt * v.speed * 1.1* math.acos(v.ang/10000)
          elseif score <= 6500 then
          v.x = v.x - dt * v.speed * 1.2* math.asin(v.ang/10000) -- ANGULOS
          v.y = v.y + dt * v.speed * 1.2* math.acos(v.ang/10000)
          elseif score <= 7000 then
          v.x = v.x - dt * v.speed * 1.3* math.asin(v.ang/10000) -- ANGULOS
          v.y = v.y + dt * v.speed * 1.3 * math.acos(v.ang/10000)
        end
      end
    end
    
    
    shine = shine - dt * 150 * shine_factor
    if shine <= 0 then 
      shine_factor = (-1)
    elseif shine >= 255 then
      shine_factor = 1
    end
    
    
    
    
    
    end
       
  end 
end

function Meteor1.draw()
  for i,v in ipairs(Meteors) do
    --love.graphics.setColor(0,0,255,150)
   -- love.graphics.setLineWidth(3)
    --love.graphics.line(0,550,800,550)
    if v.y >= -70 and v.y <= 670 then
      if score < 3600 then
        love.graphics.setColor(255,255,255,255)
        love.graphics.draw(MeteorImage, v.x, v.y, spin, 1, 1,33.5,33.5) -- animação dos Meteorsd
      elseif score >= 3600 then
        love.graphics.setColor(255,255,255,255)
        love.graphics.draw(MeteorImage, v.x, v.y, spin, 2, 2,33.5,33.5) -- animação dos Meteorsd
      end
    end
    love.graphics.setColor(0,0,255,180)
    if score < 3600 then
      --love.graphics.rectangle("fill",v.x - v.width + 10, v.y-v.height + 10, v.width*2 - 20 , v.height*2 - 20)
    elseif score >= 3600 then
      --love.graphics.rectangle("fill",v.x - v.width -10, v.y-v.height - 10 , v.width*2 + 20 , v.height*2 + 20)
    end
  end
end

return Meteor1