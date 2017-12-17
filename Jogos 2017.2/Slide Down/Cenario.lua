local Cenario = {}
local background, coin
local background_x = 0
local background_y = 0
local Plataform_Height = love.graphics.getHeight()


function Cenario.load()
	love.graphics.setBackgroundColor(255, 0, 0)
		background = love.graphics.newImage("Assets//Image//BackGround.png")

	    background_y2 =  background:getHeight()
    	 ini_C = 0 
end


function Cenario.update(dt)
	background_y = background_y + (-600*dt)
		if background_y + background:getHeight() < 0  then
			background_y = ini_C
		end

end

function Cenario.draw()
	love.graphics.draw(background, background_x, background_y)
	love.graphics.draw(background, background_x, background_y+background_y2)

end


return Cenario