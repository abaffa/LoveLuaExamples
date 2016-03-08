function attackQLoad()
	imgs =
	{
		love.graphics.newImage("pikaimages/ataques/ataqueQ0.png"),
		love.graphics.newImage("pikaimages/ataques/ataqueQ1.png"),
		love.graphics.newImage("pikaimages/ataques/ataqueQ2.png"),
		love.graphics.newImage("pikaimages/ataques/ataqueQ3.png"),
		love.graphics.newImage("pikaimages/ataques/ataqueQ4.png"),
		love.graphics.newImage("pikaimages/ataques/ataqueQ5.png"),
		love.graphics.newImage("pikaimages/ataques/ataqueQ6.png"),
		love.graphics.newImage("pikaimages/ataques/ataqueQ7.png"),
		love.graphics.newImage("pikaimages/ataques/ataqueQ6.png"),
		love.graphics.newImage("pikaimages/ataques/ataqueQ7.png")
	}

	attackQ =
	{
		image = imgs[1],
		foi = false,
		power = 1,
		x = pikachu.x,
		y = pikachu.y,
		velX = 50,
		velY = 50,
		dirX = 1,
		dirY = 1,
		erroX = 55,
		erroY = 45,
		time = 0
	}

	attackQs = {}
end

function attackQUpdate( dt )

  if not love.keyboard.isDown("w") then	

	if love.keyboard.isDown("q") then
		
		pikachu.stamina = pikachu.stamina - 40 * dt;

		if(pikachu.stamina>0)then
			attackQ.x = pikachu.x + attackQ.erroX;
			attackQ.y = pikachu.y + attackQ.erroY;

			attackQ.dirX = pikachu.dirX;
			attackQ.dirY = pikachu.dirY;
			if( attackQ.time == 0 )then
				attackQ.image = imgs[1];
				attackQ.foi = false;
				attackQ.power = 1;
				attackQ.x = pikachu.x;
				attackQ.y = pikachu.y;
				attackQ.velX = 400;
				attackQ.velY = 400;
				attackQ.dirX = 1;
				attackQ.dirY = 1;
				attackQ.erroX = 55;
				attackQ.erroY = 45;
				attackQ.timeDamage = 0.4;
			end

			

			pikachu.move = false;
			if pikachu.dirX == 1 then
				if pikachu.dirY == 0 then
					pikachu.image = attackImg.right;
					attackQ.erroX = 10;
					attackQ.erroY = 0;
				else
					if pikachu.dirY == 1 then
						pikachu.image = attackImg.downR;
						attackQ.erroX = 3;
						attackQ.erroY = 13;	
					else
						pikachu.image = attackImg.upR;
						attackQ.erroX = 5;
						attackQ.erroY = -10;
					end
				end
			else
				if pikachu.dirX == -1 then
					if pikachu.dirY == 0 then
						pikachu.image = attackImg.left;
						attackQ.erroX = -35;
						attackQ.erroY = 0;
					else
						if pikachu.dirY == 1 then
							pikachu.image = attackImg.downL;
							attackQ.erroX = -25;
							attackQ.erroY = 10;
						else
							pikachu.image = attackImg.upL;
							attackQ.erroX = -34;
							attackQ.erroY = -7;
						end
					end
				else
					if pikachu.dirY == -1 then
						pikachu.image = attackImg.up;
						attackQ.erroX = -14;
						attackQ.erroY = -17;
					else
						pikachu.image = attackImg.down;
						attackQ.erroX = -14;
						attackQ.erroY = 20;
					end
				end
			end

			if (attackQ.power < 4) then
				attackQ.time = attackQ.time + dt;
				if (attackQ.time < 0.1) then
					attackQ.image = imgs[1];
				else
					if (attackQ.time < 0.2) then
						attackQ.image = imgs[2];
					else
						if (attackQ.time < 0.3) then
							attackQ.image = imgs[3];
						else
							if (attackQ.time < 0.4) then
								attackQ.image = imgs[2];
							else
								if(attackQ.time < 0.5) then
									attackQ.image = imgs[1];
								else
									if(attackQ.time < 0.6) then
										attackQ.image = imgs[2];
									else
										attackQ.time = 0.0001;
										attackQ.power = attackQ.power + 1;
									end
								end
							end
						end
					end
				end
			else
				if (attackQ.power < 8) then
					attackQ.time = attackQ.time + dt;
					if (attackQ.time < 0.1) then
						attackQ.image = imgs[2];
					else
						if (attackQ.time < 0.2) then
							attackQ.image = imgs[3];
						else
							if (attackQ.time < 0.3) then
								attackQ.image = imgs[4];
							else
								if (attackQ.time < 0.4) then
									attackQ.image = imgs[5];
									attackQ.erroX = attackQ.erroX + 10;
									attackQ.erroY = attackQ.erroY - 4;
								else
									if(attackQ.time < 0.5) then
										attackQ.image = imgs[4];
									else
										if(attackQ.time < 0.6) then
											attackQ.image = imgs[3];
										else
											
											attackQ.time = 0.0001;
											attackQ.power = attackQ.power + 1;
										end
									end
								end
							end
						end
					end
				else
					attackQ.time = attackQ.time + dt;
					attackQ.erroX = attackQ.erroX + 10;
					attackQ.erroY = attackQ.erroY - 4;
					if (attackQ.time < 0.1) then
						attackQ.image = imgs[5];
					else
						if (attackQ.time < 0.2) then
							attackQ.image = imgs[6];
						else
							if (attackQ.time < 0.3) then
								attackQ.image = imgs[7];
							else
								if (attackQ.time < 0.4) then
									attackQ.image = imgs[8];
								else
									if(attackQ.time < 0.5) then
										attackQ.image = imgs[7];
									else
										if(attackQ.time < 0.6) then
											attackQ.image = imgs[6];
										else
											attackQ.time = 0.001;
										end
									end
								end
							end
						end
					end
				end
			end
		else
			pikachu.stamina = 0;
		end
	else

		if (attackQ.time ~= 0) then
			love.audio.play(attackW.sound)
			pikachu.move = true;
			attackQ.foi = true;
			attackQ.time = 0;
			table.insert(attackQs, 
			{
				image = imgs[attackQ.power],
				foi = true ,
				power = attackQ.power,
				x = attackQ.x,
				y = attackQ.y,
				velX = attackQ.velX,
				velY = attackQ.velY,
				dirX = attackQ.dirX,
				dirY = attackQ.dirY,
				erroX = attackQ.erroX,
				erroY = attackQ.erroY,
				time = 0,
				timeDamage = 0.3
			});			
			
		end
	end
  end
	for i,v in ipairs( attackQs ) do
		v.x = v.x + v.velX * dt * v.dirX;
		v.y = v.y + v.velY * dt * v.dirY;
		v.time = v.time + dt;
		if (v.power > 0) then
			if (v.time < 0.1) then
				v.image = imgs[v.power];
			else
				if (v.time < 0.2) then
					v.image = imgs[v.power + 1];
				else
					if (v.time < 0.3) then
						v.image = imgs[v.power + 2];
					else
						if (v.time < 0.4) then
							v.image = imgs[v.power + 1];
						else
							if(v.time < 0.5) then
								v.image = imgs[v.power];
							else
								if(v.time < 0.6) then
									v.image = imgs[v.power + 1];
								else
									v.time = 0;
									v.power = v.power - 2;
								end
							end
						end
					end
				end
			end
		else
			table.remove(attackQs, i);
		end
	end
end

function  attackQDraw(  )

	for i,v in ipairs(attackQs) do
		love.graphics.draw(v.image, v.x, v.y);
	end

  if not love.keyboard.isDown("w") then	
		
	if love.keyboard.isDown("q") then
		love.graphics.draw(attackQ.image, attackQ.x, attackQ.y);
	end
  end	
end

function attackQAgumonColisao (dt)
	for ia,va in ipairs(agumons) do
		danoRecebidoIni = va.rDamage;
    	for i,v in ipairs(attackQs) do
	      if colide(v.x,v.y,v.image:getWidth() * 0.7,v.image:getHeight() * 0.7,va.x,va.y,va.image:getWidth(),va.image:getHeight()) then
	        va.x = v.x
	        va.y = v.y
	        if (attackQ.timeDamage >= 0.3) then
				va.health = va.health - v.power * pikachu.lv
	            va.rDamage = va.rDamage + v.power * pikachu.lv
				if va.health <= 0 then
					pikachu.orbes = pikachu.orbes + va.orbes;
					table.remove(agumons, ia);
					if(gameState == 1)then
						map.enemiesKilled = map.enemiesKilled + 1;
	            	end
	            end
	        end
	      end
	    end
	    if (danoRecebidoIni == va.rDamage or va.timeRDamage > 0) then
    		va.timeRDamage = va.timeRDamage + dt;
    		if (va.timeRDamage > 2) then
   				va.rDamage = 0;
   				va.timeRDamage = 0;
   			end
   		end
    end
end

function attackQMonColisao (dt)
	for ia,va in ipairs(mons) do
		danoRecebidoIni = va.rDamage;
    	for i,v in ipairs(attackQs) do
	      if colide(v.x,v.y,v.image:getWidth() * 0.7,v.image:getHeight() * 0.7,va.x,va.y,va.image:getWidth(),va.image:getHeight()) then
	        va.x = v.x
	        va.y = v.y
	        if (attackQ.timeDamage >= 0.3) then
				va.health = va.health - v.power * pikachu.lv
	            va.rDamage = va.rDamage + v.power * pikachu.lv
				if va.health <= 0 then
					pikachu.orbes = pikachu.orbes + va.orbes;
					table.remove(mons, ia);
					if(gameState == 1)then
						map.enemiesKilled = map.enemiesKilled + 1;
					end					
	            end
	        end
	      end
	    end
	    if (danoRecebidoIni == va.rDamage or va.timeRDamage > 0) then
    		va.timeRDamage = va.timeRDamage + dt;
    		if (va.timeRDamage > 2) then
   				va.rDamage = 0;
   				va.timeRDamage = 0;
   			end
   		end
    end
end