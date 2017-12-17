local music = {}

function music.load()
  florestaBGM = love.audio.newSource("Assets/floresta.wav", "stream")
  cavernaBGM = love.audio.newSource("Assets/Caverna.wav", "stream")
  --casteloBGM = love.audio.newSource("Assets/Castelo.wav", "stream")
  --bossBGM = love.audio.newSource("Assets/Imperatriz.wav", "stream")
  
  florestaBGM:setLooping(true)
  cavernaBGM:setLooping(true)
  --casteloBGM:setLooping(true)
  --bossBGM:setLooping(true)
  cavernaBGM:play()
end

function music.update(gamestate)
  if gamestate == "init" then
    cavernaBGM:play()
    florestaBGM:stop()
    --casteloBGM:stop()
    --bossBGM:stop()
  elseif gamestate == "mapa1" then
    cavernaBGM:stop()
    florestaBGM:play()
    --casteloBGM:stop()
    --bossBGM:stop()
  elseif gamestate == "mapa2" then      
    cavernaBGM:play()
    florestaBGM:stop()
    --casteloBGM:stop()
    --bossBGM:stop()
  end
end

return music