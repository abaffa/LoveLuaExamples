button={}

function title_draw()
  font = love.graphics.setNewFont("Bubblegum.ttf",50)
  title = love.graphics.print("SAVErino",0,0)
end

function button_spawn(x,y,text,id)
  table.insert(button, {x = x, y = y, text = text, id = id, mouseover = false})
end 

function button_draw()
  for i,v in ipairs(button) do
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(font)
    love.graphics.print(v.text,v.x,v.y) 
   end 
end  

function button_click(x,y)
  for i,v in ipairs(button) do
    if x > v.x and
     x < v.x + font:getWidth(v.text) and
     y > v.y and
     y < v.y + font:getHeight(v.text) then
      if v.id == "sair" then
        love.event.push("quit")   
      end 
      if v.id == "start" then
        return true
      end 
    end
  end 
end  

function button_check(mousex, mousey)
  for i,v in ipairs(button) do
    if mousex > v.x and
    mousex < v.x + font:getWidth(v.text) and
    mousey > v.y and
    mousey < v.y + font:getHeight(v.text) then
      v.mouseover = true
    else
      v.mouseover = false
    end
  end
end  

function menu_load()
  menu_background = love.graphics.newImage("menu_oficial.png")
end

function menu_draw()
  love.graphics.draw(menu_background,0,0)
end