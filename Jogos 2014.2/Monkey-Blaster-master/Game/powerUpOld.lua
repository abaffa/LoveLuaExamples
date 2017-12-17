--powerUp.lua
--tipo: 1 - banana, 2 - explosion
powerUp={}
powerTipo={}
qntdTipo=1

function powerUp.load()
  for i=1, qntdTipo do
    powerTipo[i]={}
  end
  powerTipo[1].img = love.graphics.newImage("/Source/powerUpBanana.png")
  powerTipo[1].width = size/powerTipo[1].img:getWidth()
  powerTipo[1].height = size/powerTipo[1].img:getHeight()
  powerTipo[1].max = 4
  powerTipo[1].eff = 1
  powerTipo[1].prob = 0.2
end

function powerUp.update(dt)
  v,i=search_item(player.centerx,player.centery,powerUp)
  if(v~=nil) then
    powerUp.apply(v,i)
  end
end

function powerUp.draw()
  for i,v in ipairs(powerUp) do
    if(solidb[v.gridx][v.gridy]==7) then
      love.graphics.setColor(240,20,20)
      love.graphics.draw(v.img, v.gridx, v.gridy, 0, v.width, v.height)
      love.graphics.setColor(255,255,255)
    else
      love.graphics.draw(v.img, v.gridx, v.gridy, 0, v.width, v.height)
    end
  end
end

function powerUp.new(x,y,tipo)
  table.insert(powerUp,{gridx=x,gridy=y,tipo=tipo,img=powerTipo[tipo].img,width=powerTipo[tipo].width,height=powerTipo[tipo].height,destroy=false})
  change_space(x,y,6)
  
end

function powerUp.apply(p,i)
  if p.tipo==1 then
    if(player.bombLimit<powerTipo[p.tipo].max) then
      player.bombLimit = player.bombLimit + powerTipo[p.tipo].eff
    end
  else  --adicionar demais powerUps
  
  end
  change_space(p.gridx,p.gridy,0)
  table.remove(powerUp,i)
end

function powerUp.generate(x,y)
  tipo=powerUp.rand()
  if(tipo~=nil) then
    powerUp.new(x,y,tipo)
  end
end

function powerUp.rand()
  num=math.random()
  for i=#powerTipo,1,-1 do
    if(num<powerTipo[i].prob) then
      return i
    end
  end
  return nil
end