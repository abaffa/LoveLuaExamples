------------OPÇÕES------------

local opcoes = {}

-------Variaveis------
local keys = {
              back = 'escape',
              selectUp = 'up',
              selectDown = 'down',
              selectSelection = 'return',
              changeRight = 'right',
              changeLeft = 'left'
  }
  local selection = 1
  
  local resolution = 1
  local resolutionList = love.window.getFullscreenModes()

--------Funcoes-------

---pseudo-callbacks---
function opcoes.load()
    cfg = require "cfg"
    for i = 1, #resolutionList, 1 do
      if resolutionList[i].width == WIDTH and resolutionList[i].height == HEIGHT then
        resolution = i
        break
      end
    end
    
end

function opcoes.update(dt)
    
end

function opcoes.draw()
    love.graphics.setColor(1,0,0)
    love.graphics.setFont(fontBigger2)
    love.graphics.printf("Opcoes", 0, (HEIGHT/1080)*130, WIDTH, "center")
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fontMedium1)
    love.graphics.printf(resolutionList[resolution].width .. "  X  " .. resolutionList[resolution].height, (WIDTH/1920)*300, (HEIGHT/1080)*350, WIDTH, "center")
    
    if fullScreenState then
      love.graphics.printf("True", (WIDTH/1920)*300, (HEIGHT/1080)*500, WIDTH, "center")
    else
      love.graphics.printf("False", (WIDTH/1920)*300, (HEIGHT/1080)*500, WIDTH, "center")
    end
    
    if fullScreenState then
      love.graphics.setColor(rgb(195, 195, 195))
    end
    
    if borderlessState then
      love.graphics.printf("True", (WIDTH/1920)*300, (HEIGHT/1080)*650, WIDTH, "center")
    else
      love.graphics.printf("False", (WIDTH/1920)*300, (HEIGHT/1080)*650, WIDTH, "center")
    end
    love.graphics.setColor(1,1,1)
    
    love.graphics.printf(volumeGeral, (WIDTH/1920)*300, (HEIGHT/1080)*800, WIDTH, "center")
    
    love.graphics.setFont(fontBig1)
    love.graphics.printf("Resolution", (WIDTH/1920)*-300, (HEIGHT/1080)*330, WIDTH, "center")
    
    love.graphics.printf("Fullscreen", (WIDTH/1920)*-300, (HEIGHT/1080)*480, WIDTH, "center")
    
    if fullScreenState then
      love.graphics.setColor(rgb(195, 195, 195))
    end
    love.graphics.printf("Borderless", (WIDTH/1920)*-300, (HEIGHT/1080)*630, WIDTH, "center")
    love.graphics.setColor(1,1,1)
    
    love.graphics.printf("Volume", (WIDTH/1920)*-300, (HEIGHT/1080)*780, WIDTH, "center")
    
    love.graphics.setColor(0,1,0)
    love.graphics.printf("Apply", (WIDTH/1920)*15, (HEIGHT/1080)*915, WIDTH, "center")
    love.graphics.setColor(1,1,1)
    
    love.graphics.setFont(fontSelect)
    if selection == 1 then
      love.graphics.printf("<\t\t\t\t\t\t\t\t\t\t>", (WIDTH/1920)*300, (HEIGHT/1080)*340, WIDTH, "center")
      
    elseif selection == 2 then
      love.graphics.printf("<\t\t\t\t>", (WIDTH/1920)*295, (HEIGHT/1080)*490, WIDTH, "center")
      
    elseif selection == 3 then
      love.graphics.printf("<\t\t\t\t>", (WIDTH/1920)*295, (HEIGHT/1080)*640, WIDTH, "center")
      
    elseif selection == 4 then
      love.graphics.printf("< \t\t\t >", (WIDTH/1920)*295, (HEIGHT/1080)*790, WIDTH, "center")
      
    elseif selection == 5 then
      love.graphics.printf("<\t\t\t\t\t\t\t>", (WIDTH/1920)*10, (HEIGHT/1080)*925, WIDTH, "center")
      
    end
    
end

function opcoes.keypressed(key)
    if key == keys.back then
      changeToMenu()
    end
    
    if key == keys.selectUp and selection > 1 then
      selection = selection - 1
      if selection == 3 and fullScreenState then
        selection = selection - 1
      end
    elseif key == keys.selectDown and selection < 5 then
      selection = selection + 1
      if selection == 3 and fullScreenState then
        selection = selection + 1
      end
    end
    
    if selection == 1 then
      if key == keys.changeRight and resolution > 1 then
        resolution = resolution - 1
      elseif key == keys.changeLeft and resolution < #resolutionList then
        resolution = resolution + 1
      end
      
    elseif selection == 2 then
      if key == keys.changeRight or key == keys.changeLeft then
        if fullScreenState then
          fullScreenState = false
        else
          fullScreenState = true
        end
        love.window.setFullscreen(fullScreenState, "exclusive")
        
      end
      
    elseif selection == 3 then
      if key == keys.changeRight or key == keys.changeLeft then
        if borderlessState then
          borderlessState = false
        else
          borderlessState = true
        end
        
      end
      
    elseif selection == 4 then
      if key == keys.changeRight and volumeGeral < 10 then
        volumeGeral = volumeGeral + 1
      elseif key == keys.changeLeft and volumeGeral > 0 then
        volumeGeral = volumeGeral - 1
      end
      
    elseif selection == 5 then
      if key == keys.selectSelection then
        WIDTH = resolutionList[resolution].width
        HEIGHT = resolutionList[resolution].height
        love.window.setMode(WIDTH, HEIGHT, {resizable=false, vsync=false, borderless = borderlessState})
        love.window.setFullscreen(fullScreenState, "exclusive")
        cfg.fonts()
        
      end
      
    end
    
end

---outras-funcoes---

---gets/sets---


--
return opcoes