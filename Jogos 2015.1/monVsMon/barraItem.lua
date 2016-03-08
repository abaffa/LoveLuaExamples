
function barraItem_load()

	barraItem = love.graphics.newImage("barraItens.png")

	pClick = 0

end

function barraItem_keypressed(key)

	if key == "p" then
		if pClick == 0 then
		   pClick = 1
	        else if pClick == 1 then
		        pClick = 0   
		    end
		end
	end
end

function barraItem_draw()

	if pClick == 1 then

		love.graphics.draw(barraItem, 460, 600)
		love.graphics.setFont(love.graphics.newFont(12));
	    
	    if pikachu.smallPots > 0 then
			love.graphics.draw(pots[1], 540, 640);
			love.graphics.print(pikachu.smallPots, 550, 630);	
		end
		love.graphics.print("1", 550, 685);

		if (pikachu.mediumPots > 0) then
			love.graphics.draw(pots[2], 650, 640)
			love.graphics.print(pikachu.mediumPots, 660, 630);
			
		end  
		love.graphics.print("2", 660, 685);
		if(pikachu.largePots > 0)then
			love.graphics.draw(pots[3], 760, 640)
			love.graphics.print(pikachu.largePots, 770, 630);
			
		end
		love.graphics.print("3", 770, 685);	
	end

end

