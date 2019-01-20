local seleção = require "seleção" -- carrega os modulos
local menu = require "menu"
local fase1 = require "fase1"
local fase2 = require "fase2"
local fase3 = require "fase3"
local pause = require "pause"
local pulof1 = require "pulof1"
local gameover = require "gameover"
local texto1 = require "texto1"
local texto2 = require "texto2"
local texto3 = require "texto3"
-- py -> posição de y do menu
-- pys -> posição de y da tela de seleção de fase
--pxf1 -> posição de x na fase 1
--pyf1 -> posição de y na fase 1
--pyp -> posição de y na tela de pause

function love.load() -- load dos modulos
  menu.load()
  seleção.load()
  fase1.load()
  fase2.load()
  fase3.load()
  pause.load()
  gameover.load()
  texto1.load()
  love.window.setTitle("BTL") -- título da janela
  trilha = love.audio.newSource("trilha_sonora.mp3","static")
  sel = love.audio.newSource("sfx_select.wav","static")
end

function love.update(dt) -- update dos modulos
  trilha:setLooping(true)
  love.audio.play(trilha)
  
  if not pause.estaNoPause then
    if menu.estaNoMenu then
      menu.update(dt)
    elseif seleção.estaNaSeleção then
      seleção.update(dt)
    elseif fase1.estaNaFase1 then
      fase1.update(dt)
      if pulof1.estaPulando then
        pulof1.update(dt)
      end
      if fase1.vida==0 then
        gameover.perdeu = true
        fase1.estaNaFase1 = false
      end
      if fase1.fade_out >= 255 then
        fase1.estaNaFase1 = false
        fase1.speed=0
        pxf1=100
        pyf1=350
        pyp = 300
        fase1.speed=0
        fase1.x=250
        fase1.vida=2
        fase1.fade_out=0
        pulof1.estaPulando = false
        menu.estaNoMenu = true
      end
    elseif fase2.estaNaFase2 then
      fase2.update(dt)
      if pulof1.estaPulando then
        pulof1.update(dt)
      end
      if fase2.vida==0 then
        gameover.perdeu = true
        fase2.estaNaFase2 = false
      end
      if fase2.fade_out >= 255 then
        fase2.estaNaFase2 = false
        fase2.speed=0
        pxf2=100
        pyf2=350
        pyp = 300
        fase2.speed=0
        fase2.x=250
        fase2.vida=2
        fase2.fade_out=0
        pulof1.estaPulando = false
        menu.estaNoMenu = true
      end
    elseif fase3.estaNaFase3 then
      fase3.update(dt)
      if pulof1.estaPulando then
        pulof1.update(dt)
      end
      if fase3.vida==0 then
        gameover.perdeu = true
        fase3.estaNaFase3 = false
      end
      if fase3.fade_out >= 255 then
        fase3.estaNaFase3 = false
        fase3.speed=0
        pxf3=100
        pyf3=350
        pyp=300
        fase3.speed=0
        fase3.x=250
        fase3.vida=1
        fase3.fade_out=0
        pulof1.estaPulando = false
        menu.estaNoMenu = true
      end
    elseif gameover.perdeu then
      gameover.update(dt)
    end
  else pause.update(dt)
  end
end

function love.keypressed(key)
  if key == "s" then
    if menu.estaNoMenu then -- desce a seta no menu
      py = py + 100
    elseif seleção.estaNaSeleção then -- desce a seta na seleção
      pys = pys + 100
    elseif pause.estaNoPause then -- desce a seta no pause
      pyp = pyp + 100
    elseif gameover.perdeu then
      pyg = pyg + 100
    end
  end
  if key == "w" then
    if menu.estaNoMenu then -- sobe a seta no menu
      py = py - 100
    elseif seleção.estaNaSeleção then -- desce a seta na seleção
      pys = pys - 100
    elseif pause.estaNoPause then -- sobe a seta no pause
      pyp = pyp - 100
    elseif gameover.perdeu then
      pyg = pyg - 100
    end
  end
  
  if key == "space" then -- tecla de seleção
    if menu.estaNoMenu then
      if py == 400 then -- troca do menu para a seleção
       menu.estaNoMenu = false
       seleção.estaNaSeleção = true
       pys = 250
       love.audio.play(sel)
      elseif py == 500 then -- fecha o jogo
       love.event.quit()
      end
    elseif seleção.estaNaSeleção then 
      if pys == 550 then  -- volta da seleção para o menu
       menu.estaNoMenu = true
       seleção.estaNaSeleção = false
       py = 400
       love.audio.play(sel)
      elseif pys==250 then   -- seleciona a primeira fase
        seleção.estaNaSeleção = false 
        texto1.estaNoTexto1 = true
        love.audio.play(sel)
      elseif pys==350 then  -- seleciona a segunda fase
        seleção.estaNaSeleção = false
        texto2.estaNoTexto2 = true 
        love.audio.play(sel)
      elseif pys==450 then  -- seleciona a terceira fase
        seleção.estaNaSeleção = false
        texto3.estaNoTexto3 = true
        love.audio.play(sel)
      end
    elseif pause.estaNoPause then
      if pyp == 400 then
        pause.estaNoPause = false
        menu.estaNoMenu = true
        fase1.estaNaFase1 = false
        fase2.estaNaFase2 = false
        fase3.estaNaFase3 = false
        ---------------------------------------FASE 1
        fase1.speed=0
        pxf1=100
        pyf1=350
        pyp = 300
        fase1.x=250
        fase1.vida=2
        fase1.fade_out=0
        pulof1.estaPulando = false
        ---------------------------------------FASE 2
        fase2.speed=0
        pxf2=100
        pyf2=350
        pyp = 300
        fase2.x=250
        fase2.vida=2
        fase2.fade_out=0
        pulof1.estaPulando = false
        ---------------------------------------FASE 3
        fase3.speed=0
        pxf3=100
        pyf3=400
        pyp = 300
        fase3.x=250
        fase3.vida=1
        fase3.fade_out=0
        pulof1.estaPulando = false
        ---------------------------------------
        love.audio.play(sel)
      elseif pyp == 300 then
        pause.estaNoPause = false
        love.audio.play(sel)
      end
    elseif fase1.estaNaFase1 and not pulof1.estaPulando then
      chao1=pyf1
      pulof1.estaPulando = true
    elseif fase2.estaNaFase2 and not pulof1.estaPulando then
      chao2=pyf2
      pulof1.estaPulando = true
    elseif fase3.estaNaFase3 and not pulof1.estaPulando then 
      chao3=pyf3
      pulof1.estaPulando = true
    elseif gameover.perdeu then
      ---------------------------------------FASE 1
      fase1.speed=0
      pxf1=100
      pyf1=350
      pyp=300
      fase1.speed=0
      fase1.x=250
      fase1.vida=2
      fase1.fade_out=0
      pulof1.estaPulando = false
      ---------------------------------------FASE 2
      fase2.speed=0
      pxf2=100
      pyf2=350
      pyp=300
      fase2.speed=0
      fase2.x=250
      fase2.vida=2
      fase2.fade_out=0
      pulof1.estaPulando = false
      ---------------------------------------FASE 3
      fase3.speed=0
      pxf3=100
      pyf3=400
      pyp=300
      fase3.x=250
      fase3.vida=1
      fase3.fade_out=0
      pulof1.estaPulando = false
      ---------------------------------------
      if pyg == 400 then
        gameover.perdeu = false
        menu.estaNoMenu = true
        love.audio.play(sel)
      end    
    elseif texto1.estaNoTexto1 then
      texto1.estaNoTexto1 = false
      fase1.estaNaFase1 = true
    elseif texto2.estaNoTexto2 then
      texto2.estaNoTexto2 = false
      fase2.estaNaFase2 = true
    elseif texto3.estaNoTexto3 then
      texto3.estaNoTexto3 = false
      fase3.estaNaFase3 = true
    end
  end
  
  if key == "escape" then
    if fase1.estaNaFase1 then -- pausa o jogo
      pause.estaNoPause = true
    elseif fase2.estaNaFase2 then
      pause.estaNoPause = true
    elseif fase3.estaNaFase3 then
      pause.estaNoPause = true
    end
  end
end

function love.keyreleased(key)
  
if key == "w" then
  if not menu.estaNoMenu and not seleção.estaNaSeleção and not pause.estaNoPause and not gameover.Perdeu then
    retardando_w = true
  end
end

if key == "a" then
  if not menu.estaNoMenu and not seleção.estaNaSeleção and not pause.estaNoPause and not gameover.Perdeu then
    retardando_a = true
  end
end

if key == "s" then
  if not menu.estaNoMenu and not seleção.estaNaSeleção and not pause.estaNoPause and not gameover.Perdeu then
    retardando_s = true
  end
end

if key == "d" then
  if not menu.estaNoMenu and not seleção.estaNaSeleção and not pause.estaNoPause and not gameover.Perdeu then
    retardando_d = true
  end
end
  
end
function love.draw() -- draw dos modulos
  if menu.estaNoMenu then
   menu.draw()
   end
  if seleção.estaNaSeleção then
   seleção.draw()
  end
  if fase1.estaNaFase1 then
    fase1.draw()
  end
  if fase2.estaNaFase2 then
    fase2.draw()
  end
  if fase3.estaNaFase3 then
    fase3.draw()
  end
  if pause.estaNoPause then
    pause.draw()
  end
  if gameover.perdeu then
    gameover.draw()
  end
  if texto1.estaNoTexto1 then
    texto1.draw()
  end
  if texto2.estaNoTexto2 then
    texto2.draw()
  end
  if texto3.estaNoTexto3 then
    texto3.draw()
  end
end