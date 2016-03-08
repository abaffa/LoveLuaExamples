function map2Load()
	map2 =
	{
		img = love.graphics.newImage("bgs/cidade.png"),
		xFriction = 8,
		yFriction = 8,
		song = love.audio.newSource("sounds/cidadeSong.wav", "stream"),
		pika3x = love.audio.newSource("sounds/pikax3.wav"),
		loja = false,
		lojaAgu = love.graphics.newImage("bgs/lojaDoAgumon.png"),
		lojaAguStage = 0,
		cursorX = 150,
		cursorY = 270,
		selected = 1,
		time = 0,
		apertou = false,
		falta = false
	};

	pots =
	{
		love.graphics.newImage("bgs/smallPot.png"),
		love.graphics.newImage("bgs/mediumPot.png"),
		love.graphics.newImage("bgs/largePot.png"),
		love.graphics.newImage("bgs/potSelect.png")
	}
end

function map2KeyPress( key )
	if(map2.loja == true)then
		if( map2.lojaAguStage == 2)then
			if key == "down" then
				map2.selected = 4;
			end
			  
			if key == "up" then
				map2.selected = 1;
			end

			if key == "right" then
				map2.selected = map2.selected + 1;
				if( map2.selected == 4)then
					map2.selected = 1;
				end
			end

			if key == "left" then
				map2.selected = map2.selected - 1;
				if( map2.selected == 0)then
					map2.selected = 3;
				end
			end
		else
			if key == "down" then
				map2.selected = map2.selected + 1;
			end
			  
			if key == "up" then
				map2.selected = map2.selected - 1;
			end
		end
	end

	if key == "return" then
		map2.apertou = true;
	end
end

function menu( )
	if(map2.selected == 1)then
		map2.lojaAguStage = 1;
		if(pikachu.lv * pikachu.lv * 1000 > pikachu.orbes)then
			map2.falta = true;
		else
			map2.falta = false;
		end
	else
		if(map2.selected == 2)then
			map2.lojaAguStage = 2;
			map2.selected = 1;
		else
			map2.loja = false;
			pikachu.move = true;
			map2.lojaAguStage = 0;
			map2.selected = 1;
		end
	end
end

function menuArrows()
	if(map2.selected == 4)then
		map2.selected = 1;
	else
		if(map2.selected == 0)then
			map2.selected = 3;
		end
	end
end

function upar( )
	pikachu.orbes = pikachu.orbes - (pikachu.lv * pikachu.lv * 1000);
	pikachu.lv = pikachu.lv + 1;
	map2.apertou = false;
	map2.loja = false;
	pikachu.move = true;
	map2.lojaAguStage = 0;
	map2.selected = 1;
	love.audio.play(attackW.sound);
	lvUp();
end

function uparEnter(  )

	if(map2.selected == 3)then
		map2.lojaAguStage = 0;
		map2.selected = 1;
	else
		if(map2.selected == 2)then
			upar();
		end
	end
end

function uparArrows( )
	if(map2.falta)then
		map2.selected = 3;
	else
		if(map2.selected == 1)then
			map2.selected = 2;
		else
			if(map2.selected == 4)then
				map2.selected = 3;
			end
		end
	end
end

function comprarPot(  )

end

function map2Update( dt )
	love.audio.play(map2.song);
	pikachuMove(dt);
	if(pikachu.y > 460)then
		pikachu.y = 460;
	else
		if(pikachu.y<225)then
			pikachu.y = 225;
		end
	end

	if(pikachu.x > 680 and pikachu.x < 760 and pikachu.y < 270)then

		if(map2.loja)then
			if(map2.apertou)then
				map2.apertou = false;
				if(map2.lojaAguStage == 0)then
					menu();
				else
					if(map2.lojaAguStage == 1)then
						uparEnter();
					else
						if(map2.lojaAguStage == 2)then

							if(map2.selected == 1)then
								if(pikachu.orbes >= 3000)then
									love.audio.play(map2.pika3x);
									pikachu.orbes = pikachu.orbes - 3000;
									pikachu.smallPots = pikachu.smallPots + 1;
									pikachu.move = true;
									map2.loja = false;
									map2.lojaAguStage = 0;
									map2.selected = 1;
								end
							end

							if(map2.selected == 2)then
								if(pikachu.orbes >= 4000)then
									love.audio.play(map2.pika3x);
									pikachu.orbes = pikachu.orbes - 4000;
									pikachu.mediumPots = pikachu.mediumPots + 1;
									pikachu.move = true;
									map2.loja = false;
									map2.lojaAguStage = 0;
									map2.selected = 1;
								end
							end

							if(map2.selected == 3)then
								if(pikachu.orbes >= 5000)then
									love.audio.play(map2.pika3x);
									pikachu.orbes = pikachu.orbes - 5000;
									pikachu.largePots = pikachu.largePots + 1;
									pikachu.move = true;
									map2.loja = false;
									map2.lojaAguStage = 0;
									map2.selected = 1;
								end
							end

							if(map2.selected == 4)then
								map2.lojaAguStage = 0;
								map2.selected = 1;
							end
						end
					end
				end
				
			end

			if(map2.lojaAguStage == 0)then
				menuArrows();
			else
				if(map2.lojaAguStage == 1)then
					uparArrows();
				end
			end

			if(map2.selected == 1)then
				map2.cursorY = 270;
			else
				if(map2.selected == 2)then
					map2.cursorY = 300;
				else
					map2.cursorY = 330;
				end
			end
		else
			if(map2.apertou)then
				map2.apertou = false;
				map2.loja = true;
				pikachu.move = false;
				love.audio.play(pikachuSound);
			end
		end
	end

	if(pikachu.x < -100 or pikachu.x > 1400)then
		gameState = 1.9;
		love.audio.stop(map2.song);
		pikachu.x = 300;
		pikachu.y = 300;
	end
end

function map2Draw( )
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(map2.img, 0 , 0);
	love.graphics.draw(pikachu.image, pikachu.x, pikachu.y);
	if(map2.loja)then
		love.graphics.draw(map2.lojaAgu, 100, 200);
		if(map2.lojaAguStage == 0)then
			love.graphics.draw(pikachuD[1], map2.cursorX, map2.cursorY, 0, 0.7, 0.7)
			love.graphics.setFont(love.graphics.newFont(20));
			love.graphics.setColor(0, 0, 0)
			love.graphics.print("O que você deseja?", 150, 240);
			love.graphics.setFont(love.graphics.newFont(18));
			love.graphics.setColor(255, 255, 255)
			love.graphics.print("Upar", 180, 270);
			love.graphics.print("Comprar pot", 180, 300);
			love.graphics.print("Sair", 180, 330);
		else
			if(map2.lojaAguStage == 1)then
				love.graphics.draw(pikachuD[1], map2.cursorX, map2.cursorY, 0, 0.7, 0.7)
				love.graphics.setFont(love.graphics.newFont(20));
				love.graphics.setColor(0, 0, 0)
				love.graphics.print("São necessárias: ".. pikachu.lv * pikachu.lv * 1000 .. " orbes.", 150, 240);
				love.graphics.print("Você tem " .. pikachu.orbes .. " orbes", 150, 270);
				love.graphics.setFont(love.graphics.newFont(18));
				if(map2.falta)then
					love.graphics.print("VOCÊ NÃO TEM ORBES SUFICIENTES!!!", 150, 300);
				else
					love.graphics.setColor(255, 255, 255)
					love.graphics.print("Gastar", 180, 300);
				end
				love.graphics.setColor(255, 255, 255)
				love.graphics.print("Voltar", 180, 330);

			else
				if(map2.lojaAguStage == 2)then
					love.graphics.setColor(255, 255, 255);
					love.graphics.draw(pots[1], 198, 265);
					love.graphics.draw(pots[2], 235, 265);
					love.graphics.draw(pots[3], 268, 265);
					love.graphics.setFont(love.graphics.newFont(15));
					if(map2.selected == 1)then
						love.graphics.draw(pots[4], 190, 260);
						love.graphics.setColor(0, 0, 0);
						love.graphics.print("Poção pequena: Cura 50 de HP.", 305, 250);
						love.graphics.print("Custo: 3000 orbes.", 305, 270);
					else
						if(map2.selected == 2)then
							love.graphics.draw(pots[4], 228, 260);
							love.graphics.setColor(0, 0, 0);
							love.graphics.print("Poção media: Cura 100 de HP.", 305, 250);
							love.graphics.print("Custo: 4000 orbes.", 305, 270);
						else
							if(map2.selected == 3)then
								love.graphics.draw(pots[4], 264, 260);
								love.graphics.setColor(0, 0, 0);
								love.graphics.print("Poção grande: Cura 200 de HP.", 305, 250);
								love.graphics.print("Custo: 5000 orbes.", 305, 270);
							else
								if(map2.selected == 4)then
									love.graphics.draw(pikachuD[1], map2.cursorX, map2.cursorY, 0, 0.7, 0.7);
								end
							end
						end
					end
					love.graphics.setColor(0, 0, 0);
					love.graphics.print("Você possui: ".. pikachu.orbes .." orbes.", 305, 290);
					love.graphics.setColor(255, 255, 255);
					love.graphics.setFont(love.graphics.newFont(18));
					love.graphics.print("Voltar", 180, 330);
				end
			end
		end
	end
end