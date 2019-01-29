local menu = {}

local botaoStart
local actualButton = 1

function menu.load()
    love.graphics.setBackgroundColor(130,34,116)
    título = love.graphics.newImage("Menu - Ninja Rush.png")
    shuriken = love.graphics.newImage("Shuriken - Menu.png")
    start = love.graphics.newImage("Start.png")
    ranking = love.graphics.newImage("Ranking.png")
    controls = love.graphics.newImage("Controls.png")
    kunai = love.graphics.newImage("Kunai - Menu.png")
    buttons = {
      width = 1.7,
      height = 1.7,
      {
        --start
        image = start,
        x = 468,
        y = 300
      },
      {
        --ranking
        image = ranking,
        x = 460,
        y = 400
      },
      {
        --controls
        image = controls,
        x = 460,
        y =500
      }
    }
  end

  function menu.update (dt)
    --y_kunai = buttons[actualButton].y
    y_k= buttons [actualButton].y
  end
 
  local function checkpoint(botao,x,y)
    return botao.x < x+1 and x < botao.width
    and botao.y < y+1 and y < botao.y + botao.width
  end

function menu.draw()
  love.graphics.setColor(255, 255, 255)
  -- Shuriken --
  love.graphics.draw(shuriken, 100, 40, 0, 0.5, 0.5)
  love.graphics.draw(shuriken, 730, 40, 0, 0.5, 0.5)
  -- Título --
  love.graphics.draw(título, 255, 20)
   
  if actualButton > 0 then
    --DESENHO KUNAI
    love.graphics.draw(kunai, 300, y_k)
  end
  for i=1, #buttons do
   local b = buttons[i]
   love.graphics.draw(b.image, b.x, b.y)
  end
end

function menu.keypressed(key)
  if key == "down" then
    if actualButton < #buttons then
      actualButton = actualButton + 1
    end
  end
  if key == "up" then
    if actualButton > 1 then
      actualButton = actualButton - 1
    end
  end
  if key == "return" then
    if actualButton == 1 then
      ChangeToCharacters()
    end
   end
end

return menu