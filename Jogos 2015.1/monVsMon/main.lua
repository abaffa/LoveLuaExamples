require "lose"
require "pikachu"
require "agumon1"
require "novoMon"
require "camera"
require "map"
require "attackQ"
require "attackW"
require "attackE"
require "menu"
require "digiMap"
require "map2"
require "map3"
require "orbs"
require "barraItem"
require "cutScene1"
require "cutScene2"

function mod( x1, y1, x2, y2 ) -- funcao distancia
  return math.sqrt( (x1-x2)^2 + (y1-y2)^2);
end

function diagonalColide( x1, y1, width1, height1, quadrant, x2, y2, width2, height2 )
  if ( quadrant == 1 ) then
    if( (-x2 + y1 + x1 > y2)
     and ( -(x2 + width2) + (y1 - width1) + (x1 - width1) < (y2 + height2) ) ) then
      if( colide( x1, y1 - height1, height1, height1, x2, y2, width2, height2 ) ) then
        return true
      end
    end
  else
    if(quadrant == 2) then
      if( ((x2 + width2) + y1 - x1 > y2) and ((x2) + (y1 + width1) - (x1 + width1) < (y2 + height2)) ) then
        if( colide( x1 - height1, y1 - height1, height1, height1, x2, y2, width2, height2 ) ) then
          return true
        end
      end
    else
      if (quadrant == 3) then
        if( (-x2 + y1 + x1 > y2)
         and ( -(x2 + width2) + (y1 + width1) + (x1 - width1) < (y2 + height2) ) ) then
          if( colide( x1 - height1, y1, height1, height1, x2, y2, width2, height2 ) ) then
            return true
          end
        end
        --(x2 + width2) + y1 - x1 > y2
        --(x2 + width2) + (y1 + width1) - (x1 - width1) > (y2 + height2)
      else -- quadrant = 4
        if( ((x2 + width2) + y1 - x1 > y2) and ((x2) + (y1 - width1) - (x1 + width1) < (y2 + height2)) ) then
          if( colide( x1, y1, height1, height1, x2, y2, width2, height2 ) ) then
            return true
          end
        end
      end
    end
  end
end

function colide( x1, y1, width1, height1, x2, y2, width2, height2 )
  return x1 + width1 > x2 and x2 + width2 > x1 and y1+height1 >= y2 and y1 <= y2 + height2
end

function love.keypressed(key)
  if gameState == 1 then

    barraItem_keypressed(key)
    keypressedPikachu(key);
    
  else
    if(gameState == -1) then
      menu_keypressed(key)
    else
      if(gameState == 2)then
        map2KeyPress(key)
        else
          if(gameState == 3) then
            barraItem_keypressed(key)
            keypressedPikachu(key);
          else
            if(gameState == 0.5)then
              cs1Keypressed(key);
            else
              if(gameState == 1.5)then
                cs2Keypressed(key);
              end
            end
          end
      end
    end
  end
end  

function love.keyreleased(key)
  pikachu_animreset()
end

function love.load()
  cs1Load();
  cs2Load();
  barraItem_load();
  orb_load();
  loseLoad();
  menu_load();
  agumonLoad();
  monLoad();
  pikachu_load();
  attackQLoad();
  attackWLoad();
  attackELoad();
  mapLoad();
  map2Load();
  map3Load();
  digiMapLoad();
  love.window.setFullscreen(true, "desktop");
  --love.window.setMode(1600, 1200);
end

function love.update(dt)
  if(gameState == 0)then
    loseUpdate(dt);
  else
    if gameState == 1 then
        orb_generate(dt)
        orb_move(dt)
        love.audio.play(map.song);
        pikachuMove(dt);
        attackQUpdate(dt);
        attackWUpdate(dt, agumons);
        attackEUpdate(dt);
        agumonMove(dt);
        if(map.enemiesSpawned < 15)then
          agumon_generate(dt);
        else
          if(map.enemiesKilled > 14)then
            if(map.timesWon == 0)then
              gameState = 1.5;
            else
              gameState = 1.9;
            end
            map.enemiesKilled = 0;
            map.enemiesSpawned = 0;
            map.timesWon = map.timesWon + 1;
            pikachu.move = true;
            
            camera.x = 0
            camera.y = 0
            camera.scaleX = 1
            camera.scaleY = 1
            camera.rotation = 0
            pikachu.x = 300;
            pikachu.y = 300;
            love.audio.stop(map.song);
          end
        end
        mapBorders();
        attackQAgumonColisao(dt);

        if pikachu.x > 600 then
          camera.x = pikachu.x - 600;
        end

        if pikachu.y > 350 then
          camera.y = pikachu.y - 350;
        end
    else
      if(gameState == 1.9)then
        digiMapUpdate(dt);
      else
        if(gameState == 2)then
          map2Update(dt);
        else
          if(gameState == 3)then
            map3Update(dt);
          else
            if(gameState == 0.5)then
              cs1Update(dt);
            end
          end
        end
      end
    end
  end
end

function love.draw()


  if(gameState == 0)then
    loseDraw();
  else
    if gameState == 1 then

    camera:set()

      love.graphics.draw(map.img,16,12)

      pikachu_draw()

      orb_draw()

      agumon_draw()

      attackQDraw()

      attackWDraw()

      attackEDraw()

    camera:unset()

    barraItem_draw()

    pikachuLifeDraw()

    orb_desenho()
    else
      if gameState == -1 then
        menu_draw()
      else
        if(gameState == 1.9)then
          digiMapDraw();
        else
          if(gameState == 2)then
            map2Draw();
          else
            if(gameState == 3)then
              map3Draw();
              barraItem_draw();
            else
              if(gameState == 0.5)then
                cs1Draw();
              else
                if(gameState == 1.5)then
                  cs2Draw();
                end
              end
            end
          end
        end
      end
    end
  end
end