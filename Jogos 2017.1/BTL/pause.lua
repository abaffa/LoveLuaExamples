pyp=300
local pause = {
  estaNoPause = false
        }
function pause.load()
fonte = love.graphics.newFont("INVASION2000.TTF",50)
end

function pause.update(dt)
  if pyp > 400 then
    pyp = 300
  end
  if pyp < 300 then
    pyp = 400
end
end
function love.keypressed(key)
  if key == "s" then
    pyp = pyp + 100
    end
  if key == "w" then
    pyp = pyp - 100
    end
  
  end
function pause.draw()
  love.graphics.setColor(0,0,0,200)
  love.graphics.rectangle("fill",0,0,800,600)
  love.graphics.setColor(255,255,255)
  love.graphics.setFont(fonte)
  love.graphics.print("Pausado", 275, 100)
  love.graphics.print("Voltar ao jogo\n\nSair do jogo", 200, 300)
  love.graphics.print(">", 170, pyp)
  
 
end
return pause