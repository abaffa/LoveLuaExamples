local deathMenu={}
local telaMorte
local selectedMenu = 0


function deathMenu.load()
  telaMorte=love.graphics.newImage("imagens/telamorte.jpg")
end

function deathMenu.getState()
  return selectedMenu
end

function deathMenu.update()
  local mouseX = love.mouse.getX()
  local mouseY = love.mouse.getY()
  selectedMenu = 0
  if mouseX < 400 and mouseX > 100 then
    if mouseY > 200 then
      if mouseY < 250 then
        selectedMenu = 1
      elseif mouseY < 300 then
        selectedMenu = 2
      end
    end
  end
end

function deathMenu.draw ()
  love.graphics.setColor(100,100,100)
  love.graphics.draw(telaMorte,0,0,0,love.graphics.getWidth()/telaMorte:getWidth(),love.graphics.getHeight()/telaMorte:getHeight())
  love.graphics.setColor(200,0,0)
  if selectedMenu == 1 then
    love.graphics.setColor(200,200,200)
    love.graphics.print("TENTAR NOVAMENTE",100,200)
    love.graphics.setColor(200,0,0)
  else
    love.graphics.print("TENTAR NOVAMENTE",100,200)
  end
  if selectedMenu == 2 then
    love.graphics.setColor(200,200,200)
    love.graphics.print("MENU PRINCIPAL",100,250)
    love.graphics.setColor(200,0,0) 
  else
    love.graphics.print("MENU PRINCIPAL",100,250)
  end
end


return deathMenu