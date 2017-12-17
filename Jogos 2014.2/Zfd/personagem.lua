hero= {
 walk = {},
 arma = 1,
 anim_frame = 1,
 pos_x = 400,
 pos_y = 300,
 anim_time = 0,
 fire_time = 0,
 firerate = 1,
 balas = 0,
 met = 0,
 shot = 0,
 snip = 0,
 dano = 25,
 vel = 1.25,
 hp = 300
}

function movimento(dir, dt)
    if dir == 1 then
      if not (CheckCollision(hero.pos_x + (100 * dt * hero.vel),hero.pos_y,32,32,arvore1pos_x,arvore1pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(hero.pos_x + (100 * dt * hero.vel),hero.pos_y ,32,32,arvore2pos_x,arvore2pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(hero.pos_x + (100 * dt * hero.vel), hero.pos_y ,32,32,arvore3pos_x,arvore3pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(hero.pos_x + (100 * dt * hero.vel), hero.pos_y, 32,32,arvore4pos_x,arvore4pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(hero.pos_x + (100 * dt * hero.vel),hero.pos_y,32,32,arvorerosapos_x,arvorerosapos_y,arvorerosaheight,arvorerosawidth) ) then
          if (hero.anim_frame < 7 or hero.anim_frame > 9) and not checarSetas() then
            hero.anim_frame = 7
          else qualSeta()
          end
        hero.pos_x = hero.pos_x + (100 * dt * hero.vel)
        hero.anim_time = hero.anim_time + dt 
        if hero.anim_time > 0.1 then 
          hero.anim_frame = hero.anim_frame + 1
          if hero.anim_frame > 9  and not checarSetas() then
            hero.anim_frame = 7
          else qualSeta()
          end
          hero.anim_time = 0 
        end
      end
    elseif dir == 2 then
      if not (CheckCollision(hero.pos_x - (100 * dt * hero.vel),hero.pos_y,32,32,arvore1pos_x,arvore1pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(hero.pos_x - (100 * dt * hero.vel),hero.pos_y ,32,32,arvore2pos_x,arvore2pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(hero.pos_x - (100 * dt * hero.vel), hero.pos_y ,32,32,arvore3pos_x,arvore3pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(hero.pos_x - (100 * dt * hero.vel), hero.pos_y, 32,32,arvore4pos_x,arvore4pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(hero.pos_x - (100 * dt * hero.vel),hero.pos_y,32,32,arvorerosapos_x,arvorerosapos_y,arvorerosaheight,arvorerosawidth)) then
        if (hero.anim_frame < 4 or hero.anim_frame > 6) and not checarSetas() then  
          hero.anim_frame = 4
          else qualSeta()
        end
        hero.pos_x = hero.pos_x - (100 * dt * hero.vel)
        hero.anim_time = hero.anim_time + dt 
        if hero.anim_time > 0.1 then 
          hero.anim_frame = hero.anim_frame + 1
          if hero.anim_frame > 6 and not checarSetas() then
            hero.anim_frame = 4
          else qualSeta()
          end
          hero.anim_time = 0 
        end
      end
    elseif dir == 3 then
      if not (CheckCollision(hero.pos_x,hero.pos_y - (100 * dt * hero.vel),32,32,arvore1pos_x,arvore1pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(hero.pos_x,hero.pos_y - (100 * dt * hero.vel),32,32,arvore2pos_x,arvore2pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(hero.pos_x,hero.pos_y - (100 * dt * hero.vel),32,32,arvore3pos_x,arvore3pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(hero.pos_x,hero.pos_y - (100 * dt * hero.vel),32,32,arvore4pos_x,arvore4pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(hero.pos_x, hero.pos_y - (100 * dt * hero.vel),32,32,arvorerosapos_x,arvorerosapos_y,arvorerosaheight,arvorerosawidth)) then
        if (hero.anim_frame < 10 or hero.anim_frame > 12) and not checarSetas() then
          hero.anim_frame = 10
          else qualSeta()
        end
        hero.pos_y = hero.pos_y - (100 * dt * hero.vel)
        hero.anim_time = hero.anim_time + dt
        if hero.anim_time > 0.1 then
          hero.anim_frame = hero.anim_frame + 1
          if hero.anim_frame > 12 and not checarSetas() then
            hero.anim_frame = 10
            else qualSeta()
          end
          hero.anim_time = 0
        end
      end
    elseif dir == 4 then
      if not (CheckCollision(hero.pos_x,hero.pos_y + (100 * dt * hero.vel),32,32,arvore1pos_x,arvore1pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(hero.pos_x,hero.pos_y + (100 * dt * hero.vel),32,32,arvore2pos_x,arvore2pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(hero.pos_x,hero.pos_y + (100 * dt * hero.vel),32,32,arvore3pos_x,arvore3pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(hero.pos_x,hero.pos_y + (100 * dt * hero.vel),32,32,arvore4pos_x,arvore4pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(hero.pos_x, hero.pos_y + (100 * dt * hero.vel),32,32,arvorerosapos_x,arvorerosapos_y,arvorerosaheight,arvorerosawidth)) then
        if (hero.anim_frame < 1 or hero.anim_frame > 3) and not checarSetas() then
          hero.anim_frame = 1
        else qualSeta()
        end
        hero.pos_y = hero.pos_y + (100 * dt * hero.vel)
        hero.anim_time = hero.anim_time + dt
        if hero.anim_time > 0.1 then
          hero.anim_frame = hero.anim_frame + 1
          if hero.anim_frame > 3 and not checarSetas() then
            hero.anim_frame = 1
            else qualSeta()
          end
          hero.anim_time = 0
        end
      end
    end
  end 

      