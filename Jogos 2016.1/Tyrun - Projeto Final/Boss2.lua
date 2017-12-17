local Boss21 = {}

function Boss21.load()
  Boss2 = {x = 2000, y = 245, width = 312, height = 333, speed = 100,HP = 250, speedY = 0, fall = 1, R = 120, G = 255, B = 120}
  factor_jump = 1 -- fator que decide se o Boss2 pula ou nã pula
  factor_luck = 3 -- fator que altera o factor_jump
  frequent_jump = 0 -- math.floor do factor_jump, ou seja, será constante em intervalos de tempo iguais, permitindo que o chefe pule num certo instante, controlado por factor_jump
  
  
end

function Boss21.update(dt)
  if inicio == false then
    if gameover == false then
      
      if Boss2.HP <= 0 and estagio == 2 then
        score = score + 500
      end
      
      
      if BossMove == 0 and score >= 1500 then
         Boss2.x = Boss2.x - dt * 120
        if Boss2.x <= 912 then
          BossMove = 2
        end
      elseif BossMove == 2 then
        if Boss2.HP >=200 then
        factor_jump = factor_jump + dt * 4
        elseif Boss2.HP >=100 then
        factor_jump = factor_jump + dt * 5
        elseif Boss2.HP > 0 then
        factor_jump = factor_jump + dt * 6
        end
      
        if factor_jump >= 15 then
          factor_jump = 1
        end
        frequent_jump = math.floor(factor_jump)
        if frequent_jump == factor_luck then
          Boss2.speedY = 400
        end
        if Boss2.speedY ~= 0 then
          if Boss2.HP >= 200 then-- pulo dos Yetis
            if Boss2.x-312 > Tycon.x and Boss2.speedY > 0 then
            Boss2.x = Boss2.x - dt * 500          
            elseif Boss2.x-312 < Tycon.x and Boss2.speedY > 0 then
            Boss2.x = Boss2.x + dt * 400
            end
           
          elseif Boss2.HP >= 100 then
            if Boss2.x-312 > Tycon.x and Boss2.speedY > 0 then
              Boss2.x = Boss2.x - dt * 700        
            elseif Boss2.x-312 < Tycon.x and Boss2.speedY > 0 then
              Boss2.x = Boss2.x + dt * 550 
            end
            
          elseif Boss2.HP > 0 then
            if Boss2.x-312 > Tycon.x and Boss2.speedY > 0 then
            Boss2.x = Boss2.x - dt * 1000         
            elseif Boss2.x-312 < Tycon.x and Boss2.speedY > 0 then
            Boss2.x = Boss2.x + dt * 800       
            end
          end
          
          if Boss2.HP >= 200 then
            Boss2.y = Boss2.y - Boss2.speedY * Boss2.fall * dt*4 --ajuste da posição em relação ao eixo y
            Boss2.speedY = Boss2.speedY - gravity * dt*8 -- ajuste da velocidade em relação ao eixo y
          elseif Boss2.HP >= 100 then
            Boss2.y = Boss2.y - Boss2.speedY * Boss2.fall * dt*5 --ajuste da posição em relação ao eixo y
          Boss2.speedY = Boss2.speedY - gravity * dt*8 -- ajuste da velocidade em relação ao eixo y
          elseif Boss2.HP > 0 then
            Boss2.y = Boss2.y - Boss2.speedY * Boss2.fall * dt*6 --ajuste da posição em relação ao eixo y
            Boss2.speedY = Boss2.speedY - gravity * dt*10 -- ajuste da velocidade em relação ao eixo y
          end
          
          if Boss2.speedY < 0 then
            Boss2.fall = 2
          elseif Boss2.speedY >= 0 then
            Boss2.fall = 1
          end
            
          
          if Boss2.y > 245 then -- parada do segundo chefe quando chegar no chão
            Boss2.speedY = 0
            factor_luck = love.math.random(1,14)
            Boss2.y = 245
          end
        end
      end
    end
  end
end

function Boss21.draw()
  
  if inicio == false then
    if gameover == false then
      if estagio == 2 then
        if score >= 1500 and score <= 2500 then -- Boss2
        love.graphics.setColor(0,0,0,150)
        --love.graphics.circle("fill",Boss2.x-Boss2.width/2,570,Boss2.width/2,10)
        love.graphics.ellipse("fill",Boss2.x-Boss2.width/2,570,Boss2.width/2,10)
        love.graphics.setColor(Boss2.R,Boss2.G,Boss2.B,255)
        love.graphics.draw(YetiImage[Yeti_anim_frame], Boss2.x, Boss2.y, 0, -3, 3)
        --love.graphics.setColor(255,0,0,180)
        --love.graphics.rectangle("fill",Boss2.x-312, Boss2.y, Boss2.width, Boss2.height)
        love.graphics.setColor(0,0,0,220)
        love.graphics.rectangle("fill",4+760,150-1,12,250+2)
        love.graphics.setColor(255,Boss2.HP,0,220)
        love.graphics.rectangle("fill",5+760,(-Boss2.HP)+400,10,Boss2.HP)
        end
      end
    end
  end
end

return Boss21