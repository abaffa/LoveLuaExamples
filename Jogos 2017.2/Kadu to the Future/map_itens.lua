-- Cria uma tabela para itens no mapa
map_itens = {}

-- Define a função load de 'map_itens'
function map_itens.load()
	-- Carrega as imagens dos itens em variáveis
	snorlax = love.graphics.newImage("imagens/map_itens/pelucia_gg.png")
	poste 	= love.graphics.newImage("imagens/map_itens/poste.png")
end

function map_itens.update(dt)
end

-- Define a função draw de 'map_itens'
function map_itens.draw()
	--[[Desenha os itens do mapa da tela (cria perspectiva no jogo, sensação de profundidade)]]
	love.graphics.scale(2, 2)
	if map.w == quarto_kadu then
		love.graphics.setColor(255,255,255)
		love.graphics.draw(snorlax, map_img_x+84-player.dest_x, map_img_y+72-player.dest_y--[[88+32-4, 72+32]])
	end
	love.graphics.scale(0.5, 0.5)
end