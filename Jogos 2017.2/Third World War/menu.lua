menu = {}

function menu.load()
	TWW 	 	= love.graphics.newImage("images/menu/TWW.png")
	b_jogar		= love.graphics.newImage("images/menu/jogar_img.png")
	b_continuar = love.graphics.newImage("images/menu/continuar_img.png")
	b_sair		= love.graphics.newImage("images/menu/sair_img.png")
	BG			= love.graphics.newImage("images/menu/BG.png")
	menu.width 	= 800
	menu.height = 600
	menu.on 	= true
	menu.button	= 1
end

function menu.update(dt)
end

function menu.draw()
	love.graphics.setColor(255, 255, 255)
	-- Desenha a imagem de background
	love.graphics.draw(BG, 0, 0)
	
	-- Define a cor (0, 0, 0 = preto) e transparencia (140, de 255)
	love.graphics.setColor(0,0,0,140)
	-- Desenha os retângulos
	love.graphics.rectangle("fill", 100, 20, 600, 80)
	love.graphics.rectangle("fill", 300, 260, 200, 40)
	love.graphics.rectangle("fill", 300, 340, 200, 40)
	love.graphics.rectangle("fill", 300, 420, 200, 40)

	-- Define a cor do retangulo selecionado
	love.graphics.setColor(255,0,0,100)
	-- Cria uma condicional para definir o retangulo selecionado
	-- (A seleção real ocorre no arquivo "keypressed.lua")
	if menu.button == 1 then
		love.graphics.rectangle("fill", 300, 260, 200, 40)
	elseif menu.button == 2 then
		love.graphics.rectangle("fill", 300, 340, 200, 40)
	elseif menu.button == 3 then
		love.graphics.rectangle("fill", 300, 420, 200, 40)
	end	

	-- Define a cor (255,255,255 = branco; nesse caso serve para deixar a imagem na sua cor original)
	love.graphics.setColor(255, 255, 255)
	-- Desenhas as imagens das letras das opções
	love.graphics.draw(TWW, 100, 20)
	love.graphics.draw(b_jogar, 300, 260)
	love.graphics.draw(b_continuar, 300, 340)
	love.graphics.draw(b_sair, 300, 420)
end