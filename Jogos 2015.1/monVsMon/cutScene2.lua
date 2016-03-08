function cs2Load(  )
	cs2 =
	{
		state = 0,
		song = love.audio.newSource("sounds/cutScene2.wav"),
		baloes =
		{
			love.graphics.newImage("cs2/balao1.png"), -- (252, 245)
			love.graphics.newImage("cs2/balao2.png"), -- (358, 200)
			love.graphics.newImage("cs2/balao3.png"),
			love.graphics.newImage("cs2/balao4.png"),
			love.graphics.newImage("cs2/balao5.png"),
			love.graphics.newImage("cs2/balao6.png"),
			love.graphics.newImage("cs2/balao7.png"),
			love.graphics.newImage("cs2/balao8.png"),
		},
		amuleto = love.graphics.newImage("cs2/amuleto.png") -- (280, 120) state = 6
	}
end

function cs2Keypressed( key )
	if key == "return" then
		cs2.state = cs2.state + 1;
	end
end

function cs2Draw( )
	love.audio.play(cs2.song);
	love.graphics.draw(map.img,16,12);
	love.graphics.draw(agumonE[1], 400, 350);
	love.graphics.draw(pikachuD[1], 350, 350);
	if(cs2.state == 1)then
		love.graphics.draw(cs2.baloes[1], 252, 245);
	else
		if(cs2.state == 2)then
			love.graphics.draw(cs2.baloes[2], 358, 200);
		else
			if(cs2.state == 3)then
				love.graphics.draw(cs2.baloes[3], 358, 200);
			else
				if(cs2.state == 4)then
					love.graphics.draw(cs2.baloes[4], 358, 200);
				else
					if(cs2.state == 5)then
						love.graphics.draw(cs2.baloes[5], 358, 200);
					else
						if(cs2.state == 6)then
							love.graphics.draw(cs2.amuleto, 280, 120);
						else
							if(cs2.state == 7)then
								love.graphics.draw(cs2.baloes[6], 358, 200);
							else
								if(cs2.state == 8)then
									love.graphics.draw(cs2.baloes[7], 358, 200);
								else
									if(cs2.state == 9)then
										love.graphics.draw(cs2.baloes[8], 358, 200);
									end
								end
							end
						end
					end
				end
			end
		end
	end

	if(cs2.state == 10)then
		love.audio.stop(cs2.song);
		gameState = 1.9;
	end
end