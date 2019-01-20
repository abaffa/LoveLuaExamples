local menu = require "menu"

local carro = { 
   quads = {}, -- tabela de sprites cortados 
   carRed = nil, --variavel com a foto sem estar cortada do sprite
   anim = 1, -- variavel animação
   tileSizeRX = 160,
   tileSizeRY = 128,
   timer = 0,
   dif = 100,
   passado = 0, 
   intervalo = 5,
   xvelho = 0
}

function carro.loadQuads(nx, ny)
  carro.carRed = love.graphics.newImage("carro_verm.png")
  local count = 1
  for i = 0, nx-1 do
    for j = 0, ny-1 do
      carro.quads[count] = love.graphics.newQuad(i*carro.tileSizeRX,j*carro.tileSizeRY, carro.tileSizeRX, carro.tileSizeRY, carro.carRed:getWidth(), carro.carRed:getHeight())
       count = count + 1
     end
   end
end

function carro.load()
  love.graphics.setBackgroundColor(255, 255, 255)
  carro.loadQuads(3,3)
end

function carro.spawn()
  
  local x = math.floor(math.random((width/4)-carro.tileSizeRX,(3*width/4)-carro.tileSizeRX)) -- seta um x
  local y = - carro.tileSizeRY -- seta um y
  local dth = carro.tileSizeRX -- width da imagem
  local ght = carro.tileSizeRY; -- height da imagem 

  for i, v in ipairs(carro) do
    if colisao(v.x, v.y, dth, ght, x, y, dth, ght) then
      x = math.floor(math.random((width/4)-carro.tileSizeRX,(3*width/4)-carro.tileSizeRX))
    end
  end
  
  table.insert(carro,{ x=x,y=y,speed=math.floor(math.random(120,480))}) -- cria um carro

 --carro.xvelho = x -- anota o x do carro novo
end 

function carro.generator()
      local z = math.floor(math.random(1,3)) 
      local tempo = os.time()
    
    if (tempo - carro.passado) > carro.intervalo then -- tempo atual - tempo do ultimo spawn = 0
      
    
      if z == 1 then
        carro.spawn()
      elseif z == 2 then
        carro.spawn()
        carro.spawn()
      elseif z == 3 then
        carro.spawn()
        carro.spawn()
      end

      carro.passado = tempo
      if carro.intervalo < 0.8 then
        carro.intervalo = 3
      end
      carro.intervalo = carro.intervalo -0.9
    end
end


function carro.update(dt)
  if not pause.onPause and not menu.onMenu then
    carro.generator()
    carro.timer = os.time()
    if carro.timer > 10 then --sprites dinamica
      carro.timer = 0
      if carro.anim < 7 then
        carro.anim = carro.anim + 3
      else
        carro.anim = 1
      end
    end

    -- for i, v in ipairs(carro) do
    --   for j, z in ipairs(carro) do
    --     if not i == j then
    --       if colisao(v.x, v.y, carro.tileSizeRX, carro.tileSizeRY
    --                 ,z.x, z.y, carro.tileSizeRY, carro.tileSizeRY) then
    --         v.speed = 0
    --       end
    --     end
    --   end
    --    v.y = v.y + v.speed * dt;
    --    if v.y > height then 
    --     table.remove(carro, i)
    --   end


    for i = 1, #carro do 
      --nested loop
      for j = 1, #carro do
        if not i == j then -- se i n for igual a j (situaçao final)
          --checa se o carroI colide com o carroJ
          if colisao(carro[i].x, carro[i].y, carro.tileSizeRX, carro.tileSizeRY
                    ,carro[j].x, carro[j].y, carro.tileSizeRX, carro.tileSizeRY) then
            --se colidir, vel do carro i = 0
            carro[i].speed = 0
          end
        end
      end
    end

    for i, v in ipairs(carro) do 
       --somar carro.speed à carro.y
      v.y = v.y + v.speed*dt
      --se o carro passar da tela, delete o elemento carro da array
      if v.y > height then
        table.remove(carro, i)
      end
    end
    
  end

end



  function carro.draw()
      --love.graphics.draw(carro.carRed, carro.quads[1], width/2, height/2)
     
     for i = 1 , #carro do 
       love.graphics.draw(carro.carRed, carro.quads[1], carro[i].x, carro[i].y)
     end 
 

  end


return carro