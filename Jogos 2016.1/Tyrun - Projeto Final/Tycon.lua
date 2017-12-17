local Tycon1 = {}

function Tycon1.load()
  Tycon =  {x = 100, y = 500, width = 136, height = 70, speed = 300, power = 0}
  Flame = {x = Tycon.x + 70, y = Tycon.y-20, width = 80, height = 80, speed = 300}
  Boom = {x = Tycon.x + 70, y = Tycon.y, width = 80, height = 80, speed = 300, acc = 0}
  Tycon_anim_frame = 1
  
  for x = 1, 6, 1 do -- frames de Tycon
    Tycon[x] = love.graphics.newImage("Tycon " .. x .. "hd.png")
  end
  
  power_icon_1 = love.graphics.newImage("power1.png")
  FlameImage = {}
  for x = 1, 6, 1 do
  FlameImage[x] = love.graphics.newImage("Flame "..x..".png")
end
  
  BoomImage = love.graphics.newImage("Boomerang.png")
  
end

function Tycon1.update(dt)
  if inicio == false then
    if gameover == false then
      if love.keyboard.isDown("left") or love.keyboard.isDown("a") then -- movimentação horizontal de Tycon
       vextraX = -0.3
       Tycon.x = Tycon.x - Tycon.speed*dt*0.1 - BossMove * dt * Tycon.speed*5/6
      elseif love.keyboard.isDown("right") or love.keyboard.isDown("d")  then
        vextraX = 1
        --score = 2001
        Tycon.x = Tycon.x + Tycon.speed*dt*0.15 + BossMove * dt * Tycon.speed*5/4
      else
        vextraX = 0
      end 
      --[[(love.keyboard.isDown("down") or love.keyboard.isDown("s")) and Tycon.y ~= 500 then
        Tycon.y = Tycon.y + dt * 200
      elseif (love.keyboard.isDown("space") or love.keyboard.isDown(" ")) and Tycon.y ~= 500 and y_velocity > 0  then
        Tycon.y = Tycon.y - dt * 40
      end]]
      
      if estagio == 3 then
        --anim_Tycon = anim_Tycon + dt * (9 + BossMove* 1/3 * 10)
        anim_Tycon = anim_Tycon + dt * (9 + score/2500)-- velocidade da animação de Tycon
      elseif BossMove == 1 then
        anim_Tycon = anim_Tycon + dt * (9 + BossMove * 10) 
      elseif BossMove == 2 then
        anim_Tycon = anim_Tycon + dt * (9 + (250-Boss2.HP)/50)
      else 
        anim_Tycon = anim_Tycon + dt * (9)  ------- IMPLEMENTADO ----------------
      end
  
      if anim_Tycon >= 7 then -- repetição da animação de Tycon
        anim_Tycon = 1
      end
      Tycon_anim_frame = math.floor(anim_Tycon)
      
      anim_Flame = anim_Flame + dt * 5  
      if anim_Flame >= 7 then  
        anim_Flame = 1
      end
      Flame_anim_frame = math.floor(anim_Flame)
    
  
      if y_velocity ~= 0 then -- pulo de Tycon
        Tycon.y = Tycon.y - y_velocity * dt*4 --ajuste da posição em relação ao eixo y
        y_velocity = y_velocity - gravity * dt*4 -- ajuste da velocidade em relação ao eixo y
 
        if Tycon.y > 500 then -- parada de Tycon quando chegar no chão
          y_velocity = 0
          Tycon.y = 500
        end
      end
      
      if estagio == 2 and shoot == true then  -- movimentação do bumerangue de Tycon
        if Boom.acc >= 0 then
        Boom.x = Boom.x + dt * 1.5 * Boom.acc^2
      elseif Boom.acc < 0 then
        Boom.x = Boom.x + dt * 1.5 * (Boom.acc^2) * (-1)
      end
      
        Boom.acc = Boom.acc - dt * 60
        
        if Boom.acc >= 0 then
          Boom.y = Tycon.y
        end
      end
    
      if Boom.x <= -80 then
      shoot = false
      end
    end
  end
  

end

function Tycon1.draw()
  if inicio == false then
    if gameover == false then
      if shoot == true and estagio == 1 then
        love.graphics.setColor(255,255,255,255) -- bola de fogo de Tycon FOGO
        love.graphics.draw(FlameImage[Flame_anim_frame], Flame.x,Flame.y,math.asin(Flame_Travely/(math.sqrt((Flame_Travelx)^2+(Flame_Travely)^2))),0.4,0.4,87,84) -- Bola de fogo de Tycon
        elseif shoot == true and estagio == 2 then
          love.graphics.setColor(255,255,255,255) -- bumerangue de Tycon
          love.graphics.draw(BoomImage,Boom.x,Boom.y, speed * 10 , 1, 1, 55.885, 40.574)
           --love.graphics.setColor(255,0,255,180)
          --love.graphics.rectangle("fill",Boom.x - 24.115 ,Boom.y - 39.426,Boom.width,Boom.height)
      end
  
      love.graphics.setColor(255,255,255,255)
      if Att <= 0 then
        love.graphics.draw(Tycon[Tycon_anim_frame], Tycon.x, Tycon.y, 0, 1, 1) -- animação de Tycon
      elseif Att > 0 then
        love.graphics.draw(Tycon_Att, Tycon.x + 20, Tycon.y - 20, 0, 1, 1)
      end
      --love.graphics.setColor(0,255,255,190)
      -- love.graphics.rectangle("fill",Tycon.x + 65,Tycon.y + 10,40,40)
    end
  end
end
return Tycon1