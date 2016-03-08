function map3Load()

	map3 =
	{
		img = love.graphics.newImage("bgs/floresta0.png"),
		room = 0,
		imgs =
		{
			love.graphics.newImage("bgs/floresta0.png"),
			love.graphics.newImage("bgs/floresta1.png"),
			love.graphics.newImage("bgs/floresta2.png"),
			love.graphics.newImage("bgs/floresta3.png")
		},
		xFriction = 10,
		yFriction = 10,
		song = love.audio.newSource("sounds/forestSong.wav", "stream"),
		song2 = love.audio.newSource("sounds/digimon.wav", "stream"),
		timesWon = 0,
		spawned = false,
		room0 = 4,
		room1 = 4,
		room2 = 4,
		enemies0 = {},
		enemies1 = {},
		enemies2 = {},
		gema = love.graphics.newImage("bgs/gema1.png")
	}
end

function room0Borders()
	map3.img = map3.imgs[1];
	for i,v in ipairs(agumons) do
		if(v.x >= 1155)then
			v.x = 1154;
		else
			if(v.x <= 200)then
				v.x = 201;
			end
		end

		if(v.y > 660)then
			v.y = 660
		else
			if(v.y < 170)then
				v.y = 171;
			end
		end
	end

	if(pikachu.x >= 1180)then
		if(pikachu.y > 574 and pikachu.y < 606)then
			if(pikachu.x > 1238)then
				map3.room = 2;
				pikachu.move = true;
				pikachu.x = 220;
				map3.enemies0 = agumons;
				if(next(agumons)==nil)then
					map3.room0 = 0;
				else
					agumons = {};
				end
				map3.spawned = false;
			end
		else
			pikachu.x = 1180;
		end
	else
		if(pikachu.x <= 220)then
			pikachu.x = 220;
		end
	end

	if(pikachu.y < 170)then
		if(pikachu.x > 831 and pikachu.x < 861)then
			if(pikachu.y < 100)then
				pikachu.y = 710;
				map3.room = 1;
				pikachu.move = true;
				map3.enemies0 = agumons;
				if(next(agumons)==nil)then
					map3.room0 = 0;
					map3.enemies0 = {}
				else
					agumons = {};
				end
				map3.spawned = false;
			end
		else
			if(pikachu.y < 165 and pikachu.x > 828 and pikachu.x < 864)then
				if(pikachu.x > 840)then
					pikachu.x = 860;
				else
					pikachu.x = 832;
				end
			else
				pikachu.y = 170;
			end
		end
	else
		if(pikachu.y > 660)then
			pikachu.y = 660
		end
	end
end

function room1Borders( )
	map3.img = map3.imgs[2];

	for i,v in ipairs(agumons) do
		if(v.x >= 1155)then
			v.x = 1154;
		else
			if(v.x <= 200)then
				v.x = 201;
			end
		end

		if(v.y > 660)then
			v.y = 660
		else
			if(v.y < 170)then
				v.y = 171;
			end
		end

		if(v.y > 227 and v.y < 308 and v.x < 1037 and v.x > 308)then
			if(v.y > 250) then
				v.y = 308;
			else
				v.y = 227;
			end
		else
			if(v.y > 227 and v.y < 308 and v.x > 300 and v.x < 350)then
				v.x = 300;
			end
		end

		if(v.x > 1034 and v.x < 1114 and v.y < 561)then
			if(v.x > 1070)then
				v.x = 1114;
			else
				v.x = 1033;
			end
		else
			if(v.x > 1034 and v.x < 1112 and v.y < 566)then
				v.y = 567;
			end
		end
	end

	--cantos direita, esquerda
	if(pikachu.x >= 1180)then
		pikachu.x = 1180;
	else
		if(pikachu.x <= 220)then
			pikachu.x = 220;
		end
	end
	--

	--buraco e cantos superior e inferior
	if(pikachu.y < 170)then
		pikachu.y = 170;
	else
		if(pikachu.y > 660)then
			if(pikachu.x > 837 and pikachu.x < 902)then
				if(pikachu.y > 715)then
					map3.room = 0;
					map3.enemies1 = agumons;
					if(next(agumons)==nil)then
						map3.room1 = 0;
					else
						agumons = {};
					end
					pikachu.y = 105;
					map3.spawned = false;
				end
			else
				if(pikachu.y > 670 and pikachu.x > 834 and pikachu.x < 906)then
					if(pikachu.x > 860)then
						pikachu.x = 897;
					else
						pikachu.x = 842;
					end
				else
					pikachu.y = 660
				end
			end
		end
	end
	--

	if(pikachu.y > 227 and pikachu.y < 308 and pikachu.x < 1037 and pikachu.x > 308)then
		if(pikachu.y > 250) then
			pikachu.y = 308;
		else
			pikachu.y = 227;
		end
	else
		if(pikachu.y > 227 and pikachu.y < 308 and pikachu.x > 300 and pikachu.x < 350)then
			pikachu.x = 300;
		end
	end

	if(pikachu.x > 1034 and pikachu.x < 1114 and pikachu.y < 561)then
		if(pikachu.x > 1070)then
			pikachu.x = 1114;
		else
			pikachu.x = 1033;
		end
	else
		if(pikachu.x > 1034 and pikachu.x < 1112 and pikachu.y < 566)then
			pikachu.y = 567;
		end
	end
end

function room2Borders( )
	map3.img = map3.imgs[3];

	for i,v in ipairs(mons) do
		if(v.x >= 1155)then
			v.x = 1154;
		else
			if(v.x <= 200)then
				v.x = 201;
			end
		end

		if(v.y > 660)then
			v.y = 660
		else
			if(v.y < 170)then
				v.y = 171;
			end
		end

		if(v.y>343 and v.y<427 and v.x<554)then
			if(v.y>380)then
				v.y=428;
			else
				v.y = 341;
			end
		else
			if(v.y>342 and v.y < 427 and v.x < 560)then
				v.x = 561;
			end
		end

		if(v.x > 730 and v.x < 802 and v.y > 258)then
			if(v.x > 750)then
				v.x = 803;
			else
				v.x = 729;
			end
		else
			if(v.x > 730 and v.x < 802 and v.y > 253)then
				v.y = 252;
			end
		end
	end

	if(pikachu.x >= 1155)then
		pikachu.x = 1154;
	else
		
		if(pikachu.y > 342 and pikachu.y < 427 and pikachu.x < 554)then
			if(pikachu.y > 380)then
				pikachu.y = 428;
			else
				pikachu.y = 341;
			end
		else
			if(pikachu.y > 342 and pikachu.y < 427 and pikachu.x < 560)then
				pikachu.x = 561;
			end
		end

		if(pikachu.x > 730 and pikachu.x < 802 and pikachu.y > 258)then
			if(pikachu.x > 750)then
				pikachu.x = 803;
			else
				pikachu.x = 729;
			end
		else
			if(pikachu.x > 730 and pikachu.x < 802 and pikachu.y > 253)then
				pikachu.y = 252;
			end
		end
		

		if(pikachu.x <= 200)then
			if(pikachu.y > 573 and pikachu.y < 608)then
				if(pikachu.y < 578)then
					pikachu.y = 579;
				else
					if(pikachu.y > 604)then
						pikachu.y = 603;
					end
				end
			else
				pikachu.x = 201;
			end
			if(pikachu.x < 140)then
				pikachu.x = 1175;
				map3.room = 0;
				pikachu.move = true;
				if(next(mons)==nil)then
					map3.room2 = 0;
				else
					if(next(mons)==nil)then
						map3.room2 = 0;
					else
						mons = {};
					end
				end
				map3.spawned = false;
			end
		end
	end

	if(pikachu.y > 662)then
		if(pikachu.x > 1047 and pikachu.x < 1105)then
			if(pikachu.x > 1100)then
				pikachu.x = 1099;
			else
				if(pikachu.x < 1053)then
					pikachu.x = 1054;
				end
			end

			if(pikachu.y > 730)then
				map3.room = 3;
				pikachu.move = true;
				if(next(mons)==nil)then
					map3.room0 = 0;
				else
					mons = {};
				end
				map3.spawned = false;
				pikachu.y = 144;
			end

		else
			pikachu.y = 659
		end
		
	else
		if(pikachu.y < 170)then
			pikachu.y = 171;
		end
	end
	

	
end

function room3Borders( )
	map3.img = map3.imgs[4];

	if(pikachu.x >= 1155)then
		pikachu.x = 1154;
	else
		if(pikachu.x <= 200)then
			pikachu.x = 201;
		end
	end

	if(pikachu.y > 670)then
		pikachu.y = 670
	else
		if(pikachu.y < 180)then
			pikachu.y = 181;
		end
	end

end

function map3Borders()
	if(map3.room == 0)then
		room0Borders();
	else
		if(map3.room == 1)then
			room1Borders();
		else
			if(map3.room == 2)then
				room2Borders();
			else
				if(map3.room == 3)then
					room3Borders();
				end
			end
		end
	end
end

function room0Enemies( dt )
	if next(map3.enemies0) == nil and map3.room0 > 0 and not map3.spawned then
		i = 1;
		while(i<=map3.room0)do
			rand = love.math.random(i * 100, i * 200);
			lvRand = math.floor(love.math.random(map3.timesWon * 1.5 + 3, map3.timesWon * 1.5 + 6)); 
			agumon_spawn( rand, 200, lvRand);
			i = i + 1;
			map3.spawned = true;
		end
	else
		if(not map3.spawned)then
			agumons = map3.enemies0;
			map3.spawned = true;
		end
	end

	agumonMove(dt);
end

function room1Enemies(dt)
	if next(map3.enemies1) == nil and map3.room1 > 0 and not map3.spawned then
		i = 1;
		while(i<=map3.room1)do
			rand = love.math.random(i * 100, i * 200);
			lvRand = math.floor(love.math.random(map3.timesWon * 1.5 + 3, map3.timesWon * 1.5 + 6)); 
			agumon_spawn(rand, 200, lvRand);
			i = i + 1;
			map3.spawned = true;
		end
	else
		if(not map3.spawned)then
			agumons = map3.enemies1;
			map3.spawned = true;
		end
	end

	agumonMove(dt);
end

function room2Enemies( dt )
	if next(map3.enemies2) == nil and map3.room2 > 0 and not map3.spawned then
		i = 1;
		while(i<=map3.room2)do
			rand = love.math.random(i * 100, i * 200);
			lvRand = math.floor(love.math.random(map3.timesWon * 1.5 + 3, map3.timesWon * 1.5 + 6));
			mon_spawn(rand, 200* i, lvRand);
			i = i + 1;
			map3.spawned = true;
		end
	else
		if(not map3.spawned)then
			mons = map3.enemies2;
			map3.spawned = true;
		end
	end
	monMove(dt);
end

function map3Update( dt )
	orb_generate(dt)
    orb_move(dt)
	love.audio.play(map3.song);
	map3Borders();
	if(map3.room == 0)then
		room0Enemies( dt );
	else
		if(map3.room == 1)then
			room1Enemies( dt );
		else
			if(map3.room == 2)then
				room2Enemies( dt );
			end
		end
	end
	if(map3.room == 2)then
		attackQMonColisao(dt);
	    attackWUpdate(dt, mons);
	else
		attackQAgumonColisao(dt);
	    attackWUpdate(dt, agumons);
	end
	pikachuMove(dt);
	attackQUpdate(dt);
	attackEUpdate(dt);
end

function map3Draw( )
	
	love.graphics.draw(map3.img, 0, 70);
	pikachu_draw();
	pikachuLifeDraw();
	attackQDraw();
	attackWDraw();
	attackEDraw();
	agumon_draw();
	mon_draw();
	orb_desenho();
    orb_draw();
    if(map3.room == 3)then
    	love.audio.stop(map3.song);
    	love.audio.play(map3.song2);
		love.graphics.draw(map3.gema, 300, 600);
		if(colide(300, 600, map3.gema:getWidth(), map3.gema:getHeight(), pikachu.x, pikachu.y, pikachu.image:getWidth(),pikachu.image:getHeight())) then
			gameState = 1.9;
			love.audio.stop(map3.song2);
			pikachu.timeRecoil = 0;
			pikachu.move = true;
			map3.room = 0;
			map3.timesWon = map3.timesWon + 1;
			map3.room0 = 4;
			map3.room1 = 4;
			map3.room2 = 4;
			map3.enemies0 = {};
			map3.enemies1 = {};
			map3.enemies2 = {};
		end
	end
end