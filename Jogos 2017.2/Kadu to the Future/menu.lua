menu = {}

function menu.load()
	menu.width 	= 640
	menu.height = 480
	menu.on 	= true
	menu.button	= 1
	button_w 	= 200
	button_h 	= 40

	KttF_logo 	= love.graphics.newImage("imagens/misc/KadutotheFuture_Logo_4x.png")

	menu_song:play()
end

function menu.update(dt)
end

function menu.draw()
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
	if menu.button == 1 then
		love.graphics.rectangle("fill", menu.width*0.5-100, menu.height-220, button_w, button_h)
	elseif menu.button == 2 then
		love.graphics.rectangle("fill", menu.width*0.5-100, menu.height-160, button_w, button_h)
	elseif menu.button == 3 then
		love.graphics.rectangle("fill", menu.width*0.5-100, menu.height-100, button_w, button_h)
	end	

	-- Define a cor (255,255,255 = branco; nesse caso serve para deixar a imagem na sua cor original)
	love.graphics.setColor(255, 255, 255)

	--Desenha a logo
	love.graphics.draw(KttF_logo, menu.width-440-((menu.width-440)/2), menu.height-460)

	-- Desenhas as opções
	love.graphics.printf("Jogar", menu.width*0, (menu.height-220+7), menu.width/2, "center", 0, 2, 2)
	love.graphics.printf("Continuar", menu.width*0, (menu.height-160+7), menu.width/2, "center", 0, 2, 2)
	love.graphics.printf("Sair", menu.width*0, (menu.height-100+7), menu.width/2, "center", 0, 2, 2)
end