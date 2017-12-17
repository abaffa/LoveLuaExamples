--powerUp.lua
--tipo: 1 - banana, 2 - explosion
powerUp={}
powerTipo={}
qntdTipo=3

function powerUp.infoLoad()
  for i=1, qntdTipo do
    powerTipo[i]={}
  end
  powerTipo[1].img = love.graphics.newImage("/Source/powerUpBanana.png")
  powerTipo[1].width = size/powerTipo[1].img:getWidth()
  powerTipo[1].height = size/powerTipo[1].img:getHeight()
  powerTipo[1].max = 6
  powerTipo[1].eff = 1
  powerTipo[1].prob = 0.12
  powerTipo[2].img = love.graphics.newImage("/Source/powerUpExplosion.png")
  powerTipo[2].width = size/powerTipo[2].img:getWidth()
  powerTipo[2].height = size/powerTipo[2].img:getHeight()
  powerTipo[2].max = 8
  powerTipo[2].eff = 1
  powerTipo[2].prob = 0.12
  powerTipo[3].img = love.graphics.newImage("/Source/powerUpSpeed.png")
  powerTipo[3].width = size/powerTipo[3].img:getWidth()
  powerTipo[3].height = size/powerTipo[3].img:getHeight()
  powerTipo[3].max = 144
  powerTipo[3].eff = 1.2
  powerTipo[3].prob = 0.12
  
end

function powerUp.update(dt)
  for j,w in ipairs(player) do
    if j>quantPlayer then
      break
    end
    if not w.dead then
      v,i=search_item(w.centerx,w.centery,powerUp)
      if(v~=nil) then
        powerUp.apply(v,i,w)
        return
      end
    end
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

function powerUp.apply(p,i,player)
  if p.tipo==1 then
    if(player.bombLimit<powerTipo[p.tipo].max) then
      player.bombLimit = player.bombLimit + powerTipo[p.tipo].eff
    end
  elseif   --adicionar demais powerUps
   p.tipo==2 then
    if(player.bombPower<powerTipo[p.tipo].max) then
      player.bombPower = player.bombPower + powerTipo[p.tipo].eff
      end
  elseif p.tipo==3 then
    if(player.speed<powerTipo[p.tipo].max) then
      player.speed = player.speed * powerTipo[p.tipo].eff
      end
  end
  change_space(p.gridx,p.gridy,0)
  table.remove(powerUp,i)
end

function powerUp.generate(x,y)
  if x~=exit.x or y~=exit.y then
    tipo=powerUp.rand()
    if(tipo~=nil) then
      powerUp.new(x,y,tipo)
    end
  end
end

function powerUp.rand()
  quant=#powerTipo
  for i=1,quant do
    num=math.random()
    if(num<powerTipo[i].prob) then
      return i
    end
  end
  return nil
end