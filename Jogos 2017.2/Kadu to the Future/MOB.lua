MOB = {}

function MOB.load()
	MM_d_img		= love.graphics.newImage("imagens/mobs/melee_medieval/m_m_down.png")
	MM_u_img		= love.graphics.newImage("imagens/mobs/melee_medieval/m_m_up.png")
	MM_s_img		= love.graphics.newImage("imagens/mobs/melee_medieval/m_m_side.png")
	MM_d_w_img		= love.graphics.newImage("imagens/mobs/melee_medieval/m_m_down_w.png")
	MM_u_w_img		= love.graphics.newImage("imagens/mobs/melee_medieval/m_m_up_w.png")
	MM_s_w1_img		= love.graphics.newImage("imagens/mobs/melee_medieval/m_m_side_w01.png")
	MM_s_w2_img		= love.graphics.newImage("imagens/mobs/melee_medieval/m_m_side_w02.png")

	RM_d_img		= love.graphics.newImage("imagens/mobs/ranged_medieval/r_m_down.png")
	RM_u_img		= love.graphics.newImage("imagens/mobs/ranged_medieval/r_m_up.png")
	RM_s_img		= love.graphics.newImage("imagens/mobs/ranged_medieval/r_m_side.png")
	RM_d_w_img		= love.graphics.newImage("imagens/mobs/ranged_medieval/r_m_down_w.png")
	RM_u_w_img		= love.graphics.newImage("imagens/mobs/ranged_medieval/r_m_up_w.png")
	RM_s_w1_img		= love.graphics.newImage("imagens/mobs/ranged_medieval/r_m_side_w01.png")
	RM_s_w2_img		= love.graphics.newImage("imagens/mobs/ranged_medieval/r_m_side_w02.png")

	rob_d 			= love.graphics.newImage("imagens/mobs/rob/rob_down.png")
	rob_u 			= love.graphics.newImage("imagens/mobs/rob/rob_up.png")
	rob_s 			= love.graphics.newImage("imagens/mobs/rob/rob_side.png")

end

--[[function random_mob_spawn(x, y)
	random_mob = {xPos = x*16, yPos = y*16, pause = 0}
	table.insert(random_mobs, random_mob)
end]]

function RM_mob_spawn(x, y, time, live)
	RM_mob = {xPos = x*16, yPos = y*16, timer = time, side = "d", dir = 1, img = RM_d_img, life = live}
	table.insert(RM_mobs, RM_mob)
end

--[[function MM_mob_spawn(x, y)
	MM_mob = {xPos = x*16, yPos = y*16}
	table.insert(MM_mobs, MM_mob)
end]]

function RM_mob_update(dt)
	for i = #RM_mobs, 1, -1 do
		RM_mob = RM_mobs[i]

		if RM_mob.life < 1 then
			table.remove(RM_mobs, i)
		end

		for j=#bullets, 1, -1 do
			bullet = bullets[j]
			if distancia(bullet.xPos, RM_mob.xPos+8, bullet.yPos, RM_mob.yPos+4) < 8 then
				dano2:rewind()
				dano2:play()
				table.remove(bullets, j)
				RM_mob.life = RM_mob.life - 1
			end
		end

		if map.w ~= futuro_05 then
			if distancia(player.dest_x+9, RM_mob.xPos+8, player.dest_y, RM_mob.yPos) < 14 then
				dano2:rewind()
				dano2:play()
				table.remove(RM_mobs, i)
				player.life = player.life - 2
			end
			if melee.attack == true then
				if 		melee.side == "u" then
					if RM_mob.yPos < player.dest_y and distancia(player.dest_x+9, RM_mob.xPos+8, player.dest_y, RM_mob.yPos) <= 24 then
						dano2:rewind()
						dano2:play()
						RM_mob.life = RM_mob.life - 2
					end
				elseif 	melee.side == "d" then
					if RM_mob.yPos > player.dest_y and distancia(player.dest_x+9, RM_mob.xPos+8, player.dest_y, RM_mob.yPos) <= 24 then
						dano2:rewind()
						dano2:play()
						RM_mob.life = RM_mob.life - 2
					end
				elseif 	melee.side == "l" then
					if RM_mob.xPos < player.dest_x and distancia(player.dest_x+9, RM_mob.xPos+8, player.dest_y, RM_mob.yPos) <= 24 then
						dano2:rewind()
						dano2:play()
						RM_mob.life = RM_mob.life - 2
					end
				elseif 	melee.side == "r" then
					if RM_mob.xPos > player.dest_x and distancia(player.dest_x+9, RM_mob.xPos+8, player.dest_y, RM_mob.yPos) <= 24 then
						dano2:rewind()
						dano2:play()
						RM_mob.life = RM_mob.life - 2
					end
				end
			end

		
			if RM_mob.timer > 0 then
				RM_mob.timer = RM_mob.timer - dt
			else
				enemy_bullet_spawn(RM_mob.xPos, RM_mob.yPos, RM_mob.side)
				RM_mob.timer = 1
			end

			if math.sqrt((player.dest_y - RM_mob.yPos)^2) > math.sqrt((player.dest_x - RM_mob.xPos)^2) then
				if player.dest_y - RM_mob.yPos < 0 then
					RM_mob.side = "u"
					RM_mob.img  = RM_u_img
					RM_mob.off  = 0
					RM_mob.dir  = 1
				else
					RM_mob.side = "d"
					RM_mob.img  = RM_d_img
					RM_mob.off  = 0
					RM_mob.dir  = 1
				end
			else
				if player.dest_x - RM_mob.xPos < 0 then
					RM_mob.side = "l"
					RM_mob.img  = RM_s_img
					RM_mob.off  = 0
					RM_mob.dir  = 1
				else
					RM_mob.side = "r"
					RM_mob.img  = RM_s_img
					RM_mob.off  = 16
					RM_mob.dir  = -1
				end
			end
		else
			if distancia(player.dest_x+9, RM_mob.xPos+8, player.dest_y, RM_mob.yPos) < 14 then
				dano1:rewind()
				dano1:play()
				player.life = 0
			end
			if RM_mob.timer > 0 then
				RM_mob.timer = RM_mob.timer - dt
			else
				enemy_bullet_spawn(RM_mob.xPos, RM_mob.yPos, RM_mob.side)
				RM_mob.timer = 0.5
			end
			if math.sqrt((player.dest_y - RM_mob.yPos)^2) > math.sqrt((player.dest_x - RM_mob.xPos)^2) then
				if player.dest_y - RM_mob.yPos < 0 then
					RM_mob.side = "u"
					RM_mob.img  = rob_u
					RM_mob.off  = 0
					RM_mob.dir  = 1
				else
					RM_mob.side = "d"
					RM_mob.img  = rob_d
					RM_mob.off  = 0
					RM_mob.dir  = 1
				end
			else
				if player.dest_x - RM_mob.xPos < 0 then
					RM_mob.side = "l"
					RM_mob.img  = rob_s
					RM_mob.off  = 0
					RM_mob.dir  = 1
				else
					RM_mob.side = "r"
					RM_mob.img  = rob_s
					RM_mob.off  = 16
					RM_mob.dir  = -1
				end
			end
		end
	end
end

--[[function MM_mob_update(dt)
	for i = #MM_mobs, 1, -1 do
		MM_mob = MM_mobs[i]
		if distancia(player.dest_x, MM_mob.xPos, 0,0) < distancia(0,0, player.dest_y, MM_mob.yPos) then
			if player.dest_x - RM_mob.xPos < 0 then
				--anda pra esquerda
			else
				--anda pra direita
			end
		else
			if player.dest_y - RM_mob.yPos < 0 then
				--anda pra cima
			else
				--anda pra baixo
			end
		end
	end
end

function random_mob_update(dt)
		for i = #random_mobs, 1, -1 do
		random_mob = random_mobs[i]
		if melee.attack == true then
			if 		melee.side == "u" then
				if random_mob.yPos <= player.dest_y and distancia(player.dest_x, random_mob.xPos, player.dest_y, random_mob.yPos) <= 24 then
					table.remove(random_mobs, i)
				end
			elseif 	melee.side == "d" then
				if random_mob.yPos >= player.dest_y and distancia(player.dest_x, random_mob.xPos, player.dest_y, random_mob.yPos) <= 24 then
					table.remove(random_mobs, i)
				end
			elseif 	melee.side == "l" then
				if random_mob.xPos <= player.dest_x and distancia(player.dest_x, random_mob.xPos, player.dest_y, random_mob.yPos) <= 24 then
					table.remove(random_mobs, i)
				end
			elseif 	melee.side == "r" then
				if random_mob.xPos >= player.dest_x and distancia(player.dest_x, random_mob.xPos, player.dest_y, random_mob.yPos) <= 24 then
					table.remove(random_mobs, i)
				end
			end
		end
		for j=#bullets, 1, -1 do
			bullet = bullets[j]
			if distancia(bullet.xPos, random_mob.xPos+8, bullet.yPos, random_mob.yPos+8) <= 8 then
				table.remove(random_mobs, i)
				table.remove(bullets, j)
			end
		end
		if math.floor(random_mob.xPos)%16==0 and math.floor(random_mob.yPos)%16==0 then
			random_mob.side = love.math.random(1, 4) --1==up, 2==down, 3==left, 4==right
			if random_mob.pause <= 0 then
				random_mob.pause = 1
			end
		end
		if random_mob.pause > 0 then
			random_mob.pause = random_mob.pause-dt
		end
		if random_mob.pause <= 0 then
			if 		random_mob.side == 1 then
				random_mob.xPos = random_mob.xPos - 20*dt
			elseif 	random_mob.side == 2 then
				random_mob.xPos = random_mob.xPos + 20*dt
			elseif 	random_mob.side == 3 then
				random_mob.yPos = random_mob.yPos - 20*dt
			elseif 	random_mob.side == 4 then
				random_mob.yPos = random_mob.yPos + 20*dt
			end
		end
	end
end]]

function MOB.update(dt)
	--random_mob_update(dt)
	--MM_mob_update(dt)
	RM_mob_update(dt)
end