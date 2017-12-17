--animation.lua
animation={}
logoDist = 0.9
letterDist = 0.03
fadeMax = 240

function animation.load(t1,t2,t3)
  animation.logo=love.graphics.newImage("/Source/logo.png")
  animation.logoWidth=animation.logo:getWidth()
  animation.logoHeight=animation.logo:getHeight()
  animation.logoX=love.graphics.getWidth()/2
  animation.logoY=2*love.graphics.getHeight()/5
  
  animation.posx=logoDist*love.graphics.getWidth()-animation.logoWidth/2
  animation.vel=(animation.posx-animation.logoX)/t2
  animation.fvel1=fadeMax/t1
  animation.fvel3=fadeMax/(0.7*t3)
  
  animation.logoLetter=love.graphics.newImage("/Source/letter.png")
  animation.logoLetterWidth=(logoDist-letterDist)*love.graphics.getWidth() - animation.logoWidth
  animation.logoLetterHeight=animation.logoLetter:getHeight()
  animation.logoLetterX=((logoDist+letterDist)*love.graphics.getWidth()-animation.logoWidth)/2
  animation.logoLetterY=2*love.graphics.getHeight()/5
  animation.logoLetterfWidth=animation.logoLetterWidth/animation.logoLetter:getWidth()
  
  animation.a1=t1
  animation.a2=t2
  animation.a3=t3
  animation.fade1=0
  animation.fade3=0
  animation.finish=false
end

function animation.update(dt)
  if animation.a3>0 then
    if animation.a2>0 then
      if animation.a1>0 then
        animation.a1 = animation.a1 - dt
        animation.fade1 = animation.fade1 + animation.fvel1 * dt
      else
        animation.a2 = animation.a2 - dt
        animation.logoX = animation.logoX + animation.vel * dt
      end
    else
      animation.a3 = animation.a3 - dt
      if animation.fade3<fadeMax then
        animation.fade3 = animation.fade3 + animation.fvel3 * dt
      end
    end
  else
    animation.finish=true
  end
end

function animation.draw()
  if animation.a3>0 and animation.a2<=0 then
      love.graphics.setColor(255,255,255,animation.fade3)
      love.graphics.draw(animation.logoLetter,animation.logoLetterX,animation.logoLetterY,0,animation.logoLetterfWidth,1,animation.logoLetter:getWidth()/2,animation.logoLetterHeight/2)
  end
  love.graphics.setColor(255,255,255,animation.fade1)
  love.graphics.draw(animation.logo,animation.logoX,animation.logoY,0,1,1,animation.logoWidth/2,animation.logoHeight/2)
end

function animation.death()
  
end

function enemyAnimation(v,dt)
    v.frametime=v.frametime+dt
    if v.xvel>0 then 
      if v.frame < v.rightI or v.frame > v.rightF then
        v.frame = v.rightI
      end
      if v.frametime > 0.28 then
        v.frametime = 0
        v.frame=v.frame+1
        if v.frame > v.rightF then
          v.frame = v.rightI
        end
      end
    
  elseif v.xvel<0 then
    if v.frame < v.leftI or v.frame >v.leftF then
      v.frame = v.leftI
    end
    if v.frametime > 0.28 then
      v.frametime = 0
      v.frame = v.frame +1
      if v.frame > v.leftF then
        v.frame =v.leftI
      end
    end
    elseif v.yvel>0 then
      if v.frame < v.downI or v.frame > v.downF then
        v.frame = v.downI
      end
      if v.frametime > 0.28 then
        v.frametime = 0
        v.frame=v.frame +1
        if v.frame>v.downF then
          v.frame = v.downI
        end
      end
    elseif v.yvel<0 then
      if v.frame < v.upI or v.frame > v.upF then
      v.frame = 10
      end
      if v.frametime > 0.28 then
        v.frametime = 0
        v.frame = v.frame + 1
        if v.frame > v.upF then
          v.frame = v.upI
        end
        end
    end
end