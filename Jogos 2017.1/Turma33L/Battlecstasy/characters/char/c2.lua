local c2 = {}
--[[ COMENTARIOS INDICADORES (INDICE) [0]

      [1] WALK FOWARD, [2] WALK BACKWARD, [3] STAND UP, [4] STAND, [5] LANDING ON GROUND, [6] LANDING, [7] JUMP FORWARD,
      [8] JUMP BACKWARD, [9] JUMP, [10] INTERFACE, [11] HIT LOW, [12] HIT HIGH, [13] HIT AIR, [14] GUARD, [15] GETTING BACK UP,
      [16] FALLING, [17] DASH FORWARD, [18] DASH BACKWARD, [19] CROUCH GUARD, [20] CROUCH, [21] NEUTRAL WEAK, [22] NEUTRAL HEAVY,
      [23] NEUTRAL MEDIUM, [24] CROUCH WEAK, [25] CROUCH MEDIUM, [26] CROUCH HEAVY, [27] AIR WEAK, [28] AIR MEDIUM, [29] AIR HEAVY,
      [30] SPECIAL, [31] SUPER.
      
      [A] c2:new(), [B] c2:update(), [C] c2:draw().
]]
local playerControl = {{"w","a","s","d","c","v","b","n","space","e"},{"i","j","k","l","9","0","-","=","p","o"}}
local Cirno2AttackBox
local Cirno2Gravity = 0.8
--local Cirno2Jump = 1.1
local Cirno2HP = 90
local Cirno2AnimationFrame ={}
local Cirno2AnimationTime
local Cirno2AnimationSize = {8,8,2,6,9,3,2,2,6,3,4,4,7,8,5,2,7,5,8,4,6,6,13,5,13,14,10,26,23,14,32,7,5}
local Cirno2_count = 1
local Cirno2_anim_type
local Cirno2State --Estado da Cirno2: 0 é normal, 1 é no ar, 2 é em hitstun, 3 é caido, 4 é guardando, 5 é atacando, 6 é atacando no ar, 7 é agachada, 8 é atacando agachada, 9 é dash
local Cirno2StageHeight
local Cirno2Charbx
local Cirno2Charby
local Cirno2XSpeed
local Cirno2YSpeed
local Cirno2_sprite
local Cirno2_sprite2
local Cirno2GenericVariable
local Cirno2GenericVariableAtk
local Cirno2Attacktype
local Cirno2SpecialEffects
local Cirno2SpecialEffectX
local Cirno2SpecialEffectY
local Cirno2Guardtype
local Cirno2_hitboxX
local Cirno2_hitboxY
local Cirno2_crouchvar
local Cirno2_pl = 0

function c2:new(pos_chao, prop, extraX, extraY, playerNum) --[A]
  Cirno2_sprite = 1
  Cirno2_sprite2 = 1
  Cirno2XSpeed = 0
  Cirno2YSpeed = 0
  Cirno2GenericVariable = 0
  Cirno2GenericVariableAtk = 0
  Cirno2Attacktype = 0
  Cirno2SpecialEffects =0
  Cirno2SpecialEffectX =0
  Cirno2SpecialEffectY =0
  Cirno2Guardtype=0
  Cirno2_hitboxX=65
  Cirno2_hitboxY=80
  Cirno2_crouchvar=0
  Cirno2_anim_type=4
  Cirno2State=0
  Cirno2AnimationTime = 0
  Cirno2AttackBox = {0,0,0,0}
  Cirno2_pl = playerNum
  Cirno2Charbx=700
  for i=1,33 do
    Cirno2AnimationFrame[i] = {}
    for j=1,Cirno2AnimationSize[i] do
      Cirno2AnimationFrame[i][j]=love.graphics.newImage("characters/char/Cirno/Cirno"..Cirno2_count..".png")
      Cirno2_count=Cirno2_count+1
    end
  end
  Cirno2StageHeight = pos_chao - Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getHeight() -- Alterado por pos_chao. Crie uma variável pos_chao na main e coloque assim: "Cirno2:new(pos_chao)"
  Cirno2Charby = Cirno2StageHeight
  Cirno2_count=1
  return {extraX+Cirno2Charbx*prop, extraY+Cirno2Charby*prop, Cirno2_hitboxX*prop, Cirno2_hitboxY*prop}, {extraX+(Cirno2Charbx+10)*prop, extraY+(Cirno2Charby+5)*prop, (Cirno2_hitboxX-20)*prop, (Cirno2_hitboxY-10)*prop}
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2WalkForward(dt) --[1]
  Cirno2_anim_type=1
  Cirno2XSpeed=120
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.15 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 8 then
    Cirno2_sprite= 1
    Cirno2XSpeed=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2WalkBackward(dt) --[2]
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  Cirno2_anim_type=2
  Cirno2XSpeed=-120
  if Cirno2AnimationTime > 0.15 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 8 then
    Cirno2_sprite= 1
    Cirno2XSpeed=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2StandUp(dt) --[3]
  if Cirno2GenericVariable==0 then
    Cirno2_sprite=1
    Cirno2GenericVariable=1
  end
  Cirno2_anim_type=3
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.15 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 2 then
    Cirno2_sprite= 1
    Cirno2State=0
    Cirno2GenericVariable=0
    Cirno2_crouchvar=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2Stand(dt) --[4]
  Cirno2XSpeed=0
  Cirno2_anim_type=4
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.15 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 6 then
    Cirno2_sprite= 1
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2Landing(dt) --[6]
  Cirno2XSpeed=0
  if Cirno2GenericVariable==0 then
    Cirno2_sprite=1
    Cirno2GenericVariable=1
  end
  Cirno2_anim_type=6
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.10 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 3 then
    Cirno2_sprite= 1
    Cirno2State=0
    Cirno2GenericVariable=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2LandingOnGround(dt) --[5]
  Cirno2_anim_type=5
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.15 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 9 then
    Cirno2_sprite=9
    Cirno2State=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2JumpForward(dt) --[7]
  if Cirno2State==0 then
    Cirno2YSpeed=-400
  end
  Cirno2State=1
  Cirno2_anim_type=7
  Cirno2XSpeed=120
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.10 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 2 then
    Cirno2_sprite=1
    Cirno2XSpeed=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2JumpBackward(dt)--[8]
  if Cirno2State==0 then
    Cirno2YSpeed=-400
  end
  Cirno2State=1
  Cirno2_anim_type=8
  Cirno2XSpeed=-120
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.10 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 2 then
    Cirno2_sprite=1
    Cirno2XSpeed=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2Jump(dt) --[9]
  Cirno2XSpeed=0
  if Cirno2State==0 then
    Cirno2YSpeed=-400
  end
  Cirno2State=1
  Cirno2_anim_type=9
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.15 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 6 then
    Cirno2_sprite=6
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2HitLow(dt) --[11]
  Cirno2State=2
  Cirno2_anim_type=11
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.15 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 4 then
    Cirno2_sprite=1
    Cirno2State=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2HitHigh(dt) --[12]
  Cirno2State=2
  Cirno2_anim_type=12
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.15 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 4 then
    Cirno2_sprite=1
    Cirno2State=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2HitAir(dt) --[13]
  Cirno2State=2
  Cirno2_anim_type=13
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.15 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 7 then
    Cirno2_sprite=7
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2Guard(dt, Cirno2side) --[14]
  Cirno2SpecialEffects=9
  Cirno2SpecialEffectX=50
  if Cirno2GenericVariable==0 then
    Cirno2_sprite2=5
    Cirno2GenericVariable=1
  end
  Cirno2State=4
  Cirno2Guardtype=0
  Cirno2XSpeed=0
  Cirno2_anim_type=14
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.15 then
    Cirno2_sprite=Cirno2_sprite+1
    if Cirno2GenericVariable==0 then
      Cirno2_sprite2=5
      Cirno2GenericVariable=1
    end
    Cirno2_sprite2=Cirno2_sprite2+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 2 and Cirno2GenericVariable==1 then
    Cirno2_sprite=1
  end
  if Cirno2_sprite2>8 then
    Cirno2_sprite2=5
  end
  if love.keyboard.isDown(playerControl[Cirno2_pl][3]) then
    Cirno2CrouchGuard(dt)
  end
  if not love.keyboard.isDown(playerControl[Cirno2_pl][-Cirno2side+3]) then
    Cirno2GenericVariable=2
  end
  if Cirno2_sprite>3 then
    Cirno2_sprite=1
    Cirno2_sprite2=1
    Cirno2State=0
    Cirno2Guardtype=0
    Cirno2SpecialEffects=0
    Cirno2SpecialEffectX=0
    Cirno2GenericVariable=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2GettingBackUp(dt) --[15]
  Cirno2_anim_type=15
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.15 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 5 then
    Cirno2_sprite=1
    Cirno2State=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2Falling(dt, Cirno2side) --[16]
  Cirno2_anim_type=16
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.10 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 2 then
    Cirno2_sprite=1
  end
  if love.keyboard.isDown(playerControl[Cirno2_pl][Cirno2side+3]) then
    Cirno2XSpeed=120
  elseif love.keyboard.isDown(playerControl[Cirno2_pl][-Cirno2side+3]) then
    Cirno2XSpeed=-120
  else Cirno2XSpeed=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2DashForward(dt, Cirno2side) --[17]
  Cirno2State=9
  Cirno2_anim_type=17
  Cirno2XSpeed=0
  if Cirno2GenericVariable==0 then
    Cirno2_sprite=1
    Cirno2GenericVariable=1
  end
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.15 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 2 then
    Cirno2XSpeed=240
  end
  if Cirno2_sprite > 6 and love.keyboard.isDown(playerControl[Cirno2_pl][10]) and love.keyboard.isDown(playerControl[Cirno2_pl][Cirno2side+3]) then
    Cirno2_sprite=3
  elseif Cirno2_sprite>6 then
    Cirno2XSpeed=0
  end
  if not love.keyboard.isDown(playerControl[Cirno2_pl][10]) or not love.keyboard.isDown(playerControl[Cirno2_pl][Cirno2side+3]) then
    if Cirno2_sprite < 7 then
      Cirno2_sprite=7
    end
  end
  if Cirno2_sprite > 7 then
    Cirno2_sprite=1
    Cirno2GenericVariable=0
    Cirno2XSpeed=0
    Cirno2State=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2DashBackward(dt, Cirno2side) --[18]
  Cirno2State=9
  Cirno2_anim_type=18
  Cirno2XSpeed=0
  if Cirno2GenericVariable==0 then
    Cirno2_sprite=1
    Cirno2GenericVariable=2
  end
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.15 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 0 then
    Cirno2XSpeed=-240
  end
  if Cirno2_sprite > 4 and love.keyboard.isDown(playerControl[Cirno2_pl][10]) and love.keyboard.isDown(playerControl[Cirno2_pl][-Cirno2side+3]) then
    Cirno2_sprite=1
  elseif Cirno2_sprite>4 then
    Cirno2XSpeed=0
  end
  if not love.keyboard.isDown(playerControl[Cirno2_pl][10]) or not love.keyboard.isDown(playerControl[Cirno2_pl][-Cirno2side+3]) then
    if Cirno2_sprite < 5 then
      Cirno2_sprite=5
    end
  end
  if Cirno2_sprite > 5 then
    Cirno2_sprite=1
    Cirno2GenericVariable=0
    Cirno2XSpeed=0
    Cirno2State=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2CrouchGuard(dt, Cirno2side) --[19]
  Cirno2SpecialEffects=9
  if Cirno2GenericVariable==0 then
    Cirno2_sprite2=5
    Cirno2GenericVariable=1
  end
  Cirno2SpecialEffectX=50
  Cirno2State=4
  Cirno2Guardtype=1
  Cirno2XSpeed=0
  Cirno2_anim_type=19
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.15 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2_sprite2=Cirno2_sprite2+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 2 and Cirno2GenericVariable==1 then
    Cirno2_sprite=1
  end
  if Cirno2_sprite2>8 then
    Cirno2_sprite2=5
  end
  if not love.keyboard.isDown(playerControl[Cirno2_pl][-Cirno2side+3]) then
    Cirno2GenericVariable=2
  end
  if not love.keyboard.isDown(playerControl[Cirno2_pl][3]) then
    Cirno2Guard(dt)
  end
  if Cirno2_sprite>3 then
    Cirno2_sprite=1
    Cirno2_sprite2=1
    Cirno2State=0
    Cirno2Guardtype=0
    Cirno2SpecialEffects=0
    Cirno2SpecialEffectX=0
    Cirno2GenericVariable=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2Crouch(dt) --[20]
  if Cirno2_crouchvar==1 then
    Cirno2_sprite=4
  end
  Cirno2XSpeed=0
  Cirno2State=7
  Cirno2_anim_type=20
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.15 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite>3 then
    Cirno2_sprite=4
    Cirno2_crouchvar=1
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2NeutralWeak(dt) --[21]
  Cirno2XSpeed=0
  if Cirno2GenericVariableAtk==0 then
    Cirno2_sprite=1
    Cirno2GenericVariableAtk=1
  end
  Cirno2SpecialEffects=10
  Cirno2Attacktype=1
  Cirno2State=5
  Cirno2_anim_type=21
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.05 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 6 then
    Cirno2_sprite=1
    Cirno2State=0
    Cirno2Attacktype=0
    Cirno2GenericVariableAtk=0
    Cirno2SpecialEffects=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2NeutralHeavy(dt) --[22]
  Cirno2XSpeed=0
  if Cirno2GenericVariableAtk==0 then
    Cirno2_sprite=1
    Cirno2GenericVariableAtk=1
  end
  Cirno2Attacktype=3
  Cirno2State=5
  Cirno2_anim_type=22
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.10 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 4 then
    Cirno2SpecialEffects=1
    Cirno2_sprite2=6
    Cirno2GenericVariable=Cirno2GenericVariable+5*dt
    Cirno2XSpeed=500
  end
  if Cirno2_sprite > 5 then
    Cirno2_sprite = 5
  end
  if Cirno2GenericVariable>3 then
    Cirno2XSpeed=0
    Cirno2SpecialEffects=0
    Cirno2_sprite=1
    Cirno2State=0
    Cirno2Attacktype=0
    Cirno2GenericVariableAtk=0
    Cirno2GenericVariable=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2NeutralMedium(dt) --[23]
  Cirno2XSpeed=0
  if Cirno2GenericVariableAtk==0 then
    Cirno2_sprite=1
    Cirno2GenericVariableAtk=1
  end
  Cirno2Attacktype=2
  Cirno2State=5
  Cirno2_anim_type=23
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.10 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite >3 then
    Cirno2SpecialEffectX=25
    Cirno2SpecialEffectY=-10
    Cirno2SpecialEffects=3
    Cirno2_sprite2=12
  end
  if Cirno2_sprite >5 then
    Cirno2SpecialEffects=0
  end
  if Cirno2_sprite > 11 then
    Cirno2_sprite=1
    Cirno2_sprite2=1
    Cirno2State=0
    Cirno2Attacktype=0
    Cirno2GenericVariableAtk=0
    Cirno2GenericVariable=0
    Cirno2SpecialEffectX=0
    Cirno2SpecialEffectY=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2CrouchingWeak(dt) --[24]
  Cirno2XSpeed=0
  if Cirno2GenericVariableAtk==0 then
    Cirno2_sprite=1
    Cirno2GenericVariableAtk=1
  end
  Cirno2Attacktype=1
  Cirno2SpecialEffects=11
  Cirno2State=8
  Cirno2_anim_type=24
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.05 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 5 then
    Cirno2_sprite=4
    Cirno2SpecialEffects=0
    Cirno2State=7
    Cirno2Attacktype=0
    Cirno2GenericVariableAtk=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2CrouchingMedium(dt) --[25]
  Cirno2XSpeed=0
  if Cirno2GenericVariableAtk==0 then
    Cirno2_sprite=1
    Cirno2GenericVariableAtk=1
  end
  Cirno2Attacktype=2
  Cirno2State=8
  Cirno2_anim_type=25
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.125 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite>=2 then
    Cirno2SpecialEffects=4
    Cirno2GenericVariable=Cirno2GenericVariable+7.5*dt
    Cirno2_sprite2=11
    Cirno2SpecialEffectX=110
    Cirno2SpecialEffectY=40
    Cirno2XSpeed=150
  end
  if not love.keyboard.isDown(playerControl[Cirno2_pl][6]) then
    Cirno2_sprite=1
    Cirno2State=7
    Cirno2Attacktype=0
    Cirno2GenericVariableAtk=0
    Cirno2SpecialEffects=0
    Cirno2GenericVariable=0
    Cirno2SpecialEffectX=0
    Cirno2SpecialEffectY=0
    Cirno2XSpeed=0
  end
  if Cirno2_sprite>10 and love.keyboard.isDown(playerControl[Cirno2_pl][6]) then
    Cirno2_sprite=2
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2CrouchingHeavy(dt, Cirno2side) --[26]
  Cirno2XSpeed=0
  if Cirno2GenericVariableAtk==0 then
    Cirno2_sprite=1
    Cirno2GenericVariableAtk=1
  end
  Cirno2Attacktype=3
  Cirno2State=8
  Cirno2_anim_type=26
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.10 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite >3 then
    Cirno2SpecialEffects=2
    Cirno2SpecialEffectY=-80
    Cirno2_sprite2=14
    Cirno2XSpeed=100
    Cirno2GenericVariable=Cirno2GenericVariable+2*dt
    if Cirno2GenericVariable<1 and Cirno2_sprite>8 then
      Cirno2_sprite=8
    end
  end
  if Cirno2_sprite==6 then
    Cirno2SpecialEffectX=70-10*Cirno2side
    Cirno2SpecialEffectY=-60
  end
  if Cirno2_sprite>6 then
    Cirno2SpecialEffectX=60+20*Cirno2side
    Cirno2SpecialEffectY=0
    Cirno2Charby=Cirno2Charby+30
  end
  if Cirno2_sprite>8 then
    Cirno2XSpeed=0
    Cirno2SpecialEffects=0
  end
  if Cirno2_sprite>9 then
   Cirno2Charby=Cirno2Charby-30
  end
  if Cirno2_sprite > 13 then
    Cirno2_sprite=1
    Cirno2State=7
    Cirno2Attacktype=0
    Cirno2GenericVariableAtk=0
    Cirno2GenericVariable=0
    Cirno2SpecialEffectX=0
    Cirno2SpecialEffectY=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2AirWeak(dt) --[27]
  if Cirno2GenericVariableAtk==0 then
    Cirno2_sprite=1
    Cirno2GenericVariableAtk=1
  end
  Cirno2Attacktype=1
  Cirno2State=6
  Cirno2SpecialEffects=12
  Cirno2_anim_type=27
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.05 then
    Cirno2_sprite=Cirno2_sprite+1
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite > 10 then
    Cirno2_sprite=1
    Cirno2SpecialEffects=0
    Cirno2Attacktype=0
    Cirno2GenericVariableAtk=0
    Cirno2State=1
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2AirMedium(dt) --[28]
  if Cirno2GenericVariableAtk==0 then
    Cirno2_sprite=1
    Cirno2_sprite2=8
    Cirno2GenericVariableAtk=1
  end
  Cirno2Attacktype=2
  Cirno2State=6
  Cirno2_anim_type=28
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.05 then
    Cirno2_sprite=Cirno2_sprite+1
    if Cirno2_sprite>5 then
      Cirno2_sprite2=Cirno2_sprite2+1
    end
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite>5 then
    Cirno2SpecialEffects=5
    Cirno2SpecialEffectX=130
  end
  if Cirno2_sprite>7 and Cirno2GenericVariable==0 then
    Cirno2_sprite=7
  end
  if Cirno2_sprite2>26 then
    Cirno2SpecialEffects=0
    Cirno2GenericVariable=1
  end
  if Cirno2_sprite > 8 then
    Cirno2_sprite=1
    Cirno2Attacktype=0
    Cirno2GenericVariableAtk=0
    Cirno2_sprite2=0
    Cirno2GenericVariable=0
    Cirno2SpecialEffects=0
    Cirno2SpecialEffectX=0
    Cirno2State=1
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2AirHeavy(dt) --[29]
  if Cirno2GenericVariableAtk==0 then
    Cirno2_sprite=1
    Cirno2_sprite2=18
    Cirno2GenericVariableAtk=1
  end
  Cirno2Attacktype=3
  Cirno2State=6
  Cirno2_anim_type=29
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.08 then
    Cirno2_sprite=Cirno2_sprite+1
    if Cirno2_sprite>4 and Cirno2_sprite<12 then
      Cirno2GenericVariable=Cirno2GenericVariable+math.pi/4
    end
    if Cirno2_sprite>12 then
      Cirno2SpecialEffectX=60
      Cirno2SpecialEffectY=40
      Cirno2_sprite2=Cirno2_sprite2+1
    end
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite>1 then
    Cirno2SpecialEffects=6
    if Cirno2GenericVariableAtk==1 then
      Cirno2SpecialEffectX=30
      Cirno2SpecialEffectY=-30
      Cirno2GenericVariableAtk=2
    end
  end
  if Cirno2_sprite>4 and Cirno2_sprite<12 then
    if Cirno2GenericVariableAtk==2 then
      Cirno2_sprite2=17
      Cirno2GenericVariableAtk=3
    end
    Cirno2SpecialEffectX=math.cos(Cirno2GenericVariable)*30
    Cirno2SpecialEffectY=math.sin(Cirno2GenericVariable)*30
  end
  if Cirno2_sprite==12 then
    Cirno2GenericVariable=0
    Cirno2_sprite2=18
    Cirno2SpecialEffectX=30
    Cirno2SpecialEffectY=-10
  end
  if Cirno2_sprite>15 and Cirno2GenericVariable==1 then
    Cirno2_sprite=15
  end
  if Cirno2_sprite2>23 then
    Cirno2GenericVariable=2
  end
  if Cirno2_sprite > 16 then
    Cirno2_sprite=1
    Cirno2Attacktype=0
    Cirno2GenericVariableAtk=0
    Cirno2SpecialEffects=0
    Cirno2SpecialEffectX=0
    Cirno2SpecialEffectY=0
    Cirno2_sprite2=0
    Cirno2GenericVariable=0
    Cirno2State=1
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2Special(dt) --[30]
  if Cirno2GenericVariableAtk==0 then
    Cirno2_sprite=1
    Cirno2GenericVariableAtk=1
  end
  Cirno2XSpeed=0
  Cirno2SpecialEffects=7
  Cirno2Attacktype=4
  Cirno2State=5
  Cirno2_anim_type=30
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.15 then
    Cirno2_sprite=Cirno2_sprite+1
    if Cirno2GenericVariable==1 then
      Cirno2_sprite2=Cirno2_sprite2+1
    end
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite<5 then
    Cirno2_sprite2=9
    Cirno2SpecialEffectX=-50
    Cirno2SpecialEffectY=0
  end
  if Cirno2_sprite>4 and Cirno2GenericVariable==0 then
    Cirno2_sprite2=10
    Cirno2GenericVariable=1
    Cirno2SpecialEffectX=100
    Cirno2SpecialEffectY=-50
  end
  if Cirno2_sprite>7 and Cirno2GenericVariable==1 then
    Cirno2_sprite=7
  end
  if Cirno2_sprite2>14 then
    Cirno2GenericVariable=2
    Cirno2SpecialEffects=0
  end
  if Cirno2_sprite > 8 then
    Cirno2_sprite=1
    Cirno2State=0
    Cirno2Attacktype=0
    Cirno2GenericVariableAtk=0
    Cirno2SpecialEffects=0
    Cirno2SpecialEffectX=0
    Cirno2SpecialEffectY=0
    Cirno2_sprite2=0
    Cirno2GenericVariable=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function Cirno2Super(dt) --[31]
  if Cirno2GenericVariableAtk==0 then
    Cirno2_sprite=1
    Cirno2GenericVariableAtk=1
  end
  Cirno2XSpeed=0
  Cirno2Attacktype=5
  Cirno2State=5
  Cirno2_anim_type=31
  Cirno2AnimationTime=Cirno2AnimationTime+dt
  if Cirno2AnimationTime > 0.10 then
    Cirno2_sprite=Cirno2_sprite+1
    if Cirno2_sprite>7 then
      if Cirno2GenericVariable == 0 then
        Cirno2_sprite2=13
        Cirno2GenericVariable=1
      end
      Cirno2SpecialEffects=8
      Cirno2SpecialEffectX=130
      Cirno2_sprite2=Cirno2_sprite2+1
    end
    Cirno2AnimationTime = 0
  end
  if Cirno2_sprite>9 and Cirno2GenericVariable==1 then
    Cirno2_sprite=9
  end
  if Cirno2_sprite2>30 then
    Cirno2SpecialEffects=0
    Cirno2GenericVariable=2
  end
  if Cirno2_sprite > 12 then
    Cirno2_sprite=1
    Cirno2Attacktype=0
    Cirno2State=0
    Cirno2GenericVariableAtk=0
    Cirno2_sprite2=0
    Cirno2GenericVariable=0
    Cirno2SpecialEffects=0
    Cirno2SpecialEffectX=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function c2:update(dt, prop, extraX, extraY, Cirno2EnemyState, Cirno2side, winner) --[B]
  --MOVEMENT SYSTEM-- BEGIN
  Cirno2Charbx=Cirno2Charbx+Cirno2side*Cirno2XSpeed*dt
  Cirno2Charby=Cirno2Charby+Cirno2YSpeed*dt+Cirno2Gravity*250*math.pow(dt,2)
  Cirno2YSpeed=Cirno2YSpeed+Cirno2Gravity*500*dt
  if Cirno2Charby>Cirno2StageHeight-20 then
    Cirno2Charby=Cirno2StageHeight-20
    Cirno2YSpeed=0
    if Cirno2State==1 or Cirno2State==6 then
      Cirno2Landing(dt)
      Cirno2Attacktype=0
      Cirno2_sprite2=0
      Cirno2SpecialEffects=0
      Cirno2GenericVariableAtk=0
      Cirno2SpecialEffects=0
      Cirno2SpecialEffectX=0
      Cirno2SpecialEffectY=0
    elseif Cirno2_crouchvar==1 then
      Cirno2Charby=Cirno2StageHeight
    end
  end
  --MOVEMENT SYSTEM-- END
  
  if winner == 0 then
    if Cirno2State == 0 then
      if love.keyboard.isDown(playerControl[Cirno2_pl][5]) then
        Cirno2NeutralWeak(dt) --[21]
      elseif love.keyboard.isDown(playerControl[Cirno2_pl][6]) then
        Cirno2NeutralMedium(dt) --[23]
      elseif love.keyboard.isDown(playerControl[Cirno2_pl][7]) then
        Cirno2NeutralHeavy(dt) --[22]
      elseif love.keyboard.isDown(playerControl[Cirno2_pl][8]) then
        Cirno2Special(dt) --[30]
      elseif love.keyboard.isDown(playerControl[Cirno2_pl][9]) then
        Cirno2Super(dt) --[31]
      elseif love.keyboard.isDown(playerControl[Cirno2_pl][Cirno2side+3]) then
        Cirno2WalkForward(dt) --[1]
        if love.keyboard.isDown(playerControl[Cirno2_pl][1]) then
          Cirno2_sprite=1
          Cirno2JumpForward(dt) --[7]
        elseif love.keyboard.isDown(playerControl[Cirno2_pl][10]) then
          Cirno2DashForward(dt, Cirno2side) --[17]
        end
      elseif love.keyboard.isDown(playerControl[Cirno2_pl][-Cirno2side+3]) then
        Cirno2WalkBackward(dt) --[2]
        if love.keyboard.isDown(playerControl[Cirno2_pl][1]) then
          Cirno2_sprite=1
          Cirno2JumpBackward(dt) --[8]
        elseif love.keyboard.isDown(playerControl[Cirno2_pl][10]) then
          Cirno2DashBackward(dt, Cirno2side) --[18]
        end
      elseif love.keyboard.isDown(playerControl[Cirno2_pl][3]) then
        Cirno2_sprite=1
        Cirno2Crouch(dt) --[20]
      elseif love.keyboard.isDown(playerControl[Cirno2_pl][1]) then
        Cirno2_sprite=1
        Cirno2Jump(dt) --[9]
      else
        Cirno2Stand(dt) --[4]
      end
    elseif Cirno2State == 1 then
      if Cirno2YSpeed<0 then
        if love.keyboard.isDown(playerControl[Cirno2_pl][-Cirno2side+3]) then
          Cirno2JumpBackward(dt) --[8]
        elseif love.keyboard.isDown(playerControl[Cirno2_pl][Cirno2side+3]) then
          Cirno2JumpForward(dt) --[7]
        else Cirno2Jump(dt) --[9]
        end
      end
      if Cirno2YSpeed>0 then
        Cirno2Falling(dt, Cirno2side) --[16]
      end
      if love.keyboard.isDown(playerControl[Cirno2_pl][5]) then
        Cirno2AirWeak(dt) --[27]
      elseif love.keyboard.isDown(playerControl[Cirno2_pl][6]) then
        Cirno2AirMedium(dt) --[28]
      elseif love.keyboard.isDown(playerControl[Cirno2_pl][7]) then
        Cirno2AirHeavy(dt) --[29]
      end
    elseif Cirno2State == 3 then
      if love.keyboard.isDown(playerControl[Cirno2_pl][1]) then
        Cirno2GettingBackUp(dt) --[15]
      end
    elseif Cirno2State==4 then
      if Cirno2Guardtype==0 then
        Cirno2Guard(dt, Cirno2side) --[14]
      elseif Cirno2Guardtype==1 then
        Cirno2Charby=Cirno2StageHeight
        Cirno2CrouchGuard(dt, Cirno2side) --[19]
      end
    elseif Cirno2State == 5 then
      if Cirno2Attacktype == 1 then
        Cirno2NeutralWeak(dt) --[21]
      elseif Cirno2Attacktype == 2 then
        Cirno2NeutralMedium(dt) --[23]
      elseif Cirno2Attacktype == 3 then
        Cirno2NeutralHeavy(dt) --[22]
      elseif Cirno2Attacktype == 4 then
        Cirno2Special(dt) --[30]
      elseif Cirno2Attacktype == 5 then
        Cirno2Super(dt) --[31]
      end
    elseif Cirno2State == 6 then
      if Cirno2Attacktype == 1 then
        Cirno2AirWeak(dt) --[27]
      elseif Cirno2Attacktype == 2 then
        Cirno2AirMedium(dt) --[28]
      elseif Cirno2Attacktype == 3 then
        Cirno2AirHeavy(dt) --[29]
      end
    elseif Cirno2State==8 then
      if Cirno2Attacktype == 1 then
        Cirno2CrouchingWeak(dt) --[24]
      elseif Cirno2Attacktype == 2 then
        Cirno2CrouchingMedium(dt) --[25]
      elseif Cirno2Attacktype == 3 then
        Cirno2CrouchingHeavy(dt, Cirno2side) --[26]
      end
    elseif Cirno2State == 7 then
      if love.keyboard.isDown(playerControl[Cirno2_pl][3]) then
        Cirno2Crouch(dt) --[20]
        if Cirno2_crouchvar==1 then
          if love.keyboard.isDown(playerControl[Cirno2_pl][5]) then
            Cirno2CrouchingWeak(dt) --[24]
          elseif love.keyboard.isDown(playerControl[Cirno2_pl][6]) then
            Cirno2CrouchingMedium(dt) --[25]
          elseif love.keyboard.isDown(playerControl[Cirno2_pl][7]) then
            Cirno2CrouchingHeavy(dt, Cirno2side) --[26]
          end
        end
      else
        Cirno2StandUp(dt) --[3]
      end
    elseif Cirno2State==9 then
      if Cirno2GenericVariable==1 then
        Cirno2DashForward(dt, Cirno2side) --[17]
      elseif Cirno2GenericVariable==2 then
        Cirno2DashBackward(dt, Cirno2side) --[18]
      end
    end
    if Cirno2EnemyState==5 or Cirno2EnemyState==6 or Cirno2EnemyState==8 then
      if love.keyboard.isDown(playerControl[Cirno2_pl][-Cirno2side+3]) and Cirno2State==0 then
        Cirno2Guard(dt, Cirno2side) --[14]
      elseif love.keyboard.isDown(playerControl[Cirno2_pl][-Cirno2side+3]) and Cirno2State==7 then
        Cirno2CrouchGuard(dt, Cirno2side) --[19]
      end
    end
  else
    if Cirno2_pl == winner then
      if Cirno2GenericVariable == 0 then
        Cirno2_sprite = 1
        Cirno2_sprite2 = 0
        Cirno2GenericVariable = 1
      end
      Cirno2Charbx = 600
      Cirno2Charby = Cirno2StageHeight-20
      Cirno2_anim_type = 32
      Cirno2XSpeed=0
      Cirno2State=0
      Cirno2AnimationTime=Cirno2AnimationTime+dt
      if Cirno2AnimationTime > 0.10 then
        Cirno2_sprite=Cirno2_sprite+1
        Cirno2AnimationTime = 0
        if Cirno2_sprite2~=0 then
          Cirno2_sprite2=Cirno2_sprite2+1
        end
      end
      if Cirno2_sprite > 2 and Cirno2_sprite2==0 then
        Cirno2SpecialEffects = 13
        Cirno2SpecialEffectX = Cirno2Charbx
        Cirno2SpecialEffectY = Cirno2Charby-70
        Cirno2_sprite2 = 5
      end
      if Cirno2_sprite>4 then
        Cirno2_sprite = 3
      end
      if Cirno2_sprite2>7 then
        Cirno2_sprite2 = 5
      end
    else
      if Cirno2GenericVariable == 0 then
        Cirno2_sprite = 1
        Cirno2GenericVariable = 1
      end
      Cirno2Charbx = 600
      Cirno2Charby = Cirno2StageHeight+20
      Cirno2_anim_type = 33
      Cirno2SpecialEffects = 0
      Cirno2XSpeed=0
      Cirno2State=0
      Cirno2AnimationTime=Cirno2AnimationTime+dt
      if Cirno2AnimationTime > 0.10 then
        Cirno2_sprite=Cirno2_sprite+1
        Cirno2AnimationTime = 0
      end
      if Cirno2_sprite > 5 then
        Cirno2_sprite = 5
      end
    end
  end
  return extraX+Cirno2Charbx*prop, extraY+Cirno2Charby*prop, extraX+(Cirno2Charbx+10)*prop, extraY+(Cirno2Charby+5)*prop, Cirno2_hitboxX*prop, Cirno2_hitboxY*prop, Cirno2State, extraX+(Cirno2Charbx+Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getWidth())*prop, Cirno2SpecialEffects, Cirno2AttackBox
end
--------------------------------------------------------------------------------------------
function c2:draw(prop, extraX, extraY, charX, charY, Cirno2side) --[C]
  Cirno2Charbx = (charX-extraX)/prop
  Cirno2Charby = (charY-extraY)/prop
  if Cirno2SpecialEffects==1 then --[22]
    love.graphics.draw(Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2], extraX+Cirno2Charbx*prop, extraY+Cirno2Charby*prop, 0, Cirno2side*prop, prop, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getWidth()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getWidth())/2, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getHeight()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getHeight())/2)
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX+(Cirno2Charbx-75)*prop, extraY+(Cirno2Charby-60)*prop, (Cirno2_hitboxX+150)*prop, (Cirno2_hitboxY+100)*prop)
    Cirno2AttackBox = {extraX+(Cirno2Charbx-75)*prop, extraY+(Cirno2Charby-60)*prop, (Cirno2_hitboxX+150)*prop, (Cirno2_hitboxY+100)*prop}
    love.graphics.setColor(255,255,255)

  elseif Cirno2SpecialEffects==2 then --[26]
    love.graphics.draw(Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2], extraX+(Cirno2Charbx+Cirno2SpecialEffectX)*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY)*prop, 0, Cirno2side*prop, prop, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getWidth()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getWidth())/2, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getHeight()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getHeight())/2)
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX+(Cirno2Charbx+Cirno2side*(Cirno2SpecialEffectX-15))*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY-15)*prop, (Cirno2_hitboxX+30)*prop, (Cirno2_hitboxY+30)*prop)
    Cirno2AttackBox = {extraX+(Cirno2Charbx+Cirno2side*(Cirno2SpecialEffectX-15))*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY-15)*prop, (Cirno2_hitboxX+30)*prop, (Cirno2_hitboxY+30)*prop}
    love.graphics.setColor(255,255,255)

  elseif Cirno2SpecialEffects==3 then --[23]
    love.graphics.draw(Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2], extraX+(Cirno2Charbx+Cirno2SpecialEffectX)*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY)*prop, 0, Cirno2side*0.6*prop, 0.6*prop, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getWidth()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getWidth())/2, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getHeight()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getHeight())/2)
    love.graphics.draw(Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2+1], extraX+(Cirno2Charbx+Cirno2SpecialEffectX-40)*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY+40)*prop, 0, Cirno2side*0.6*prop, 0.6*prop, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getWidth()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getWidth())/2, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getHeight()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getHeight())/2)
    love.graphics.draw(Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2], extraX+(Cirno2Charbx+Cirno2SpecialEffectX)*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY+40)*prop, 0, Cirno2side*0.6*prop, 0.6*prop, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getWidth()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getWidth())/2, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getHeight()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getHeight())/2)
    love.graphics.draw(Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2], extraX+(Cirno2Charbx+Cirno2SpecialEffectX-40)*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY)*prop, 0, Cirno2side*0.6*prop, 0.6*prop, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getWidth()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getWidth())/2, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getHeight()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getHeight())/2)
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX+(Cirno2Charbx-25)*prop, extraY+(Cirno2Charby-30)*prop, (Cirno2_hitboxX+40)*prop, (Cirno2_hitboxY+40)*prop)
    Cirno2AttackBox = {extraX+(Cirno2Charbx-25)*prop, extraY+(Cirno2Charby-30)*prop, (Cirno2_hitboxX+40)*prop, (Cirno2_hitboxY+40)*prop}
    love.graphics.setColor(255,255,255)

  elseif Cirno2SpecialEffects==4 then --[25]
    love.graphics.draw(Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2], extraX+(Cirno2Charbx+Cirno2SpecialEffectX)*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY)*prop, Cirno2GenericVariable, Cirno2side*0.5*prop, 0.5*prop, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getWidth())/2, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getHeight()/2))
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX+(Cirno2Charbx+Cirno2side*(Cirno2SpecialEffectX-50))*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY-50)*prop, (Cirno2_hitboxX+35)*prop, (Cirno2_hitboxY+25)*prop)
    Cirno2AttackBox = {extraX+(Cirno2Charbx+Cirno2side*(Cirno2SpecialEffectX-50))*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY-50)*prop, (Cirno2_hitboxX+35)*prop, (Cirno2_hitboxY+25)*prop}
    love.graphics.setColor(255,255,255)

  elseif Cirno2SpecialEffects==5 then --[28]
    love.graphics.draw(Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2], extraX+(Cirno2Charbx+Cirno2SpecialEffectX)*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY)*prop, 0, Cirno2side*prop, prop, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getWidth()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getWidth())/2, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getHeight()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getHeight())/2)
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX+(Cirno2Charbx+Cirno2SpecialEffectX-75)*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY-15)*prop, (Cirno2_hitboxX+35)*prop, (Cirno2_hitboxY+25)*prop)
    Cirno2AttackBox = {extraX+(Cirno2Charbx+Cirno2SpecialEffectX-75)*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY-15)*prop, (Cirno2_hitboxX+35)*prop, (Cirno2_hitboxY+25)*prop}
    love.graphics.setColor(255,255,255)

  elseif Cirno2SpecialEffects==6 then --[29]
    love.graphics.draw(Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2], extraX+(Cirno2Charbx+Cirno2SpecialEffectX+33)*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY+33)*prop, Cirno2GenericVariable, Cirno2side*prop, prop, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getWidth())/2+30, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getHeight())/2+40)
    love.graphics.setColor(255,0,0)
    if Cirno2_sprite>1 and Cirno2_sprite<5 then
      love.graphics.rectangle("line", extraX+(Cirno2Charbx+20)*prop, extraY+(Cirno2Charby-85)*prop, (Cirno2_hitboxX-40)*prop, (Cirno2_hitboxY+25)*prop)
      Cirno2AttackBox = {extraX+(Cirno2Charbx+20)*prop, extraY+(Cirno2Charby-85)*prop, (Cirno2_hitboxX-40)*prop, (Cirno2_hitboxY+25)*prop}
    end
    if Cirno2_sprite<8 and Cirno2_sprite>4 then
      love.graphics.rectangle("line", extraX+(Cirno2Charbx+40)*prop, extraY+(Cirno2Charby-10)*prop, Cirno2_hitboxX*prop, (Cirno2_hitboxY+50)*prop)
      Cirno2AttackBox = {extraX+(Cirno2Charbx+40)*prop, extraY+(Cirno2Charby-10)*prop, Cirno2_hitboxX*prop, (Cirno2_hitboxY+50)*prop}
    end
    if Cirno2_sprite>6 and Cirno2_sprite<10 then
      love.graphics.rectangle("line", extraX+(Cirno2Charbx-25)*prop, extraY+(Cirno2Charby+50)*prop, (Cirno2_hitboxX+50)*prop, Cirno2_hitboxY*prop)
      Cirno2AttackBox = {extraX+(Cirno2Charbx-25)*prop, extraY+(Cirno2Charby+50)*prop, (Cirno2_hitboxX+50)*prop, Cirno2_hitboxY*prop}
    end
    if  Cirno2_sprite>8 and Cirno2_sprite<12 then
      love.graphics.rectangle("line", extraX+(Cirno2Charbx-50)*prop, extraY+(Cirno2Charby-10)*prop, Cirno2_hitboxX*prop, (Cirno2_hitboxY+50)*prop)
      Cirno2AttackBox = {extraX+(Cirno2Charbx-50)*prop, extraY+(Cirno2Charby-10)*prop, Cirno2_hitboxX*prop, (Cirno2_hitboxY+50)*prop}
    end
    if  Cirno2_sprite>12 and Cirno2_sprite<16 then
      love.graphics.rectangle("line", extraX+(Cirno2Charbx+30)*prop, extraY+(Cirno2Charby+40)*prop, (Cirno2_hitboxX+10)*prop, (Cirno2_hitboxY+20)*prop)
      Cirno2AttackBox = {extraX+(Cirno2Charbx+30)*prop, extraY+(Cirno2Charby+40)*prop, (Cirno2_hitboxX+10)*prop, (Cirno2_hitboxY+20)*prop}
    end
    love.graphics.setColor(255,255,255)

  elseif Cirno2SpecialEffects==7 then --[30]
    love.graphics.draw(Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2], extraX+(Cirno2Charbx+Cirno2SpecialEffectX)*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY)*prop, 0, Cirno2side*prop, prop, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getWidth()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getWidth())/2, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getHeight()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getHeight())/2)
    love.graphics.setColor(255,0,0)
    if Cirno2_sprite2>9 then
      love.graphics.rectangle("line", extraX+(Cirno2Charbx+Cirno2SpecialEffectX-20)*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY-10)*prop, (Cirno2_hitboxX+75)*prop, (Cirno2_hitboxY+70)*prop)
      Cirno2AttackBox = {extraX+(Cirno2Charbx+Cirno2SpecialEffectX-20)*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY-10)*prop, (Cirno2_hitboxX+75)*prop, (Cirno2_hitboxY+70)*prop}
    end
    love.graphics.setColor(255,255,255)

  elseif Cirno2SpecialEffects==8 then --[31]
    love.graphics.draw(Cirno2AnimationFrame[Cirno2_anim_type][32], extraX+400*prop, extraY+300*prop, 0, Cirno2side*3.2*prop, 3.2*prop, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getWidth())/2, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getHeight())/2)
    love.graphics.draw(Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2], extraX+(Cirno2Charbx+Cirno2SpecialEffectX)*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY)*prop, 0, Cirno2side*prop, prop, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getWidth()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getWidth())/2, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getHeight()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getHeight())/2)
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX, extraY, 800*prop, 600*prop)
    Cirno2AttackBox = {extraX, extraY, 800*prop, 600*prop}
    love.graphics.setColor(255,255,255)

  elseif Cirno2SpecialEffects==9 then --[14]
    love.graphics.draw(Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2], extraX+(Cirno2Charbx+Cirno2SpecialEffectX)*prop, extraY+(Cirno2Charby+Cirno2SpecialEffectY)*prop, 0, Cirno2side*prop, prop, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getWidth()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getWidth())/2, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getHeight()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getHeight())/2)
    
  elseif Cirno2SpecialEffects==10 then --[21]
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX+(Cirno2Charbx+45)*prop, extraY+(Cirno2Charby+20)*prop, (Cirno2_hitboxX-30)*prop, (Cirno2_hitboxY-40)*prop)
    Cirno2AttackBox = {extraX+(Cirno2Charbx+45)*prop, extraY+(Cirno2Charby+20)*prop, (Cirno2_hitboxX-30)*prop, (Cirno2_hitboxY-40)*prop}
    love.graphics.setColor(255,255,255)
    
  elseif Cirno2SpecialEffects==11 then --[24]
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX+(Cirno2Charbx+45)*prop, extraY+(Cirno2Charby+40)*prop, (Cirno2_hitboxX-30)*prop, (Cirno2_hitboxY-40)*prop)
    Cirno2AttackBox = {extraX+(Cirno2Charbx+45)*prop, extraY+(Cirno2Charby+40)*prop, (Cirno2_hitboxX-30)*prop, (Cirno2_hitboxY-40)*prop}
    love.graphics.setColor(255,255,255)
    
  elseif Cirno2SpecialEffects==12 then --[27]
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX+(Cirno2Charbx+40)*prop, extraY+(Cirno2Charby+55)*prop, (Cirno2_hitboxX-30)*prop, (Cirno2_hitboxY-40)*prop)
    Cirno2AttackBox = {extraX+(Cirno2Charbx+40)*prop, extraY+(Cirno2Charby+55)*prop, (Cirno2_hitboxX-30)*prop, (Cirno2_hitboxY-40)*prop}
    love.graphics.setColor(255,255,255)
  
  elseif Cirno2SpecialEffects==13 then
    love.graphics.draw(Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2], extraX+Cirno2SpecialEffectX*prop, extraY+Cirno2SpecialEffectY*prop, 0, Cirno2side*prop, prop, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getWidth()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getWidth())/2, (Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite2]:getHeight()-Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getHeight())/2)
  end

  love.graphics.draw(Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite], extraX+(Cirno2Charbx+34.5)*prop, extraY+Cirno2Charby*prop, 0, Cirno2side*prop, prop, Cirno2AnimationFrame[Cirno2_anim_type][Cirno2_sprite]:getWidth()/2, 0)
  --love.graphics.rectangle("line", extraX+Cirno2Charbx*prop, extraY+Cirno2Charby*prop, Cirno2_hitboxX*prop, Cirno2_hitboxY*prop)
  love.graphics.setColor(0,0,255)
  --love.graphics.rectangle("line", extraX+Cirno2Charbx*prop, extraY+(Cirno2Charby+5)*prop, (Cirno2_hitboxX-10)*prop, (Cirno2_hitboxY-10)*prop)
  love.graphics.setColor(255,255,255)
end

return c2