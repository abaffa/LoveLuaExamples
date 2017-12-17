local Yeti1 = {}

function Yeti1.load()
  Yetis = {}
  
  YetiImage = {}
  
  for x = 1, 4, 1 do
    YetiImage[x] = love.graphics.newImage("yeti "..x..".png") -- carrega os frames dos yetis
  end
  
end

function Yeti1.update(dt)
  if inicio == false then
    if gameover == false then -- enquanto Tycon estiver vivo
      
      local remYeti = {}
     for i,v in ipairs(Yetis) do
        if v.x <= -100 then
          table.insert(remYeti, i)
        end
      end
      
      for i,v in ipairs(remYeti) do
        table.remove(Yetis, v)
        Yetis.y = 440
        if BossMove ~= 2 then
        table.insert(Yetis, {width = 133, height = 131, speed = love.math.random(510,600), x = 900 + love.math.random(0,100), y = 440})
        end
    
        yeti_jump = love.math.random(1,10)
      end
     
      
      anim_Yeti = anim_Yeti + dt * 5  -- velocidade da animação dos Yetis
      if anim_Yeti >= 5 then  -- repetição da animação dos Yetis
        anim_Yeti = 1
      end
      Yeti_anim_frame = math.floor(anim_Yeti)
      
      if estagio == 2 then
        if score <= 1500 then
          Tycon.power = 0
        end
        for i,v in ipairs(Yetis) do
          if yeti_velocity ~= 0 then -- pulo dos Yetis
            v.y = v.y - yeti_velocity * dt*4 --ajuste da posição em relação ao eixo y
            yeti_velocity = yeti_velocity - gravity * dt*4 -- ajuste da velocidade em relaçã ao eixo y
 
            if v.y > 440 then -- parada dos Yetis quando chegar no chão
              yeti_velocity = 0
              v.y = 440
            end
          end
        end
        
        for i,v in ipairs(Yetis) do
        v.x = v.x - dt * v.speed      
        end  
      end   
    --if score >1700 then
      --score = 1500
   --end
    end
  end
  
end

function Yeti1.draw()
  if inicio == false then
    if gameover == false then
      
      love.graphics.setColor(255, 255, 255, 255)
     
      
      for i,v in ipairs(Yetis) do  -- Imagem dos Yetis
        if v.x <= 850 then
          love.graphics.setColor(255, 255, 255, 255)
           if yeti_jump % 2 == 1 then
              love.graphics.setColor(230, 255, 255, 255)
           end
          love.graphics.draw(YetiImage[Yeti_anim_frame], v.x, v.y, 0, 1.2, 1.2)
          --love.graphics.setColor(255, 255, 0, 190)
          -- love.graphics.rectangle("fill",v.x,v.y,v.width,v.height)
        end
      end
      
      
    end
  end
end

return Yeti1