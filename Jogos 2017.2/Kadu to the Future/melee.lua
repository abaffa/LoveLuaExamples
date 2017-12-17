-- Cria tabela para ataque melee (corpo a corpo)
melee 			= {}

-- Cria variável temporizadora do ataque melee
melee_trigger 	= 0

-- Define se o ataque está ocorrendo ou não
melee.attack 	= false

-- Define para qual direção o ataque está sendo executado
melee.side 		= "start"

-- Define a duração do ataque
attack_duration = 0

-- Define a função update de 'melee'
function melee_update(dt)
	-- Define o botão de ativação do ataque e seus valores
	if love.keyboard.isDown("a") and melee_trigger <= 0 --[[and player.dest_x % 16 == 0 and player.dest_y % 16 == 0]] then
		whoosh:rewind()
		whoosh:play()
		player.still 	= true
		melee.attack 	= true
		attack_duration = 0.3
		melee_trigger 	= 0.6
		melee.side 		= player.side
	end

	-- Função de atualização da duração do ataque
	if melee.attack == true then
		if attack_duration > 0 then
			attack_duration = attack_duration - dt
		elseif attack_duration <= 0 then
			melee.attack = false
			player.still = false
		end
	end

	-- Função de atualização do temporizador
	if melee_trigger > 0 then
		melee_trigger = melee_trigger - dt
	end
end

-- Define a função draw do Debugger de 'melee'
function melee_draw_debugger()
	if melee.attack then
		love.graphics.setColor(255, 0, 0)
		love.graphics.circle("line", player.dest_x+8, player.dest_y+8, 20)
	end
end

-- Define a função draw de 'melee'
function melee_draw()
	if melee.attack then
		love.graphics.setColor(255, 0, 0)
		love.graphics.circle("line", (320-8)/2+9, (240-13)/2+15, 20)
	end
end