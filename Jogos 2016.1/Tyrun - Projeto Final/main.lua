Tycon1 = require "Tycon"
Dino1 = require "Dino"
Yeti1 = require "Yeti"
Meteor1 = require "Meteor"
Boss21 = require "Boss2"
Fade1 = require "Fade"

function CheckCollision(ax1,ay1,aw,ah, bx1,by1,bw,bh)
  local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
  return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end

function love.load()
  --if arg and arg[#arg] == "-debug" then require("mobdebug").start() end
Tycon1.load()
Dino1.load()
Yeti1.load()
Meteor1.load()
Boss21.load()
Fade1.load()
    
  --score = tonumber(0)
  --Tycon.shots = {} -- power ups
  --life = 100
     
  Boss1 = {x = -300, y = -100, width = 750, height = 550, speed = 100,HP = 100}
  
    
  stage1song = love.audio.newSource("Tyrun 20.wav", "stream")
  stage2song = love.audio.newSource("Tyrun 50.wav", "stream")
  stage3song = love.audio.newSource("Tyrun 20.wav", "stream")
    
  Boss1song = love.audio.newSource("Run.wav", "stream")
  Boss2song = love.audio.newSource("Builder.wav","stream")
  FlameEffect = love.audio.newSource("Flame.mp3", "static")

  play_imag = {imag = love.graphics.newImage("play.png"), x = 310, y = 255}
  gameover_imag = {imag = love.graphics.newImage("gameover.png"), x = 125, y = 200} 
  playagain_imag = {imag = love.graphics.newImage("playagain.png"), x = 275, y = 300}
  title_imag = { imag = love.graphics.newImage("TitleC.png"), x = -70, y = 30}
  
  floresta_imag = love.graphics.newImage("Floresta.png")
  gelo_imag = love.graphics.newImage("Gelo.png")
  fire_imag = love.graphics.newImage("Fire.png")
  
  Tycon_Att = love.graphics.newImage("Tycon Att.png")
  snap_itc_font = love.graphics.newFont("snap.ttf", 50)
  
  MouseClick_anim_frame = 1
  
  MouseClick = {}
  for x = 1, 2, 1 do -- frames do MouseClick
    MouseClick[x] = love.graphics.newImage("MouseClick " .. x .. ".png")
  end
  

  --[[VARIÁVEIS NÃO UTILIZADAS]]--
  d = 0 -- sinal da direção do ciclo dos dias
  t = 0 -- direção do ciclo dos dias
  speed = 1 -- possível aceleração do cenário(renomear)
  cycle = 0 -- valor do ciclo dos dias
  
  reiniciajogo()  -- reinicia o jogo 
end

function reiniciajogo()
  while #Dinos>=1 do
    table.remove(Dinos,1)
  end
  while #Yetis>=1 do
    table.remove(Yetis,1)
  end
  while #Meteors>=1 do
    table.remove(Meteors,1)
  end
  for i=1,1 do   -- i = o numero de dino para aparecer
    Dino_anim_frame = 1
    table.insert(Dinos, {width = 266, height = 131, speed = love.math.random(350,500), x = (i-1) * (266 + 1150) + 1500, y = 450})
  end
  Tycon.x = 100
  Tycon.y = 500
  Tycon.power = 0
  Boss1.x = -300
  Boss2.x = 2000
  Yeti_anim_frame = 1
  Flame_anim_frame = 1
  MouseClick_anim_frame = 1
  anim_MouseClick = 1
  anim_Tycon = 1 -- variável dos frames da animação de Tycon
  anim_Dino = 1 -- variável dos frames da animação dos Dinos
  anim_Yeti = 1-- variável dos frames da animação dos Yetis
  anim_Flame = 1-- variável dos frames da animação das chamas de Tycon
  vbg = 10 -- velocidade do cenário da Floresta com referencial em 10
  ice = 10 -- velocidade do cenário do Gelo com referencial em 10
  fire = 10

  score = 0
  BossMove = 0 -- condiciona o campo de batalha contra o primeiro chefe, disponibilizando o power up e a movimentação de Tycon
  yeti_jump = 0 -- Variável que decide se o Yeti pula ou não
  Att = 0 -- variável da posição de ataque de Tycon
  Click = false

  gravity = 100 --gravidade em relação a todos os objetos afetados
  jump_height = 190 -- altura do pulo de Tycon
  Flame_Travelx = 0 -- componente horizontal da chama
  Flame_Travely = 0 -- componente vertical da chama
  y_velocity = 0 -- velocidade vertical de Tycon
  yeti_velocity = 0 --velocidade vertical dos Yetis
  Boss2.y = 245 -- posição inicial em relação ao eixo Y do segundo chefe
  
  Boss1Damage = 0

  gameover = false
  inicio = true
  ranking = false
  credit = false
  
  shoot = false
  vextraX = 0
  estagio = 1
  light = 255
  kaboom = 100
  
  Boss2.HP = 250
  love.audio.setVolume(1)
  love.audio.stop(stage1song)
  love.audio.stop(stage2song)
  love.audio.stop(stage3song)
  love.audio.stop(Boss1song)
  love.audio.stop(Boss2song)
 
end

function love.update(dt) ---UPDATE  UPDATE UPDATE UPDATE UPDATE UPDATE UPDATE UPDATE UPDATE UPDATE UPDATE 
  
  vbg = vbg + dt * (300 + BossMove * 8 * (Boss1Damage*1.2))  -- movimentação do cenário
 
  ice = ice + dt * (400 + BossMove * 8 * ((Boss2.HP - 251)*(-1))/1.7)
   
  if score >= 9000 then
  fire = fire +10+ dt -- corrida final
  elseif score >= 2500 then
  fire = fire +10+ dt * (500 + score/10000)/2
  end
   
  if vbg >= 1140.01 then -- tempo para o cenário 1 repetir (já está exato)
    vbg = 10 -- valor inicial
  end
   
  if ice >= 920.01 then -- tempo para o cenário 2 repetir (já está exato)
    ice = 10
  end
   
  if fire >= 1910.01 then
    fire = 10
  end
     
  Tycon1.update(dt)
  Dino1.update(dt)
  Yeti1.update(dt)
  Meteor1.update(dt)
  Boss21.update(dt)
  Fade1.update(dt)
  if inicio == false then
    if credit == false then
    if ranking == false then
      if gameover == false then
        Att = Att - dt * 400
        if estagio == 1 then
          score = score + dt * 2 -- aumento da pontuação através do tempo
        elseif estagio == 2 then
          score = score + dt * 6 -- aumento da pontuação através do tempo
        elseif estagio == 3 then
          score = score + dt * 10 -- aumento da pontuação através do tempo
        end
        
    
        if score > 600 and estagio==1 then  -- controle da mudança de fase da Floresta para o Gelo
          while #Dinos>=1 do
            table.remove(Dinos)
          end
          for i=1,1 do
            table.insert(Yetis, {width = 133, height = 131, speed = love.math.random(510,600), x = 4000 + love.math.random(0,100), y = 440})
            yeti_jump = love.math.random(1,10)
          end
          Tycon.x = 100
          Click = false
          estagio = 2
        elseif score > 2500 and estagio==2 then
          while #Yetis>=1 do
            table.remove(Yetis)
          end
        
          Tycon.x = 100 
          light = 255
          
            for i=1,3 do
            table.insert(Meteors, {width = 33.5, height = 33.5, speed = 300, x = (i-1) * (60 + 1150) + love.math.random(2400,3400) , y = love.math.random(-200,-70),ang = love.math.random(-10000,10000)})
            end
          
          estagio = 3
          BossMove = 3
        end           
      
        if Tycon.x < 0 then
          Tycon.x = 0
        end
        
        if Tycon.x + Tycon.width > 800 then
          Tycon.x = 800 -Tycon.width
        end
      if love.keyboard.isDown("delete") and love.keyboard.isDown("insert") then
        if love.keyboard.isDown("1") then
          score = 0
        elseif love.keyboard.isDown("2") then
          score = 120
        elseif love.keyboard.isDown("3") then
          score = 610
        elseif love.keyboard.isDown("4") then
          score = 1500
        elseif love.keyboard.isDown("5") then
          score = 2510
        elseif love.keyboard.isDown("6") then
          kaboom = 1000
          score = 3500
        end
      end
      
      
        if score < 120  then
          love.audio.play(stage1song) -- música do jogo
        else
          love.audio.stop(stage1song)
        end
        if score >= 120 and score < 600 then
          love.audio.stop(stage1song)
        end 
        if score >= 1500 and score < 2500 then -- Música do segundo chefe
          love.audio.play(Boss2song)
        else
          love.audio.stop(Boss2song)
        end
        if score >= 2500 then
          love.audio.play(stage3song)
        else
          love.audio.stop(stage3song)
        end
              
        if love.keyboard.isDown("u") then                            -------------------------------------------------------------------------
          love.audio.setVolume(0)                         
        elseif  love.keyboard.isDown("i") then                       -------------------------------------------------------------------------
          love.audio.setVolume(1)
        end
      
        if estagio == 2 and score < 1500 then
          love.audio.stop(Boss1song)
          love.audio.play(stage2song)
          shoot = false 

          if score <= 1500 then
            BossMove = 0       
          end 
        else 
          love.audio.stop(stage2song)
        end
    
        if estagio==1 then -- movimentção dos inimigos da primeira fase
           
          if score >= 120 and score<= 600 then  -- música do primiro chefe
            love.audio.play(Boss1song)
        
            if BossMove == 0 then -- Movimentação do Boss1
              Boss1.x = Boss1.x + dt * Boss1.speed 
              if Boss1.x >= 350 then
                BossMove = 1              
              end
        
            elseif BossMove == 1 then -- trajetória perseguidora do Boss1
              if Tycon.x + 600 > Boss1.x then
                Boss1.x = Boss1.x + dt * Boss1.speed 
              elseif Tycon.x + 600 < Boss1.x then
                Boss1.x = Boss1.x - dt * Boss1.speed
              end
              if shoot == true then
                if Flame_Travelx >= 0 and Flame_Travelx < 10 and Flame_Travely <= 0 and Flame_Travely > -10 then
                  Flame.x = Flame.x + dt * Flame_Travelx *1.5 * 100 -- Trajetória da Bola de Fogo de Tycon no eixo x
                  Flame.y = Flame.y + dt * Flame_Travely *1.5 * 100-- Trajetória da Bola de Fogo de Tycon no eixo y
                elseif Flame_Travelx >= 10 and Flame_Travelx < 100 and Flame_Travely <= -10 and Flame_Travely > -100 then
                  Flame.x = Flame.x + dt * Flame_Travelx *1.5 * 10 -- Trajetória da Bola de Fogo de Tycon no eixo x
                  Flame.y = Flame.y + dt * Flame_Travely *1.5 * 10-- Trajetória da Bola de Fogo de Tycon no eixo y
                else
                  Flame.x = Flame.x + dt * Flame_Travelx *1.5 -- Trajetória da Bola de Fogo de Tycon no eixo x
                  Flame.y = Flame.y + dt * Flame_Travely *1.5 -- Trajetória da Bola de Fogo de Tycon no eixo y
              end
              end
  
              if Flame.x >= 850 or Flame.y <= -50 then
                shoot = false
              end
              if shoot == false then
                Flame.x = Tycon.x + 70
                Flame.y = Tycon.y - 20
              end
            end      
          end
        end
      
        speed = speed + dt -- possível aceleração para o cenário(renomear)
        --+ (speed/5)      
        if Boss1.x >=200 and Tycon.power == 0 and estagio == 1 then
          Click = true
        end
        if Boss2.x <= 1100 and Tycon.power == 0 and estagio == 2 then
          Click = true
        end
      
      
        anim_MouseClick = anim_MouseClick + dt * 5  
        if anim_MouseClick >= 3 then  
          anim_MouseClick = 1
        end
        MouseClick_anim_frame = math.floor(anim_MouseClick)
      
      
        --if score >= 580 and BossMove == 1 then
        -- score = 200
        --end
        -- if score >= 1980 and BossMove == 2 then
        --   score = 1600
        -- end
    
    
        if Boss1Damage == 50 then 
          BossMove = 0
          score = score + 450
          table.remove(Boss1)
          Boss1Damage = 0
          
        end
   
        for ii,vv in ipairs(Dinos) do  -- Colisão de Tycon com os Dinos
        
          if CheckCollision(Tycon.x + 65,Tycon.y + 10,40,40,vv.x,vv.y,vv.width - 171, vv.height-100)  or CheckCollision(Tycon.x + 65,Tycon.y + 10,40,40,vv.x + 55,vv.y + 30,vv.width - 165, vv.height - 30)  then
            gameover = true
            for i,v in ipairs(Dinos) do
              table.remove(Dinos, i)
            end
      
          elseif CheckCollision(Tycon.x + 65,Tycon.y + 10,40,40,vv.x + 100 ,vv.y + 35,vv.width - 100, vv.height-97) then
            if love.keyboard.isDown("space") or love.keyboard.isDown(" ") then
              y_velocity = 240
            else
              y_velocity = 120
            end
          end
        end
        
        if CheckCollision(Flame.x+30,Flame.y-40,Flame.width,Flame.height,Boss1.x - 400,Boss1.y,Boss1.width - 330,Boss1.height - 350) and shoot == true then -- Colisão da bola de fogo com o primeiro chefe
          Boss1Damage = Boss1Damage + 1
          love.audio.stop(FlameEffect)
          shoot = false
        end
        
        if CheckCollision(Boom.x - 24.115 ,Boom.y - 39.426,Boom.width,Boom.height,Boss2.x-312, Boss2.y, Boss2.width - 200, Boss2.height) and shoot == true and estagio == 2 then
          Boss2.HP = Boss2.HP - 1
          if Boss2.HP % 3 == 1 then
            Boss2.R = love.math.random(10,255)
            Boss2.G = love.math.random(10,255)
            Boss2.B = love.math.random(10,255)
          end
          shoot = false
          
        end
        
         if CheckCollision(Boom.x - 24.115 ,Boom.y - 39.426,Boom.width,Boom.height,(Boss2.x-312) + 150, Boss2.y, Boss2.width-150, Boss2.height) and shoot == true and estagio == 2 then
          Boss2.HP = Boss2.HP - 10
          if Boss2.HP % 3 == 1 then
            Boss2.R = love.math.random(10,255)
            Boss2.G = love.math.random(10,255)
            Boss2.B = love.math.random(10,255)
          end
          shoot = false
          
        end
        
        if CheckCollision(Boom.x - 24.115 ,Boom.y - 39.426,Boom.width,Boom.height, Tycon.x + 65,Tycon.y + 10,40,40) and Boom.acc <= 0 and estagio == 2 then
          shoot = false
        end
            
        if CheckCollision(Tycon.x + 65,Tycon.y + 10,40,40,Boss2.x-312, Boss2.y, Boss2.width, Boss2.height) and estagio ==2 and  BossMove == 2 then
          gameover = true
        end
  
        for iii,vvv in ipairs(Yetis) do -- Colisão de Tycon com os Yetis
          if CheckCollision(Tycon.x + 65,Tycon.y + 10,40,40,vvv.x,vvv.y,vvv.width, vvv.height) then
            gameover = true
          end
        end
    
        for i,v in ipairs(Meteors) do
          if CheckCollision(Tycon.x + 65,Tycon.y + 10,40,40, v.x - v.width+10, v.y-v.height +10, v.width*2 - 20 , v.height*2 -20 ) and score < 3600 and estagio == 3  then -- colisão com Tycon
            gameover = true
          elseif CheckCollision(Tycon.x + 65,Tycon.y + 10,40,40, v.x - v.width -10, v.y-v.height -10 , v.width*2 + 20 , v.height*2 + 20 ) and score >= 3600 and estagio == 3 then
            gameover = true
          end -- colisão dos meteoros grandes com Tycon
          
          
          if CheckCollision(0,550,800,550, v.x - v.width+10, v.y-v.height +10, v.width*2 - 20 , v.height*2 -20 ) and estagio == 3 then -- colisão com love2d
            table.remove(Meteors,i)
            if score < 3500 then
              table.insert(Meteors, {width = 33.5, height = 33.5, speed = love.math.random(300,500), x = love.math.random(1000,2500), y = love.math.random(-400,-70), ang = love.math.random(8000,8500)})
            end
            if score >= 3600 then
              table.insert(Meteors, {width = 33.5, height = 33.5, speed = love.math.random(300,500), x = love.math.random(1000,2500), y = love.math.random(-400,-70), ang = love.math.random(8000,8500)})
            end
            
            
          end
        end
  
      elseif gameover == true then -- fim do jogo
          love.audio.stop(Boss1song)
          love.audio.stop(stage1song)
      end
    end
    end
  end
end

function love.draw()
 
  if inicio == true then -- tela inicial
    
    love.graphics.setColor(100,100,255,255)
    love.graphics.draw(floresta_imag, 10 - vbg, 0,0 , 2.1, 2.1 )
      
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(play_imag.imag, play_imag.x, play_imag.y, 0 , 1, 1)
    
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(title_imag.imag, title_imag.x+50, title_imag.y, 0 , 0.35, 0.35)
    
    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(snap_itc_font)
    love.graphics.print("Ranking", 280, 400)
    love.graphics.print("Credits", 282.5, 500)
    
    
    
  elseif inicio == false then    
    if credit == true then
      love.graphics.setBackgroundColor(0,0,0)
      love.graphics.setColor(255, 255, 255)
      love.graphics.setFont(snap_itc_font)
      love.graphics.print("Credits", 300, 0,0,1,1)
      love.graphics.print("Back", 650, 530)
      love.graphics.print("Songs: ", 100, 100,0,1,1)
      love.graphics.print("Run -- by Ross Bugden ", 100, 180,0,0.5,0.5)
      love.graphics.print("Splatoon Final Boss 8-Bit Remix -- by M Kaiser", 100, 220,0,0.5,0.5)
      love.graphics.print("Abstract Minimal Techno - Ambient Winter", 100, 260,0,0.5,0.5)
      love.graphics.print("-- by Liquid Faction ", 100, 300,0,0.5,0.5)
      
      love.graphics.print("Staff: ", 100, 360,0,1,1)
      love.graphics.print("Alan Levy ", 100, 430,0,0.5,0.5)
      love.graphics.print("Marceu Filho", 100, 470,0,0.5,0.5)
      love.graphics.print("Matheus Moura", 100, 510,0,0.5,0.5)
      love.graphics.print("Thiago Avidos ", 100, 550,0,0.5,0.5)
      
      
      
      
      
      elseif credit == false then      
      if ranking == true then
      love.graphics.setBackgroundColor(0,0,0) 
      
      love.graphics.setColor(255, 255, 255)
      love.graphics.setFont(snap_itc_font)
      love.graphics.print("Ranking - Top 10", 160, 0)
      love.graphics.print("Back", 650, 530)
      
      for x = 1,10,1 do
        love.graphics.setFont(snap_itc_font)
        love.graphics.print(x.."-", 50, 52 * x)
      end
                
    elseif ranking == false then
    
      if gameover == false then
    
        if score <= 600 then
          love.graphics.setColor(100,100,255,255) -- luz noturna
          love.graphics.draw(floresta_imag, 10 - vbg, 0, 0 , 2.1, 2.1 ) -- carrega a Floresta
        elseif score <= 2500 then
          if BossMove ~= 2 then
            love.graphics.setColor(255,255,255,255)
          elseif BossMove == 2 then
            love.graphics.setColor(Boss2.G,Boss2.B,Boss2.R,255)
          end
          love.graphics.draw(gelo_imag, 10 - ice, 0, 0 , 2.1, 2.1) -- quando carrega funciona bem mais lento
        elseif score > 2500 and score < 9000 then
          love.graphics.setColor(170 + shine/5, 255- shine/2, shine, 255)
          love.graphics.draw(fire_imag, 10 - fire, 0, 0, 2.0, 2.0)
        elseif score > 9000 then
          love.graphics.setColor(255, 0, 0, 255)
          love.graphics.draw(fire_imag, 10 - fire, 0, 0, 2.0, 2.0)
        end
                       
        -- love.graphics.setColor(255,0,0,190)
        -- love.graphics.rectangle("fill",Boss1.x - 350,Boss1.y,(-1)*Boss1.width+400,Boss1.height - 170)
        --love.graphics.setColor(0,255,0,190)
        --love.graphics.rectangle("fill",Boss1.x - 400,Boss1.y,Boss1.width - 330,Boss1.height - 350)
          
        Dino1.draw()
        Tycon1.draw()
        Boss21.draw()
        Yeti1.draw()
        Meteor1.draw()
      
        love.graphics.setColor(120,120,120,180) -- item BOX
        love.graphics.rectangle("fill",20,20,80,80)
        love.graphics.setColor(0,0,0,255)
        love.graphics.setLineWidth(3)
        love.graphics.line(20,20,100,20,100,100,20,100,20,20)
            
        if (Click == true and estagio == 1) or (Click == true and estagio == 2) then
          love.graphics.setColor(255,255,255,255)
          love.graphics.draw(MouseClick[MouseClick_anim_frame], 20,20, 0, 1, 1)
        end
    
        if Tycon.power == 1 then
          love.graphics.setColor(255,255,255,255)
          love.graphics.draw(power_icon_1, 20, 20, 0, 1, 1)
        elseif Tycon.power == 2 and estagio == 2 then
          love.graphics.setColor(255,255,255,255)
           love.graphics.draw(BoomImage, 70,20, math.pi/4, 0.9, 0.9)
       
        end
        love.graphics.setColor(255,255,255)
        love.graphics.setFont(snap_itc_font)
        if score < 1000 then
          love.graphics.print(math.floor(score), 650, 50,0,1,1) -- pontuação do jogador
        else
          love.graphics.print(math.floor(score), 620, 50,0,1,1)
        end
           
        --love.graphics.setColor(255, 255, 255)
        --love.graphics.setFont(snap_itc_font)
        --love.graphics.print(#Dinos, 400, 100, 0, 1, 1)
      
        --love.graphics.setColor(255, 255, 255)
        --love.graphics.setFont(snap_itc_font)
        --love.graphics.print(#Yetis, 400, 300, 0, 1, 1)
      
        --love.graphics.setColor(255, 255, 255)
        --love.graphics.setFont(snap_itc_font)
        --love.graphics.print(yeti_jump, 400, 300, 0, 1, 1)
      
        --love.graphics.setColor(255, 255, 255)
        --love.graphics.setFont(snap_itc_font)
        --love.graphics.print(Boss1Damage, 400, 300, 0, 1, 1)
        
        --love.graphics.setColor(255, 255, 255)
        --love.graphics.setFont(snap_itc_font)
        --love.graphics.print(Boss2.HP, 400, 300, 0, 1, 1)
        --love.graphics.print(Boss1Damage, 400, 100)
                
        -- love.graphics.setColor(255, 255, 255)
        --love.graphics.setFont(snap_itc_font)
        --love.graphics.print(vextraX, 400, 50, 0, 1, 1)
          
        --Hitbox dos Dinos
        --[[love.graphics.setColor(255,0,0,190)
        love.graphics.rectangle("fill",v.x,v.y,v.width - 171, v.height-100)
        love.graphics.rectangle("fill",v.x + 55,v.y + 30,v.width - 165, v.height - 30)

        love.graphics.setColor(255,0,255,190)
        love.graphics.rectangle("fill",v.x + 100 ,v.y + 35,v.width - 100, v.height-97)]]
        
        Fade1.draw()
       
      elseif gameover == true then -- fim do jogo
        love.audio.setVolume(0)
        love.graphics.setColor(100,100,255,255)
        love.graphics.draw(floresta_imag, 10 - vbg, 0,0 , 2.1, 2.1 ) --  plano de fundo da tela de 'game over'
  
        love.graphics.setColor(255,255,255)
        love.graphics.setFont(snap_itc_font)
        love.graphics.print("Score: ".. math.floor(score), 250, 400, 0 , 1, 1) -- pontuação do jogador expressa como arredondamento para o primeiro número inteiro menor que o valor
       
        love.graphics.setColor(255,255,255)
        love.graphics.draw(gameover_imag.imag, gameover_imag.x, gameover_imag.y, 0, 1, 1)
        love.graphics.draw(playagain_imag.imag, playagain_imag.x, playagain_imag.y, 0, 1, 1)
      end
    end
    end
  end
end          
  
function love.keypressed(key, scancode, isrepeat) -- pulo
  if key == " " or key == "space" then
    if y_velocity == 0 then -- Quando Tycon estiver no solo, estará disponível para executar o pulo
      y_velocity = jump_height
    end
    
    if estagio == 2 and yeti_velocity==0  then      
      if yeti_jump % 2 == 1 then
        yeti_velocity = jump_height*1.333
      end
    end
  end
  if key == "return" and (inicio == true) then
    inicio = false
    gameover = false
    score = 0
  end
  if  key == "return" and gameover == true then
    reiniciajogo()
  end
end

function love.mousepressed(x, y, button)
  if inicio == true then
    if (button == "l" or button == 1) and x > play_imag.x and x < play_imag.x + play_imag.imag:getWidth() and y > play_imag.y and y < play_imag.y + play_imag.imag:getHeight() then
      inicio = false
      gameover = false
      score = 0
    end 
    if (button == "l" or button == 1) and x > 280 and x < 500 and y > 400 and y < 460 then
      inicio = false
      ranking = true
      
    end
    if (button == "l" or button == 1) and x > 300 and x < 500 and y > 500 and y < 560 then
      inicio = false
      credit = true
      
    end
  end
  if credit == true then
    if (button == "l" or button == 1) and x > 650 and x < 800 and y > 530 and y < 600 then  --back
      inicio = true
      credit = false
      score = 0
    end
  end
  if ranking == true then
    if (button == "l" or button == 1) and x > 650 and x < 800 and y > 530 and y < 600 then
      inicio = true
      ranking = false
      score = 0
    end
  end
  if gameover == true then
    if (button == "l" or button == 1) and x > playagain_imag.x and x < playagain_imag.x + playagain_imag.imag:getWidth() and y > playagain_imag.y and y < playagain_imag.y + playagain_imag.imag:getHeight() then
      reiniciajogo()
    end
  end
  if gameover == false then
   if BossMove == 1 then
    if (button == "l" or button == 1) and y < 450 and x > Tycon.x + 130 and Flame.x == Tycon.x + 70  then
      Tycon.power = 1
      shoot = true
      love.audio.play(FlameEffect)
      Click = false
      --love.audio.play(FlameEffect)
      Att = 100 -- tempo inicial da duração do ataque d Tycon
      Flame_Travelx = x - Tycon.x + 70 + vextraX * Tycon.speed*5/3
      Flame_Travely = y - Tycon.y - 20      
    end
   elseif BossMove == 2 and shoot == false then
     if (button == "l" or button == 1) then
       Tycon.power = 2
       Boom.x = Tycon.x + 70
       Boom.acc = 30
       shoot = true
       Click = false
       Att = 100
              
       end
       
       
       
       
   end 
  end
end


