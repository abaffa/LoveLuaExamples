function orb_load()
	orbImage = love.graphics.newImage("orb.png");

	orbs = {}
end



function orb_spawn(x, y)
	table.insert(orbs,
	{	
		x=x,
		y=y,
		image=orbImage
    })
end

function orb_generate(dt)
	if(map3.room == 2)then
		for i,v in ipairs(mons) do
			if v.health <= 1 and v.orbFoi == 0 then
	              for i = 1, v.orbes,1 do
				    orb_spawn(v.x, v.y)
				  end
				    v.orbFoi = 1
			end
		end
	else
		for i,v in ipairs(agumons) do
			if v.health <= 1 and v.orbFoi == 0 then
	              for i = 1, v.orbes,1 do
				    orb_spawn(v.x, v.y)
				  end
				    v.orbFoi = 1
			end
		end
	end
end

function orb_draw()
	for i,v in ipairs(orbs) do
		love.graphics.setColor(255,255,255)
        love.graphics.draw(v.image, v.x, v.y)
    end
end

function orb_move(dt)
	for i,v in ipairs(orbs) do
		if v.x > pikachu.x then
			v.x = v.x - 200 * dt
		end

		if v.x < pikachu.x then
			v.x = v.x + 200 * dt
		end

		if v.y < pikachu.y then
			v.y = v.y + 200 * dt
		end

		if v.y > pikachu.y then
			v.y = v.y - 200 * dt
		end
        
        if pikachu.x - 7 < v.x and
        	pikachu.x + 7 > v.x and
        	pikachu.y - 7 < v.y and
        	pikachu.y + 7 > v.y then
        	table.remove(orbs, i)
        end

		
	end
end

function orb_desenho()
	  love.graphics.draw(orbImage, 1250, 15);

	  love.graphics.print(pikachu.orbes,1310, 25)
end