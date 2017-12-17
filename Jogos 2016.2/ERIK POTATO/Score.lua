local Score = {}
local SfonteS = love.graphics.newFont("bloodlust.ttf", 48)

function Score.load(call, isSecret)
  Score.BG = love.graphics.newImage("Score.png")
  Score.isSecret = isSecret
end

function Score.mousepressed()
end

function Score.keypressed()
end

function Score.update(dt)
end

function Score.draw()
  love.graphics.draw(Score.BG,0,0)
  local fonte = love.graphics.newFont("Tasty_Birds.otf", 18)
  love.graphics.setFont(fonte)
  love.graphics.print("Clica no Erik\nno Menu",50,50)
  if Score.isSecret then
    love.graphics.setFont(SfonteS)
    love.graphics.setColor(255,0,0)
    love.graphics.print("SECRETO",335,70,0,1.3,1.3)
  end
end

return Score