function checarSetas()
  return love.keyboard.isDown("left") or love.keyboard.isDown("right") or love.keyboard.isDown("up") or love.keyboard.isDown("down")
end

function atirar()
  if hero.fire_time > 0.3 then
    if love.keyboard.isDown("down") then
      if hero.shot == 0 then 
      table.insert(tiro,{pox = hero.pos_x + 16,poy = hero.pos_y + 32,vex = 0,vey = 1, xOriginal = hero.pos_x, yOriginal = hero.pos_y, tipo = 1 }) 
        if hero.shot == 1 or hero.snip == 1 or hero.met == 1 and hero.balas > 0 then
          hero.balas = hero.balas - 1
        end
      	love.audio.play(somtiro)
      else
        for x = 0.2, -0.2, -0.1 do 
          table.insert(tiro,{pox = hero.pos_x + 16,poy = hero.pos_y + 32,vex = x,vey = 1, xOriginal = hero.pos_x, yOriginal = hero.pos_y, tipo = 2 })
          if hero.shot == 1 or hero.snip == 1 or hero.met == 1 and hero.balas > 0 then
          hero.balas = hero.balas - 1
          end
        end
        love.audio.play(somtiro)
      end
      hero.fire_time = 0
    elseif love.keyboard.isDown("left") then
      if hero.shot == 0 then
        table.insert(tiro,{pox = hero.pos_x + 16,poy = hero.pos_y + 20 ,vex = -1,vey = 0, xOriginal = hero.pos_x, yOriginal = hero.pos_y, tipo = 1})
        if hero.shot == 1 or hero.snip == 1 or hero.met == 1 and hero.balas > 0 then
          hero.balas = hero.balas - 1
        end
        love.audio.play(somtiro)
      else
        for x = 0.2, -0.2, -0.1 do 
          table.insert(tiro,{pox = hero.pos_x + 16,poy = hero.pos_y + 20,vex = -1,vey = x, xOriginal = hero.pos_x, yOriginal = hero.pos_y, tipo = 2 })
          if hero.shot == 1 or hero.snip == 1 or hero.met == 1 and hero.balas > 0 then
            hero.balas = hero.balas - 1
          end
        end
        love.audio.play(somtiro)
      end
      hero.fire_time = 0
    elseif love.keyboard.isDown("right") then
      if hero.shot == 0 then
        table.insert(tiro,{pox = hero.pos_x + 16,poy = hero.pos_y + 20 ,vex = 1,vey = 0, xOriginal = hero.pos_x , yOriginal = hero.pos_y, tipo = 1})
        if hero.shot == 1 or hero.snip == 1 or hero.met == 1 and hero.balas > 0 then
          hero.balas = hero.balas - 1
        end
        love.audio.play(somtiro)
      else
        for x = 0.2, -0.2, -0.1 do 
          table.insert(tiro,{pox = hero.pos_x + 16,poy = hero.pos_y + 20,vex = 1,vey = x, xOriginal = hero.pos_x, yOriginal = hero.pos_y, tipo = 2 })
          if hero.shot == 1 or hero.snip == 1 or hero.met == 1 and hero.balas > 0 then
            hero.balas = hero.balas - 1
          end
        end
        love.audio.play(somtiro)
      end
      hero.fire_time = 0
    elseif love.keyboard.isDown("up") then
      if hero.shot == 0 then 
        table.insert(tiro,{pox = hero.pos_x + 16,poy = hero.pos_y,vex = 0,vey = -1, xOriginal = hero.pos_x , yOriginal = hero.pos_y, tipo = 1})
        if hero.shot == 1 or hero.snip == 1 or hero.met == 1 and hero.balas > 0 then
          hero.balas = hero.balas - 1
        end
        love.audio.play(somtiro)
      else
        for x = 0.2, -0.2, -0.1 do 
          table.insert(tiro,{pox = hero.pos_x + 16,poy = hero.pos_y,vex = x,vey = -1, xOriginal = hero.pos_x, yOriginal = hero.pos_y, tipo = 2 })
          if hero.shot == 1 or hero.snip == 1 or hero.met == 1 and hero.balas > 0 then
            hero.balas = hero.balas - 1
          end
        end
      love.audio.play(somtiro)
      end
      hero.fire_time = 0
    end
  end
end

function love.keypressed(key)
  if key == "c" then
    if hero.arma == 2 then
      hero.arma = 1
     else hero.arma = 2 
    end
  end
end
function movTiro(dt)
  for i = #tiro, 1, -1 do
    tiro[i].pox = tiro[i].pox + (300 * dt * tiro[i].vex*hero.firerate)
    tiro[i].poy = tiro[i].poy + (300 * dt * tiro[i].vey*hero.firerate)
    if tiro[i].tipo == 1 then
      if (tiro[i].poy > tiro[i].yOriginal + 360 and tiro[i].vey > 0 ) or (tiro[i].pox  > tiro[i].xOriginal + 360 and tiro[i].vex > 0) or (tiro[i].poy < tiro[i].yOriginal - 360 and tiro[i].vey < 0 ) or (tiro[i].pox < tiro[i].xOriginal - 360 and tiro[i].vex < 0 ) then
        table.remove(tiro, i )
      end
    else
      if (tiro[i].poy > tiro[i].yOriginal + 360 and tiro[i].vey > 0) or (tiro[i].pox  > tiro[i].xOriginal + 360 and tiro[i].vex > 0) or (tiro[i].poy < tiro[i].yOriginal - 360 and tiro[i].vey < 0 ) or (tiro[i].pox < tiro[i].xOriginal - 360 and tiro[i].vex < 0 )  then
        table.remove(tiro, i )
      end  
    end
  end
end

function qualSeta()
  checar = 1
  if love.keyboard.isDown("down") then 
    hero.anim_frame = hero.anim_frame
    if hero.anim_frame > 3 then
      hero.anim_frame = 1
    end
  elseif love.keyboard.isDown("left") then 
    hero.anim_frame = hero.anim_frame
    if hero.anim_frame > 6 or hero.anim_frame < 4 then
      hero.anim_frame = 4
    end
  elseif love.keyboard.isDown("right") then 
    hero.anim_frame = hero.anim_frame
    if hero.anim_frame > 9 or hero.anim_frame < 7 then
      hero.anim_frame = 7
    end
  elseif love.keyboard.isDown("up") then
     hero.anim_frame = hero.anim_frame
    if hero.anim_frame > 12 or hero.anim_frame < 10 then
      hero.anim_frame = 10
    end
  end
end
