local menu = require "menu"
local pasue = require "pause"
local pista = require "pista"
local transicao = require "transicao"
 -- local hud = require "hud"

fase = {

  numCars = 0,
  tempo = 0,
  count = 0,
  timeRedu = os.time(),
  updated = false,

  { --fase1
    numCars = 4,
    tempo = 60,
    concluiu = false,
    onFase = false;
  },

  {--fase2
    numCars = 8,
    tempo = 90,
    concluiu = false,
    onFase = false;
  },
  { --fase3
    numCars = 10,
    tempo = 120,
    concluiu = false,
    onFase = false;

  },
  {--fase4
    numCars = 12,
    tempo = 150,
    concluiu = false,
    onFase = false;
  },
  {--fase5
    numCars = 15,
    tempo = 180,
    concluiu = false,
    onFase = false;
  }
};

function fase.updateStats()
  if not fase.updated then
    for i=1, 5 do
      if fase[i].onFase then
        fase.count = i
        --atualiza as variaveis da fase
        fase.numCars = fase[i].numCars
        fase.tempo = fase[i].tempo
       -- table.remove(segment.cars, #segment.cars)
        fase.updated = true
        hud.resetar = false
        pista.updateStages(pista.totalCars, fase.numCars)
	  end
    end
  end
end

function fase.Qualimg()
  local zeebo = 0
  if fase.count ~= 5 then -- se a fase n for a 5
    zeebo = fase.count + 1  -- diz o numero da proxima fase
  end
end


local tempin = 20
function fase.update(dt)
  if not menu.onMenu and not pause.onPause then
    --se for pra mostrar transicao e o n for 1
    if transicao.betweenfases and transicao.n == 1 then
      congelar_jogo = true
      tempin = tempin - 5*dt
      --print(tempin)
      if tempin <= 0 then
        transicao.betweenfases = false
        transicao.n = 2
        congelar_jogo = false
        tempin = 20
      end
    else
     
      fase.updateStats()
   
      if fase.tempo > 0 then
        fase.tempo = fase.tempo - 1.17*dt
      end

      if fase.tempo < 0 and not fase[5].onFase then
        --assim q a fase acabar, congela o jogo
        congelar_jogo = true;
        --reseta a hud
        hud.resetar = true
        --variavel de mostrar a tela de transicao fica true
        transicao.betweenfases = true;
        --roda o timer 
        tempin = tempin - 5*dt
        --se o timer chegar a 0
        if tempin <= 0 then
          --volta o timer
          tempin = 20
          --variavel de mostrar a transicao fica false
          transicao.betweenfases = false
          --numero da transicao muda pra proxima fase
          transicao.n = transicao.n + 1
          --descongela o jogo
          congelar_jogo = false
          -- updoodle na fase
          fase.updated = false
          fase[fase.count].onFase = false
          fase[fase.count+1].onFase = true
        end
      elseif fase.tempo < 0 and fase[5].onFase then
        congelar_jogo = true
        transicao.ganhou = true
      end

    end
  end
end

return fase
