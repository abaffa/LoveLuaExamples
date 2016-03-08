function monLoad()

    monD = {}
	monD[1] = love.graphics.newImage("mon/monD1.png")
	monD[2] = love.graphics.newImage("mon/monD2.png")
	monD[3] = love.graphics.newImage("mon/monD3.png")

	monE = {}
	monE[1] = love.graphics.newImage("mon/monE1.png")
	monE[2] = love.graphics.newImage("mon/monE2.png")
	monE[3] = love.graphics.newImage("mon/monE3.png")

	monC = {}
	monC[1] = love.graphics.newImage("mon/monC1.png")
	monC[2] = love.graphics.newImage("mon/monC2.png")
	monC[3] = love.graphics.newImage("mon/monC3.png")

	monB = {}
	monB[1] = love.graphics.newImage("mon/monB1.png")
	monB[2] = love.graphics.newImage("mon/monB2.png")
	monB[3] = love.graphics.newImage("mon/monB3.png")

	monC_E = {}
	monC_E[1] = love.graphics.newImage("mon/monC_E1.png")
	monC_E[2] = love.graphics.newImage("mon/monC_E2.png")
	monC_E[3] = love.graphics.newImage("mon/monC_E3.png")

	monC_D = {}
	monC_D[1] = love.graphics.newImage("mon/monC_D1.png")
	monC_D[2] = love.graphics.newImage("mon/monC_D2.png")
	monC_D[3] = love.graphics.newImage("mon/monC_D3.png")

	monB_E = {}
	monB_E[1] = love.graphics.newImage("mon/monB_E1.png")
	monB_E[2] = love.graphics.newImage("mon/monB_E2.png")
	monB_E[3] = love.graphics.newImage("mon/monB_E3.png")

	monB_D = {}
	monB_D[1] = love.graphics.newImage("mon/monB_D1.png")
	monB_D[2] = love.graphics.newImage("mon/monB_D2.png")
	monB_D[3] = love.graphics.newImage("mon/monB_D3.png")

	mons = {}
	
	timerLimMon = love.math.random(4,20)
	timerMon = 20

	xrandomMon = love.math.random(1,3)

end

function mon_spawn(x, y, lv)
	table.insert(mons,
    {
      x=x,
      y=y,
      xSpeed = 500,
      ySpeed = 500,
      xvel=0,
      yvel=0,
      animtimer = 0,
      pnum = 1,
      health = lv * 50 + 50,
      image = monD[1],
      foi = 0,
      para = 0,
      paraLim = 0,
      andar = true,
      dirX = 1,
      dirY = 1,
      damage = lv * 5 + 10,
      orbes = lv * 50 + 50,
      hit = false,
      rDamage = 0,
      timeRDamage = 0,
      level = lv,
      orbFoi = 0
    });
end


function monchooseDirection(v)

  if pikachu.y + 10 < v.y then
    v.dirY = -1;
  else     
    if pikachu.y - 10 > v.y then
      v.dirY = 1;
      
    else
      v.dirY = 0;
    end
  end
  if pikachu.x + 10 < v.x then
    v.dirX = -1;
  else
    if pikachu.x - 10 > v.x then
      v.dirX = 1;
    else
      v.dirX = 0;
    end
  end
  
end


function monchooseSpeed( v )
	dist = mod(pikachu.x, pikachu.y,v.x,v.y);

	if (dist > 200) then
		if v.dirX == 1 then
			if v.dirY == 0 then
				v.image = monD[v.pnum];
			else
				if v.dirY == 1 then
					v.image = monB_D[v.pnum];
				else
					v.image = monC_D[v.pnum];
				end
			end
		else
			if v.dirX == -1 then
				if v.dirY == 0 then
					v.image = monE[v.pnum];
				else
					if v.dirY == 1 then
						v.image = monB_E[v.pnum];
					else
						v.image = monC_E[v.pnum];
					end
				end
			else
				if v.dirY == -1 then
					v.image = monC[v.pnum];
				else
					v.image = monB[v.pnum];
				end
			end
		end
		v.xSpeed = 500;
		v.ySpeed = 500;
	else
		if(dist > 100) then
			if v.dirX == 1 then
				if v.dirY == 0 then
					v.image = monD[v.pnum];
				else
					if v.dirY == 1 then
						v.image = monB_D[v.pnum];
					else
						v.image = monC_D[v.pnum];
					end
				end
			else
				if v.dirX == -1 then
					if v.dirY == 0 then
						v.image = monE[v.pnum];
					else
						if v.dirY == 1 then
							v.image = monB_E[v.pnum];
						else
							v.image = monC_E[v.pnum];
						end
					end
				else
					if v.dirY == -1 then
						v.image = monC[v.pnum];
					else
						v.image = monB[v.pnum];
					end
				end
			end
			v.xSpeed = 1500;
			v.ySpeed = 1500;

		else
			if v.dirX == 1 then
				if v.dirY == 0 then
					v.image = monD[1];
				else
					if v.dirY == 1 then
						v.image = monB_D[1];
					else
						v.image = monC_D[1];
					end
				end
			else
				if v.dirX == -1 then
					if v.dirY == 0 then
						v.image = monE[1];
					else
						if v.dirY == 1 then
							v.image = monB_E[1];
						else
							v.image = monC_E[1];
						end
					end
				else
					if v.dirY == -1 then
						v.image = monC[1];
					else
						v.image = monB[1];
					end
				end
			end
			v.xSpeed = 3000;
			v.ySpeed = 3000;
			v.andar = false;
		end
	end
end


function monMove(dt)
	for i,v in ipairs(mons) do


		if(v.para < 0.7)then
		    if(v.andar)then
		    	monchooseSpeed(v);
		    	monchooseDirection(v)
		    	v.animtimer = v.animtimer + dt;
				if v.animtimer > 0.14 then
					if v.pnum < 3 then
						v.pnum = v.pnum + 1
					else
						v.pnum = 2
					end
					v.animtimer = 0
				end
		    else
		    	v.para = v.para + dt;
			end
		else
			monchooseSpeed(v);
			v.ySpeed = 0;
			v.xSpeed = 0;
			if(v.paraLim > 1)then
				v.andar = true;
				v.para = 0;
				v.paraLim = 0;
			else
				v.paraLim = v.paraLim + dt;
			end
			
		end

		v.x = v.x + v.xvel * dt * v.dirX;
		v.y = v.y + v.yvel * dt * v.dirY;
		v.xvel = v.xvel + v.xSpeed * dt;
		v.yvel = v.yvel + v.ySpeed * dt;
		v.xvel = v.xvel * (1-math.min(dt*map.xFriction,1));
		v.yvel = v.yvel * (1-math.min(dt*map.yFriction,1));
		
		if (v.hit) then
			if(pikachu.rDamage > 0)then
				if(pikachu.timeRecoil < 0.7)then
					
					pikachu.xvelocity = pikachu.xvelocity + 2500 * dt;
					pikachu.yvelocity = pikachu.yvelocity + 2500 * dt;
					pikachu.xvelocity = pikachu.xvelocity * (1-math.min(dt*map.xFriction,1));
					pikachu.yvelocity = pikachu.yvelocity * (1-math.min(dt*map.yFriction,1));
					pikachu.x = pikachu.x + pikachu.xvelocity * dt * pikachu.dirX;
					pikachu.y = pikachu.y + pikachu.yvelocity * dt * pikachu.dirY;
					
					pikachu.timeRecoil = pikachu.timeRecoil + dt;
					pikachu.move = false;
					pikachu.life = pikachu.life - v.damage * dt;
					if(pikachu.life <= 0)then
						bla = gameState;
						lose.gameState = bla;
						gameState = 0;
						pikachu.move = true;
						pikachu.timeRecoil = 0;
						love.audio.stop(map.song);
					end
				else

					pikachu.timeRecoil = 0;
					pikachu.rDamage = 0;
					v.hit = false;
					pikachu.xvelocity = 0;
					pikachu.yvelocity = 0;
					pikachu.move = true;
				end
			end
		end

		if(colide(v.x, v.y, v.image:getWidth() - 5, v.image:getHeight() - 5, pikachu.x, pikachu.y, pikachu.image:getWidth(), pikachu.image:getHeight())) then
			v.hit = true;
			v.para = 0.7;
			pikachu.move = false;
			pikachu.rDamage = 50;
			pikachu.dirX = v.dirX;
			pikachu.dirY = v.dirY;
  		end
	end
end

function mon_draw()
	for i,v in ipairs(mons) do
	    if v.rDamage > 0 then
	      love.graphics.setFont(damageFont)
	      love.graphics.setColor(255,0,0)
	      love.graphics.print(v.rDamage, v.x, v.y - 20)
	    end
	    
	    love.graphics.setColor(255,255,255)
	    love.graphics.draw(v.image, v.x, v.y)
	end
end
