--ia.lua

function IA(obj, tipo, inv, player)

  if tipo==1 then if inv~=0 then IA_1(obj) end  --so rebate
  elseif tipo==2 then if inv~=0 then IA_2(obj) end  --rebate e troca
  elseif tipo==3 then IA_3(obj,inv,player) --rebate, troca e segue
  elseif tipo==4 then if inv~=0 then IA_4(obj) end  --rebate, troca e desarma
  elseif tipo==5 then IA_5(obj,inv,player) --rebate, troca, segue e desarma
  elseif tipo==6 then IA_6(obj,inv,player) --rebate, troca, segue e BOOST
  elseif tipo==7 then IA_7(obj,inv,player) --rebate, troca, seegue, desarma e BOOST  MECANICA POSSIVEL PARA BOSS
  elseif tipo==10 then IA_6(obj,inv,player)
  end
end

function IA_1(obj)
  changeWayIA(obj)
end

function IA_2(obj)
  obj.count = obj.count+1
  if(obj.count<3) then
    changeWayIA(obj)
  else
    changeDirIA(obj)
  end
end

function IA_3(obj,inv,player)
  if((not follow(obj,player)) and inv~=0) then IA_2(obj) end
end

function IA_4(obj)
  if not desarmBomb(obj) then IA_2(obj) end
end

function IA_5(obj,inv,player)
  if inv~=0 then
    if desarmBomb(obj) then
      inv=0
    end
  end
  IA_3(obj,inv,player)
end

function IA_6(obj,inv,player)
  if follow(obj,player) then
    boostSpeed(obj)
  elseif inv~=0 then
    IA_2(obj)
  end
end

function IA_7(obj,inv,player)
  if inv~=0 then
    if desarmBomb(obj) then
      inv=0
    end
  end
  IA_6(obj,inv,player)
end

function changeWayIA(obj)
  if(obj.xvel~=0) then
      obj.xvel = -1*obj.xvel
    else
      obj.yvel = -1*obj.yvel
    end
end

function changeDirIA(obj)
  i,j=check_grid_position(obj.x,obj.y)
  if(obj.xvel~=0) then
    if j<tamy then if maze[i][j+1]==0 then
      obj.yvel=math.abs(obj.xvel)
      obj.xvel=0
      obj.count=0
      return
    end end
    if j>0 then if maze[i][j-1]==0 then
      obj.yvel=-1*math.abs(obj.xvel)
      obj.count=0
      return
    end end
    changeWayIA(obj)
  else
    if i<tamx then if maze[i+1][j]==0 then
      obj.xvel=math.abs(obj.yvel)
      obj.yvel=0
      obj.count=0
      return
    end end
    if i>0 then if maze[i-1][j]==0 then
      obj.xvel=-1*math.abs(obj.yvel)
      obj.yvel=0
      obj.count=0
      return
    end end
    changeWayIA(obj)
  end
end

function IAvisionX(obj,player)
  limit = player.centerx-(player.centerx-upperTileX)%size
  direction = math.sign(player.x-obj.x)
  for i=obj.x-(obj.x-upperTileX)%size,limit,size*direction do
    if solidb[i][obj.y]~=0 then return false end
  end
  return true
end

function IAvisionY(obj,player)
  limit = player.centery-(player.centery-upperTileY)%size
  direction = math.sign(player.y-obj.y)
  for i=obj.y-(obj.y-upperTileY)%size,limit,size*direction do
    if solidb[obj.x][i]~=0 then return false end
  end
  return true
end

function desarmBomb(obj)
  a=math.sign(obj.xvel)
  b=math.sign(obj.yvel)
  v,i=search_item(obj.x+a*size, obj.y+b*size, bomb)
  if v~=nil then
    change_space(v.gridx,v.gridy,0)
    table.remove(bomb,pos)
    player[v.ind].bombQuant = player[v.ind].bombQuant-1
    love.audio.play(obj.disarm)
    return true
  end
  return false
end

function boostSpeed(obj)
  obj.boostTime=2
end

function follow(obj,player)
  a,b=check_grid_position(player.centerx,player.centery) --a=a*size+upperTileX b=b*size+upperTileY
  x,y=check_grid_position(obj.x,obj.y)
  ok=0
  if(a==x)then
    ok=1                  -- em frente/baixo
  elseif(b==y)then   --ao lado
    ok=2
  end
  if(ok~=0) then
    if (obj.x==x*size+upperTileX and obj.y==y*size+upperTileY) then
      if(ok==1)then
        if obj.yvel==0 or math.sign(player.y-obj.y)==math.sign(obj.yvel) then
          if IAvisionY(obj,player) then
            if obj.yvel==0 then
              obj.yvel=math.sign(player.y-obj.y)*math.abs(obj.xvel)
            else
              obj.yvel=math.sign(player.y-obj.y)*math.abs(obj.yvel)
            end
            obj.xvel=0
            love.audio.play(obj.alert)
            obj.alertTime=1
            return true
          end
        --elseif obj.y em direcao diferente para chase maior
        end
      elseif obj.xvel==0 or math.sign(player.x-obj.x)==math.sign(obj.xvel) then
        if IAvisionX(obj,player) then
          if obj.xvel==0 then
            obj.xvel=math.sign(player.x-obj.x)*math.abs(obj.yvel)
          else
            obj.xvel=math.sign(player.x-obj.x)*math.abs(obj.xvel)
          end
          obj.yvel=0
          love.audio.play(obj.alert)
          obj.alertTime=1
          return true
        end
      end
    end
  end
  return false
end