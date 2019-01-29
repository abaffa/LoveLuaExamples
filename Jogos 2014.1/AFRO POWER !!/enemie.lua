require "player"

local andando = false
local atacando = false

enemie1_mov = {}
enemie1_mov[1]=love.graphics.newImage("enemies/e1R.png")
enemie1_mov[2]=love.graphics.newImage("enemies/e1-2R.png")
enemie1_mov[3]=love.graphics.newImage("enemies/e1-3R.png")
enemie1_mov[4]=love.graphics.newImage("enemies/e1-4R.png")
enemie1_mov[5]=love.graphics.newImage("enemies/e1L.png")
enemie1_mov[6]=love.graphics.newImage("enemies/e1-2L.png")
enemie1_mov[7]=love.graphics.newImage("enemies/e1-3L.png")
enemie1_mov[8]=love.graphics.newImage("enemies/e1-4L.png")

enemie1_atk = {}
enemie1_atk[1]=love.graphics.newImage("enemies/e1-atk.png")
enemie1_atk[2]=love.graphics.newImage("enemies/e1-atk2.png")
enemie1_atk[3]=love.graphics.newImage("enemies/e1-atk3.png")

enemie2_mov = {}
enemie2_mov[1]=love.graphics.newImage("enemies/e2.png")
enemie2_mov[2]=love.graphics.newImage("enemies/e2-2.png")
enemie2_mov[3]=love.graphics.newImage("enemies/e2-3.png")

enemie2_atk = {}
enemie2_atk[1]=love.graphics.newImage("enemies/e2-atk.png")
enemie2_atk[2]=love.graphics.newImage("enemies/e2-atk2.png")

enemie3_mov = {}
enemie3_mov[1]=love.graphics.newImage("enemies/e3.png")
enemie3_mov[2]=love.graphics.newImage("enemies/e3-2.png")
enemie3_mov[3]=love.graphics.newImage("enemies/e3-3.png")

enemie4_mov = {}
enemie4_mov[1]=love.graphics.newImage("itens/pedra.png")
enemie4_mov[2]=love.graphics.newImage("enemies/e4-2.png")
enemie4_mov[3]=love.graphics.newImage("enemies/e4-3.png")
enemie4_mov[4]=love.graphics.newImage("enemies/e4-4.png")
enemie4_mov[5]=love.graphics.newImage("enemies/e4.png")

enemie5_mov = {}
enemie5_mov[1]=love.graphics.newImage("enemies/e5.png")
enemie5_mov[2]=love.graphics.newImage("enemies/e5-2.png")

miniboss1_mov = {}
miniboss1_mov[1] = love.graphics.newImage("enemies/mb1.png")
miniboss1_mov[2] = love.graphics.newImage("enemies/mb1-2.png")
miniboss1_mov[3] = love.graphics.newImage("enemies/mb1-3.png")
miniboss1_mov[4] = love.graphics.newImage("enemies/mb1-4.png")
miniboss1_mov[5] = love.graphics.newImage("enemies/mb1-5.png")
miniboss1_mov[6] = love.graphics.newImage("enemies/mb1-6.png")
miniboss1_mov[7] = love.graphics.newImage("enemies/mb1-7.png")
miniboss1_mov[8] = love.graphics.newImage("enemies/mb1-8.png")

miniboss1_atk = {}
miniboss1_atk[1] = love.graphics.newImage("enemies/mb1 atk.png")
miniboss1_atk[2] = love.graphics.newImage("enemies/mb1 atk2.png")

miniboss2_mov = {}
miniboss2_mov[1] = love.graphics.newImage("enemies/mb2.png")
miniboss2_mov[2] = love.graphics.newImage("enemies/mb2-2.png")
miniboss2_mov[3] = love.graphics.newImage("enemies/mb2-3.png")

miniboss2_atk = {}
miniboss2_atk[1] = love.graphics.newImage("enemies/mb2 atk.png")
miniboss2_atk[2] = love.graphics.newImage("enemies/mb2 atk2.png")

miniboss3_mov = {}
miniboss3_mov[1] = love.graphics.newImage("enemies/mb3.png")
miniboss3_mov[2] = love.graphics.newImage("enemies/mb3-2.png")
miniboss3_mov[3] = love.graphics.newImage("enemies/mb3-3.png")

enemie = {
 speed = 110
}
miniboss1 = {
  num = 1,
  anitimer = 0,
  pic = miniboss1_mov[1],
  speed = 100
}
miniboss2 = {
  num = 1,
  anitimer = 0,
  pic = miniboss2_mov[1],
  speed = 100
}
miniboss3 = {
  num = 1,
  anitimer = 0,
  pic = miniboss3_mov[1],
  speed = 100
}
enemie1 = {
 num = 1,
 animtimer = 0,
 pic = enemie1_mov[1]
}
enemie2 = {
 num = 1,
 animtimer = 0,
 pic = enemie2_mov[1]
}
enemie3 = {
 num = 1,
 animtimer = 0,
 pic = enemie3_mov[1]
}
enemie4 = {
 num = 1,
 animtimer = 0,
 pic = enemie4_mov[1]
}
enemie5 = {
 num = 1,
 animtimer = 0,
 pic = enemie5_mov[1]
}

function enemies_update(dt)
  	enemie1.animtimer = enemie1.animtimer + dt
    enemie2.animtimer = enemie2.animtimer + dt
    enemie3.animtimer = enemie3.animtimer + dt
    enemie4.animtimer = enemie4.animtimer + dt
    enemie5.animtimer = enemie5.animtimer + dt
    miniboss1.anitimer = miniboss1.anitimer + dt
    miniboss2.anitimer = miniboss2.anitimer + dt
    miniboss3.anitimer = miniboss3.anitimer + dt
    
  	enemie1.pic = enemie1_mov[enemie1.num]
  	enemie2.pic = enemie2_mov[enemie2.num]
  	enemie3.pic = enemie3_mov[enemie3.num]
  	enemie4.pic = enemie4_mov[enemie4.num]
  	enemie5.pic = enemie5_mov[enemie5.num]
    miniboss1.pic = miniboss1_mov[miniboss1.num]
    miniboss2.pic = miniboss2_mov[miniboss2.num]
    miniboss3.pic = miniboss3_mov[miniboss3.num]
    
    if miniboss1.anitimer > 0.15 then
      miniboss1.num = miniboss1.num + 1
      miniboss1.anitimer = 0
    end
    if miniboss2.anitimer > 0.25 then
      miniboss2.num = miniboss2.num + 1
      miniboss2.anitimer = 0
    end
    if miniboss3.anitimer > 0.15 then
      miniboss3.num = miniboss3.num + 1
      miniboss3.anitimer = 0
    end
  	if enemie1.animtimer > 0.3 then
  		enemie1.num = enemie1.num + 1
      enemie1.animtimer = 0
    end
    if enemie2.animtimer > 0.25 then
  		enemie2.num = enemie2.num + 1
      enemie2.animtimer = 0
    end 
    if enemie3.animtimer > 0.09 then
  		enemie3.num = enemie3.num + 1
      enemie3.animtimer = 0
    end
    if enemie4.animtimer > 0.3 then
  		enemie4.num = enemie4.num + 1
      enemie4.animtimer = 0
    end
    if enemie5.animtimer > 0.1 then
  		enemie5.num = enemie5.num + 1
      enemie5.animtimer = 0
    end
    if enemie1.num == 9 then
  	 enemie1.num = 1
    end
    if enemie2.num == 4 then
  	 enemie2.num = 1
    end
    if enemie3.num == 4 then
  	 enemie3.num = 1
    end
    if enemie4.num == 6 then
  	 enemie4.num = 2
    end
    if enemie5.num == 3 then
     enemie5.num = 1
    end
    if miniboss1.num == 9 then
      miniboss1.num = 1
    end
    if miniboss2.num == 4 then
      miniboss2.num = 1
    end
    if miniboss3.num == 4 then
      miniboss3.num = 1
    end
end