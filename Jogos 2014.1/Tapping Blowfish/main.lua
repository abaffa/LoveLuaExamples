--[[
FEITO - Colocar uma variável que armazena o tempo para ver o tempo que demora para as 4 algas/tubarões passarem
FEITO - Padronizar o tamanho do tubarão para 150 pixels de largura(assim, o tempo de viagem do tubarão será o mesmo que o da alga)
FEITO - Colocar uma variável para calcular o dt até randomizar
FEITO - Trocar a ordem do random: Checar valor numérico e depois checar qual é o evento atual (a causa do conflito de 2 eventos ao mesmo tempo é a ordem em que acontecem as coisas)
ADAPTADO, O COMEÇO DOS EVENTOS TEM COMO BASE O VETOR [4] DO EVENTO - Colocar uma variável para controlar o começo dos eventos
FEITO, COLISÃO COM TUBARÃO SEPARADA EM 3 PARTES - Reformular sistema de colisão com tubarão(já que o tubarão foi reformulado)
ADAPTADO PARA 1.5s / AUMENTADO PARA 4s APÓS ALTERAÇÕES E TESTES - Correnteza irá entrar em efeito em torno de 3s após o aviso
FEITO - Aviso da correnteza através de uma imagem de placa(PERIGO: CORRENTEZA)
FEITO - Colocar música
FEITO - Arrumar topo
PARCIALMENTE FEITO - Fazer menu
FEITO - Verificar funcionamento da correnteza
ADIADO - Fazer um movimento angular para o peixe
ADIADO - Menu de missões
FEITO - Espaço para mudança da correnteza ( um tempo sem vir eventos para o jogador se acostumar com a mudança )
FEITO - Sortear o evento da correnteza a cada 2(?) sorteios de evento
FEITO - Sistema de pontuação baseado na passagem por obstáculos
FEITO - Sistema de inchaço do peixe
FEITO - Controlar variáveis do inchaço do peixe
FEITO - Mudar a localização do aviso da correnteza
- Mudar a hitbox do peixe para um círculo com centro no centro do peixe e raio metade da largura da imagem
- Arrumar inchaço
- Arrumar sistema de exibir pontuação
- Adicionar botão de pause para ser utilizado no celular
- Adicionar método de aumentar/diminuir volume no celular

TO DO LIST:
Primeira Parte:
- Fundo do mar: mudar imagem
FEITO(?) - Animação parabólica para subida do peixe
FEITO - Melhorar resposta ao comando
ADAPTADO, ÁREAS DE COLISÃO MELHORADAS - Arrumar pontas de imagens(transparentes)
FEITO - Implementar correnteza
FEITO - Arrumar funcionamento do tubarão
PARCIALMENTE FEITO - Botar as imagens em um tamanho padrão(que a gente saiba as dimensões)
- Mudança de skylines baseada na distância
 - Sempre a mesma cidade com o mesmo chefão
ADIADO(?) - Produzir chefões(água viva gigante[Austrália], mergulhador[], polvo[])
 - Formular mecânica dos chefões
 - Mecânicas de tentáculos
  - Um deles ficará no topo da tela, com os tentáculos caindo aleatoriamente e o peixe se move para os lados
  - O outro virá pelo lado da tela e o movimento do peixe continua normal
 - Distância entre os chefões gradualmente aumentando(ex. 50, 150, 300...)
 - Geiser: solta água para cima
 - Uma baleia sugando água e o peixe deve resistir à "correnteza" causada
 - A dificuldade dos bosses aumenta a cada vez que o jogador os confronta, causando com que aumente sua velocidade ou alteração no peixe
FEITO - Arrumar distância das algas quando resetadas
- Formular distância
- Formular pontuação
ARRUMADO - Perder para o tubarão buga o jogo
FEITO - Criar uma aleatoriedade para a aparição dos inimigos
ADIADO(?) - Caverna
 - O formato da caverna define o caminho do peixe
ADIADO(?) - Inchaço do peixe
 - Ideias: aleatoriedade, batida, distância específica

Segunda Parte:
- Menus
]]--

res = require 'res'
require 'TEsound'

local colisao = true
local game = { -- Variáveis do jogo
  score = 0, -- Pontuação do jogador.
  score_total = "You scored " .. tostring(score) .. " points.", -- Mensagem com a pontuação do jogador ao perder o jogo.
  pontuacao_icone = love.graphics.newImage("pontuacao.png"), -- Ícone de peixinho ao lado da pontuação.
  dist = 0, -- Distância percorrida pelo jogador.
  dist_total = "You reached " .. tostring(dist) .. "meters.", -- Mensagem com a distância percorrida do jogador ao perder o jogo.
  started = false, -- O jogador deu "START" no jogo?
  lost = false, -- O jogador perdeu o jogo?
  retry = love.graphics.newImage("botao1.png"), -- Botão de jogar novamente.
  botao_central_px = 0, -- Coordenada X de um botão centralizado na tela. Calculado em love.load.
  botao_central_py = 0, -- Coordenada Y de um botão centralizado na tela. Calculado em love.load.
  jogar = love.graphics.newImage("botao1.png"), -- Imagem do botão jogar.
  botao_jogar_py = 0, -- Coordenada Y do botão jogar. Calculado em love.load
  paused = true, -- O jogo está pausado?
  pause = love.graphics.newImage("pause.png"), -- Imagem de pause.
  unpause = love.graphics.newImage("botao1.png"), -- Imagem do botão "Resume".
  unpause_px = 0, -- Posição X do botão "Resume".
  unpause_py = 0, -- Posição Y do botão "Resume".
  inicializado = true, -- O jogo foi reinicializado, caso o jogador tenha perdido?
  alga = 0, -- Imagem da alga.
  y_alga = {}, -- Vetor com as coordenadas Y das algas.
  onda = 0, -- Imagem da onda.
  cidade_atual = 1, -- Cidade na qual o jogador está. 
  correnteza = false, -- A correnteza será ativada?
  correnteza_timer = 0,  -- Contagem de tempo para a correnteza ser ativada.
  correnteza_ativa = false, -- A correnteza está ativa?
  correnteza_space = {875, 1125, 1375}, -- O "evento" de ativar a correnteza.
  correnteza_placa = false, -- A placa da correnteza deverá aparecer?
  correnteza_placa_img = love.graphics.newImage("correnteza.png"), -- Imagem da placa da correnteza.
  correnteza_placa_py = 0, -- Coordenada Y da placa da correnteza.
  background_move = 0, -- Movimentação do fundo do jogo.
  multiplier = 1, -- Multiplicador da pontuação do jogador.
  fonte = love.graphics.newFont("antique_book_cover.otf", 35), -- Fonte do jogo.
  fonte_game_over = love.graphics.newFont("Kraash Black.ttf", 35), -- Fonte do "Game Over" e mensagens ao chegar em certas pontuações.
  logo = love.graphics.newImage("logo3.png"), -- Imagem do logo "The Tap BlowFish".
  audio_subida = love.sound.newSoundData("som subida.mp3"), -- Efeito sonoro da subida do peixe.
  audio_soundtrack = love.audio.newSource("ost.mp3"), -- Música do jogo.
  jogador = "", -- Nome do jogador.
  over_msg_py = 0, -- Coordenada Y da escrita de "Game Over". Calculado em love.load.
  som_ativo = true, -- Os sons estão ativos?
  som_imagem = love.graphics.newImage("speaker.png"), -- Imagem do speaker(quando o som está ativado).
  som_desativado_imagem = love.graphics.newImage("speaker2.png"), -- Imagem do speaker(quando o som está desativado).
  audio_pontuacao = love.sound.newSoundData("coin effect.mp3"), -- Efeito sonoro de passar por um obstáculo.
}

local highscore = {} -- Tabela com as maiores pontuações.
local totalscore = 1 -- Quantidade de pontuações a serem adicionadas

local misc = { -- Variáveis gerais.
  velo = 0 -- Velocidade de queda do peixe.
}
local alga = { -- Variáveis da alga.
  imagem = 0, -- Imagem da alga.
  px = {875, 1125, 1375, 1625}, -- Vetor com as coordenadas X das algas.
  py = {}, -- Vetor com as coordenadas Y das algas.
  desenhar = {true, true, true, false}, -- Desenhar a alga.
  }
local tempo = { -- Variáveis de tempo
  delay_jump = 0, -- Tempo entre um pulo e outro do peixe.
  delay_tubarao_random = 0, -- Tempo até gerar outro número aleatório para decidir se aparecerá o tubarão.
  delay_score = 0, -- Tempo até aumentar a pontuação.
  delay_dist = 0, -- Tempo até aumentar a distância percorrida.
  delay_restart = 0, -- Tempo até o jogador poder reiniciar o jogo através da barra de espaço(para evitar de não ver a pontuação)
}
local fundo = { -- Variáveis relacionadas ao fundo
  topo = {}, -- Imagem do topo. Carregada em love.load.
  topo_altura = 0, -- Altura da imagem do topo. Calculada em love.load.
  game = 0 -- Imagem de fundo do jogo. Carregada em love.load.
}
local tubarao = { -- Variáveis relacionadas ao tubarão
  img = 0, -- Imagem do tubarão. Carregada em love.load.
  desenhar = {false, false, false, false}, -- Tubarão será desenhado?
  px = {875, 1125, 1375, 1625}, -- Posição X inicial do tubarão.
  py = {0, 0, 0, 0}, -- Posição Y do tubarão(gerada aleatoriamente quando o tubarão aparecer).
  maxpy = 0, -- Máximo da posição Y do tubarão(impossibilita ele aparecer fora da tela). Calculada em love.load.
  largura = 0, -- Largura do tubarão. Calculada em love.load.
  altura = 0, -- Altura do tubarão. Calculada em love.load.
  py_min = 0, -- Coordenada Y mínima que o tubarão pode chegar.
  sentido_baixo = {false, false, false, false}, -- O tubarão está subindo ou descendo?
  }
local peixe = { -- Variáveis relacionadas ao peixe
  anim = {}, -- Frames de animação do peixe.
  frame = 1, -- Frame da animação a ser desenhado. Inicialmente 1, caso subindo, 2.
  px = 100, -- Posição X do peixe.
  py = 300, -- Posição Y inicial do peixe.
  destino = 0, -- A posição Y para a qual o peixe irá subir quando o jogador der o comando.
  subindo = false, -- O jogador deu o comando para subir?
  subiu = false, -- O peixe fez a ação de subir?
  altura = 0, -- Altura do peixe. Calculada em love.load.
  rotacao = math.rad(0), -- Variável para rotação do peixe(atualmente não em uso).
  escala = 0.25, -- Escala do desenho do peixe. Possibilita o sistema de inchaço.
  inchar = false, -- O peixe deve inchar no momento?
  inchado = false, -- O peixe está inchado?
}
local evento = {
  atual = 0, -- Qual é o evento atual? 1 = alga, 2 = tubarão, 3 = correnteza entrando
  proximo = 0, -- Qual é o próximo evento?
  passado = 0, -- Qual foi o evento passado?
  sorteio = 0, -- Variável para sorteio do evento.
  storage = 0, -- Variável contendo o valor do sorteio anterior.
  start = false, -- O evento sorteado deve começar?
  primeiro = true, -- O evento que vai começar será o primeiro?
  repeticao = 0, -- Quantas vezes os eventos já foram sorteados?
  correnteza = 0, -- Variável para sorteio da correnteza.
  correnteza_storage = 0, -- Variável contendo o valor do sorteio anterior.
  correnteza_delay = 0, -- Variável que possibilita o controle do sorteio da correnteza ser a cada dois sorteios de evento.
  inchaco = 0, -- Variável para o sorteio do inchaço.
  inchaco_storage = 0, -- Variável contendo o valor do sorteio anterior.
}
local voice = { -- Variáveis relacionadas às mensagens de pontuação.
  random = 0, -- O sorteio da mensagem a ser exibida.
  storage = 0, -- O sorteio da mensagem anterior.
  desenhar = {false, false, false, false, false, false}, -- A mensagem [x] deve ser desenhada?
  timer = {0, 0, 0, 0, 0, 0}, -- Há quanto tempo a mensagem está na tela?
  som = love.sound.newSoundData("mensagem.mp3"), -- Som de aplausos para quando a mensagem aparece.
  mensagem = {"Awesome", "Unstoppable", "Well played", "Well done", "Nice job", "Good job"}, -- As mensagens que podem aparecer.
  sorteou = false, -- A mensagem foi sorteada?
  fonte = love.graphics.newFont("Kraash Black.ttf", 20), -- A fonte da mensagem que vai aparecer.
  }

function restart_game(dt) -- Função que reinicia os valores do jogo para caso o jogador tenha perdido.
  peixe.px = 100
  peixe.py = 300
  peixe.escala = 0.25
  peixe.inchar = false
  peixe.inchado = false
  misc.velo = 0
  game.score = 0
  game.dist = 0
  game.multiplier = 1
  alga.px = {config.tela_tamanho_x + 75, config.tela_tamanho_x + 325, config.tela_tamanho_x + 575, config.tela_tamanho_x + 825}
  peixe.subindo = false
  peixe.subiu = false
  tempo.delay_jump = 0
  tempo.delay_score = 0
  tempo.delay_dist = 0
  for x = 1, 4, 1 do
    alga.py[x] = love.math.random(-50, 250)
    tubarao.py[x] = love.math.random(fundo.topo_altura + 43, tubarao.maxpy)
  end
  alga.desenhar = {false, false, false, false}
  tubarao.inscreen = false
  tubarao.desenhar = {false, false, false, false}
  tubarao.spawned = false
  tubarao.px = {config.tela_tamanho_x + 75, config.tela_tamanho_x + 325, config.tela_tamanho_x + 575, config.tela_tamanho_x + 825}
  evento.sorteio = love.math.random(1, 100)
  game.correnteza = false
  game.correnteza_timer = 0
  game.correnteza_ativa = false
  game.correnteza_placa = false
  evento.atual = 0
  evento.proximo = 0
  evento.passado = 0
  evento.storage = 0
  evento.correnteza = 0
  evento.correnteza_storage = 0
  evento.repeticao = 0
  evento.primeiro = true
  evento.correnteza_delay = 0
  evento.inchaco = 0
  evento.inchaco_storage = 0
  game.lost = false
  game.background_move = 0
end
--[[
function loadscore()
  local file = io.open("highscore.dat", "r")
	for line in file:lines() do
		local i = line:find(' ', 1, true)
		highscore[totalscore] = {name = line:sub(1, i-1), score = tonumber(line:sub(i+1))}
    totalscore = totalscore + 1
	end
	file:close()
end

function savescore()
  local file = io.open("highscore.dat", "w")
	for i = 1, totalscore - 1 do		
		file:write(highscore[i].name .. " " .. highscore[i].score .. "\n")
	end
	file:close()
end

function sortScore(a, b)
	return a.score > b.score
end

function addscore(n, v)
  highscore[totalscore] = {name = n, score = v}
  totalscore = totalscore + 1
  table.sort(highscore, sortScore)
end
]]--
function perde_jogo(score, dist)
  game.paused = true
  game.inicializado = false
  game.score_total = "You scored " .. tostring(score) .. " points."
  game.dist_total = "You reached " .. tostring(dist) .. " meters."
  game.lost = true
  --addscore(game.jogador, score)
end

function love.load()

  love.window.setMode(800, 600, {resizable=true}) 
  
  gameWidth = 800
  gameHeight = 600
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()
  res.set("fit",gameWidth,gameHeight,screenWidth,screenHeight)
  
  
  config = {
    tela_tamanho_x = gameWidth,
    tela_tamanho_y = gameHeight,
  }
  
  -- Carregar frames do peixe e calcular sua altura.
  peixe.anim[1] = love.graphics.newImage("baiacu.png")
  peixe.altura = peixe.anim[1]:getHeight() * peixe.escala
  -- Carregar imagens de fundo e calcular altura do topo.
  fundo.topo[1] = love.graphics.newImage("paristopo.png")
  --fundo.topo[2] = love.graphics.newImage("skyline rio resized.png")
  fundo.game = love.graphics.newImage("background.png")
  fundo.topo_altura = fundo.topo[1]:getHeight() * 0.6
  -- Carregar e calcular coisas relacionadas ao tubarão.
  tubarao.img = love.graphics.newImage("tubarao.png")
  tubarao.altura = tubarao.img:getHeight()
  tubarao.largura = tubarao.img:getWidth()
  tubarao.py_min = fundo.topo_altura + 43
  tubarao.maxpy = fundo.topo_altura + 143
  -- Carregar pause.
  game.unpause_px = (config.tela_tamanho_x/2) - (game.unpause:getWidth()/2)
  game.unpause_py = (config.tela_tamanho_y/2) - (game.unpause:getHeight()/2)
  alga.imagem = love.graphics.newImage("alga.png")
  game.onda = love.graphics.newImage("onda3.png")
  game.botao_central_px = (config.tela_tamanho_x/2) - (game.retry:getWidth()/2)
  game.botao_central_py = (config.tela_tamanho_y/2) - (game.retry:getHeight()/2)
  game.correnteza_placa_py = ((config.tela_tamanho_y - fundo.topo_altura) / 2) - 50 + fundo.topo_altura
  game.botao_jogar_py = game.logo:getHeight() + 40
  game.over_msg_py = game.botao_central_py - game.fonte:getHeight(game.dist_total) - game.fonte:getHeight(game.score_total) - game.fonte:getHeight("Fim de Jogo.")
  love.graphics.setBackgroundColor(40, 134, 241)
  for x = 1, 4, 1 do
    alga.py[x] = love.math.random(-50, 250)
  end
  evento.sorteio = love.math.random(1, 100)
  love.window.setTitle("The Tap BlowFish")
  love.graphics.setFont(game.fonte)
  love.audio.setVolume(0.1)
  love.audio.play(game.audio_soundtrack)
  --loadscore()
end

function love.resize(w, h)
  screenWidth = w
  screenHeight = h
  res.set("fit",gameWidth,gameHeight,screenWidth,screenHeight)
end

function love.update(dt)
  TEsound.cleanup()
  if game.paused == false then
  teste = 150 * dt
  -- Aqui começa o funcionamento do jogo.
  
  game.background_move = game.background_move + (150 * dt)
  -- Reinicia o jogo caso o jogador tenha perdido.
  if game.inicializado == false then
    restart_game(dt)
    game.inicializado = true
  end
  
  -- Aumenta a distância percorrida pelo jogador.
  tempo.delay_dist = tempo.delay_dist + (150 * dt)
  game.dist = math.floor(tempo.delay_dist/100) * 10
  
  -- Aumenta a pontuação do jogador.
  for x = 1, 4, 1 do
    if alga.px[x] >= peixe.px - (75 * dt) and alga.px[x] < peixe.px + (75 * dt) then
      game.score = game.score + (1 * game.multiplier)
      if game.som_ativo == true then
        TEsound.play(game.audio_pontuacao, "efeitos", 1, 1)
      end
    elseif tubarao.px[x] >= peixe.px - (75 * dt) and tubarao.px[x] < peixe.px + (75 * dt) then
      game.score = game.score + (1 * game.multiplier)
      if game.som_ativo == true then
        TEsound.play(game.audio_pontuacao, "efeitos", 1, 1)
      end
    end
  end
  if game.score % 35 == 0 and game.score ~= 0 and voice.sorteou == false then
    voice.random = love.math.random(1, 6)
    voice.sorteou = true
  end
  if voice.random ~= voice.storage then
    voice.storage = voice.random
    if game.som_ativo == true then
      TEsound.play(voice.som, "comemorações", 1, 1)
    end
    voice.desenhar[voice.storage] = true
  end
  if voice.desenhar[voice.storage] == true then
    voice.timer[voice.storage] = voice.timer[voice.storage] + dt
    if voice.timer[voice.storage] >= 2 then
      voice.desenhar[voice.storage] = false
      voice.timer[voice.storage] = 0
      voice.sorteou = false
    end
  end
  
  -- Sistema de sorteio de eventos
  if alga.px[4] <= config.tela_tamanho_x - 175 and alga.px[4] > config.tela_tamanho_x - 175 - (150 * dt) then
    evento.sorteio = love.math.random(1, 100)
    evento.repeticao = evento.repeticao + 1
    if evento.repeticao > 4 then
      evento.correnteza_delay = evento.correnteza_delay + 1
      if evento.correnteza_delay > 2 then
        evento.correnteza = love.math.random(1, 100)
        evento.correnteza_delay = 0
      end
    end
    if evento.repeticao > 3 then
      evento.inchaco = love.math.random(1, 100)
    end
  elseif tubarao.px[4] <= config.tela_tamanho_x - 175 and tubarao.px[4] > config.tela_tamanho_x - 175 - (150 * dt) then
    evento.sorteio = love.math.random(1, 100)
    evento.repeticao = evento.repeticao + 1
    if evento.repeticao > 4 then
      evento.correnteza_delay = evento.correnteza_delay + 1
      if evento.correnteza_delay > 2 then
        evento.correnteza = love.math.random(1, 100)
        evento.correnteza_delay = 0
      end
    end
    if evento.repeticao > 3 then
      evento.inchaco = love.math.random(1, 100)
    end
  elseif game.correnteza_space[3] <= config.tela_tamanho_x - 175 and game.correnteza_space[3] > config.tela_tamanho_x - 175 - (150 * dt) then
    evento.sorteio = love.math.random(1, 100)
  end
  if evento.correnteza ~= evento.correnteza_storage then
    evento.correnteza_storage = evento.correnteza
    if evento.correnteza >= 1 and evento.correnteza <= 50 and game.correnteza ~= true then
      game.correnteza = true
    elseif evento.correnteza > 50 and evento.correnteza <= 100 and game.correnteza ~= false then
      game.correnteza = false
    end
  end
  if evento.sorteio ~= evento.storage then
    evento.passado = evento.atual
    evento.atual = evento.proximo
    evento.storage = evento.sorteio
    if (game.correnteza == true and game.correnteza_ativa ~= true) or (game.correnteza == false and game.correnteza_ativa ~= false) then
      evento.proximo = 3
      evento.start = true
      game.correnteza_placa = true
    elseif evento.sorteio >= 1 and evento.sorteio <= 50 then
      evento.proximo = 1
      evento.start = true
    elseif evento.sorteio > 50 and evento.sorteio <= 100 then
      evento.proximo = 2
      evento.start = true
    end
  end
  
  if game.correnteza == true and game.correnteza_ativa ~= true then
    game.correnteza_timer = game.correnteza_timer + dt
    if game.correnteza_timer >= 4 then
      game.correnteza_ativa = true
      game.correnteza_timer = 0
      misc.velo = 0
    end
  elseif game.correnteza == false and game.correnteza_ativa ~= false then
    game.correnteza_timer = game.correnteza_timer + dt
    if game.correnteza_timer >= 4 then
      game.correnteza_ativa = false
      game.correnteza_timer = 0
      misc.velo = 0
    end
  end
  
  if evento.inchaco ~= evento.inchaco_storage then
    if evento.inchaco >= 1 and evento.inchaco <= 30 and peixe.inchado == false then
      peixe.inchar = true
    elseif evento.inchaco > 30 and evento.inchaco <= 100 and peixe.inchado == true then
      peixe.inchar = false
    end
  end
  if peixe.inchar == true and peixe.inchado == false then
    peixe.escala = peixe.escala + (dt / 10)
    if peixe.escala > 0.3 then
      peixe.escala = 0.3
      peixe.inchado = true
    end
  elseif peixe.inchar == false and peixe.inchado == true then
    peixe.escala = peixe.escala - (dt / 10)
    if peixe.escala < 0.25 then
      peixe.escala = 0.25
      peixe.inchado = false
    end
  end
  
  -- Evento das algas
  if evento.proximo == 1 and evento.atual ~= 1 and evento.start == true then
    if evento.primeiro == true then
      alga.px = {config.tela_tamanho_x + 75, config.tela_tamanho_x + 325, config.tela_tamanho_x + 575, config.tela_tamanho_x + 825}
      evento.primeiro = false
    elseif evento.atual == 3 then
      alga.px = {game.correnteza_space[3] + 250, game.correnteza_space[3] + 500, game.correnteza_space[3] + 750, game.correnteza_space[3] + 1000}
    else alga.px = {tubarao.px[4] + 250, tubarao.px[4] + 500, tubarao.px[4] + 750, tubarao.px[4] + 1000}
    end
    evento.start = false
    for x = 1, 4, 1 do
      alga.py[x] = love.math.random(-50, 250)
    end
  end
  if evento.atual == 1 or evento.proximo == 1 or evento.passado == 1 then
    for x = 1, 4, 1 do -- X irá variar de 1 a 5, incrementando 1 a cada loop.
      alga.px[x] = alga.px[x] - (150 * dt) -- A alga X irá ter sua posição X diminuída para andar para a esquerda.
      if alga.px[x] < -150 and evento.proximo == 1 then -- Se a alga X passar da tela e o evento for se repetir...
        alga.px[x] = config.tela_tamanho_x + 75 -- ... voltará ao canto direito da tela...
        alga.py[x] = love.math.random(-50, 250) -- .. e sorteará uma nova altura para a alga.
      end
    end
  end
  
  -- Evento dos tubarões
  if evento.atual ~= 2 and evento.proximo == 2 and evento.start == true then
    if evento.primeiro == true then
      tubarao.px = {config.tela_tamanho_x + 75, config.tela_tamanho_x + 325, config.tela_tamanho_x + 575, config.tela_tamanho_x + 825}
      evento.primeiro = false
    elseif evento.atual == 3 then
      tubarao.px = {game.correnteza_space[3] + 250, game.correnteza_space[3] + 500, game.correnteza_space[3] + 750, game.correnteza_space[3] + 1000}
    else tubarao.px = {alga.px[4] + 250, alga.px[4] + 500, alga.px[4] + 750, alga.px[4] + 1000}
    end
    evento.start = false
    for x = 1, 4, 1 do
      tubarao.py[x] = love.math.random(fundo.topo_altura + 43, tubarao.maxpy)
    end
  end
  if evento.proximo == 2 or evento.atual == 2 or evento.passado == 2 then
    for x = 1, 4, 1 do
      tubarao.px[x] = tubarao.px[x] - (150 * dt)
      if tubarao.sentido_baixo[x] == false then
        tubarao.py[x] = tubarao.py[x] - (30 * dt)
      elseif tubarao.sentido_baixo[x] == true then
        tubarao.py[x] = tubarao.py[x] + (30 * dt)
      end
      if tubarao.py[x] >= tubarao.maxpy then
        tubarao.sentido_baixo[x] = false
      elseif tubarao.py[x] <= tubarao.py_min then
        tubarao.sentido_baixo[x] = true
      end
      if tubarao.px[x] < -150 and evento.proximo == 2 then
        tubarao.px[x] = config.tela_tamanho_x + 75
        tubarao.py[x] = love.math.random(fundo.topo_altura + 43, tubarao.maxpy)
      end
    end
  end
  
  -- Evento de pausa para correnteza
  if evento.atual ~= 3 and evento.proximo == 3 and evento.start == true then
    game.correnteza_space = {config.tela_tamanho_x + 75, config.tela_tamanho_x + 325, config.tela_tamanho_x + 575}
    evento.start = false
  end
  if evento.proximo == 3 or evento.atual == 3 or evento.passado == 3 then
    for x = 1, 3, 1 do
      game.correnteza_space[x] = game.correnteza_space[x] - (150 * dt)
    end
  end
  
  -- Determinação se deve desenhar os obstáculos ou não
  for x = 1, 4, 1 do
    if (alga.px[x] < -75 or alga.px[x] >= config.tela_tamanho_x + 75) and alga.desenhar[x] == true then
      alga.desenhar[x] = false
    elseif alga.px[x] > -75 and alga.px[x] < config.tela_tamanho_x + 75 and alga.desenhar[x] == false then
      alga.desenhar[x] = true
    end
    if (tubarao.px[x] < -75 or tubarao.px[x] >= config.tela_tamanho_x + 75) and tubarao.desenhar[x] == true then
      tubarao.desenhar[x] = false
    elseif tubarao.px[x] > -75 and tubarao.px[x] < config.tela_tamanho_x + 75 and tubarao.desenhar[x] == false then
      tubarao.desenhar[x] = true
    end
  end
  
  -- Checagem de comando do jogador.
  if peixe.subiu == true then -- Checa se o peixe subiu.
    peixe.subindo = false -- Informa que o peixe não está subindo.
    peixe.subiu = false -- Informa que o peixe não subiu no ciclo atual.
  end
    
  -- Mecânicas de subida do peixe.
  if peixe.subindo == true and peixe.subiu == false and tempo.delay_jump < 0.3 then -- Checa se o peixe está subindo, se ele já subiu e há quanto tempo ele está subindo.
    --misc.velo = 0 -- Reseta a gravidade.
    tempo.delay_jump = tempo.delay_jump + dt -- Armazena há quanto tempo o peixe está subindo.
    if game.correnteza_ativa == false then
      peixe.py = peixe.py - (220 * dt) -- Diminui a posição Y do peixe para ele subir.
    elseif game.correnteza_ativa == true and peixe.py + peixe.altura + (220 * dt) <= config.tela_tamanho_y then
      peixe.py = peixe.py + (220 * dt)
    end
  end
  if tempo.delay_jump >= 0.3 then -- Checa se o peixe já subiu por tempo suficiente.
    peixe.subiu = true -- Informa que o peixe já subiu.
    tempo.delay_jump = 0 -- Reseta o tempo de subida do peixe.
  end
  
  -- Cálculos do peixe caindo.
  if peixe.subindo == false then -- Checa se o peixe está subindo. Se o peixe não estiver subindo, ele será puxado para baixo.
    --misc.velo = misc.velo + (20 * dt) -- Incremento da aceleração.
    if peixe.py <= config.tela_tamanho_y - peixe.altura then -- Checa se o peixe já saiu da tela.
      if game.correnteza_ativa == false then
        peixe.py = peixe.py + 220*dt -- Aumento da posição Y do peixe, baseado na velocidade com aceleração.
      elseif game.correnteza_ativa == true then
        peixe.py = peixe.py - 220*dt
      end
    end
    if peixe.py > config.tela_tamanho_y - peixe.altura then -- Checa se o peixe passou do limite da posição Y.
      peixe.py = config.tela_tamanho_y - peixe.altura -- Se o peixe passar da tela, volta para o limite.
    end
  end
  
  -- Checagem da posição do peixe para não subir demais.
  if peixe.py < fundo.topo_altura then -- Se o peixe chegar à imagem do topo, sua posição será limitada ao fim desta.
    peixe.py = fundo.topo_altura
  end
  
  -- Sistema de reiniciar o jogo caso o jogador perca.
  
  if colisao == true then
  if peixe.py == config.tela_tamanho_y - peixe.altura then
    perde_jogo(game.score, game.dist)
  end
  for x = 1, 4, 1 do
    if alga.desenhar[x] == true then
    if alga.px[x] - 50 <= 100 + peixe.anim[1]:getWidth() * peixe.escala and alga.px[x] + 50 > 100 then
    if peixe.py <= alga.py[x] + 185 or peixe.py + peixe.altura >= alga.py[x] + 365 then
      perde_jogo(game.score, game.dist)
    end
    end
    end
    
    -- Colisão tubarão por partes(experimental)
    if tubarao.desenhar[x] == true then
    -- Parte 1: Cabeça
    if peixe.anim[1]:getWidth() * peixe.escala + 100 >= tubarao.px[x] - 70 and tubarao.px[x] - 19 > 100 then
    if (peixe.py + peixe.altura >= tubarao.py[x] - 20 and peixe.py <= tubarao.py[x] + 20) or (peixe.py + peixe.altura >= tubarao.py[x] + 216 and peixe.py <= tubarao.py[x] + 256) then
      perde_jogo(game.score, game.dist)
    end
    end
    -- Parte 2: Barbatanas
    if peixe.anim[1]:getWidth() * peixe.escala + 100 >= tubarao.px[x] - 19 and tubarao.px[x] - 7 > 100 then
    if (peixe.py + peixe.altura >= tubarao.py[x] - 43 and peixe.py <= tubarao.py[x] + 43) or (peixe.py + peixe.altura >= tubarao.py[x] + 193 and peixe.py <= tubarao.py[x] + 293) then
      perde_jogo(game.score, game.dist)
    end
    end
    -- Parte 3: Rabo
    if peixe.anim[1]:getWidth() * peixe.escala + 100 >= tubarao.px[x] + 7 and tubarao.px[x] + 75 > 100 then
    if (peixe.py + peixe.altura >= tubarao.py[x] - 20 and peixe.py <= tubarao.py[x] + 20) or (peixe.py + peixe.altura >= tubarao.py[x] + 216 and peixe.py <= tubarao.py[x] + 256) then
      perde_jogo(game.score, game.dist)
    end
    end
    end
  end
  end
  
  --Aqui termina o funcionamento do jogo.
  
  end
  if game.lost == true and tempo.delay_restart < 2 then
    tempo.delay_restart = tempo.delay_restart + dt
  end
end

function love.keypressed(key)
  if key == "f1" and love.keyboard.isDown("f12") then
    voice.random = love.math.random(1, 6)
  elseif key == "space" then
    if game.paused == false then
      peixe.subindo = true -- Informa que o peixe deve subir.
      tempo.delay_jump = 0
      if game.som_ativo == true then
        TEsound.play(game.audio_subida, "efeitos", 0.5, 1)
      end
    elseif game.paused == true and game.started == true and game.lost == false then
      game.paused = false
    elseif game.paused == true and game.started == false and game.lost == false then
      game.paused = false
      game.started = true
    elseif game.paused == true and game.started == true and game.lost == true and tempo.delay_restart > 1 then
      game.paused = false
    end
  elseif key == "f2" and love.keyboard.isDown("f12") then
    if colisao == true then
      colisao = false
    else colisao = true
    end
  elseif key == "f3" and love.keyboard.isDown("f12") then
    love.audio.pause(game.audio_soundtrack)
  elseif key == "return" then
    if game.paused == true and game.started == true then
      game.paused = false
    elseif game.paused == false and game.started == true then 
      game.paused = true
    elseif game.paused == true and game.started == false then
      game.paused = false
      game.started = true
    end
  end
end

function love.mousepressed(x, y, button)
  if button == "l" then
    local mx,my = res.gamePosition(love.mouse.getPosition())
    if game.paused == false then
      peixe.subindo = true
      tempo.delay_jump = 0
      if game.som_ativo == true then
        TEsound.play(game.audio_subida, "efeitos", 0.5, 1)
      end
    elseif game.paused == true and game.started == true and game.lost == false and mx >= game.botao_central_px and mx <= (game.botao_central_px + game.jogar:getWidth()) and my >= game.botao_central_py and my <= (game.botao_central_py + game.jogar:getHeight()) then
      game.paused = false
    elseif game.paused == true and game.started == false and game.lost == false and mx >= game.botao_central_px and mx <= (game.botao_central_px + game.jogar:getWidth()) and my >= game.botao_jogar_py and my <= (game.botao_jogar_py + game.jogar:getHeight()) then
      game.started = true
      game.paused = false
    elseif game.paused == true and game.started == true and game.lost == true and mx >= game.botao_central_px and mx <= game.botao_central_px + game.retry:getWidth() and my >= config.tela_tamanho_y - game.retry:getHeight() * 2 and my <= config.tela_tamanho_y - game.retry:getHeight() then
      game.paused = false
    elseif game.paused == true and mx >= config.tela_tamanho_x - game.som_imagem:getWidth() - 3 and mx <= config.tela_tamanho_x and my >= 0 and my <= game.som_imagem:getHeight() then
      if game.som_ativo == true then
        game.som_ativo = false
        love.audio.stop(game.audio_soundtrack)
      elseif game.som_ativo == false then
        game.som_ativo = true
        love.audio.play(game.audio_soundtrack)
      end
    end
  end
end

function love.quit()
  --savescore()
end

function love.draw()
	res.render(draw)
end

function draw()
  if game.started == true then
  -- Desenho fundo do mar
  love.graphics.setColor (255, 255, 255)
  love.graphics.draw(fundo.game, -game.background_move, 0)
  love.graphics.draw(fundo.game, -game.background_move + 858, 0)
  if game.background_move > 858 then
    game.background_move = 0
  end
  
  -- Desenho das algas
  for x = 1, 4, 1 do
    if alga.desenhar[x] == true then
      love.graphics.draw(alga.imagem, alga.px[x], alga.py[x] + 550, 0, 1, 1, 75, 200) -- alga de baixo
      love.graphics.draw(alga.imagem, alga.px[x], alga.py[x], math.rad(180), 1, 1, 75, 200) -- alga de cima
    end
  end
  
  -- Desenho do topo
  love.graphics.draw(fundo.topo[game.cidade_atual], 0, 0, 0, 1.1, 0.6)
  if game.correnteza_space[2] < config.tela_tamanho_x and game.correnteza_space[2] > -game.correnteza_placa_img:getWidth() then
    love.graphics.draw(game.correnteza_placa_img, game.correnteza_space[2], game.correnteza_placa_py)
  end
  love.graphics.print("" .. game.dist .. " m", 3, 5)
  love.graphics.print("" .. tostring(game.score) .. "", 3, 40)
  love.graphics.draw(game.pontuacao_icone, 7 + game.fonte:getWidth(tostring(game.score)), 48, 0, 0.7, 0.7)
  --love.graphics.print("Evento atual: " .. evento.atual .. ", Evento próximo: " .. evento.proximo .. ", Evento sorteio: " .. evento.sorteio .. ", Teste: " .. teste .. "", 200, 0)
  love.graphics.setColor(255, 255, 255)
  
  -- Desenho da onda
  love.graphics.draw(game.onda, -game.background_move, fundo.topo_altura - 25)
  love.graphics.draw(game.onda, -game.background_move + 858, fundo.topo_altura - 25)
  
  -- Desenho do tubarão
  for x = 1, 4, 1 do
    if tubarao.desenhar[x] == true then
      love.graphics.draw(tubarao.img, tubarao.px[x], tubarao.py[x], 0, 1, 1, 75, 43)
      love.graphics.draw(tubarao.img, tubarao.px[x], tubarao.py[x] + tubarao.img:getHeight() + 150, 0, 1, 1, 75, 43)
    end
  end
  
  -- Desenho do peixe
  love.graphics.draw(peixe.anim[peixe.frame], peixe.px, peixe.py, peixe.rotacao, peixe.escala, peixe.escala)
  
  -- Desenho das mensagens de motivação
  if voice.desenhar[voice.storage] == true then
    love.graphics.setFont(voice.fonte)
    love.graphics.print("" .. voice.mensagem[voice.storage] .. "!", (config.tela_tamanho_x/2), game.fonte:getHeight(voice.mensagem[voice.storage]))
    love.graphics.setFont(game.fonte)
  end
  end
  
  -- Pause Game
  if game.paused == true then
    if game.started == true and game.lost == false then
      love.graphics.draw(game.pause, 0, 0)
      if game.som_ativo == true then
        love.graphics.draw(game.som_imagem, config.tela_tamanho_x - game.som_imagem:getWidth() - 3, 0)
      else love.graphics.draw(game.som_desativado_imagem, config.tela_tamanho_x - game.som_imagem:getWidth() - 3, 0)
      end
      love.graphics.draw(game.unpause, game.unpause_px, game.unpause_py)
    elseif game.started == false and game.lost == false then
      love.graphics.draw(fundo.game, -game.background_move, 0)
      love.graphics.draw(fundo.game, -game.background_move + 858, 0)
      love.graphics.draw(fundo.topo[game.cidade_atual], 0, 0, 0, 1.1, 0.6)
      love.graphics.draw(game.onda, -game.background_move, fundo.topo_altura - 25)
      love.graphics.draw(game.onda, -game.background_move + 858, fundo.topo_altura - 25)
      love.graphics.draw(game.pause, 0, 0)
      love.graphics.draw(game.logo, 0, 0)
      if game.som_ativo == true then
        love.graphics.draw(game.som_imagem, config.tela_tamanho_x - game.som_imagem:getWidth() - 3, 0)
      else love.graphics.draw(game.som_desativado_imagem, config.tela_tamanho_x - game.som_imagem:getWidth() - 3, 0)
      end
      love.graphics.draw(game.jogar, game.botao_central_px, game.botao_jogar_py)
    elseif game.started == true and game.lost == true then
      love.graphics.draw(game.pause, 0, 0)
      if game.som_ativo == true then
        love.graphics.draw(game.som_imagem, config.tela_tamanho_x - game.som_imagem:getWidth() - 3, 0)
      else love.graphics.draw(game.som_desativado_imagem, config.tela_tamanho_x - game.som_imagem:getWidth() - 3, 0)
      end
      love.graphics.draw(game.retry, game.botao_central_px, config.tela_tamanho_y - game.retry:getHeight() * 2)
      love.graphics.setFont(game.fonte_game_over)
      love.graphics.print("Game Over", (config.tela_tamanho_x/2) - (game.fonte_game_over:getWidth("Game Over")/2), game.over_msg_py - 100)
      love.graphics.setFont(game.fonte)
      love.graphics.print("" .. game.dist_total .. "", (config.tela_tamanho_x/2) - (game.fonte:getWidth(game.dist_total)/2), game.over_msg_py + game.fonte_game_over:getHeight("Game Over") * 3 - 75)
      love.graphics.print("" .. game.score_total .. "", (config.tela_tamanho_x/2) - (game.fonte:getWidth(game.score_total)/2), game.over_msg_py + game.fonte:getHeight(game.dist_total) * 3 + game.fonte_game_over:getHeight("Game Over") * 3 - 50)
    end
  end
end