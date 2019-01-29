local menu = {}
local buttons

function menu.load()
  head = love.graphics.newImage("bear-head.png")
  bg = love.graphics.newImage("menu-hd.png")
  buttons = {
    {
      x= 310,
      y= 325,
      width= 200,
      height = 50
    },
    {
      x= 550,
      y= 480,
      width= 40,
      height = 50
    },
    {
      x= 310,
      y= 400,
      width= 200,
      height = 50
    },
    {
      x= 310,
      y= 475,
      width= 200,
      height= 50
    }
  }
  
  setas = {
      px= buttons[1].x+225,
      py= buttons[1].y,
      wx= 100,
      hx= 60
  }
  local iw,ih = head:getDimensions()
  headsw = 100/iw
  headsh = 60/ih
  headsw = math.min(headsw,headsh)
  headsh = headsw
end

function checkPoint(botao,x,y)
  return botao.x < x + 1 and x < botao.x + botao.width
    and botao.y < y + 1 and y < botao.y + botao.height
end

function menu.update(dt)


  
  local x,y = love.mouse.getPosition()
  local isTouchingButton = false
  for i=1, #buttons do
    if checkPoint(buttons[i],x,y) then
      setas.px = buttons[i].x+buttons[i].width+10
      setas.py=buttons[i].y
      buttonCollider = true
      isTouchingButton = true
    end
   end
   if isTouchingButton==false then
    buttonCollider = false
   end
end

function menu.mousepressed(x,y,but)

  if checkPoint(buttons[1],x,y) and but == 1 then --BOTAO START
    changeToCutscene()
    love.audio.play(rugido)
  end
  
  if checkPoint(buttons[2],x,y) and but == 1 then --BOTAO CONFIGURAÇÕES
    config.destiny = menu
    changeToConfig()
    love.audio.play(rugido)
  end
  
  if checkPoint(buttons[3],x,y) and but == 1 then --BOTAO CREDITOS
    changeToCreditos()
    love.audio.play(rugido)
  end
  
  if checkPoint(buttons[4],x,y) and but == 1 then --BOTAO SAIR
    love.event.quit()
  end
  
end
 
 function menu.draw()
     love.graphics.setColor(255,255,255)
     love.graphics.draw(bg,0,0,0,0.8,0.8)
        
   if buttonCollider == true then
     local s = setas
     love.graphics.draw(head,s.px,s.py,0,headsw,headsh)
    end
   
  end
  
  function menu.keypressed(key)
    
  end
  
  return menu