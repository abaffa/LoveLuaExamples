function cs1Load( )
	cs1 =
	{
		img = love.graphics.newImage("bgs/grass.png"),
		xFriction = 10,
		yFriction = 10,
		state = 0,
		song = love.audio.newSource("sounds/cutScene1.wav")
	}

	balao = 
	{
		x = 290,
		y = 180,
		image = love.graphics.newImage("bgs/balao.png")
	}

	ash = 
	{
		x = 280,
		y = 280,
		image = love.graphics.newImage("bgs/ash.png")
	}

	blackHole =
	{
		x = 840,
		y = 160,
		image = love.graphics.newImage("bgs/bnegro.png")
	}

end

function andarPikachu( dt )

	pikachu.x = pikachu.x + pikachu.xvelocity * dt;
	pikachu.y = pikachu.y + pikachu.yvelocity * dt;

	
	pikachu.yvelocity = pikachu.yvelocity * (1-math.min(dt*cs1.yFriction,1));
	pikachu.xvelocity = pikachu.xvelocity * (1-math.min(dt*cs1.xFriction,1));
	
	pikachuanimtimer = pikachuanimtimer + dt
	if pikachu.dirY == -1 then
		pikachu.yvelocity = pikachu.yvelocity + pikachu.dirY * pikachu.yspeed * dt;
		if pikachu.dirX == -1 then
			pikachu.xvelocity = pikachu.xvelocity + pikachu.xspeed * dt * pikachu.dirX
		    pikachu.image = pikachuC_E[pikachupnum]	
		else
			if pikachu.dirX == 1 then
				pikachu.xvelocity = pikachu.xvelocity + pikachu.xspeed * dt * pikachu.dirX
				pikachu.image = pikachuC_D[pikachupnum]
			else
		        pikachu.image = pikachuC[pikachupnum];
			end
		end
	else
		if pikachu.dirY == 1 then
			pikachu.yvelocity = pikachu.yvelocity + pikachu.yspeed * dt * pikachu.dirY
			if pikachu.dirX == -1 then
				pikachu.xvelocity = pikachu.xvelocity + pikachu.xspeed * dt * pikachu.dirX
				pikachu.image = pikachuB_E[pikachupnum]				
			else
				if pikachu.dirX == 1 then
					pikachu.xvelocity = pikachu.xvelocity + pikachu.xspeed * dt * pikachu.dirX
					pikachu.image = pikachuB_D[pikachupnum]					
				else
					pikachu.image = pikachuB[pikachupnum];	
				end
			end
		else
			if pikachu.dirX == 1 and pikachu.dirY == 0 then
				pikachu.xvelocity = pikachu.xvelocity + pikachu.xspeed * dt * pikachu.dirX
				pikachu.image = pikachuD[pikachupnum];
			else
				if pikachu.dirX == -1 and pikachu.dirY == 0 then
					pikachu.xvelocity = pikachu.xvelocity + pikachu.xspeed * dt * pikachu.dirX
					pikachu.image = pikachuE[pikachupnum];
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

function cs1Keypressed(key)
	if key == "return" then
		if( not (cs1.state == 2))then
			cs1.state = cs1.state + 1;
		end
	end
	if(cs1.state == 6)then
		gameState = 1;
		pikachu.x = 300;
		pikachu.y = 300;
		pikachu.dirX = 1;
		pikachu.dirY = 0;
		pikachu.image = love.graphics.newImage("pikaimages/pikaD1.png");
	end
end

function cs1Update(dt)
	love.audio.play(cs1.song);
	if(cs1.state == 2)then
		if(pikachu.x < 400)then
			pikachu.dirX = 1;
			pikachu.dirY = -1;
		else
			if(pikachu.x < 500)then
				pikachu.dirX = 1;
				pikachu.dirY = 0;
			else
				if(pikachu.x < 670)then
					pikachu.dirX = 1;
					pikachu.dirY = 1;
				else
					if(pikachu.x < 720)then
						pikachu.dirX = 1;
						pikachu.dirY = 0;
					else
						if(pikachu.y > 185)then
							pikachu.dirX = 0;
							pikachu.dirY = -1;
						else
							if(pikachu.x < 855)then
								pikachu.dirX = 1;
								pikachu.dirY = 0;
							else
								cs1.state = 3;
							end
						end
					end
				end
			end
		end
		andarPikachu(dt);
	end
end

function cs1Draw( )
	love.graphics.draw(cs1.img,16,12);
	
	if(cs1.state == 1)then
		love.graphics.draw(balao.image, balao.x, balao.y);
	end
	love.graphics.draw(ash.image, ash.x, ash.y);
	if(cs1.state < 4)then
		love.graphics.draw(pikachu.image, pikachu.x, pikachu.y);
	else
		if(cs1.state == 4)then
			love.graphics.draw(blackHole.image, blackHole.x, blackHole.y);
		else
			love.audio.stop(cs1.song);
			love.graphics.draw(love.graphics.newImage("bgs/black.png"), 0, 0);
		end
	end
end