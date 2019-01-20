
local menu = require "menu"
local pause = require "pause"
local hud = require "hud"
local pista = require "pista" 
local trump = require "trump"
local cutscene = require "cutscene"
local fase = require "fase"
local transicao = require "transicao"

width, height = love.graphics.getDimensions()
congelar_jogo = false

function love.load()
  menu.load()
  pause.load()
  hud.load()
  pista.load() 
  trump.load()
  cutscene.load()
  love.window.setMode(800, 600)
  transicao.load()
end

function love.update(dt)
  fase.update(dt)
  if not menu.onMenu and not congelar_jogo then
    pista.update(dt)
    hud.update(dt)
    trump.update(dt)
  end

end

function love.draw()
    menu.draw() --
    pista.draw() --
    hud.draw() --
    trump.draw() --
    pause.draw() --
    cutscene.draw()
    transicao.draw()
end
 -- funçao resetarJogo ainda em desenvolvimento
 function resetarJogo()
  pista.playerX = 0
  pista.speed=0
  fase.updateStats()
  for i = tablelength(segments.cars), 1, -1 do
    table.remove(segments.cars, i)
  end
 end
 
 function love.keypressed(key)
   
  if key == "down" then
  
    if menu.onMenu then -- MAIN MENU
      if menu.n == 1 then -- se o menu tiver em start
        menu.n = 2 -- mude para exit
      else -- se o menu tiver em exit
        menu.n = 1 -- mude para start
      end
    end
  
    if not menu.onMenu and pause.onPause and not pause.instrucao.instru then -- PAUSE MENU
      if pause.n < 3 then -- se o pause n estiver na ultima posiçao 
        pause.n = pause.n + 1 -- soma 1
      else
        pause.n = 1 -- caso esteja, volte pro primeiro
      end
    end
  end
  
  if key == "up"  then
    
  if menu.onMenu then -- MAIN MENU
     if menu.n == 1 then -- se o menu tiver em start
      menu.n = 2 -- mude para exit
    else -- se o menu tiver em exit
      menu.n = 1 -- mude para start
    end
  end
  
  if not menu.onMenu and pause.onPause and not pause.instrucao.instru then -- PAUSE MENU
      if pause.n > 1 then -- se o n n tiver na primeira posiçao
        pause.n = pause.n - 1 -- decresce 1 ( subindo nas opçoes ) 
      else
        pause.n = 3 -- caro esteja, volte pro ultimo 
      end
    end
  end
  
  
  if key == "return"  then
    
    if menu.onMenu then -- MAIN MENU
      if menu.n == 2 then
        love.event.quit()
      else
        menu.onMenu = false
        menu.som:pause()
        menu.great:play()
        menu.som:rewind()
        if not fase[1].onFase then
          cutscene.onCutscene = true
        end
      end
    end
   
    if not menu.onMenu and pause.onPause then -- PAUSE MENU
      if pause.n == 1 then -- voltar ao jogo
        pause.onPause = false
      elseif pause.n == 2 then
        pause.instrucao.instru = true --mostrar instruções
      else -- voltar ao menu inicial
        pause.onPause = false
        menu.onMenu = true
        menu.som:play()
        menu.great:rewind()
      end
    end
    
    if cutscene.onCutscene then --pular cenas da cutscene.
      cutscene.cAtual = cutscene.cAtual + 1
      if cutscene.cAtual > cutscene.cenas then
        cutscene.onCutscene = false
        fase[1].onFase = true
        transicao.n = 1 -- bota a primeira transiçao
        transicao.betweenfases = true
      end
    end  

    if transicao.gameover then
      transicao.gameover = false;
      menu.onMenu = true;
    end

    if transicao.ganhou then
      transicao.ganhou = false
      menu.onMenu = true
    end
    
  end


  

  if key == "escape" then 
   
   if not menu.onMenu and not pause.onPause then -- PAUSE MENU
      pause.onPause = true
    end
   
   if pause.instrucao.instru then
     pause.instrucao.instru = false
   end
  
  end  
end
