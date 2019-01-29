local pausa = {}
--local game = require "game"
local menu_pausa = "Continuar\n Carregar\n  Opções\n Créditos\n    Menu\n"
local menu_type
local button_selected = 0
local opcoes_1
local seta_menu
local save_menu
local creditos = "        Gabriel Ferreira Diaz Abreu\nJoão Pedro de Andrade S.C. Menezes\nJoão Pedro Martins Filipe F.M.M. Pereira\n         João Pedro Martins Fraga\n     Luis Otávio Martins Esperança\n  Rafael Damazio Monteiro da Silva\n"  
function pausa.load()
  menu_type = "menu_pausa"
  seta_menu = love.graphics.newImage("seta_menu.png")
  quad = love.graphics.newQuad(0, 0, 43, 55, seta_menu:getWidth(), seta_menu:getHeight())
  save_menu = love.graphics.newImage("save_menu.png")
  opcoes_1 = love.graphics.newImage("opcoes_1.png")
end

function pausa.update(dt)
  button_timer = button_timer + dt
  if menu_type == "menu_pausa" then
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
  if love.keyboard.isDown("return") and button_selected == 0 then
    changeToGame()
  end  

  if love.keyboard.isDown("return") and button_selected == 1 then
    menu_type = "save_menu"   
  end
      
  if menu_type == "save_menu" then
    if love.keyboard.isDown("down") and button_timer > 0.2 then
      button_selected = button_selected + 1
      button_timer = 0
      if button_selected > 2 then
        button_selected = 0        
      end
    end
    if love.keyboard.isDown("up") then
      button_selected = button_selected - 1
      if button_selected > -2 then
       button_selected = 0  
      end   
    end   
    if love.keyboard.isDown("escape") then
      menu_type = "menu_pausa"
      button_selected = 0  
    end 
  end   
if love.keyboard.isDown("return") and button_selected == 3 then
 pausa_type = "creditos"
 button_timer = 0
  elseif love.keyboard.isDown("escape") then
    menu_type = "menu_pausa"
    button_selected = 0
end  
if love.keyboard.isDown("return") and button_selected == 4  and  button_timer > 0.2  then
  button_timer = 0 
  changeToMenu()
end  
if love.keyboard.isDown("return") and button_selected == 2 and button_timer > 0.2 then
    menu_type = "opcoes_1"
   end
    if love.keyboard.isDown("right") and button_timer > 0.2 then
      button_timer = 0
      if volume < 10 then
      volume = volume + 1
      end
    end
      if love.keyboard.isDown("left") and button_timer > 0.2 then
      button_timer = 0
       if volume > 0 then
        volume = volume - 1
        end
      love.audio.setVolume(volume*0.3)
  end
end
function pausa.draw()
  if menu_type == "menu_pausa" then
    love.graphics.setNewFont("Pixel Digivolve.otf",30)    
    love.graphics.print(menu_pausa,335,175)
    love.graphics.draw(seta_menu,310,180 + (button_selected * 35),0,0.5,0.5)
    love.graphics.setBackgroundColor(0,0,0)
  end  
if menu_type == "save_menu" then
    love.graphics.draw(save_menu,-30,50)
    love.graphics.rectangle("line",190, 40+(button_selected *170), 400 ,120)
  if button_selected > 2 then
    button_selected = 0
  end  
end   
if menu_type == "opcoes_1" then
   --love.graphics.draw(opcoes_1, -400,-90)
    love.graphics.setNewFont("fonte.ttf",25)
     love.graphics.print("Volume",200,145)
     --love.graphics.draw(seta_menu,150,139)
     love.graphics.print(volume,640,145) 
     --love.graphics.print(volume_2,400,205)    
     love.graphics.setFont(love.graphics.newFont(40))    
    love.graphics.rectangle("fill",330,147,30*volume,30)
end    
if menu_type == "creditos" then
  love.graphics.setNewFont("fonte.ttf",30)
 love.graphics.print(creditos,120,150)
 
  love.graphics.setBackgroundColor(0,0,0)
end
end
function pausa.keypressed(key)
 
  
end

 return pausa
  