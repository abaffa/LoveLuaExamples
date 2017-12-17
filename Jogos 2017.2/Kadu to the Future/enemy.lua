require("MOB")
require("enemy_bullets")

enemy = {}

random_mobs = {}
RM_mobs 	= {}
MM_mobs 	= {}

function enemy.load()
	mob = love.graphics.newImage("imagens/misc/mob.png")
end

function enemy.update(dt)
	if debugger then
		if love.keyboard.isDown("lctrl") and love.keyboard.isDown("n") then
			random_mobs = {}
		end
	end
	--random_mob_update(dt)
end

function enemy.draw()
	love.graphics.scale(2, 2)
	for i=#RM_mobs, 1, -1 do
		love.graphics.setColor(255, 255, 255)
		RM_mob = RM_mobs[i]
		love.graphics.draw(RM_mob.img, RM_mob.xPos-player.dest_x+10*16-3, RM_mob.yPos-player.dest_y+8*16-13, 0, RM_mob.dir, 1, RM_mob.off)
		--love.graphics.draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
	end
	--[[for i=#random_mobs, 1, -1 do
		love.graphics.setColor(255, 100, 255)
		random_mob = random_mobs[i]
		love.graphics.draw(mob, random_mob.xPos-player.dest_x+10*16-3, random_mob.yPos-player.dest_y+8*16-4)
	end]]
	love.graphics.scale(0.5, 0.5)
end