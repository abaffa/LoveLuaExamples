require "jogo"
function love.load()
  capa = love.graphics.newImage("capa.png")
  start = love.graphics.newImage("start.png")
  start_sel =love.graphics.newImage("start_sel.png")
  options=love.graphics.newImage("options.png") -- botão opções
  options_sel =love.graphics.newImage("options_sel.png") -- botão opções
  options2=love.graphics.newImage("options2.png") --- menu opções
  sound=love.graphics.newImage("sound.png")
  sound_sel=love.graphics.newImage("sound_selected.png")
  sound_on=love.graphics.newImage("sound_on.png")
  sound_off=love.graphics.newImage("sound_off.png")
  music=love.graphics.newImage("music.png")
  music_sel=love.graphics.newImage("music_selected.png")
  help =love.graphics.newImage("help.png") -- primeira tela
  help_sel =love.graphics.newImage("help_selected.png")
  back=love.graphics.newImage("back.png")
  back_sel=love.graphics.newImage("back_selected.png")
  help2=love.graphics.newImage("help2.png") --instruções
  levels=love.graphics.newImage("interface_levels.png")
  level1=love.graphics.newImage("LEVEL 1.png")
  level2=love.graphics.newImage("LEVEL 2.png")
  level3=love.graphics.newImage("LEVEL 3.png")
  level4=love.graphics.newImage("LEVEL 4.png")
  level5=love.graphics.newImage("LEVEL 5.png")
  carrega_musica()
  botao=0
  gamestate=0
  level=1
  som=0
  musica=0
end
function love.update(dt)
  if gamestate == 4 then 
    jogo_update(dt)
  end
  if gamestate<4 or musica==1 then
    muda_musica()
  end
  end
function love.keypressed(key)
   if botao==5 then -- help
    if key=="return" then
      if gamestate==1 then
        gamestate=2 
        elseif gamestate==2  then
        gamestate=1
      end
    end
  end
  if botao==6 and key=="return" then--back
    if gamestate==1 then
      botao=2 gamestate=0
      elseif gamestate==3 then
      botao=1 gamestate=0 level=1
    end
  elseif gamestate==0 then --menu inicial
    if botao==1 and key=="return" then --start
    gamestate=3 
  end
  if botao==2 and key=="return" then --options
    gamestate=1 botao=3
  end
    if key=="left" then
      if botao==0 then
        botao=1
        elseif botao==1 then
        botao=2
        elseif botao==2 then
        botao=1
      end
    end
    if key=="right" then
      if botao==0 then
      botao=2
      elseif botao==2 then
      botao=1
      elseif botao==1 then
      botao=2
      end
    end
  elseif gamestate==1 then -- options
    if key=="down" then
      if botao==3 then
        botao=4
        elseif botao==4 then
        botao=5
        elseif botao==5 then
        botao=6
        elseif botao==6 then
        botao=3
      end
    end
    if botao==3 then
      if key=="return" then
      if som==0 then 
        som=1
      elseif som==1 then
      som=0
    end
    end
    end
    if botao==4 then
      if key=="return" then
      if musica==0 then
        musica=1
      elseif musica==1 then
      musica=0 
    end
    end
    end
    
    if key=="up" then
      if botao==3 then
        botao=6
        elseif botao==6 then
        botao=5
        elseif botao==5 then
        botao=4
        elseif botao==4 then
        botao=3
      end
    end
  elseif gamestate==3 then -- seleção niveis
    if key=="right" then 
      if level==1 then
      level=2
      elseif level==2 then
        level=3
      elseif level==3 then
        level=4
      elseif level==4 then
        level=5
      elseif level==5 then
        botao= 6 level=0
      elseif level==0 then
        level=1 botao=0
      end
    end
    if key=="left" then 
      if level==1 then
       botao=6 level=0
      elseif level==0 then
        level=5 botao=0
      elseif level==5 then
        level=4
      elseif level==4 then
        level=3
      elseif level==3 then
        level=2
      elseif level==2 then
        level=1
      end
    end
    
    if key=="return" and level ~=0 then
      gamestate=4
      fase = level 
      jogo_load()
     end 
    if botao==6 and key=="return" then
     gamestate=0 botao=1 level=0
    end
  elseif gamestate == 4 then -- Jogo
    controle_keypressed(key)
    --if key == "" then
      --gamestate = 5
    --end
  --elseif gamestate == 5 then
    
  end
 
   if gamestate==4 then
  if key == "escape" then
    pause=1 -- menu pause
    end
      if pause==1 and  key=="down" then
        if botaopause==0 then
        botaopause=1
        elseif botaopause==1 then
        botaopause=2
        elseif botaopause==2 then
        botaopause=3
        elseif botaopause==3 then
        botaopause=4
        elseif botaopause==4 then
        botaopause=0
        end
      end
      if pause==1 and  key=="up" then
        if botaopause==0 then
        botaopause=4
        elseif botaopause==4 then
        botaopause=3
        elseif botaopause==3 then
        botaopause=2
        elseif botaopause==2 then
        botaopause=1
        elseif botaopause==1 then
        botaopause=0
        end
      end  
      if pause==1 and key=="return" then
        if botaopause==0 then
        pause=0
        elseif botaopause==1 then
          if som==1 then
           som=0
          elseif som==0 then
           som=1
          end 
        elseif botaopause==2 then
          if musica==1 then
           musica=0
          elseif musica==0 then
           musica=1
          end 
        elseif botaopause==3 then
        gamestate=3  botaopause=0
        elseif botaopause==4 then
        gamestate=0 botao=1 botaopause=0 level=1
        end
      end  
      end
      end
function love.draw()
  if gamestate == 4 then 
    jogo_draw()
  end
  if gamestate<=2 then
    love.graphics.draw(capa,0,0)
  end
  if gamestate==0 then
    love.graphics.draw (start,60,500)
    love.graphics.draw(options,525,500)
    if botao==1 then
    love.graphics.draw (start_sel,45,490)
    end
    if botao==2 then
    love.graphics.draw(options_sel,510,490)
    end
  end
  if gamestate==1 then
  love.graphics.draw(options2,100,100)
  love.graphics.draw(sound,347,217)
  love.graphics.draw(music,352,280)
  love.graphics.draw(help,326,347)
  love.graphics.draw(back,529,424)
    if som==0 then
    love.graphics.draw(sound_on,519,200)
    end
    if som==1 then
    love.graphics.draw(sound_off,519,200)
    end 
  
    if musica==0 then
    love.graphics.draw(sound_on,520,265)
  end 
  if musica==1 then
    love.graphics.draw(sound_off,520,265)
  end 
  
  if botao==3 and gamestate==1 then
    love.graphics.draw(sound_sel,347,217)
    end
    if botao==4 then
    love.graphics.draw(music_sel,352,280)
    end
    if botao==5 then
    love.graphics.draw(help_sel,326,347)
    end
  end
  if gamestate==1 or gamestate==3 then
    if botao==6 then
     love.graphics.draw(back_sel,529,424)
    end
  end  
  if gamestate==2 and botao==5 then
     love.graphics.draw(help2,100,100) 
     love.graphics.draw(back_sel,560,450)
  end
  if gamestate==3 then
  love.graphics.draw(levels,0,0,0,1.345,1.5)
  love.graphics.draw(back,660,540)
    if botao==6 then
    love.graphics.draw(back_sel,660,540)
    end
    if level==1 then 
    love.graphics.draw(level1,53,154,0,1.05,1.15)
    end
    if level==2 then 
     love.graphics.draw(level2,285,154,0,1.1,1.15)
    end
    if level==3 then 
     love.graphics.draw(level3,516,154,0,1.1,1.15)
    end
    if level==4 then 
     love.graphics.draw(level4,169,363,0,1.1,1.15)
    end
    if level==5 then 
     love.graphics.draw(level5,402,364,0,1.1,1.15)
    end
    if level==6 then 
     love.graphics.draw(back,670,540)
    end
  end
 end