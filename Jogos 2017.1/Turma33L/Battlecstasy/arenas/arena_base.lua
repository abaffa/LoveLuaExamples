--*Lembrar de conectar a arena_base a game. Além disso, está faltando um player.lua. Será possível chamar arenaNum no Arena_Base:new() toda vez que a tela de jogo (game) for iniciada?

local Arena_Base = {}
local bg_images
local bg_posYm = {540, 590, 570, 570, 570, 550, 480, 570, 570, 570, 580, 490, 490, 530, 550, 540, 550, 520}
--local bg_sounds = {}
--local start = true

function Arena_Base:new(arenaNum)
  --for i = 1,18 do
  bg_images = love.graphics.newImage("arenas/"..arenaNum..".png")
    --bg_sounds[i] = love.audio.newSource("background/sound"..i, "stream")
  --end
  
  return bg_posYm[arenaNum], bg_images
end

--[[function Arena_Base:draw(prop, extraX, extraY)
  
  love.graphics.draw(bg_images, extraX, extraY, 0, prop)
  if start then
    start = false
    bg_sounds[arenaNum]:play()
    bg_sounds[arenaNum]:setLooping(true)
  end
end]]

return Arena_Base