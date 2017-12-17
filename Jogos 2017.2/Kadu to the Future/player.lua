require("grid")
require("map")
require("bullets")
require("melee")

player = {}

function player.load()
	kadu_up 		= love.graphics.newImage("imagens/kadu/kadu_cima.png")
	kadu_down 		= love.graphics.newImage("imagens/kadu/kadu_baixo.png")
	kadu_left 		= love.graphics.newImage("imagens/kadu/kadu_esquerda.png")
	kadu_right 		= love.graphics.newImage("imagens/kadu/kadu_direita.png")
	kadu_up_w1 		= love.graphics.newImage("imagens/kadu/kadu_cima_w1.png")
	kadu_down_w1 	= love.graphics.newImage("imagens/kadu/kadu_baixo_w1.png")
	kadu_left_w1 	= love.graphics.newImage("imagens/kadu/kadu_esquerda_w1.png")
	kadu_right_w1 	= love.graphics.newImage("imagens/kadu/kadu_direita_w1.png")
	kadu_up_w2 		= love.graphics.newImage("imagens/kadu/kadu_cima_w2.png")
	kadu_down_w2 	= love.graphics.newImage("imagens/kadu/kadu_baixo_w2.png")
	kadu_left_w2 	= love.graphics.newImage("imagens/kadu/kadu_esquerda_w2.png")
	kadu_right_w2 	= love.graphics.newImage("imagens/kadu/kadu_direita_w2.png")

	player.x 		= 112
	player.y 		= 64
	player.dest_x 	= player.x
	player.dest_y 	= player.y
	player.speed 	= 60
	player.side 	= "d"
	player.life 	= 10
	player.still 	= false

	player.img_x 	= (320-8)/2
	player.img_y 	= (240-13)/2
end

function player.update(dt)
	if not player.still then
		if love.keyboard.isDown("s") then
			bullet_spawn(player.dest_x, player.dest_y, player.side)
		end

		if love.keyboard.isDown("lshift") then
			player.speed = 90
		else
			player.speed = 60
		end

		if love.keyboard.isDown("up") then
			if player.dest_y == player.y then
				if player.dest_x % 16 == 0 and player.dest_y % 16 == 0 then
					if grid(map.w, player.x/16, player.y/16) ~= 2 then player.side = "u" end
					if grid(map.w, player.x/16, (player.y-16)/16) then
						player.y = player.y - 16
					end
				end
			end
		elseif love.keyboard.isDown("down") then
			if player.dest_y == player.y then
				if player.dest_x % 16 == 0 and player.dest_y % 16 == 0 then
					player.side = "d"
					if grid(map.w, player.x/16, (player.y+16)/16) then
						player.y = player.y + 16
					end
				end
			end
		elseif love.keyboard.isDown("left") then
			if player.dest_x == player.x then
				if player.dest_x % 16 == 0 and player.dest_y % 16 == 0 then
					player.side = "l"
					if grid(map.w, (player.x-16)/16, player.y/16) then
						player.x = player.x - 16
					end
				end
			end
		elseif love.keyboard.isDown("right") then
			if player.dest_x == player.x then
				if player.dest_x % 16 == 0 and player.dest_y % 16 == 0 then
					player.side = "r"
					if grid(map.w, (player.x+16)/16, player.y/16) then
						player.x = player.x + 16
					end
				end
			end
		end



		if player.dest_y ~= player.y then
			if player.side == "u" then
				player.dest_y = player.dest_y - player.speed*dt
			elseif player.side == "d" then
				player.dest_y = player.dest_y + player.speed*dt
			end
			if player.dest_y < player.y+1 and player.dest_y > player.y-1 then
				player.dest_y = player.y
			end
		end
		if player.dest_x ~= player.x then
			if player.side == "l" then
				player.dest_x = player.dest_x - player.speed*dt
			elseif player.side == "r" then
				player.dest_x = player.dest_x + player.speed*dt
			end
			if player.dest_x < player.x+1 and player.dest_x > player.x-1 then
				player.dest_x = player.x
			end
		end
	end
end

function player.draw()
	love.graphics.scale(0.5, 0.5)
	if debugger then
		love.graphics.setColor(204, 14, 14)
		love.graphics.rectangle("fill", player.dest_x, player.dest_y, 16, 16)
	end
	love.graphics.scale(2, 2)
	
	love.graphics.scale(2, 2)
	bullet_draw()
	melee_draw()
	love.graphics.setColor(255,255,255)
	if player.side == "u" and player.dest_y == player.y then
		love.graphics.draw(kadu_up, player.img_x, player.img_y--[[player.dest_x-1, player.dest_y-6]])
	elseif player.side == "u" and (player.dest_y - player.y) < 8 then
		love.graphics.draw(kadu_up_w1, player.img_x, player.img_y--[[player.dest_x-1, player.dest_y-6]])
	elseif player.side == "u" and (player.dest_y - player.y) > 8 then
		love.graphics.draw(kadu_up_w2, player.img_x, player.img_y--[[player.dest_x-1, player.dest_y-6]])

	elseif player.side == "d" and player.dest_y == player.y then
		love.graphics.draw(kadu_down, player.img_x, player.img_y--[[player.dest_x-1, player.dest_y-6]])
	elseif player.side == "d" and (player.y - player.dest_y) < 8 then
		love.graphics.draw(kadu_down_w1, player.img_x, player.img_y--[[player.dest_x-1, player.dest_y-6]])
	elseif player.side == "d" and (player.y - player.dest_y) > 8 then
		love.graphics.draw(kadu_down_w2, player.img_x, player.img_y--[[player.dest_x-1, player.dest_y-6]])

	elseif player.side == "l" and player.dest_x == player.x then
		love.graphics.draw(kadu_left, player.img_x, player.img_y--[[player.dest_x-1, player.dest_y-6]])
	elseif player.side == "l" and (player.dest_x - player.x) < 8 then
		love.graphics.draw(kadu_left_w1, player.img_x, player.img_y--[[player.dest_x-1, player.dest_y-6]])
	elseif player.side == "l" and (player.dest_x - player.x) > 8 then
		love.graphics.draw(kadu_left_w2, player.img_x, player.img_y--[[player.dest_x-1, player.dest_y-6]])

	elseif player.side == "r" and player.dest_x == player.x then
		love.graphics.draw(kadu_right, player.img_x, player.img_y--[[player.dest_x-1, player.dest_y-6]])
	elseif player.side == "r" and (player.x - player.dest_x) < 8 then
		love.graphics.draw(kadu_right_w1, player.img_x, player.img_y--[[player.dest_x-1, player.dest_y-6]])
	elseif player.side == "r" and (player.x - player.dest_x) > 8 then
		love.graphics.draw(kadu_right_w2, player.img_x, player.img_y--[[player.dest_x-1, player.dest_y-6]])
	end
	love.graphics.scale(0.5, 0.5)
end