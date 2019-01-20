 local gameover={
  perdeu=false
  }
function gameover.load()
fonte = love.graphics.newFont("INVASION2000.TTF",50)
pyg=400
end

function gameover.update(dt)
  if pyg > 400 then
    pyg = 400
  end
  if pyg < 400 then
    pyg = 400
end
end
function love.keypressed(key)
  if key == "s" then
    py = py + 100
    end
  if key == "w" then
    py = py - 100
    end
  
  end
function gameover.draw()
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill",0,0,800,600)
  love.graphics.setColor(255,255,255)
  love.graphics.setFont(fonte)
  love.graphics.print("Game Over", 240, 100)
  love.graphics.print("\n\nMenu", 260, 300)
  love.graphics.print(">", 230, pyg)
 
  end
return gameover