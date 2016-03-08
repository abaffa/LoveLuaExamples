function sound_load()
  titlescreen = love.audio.newSource("sound/titlescreen.mp3")
  music_wave = {}
  for x = 1, 4, 1 do -- Imagens redcholour
    music_wave[x] = love.audio.newSource("sound/wave_" .. x .. ".mp3")
  end
  finalwave = love.audio.newSource("sound/finalwave.mp3")
end

function sound_update(dt)
  if (gamestate ~= 2 and gamestate ~= 9) and not (titlescreen:isPlaying()) then
    titlescreen:play()
    titlescreen:setVolume(1.5)
  elseif gamestate == 2 or gamestate == 9 then
    titlescreen:stop()
  end
  if gamestate == 2 or gamestate == 9 then
    if wave >= 1 and wave <= 3 then
      music_wave[1]:play()
      music_wave[1]:setVolume(0.2)
    elseif  wave >= 5 and wave <= 7 then
      finalwave:stop()
      music_wave[2]:play()
      music_wave[2]:setVolume(0.2)
    elseif  wave == 4 then
      music_wave[1]:stop()
      finalwave:play()
      finalwave:setVolume(0.2)
    end
    if pause == true then
      music_wave[1]:pause()
      music_wave[2]:pause()
      finalwave:pause()
    end
  else
    music_wave[1]:stop()
    music_wave[2]:stop()
    finalwave:stop()
  end
end