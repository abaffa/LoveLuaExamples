width, height = love.graphics.getDimensions()
local menu = require "menu"
local fase = require "fase"
local pista = require "pista"

hud = {
  resetar = false,
  hit = false,
  barra = {
    barraPic = nil,
    x = width - (3*(width/8)) - width/16,
    y = height/30,
    dimx = (3*(width/8))/545,
    dimy = (3*(height/60.6))/54,
    wid =  (3*(width/8)),
    hei = (3*(height/60.6))
  },

  botao = {
    foto = nil,
    x = width - (3*(width/8)) - width/16,
    y = height/60,
    dimx = 0.5,
    dimy = 0.5,
    speed = 0

  },

  taco = {
      tacoPic = nil,
      x = width/80,
      y = height/60,
      dim = 80,
	  vidas = 3
  }

}

function hud.qualFase(fase)
  local count = 0
  for i=1, #fase do
    if fase[i].onFase then
      count = i 
    end
  end
  return count
end


function hud.load()
  hud.botao.foto     = love.graphics.newImage("HUD/fotoTrump.png")
  hud.barra.barraPic = love.graphics.newImage("HUD/barraProgresso.png")
  hud.taco.tacoPic   =  love.graphics.newImage("HUD/taco.png")
end

function hud.update(dt)

	if not menu.onMenu and not cutscene.onCutscene and not pause.onPause then

		if hud.resetar then --sepa ta ficando true sempre
			hud.botao.x = width - (3*(width/8)) - width/16
			hud.taco.vidas = 3
		end
    
    if hud.hit then
      hud.taco.vidas = hud.taco.vidas - 1
      hud.hit = false
      if hud.taco.vidas == 0 then
       transicao.gameover = true
       congelar_jogo = true
       -- resetarJogo()
      end
    end
    
    
    
   
		hud.botao.speed = hud.barra.wid/fase[hud.qualFase(fase)].tempo
   -- print(hud.botao.speed);
		hud.botao.x = hud.botao.x + hud.botao.speed*dt



	end

end


function hud.draw()
  if not menu.onMenu and not cutscene.onCutscene then
    love.graphics.draw(hud.barra.barraPic, hud.barra.x, hud.barra.y, 0
                      ,hud.barra.dimx, hud.barra.dimy)

    love.graphics.draw(hud.botao.foto, hud.botao.x, hud.botao.y, 0
                      ,hud.botao.dimx, hud.botao.dimy)

    for i=0, hud.taco.vidas - 1 do
      love.graphics.draw(hud.taco.tacoPic, hud.taco.x + i*hud.taco.dim + 3, hud.taco.y, 0
                        ,hud.taco.dim/hud.taco.tacoPic:getWidth(), hud.taco.dim/hud.taco.tacoPic:getHeight())
    end
  end

  -- o que vc quer/ dimensao original

end

return hud

