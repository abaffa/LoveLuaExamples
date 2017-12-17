function powerupspawn()
  
  spawnnumero = love.math.random(0,10000) -- raridade dos spawns
   
  if Met.numero == spawnnumero then
    Met.nomapa = 1
  end

  if CheckCollision(hero.pos_x,hero.pos_y,32,32, Met.pos_x,Met.pos_y,12,12)and Met.nomapa == 1 then
    Met.equipada = 1
    Met.nomapa = 0
    hero.met = 1
    hero.balas = 100
    Met.pos_x = love.math.random(100,900)
    Met.pos_y = love.math.random(50,750)
    love.audio.play(somarma)
    if Shot.equipada == 1 then
      Shot.equipada = 0 
      hero.shot = 0
    end
    if Snip.equipada == 1 then
      Snip.equipada = 0
      hero.snip = 0
    end
  end

  if Met.equipada == 1 and hero.balas == 0 then
    Met.equipada = 0
  end

  if hero.met == 1 then --habilidade da arma
    hero.firerate = 2.5 -- rapidez do tiro
  else
    hero.firerate = 1 
  end


  if Shot.numero == spawnnumero then
    Shot.nomapa = 1
  end

  if CheckCollision(hero.pos_x,hero.pos_y,32,32, Shot.pos_x,Shot.pos_y,12,12) and Shot.nomapa == 1 then
    Shot.equipada = 1
    Shot.nomapa = 0
    hero.shot = 1
    hero.balas = 100
    Shot.pos_x = love.math.random(100,900)
    Shot.pos_y = love.math.random(50,550)
    love.audio.play(somarma)
    if Met.equipada == 1 then
      Met.equipada = 0
      hero.met = 0
    end
    if Snip.equipada == 1 then
      Snip.equipada = 0
      hero.snip = 0
    end
  end

  if hero.balas == 0 and Shot.equipada == 1 then
    Shot.equipada = 0 
    hero.shot = 0
  end

    
  if Snip.numero == spawnnumero then
    Snip.nomapa = 1
  end

  if CheckCollision(hero.pos_x,hero.pos_y,32,32, Snip.pos_x,Snip.pos_y,12,12) and Snip.nomapa == 1 then
    Snip.equipada = 1
    Snip.nomapa = 0
    hero.snip = 1
    hero.balas = 30
    Snip.pos_x = love.math.random(100,700)
    Snip.pos_y = love.math.random(50,550)
    love.audio.play(somarma)
    if Met.equipada == 1 then
      Met.equipada = 0
      hero.met = 0
    end
    if Shot.equipada == 1 then
      Shot.equipada = 0
      hero.shot = 0
    end
  end

  if Snip.equipada == 1 and hero.balas == 0 then
    Snip.equipada = 0
  end

  if Snip.equipada == 1 then --habilidade da arma
    hero.dano = 100
  else
    hero.dano = hero.danooriginal
  end

  if VacPU.numero == spawnnumero then
    VacPU.nomapa = 1
  end

  if CheckCollision(hero.pos_x,hero.pos_y,32,32, VacPU.pos_x,VacPU.pos_y,12,12) and VacPU.nomapa == 1 then
    VacPU.nomapa = 0
    if hero.hp < 400 then
      hero.hp = hero.hp + 100
    else
      hero.hp = 500
    end
    VacPU.pos_x = love.math.random(100,700)
    VacPU.pos_y = love.math.random(50,550)
  end

  while (CheckCollision(Met.pos_x,Met.pos_y,12,12,arvore1pos_x,arvore1pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(Met.pos_x,Met.pos_y,12,12,arvore2pos_x,arvore2pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(Met.pos_x,Met.pos_y,12,12,arvore3pos_x,arvore3pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(Met.pos_x,Met.pos_y,12,12,arvore4pos_x,arvore4pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(Met.pos_x,Met.pos_y,12,12,arvorerosapos_x,arvorerosapos_y,arvorerosaheight,arvorerosawidth)) do 
    Met.pos_x = love.math.random(100,1000)
    Met.pos_y = love.math.random(50,700)
  end

  while (CheckCollision(Shot.pos_x,Shot.pos_y,12,12,arvore1pos_x,arvore1pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(Shot.pos_x,Shot.pos_y,12,12,arvore2pos_x,arvore2pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(Shot.pos_x,Shot.pos_y,12,12,arvore3pos_x,arvore3pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(Shot.pos_x,Shot.pos_y,12,12,arvore4pos_x,arvore4pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(Shot.pos_x,Shot.pos_y,12,12,arvorerosapos_x,arvorerosapos_y,arvorerosaheight,arvorerosawidth)) do
    Shot.pos_x = love.math.random(100,1000)
    Shot.pos_y = love.math.random(50,700)
  end

  while (CheckCollision(Snip.pos_x,Snip.pos_y,12,12,arvore1pos_x,arvore1pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(Snip.pos_x,Snip.pos_y,12,12,arvore2pos_x,arvore2pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(Snip.pos_x,Snip.pos_y,12,12,arvore3pos_x,arvore3pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(Snip.pos_x,Snip.pos_y,12,12,arvore4pos_x,arvore4pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(Snip.pos_x,Snip.pos_y,12,12,arvorerosapos_x,arvorerosapos_y,arvorerosaheight,arvorerosawidth)) do
    Snip.pos_x = love.math.random(100,1000)
    Snip.pos_y = love.math.random(50,700)
  end

  while (CheckCollision(VacPU.pos_x,VacPU.pos_y,12,12,arvore1pos_x,arvore1pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(VacPU.pos_x,VacPU.pos_y,12,12,arvore2pos_x,arvore2pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(VacPU.pos_x,VacPU.pos_y,12,12,arvore3pos_x,arvore3pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(VacPU.pos_x,VacPU.pos_y,12,12,arvore4pos_x,arvore4pos_y,arvoreverdeheight,arvoreverdewidth) or CheckCollision(VacPU.pos_x,VacPU.pos_y,12,12,arvorerosapos_x,arvorerosapos_y,arvorerosaheight,arvorerosawidth)) do
    VacPU.pos_x = love.math.random(100,1000)
    VacPU.pos_y = love.math.random(50,700)
  end
end