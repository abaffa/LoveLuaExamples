function loseLoad( )
	lose=
	{
		audio = love.audio.newSource("sounds/youLose.mp3", "static"),
		time = 0,
		gameState = -1
	}
	
end

function  loseUpdate( dt )
	lose.time = lose.time + dt;
	if(love.keyboard.isDown("r"))then
		gameState = lose.gameState;
		pikachu.life = pikachu.lifeMax;
		pikachu.move = true;
		if(gameState == 1)then
			map.enemiesKilled = 0;
            map.enemiesSpawned = 0;
            map.timesWon = map.timesWon + 1;
            
            
            camera.x = 0;
            camera.y = 0;
            camera.scaleX = 1;
            camera.scaleY = 1;
            camera.rotation = 0;
            pikachu.x = 300;
            pikachu.y = 300;
            pikachu.orbes = 0;
            agumons = {};
        else
        	if(gameState == 3)then
        		pikachu.x = 307;
				pikachu.y = 640;
				map3.spawned = false
				map3.room = 0
				map3.room0 = 4
				map3.room1 = 4
				map3.room2 = 4
				map3.enemies0 = {}
				map3.enemies1 = {}
				map3.enemies2 = {}
				agumons = {}
        	end
		end
	end
end

function loseDraw()
	if(lose.time > 5)then
		love.audio.stop(lose.audio);
	else
		love.audio.play(lose.audio);
	end
	love.graphics.print("VOCE MORREU!", 400, 300);

	love.graphics.print("Aperte 'r' para retornar ao digiMundo", 400, 350);
end