function  digiMapLoad()
	digiMap=
	{
		img = love.graphics.newImage("bgs/digimonMap.png"),
		x = 350,
		y = 650,
		song = love.audio.newSource("sounds/digiMapSong.wav"),
		move = false,
		where = 1,
		goTo = 1,
		circle = love.graphics.newImage("bgs/circle.png"),
		time = 0
	}


end

function digiMapUpdate( dt )
	digiMap.time = digiMap.time + dt;
	love.audio.play(digiMap.song);
	if (not digiMap.move) then
		if(love.keyboard.isDown("return") and digiMap.time > 0.7)then
			gameState = digiMap.where;
			digiMap.time = 0;
			love.audio.stop(digiMap.song);
			if(digiMap.where == 2)then
				pikachu.x = 3;
				pikachu.y = 350;
			else
				if(digiMap.where == 3)then
					pikachu.x = 307;
					pikachu.y = 640;
				else
					if(digiMap.where == 1)then
						pikachu.x = 300;
						pikachu.y = 300;
					end
				end
			end
		else
			if(love.keyboard.isDown("right"))then
				digiMap.move = true;
				digiMap.goTo = digiMap.where + 1;
			else
				if(love.keyboard.isDown("left"))then
					digiMap.move = true;
					digiMap.goTo = digiMap.where - 1;
				end
			end
			if(digiMap.goTo > gameState + 1.1)then--1.9 => liberada fase 2 (pode ir até 3); 2.9 =>lib fase 3(até 4) 
				digiMap.goTo = 3;
				digiMap.move = false;
			else
				if(digiMap.goTo < 1)then
					digiMap.goTo = 1;
					digiMap.move = false;
				end
			end
		end
	else
		if(digiMap.goTo == 2)then
			if (digiMap.where == 1) then
				if(digiMap.x < 660)then
					digiMap.x = digiMap.x + 231 * dt;
					digiMap.y = digiMap.y - 130 * dt;
				else
					digiMap.move = false;
					digiMap.where = digiMap.goTo;
				end
			else
				if(digiMap.x > 660)then
					digiMap.x = digiMap.x - 231 * dt;
					digiMap.y = digiMap.y - 130 * dt;
				else
					digiMap.move = false;
					digiMap.where = digiMap.goTo;
				end
			end
		else
			if(digiMap.goTo == 1)then
				if(digiMap.x > 350)then
					digiMap.x = digiMap.x - 231 * dt;
					digiMap.y = digiMap.y + 130 * dt;
				else
					digiMap.move = false;
					digiMap.where = digiMap.goTo;
				end
			else
				if(digiMap.goTo == 3)then
					if(digiMap.x < 900)then
						digiMap.x = digiMap.x + 231 * dt;
						digiMap.y = digiMap.y + 130 * dt;
					else
						digiMap.move = false;
						digiMap.where = digiMap.goTo;
					end
				end
			end
		end
	end
end

function digiMapDraw(  )
	
	love.graphics.draw(digiMap.img, 0, 0);
	love.graphics.draw(pikachuB[1], digiMap.x, digiMap.y);
	love.graphics.draw(digiMap.circle, 200, 600);
	love.graphics.draw(digiMap.circle, 530, 460, 0, 1, 0.5);
	love.graphics.draw(digiMap.circle, 760, 570);

end