function pikachu_load()
	pikachuLife = love.graphics.newImage("pikaimages/pikaVida.png");

	pikachuD = {}
	pikachuD[1] = love.graphics.newImage("pikaimages/pikaD1.png");
	pikachuD[2] = love.graphics.newImage("pikaimages/pikaD2.png");
	pikachuD[3] = love.graphics.newImage("pikaimages/pikaD3.png");

	pikachuE = {}
	pikachuE[1] = love.graphics.newImage("pikaimages/pikaE1.png");
	pikachuE[2] = love.graphics.newImage("pikaimages/pikaE2.png");
	pikachuE[3] = love.graphics.newImage("pikaimages/pikaE3.png");

	pikachuC = {}
	pikachuC[1] = love.graphics.newImage("pikaimages/pikaC1.png");
	pikachuC[2] = love.graphics.newImage("pikaimages/pikaC2.png");
	pikachuC[3] = love.graphics.newImage("pikaimages/pikaC3.png");

	pikachuB = {}
	pikachuB[1] = love.graphics.newImage("pikaimages/pikaB1.png");
	pikachuB[2] = love.graphics.newImage("pikaimages/pikaB2.png");
	pikachuB[3] = love.graphics.newImage("pikaimages/pikaB3.png");

	pikachuC_E = {}
	pikachuC_E[1] = love.graphics.newImage("pikaimages/pikaC_E1.png");
	pikachuC_E[2] = love.graphics.newImage("pikaimages/pikaC_E2.png");
	pikachuC_E[3] = love.graphics.newImage("pikaimages/pikaC_E3.png");

	pikachuC_D = {}
	pikachuC_D[1] = love.graphics.newImage("pikaimages/pikaC_D1.png");
	pikachuC_D[2] = love.graphics.newImage("pikaimages/pikaC_D2.png");
	pikachuC_D[3] = love.graphics.newImage("pikaimages/pikaC_D3.png");

	pikachuB_E = 
	{
		love.graphics.newImage("pikaimages/pikaB_E1.png"),
		love.graphics.newImage("pikaimages/pikaB_E2.png"),
		love.graphics.newImage("pikaimages/pikaB_E3.png")
	}

	pikachuB_D = 
	{
		love.graphics.newImage("pikaimages/pikaB_D1.png"),
		love.graphics.newImage("pikaimages/pikaB_D2.png"),
		love.graphics.newImage("pikaimages/pikaB_D3.png")
	}

	attackImg =
	{
		down = love.graphics.newImage("pikaimages/pikaAtaqueB1.png"),
		up = love.graphics.newImage("pikaimages/pikaAtaqueC1.png"),
		left = love.graphics.newImage("pikaimages/pikaAtaqueE1.png"),
		right = love.graphics.newImage("pikaimages/pikaAtaqueD1.png"),
		upR = love.graphics.newImage("pikaimages/pikaAtaqueC_D1.png"),
		upL = love.graphics.newImage("pikaimages/pikaAtaqueC_E1.png"),
		downR = love.graphics.newImage("pikaimages/pikaAtaqueB_D1.png"),
		downL = love.graphics.newImage("pikaimages/pikaAtaqueB_E1.png")
	}

	pikachu = 
	{
		lv = 1,
		life = 100,
		lifeMax = 100,
		stamina = 196,
		x = 230,
		y = 300,
		dirX = 1,
		dirY = 0,
		xvelocity = 0,
		xspeed = 1500,
		yvelocity = 0,
		yspeed = 1500,
		image = love.graphics.newImage("pikaimages/pikaD1.png"),
		rDamage = 0,
		timeRecoil = 0,
		move = true,
		orbes = 0,
		smallPots = 0,
		mediumPots = 0,
		largePots = 0
	}

	pikachuanimtimer = 0
	pikachupnum = 1

end

function keypressedPikachu( key )
	if (key == "1") then
		if(pikachu.smallPots > 0)then
			pikachu.smallPots = pikachu.smallPots - 1;
			pikachu.life = pikachu.life + 50;
		end
	end

	if(key == "2")then
		if(pikachu.mediumPots > 0)then
			pikachu.mediumPots = pikachu.mediumPots - 1;
			pikachu.life = pikachu.life + 100;
		end
	end

	if(key == "3")then
		if(pikachu.largePots > 0)then
			pikachu.largePots = pikachu.largePots - 1;
			pikachu.life = pikachu.life + 200;
		end
	end

	if(pikachu.life > pikachu.lifeMax)then
		pikachu.life = pikachu.lifeMax;
	end
end

function lvUp( )
	pikachu.lifeMax = pikachu.lv * pikachu.lv * 5 + 95;
	pikachu.life = pikachu.lifeMax;
end

function pikachuMove( dt )
	
	if (pikachu.move) then
		if(pikachu.stamina >= 196)then
			pikachu.stamina = 196;
		else
			pikachu.stamina = pikachu.stamina + 20 * dt;
		end


		pikachu.x = pikachu.x + pikachu.xvelocity * dt
		pikachu.y = pikachu.y + pikachu.yvelocity * dt

		if(gameState == 1)then
			pikachu.yvelocity = pikachu.yvelocity * (1-math.min(dt*map.yFriction,1))
			pikachu.xvelocity = pikachu.xvelocity * (1-math.min(dt*map.xFriction,1))
		else
			if(gameState == 2)then
				pikachu.yvelocity = pikachu.yvelocity * (1-math.min(dt*map2.yFriction,1))
				pikachu.xvelocity = pikachu.xvelocity * (1-math.min(dt*map2.xFriction,1))
			else
				if(gameState == 3)then
					pikachu.yvelocity = pikachu.yvelocity * (1-math.min(dt*map3.yFriction,1))
					pikachu.xvelocity = pikachu.xvelocity * (1-math.min(dt*map3.xFriction,1))
				end
			end
		end
		if love.keyboard.isDown("up") then
			pikachu.dirY = -1;
			pikachu.yvelocity = pikachu.yvelocity + pikachu.dirY * pikachu.yspeed * dt;
			if love.keyboard.isDown("left") then
				attackW.angle = 3*math.pi/4;
				
				pikachu.dirX = -1;
				pikachu.xvelocity = pikachu.xvelocity + pikachu.xspeed * dt * pikachu.dirX
			    pikachu.image = pikachuC_E[pikachupnum]	
			else
				if love.keyboard.isDown("right") then
					pikachu.dirX = 1;
					attackW.angle = 5*math.pi/4;
					pikachu.xvelocity = pikachu.xvelocity + pikachu.xspeed * dt * pikachu.dirX
					pikachu.image = pikachuC_D[pikachupnum]
				else
			        pikachu.image = pikachuC[pikachupnum];		  
					pikachu.dirX = 0;
					attackW.angle = math.pi;
				end
			end
			pikachuanimtimer = pikachuanimtimer + dt
		else
			if love.keyboard.isDown("down") then
				pikachu.dirY = 1;
				pikachu.yvelocity = pikachu.yvelocity + pikachu.yspeed * dt * pikachu.dirY
				if love.keyboard.isDown("left") then
					pikachu.dirX = -1;
					attackW.angle = math.pi/4;
					pikachu.xvelocity = pikachu.xvelocity + pikachu.xspeed * dt * pikachu.dirX
					pikachu.image = pikachuB_E[pikachupnum]				
				else
					if love.keyboard.isDown("right") then
						pikachu.dirX = 1;
						attackW.angle = 7*math.pi/4;
						pikachu.xvelocity = pikachu.xvelocity + pikachu.xspeed * dt * pikachu.dirX
						pikachu.image = pikachuB_D[pikachupnum]					
					else
						pikachu.image = pikachuB[pikachupnum];
						attackW.angle = 0;
						pikachu.dirX = 0;			
					end
				end
				pikachuanimtimer = pikachuanimtimer + dt
			else
				if love.keyboard.isDown("right") then
					attackW.angle = -math.pi/2;
					pikachu.dirX = 1;
					pikachu.dirY = 0;
					pikachu.xvelocity = pikachu.xvelocity + pikachu.xspeed * dt * pikachu.dirX
					pikachu.image = pikachuD[pikachupnum];
					pikachuanimtimer = pikachuanimtimer + dt;
				else
					if love.keyboard.isDown("left") then
						attackW.angle = math.pi/2;
						pikachu.dirX = -1;
						pikachu.dirY = 0;
						pikachu.xvelocity = pikachu.xvelocity + pikachu.xspeed * dt * pikachu.dirX
						pikachu.image = pikachuE[pikachupnum];
						pikachuanimtimer = pikachuanimtimer + dt;
					end
				end
			end
		end	

		if pikachuanimtimer > 0.14 then
			if pikachupnum < 3 then
				pikachupnum = pikachupnum + 1
			else
				pikachupnum = 2
			end
			pikachuanimtimer = 0
		end

	end
end

function pikachu_animreset()

	pikachuanimtimer = 0
	pikachupnum = 1

	if pikachu.dirX == 1 then
		if pikachu.dirY == 0 then
			pikachu.image = pikachuD[pikachupnum]
		else
			if pikachu.dirY == 1 then
				pikachu.image = pikachuB_D[pikachupnum]
			else
				pikachu.image = pikachuC_D[pikachupnum]
			end
		end
	else
		if pikachu.dirX == -1 then
			if pikachu.dirY == 0 then
				pikachu.image = pikachuE[pikachupnum]
			else
				if pikachu.dirY == 1 then
					pikachu.image = pikachuB_E[pikachupnum]
				else
					pikachu.image = pikachuC_E[pikachupnum]
				end
			end
		else
			if pikachu.dirY == -1 then
				pikachu.image = pikachuC[pikachupnum]
			else
				pikachu.image = pikachuB[pikachupnum]
			end
		end
	end
end

function pikachu_draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(pikachu.image, pikachu.x, pikachu.y)
end

function pikachuLifeDraw()
	love.graphics.setColor(255, 255, 255);
	love.graphics.draw(pikachuLife,0, 0);
	life = 247 * pikachu.life/pikachu.lifeMax;


	love.graphics.setColor(255,0,0);
	love.graphics.polygon("fill",146, 71, 146 + life, 71, 146 + life, 40, 146, 40);
	stamina = pikachu.stamina;
	love.graphics.setColor(0, 255, 0);
	love.graphics.polygon("fill",146, 105, 146 + stamina, 105, 146 + stamina, 84, 146, 84);
	
	love.graphics.setColor(0, 0, 0);
	love.graphics.setFont(love.graphics.newFont(20));
	love.graphics.print(math.floor(pikachu.life) .. "/" .. pikachu.lifeMax, 230, 45)

	love.graphics.setColor(255,255,255);
end





