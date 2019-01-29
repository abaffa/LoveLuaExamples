local menu = {}
local menu_inicial = "Novo Jogo\n Carregar\n  Opções\n Créditos\n    Sair\n"
local menu_type
local cutscenes
local seta_menu
local py = 180
local px = 310
local button_selected
local opcoes 
local creditos = "        Gabriel Ferreira Diaz Abreu\nJoão Pedro de Andrade S.C. Menezes\nJoão Pedro Martins Filipe F.M.M. Pereira\n         João Pedro Martins Fraga\n     Luis Otávio Martins Esperança\n  Rafael Damazio Monteiro da Silva\n"  
local save_menu
local audio_source = love.audio.newSource('musica_1.mp3')
life = 3
function menu.load()
  audio_source:setLooping(true)
  audio_source:play()
  seta_menu = love.graphics.newImage("seta_menu.png")
  quad = love.graphics.newQuad(0, 0, 43, 55, seta_menu:getWidth(), seta_menu:getHeight())
  save_menu = love.graphics.newImage("save_menu.png")
  button_selected = 0
  button_timer = 0
  menu_type = "menu_inicial"
end
    
function menu.update(dt)
  button_timer = button_timer + dt
  if menu_type == "menu_inicial" then
    if love.keyboard.isDown("down") and button_timer > 0.2 then
      button_timer = 0
      button_selected = button_selected + 1
      if button_selected > 4 then
        button_selected = 0
      end  
      end
        if love.keyboard.isDown("up") and button_timer > 0.2 then
        button_timer = 0
        button_selected = button_selected - 1
          if button_selected < 0 then
          button_selected = 4  
          end 
        end
  end     
  if menu_type == "menu_inicial" then
    if love.keyboard.isDown("return") then
      if button_selected == 2 then
        menu_type = "opcoes"
        button_selected = 0
      elseif button_selected == 1 then
        menu_type = "save_menu"
        button_selected = 0
      elseif button_selected == 3 then
        menu_type = "creditos"
      end
    end
  end
  if menu_type == "save_menu" then 
        if love.keyboard.isDown("escape") then
        menu_type = "menu_inicial"
        button_selected = 0
        end
    if love.keyboard.isDown("down") and button_timer > 0.2 then
      button_timer = 0
      button_selected = button_selected + 1
      if button_selected > 2 then
        button_selected = 0        
      end
    end
  end
  if love.keyboard.isDown("up") and button_timer > 0.2 then
     button_timer = 0
     button_selected = button_selected - 1
    if button_selected < 0 then
       button_selected = 2  
    end   
  end            
  if menu_type == "opcoes" then
    if love.keyboard.isDown("escape") then
      menu_type = "menu_inicial"
      button_selected = 0
    end
      if love.keyboard.isDown("right") and button_timer > 0.2 then
      button_timer = 0
      if volume < 10 then
      volume = volume + 1
    end
     love.audio.setVolume(volume*0.5)
    end
      if love.keyboard.isDown("left") and button_timer > 0.2 then
      button_timer = 0
       if volume > 0 then
        volume = volume - 1
        end
      love.audio.setVolume(volume*0.5)
      end
    end  
      if menu_type == "creditos" then 
        if love.keyboard.isDown("escape") then
        menu_type = "menu_inicial"
        button_selected = 0
        end  
      end    
  if menu_type == "menu_inicial" and button_timer > 0.2 then
    if love.keyboard.isDown("return") and button_selected == 0 then
      changeToCutscene()
      --changeToGame()
    end
  end   
end
function menu.draw()
  if menu_type == "menu_inicial" then
    love.graphics.draw(love.graphics.newImage("image/menu.png"),0,0)
    love.graphics.setNewFont("Pixel Digivolve.otf",30)
    love.graphics.print(menu_inicial,335,175)
    love.graphics.setBackgroundColor(0,0,0)
    love.graphics.draw(seta_menu,px,py + (button_selected * 35),0,0.5,0.5)
     if love.keyboard.isDown("return") and button_selected == 4 then
       love.event.quit()
     end
  end
  if menu_type == "save_menu" then
    love.graphics.draw(save_menu,-30,30)
    love.graphics.rectangle("line",190, 40+(button_selected *170), 400 ,120)
  end  

  if menu_type == "creditos" then
    love.graphics.setNewFont("fonte.ttf",25)
    love.graphics.print(creditos,120,150)  
  end  
if menu_type == "opcoes" then
    love.graphics.setNewFont("fonte.ttf",25)
     love.graphics.print("Volume",200,145)
     --love.graphics.draw(seta_menu,150,139)
     love.graphics.print(volume,640,145) 
     love.graphics.setFont(love.graphics.newFont(40))    
    love.graphics.rectangle("fill",330,147,30*volume,30)
end  
end

function menu.keypressed(key)

end

return menu
