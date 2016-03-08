function attackELoad()
	

	attackE =
	{
		imgs =
		{
			down =
			{
				love.graphics.newImage("pikaimages/pikaPulando/down0.png"),
				love.graphics.newImage("pikaimages/pikaPulando/down1.png")
			},
			downL =
			{
				love.graphics.newImage("pikaimages/pikaPulando/downL0.png"),
				love.graphics.newImage("pikaimages/pikaPulando/downL1.png")
			},
			downR =
			{
				love.graphics.newImage("pikaimages/pikaPulando/downR0.png"),
				love.graphics.newImage("pikaimages/pikaPulando/downR1.png")
			},
			left =
			{
				love.graphics.newImage("pikaimages/pikaPulando/left0.png"),
				love.graphics.newImage("pikaimages/pikaPulando/left1.png")
			},
			right =
			{
				love.graphics.newImage("pikaimages/pikaPulando/right0.png"),
				love.graphics.newImage("pikaimages/pikaPulando/right1.png")
			},
			up =
			{
				love.graphics.newImage("pikaimages/pikaPulando/up1.png")
			},
			upL =
			{
				love.graphics.newImage("pikaimages/pikaPulando/upL0.png"),
				love.graphics.newImage("pikaimages/pikaPulando/upL1.png")
			},
			upR =
			{
				love.graphics.newImage("pikaimages/pikaPulando/upR0.png"),
				love.graphics.newImage("pikaimages/pikaPulando/upR1.png")
			},
			spark = 
			{
				r = love.graphics.newImage("pikaimages/pikaPulando/sparkR.png"),
				l = love.graphics.newImage("pikaimages/pikaPulando/sparkL.png"),
				d = love.graphics.newImage("pikaimages/pikaPulando/sparkD.png"),
				u = love.graphics.newImage("pikaimages/pikaPulando/sparkU.png")
			}
		},

		img = 0,
		foi = false,
		time = 0,
		x = 0,
		y = 0,
		timeImg = 0,
		angle = 0
	}
end

function attackEUpdate(dt)
	if love.keyboard.isDown("e") then

		if(pikachu.stamina - 1650 * dt > 0)then
			if pikachu.dirX == 1 then
				if pikachu.dirY == 0 then
					if(not attackE.foi)then
						attackE.time = attackE.time + dt;
						attackE.img = 0;
						
						if(attackE.time < 0.1)then							
							pikachu.image = attackE.imgs.right[1];
							attackE.x = pikachu.x;
							attackE.y = pikachu.y;
						else
							if (attackE.time < 0.2) then
								pikachu.image = attackE.imgs.right[2];
							else
								attackE.foi = true;
								pikachu.stamina = pikachu.stamina - 2000 * dt;
								pikachu.x = pikachu.x + 6500*dt;
								attackE.img = attackE.imgs.spark.r;
								attackE.angle = 0;
								attackE.time = 0;
							end
						end
					end
				else
					if pikachu.dirY == 1 then					

						if(not attackE.foi)then
							attackE.time = attackE.time + dt;
							attackE.img = 0;
						
							if(attackE.time < 0.1)then							
								pikachu.image = attackE.imgs.downR[1];
								attackE.x = pikachu.x - 20;
								attackE.y = pikachu.y + 10;
							else
								if (attackE.time < 0.2) then
									pikachu.image = attackE.imgs.downR[2];
								else
									attackE.foi = true;
									pikachu.stamina = pikachu.stamina - 2000 * dt;
									pikachu.x = pikachu.x + 4596*dt;
									pikachu.y = pikachu.y + 4596*dt;
									attackE.img = attackE.imgs.spark.d;
									attackE.angle = -math.pi/4;
									attackE.time = 0;
								end
							end
						end

					else

						if(not attackE.foi)then
							attackE.time = attackE.time + dt;
							attackE.img = 0;
						
							if(attackE.time < 0.1)then							
								pikachu.image = attackE.imgs.upR[1];
								attackE.x = pikachu.x + 50;
								attackE.y = pikachu.y - 50;
							else
								if (attackE.time < 0.2) then
									pikachu.image = attackE.imgs.upR[2];
								else
									attackE.foi = true;
									pikachu.stamina = pikachu.stamina - 2000 * dt;
									pikachu.x = pikachu.x + 4596*dt;
									pikachu.y = pikachu.y - 4596*dt;
									attackE.img = attackE.imgs.spark.u;
									attackE.angle = math.pi/4;
									attackE.time = 0;
								end
							end
						end
					end
				end
			else
				if pikachu.dirX == -1 then
					if pikachu.dirY == 0 then

						if(not attackE.foi)then
							attackE.time = attackE.time + dt;
							attackE.img = 0;
						
							if(attackE.time < 0.1)then							
								pikachu.image = attackE.imgs.left[1];
								attackE.x = pikachu.x - attackE.imgs.spark.l:getWidth() + 30;
								attackE.y = pikachu.y;
							else
								if (attackE.time < 0.2) then
									pikachu.image = attackE.imgs.left[2];
								else
									attackE.foi = true;
									pikachu.stamina = pikachu.stamina - 2000 * dt;
									pikachu.x = pikachu.x - 6500*dt;
									attackE.img = attackE.imgs.spark.l;
									attackE.angle = 0;
									attackE.time = 0;
								end
							end
						end

					else
						if pikachu.dirY == 1 then

							if(not attackE.foi)then
								attackE.time = attackE.time + dt;
								attackE.img = 0;
								
								if(attackE.time < 0.1)then							
									pikachu.image = attackE.imgs.downL[1];
									attackE.x = pikachu.x + 10;
									attackE.y = pikachu.y - 10;
								else
									if (attackE.time < 0.2) then
										pikachu.image = attackE.imgs.downL[2];
									else
										attackE.foi = true;
										pikachu.stamina = pikachu.stamina - 2000 * dt;
										pikachu.x = pikachu.x - 4596*dt;
										pikachu.y = pikachu.y + 4596*dt;
										attackE.img = attackE.imgs.spark.d;
										attackE.angle = math.pi/4;
										attackE.time = 0;
									end
								end
							end

						else
							
							if(not attackE.foi)then
								attackE.time = attackE.time + dt;
								attackE.img = 0;
								
								if(attackE.time < 0.1)then						
									pikachu.image = attackE.imgs.upL[1];
									attackE.x = pikachu.x - 45;
									attackE.y = pikachu.y - 30;
								else
									if (attackE.time < 0.2) then
										pikachu.image = attackE.imgs.upL[2];
									else
										attackE.foi = true;
										pikachu.stamina = pikachu.stamina - 2000 * dt;
										pikachu.y = pikachu.y - 4596*dt;
										pikachu.x = pikachu.x - 4596*dt;
										attackE.img = attackE.imgs.spark.u;
										attackE.angle = -math.pi/4;
										attackE.time = 0;
									end
								end
							end
						end
					end
				else
					if pikachu.dirY == -1 then
						if(not attackE.foi)then
							attackE.time = attackE.time + dt;
							attackE.img = 0;
						
							if(attackE.time < 0.1)then							
								pikachu.image = attackE.imgs.up[1];
								attackE.x = pikachu.x;
								attackE.y = pikachu.y - attackE.imgs.spark.u:getHeight() + 10;
							else
								if (attackE.time < 0.2) then
									--pikachu.image = attackE.imgs.up[1];
								else
									attackE.foi = true;
									pikachu.stamina = pikachu.stamina - 2000 * dt;
									pikachu.y = pikachu.y - 6500*dt;
									attackE.img = attackE.imgs.spark.u;
									attackE.angle = 0;
									attackE.time = 0;
								end
							end
						end
					else

						if(not attackE.foi)then
							attackE.time = attackE.time + dt;
							attackE.img = 0;
						
							if(attackE.time < 0.1)then							
								pikachu.image = attackE.imgs.down[1];
								attackE.x = pikachu.x;
								attackE.y = pikachu.y;
							else
								if (attackE.time < 0.2) then
									pikachu.image = attackE.imgs.down[2];
								else
									attackE.foi = true;
									pikachu.stamina = pikachu.stamina - 2000 * dt;
									pikachu.y = pikachu.y + 6500*dt;
									attackE.img = attackE.imgs.spark.d;
									attackE.angle = 0;
									attackE.time = 0;
								end
							end						
						end
					end
				end
			end
		end
	else
		if(attackE.img~=0)then
			attackE.timeImg = attackE.timeImg + dt;
			if(attackE.timeImg > 0.4)then
				attackE.img = 0;
				attackE.timeImg = 0;
			end
		end

		attackE.foi = false;
		attackE.time = 0;
		--attackE.foi = true;

	end
end

function attackEDraw( )
	if attackE.img ~= 0 then
		love.graphics.draw(attackE.img, attackE.x, attackE.y, attackE.angle)
	end
end