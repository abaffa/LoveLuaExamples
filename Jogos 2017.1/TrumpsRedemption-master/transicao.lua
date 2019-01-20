transicao ={
	
	trans = {},
	venceu = nil,
	perdeu = nil,
	betweenfases = false,
	n = 1,
	gameover = false,
	ganhou = false

}

function transicao.load()
-- carrega as fotenha
	for i=1, 5 do 
		transicao.trans[i] = love.graphics.newImage("Transicao/f"..i..".png")	
	end

	transicao.venceu = love.graphics.newImage("Transicao/vitoria.png")
	transicao.perdeu = love.graphics.newImage("Transicao/over.png")

end

function transicao.draw()
	
	if transicao.betweenfases then
		love.graphics.draw(transicao.trans[transicao.n],0, 0)
	end

	if transicao.gameover then
		love.graphics.draw(transicao.perdeu, 0, 0)
	end

	if transicao.ganhou then
		love.graphics.draw(transicao.venceu, 0, 0)
	end



end

return transicao
