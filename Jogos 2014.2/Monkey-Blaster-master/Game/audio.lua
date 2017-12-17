audio={}

function audio.infoLoad()
  audio.portal = love.audio.newSource("/Source/sounds/Portal.mp3")
  audio.alert = love.audio.newSource("/Source/sounds/AlertSound.mp3")
  audio.disarm = love.audio.newSource("/Source/sounds/Disarm Sound.mp3")
  audio.menu=love.audio.newSource("The Complex.mp3")
  audio.laugh=love.audio.newSource("/Source/Doctor X/laugh.mp3")
  audio.yeeha=love.audio.newSource("/Source/Doctor X/YeeHa.mp3")
  audio.shock=love.audio.newSource("/Source/Doctor X/Shock.mp3")
  love.audio.play(audio.menu)
end


function audio.play(id)
  love.audio.stop(audio.menu)
	music = stage[id].music
	music:setLooping(true)
  music:setVolume(0.6)
	love.audio.play(music)
end