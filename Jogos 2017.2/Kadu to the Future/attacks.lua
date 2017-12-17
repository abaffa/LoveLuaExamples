-- Importa os módulos necessários para funcionamento do ataque
require("bullets")
require("melee")

attacks = {}

-- Define a função 'draw' do ataque
function attacks.draw()
	love.graphics.scale(0.5, 0.5)
	if debugger then
		bullet_draw_debugger()
		melee_draw_debugger()
	end
	love.graphics.scale(2, 2)
	love.graphics.scale(2, 2)
	bullet_draw()
	melee_draw()
	love.graphics.scale(0.5, 0.5)
end