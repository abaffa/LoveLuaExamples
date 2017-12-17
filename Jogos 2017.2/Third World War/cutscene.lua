cutscene = {}

function cutscene.load()
	cutscene.on 		= false
	cutscene.button 	= 1
	cutscene.level 		= 1
	cutscene.name 		= "nome da fase"
	cutscene.version 	= 0
end

function cutscene.update(dt)
	if cutscene.level == 1 then
		if cutscene.version == 0 then
			cutscene.name = "Estados Unidos"
			cena = eua
		else
			cutscene.name = "Coreia do Norte"
			cena = coreia
		end
	elseif cutscene.level == 2 then
		if cutscene.version == 0 then
			cutscene.name = "França"
			cena = franca
		else
			cutscene.name = "China"
			cena = china
		end
	elseif cutscene.level == 3 then
		if cutscene.version == 0 then
			cutscene.name = "China"
			cena = china
		else
			cutscene.name = "França"
			cena = franca
		end
	elseif cutscene.level == 4 then
		if cutscene.version == 0 then
			cutscene.name = "Coreia do Norte"
			cena = coreia
		else
			cutscene.name = "Estados Unidos"
			cena = eua
		end
	end
end

function cutscene.draw()
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill", 0, 0, menu.width, menu.height)	
	-- Define a cor (0, 0, 0 = preto) e transparencia (140, de 255)
	love.graphics.setColor(0,0,0,140)
	-- Desenha os retângulos
	love.graphics.rectangle("fill", 100, 20, 600, 80)
	love.graphics.rectangle("fill", 300, 500, 200, 40)

	-- Define a cor do retangulo selecionado
	love.graphics.setColor(255,0,0,100)
	-- Cria uma condicional para definir o retangulo selecionado
	-- (A seleção real ocorre no arquivo "keypressed.lua")
	if cutscene.button == 1 then
		love.graphics.rectangle("fill", 300, 500, 200, 40)
	end
	-- Desenhas as imagens das letras das opções
	-- Define a cor (255,255,255 = branco; nesse caso serve para deixar a imagem na sua cor original
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(TWW, 100, 20)
	love.graphics.draw(b_continuar, 300, 500)

	love.graphics.setColor(255, 255, 255)
	-- Parabeniza o jogador por passar de fase
	love.graphics.printf("Parabéns! Você venceu a batalha em "..cutscene.name..". \n Pressione \"Enter\" para prosseguir.", 0, 260, 400, "center", 0, 2, 2)
	--love.graphics.printf(text, x, y, limit, align, r, sx, sy, ox, oy, kx, ky)
end