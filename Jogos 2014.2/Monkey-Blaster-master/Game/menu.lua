--menu.lua

menu={}
menu.tipo = 1
menu.status = true
menu.show=false
menu.cursor={}
menu.selector={}
menu.navigate=1
menu.button = love.audio.newSource("/Source/Button.mp3")
menu.wallpaper = love.graphics.newImage("/Source/wallpaper.jpg") --Testin button sound and menu image
fadeTime = 2
cursorCap = 0.2
cursorTime = 0
cursorId = 1
cursor = love.mouse.newCursor("/Source/cursor.gif", 26, 26 )

function menu.load()
  menu.cursor[1]=love.mouse.newCursor("/Source/cursor01.png", 26, 26)
  menu.cursor[2]=love.mouse.newCursor("/Source/cursor02.png", 26, 26)
  menu.cursor[3]=love.mouse.newCursor("/Source/cursor03.png", 26, 26)
  menu.cursor[4]=love.mouse.newCursor("/Source/cursor04.png", 26, 26)
  menu.cursor[5]=love.mouse.newCursor("/Source/cursor05.png", 26, 26)
  menu.cursor[6]=love.mouse.newCursor("/Source/cursor06.png", 26, 26)
  menu.selector[1]=love.graphics.newImage("/Source/cursor01.png")
  menu.selector[2]=love.graphics.newImage("/Source/cursor02.png")
  menu.selector[3]=love.graphics.newImage("/Source/cursor03.png")
  menu.selector[4]=love.graphics.newImage("/Source/cursor04.png")
  menu.selector[5]=love.graphics.newImage("/Source/cursor05.png")
  menu.selector[6]=love.graphics.newImage("/Source/cursor06.png")
  menu.background=love.graphics.newImage("/Source/Menu/background.png")
  menu.backgroundWidth=menu.background:getWidth()
  menu.backgroundHeight=menu.background:getHeight()
  menu.newGame=love.graphics.newImage("/Source/Menu/NewGame.png")
  menu.exit=love.graphics.newImage("/Source/Menu/Exit.png")
  menu.player1=love.graphics.newImage("/Source/Menu/1Player.png")
  menu.players2=love.graphics.newImage("/Source/Menu/2Players.png")
  menu.players3=love.graphics.newImage("/Source/Menu/3pl.png")
  menu.players4=love.graphics.newImage("/Source/Menu/4pl.png")
  menu.normalMode=love.graphics.newImage("/Source/Menu/NormalMode.png")
  menu.versusMode=love.graphics.newImage("/Source/Menu/VersusMode.png")
  menu.exit=love.graphics.newImage("/Source/Menu/Exit.png")
  menu.back=love.graphics.newImage("/Source/Menu/Back.png")
  menu.options=love.graphics.newImage("/Source/Menu/Options.png")
  menu.inGame=love.graphics.newImage("/Source/Menu/InGame.png")
  menu.inGameWidth=menu.inGame:getWidth()
  menu.inGameHeight=menu.inGame:getHeight()
  posx=0.32
  menu.limit={3,3,5,3,4}
end

function menu.fade(dt)
  if fadeTime>0 then
    fadeTime = fadeTime - dt
  else
    menu.show=true
  end
end

function menu.draw()
  love.graphics.setColor(220,220,220)
  love.graphics.setLineWidth(3)
  w=love.graphics.getWidth()
  h=love.graphics.getHeight()
  if menu.tipo~=4 then
    love.graphics.draw(menu.background, 0, 0, 0, w/menu.backgroundWidth, h/menu.backgroundHeight)
  end
  if menu.tipo==1 then
    love.graphics.draw(menu.newGame,posx*w,0.6*h)
    love.graphics.draw(menu.options,posx*w,0.7*h)
    love.graphics.draw(menu.exit,posx*w,0.8*h) --0.24
    love.graphics.draw(menu.selector[cursorId],posx*w-menu.selector[cursorId]:getWidth(),(0.5+menu.navigate*0.1)*h-26)
  elseif menu.tipo==2 then
    love.graphics.draw(menu.normalMode,posx*w,0.6*h)
    love.graphics.draw(menu.versusMode,posx*w,0.7*h)
    love.graphics.draw(menu.back,posx*w,0.8*h) --0.24
    love.graphics.draw(menu.selector[cursorId],posx*w-menu.selector[cursorId]:getWidth(),(0.5+menu.navigate*0.1)*h-26)
  elseif menu.tipo==3 then
    love.graphics.draw(menu.player1,posx*w,0.5*h)
    love.graphics.draw(menu.players2,posx*w,0.6*h)
    love.graphics.draw(menu.players3,posx*w,0.7*h)
    love.graphics.draw(menu.players4,posx*w,0.8*h)
    love.graphics.draw(menu.back,posx*w,0.9*h) --0.24
    love.graphics.draw(menu.selector[cursorId],posx*w-menu.selector[cursorId]:getWidth(),(0.4+menu.navigate*0.1)*h-26)
  elseif menu.tipo==4 then
    x=w/2-menu.inGameWidth/2
    y=h/2-menu.inGameHeight/2
    love.graphics.draw(menu.inGame,x,y)
    love.graphics.draw(menu.back,x+posx*menu.inGameWidth,y+0.2*menu.inGameHeight)
    love.graphics.draw(menu.options,x+posx*menu.inGameWidth,y+0.4*menu.inGameHeight)
    love.graphics.draw(menu.exit,x+posx*menu.inGameWidth,y+0.6*menu.inGameHeight) --0.24
    love.graphics.draw(menu.selector[cursorId],x+posx*menu.inGameWidth-menu.selector[cursorId]:getWidth(),y+menu.navigate*0.2*menu.inGameHeight-26)
  elseif menu.tipo==5 then
    love.graphics.draw(menu.players2,posx*w,0.6*h)
    love.graphics.draw(menu.players3,posx*w,0.7*h)
    love.graphics.draw(menu.players4,posx*w,0.8*h)
    love.graphics.draw(menu.back,posx*w,0.9*h) --0.24
    love.graphics.draw(menu.selector[cursorId],posx*w-menu.selector[cursorId]:getWidth(),(0.5+menu.navigate*0.1)*h-26)
  end
end

function menu.pause(key,mode)
	if(key=='w') then
		menu.navigate = menu.navigate-1
	elseif(key=='s') then
		menu.navigate = menu.navigate+1
	elseif(key=='return') then
		pause= false
		love.audio.play(menu.button)
    return menu.navigate
	end
  z=menu.limit[mode]
  if menu.navigate > z then
    menu.navigate = 1
  elseif menu.navigate < 1 then
    menu.navigate = z
  end --adicionar mais menus
  return 0
end

function menu.evaluate(mode) --cada mode e um menu e cada navigate e um seletor
  if mode==1 then --TELA INICIAL (novo jogo / opcoes / sair)
    if menu.navigate==1 then 
      menu.tipo=2
    --else if menu.navigate==2 then OPCOES *ARRUMAR*
    elseif menu.navigate==3 then
      love.event.quit() 
    end
  elseif mode==2 then --TELA NOVO JOGO (MODO FASE / MODO VERSUS / VOLTAR)
    if menu.navigate==1 then
      menu.tipo=3
    elseif menu.navigate==2 then
      --VERSUS ARRUMAR PARAMETROS
      menu.tipo=5
    else  --menu.navigate==3 --VOLTAR
      menu.tipo=1
    end
  elseif mode==3 then --TELA MODO FASE (1 JOGADOR / 2 JOGADORES / VOLTAR)
    if menu.navigate==1 then  --1 JOGADOR ARRUMAR PARAMETROS
      menu.status=false
      menu.show=false
      quantPlayer=1
      versus=false
      carregar_quantPlayer(quantPlayer)
      --player.load(player[1],1) A VER AINDA
    elseif menu.navigate==2 then --2 JOGADORES ARRUMAR PARAMETROS
      menu.status=false
      menu.show=false
      versus=false
      quantPlayer=2
      carregar_quantPlayer(quantPlayer)
      --player.load(player[1],1) A VER AINDA
      --player.load(player[2],2) A VER AINDA
    elseif menu.navigate==3 and joy.count>=1 then --menu.navigate==3 --VOLTAR
      menu.status=false
      menu.show=false
      versus=false
      quantPlayer=3
      carregar_quantPlayer(quantPlayer)
    elseif menu.navigate==4 and joy.count>=2 then --2 JOGADORES ARRUMAR PARAMETROS
      menu.status=false
      menu.show=false
      versus=false
      quantPlayer=4
      carregar_quantPlayer(quantPlayer)
    elseif menu.navigate==5 then --2 JOGADORES ARRUMAR PARAMETROS
      menu.tipo=2
    end
  elseif mode==4 then --TELA MENU IN-GAME (CONTINUAR / OPCOES / MENU INICIAL)
    if menu.navigate==1 then --continuar jogo
      pause=false
    --elseif menu.navigate==2 then OPCOES *ARRUMAR* *TALVEZ SEGUNDA TELA DE OPCOES*
    elseif menu.navigate==3 then --IR AO MENU ARRUMAR PARAMETROS
      menu.tipo=1
      pause=false
      menu.status=true
      menu.show=true
    end
  elseif mode==5 then
    if menu.navigate==1 then
      menu.status=false
      menu.show=false
      quantPlayer=2
      versus=true
      carregar_quantPlayer(quantPlayer)
    elseif menu.navigate==2 and joy.count>=1 then
      menu.status=false
      menu.show=false
      quantPlayer=3
      versus=true
      carregar_quantPlayer(quantPlayer)
    elseif menu.navigate==3 and joy.count>=2 then
      menu.status=false
      menu.show=false
      quantPlayer=4
      versus=true
      carregar_quantPlayer(quantPlayer)
    elseif menu.navigate==4 then
      menu.tipo=2
    end
  end
  menu.navigate = 1
end

--function menu.limit(mode)
  --if mode==1 then return 3
  --elseif mode==2 then return 3
  --elseif mode==3 then return 3
  --elseif mode==4 then return 4
  --end
--end

function carregar_quantPlayer(quant)
  for i,v in ipairs(player) do
    if i>quant then break end
    player.load(v,i)
    carregarFase = true
  end
end

function menu.cursor.update(dt)
  cursorTime = cursorTime + dt
  if cursorTime>cursorCap then
    if cursorId==6 then cursorId=1 else cursorId=cursorId+1 end
    cursorTime = cursorTime%cursorCap
    love.mouse.setCursor(menu.cursor[cursorId])
  end
end