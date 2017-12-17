spriteTime=0.28
boss={}
UpaUpa={}
airBomb={}
airBomb.time=2
airBomb.timer=0
airBomb.cap=0.5
airBomb.count=0
UpaUpa.quant=6
shadowFrame=1
shadowTime=0
explosionTime=0
explosionFrame=1
explosionSize=size/2
boss.lastAction=0
boss.laughTime=3
boss.delay=0
function boss.infoLoad()
  boss.upa=love.graphics.newImage("/Source/Doctor X/CavaloUpaUpa.png")
  boss.redX=love.graphics.newImage("/Source/Doctor X/Red_X.png")
  boss.exp=love.graphics.newImage("/Source/Doctor X/blast.png")
  boss.static=love.graphics.newImage("/Source/Doctor X/static.png")
  boss.upaWidth=boss.upa:getWidth()
  boss.upaHeight=boss.upa:getHeight()
  boss.redXWidth=boss.redX:getWidth()
  boss.redXHeight=boss.redX:getHeight()
  boss.expWidth=boss.exp:getWidth()
  boss.expHeight=boss.exp:getHeight()
  boss.staticWidth=boss.static:getWidth()
  boss.staticHeight=boss.static:getHeight()
  boss.standby={
    love.graphics.newImage("/Source/Doctor X/DoctorXleft11.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright11.png")
  }
  
  boss[1]={ --left - 1
    --normal - 1,1
    {love.graphics.newImage("/Source/Doctor X/DoctorXleft1.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft2.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft3.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft4.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft5.png")},
    --run - 1,2
    {
    love.graphics.newImage("/Source/Doctor X/DoctorXleft1.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft6.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft7.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft8.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft9.png")},
    --attack - 1,3
    {
    love.graphics.newImage("/Source/Doctor X/DoctorXleft16.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft17.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft18.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft19.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft20.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft21.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft22.png")},
    --hit - 1,4
    {
    love.graphics.newImage("/Source/Doctor X/DoctorXleft13.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft14.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft15.png")},
    --explosion 1,5
    {
    love.graphics.newImage("/Source/Doctor X/DoctorXleft24.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft25.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft26.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft27.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft28.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft29.png")},
    --laugh 1,6
    {
    love.graphics.newImage("/Source/Doctor X/DoctorXleft35.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft36.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXleft37.png")}
  }
  boss[2]={ --right 2
    --normal - 2,1
    {love.graphics.newImage("/Source/Doctor X/DoctorXright1.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright2.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright3.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright4.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright5.png")},
    --run - 2,2
    {
    love.graphics.newImage("/Source/Doctor X/DoctorXleft1.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright6.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright7.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright8.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright9.png")},
    --attack - 2,3
    {
    love.graphics.newImage("/Source/Doctor X/DoctorXright16.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright7.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright18.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright19.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright20.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright21.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright22.png")},
    --hit - 2,4
    {
    love.graphics.newImage("/Source/Doctor X/DoctorXright13.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright14.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright15.png")},
    --explosion 2,5
    {
    love.graphics.newImage("/Source/Doctor X/DoctorXright24.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright25.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright26.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright27.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright28.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright29.png")},
    --laugh 2,6
    {
    love.graphics.newImage("/Source/Doctor X/DoctorXright35.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright36.png"),
    love.graphics.newImage("/Source/Doctor X/DoctorXright37.png")}
  }
  boss.shadow={}
  boss.shadow.speed=size*8
end

function boss.load()
  for i,v in ipairs(player) do
    if i>quantPlayer then break end
    if not v.dead then
      v.x=(upperTileX+finalX)/2 + i*size
      v.y=finalY-size+5
    end
  end
  boss.inix=math.floor(tamx/2)*size+upperTileX
  boss.iniy=upperTileY
  boss.x=boss.inix
  boss.y=boss.iniy
  boss.yAdjust=-14
  boss.run=false
  boss.attack=false
  boss.explosion=false
  boss.airbomb=false
  boss.style=1
  boss.frame=1
  boss.dir=1
  boss.frametime=0
  boss.framecap=0.28
  boss.actionCount=0
  boss.timer=0
  boss.laughTimer=0
  boss.actionTime=7
  boss.speed= size*3
  boss.xvel=boss.speed
  boss.yvel=0
  boss.tipo=10
  boss.width=size-1
  boss.height=size-1
  boss.count=0
  boss.health=10
  boss.boostTime=0
  boss.invTime=0
  boss.normal=true
  boss.action=0
  boss.delayTime=1
  boss.delay=0
  boss.hurt=false
  boss.dead=false
  boss.hurtTime=0
  boss.hurtFrame=1
  boss.alert=love.audio.newSource("/Source/sounds/AlertSound.mp3")
  boss.alertTime = 0
  boss.laugh=true
  UpaUpa.create()
end

function UpaUpa.create()
  for j=0, tamy do
    for i=0, tamx do
      if (i%2==0 and j%2==0) then
        table.insert(UpaUpa,{i=i,j=j})
      end
    end
  end
end

function boss.draw()
  if boss.normal then
    boss.drawNormal()
  else
    if boss.delay>0 then
      love.graphics.draw(boss.standby[boss.dir],boss.x,boss.y+boss.yAdjust)
    else
      if boss.action==1 then
        drawShadows()
      elseif boss.action==3 then
        explosionDraw()
      end
    end
  end
  if boss.action==4 then
    airbombDraw()
  end
end

function boss.drawNormal()
  if boss.invTime>0 then
    love.graphics.setColor(255,40,40)
    love.graphics.draw(boss[boss.dir][4][1],boss.x,boss.y+boss.yAdjust)
    love.graphics.setColor(255,255,255)
  else
    love.graphics.draw(boss[boss.dir][boss.style][boss.frame],boss.x,boss.y+boss.yAdjust)
  end
  if boss.alertTime>0 then
    love.graphics.draw(enemy.alert,boss.x,boss.y-size/2,0,enemy.alertfWidth,enemy.alertfHeight)
  end
end

function boss.control(dt)
  if boss.normal then
    boss.update(dt)
  else
    if boss.delay>0 then
      boss.delay = boss.delay-dt
    else
      --ACOES PICA NO CU
      if boss.action==1 then
        replicateAttack(dt)
      elseif boss.action==2 then
        summonEnemies()
      elseif boss.action==3 then
        explosionAttack(dt)
      elseif boss.action==4 then
        boss.normal=true
      --elses para mais acoes
      end
    end
  end
  if boss.action==4 then
    airbomb(dt)
  end
end

function boss.laughAnimation(dt)
  boss.laughTimer = boss.laughTimer+dt
  boss.timer = boss.timer+dt
  if boss.timer >= boss.framecap then
    boss.frame = boss.frame + 1
    boss.timer=0
    if boss.frame > 3 then
      boss.frame=1
    end
    love.audio.play(audio.laugh)
  end
  if boss.laughTimer >= boss.laughTime then
    boss.laugh = false
    boss.timer=0
  end
end

function boss.update(dt)
  if boss.laugh then
    boss.laughAnimation(dt)
    boss.style=6
  elseif boss.hurt then
    boss.hurtAnimation(dt)
  elseif boss.dead then
    boss.deathAnimation(dt)
  else
    if boss.invTime==0 then
        player_collision(boss,boss.tipo,1,dt)
        boss.animation(dt)
        if boss.boostTime>0 then
          boss.boostTime = boss.boostTime - dt
          if boss.boostTime>0 then
            boss.xvel = boss.speed*1.5*math.sign(boss.xvel) boss.yvel = boss.speed*1.5*math.sign(boss.yvel)
            boss.style=2
            boss.framecap=0.28
          else
            boss.xvel = boss.speed*math.sign(boss.xvel) boss.yvel = boss.speed*math.sign(boss.yvel)
            boss.style=1
            boss.framecap=0.28
          end
        end
    else
      --colocar sprite de hit
      update_invincibility(boss,dt)
    end
  end
  for j,w in ipairs(player) do
      if j>quantPlayer then
        break
      end
      if not w.dead then
        enemy_collision(boss,w,j)
      end
    end
  if boss.alertTime>0 then
    boss.alertTime = boss.alertTime - dt
  end
  
  boss.timer = boss.timer + dt
  if boss.timer>=boss.actionTime then
    boss.normal = false
    boss.timer=0
    chooseAction()
  end
end

function chooseAction()
  way = math.random()%5
  if way<=1 then
    boss.action=math.random(1,4)
  else
    boss.actionCount = boss.actionCount + 1
    if boss.actionCount > 4 then
      boss.actionCount = 1
    end
    boss.action = boss.actionCount
  end
  --boss.action=4
  love.audio.play(audio.laugh)
  --boss.action=4
  boss.delay=boss.delayTime
end

function boss.animation(dt)
  boss.frametime = boss.frametime+dt
  if boss.frametime>boss.framecap then
    if boss.xvel>0 then
      framecheck(2)
    elseif boss.xvel<0 then
      framecheck(1)
    else
      boss.frame=1
    end
    boss.frametime=boss.frametime%boss.framecap
  end
end

function framecheck(dir)
  boss.frame = boss.frame + 1
  --if boss.frame==1 jogar dependendo do modo
  if boss.frame>5 then
    boss.frame=2
  end
  if boss.run then boss.style = 2 else boss.style = 1 end
  boss.dir=dir
end


--START REPLICATE ATTACK CODE
function replicateAttack(dt)
  if not boss.attack then
    createShadows()
  else
    updateShadows(dt)
  end
end

function createShadows()
  for i=upperTileY, finalY, 2*size do
    table.insert(boss.shadow,{x=upperTileX, y=i, xvel=boss.shadow.speed, yvel=0, width=size-1, height=size-1})
    table.insert(boss.shadow,{x=finalX-size, y=i, xvel=-1*boss.shadow.speed, yvel=0, width=size-1, height=size-1})
  end
  boss.attack=true
  shadowFrame=1
end

function updateShadows(dt)
  if boss.shadow[2].x<upperTileX then
    if not shadowFrameAnimation(-1,dt) then
      endShadows()
    end
  else
    if not shadowFrameAnimation(1,dt) then
      for i,v in ipairs (boss.shadow) do
        v.x = v.x + v.xvel*dt
        for j,r in ipairs (player) do
          if j>quantPlayer then
            break
          end
          if not r.dead then
            enemy_collision(v,r,j)
          end
        end
      end
    end
  end
end

function shadowFrameAnimation(mode,dt)
  if mode==1 then
    if shadowFrame>=6 then
      return false
    end
  else
    if shadowFrame<=1 then
      return false
    end
  end
  if mode==1 then
    shadowTime = shadowTime + dt
  else
    shadowTime = shadowTime + 3*dt
  end
  if shadowTime>=boss.framecap then
    shadowTime = 0
    shadowFrame = shadowFrame+mode
  end
  return true
end

function drawShadows()
  for i,v in ipairs(boss.shadow) do
    if i%2==1 then
      love.graphics.draw(boss[2][3][shadowFrame],v.x,v.y+boss.yAdjust)
    else
      love.graphics.draw(boss[1][3][shadowFrame],v.x,v.y+boss.yAdjust)
    end
  end
end

function endShadows()
  while #boss.shadow>0 do
    table.remove(boss.shadow,1)
  end
  boss.attack=false
  boss.normal=true
end
--END REPLICATE ATTACK CODE

--START SUMMON CODE
function summonEnemies()
  endTable(enemy)
  enemy.spawn(0, 0, 2, 1, 0)
  enemy.spawn(tamx, tamy, 2, -1, 0)
  boss.normal=true
  shadowFrame=1
end
--END SUMMON CODE

--START EXPLOSION CODE
function explosionAttack(dt)
  if not boss.explosion then
    love.audio.play(audio.shock)
    explosionSize=0
    boss.explosion=true
    explosionFrame=1
  else
    if not explosionFrameAnimation(dt) then
      explosionUpdate(dt)
    end
  end
end

function explosionFrameAnimation(dt)
  if explosionFrame>=6 then
    return false
  end
  explosionTime = explosionTime + dt
  if explosionTime>=boss.framecap then
    explosionTime = 0
    explosionFrame = explosionFrame+1
  end
  return true
end

function explosionDraw()
  middleX = (finalX + upperTileX)/2
  middleY = (finalY + upperTileY)/2
  love.graphics.draw(boss.exp,middleX,middleY,0,explosionSize/boss.expWidth,explosionSize/boss.expHeight,boss.expWidth/2,boss.expHeight/2)
  if explosionFrame<6 then
    love.graphics.draw(boss.static,middleX,middleY,0,1,1,boss.staticWidth/2,boss.staticHeight/2)
  end
  love.graphics.draw(boss[1][5][explosionFrame],middleX,middleY+boss.yAdjust)
end

function explosionUpdate(dt)
  explosionSize = explosionSize + size*7*dt
  middleX = (finalX + upperTileX)/2
  middleY = (finalY + upperTileY)/2
  if explosionSize >= finalX - upperTileX or explosionSize >= finalY - upperTileY then
    boss.explosion=false
    boss.normal=true
    explosionSize = 0
  else
    for i,v in ipairs(player) do
      if i>quantPlayer then
        break
      end
      if v.invTime==0 then
        if math.sqrt(math.pow(v.x-middleX,2)+math.pow(v.y-middleY,2))<=explosionSize/2 then
          bomb.kill(v, 0, i)
        end
      end
    end
  end
end
--END EXPLOSION CODE

--START AIRBOMB CODE
function airbomb(dt)
  if not boss.airbomb then
    airbombSpawn()
    airBomb.timer=0
    airBomb.count=1
    boss.airbomb=true
    love.audio.play(audio.yeeha)
  else
    airbombUpdate(dt)
    if airBomb.count < UpaUpa.quant then
      airBomb.timer = airBomb.timer + dt
      if airBomb.timer > airBomb.cap then
        airbombSpawn()
        airBomb.timer=0
        airBomb.count = airBomb.count+1
      end
    end
    if #airBomb==0 then
      boss.action=0
      boss.airbomb=false
    end
  end
end

function airbombSpawn()
  ups=table.remove(UpaUpa,math.random(1,#UpaUpa))
  table.insert(airBomb,{i=ups.i,j=ups.j,gridx=ups.i*size+upperTileX,gridy=ups.j*size+upperTileY,time=airBomb.time})
end

function airbombUpdate(dt)
  for i,v in ipairs(airBomb) do
    v.time = v.time - dt
    if v.time<=0 then
      rem=table.remove(airBomb,i)
      table.insert(UpaUpa,{i=rem.i,j=rem.j})
      table.insert(bomb,{gridx=rem.gridx,gridy=rem.gridy,x=rem.gridx+bomb.decre/2,y=rem.gridy+bomb.decre/2,explode=false,power=5,expSound=love.audio.newSource("/Source/Grenade.mp3"),time=0, ind=0})
    end
  end
end

function airbombDraw()
  redW=size/boss.redXWidth
  redH=size/boss.redXHeight
  upaW=size/boss.upaWidth
  upaH=size/boss.upaHeight
  for i,v in ipairs(airBomb) do
    love.graphics.draw(boss.redX,v.gridx,v.gridy,0,redW,redH)
    love.graphics.draw(boss.upa,v.gridx,v.gridy-v.time*300,0,upaW,upaH)
  end
end
--END AIRBOMB CODE

function boss.hurtAnimation(dt)
  
end

function boss.deathAnimation(dt)
  
end