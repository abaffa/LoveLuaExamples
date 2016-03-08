function beerpong_load()
 love.window.setTitle("College Rivals")
 beerpong_resultados = love.graphics.newImage("fase_beerpong/beerpong_resultados.png")
 copo = love.graphics.newImage("fase_beerpong/copo.png")
 background = love.graphics.newImage("fase_beerpong/fundo.png")
 cheio = love.graphics.newImage("fase_beerpong/copo_2.png")
 ball = love.graphics.newImage("fase_beerpong/bola.png")
 mao = love.graphics.newImage("fase_beerpong/mao.png")
 inst = love.graphics.newImage("fase_beerpong/inst.png")
 teste = 0
 copo_ = {}
 beerpong_state = 1
 scoretimer = 0
 uu = {}
  bola = {
   Xp,
   Yp,
   pos_x = 190,
   pos_y = 440,
  }
 state1 = false
 state2= false
 vv = 0
 acertos=0
 time= 0
 b = 1
 uu = love.math.random(1,6)
 uu2 = love.math.random(1,6)
 uu3 = love.math.random(1,6)
 uu4 = love.math.random(1,6)
 uu5 = love.math.random(1,6)
 uu6 = love.math.random(1,6)
 uu7 = love.math.random(1,6)
 uu8 = love.math.random(1,6)
 uu9 = love.math.random(1,6)
 uu10 = love.math.random(1,6)
 uu11 = love.math.random(1,6)
 uu12 = love.math.random(1,6)
 beerpong_click = 0
end
function beerpong1_mousepressed(x,y,button)
  if beerpong_click == 0 and button == 1 then
    beerpong_click = 1
  end
end
function beerpong_mousereleased(x,y,button)
  if beerpong_click == 1 and button == 1 then
   beerpong_click = 0
  end
end
function beerpong_check_mouse(mousex,mousey,x,hx,y,hy)
  return mousex < x + hx and mousey < y + hy and x < mousex + 1 and y < mousey + 1
end
function beerpong2_mousepressed(x,y,button)
  if button == 1 and state1 == false then
   state1=true
   bola.Xp = love.mouse.getX()
   bola.Yp = love.mouse.getY()
  end
end
function beerpong_score_calculator(x)
  local y
  if x >= 12 then
   y = acertos*496/6 + (500 - 42*(x - 12))
  end
  return y
end
function beerpong_update(dt)
 time = time + dt 
  if beerpong_state == 1 then
   scoretimer = scoretimer + dt
    if state1 == true and time > 2.6 then
     frame = 12*dt
     Final_Y = (bola.Yp - bola.pos_y)
     Final_X = (bola.Xp - bola.pos_x)
     bola.pos_x = bola.pos_x + Final_X*frame
     bola.pos_y = bola.pos_y + Final_Y*frame
     teste = teste + dt
    end
    if teste > 1 then
     bola.pos_x = 190
     bola.pos_y = 440
     state1=false
     teste = 0
    end
    if time >= 1.5 then
     b = 0
    end  
    if time > 2.4 then
     m = uu
    end  
    if time > 3.4 then
     uu = vv
    end
    if time > 4.4 then
     vv = uu2
    end  
    if time> 5.4 then
     uu2 = vv2
    end  
    if time >6.4 then
     vv2 = uu3
    end  
    if time>7.4 then
     uu3 = vv3
    end  
    if time >8.4 then
     vv3 = uu4
    end
    if time>9.4 then
     uu4 = vv4
    end  
    if time >10.4 then
     vv4 = uu5
    end  
    if time>11.4 then
     uu5 = vv5
    end  
    if time>12.4 then
     vv5 = uu6
    end 
    if time>13.4 then
     uu6 = vv6
    end 
    if time>14.4 then
     vv6 = uu7
    end  
    if time>15.4 then
     uu7 = vv7
    end  
    if time>16.4 then
     vv7 = uu8
    end  
    if time>17.4 then
     uu8 = vv8
    end  
    if time>18.4 then
     vv8 = uu9
    end 
    if time>19.4 then
     uu9 = vv9
    end 
    if time>20.4 then
     vv9 = uu10
    end  
    if time>21.4 then
     uu10 = vv10
    end  
    if time>22.4 then
     vv10 = uu11
    end  
    if time>23.4 then
     uu11 = vv11
    end  
    if time>24.4 then
     vv11 = uu12
    end  
    if time>25.4 then
     uu12 = vv12
    end
    if bola.pos_x > 130 and bola.pos_x < 300 and bola.pos_y > 164 and bola.pos_y < 190 and uu == 1 then
     state2 = true
    end
    if bola.pos_x > 310 and bola.pos_x < 480 and bola.pos_y > 164 and bola.pos_y < 190 and uu == 2 then
     state2 = true
    end
    if bola.pos_x > 490 and bola.pos_x < 660 and bola.pos_y > 164 and bola.pos_y < 190 and uu == 3 then
     state2 = true
    end
    if bola.pos_x > 220 and bola.pos_x < 390 and bola.pos_y > 214 and bola.pos_y < 240 and uu == 4 then
     state2 = true
    end
    if bola.pos_x > 400 and bola.pos_x < 570 and bola.pos_y > 214 and bola.pos_y < 240 and uu == 5 then
     state2 = true
    end
    if bola.pos_x > 310  and bola.pos_x < 480 and bola.pos_y > 264 and bola.pos_y < 290 and uu == 6 then
     state2 = true
    end
    if state2 == true and teste > 0.8 then
     acertos = acertos + 1
     state2 = false
    end
   beerpong_score_calculator(scoretimer)
    if scoretimer >= 24 or (scoretimer >= 12 and acertos == 6) then
     beerpong_state = 2
    end
  elseif beerpong_state == 2 then
    if beerpong_check_mouse(love.mouse.getX(),love.mouse.getY(),190,260,330,40) then
     if beerpong_click == 1 then
       gamestate = 5
      end
    end
    if beerpong_check_mouse(love.mouse.getX(),love.mouse.getY(),500,120,330,40) then
     if beerpong_click == 1 then
       love.event.push("quit")
      end
    end
  end
end
function beerpong_draw() 
  if beerpong_state == 1 then
   love.graphics.setColor(255,255,255)
   love.graphics.draw(background)
   love.graphics.draw(copo,120,120)
   love.graphics.draw(copo,300,120)
   love.graphics.draw(copo,480,120)
   love.graphics.draw(copo,210,170)
   love.graphics.draw(copo,390,170)
   love.graphics.draw(copo,300,220)
   love.graphics.print("Acertos  " ..  acertos .. "",10,10) 
    if uu == 1 then
     love.graphics.draw(cheio,130,164)
    elseif uu == 2 then
     love.graphics.draw(cheio,310,164)
    elseif uu == 3 then
     love.graphics.draw(cheio,490,164)
    elseif uu == 4 then
     love.graphics.draw(cheio,220,214)
    elseif uu == 5 then
     love.graphics.draw(cheio,400,214)
    elseif uu == 6 then
     love.graphics.draw(cheio,310,264)  
    end
   love.graphics.draw(ball, bola.pos_x, bola.pos_y)
   love.graphics.draw(mao, 0,350)
    if b == 1 then
     love.graphics.draw(inst)
    end
  elseif beerpong_state == 2 then
   love.graphics.setColor(255,255,255)
   love.graphics.draw(beerpong_resultados,0,0)
   love.graphics.setColor(0,0,0)
   love.graphics.print("SCORE "..math.ceil(tonumber(beerpong_score_calculator(scoretimer))).."",250,250) 
    if beerpong_check_mouse(love.mouse.getX(),love.mouse.getY(),190,260,330,40) then
     love.graphics.setColor(255,255,0)
     love.graphics.print("CONTINUE",190,330)
    else
     love.graphics.print("CONTINUE",190,330)
    end
    if beerpong_check_mouse(love.mouse.getX(),love.mouse.getY(),500,120,330,40) then
     love.graphics.setColor(255,255,0)
     love.graphics.print("QUIT",500,330)
    else
     love.graphics.setColor(0,0,0)
     love.graphics.print("QUIT",500,330) 
    end    
  end
end