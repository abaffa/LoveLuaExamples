pause = {}

function pause.load()
	pause.on 		= false
	pause.button 	= 1
end

function pause.update(dt)
end

function pause.draw()
	love.graphics.setColor(255, 255, 255)
	-- Desenha a imagem de background
	love.graphics.draw(BG, 0, 0)
	
	-- Define a cor (0, 0, 0 = preto) e transparencia (140, de 255)
	love.graphics.setColor(0,0,0,140)
	-- Desenha os retângulos
	love.graphics.rectangle("fill", 100, 20, 600, 80)
	love.graphics.rectangle("fill", 300, 260, 200, 40)
	love.graphics.rectangle("fill", 300, 420, 200, 40)

	-- Define a cor do retangulo selecionado
	love.graphics.setColor(255,0,0,100)
	-- Cria uma condicional para definir o retangulo selecionado
	-- (A seleção real ocorre no arquivo "keypressed.lua")
	if pause.button == 1 then
		love.graphics.rectangle("fill", 300, 260, 200, 40)
	elseif pause.button == 2 then
		love.graphics.rectangle("fill", 300, 420, 200, 40)
	end	

	-- Define a cor (255,255,255 = branco; nesse caso serve para deixar a imagem na sua cor original)
	love.graphics.setColor(255, 255, 255)
	-- Desenhas as imagens das letras das opções
	love.graphics.draw(TWW, 100, 20)
	love.graphics.draw(b_continuar, 300, 260)
	love.graphics.draw(b_sair, 300, 420)
end