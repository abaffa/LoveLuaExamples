function attackWLoad()
	attackW = 
	{
		imgs =
		{
			love.graphics.newImage("pikaimages/ataques/ataqueW0.png"),
			love.graphics.newImage("pikaimages/ataques/ataqueW1.png"),
			love.graphics.newImage("pikaimages/ataques/ataqueW2.png"),
			love.graphics.newImage("pikaimages/ataques/ataqueW3.png"),
			love.graphics.newImage("pikaimages/ataques/ataqueW4.png"),
			love.graphics.newImage("pikaimages/ataques/ataqueW5.png")	
		},
		dps = pikachu.lv + 1, -- pikachu.damage * 7
		image = love.graphics.newImage("pikaimages/ataques/ataqueW0.png"),
		foi = false,
		x = pikachu.x,
		y = pikachu.y,
		erroX = 55,
		erroY = 45,
		angle = -math.pi/2,
		time = 0,
		timeDamage = 0.5,
		sound = love.audio.newSource( "sounds/attack.mp3", "stream" )
	}

end

function attackWUpdate(dt, inimigos)
	-- if pikachu.timeRecoil == 0 then
	-- 	if not love.keyboard.isDown("q")then
	-- 		if love.keyboard.isDown("w") then
	-- 			pikachu.stamina = pikachu.stamina - 65 * dt;
	-- 			if (pikachu.stamina > 0) then
					
	-- 				love.audio.play(attackW.sound)
	-- 				attackW.x = pikachu.x + attackW.erroX;
	-- 				attackW.y = pikachu.y + attackW.erroY;

	-- 				attackW.timeDamage = attackW.timeDamage + dt;

	-- 				if (pikachu.image == attackImg.left) then
	-- 					for i,v in ipairs(agumons) do
	-- 						if colide(attackW.x - attackW.image:getHeight(), attackW.y, attackW.image:getHeight(), attackW.image:getWidth(), v.x, v.y , v.image:getWidth(), v.image:getHeight()) then
	-- 							if (attackW.timeDamage >= 0.7) then
	-- 								v.health = v.health - attackW.dps;
	-- 								v.rDamage = v.rDamage + attackW.dps;
	-- 								if v.health < 0 then
	-- 									table.remove(agumons, i);
	-- 									map.enemiesKilled = map.enemiesKilled + 1;
	-- 									pikachu.orbes = pikachu.orbes + v.orbes;
	-- 								end
	-- 							end
	-- 						end
	-- 					end
	-- 				else
	-- 					if (pikachu.image == attackImg.right) then
	-- 						for i,v in ipairs(agumons) do
	-- 							if colide(attackW.x, attackW.y - attackW.image:getWidth(), attackW.image:getHeight(), attackW.image:getWidth(), v.x, v.y, v.image:getWidth(), v.image:getHeight()) then
	-- 								if (attackW.timeDamage >= 0.7) then
	-- 									v.health = v.health - attackW.dps;
	-- 									v.rDamage = v.rDamage + attackW.dps;
	-- 									if v.health < 0 then
	-- 										pikachu.orbes = pikachu.orbes + v.orbes;
	-- 										table.remove(agumons, i);
	-- 										map.enemiesKilled = map.enemiesKilled + 1;
	-- 									end
	-- 								end
	-- 							end
	-- 						end
	-- 					else
	-- 						if (pikachu.image == attackImg.up) then
	-- 							for i,v in ipairs(agumons) do
	-- 								if colide(attackW.x - attackW.image:getWidth(), attackW.y - attackW.image:getHeight(), attackW.image:getWidth(), attackW.image:getHeight(), v.x, v.y + 5, v.image:getWidth(), v.image:getHeight()) then
	-- 									if (attackW.timeDamage >= 0.7) then
	-- 										v.health = v.health - attackW.dps;
	-- 										v.rDamage = v.rDamage + attackW.dps;
	-- 										if v.health < 0 then
	-- 											pikachu.orbes = pikachu.orbes + v.orbes;
	-- 											table.remove(agumons, i);
	-- 											map.enemiesKilled = map.enemiesKilled + 1;
	-- 										end
	-- 									end
	-- 								end
	-- 							end		
	-- 						else
	-- 							if (pikachu.image == attackImg.down) then
	-- 								for i,v in ipairs(agumons) do
	-- 									if colide(attackW.x, attackW.y, attackW.image:getWidth(), attackW.image:getHeight(), v.x, v.y + 5, v.image:getWidth(), v.image:getHeight()) then
	-- 										if (attackW.timeDamage >= 0.7) then
	-- 											v.health = v.health - attackW.dps;
	-- 											v.rDamage = v.rDamage + attackW.dps;
	-- 											if v.health < 0 then
	-- 												pikachu.orbes = pikachu.orbes + v.orbes;
	-- 												table.remove(agumons, i);
	-- 												map.enemiesKilled = map.enemiesKilled + 1;
	-- 											end
	-- 										end
	-- 									end
	-- 								end
	-- 							else
	-- 								if (pikachu.image == attackImg.downL) then
	-- 									for i,v in ipairs(agumons) do
	-- 										if diagonalColide(attackW.x, attackW.y, attackW.image:getWidth(), attackW.image:getHeight() - 60, 3, v.x, v.y, v.image:getWidth(), v.image:getHeight()) then
	-- 											if (attackW.timeDamage >= 0.7) then
	-- 												v.health = v.health - attackW.dps;
	-- 												v.rDamage = v.rDamage + attackW.dps;
	-- 												if v.health < 0 then
	-- 													pikachu.orbes = pikachu.orbes + v.orbes;
	-- 													table.remove(agumons, i)
	-- 													map.enemiesKilled = map.enemiesKilled + 1;
	-- 												end
	-- 											end
	-- 										end
	-- 									end
	-- 								else
	-- 									if (pikachu.image == attackImg.upR) then
	-- 										for i,v in ipairs(agumons) do
	-- 											if diagonalColide(attackW.x, attackW.y, attackW.image:getWidth(), attackW.image:getHeight() - 60, 1, v.x, v.y, v.image:getWidth(), v.image:getHeight()) then
	-- 												if (attackW.timeDamage >= 0.7) then
	-- 													v.health = v.health - attackW.dps;
	-- 													v.rDamage = v.rDamage + attackW.dps;
	-- 													if v.health < 0 then
	-- 														pikachu.orbes = pikachu.orbes + v.orbes;
	-- 														table.remove(agumons, i)
	-- 														map.enemiesKilled = map.enemiesKilled + 1;
	-- 													end
	-- 												end
	-- 											end
	-- 										end
	-- 									else
	-- 										if (pikachu.image == attackImg.downR) then
	-- 											for i,v in ipairs(agumons) do
	-- 												if diagonalColide(attackW.x, attackW.y, attackW.image:getWidth(), attackW.image:getHeight() - 60, 4, v.x, v.y, v.image:getWidth(), v.image:getHeight()) then
	-- 													if (attackW.timeDamage >= 0.7) then
	-- 														v.health = v.health - attackW.dps;
	-- 														v.rDamage = v.rDamage + attackW.dps;
	-- 														if v.health < 0 then
	-- 															pikachu.orbes = pikachu.orbes + v.orbes;
	-- 															table.remove(agumons, i)
	-- 															map.enemiesKilled = map.enemiesKilled + 1;
	-- 														end
	-- 													end
	-- 												end
	-- 											end
	-- 										else
	-- 											if (pikachu.image == attackImg.upL) then
	-- 												for i,v in ipairs(agumons) do
	-- 													if diagonalColide(attackW.x - attackW.image:getWidth(), attackW.y, 2 *attackW.image:getWidth(), attackW.image:getHeight() - 60, 2, v.x, v.y, v.image:getWidth(), v.image:getHeight()) then
	-- 														if (attackW.timeDamage >= 0.7) then
	-- 															v.health = v.health - attackW.dps;
	-- 															v.rDamage = v.rDamage + attackW.dps;
	-- 															if v.health < 0 then
	-- 																pikachu.orbes = pikachu.orbes + v.orbes;
	-- 																table.remove(agumons, i)
	-- 																map.enemiesKilled = map.enemiesKilled + 1;
	-- 															end
	-- 														end
	-- 													end
	-- 												end
	-- 											end
	-- 										end
	-- 									end
	-- 								end
	-- 							end
	-- 						end
	-- 					end
	-- 				end

	-- 				pikachu.move = false;
	-- 				if pikachu.dirX == 1 then
	-- 					if pikachu.dirY == 0 then
	-- 						pikachu.image = attackImg.right;
	-- 						attackW.erroX = 20;
	-- 						attackW.erroY = 25;
	-- 					else
	-- 						if pikachu.dirY == 1 then
	-- 							pikachu.image = attackImg.downR;
	-- 							attackW.erroX = 8;
	-- 							attackW.erroY = 18;	
	-- 						else
	-- 							pikachu.image = attackImg.upR;
	-- 							attackW.erroX = 23;
	-- 							attackW.erroY = 15;
	-- 						end
	-- 					end
	-- 				else
	-- 					if pikachu.dirX == -1 then
	-- 						if pikachu.dirY == 0 then
	-- 							pikachu.image = attackImg.left;
	-- 							attackW.erroX = 5;
	-- 							attackW.erroY = 0;
	-- 						else
	-- 							if pikachu.dirY == 1 then
	-- 								pikachu.image = attackImg.downL;
	-- 								attackW.erroX = 0;
	-- 								attackW.erroY = 2;
	-- 							else
	-- 								pikachu.image = attackImg.upL;
	-- 								attackW.erroX = 17;
	-- 								attackW.erroY = 7;
	-- 							end
	-- 						end
	-- 					else
	-- 						if pikachu.dirY == -1 then
	-- 							pikachu.image = attackImg.up;
	-- 							attackW.erroX = 22;
	-- 							attackW.erroY = 10;
	-- 						else
	-- 							pikachu.image = attackImg.down;
	-- 							attackW.erroX = -2;
	-- 							attackW.erroY = 15;
	-- 						end
	-- 					end
	-- 				end

	-- 				if (attackW.foi) then
	-- 					if(attackW.time > 0.1) then
	-- 						if (attackW.image == attackW.imgs[4]) then
	-- 							attackW.image = attackW.imgs[6];
	-- 						else
	-- 							attackW.image = attackW.imgs[4];
	-- 						end
	-- 						attackW.time = 0.00001;
	-- 					else
	-- 						attackW.time = attackW.time + dt;
	-- 					end
	-- 				else
	-- 					attackW.time = attackW.time + dt;
	-- 					if (attackW.time < 0.1) then
	-- 						attackW.image = attackW.imgs[1];
	-- 					else
	-- 						if (attackW.time < 0.2) then
	-- 							attackW.image = attackW.imgs[2];
	-- 						else
	-- 							if (attackW.time < 0.3) then
	-- 								attackW.image = attackW.imgs[3];
	-- 							else
	-- 								if (attackW.time < 0.4) then
	-- 									attackW.image = attackW.imgs[4];
	-- 								else
	-- 									if(attackW.time < 0.5) then
	-- 										attackW.image = attackW.imgs[5];
	-- 									else
	-- 										if(attackW.time < 0.6) then
	-- 											attackW.image = attackW.imgs[6];
	-- 										else
	-- 											attackW.foi = true;
	-- 											attackW.time = 0.0001;
	-- 										end
	-- 									end
	-- 								end
	-- 							end
	-- 						end
	-- 					end
	-- 				end
	-- 			else
	-- 				pikachu.stamina = 0;
	-- 			end
	-- 		else
	-- 			if (attackW.time ~= 0) then
	-- 				pikachu.move = true;
	-- 				attackW.foi = false;
	-- 				attackW.time = 0;
	-- 				attackW.timeDamage = 0.5;
	-- 				love.audio.stop( attackW.sound );
	-- 			end
	-- 		end
	-- 	end
	-- end
	
	if pikachu.timeRecoil == 0 then
		if not love.keyboard.isDown("q")then
			if love.keyboard.isDown("w") then
				pikachu.stamina = pikachu.stamina - 65 * dt;
				if (pikachu.stamina > 0) then
					
					love.audio.play(attackW.sound)
					attackW.x = pikachu.x + attackW.erroX;
					attackW.y = pikachu.y + attackW.erroY;

					attackW.timeDamage = attackW.timeDamage + dt;

					if (pikachu.image == attackImg.left) then
						for i,v in ipairs(inimigos) do
							if colide(attackW.x - attackW.image:getHeight(), attackW.y, attackW.image:getHeight(), attackW.image:getWidth(), v.x, v.y , v.image:getWidth(), v.image:getHeight()) then
								if (attackW.timeDamage >= 0.7) then
									v.health = v.health - attackW.dps;
									v.rDamage = v.rDamage + attackW.dps;
									if v.health < 0 then
										table.remove(inimigos, i);
										map.enemiesKilled = map.enemiesKilled + 1;
										pikachu.orbes = pikachu.orbes + v.orbes;
									end
								end
							end
						end
					else
						if (pikachu.image == attackImg.right) then
							for i,v in ipairs(inimigos) do
								if colide(attackW.x, attackW.y - attackW.image:getWidth(), attackW.image:getHeight(), attackW.image:getWidth(), v.x, v.y, v.image:getWidth(), v.image:getHeight()) then
									if (attackW.timeDamage >= 0.7) then
										v.health = v.health - attackW.dps;
										v.rDamage = v.rDamage + attackW.dps;
										if v.health < 0 then
											pikachu.orbes = pikachu.orbes + v.orbes;
											table.remove(inimigos, i);
											map.enemiesKilled = map.enemiesKilled + 1;
										end
									end
								end
							end
						else
							if (pikachu.image == attackImg.up) then
								for i,v in ipairs(inimigos) do
									if colide(attackW.x - attackW.image:getWidth(), attackW.y - attackW.image:getHeight(), attackW.image:getWidth(), attackW.image:getHeight(), v.x, v.y + 5, v.image:getWidth(), v.image:getHeight()) then
										if (attackW.timeDamage >= 0.7) then
											v.health = v.health - attackW.dps;
											v.rDamage = v.rDamage + attackW.dps;
											if v.health < 0 then
												pikachu.orbes = pikachu.orbes + v.orbes;
												table.remove(inimigos, i);
												map.enemiesKilled = map.enemiesKilled + 1;
											end
										end
									end
								end		
							else
								if (pikachu.image == attackImg.down) then
									for i,v in ipairs(inimigos) do
										if colide(attackW.x, attackW.y, attackW.image:getWidth(), attackW.image:getHeight(), v.x, v.y + 5, v.image:getWidth(), v.image:getHeight()) then
											if (attackW.timeDamage >= 0.7) then
												v.health = v.health - attackW.dps;
												v.rDamage = v.rDamage + attackW.dps;
												if v.health < 0 then
													pikachu.orbes = pikachu.orbes + v.orbes;
													table.remove(inimigos, i);
													map.enemiesKilled = map.enemiesKilled + 1;
												end
											end
										end
									end
								else
									if (pikachu.image == attackImg.downL) then
										for i,v in ipairs(inimigos) do
											if diagonalColide(attackW.x, attackW.y, attackW.image:getWidth(), attackW.image:getHeight() - 60, 3, v.x, v.y, v.image:getWidth(), v.image:getHeight()) then
												if (attackW.timeDamage >= 0.7) then
													v.health = v.health - attackW.dps;
													v.rDamage = v.rDamage + attackW.dps;
													if v.health < 0 then
														pikachu.orbes = pikachu.orbes + v.orbes;
														table.remove(inimigos, i)
														map.enemiesKilled = map.enemiesKilled + 1;
													end
												end
											end
										end
									else
										if (pikachu.image == attackImg.upR) then
											for i,v in ipairs(inimigos) do
												if diagonalColide(attackW.x, attackW.y, attackW.image:getWidth(), attackW.image:getHeight() - 60, 1, v.x, v.y, v.image:getWidth(), v.image:getHeight()) then
													if (attackW.timeDamage >= 0.7) then
														v.health = v.health - attackW.dps;
														v.rDamage = v.rDamage + attackW.dps;
														if v.health < 0 then
															pikachu.orbes = pikachu.orbes + v.orbes;
															table.remove(inimigos, i)
															map.enemiesKilled = map.enemiesKilled + 1;
														end
													end
												end
											end
										else
											if (pikachu.image == attackImg.downR) then
												for i,v in ipairs(inimigos) do
													if diagonalColide(attackW.x, attackW.y, attackW.image:getWidth(), attackW.image:getHeight() - 60, 4, v.x, v.y, v.image:getWidth(), v.image:getHeight()) then
														if (attackW.timeDamage >= 0.7) then
															v.health = v.health - attackW.dps;
															v.rDamage = v.rDamage + attackW.dps;
															if v.health < 0 then
																pikachu.orbes = pikachu.orbes + v.orbes;
																table.remove(inimigos, i)
																map.enemiesKilled = map.enemiesKilled + 1;
															end
														end
													end
												end
											else
												if (pikachu.image == attackImg.upL) then
													for i,v in ipairs(inimigos) do
														if diagonalColide(attackW.x - attackW.image:getWidth(), attackW.y, 2 *attackW.image:getWidth(), attackW.image:getHeight() - 60, 2, v.x, v.y, v.image:getWidth(), v.image:getHeight()) then
															if (attackW.timeDamage >= 0.7) then
																v.health = v.health - attackW.dps;
																v.rDamage = v.rDamage + attackW.dps;
																if v.health < 0 then
																	pikachu.orbes = pikachu.orbes + v.orbes;
																	table.remove(inimigos, i)
																	map.enemiesKilled = map.enemiesKilled + 1;
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end

					pikachu.move = false;
					if pikachu.dirX == 1 then
						if pikachu.dirY == 0 then
							pikachu.image = attackImg.right;
							attackW.erroX = 20;
							attackW.erroY = 25;
						else
							if pikachu.dirY == 1 then
								pikachu.image = attackImg.downR;
								attackW.erroX = 8;
								attackW.erroY = 18;	
							else
								pikachu.image = attackImg.upR;
								attackW.erroX = 23;
								attackW.erroY = 15;
							end
						end
					else
						if pikachu.dirX == -1 then
							if pikachu.dirY == 0 then
								pikachu.image = attackImg.left;
								attackW.erroX = 5;
								attackW.erroY = 0;
							else
								if pikachu.dirY == 1 then
									pikachu.image = attackImg.downL;
									attackW.erroX = 0;
									attackW.erroY = 2;
								else
									pikachu.image = attackImg.upL;
									attackW.erroX = 17;
									attackW.erroY = 7;
								end
							end
						else
							if pikachu.dirY == -1 then
								pikachu.image = attackImg.up;
								attackW.erroX = 22;
								attackW.erroY = 10;
							else
								pikachu.image = attackImg.down;
								attackW.erroX = -2;
								attackW.erroY = 15;
							end
						end
					end

					if (attackW.foi) then
						if(attackW.time > 0.1) then
							if (attackW.image == attackW.imgs[4]) then
								attackW.image = attackW.imgs[6];
							else
								attackW.image = attackW.imgs[4];
							end
							attackW.time = 0.00001;
						else
							attackW.time = attackW.time + dt;
						end
					else
						attackW.time = attackW.time + dt;
						if (attackW.time < 0.1) then
							attackW.image = attackW.imgs[1];
						else
							if (attackW.time < 0.2) then
								attackW.image = attackW.imgs[2];
							else
								if (attackW.time < 0.3) then
									attackW.image = attackW.imgs[3];
								else
									if (attackW.time < 0.4) then
										attackW.image = attackW.imgs[4];
									else
										if(attackW.time < 0.5) then
											attackW.image = attackW.imgs[5];
										else
											if(attackW.time < 0.6) then
												attackW.image = attackW.imgs[6];
											else
												attackW.foi = true;
												attackW.time = 0.0001;
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
				if (attackW.time ~= 0) then
					pikachu.move = true;
					attackW.foi = false;
					attackW.time = 0;
					attackW.timeDamage = 0.5;
					love.audio.stop( attackW.sound );
				end
			end
		end
	end
end

function attackWDraw( )
    if pikachu.timeRecoil == 0 then
	    if not love.keyboard.isDown("q") then	
			if love.keyboard.isDown("w") then
				if(pikachu.stamina>0)then
					love.graphics.draw(attackW.image, attackW.x, attackW.y, attackW.angle)
				end
			end
	    end
    end	
end


