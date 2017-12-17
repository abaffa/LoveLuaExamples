pause = {}

function pause.load()
	pause.on 		= false
	pause.button 	= 1
end

function pause.update(dt)
end

function pause.draw()
	love.graphics.setBackgroundColor(40, 40, 40)
	
	-- Define a cor (0, 0, 0 = preto) e transparencia (140, de 255)
	love.graphics.setColor(0,0,255, 200)
	-- Desenha os retângulos
	love.graphics.rectangle("fill", menu.width*0.5-100, menu.height-220, button_w, button_h)
	love.graphics.rectangle("fill", menu.width*0.5-100, menu.height-160, button_w, button_h)
	love.graphics.rectangle("fill", menu.width*0.5-100, menu.height-100, button_w, button_h)

	-- Define a cor do retangulo selecionado
	love.graphics.setColor(255,55,0,200)
	-- Cria uma condicional para definir o retangulo selecionado
	-- (A seleção real ocorre no arquivo "keypressed.lua")
	if pause.button == 1 then
		love.graphics.rectangle("fill", menu.width*0.5-100, menu.height-220, button_w, button_h)
	elseif pause.button == 2 then
		love.graphics.rectangle("fill", menu.width*0.5-100, menu.height-160, button_w, button_h)
	elseif pause.button == 3 then
		love.graphics.rectangle("fill", menu.width*0.5-100, menu.height-100, button_w, button_h)
	end	

	-- Define a cor (255,255,255 = branco; nesse caso serve para deixar a imagem na sua cor original)
	love.graphics.setColor(255, 255, 255)

	-- Desenha o logo
	love.graphics.draw(KttF_logo, menu.width-440-((menu.width-440)/2), menu.height-460)
	
	-- Desenhas as opções
	love.graphics.printf("Continuar", menu.width*0, (menu.height-220+7), menu.width/2, "center", 0, 2, 2)
	love.graphics.printf("Salvar", menu.width*0, (menu.height-160+7), menu.width/2, "center", 0, 2, 2)
	love.graphics.printf("Sair", menu.width*0, (menu.height-100+7), menu.width/2, "center", 0, 2, 2)
end