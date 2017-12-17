-- Cria a variável de cenário
cenario = {}

-- Cria as variáveis associadas ao cenário
function cenario.load()
	eua 		= love.graphics.newImage("images/mapa/eua.png")
	coreia 		= love.graphics.newImage("images/mapa/coreia.png")
	franca 		= love.graphics.newImage("images/mapa/franca.png")
	china 		= love.graphics.newImage("images/mapa/china.png")
	cena 		= "?"
	chao 		= love.graphics.newImage("images/mapa/ground.png")
	chaozao 	= love.graphics.newImage("images/mapa/ground_long.png")
	tempo 		= 0
	cenario.s 	= 50
end

-- Atualiza as variáveis associadas ao cenário
function cenario.update(dt)
	-- contagem de tempo decorrido em relação a velocidade do chão
	tempo = tempo + cenario.s * dt

	if tempo >= 2000 then
		if #mobs == 0 then
			tempo = 0
			cenario.s = 50
			cutscene.on = true
		else
			tempo = 4000
			cenario.s = 0
		end
	end
end

-- "Desenha" o cenário
function cenario.draw()
	-- desenha o cenario
	love.graphics.draw(cena, -tempo/20, 0)
	-- faz o chão mover para a esquerda conforme o tempo
	love.graphics.draw(chaozao, -tempo, 500)
end