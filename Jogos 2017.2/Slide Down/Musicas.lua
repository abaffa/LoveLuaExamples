local audio = {
	 musics = {}
}
local random_song, seek, gameover_song, pause_song
local N_musics = 42
local cleyton = require ("cleyton_movimentos")


function audio.load()

	for x = 1,N_musics,1 do
    	audio.musics[x] = love.audio.newSource("Assets//musicas//arquivo_musica_0".. x ..".mp3","stream")
    end
    pause_song = love.audio.newSource("Assets//musicas//Elevator_Song.mp3", "stream")
    gameover_song = love.audio.newSource("Assets//musicas//Proerd.mp3", "stream")

    audio.reload()

end

function audio.update(gameover, pause, menu)
	if not gameover	and not pause and not menu then
		if not audio.musics[seek]:isPlaying() then
			audio.reload()
		end

		love.audio.stop(gameover_song)
		love.audio.stop(pause_song)
	elseif gameover then
		love.audio.stop(random_song)
		love.audio.stop(pause_song)
		love.audio.play(gameover_song)
		gameover_song:setLooping(true)
	
	elseif menu or pause then
		love.audio.stop(random_song)
		love.audio.stop(random_song)
		love.audio.play(pause_song)
		pause_song:setLooping(true)
	end
end

function audio.reload()
	seek = love.math.random(1,N_musics)
	random_song =  audio.musics[seek]
	love.audio.play(random_song)
	--random_song:setLooping(true)

end

return audio