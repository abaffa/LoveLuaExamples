size=35

require "player"
require "stages"require "maze"require "audio"require "enemy"require "bomb"require "menu"require "animation"require "auxiliarFunctions"
require "testFunctions"
require "powerUp"
require "IA"
require "boss"
initial={}pause = false
lastFase = 5
qx={}qx[1]=0 qx[2]=0
qy={}qy[1]=0 qy[2]=0
HAHA=0
HUEHUE=0
carregarfase=false
fase=5

pausePortal = 0
lastbutton=0
versus=false
gamestandby=falsefunction love.load()
  joy.load()
  --love.window.setMode(1000, 600, {vsync=false, fullscreen=true, fullscreentype="normal"})
  math.randomseed(os.time())	--upperTileY = 0.1*love.graphics.getHeight()	--upperTileX = 0.1*love.graphics.getWidth()
  audio.infoLoad()
  menu.load()
  love.mouse.setCursor( cursor )
  animation.load(1.5,2,5)	prepareUpper()	stage.infoLoad()
  enemy.infoLoad()
  powerUp.infoLoad()
  player.infoLoad()
  boss.infoLoad()
  bomb.load()
	--IDEMend
function love.gamepadpressed(joystick, button)
  
    lastbutton = button
    
  if not animation.finish then
    if key=='return' then
      animation.finish = true
    end
  elseif (menu.show and menu.status) or pause then
    if menu.pause(key,menu.tipo)>0 then
      menu.evaluate(menu.tipo)
    end
  else
    if pausePortal==0 then
      
    if button=='b' then
      putBomb(button,joystick)
    end
    
    end end
end
function love.keypressed(key)
  if gamestandby then
    if key=='return' then
      menu.show=true
      menu.status=true
      gamestandby=false
    end
  else
  if not animation.finish then
    if key=='return' then
      animation.finish = true
    end
  elseif (menu.show and menu.status) or pause then
    if menu.pause(key,menu.tipo)>0 then
      menu.evaluate(menu.tipo)
    end
  else
    if pausePortal==0 then      if key == "escape" then        --pause = not pause;
        pause=true
        menu.tipo=4      elseif not menu.status then	        putBomb(key)      else        menu.pause(key)      end
    end
    end
  endendfunction love.update(dt)
  
  menu.cursor.update(dt)
  if not gamestandby then
    
  if not animation.finish then
    animation.update(dt)
  elseif menu.status then --abertura do jogo  / menu
    if not menu.show then
      menu.fade(dt)
    end
  else                  --abertura do jogo
    if not pause then
      if pausePortal>0 then
        pausePortal = pausePortal-dt
        if pausePortal<=0 then
          pausePortal = 0
          fase=fase+1
          carregarFase = true
        end
      else
        if carregarFase then
          love.audio.play(audio.laugh)
          i=1
          while(#powerUp>0) do
            table.remove(powerUp,i)
          end
          while(#enemy>0) do
            table.remove(enemy,i)
          end
          while(#bomb>0) do
            table.remove(bomb,i)
          end
          stage.load(fase)
          for i,v in ipairs(player) do
            v.x = initial.x[i]
            v.y = initial.y[i]
          end
          if fase==5 then
            boss.load()
          end
          carregarFase = false
        end        hue=dt
        enemy.update(dt)        player_control(dt)        bomb.control(dt)
        powerUp.update(dt)
        if fase==5 then
          boss.control(dt)
        end
        --updateHitBox() --Funcao para atualizar a hitbox
      end
    end
  end --finalizacao
  endendfunction love.draw()
  --love.graphics.print("Last gamepad button pressed: "..lastbutton, 10, 10)
  if not animation.finish then
    animation.draw()
  elseif menu.status then  --inciio do jogo
    if menu.show then
      menu.draw()
    end
    --draw menu
  else    love.graphics.rectangle("line",upperTileX,upperTileY,finalX-upperTileX,finalY-upperTileY)    maze_draw()    bomb.draw()
    powerUp.draw()    player_draw()
    if fase==5 then
      boss.draw()
    end
    --for i,v in ipairs(enemyTipo[2].charQuads) do
      --love.graphics.draw(enemyTipo[2].img,v,i*40,upperTileY)
      --love.graphics.rectangle("line",i*40,upperTileY,31,54)
    --end
    --showHitBox()
    --showCollision() --Funcao para testar matriz de colisao e dinamica em solidb
    love.graphics.setColor(255,255,255)    enemy.draw()
    --love.graphics.print(HAHA,30,30)
    --love.graphics.print(HUEHUE,30,60)
    --showTestText()    if pause then      menu.draw()
      --love.graphics.draw(menu.wallpaper,0,0)    end
  end --finalizaçãoend