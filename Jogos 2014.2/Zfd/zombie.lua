
local numdezumbis
local zombiespawncount

function LoadZombies(numdezumbis)
  for i=0, numdezumbis, 1 do
    zombie[i] = {
    anim_frame = 1,
    pos_x = love.math.random(-50,1100),
    pos_y = love.math.random(-50,800),
    anim_time = 0,
    zombie_spawn = love.math.random(0,500),
    zombieinmap = 0,
    ztype = love.math.random(1,10), -- 2 dano, 3 rapido, resto Normal
    height = 32,
    width = 32,
    vel = 1,
    hp = 100,
    walk = {},
    zombiedead = 0,
    pontuado = 0,
    stuck = 0,
    }

  
   if zombie[i].ztype == 2 then
     zombie[i].height = 43
     zombie[i].width = 43
     zombie[i].hp = 200
   end
   
   if zombie[i].ztype == 3 then
     zombie[i].vel = 1.5
   end
   
   
  if zombie[i].pos_y > -50 and zombie[i].pos_y < 800 then
    while zombie[i].pos_x > -50 and zombie[i].pos_x < 1100 do
      zombie[i].pos_x = love.math.random(-50,1100)
    end
  end
  
  if zombie[i].pos_x > -50 and zombie[i].pos_x < 1100 then
    while zombie[i].pos_y > 0 and zombie[i].pos_y < 1100 do
      zombie[i].pos_y = love.math.random(-50,800)
    end
  end
  end
end


function resetZombie(i)
  zombie[i].pos_x = love.math.random(-50,1100)
  zombie[i].pos_y = love.math.random(-50,800)
  if zombie[i].pos_x > -50 and zombie[i].pos_x < 1100 then
    while zombie[i].pos_y > 0 and zombie[i].pos_y < 1100 do
     zombie[i].pos_y = love.math.random(-50,800)
    end
  end
  if zombie[i].pos_y > -50 and zombie[i].pos_y < 800 then
    while zombie[i].pos_x > -50 and zombie[i].pos_x < 1100 do
     zombie[i].pos_x = love.math.random(-50,1100)
    end
   end
 end
      
function ColisaoTiroZumbi(numdezumbis)
  for i = 0, numdezumbis, 1 do
    for j = #tiro, 1, -1 do
      if CheckCollision(zombie[i].pos_x,zombie[i].pos_y,zombie[i].height,zombie[i].width, tiro[j].pox,tiro[j].poy, 3,3) and zombie[i].zombieinmap == 1 then
        zombie[i].hp = zombie[i].hp - hero.dano
        table.remove(tiro,j)
        if zombie[i].hp <= 0 and zombie[i].pontuado == 0 then
          if zombie[i].ztype == 3 then
            scorecount = scorecount + 50
          elseif zombie[i].ztype == 2 then
            scorecount = scorecount + 25
          else
            scorecount = scorecount + 10
          end
          zombie[i].pontuado = 1
          zumbismortos = zumbismortos + 1
        end
      end
    end
  end
end
 
      
function movimentozumbi(nzumbis,dt)
  for i=0, nzumbis, 1 do
     
    zombiespawncount = love.math.random(0,500)  --raridade dos spawns
     
    if zombie[i].zombie_spawn == zombiespawncount then
      zombie[i].zombieinmap = 1
    end
    
    if zombie [i].zombieinmap == 1 then
        if zombie[i].pos_x > hero.pos_x  then
          colidiu=0
          for j=0,nzumbis,1 do
            if CheckCollision(zombie[i].pos_x- (50*dt*zombie[i].vel), zombie[i].pos_y, zombie[i].width,zombie[i].height, zombie[j].pos_x, zombie[j].pos_y, zombie[j].width,zombie[j].height) and i~=j and zombie[i].zombieinmap == 1 and zombie[j].zombieinmap == 1 then
              colidiu = colidiu +1
            end
          end
          if colidiu == 0 then
            if not (CheckCollision(zombie[i].pos_x - (50 * dt * zombie[i].vel),zombie[i].pos_y,zombie[i].width,zombie[i].height,arvore1pos_x,arvore1pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(zombie[i].pos_x - (50 * dt * zombie[i].vel ),zombie[i].pos_y ,zombie[i].width,zombie[i].height,arvore2pos_x,arvore2pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(zombie[i].pos_x - (50 * dt *zombie[i].vel), zombie[i].pos_y ,zombie[i].width,zombie[i].height,arvore3pos_x,arvore3pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(zombie[i].pos_x - (50 * dt *zombie[i].vel), zombie[i].pos_y, zombie[i].width,zombie[i].height,arvore4pos_x,arvore4pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(zombie[i].pos_x - (50 * dt *zombie[i].vel ),zombie[i].pos_y,zombie[i].width,zombie[i].height,arvorerosapos_x,arvorerosapos_y,arvorerosaheight,arvorerosawidth)) then
              zombie[i].pos_x = zombie[i].pos_x - (50*dt*zombie[i].vel) -- lado direito
            end
            zombie[i].stuck = 0
          else
            zombie[i].stuck = zombie[i].stuck + dt
          end
          if math.abs(hero.pos_x - zombie[i].pos_x) > math.abs(hero.pos_y - zombie[i].pos_y) then
            if zombie[i].anim_frame < 4 or zombie[i].anim_frame > 6  then 
              zombie[i].anim_frame = 4
            end
            zombie[i].anim_time = zombie[i].anim_time + dt 
            if zombie[i].anim_time > 0.1 then 
              zombie[i].anim_frame = zombie[i].anim_frame + 1
              if zombie[i].anim_frame > 6 then
                zombie[i].anim_frame = 4
              end
              zombie[i].anim_time = 0 
            end
          end
        elseif zombie[i].pos_x < hero.pos_x then
          colidiu=0
          for j=0,nzumbis,1 do
            if CheckCollision(zombie[i].pos_x+ (50*dt*zombie[i].vel), zombie[i].pos_y, zombie[i].width,zombie[i].height, zombie[j].pos_x, zombie[j].pos_y, zombie[j].width,zombie[j].height) and i~=j and zombie[i].zombieinmap == 1 and zombie[j].zombieinmap == 1 then
              colidiu = colidiu +1
            end
          end
          if colidiu == 0 then
            if not (CheckCollision(zombie[i].pos_x + (50 * dt * zombie[i].vel),zombie[i].pos_y,zombie[i].width,zombie[i].height,arvore1pos_x,arvore1pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(zombie[i].pos_x + (50 * dt * zombie[i].vel ),zombie[i].pos_y ,zombie[i].width,zombie[i].height,arvore2pos_x,arvore2pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(zombie[i].pos_x + (50 * dt *zombie[i].vel), zombie[i].pos_y ,zombie[i].width,zombie[i].height,arvore3pos_x,arvore3pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(zombie[i].pos_x + (50 * dt *zombie[i].vel), zombie[i].pos_y, zombie[i].width,zombie[i].height,arvore4pos_x,arvore4pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(zombie[i].pos_x + (50 * dt *zombie[i].vel ),zombie[i].pos_y,zombie[i].width,zombie[i].height,arvorerosapos_x,arvorerosapos_y,arvorerosaheight,arvorerosawidth)) then
              zombie[i].pos_x = zombie[i].pos_x + (50 * dt* zombie[i].vel)
            end
          else
            zombie[i].stuck = zombie[i].stuck + dt
          end
          if math.abs(hero.pos_x - zombie[i].pos_x) > math.abs(hero.pos_y - zombie[i].pos_y) then
            if zombie[i].anim_frame < 7 or zombie[i].anim_frame > 9 then  
              zombie[i].anim_frame = 7
            end
            zombie[i].anim_time = zombie[i].anim_time + dt 
            if zombie[i].anim_time > 0.1 then 
              zombie[i].anim_frame = zombie[i].anim_frame + 1
              if zombie[i].anim_frame > 9 then
                zombie[i].anim_frame = 7
              end
              zombie[i].anim_time = 0   
            end
          end
        end
        if zombie[i].pos_y > hero.pos_y then
          colidiu=0
          for j=0,nzumbis,1 do
            if CheckCollision(zombie[i].pos_x, zombie[i].pos_y- (50*dt*zombie[i].vel), zombie[i].width,zombie[i].height, zombie[j].pos_x, zombie[j].pos_y, zombie[j].width,zombie[j].height) and i~=j and zombie[i].zombieinmap == 1 and zombie[j].zombieinmap == 1 then
              colidiu = colidiu +1
            end
          end
          if colidiu == 0 then
            if not (CheckCollision(zombie[i].pos_x, zombie[i].pos_y - (50 * dt * zombie[i].vel),zombie[i].width,zombie[i].height,arvore1pos_x,arvore1pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(zombie[i].pos_x,zombie[i].pos_y - (50 * dt * zombie[i].vel ),zombie[i].width,zombie[i].height,arvore2pos_x,arvore2pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(zombie[i].pos_x, zombie[i].pos_y - (50 * dt *zombie[i].vel),zombie[i].width,zombie[i].height,arvore3pos_x,arvore3pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision( zombie[i].pos_x, zombie[i].pos_y - (50 * dt *zombie[i].vel),  zombie[i].width,zombie[i].height,arvore4pos_x,arvore4pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(zombie[i].pos_x, zombie[i].pos_y - (50 * dt *zombie[i].vel ),zombie[i].width,zombie[i].height,arvorerosapos_x,arvorerosapos_y,arvorerosaheight,arvorerosawidth)) then
              zombie[i].pos_y = zombie[i].pos_y - (50*dt*zombie[i].vel)
            end
          else
            zombie[i].stuck = zombie[i].stuck + dt
          end
          if math.abs(hero.pos_x - zombie[i].pos_x) < math.abs(hero.pos_y - zombie[i].pos_y) then
            if zombie[i].anim_frame < 10 or zombie[i].anim_frame > 12 then
              zombie[i].anim_frame = 10
            end
            zombie[i].anim_time = zombie[i].anim_time + dt
            if zombie[i].anim_time > 0.1 then
              zombie[i].anim_frame = zombie[i].anim_frame + 1
              if zombie[i].anim_frame > 12  then
                zombie[i].anim_frame = 10
              end
              zombie[i].anim_time = 0
            end
          end
        elseif zombie[i].pos_y < hero.pos_y then
          colidiu=0
          for j=0,nzumbis,1 do
            if CheckCollision(zombie[i].pos_x, zombie[i].pos_y+ (50*dt*zombie[i].vel), zombie[i].width,zombie[i].height, zombie[j].pos_x, zombie[j].pos_y, zombie[j].width,zombie[j].height) and i~=j and zombie[i].zombieinmap == 1 and zombie[j].zombieinmap == 1 then
              colidiu = colidiu +1
            end
          end
          if colidiu == 0 then
            if not (CheckCollision(zombie[i].pos_x, zombie[i].pos_y + (50 * dt * zombie[i].vel),zombie[i].width,zombie[i].height,arvore1pos_x,arvore1pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(zombie[i].pos_x,zombie[i].pos_y + (50 * dt * zombie[i].vel ),zombie[i].width,zombie[i].height,arvore2pos_x,arvore2pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(zombie[i].pos_x, zombie[i].pos_y + (50 * dt *zombie[i].vel),zombie[i].width,zombie[i].height,arvore3pos_x,arvore3pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision( zombie[i].pos_x, zombie[i].pos_y + (50 * dt *zombie[i].vel),  zombie[i].width,zombie[i].height,arvore4pos_x,arvore4pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(zombie[i].pos_x, zombie[i].pos_y + (50 * dt *zombie[i].vel ),zombie[i].width,zombie[i].height,arvorerosapos_x,arvorerosapos_y,arvorerosaheight,arvorerosawidth)) then
              zombie[i].pos_y = zombie[i].pos_y + (50*dt*zombie[i].vel)
            end
          else
            zombie[i].stuck = zombie[i].stuck + dt
           end
          if math.abs(hero.pos_x - zombie[i].pos_x) < math.abs(hero.pos_y - zombie[i].pos_y) then
            if zombie[i].anim_frame < 1 or zombie[i].anim_frame > 3 then
              zombie[i].anim_frame = 1
            end
            zombie[i].anim_time = zombie[i].anim_time + dt
            if zombie[i].anim_time > 0.1 then
                zombie[i].anim_frame = zombie[i].anim_frame + 1
                if zombie[i].anim_frame > 3  then
                  zombie[i].anim_frame = 1
                end
            zombie[i].anim_time = 0
            end
          end
        end
    end

    if CheckCollision(zombie[i].pos_x, zombie[i].pos_y, zombie[i].width, zombie[i].height, hero.pos_x, hero.pos_y, 32,32) and zombie[i].zombieinmap == 1 then
      hero.hp = math.floor(hero.hp - (30*dt))
    end
    
    if zombie[i].hp <= 0 then
      zombie[i].zombieinmap = 0
    end
    
    if zombie[i].stuck > 10 then
      resetZombie(i)
    end
  end
end