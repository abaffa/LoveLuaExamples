local c1 = {}
--[[ COMENTARIOS INDICADORES (INDICE) [0]

      [1] WALK FOWARD, [2] WALK BACKWARD, [3] STAND UP, [4] STAND, [5] LANDING ON GROUND, [6] LANDING, [7] JUMP FORWARD,
      [8] JUMP BACKWARD, [9] JUMP, [10] INTERFACE, [11] HIT LOW, [12] HIT HIGH, [13] HIT AIR, [14] GUARD, [15] GETTING BACK UP,
      [16] FALLING, [17] DASH FORWARD, [18] DASH BACKWARD, [19] CROUCH GUARD, [20] CROUCH, [21] NEUTRAL WEAK, [22] NEUTRAL HEAVY,
      [23] NEUTRAL MEDIUM, [24] CROUCH WEAK, [25] CROUCH MEDIUM, [26] CROUCH HEAVY, [27] AIR WEAK, [28] AIR MEDIUM, [29] AIR HEAVY,
      [30] SPECIAL, [31] SUPER.
      
      [A] c2:new(), [B] c2:update(), [C] c2:draw().
]]
local playerControl = {{"w","a","s","d","c","v","b","n","space","e"},{"i","j","k","l","9","0","-","=","p","o"}}
local CirnoAttackBox
local CirnoGravity = 0.8
--local CirnoJump = 1.1
local CirnoHP = 90
local CirnoAnimationFrame ={}
local CirnoAnimationTime
local CirnoAnimationSize = {8,8,2,6,9,3,2,2,6,3,4,4,7,8,5,2,7,5,8,4,6,6,13,5,13,14,10,26,23,14,32,7,5}
local Cirno_count = 1
local Cirno_anim_type
local CirnoState --Estado da Cirno: 0 é normal, 1 é no ar, 2 é em hitstun, 3 é caido, 4 é guardando, 5 é atacando, 6 é atacando no ar, 7 é agachada, 8 é atacando agachada, 9 é dash
local CirnoStageHeight
local CirnoCharbx
local CirnoCharby
local CirnoXSpeed
local CirnoYSpeed
local Cirno_sprite
local Cirno_sprite2
local CirnoGenericVariable
local CirnoGenericVariableAtk
local CirnoAttacktype
local CirnoSpecialEffects
local CirnoSpecialEffectX
local CirnoSpecialEffectY
local CirnoGuardtype
local Cirno_hitboxX
local Cirno_hitboxY
local Cirno_crouchvar
local Cirno_pl = 0

function c1:new(pos_chao, prop, extraX, extraY, playerNum) --[A]
  Cirno_sprite = 1
  Cirno_sprite2 = 1
  CirnoXSpeed = 0
  CirnoYSpeed = 0
  CirnoGenericVariable = 0
  CirnoGenericVariableAtk = 0
  CirnoAttacktype = 0
  CirnoSpecialEffects =0
  CirnoSpecialEffectX =0
  CirnoSpecialEffectY =0
  CirnoGuardtype=0
  Cirno_hitboxX=65
  Cirno_hitboxY=80
  Cirno_crouchvar=0
  Cirno_anim_type=4
  CirnoState=0
  CirnoAnimationTime = 0
  CirnoAttackBox = {0,0,0,0}
  Cirno_pl = playerNum
  CirnoCharbx=100
  for i=1,33 do
    CirnoAnimationFrame[i] = {}
    for j=1,CirnoAnimationSize[i] do
      CirnoAnimationFrame[i][j]=love.graphics.newImage("characters/char/Cirno/Cirno"..Cirno_count..".png")
      Cirno_count=Cirno_count+1
    end
  end
  CirnoStageHeight = pos_chao - CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getHeight() -- Alterado por pos_chao. Crie uma variável pos_chao na main e coloque assim: "cirno:new(pos_chao)"
  CirnoCharby = CirnoStageHeight
  Cirno_count=1
  return {extraX+CirnoCharbx*prop, extraY+CirnoCharby*prop, Cirno_hitboxX*prop, Cirno_hitboxY*prop}, {extraX+(CirnoCharbx+10)*prop, extraY+(CirnoCharby+5)*prop, (Cirno_hitboxX-20)*prop, (Cirno_hitboxY-10)*prop}
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoWalkForward(dt) --[1]
  Cirno_anim_type=1
  CirnoXSpeed=120
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.15 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 8 then
    Cirno_sprite= 1
    CirnoXSpeed=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoWalkBackward(dt) --[2]
  CirnoAnimationTime=CirnoAnimationTime+dt
  Cirno_anim_type=2
  CirnoXSpeed=-120
  if CirnoAnimationTime > 0.15 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 8 then
    Cirno_sprite= 1
    CirnoXSpeed=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoStandUp(dt) --[3]
  if CirnoGenericVariable==0 then
    Cirno_sprite=1
    CirnoGenericVariable=1
  end
  Cirno_anim_type=3
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.15 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 2 then
    Cirno_sprite= 1
    CirnoState=0
    CirnoGenericVariable=0
    Cirno_crouchvar=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoStand(dt) --[4]
  CirnoXSpeed=0
  Cirno_anim_type=4
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.15 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 6 then
    Cirno_sprite= 1
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoLanding(dt) --[6]
  CirnoXSpeed=0
  if CirnoGenericVariable==0 then
    Cirno_sprite=1
    CirnoGenericVariable=1
  end
  Cirno_anim_type=6
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.10 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 3 then
    Cirno_sprite= 1
    CirnoState=0
    CirnoGenericVariable=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoLandingOnGround(dt) --[5]
  Cirno_anim_type=5
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.15 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 9 then
    Cirno_sprite=9
    CirnoState=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoJumpForward(dt) --[7]
  if CirnoState==0 then
    CirnoYSpeed=-400
  end
  CirnoState=1
  Cirno_anim_type=7
  CirnoXSpeed=120
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.10 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 2 then
    Cirno_sprite=1
    CirnoXSpeed=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoJumpBackward(dt)--[8]
  if CirnoState==0 then
    CirnoYSpeed=-400
  end
  CirnoState=1
  Cirno_anim_type=8
  CirnoXSpeed=-120
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.10 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 2 then
    Cirno_sprite=1
    CirnoXSpeed=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoJump(dt) --[9]
  CirnoXSpeed=0
  if CirnoState==0 then
    CirnoYSpeed=-400
  end
  CirnoState=1
  Cirno_anim_type=9
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.15 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 6 then
    Cirno_sprite=6
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoHitLow(dt) --[11]
  CirnoState=2
  Cirno_anim_type=11
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.15 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 4 then
    Cirno_sprite=1
    CirnoState=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoHitHigh(dt) --[12]
  CirnoState=2
  Cirno_anim_type=12
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.15 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 4 then
    Cirno_sprite=1
    CirnoState=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoHitAir(dt) --[13]
  CirnoState=2
  Cirno_anim_type=13
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.15 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 7 then
    Cirno_sprite=7
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoGuard(dt, Cirnoside) --[14]
  CirnoSpecialEffects=9
  CirnoSpecialEffectX=50
  if CirnoGenericVariable==0 then
    Cirno_sprite2=5
    CirnoGenericVariable=1
  end
  CirnoState=4
  CirnoGuardtype=0
  CirnoXSpeed=0
  Cirno_anim_type=14
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.15 then
    Cirno_sprite=Cirno_sprite+1
    if CirnoGenericVariable==0 then
      Cirno_sprite2=5
      CirnoGenericVariable=1
    end
    Cirno_sprite2=Cirno_sprite2+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 2 and CirnoGenericVariable==1 then
    Cirno_sprite=1
  end
  if Cirno_sprite2>8 then
    Cirno_sprite2=5
  end
  if love.keyboard.isDown(playerControl[Cirno_pl][3]) then
    CirnoCrouchGuard(dt)
  end
  if not love.keyboard.isDown(playerControl[Cirno_pl][-Cirnoside+3]) then
    CirnoGenericVariable=2
  end
  if Cirno_sprite>3 then
    Cirno_sprite=1
    Cirno_sprite2=1
    CirnoState=0
    CirnoGuardtype=0
    CirnoSpecialEffects=0
    CirnoSpecialEffectX=0
    CirnoGenericVariable=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoGettingBackUp(dt) --[15]
  Cirno_anim_type=15
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.15 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 5 then
    Cirno_sprite=1
    CirnoState=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoFalling(dt, Cirnoside) --[16]
  Cirno_anim_type=16
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.10 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 2 then
    Cirno_sprite=1
  end
  if love.keyboard.isDown(playerControl[Cirno_pl][Cirnoside+3]) then
    CirnoXSpeed=120
  elseif love.keyboard.isDown(playerControl[Cirno_pl][-Cirnoside+3]) then
    CirnoXSpeed=-120
  else CirnoXSpeed=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoDashForward(dt, Cirnoside) --[17]
  CirnoState=9
  Cirno_anim_type=17
  CirnoXSpeed=0
  if CirnoGenericVariable==0 then
    Cirno_sprite=1
    CirnoGenericVariable=1
  end
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.15 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 2 then
    CirnoXSpeed=240
  end
  if Cirno_sprite > 6 and love.keyboard.isDown(playerControl[Cirno_pl][10]) and love.keyboard.isDown(playerControl[Cirno_pl][Cirnoside+3]) then
    Cirno_sprite=3
  elseif Cirno_sprite>6 then
    CirnoXSpeed=0
  end
  if not love.keyboard.isDown(playerControl[Cirno_pl][10]) or not love.keyboard.isDown(playerControl[Cirno_pl][Cirnoside+3]) then
    if Cirno_sprite < 7 then
      Cirno_sprite=7
    end
  end
  if Cirno_sprite > 7 then
    Cirno_sprite=1
    CirnoGenericVariable=0
    CirnoXSpeed=0
    CirnoState=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoDashBackward(dt, Cirnoside) --[18]
  CirnoState=9
  Cirno_anim_type=18
  CirnoXSpeed=0
  if CirnoGenericVariable==0 then
    Cirno_sprite=1
    CirnoGenericVariable=2
  end
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.15 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 0 then
    CirnoXSpeed=-240
  end
  if Cirno_sprite > 4 and love.keyboard.isDown(playerControl[Cirno_pl][10]) and love.keyboard.isDown(playerControl[Cirno_pl][-Cirnoside+3]) then
    Cirno_sprite=1
  elseif Cirno_sprite>4 then
    CirnoXSpeed=0
  end
  if not love.keyboard.isDown(playerControl[Cirno_pl][10]) or not love.keyboard.isDown(playerControl[Cirno_pl][-Cirnoside+3]) then
    if Cirno_sprite < 5 then
      Cirno_sprite=5
    end
  end
  if Cirno_sprite > 5 then
    Cirno_sprite=1
    CirnoGenericVariable=0
    CirnoXSpeed=0
    CirnoState=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoCrouchGuard(dt, Cirnoside) --[19]
  CirnoSpecialEffects=9
  if CirnoGenericVariable==0 then
    Cirno_sprite2=5
    CirnoGenericVariable=1
  end
  CirnoSpecialEffectX=50
  CirnoState=4
  CirnoGuardtype=1
  CirnoXSpeed=0
  Cirno_anim_type=19
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.15 then
    Cirno_sprite=Cirno_sprite+1
    Cirno_sprite2=Cirno_sprite2+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 2 and CirnoGenericVariable==1 then
    Cirno_sprite=1
  end
  if Cirno_sprite2>8 then
    Cirno_sprite2=5
  end
  if not love.keyboard.isDown(playerControl[Cirno_pl][-Cirnoside+3]) then
    CirnoGenericVariable=2
  end
  if not love.keyboard.isDown(playerControl[Cirno_pl][3]) then
    CirnoGuard(dt)
  end
  if Cirno_sprite>3 then
    Cirno_sprite=1
    Cirno_sprite2=1
    CirnoState=0
    CirnoGuardtype=0
    CirnoSpecialEffects=0
    CirnoSpecialEffectX=0
    CirnoGenericVariable=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoCrouch(dt) --[20]
  if Cirno_crouchvar==1 then
    Cirno_sprite=4
  end
  CirnoXSpeed=0
  CirnoState=7
  Cirno_anim_type=20
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.15 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite>3 then
    Cirno_sprite=4
    Cirno_crouchvar=1
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoNeutralWeak(dt) --[21]
  CirnoXSpeed=0
  if CirnoGenericVariableAtk==0 then
    Cirno_sprite=1
    CirnoGenericVariableAtk=1
  end
  CirnoSpecialEffects=10
  CirnoAttacktype=1
  CirnoState=5
  Cirno_anim_type=21
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.05 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 6 then
    Cirno_sprite=1
    CirnoState=0
    CirnoAttacktype=0
    CirnoGenericVariableAtk=0
    CirnoSpecialEffects=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoNeutralHeavy(dt) --[22]
  CirnoXSpeed=0
  if CirnoGenericVariableAtk==0 then
    Cirno_sprite=1
    CirnoGenericVariableAtk=1
  end
  CirnoAttacktype=3
  CirnoState=5
  Cirno_anim_type=22
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.10 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 4 then
    CirnoSpecialEffects=1
    Cirno_sprite2=6
    CirnoGenericVariable=CirnoGenericVariable+5*dt
    CirnoXSpeed=500
  end
  if Cirno_sprite > 5 then
    Cirno_sprite = 5
  end
  if CirnoGenericVariable>3 then
    CirnoXSpeed=0
    CirnoSpecialEffects=0
    Cirno_sprite=1
    CirnoState=0
    CirnoAttacktype=0
    CirnoGenericVariableAtk=0
    CirnoGenericVariable=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoNeutralMedium(dt) --[23]
  CirnoXSpeed=0
  if CirnoGenericVariableAtk==0 then
    Cirno_sprite=1
    CirnoGenericVariableAtk=1
  end
  CirnoAttacktype=2
  CirnoState=5
  Cirno_anim_type=23
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.10 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite >3 then
    CirnoSpecialEffectX=25
    CirnoSpecialEffectY=-10
    CirnoSpecialEffects=3
    Cirno_sprite2=12
  end
  if Cirno_sprite >5 then
    CirnoSpecialEffects=0
  end
  if Cirno_sprite > 11 then
    Cirno_sprite=1
    Cirno_sprite2=1
    CirnoState=0
    CirnoAttacktype=0
    CirnoGenericVariableAtk=0
    CirnoGenericVariable=0
    CirnoSpecialEffectX=0
    CirnoSpecialEffectY=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoCrouchingWeak(dt) --[24]
  CirnoXSpeed=0
  if CirnoGenericVariableAtk==0 then
    Cirno_sprite=1
    CirnoGenericVariableAtk=1
  end
  CirnoAttacktype=1
  CirnoSpecialEffects=11
  CirnoState=8
  Cirno_anim_type=24
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.05 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 5 then
    Cirno_sprite=4
    CirnoSpecialEffects=0
    CirnoState=7
    CirnoAttacktype=0
    CirnoGenericVariableAtk=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoCrouchingMedium(dt) --[25]
  CirnoXSpeed=0
  if CirnoGenericVariableAtk==0 then
    Cirno_sprite=1
    CirnoGenericVariableAtk=1
  end
  CirnoAttacktype=2
  CirnoState=8
  Cirno_anim_type=25
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.125 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite>=2 then
    CirnoSpecialEffects=4
    CirnoGenericVariable=CirnoGenericVariable+7.5*dt
    Cirno_sprite2=11
    CirnoSpecialEffectX=110
    CirnoSpecialEffectY=40
    CirnoXSpeed=150
  end
  if not love.keyboard.isDown(playerControl[Cirno_pl][6]) then
    Cirno_sprite=1
    CirnoState=7
    CirnoAttacktype=0
    CirnoGenericVariableAtk=0
    CirnoSpecialEffects=0
    CirnoGenericVariable=0
    CirnoSpecialEffectX=0
    CirnoSpecialEffectY=0
    CirnoXSpeed=0
  end
  if Cirno_sprite>10 and love.keyboard.isDown(playerControl[Cirno_pl][6]) then
    Cirno_sprite=2
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoCrouchingHeavy(dt, Cirnoside) --[26]
  CirnoXSpeed=0
  if CirnoGenericVariableAtk==0 then
    Cirno_sprite=1
    CirnoGenericVariableAtk=1
  end
  CirnoAttacktype=3
  CirnoState=8
  Cirno_anim_type=26
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.10 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite >3 then
    CirnoSpecialEffects=2
    CirnoSpecialEffectY=-80
    Cirno_sprite2=14
    CirnoXSpeed=100
    CirnoGenericVariable=CirnoGenericVariable+2*dt
    if CirnoGenericVariable<1 and Cirno_sprite>8 then
      Cirno_sprite=8
    end
  end
  if Cirno_sprite==6 then
    CirnoSpecialEffectX=70-10*Cirnoside
    CirnoSpecialEffectY=-60
  end
  if Cirno_sprite>6 then
    CirnoSpecialEffectX=60+20*Cirnoside
    CirnoSpecialEffectY=0
    CirnoCharby=CirnoCharby+30
  end
  if Cirno_sprite>8 then
    CirnoXSpeed=0
    CirnoSpecialEffects=0
  end
  if Cirno_sprite>9 then
   CirnoCharby=CirnoCharby-30
  end
  if Cirno_sprite > 13 then
    Cirno_sprite=1
    CirnoState=7
    CirnoAttacktype=0
    CirnoGenericVariableAtk=0
    CirnoGenericVariable=0
    CirnoSpecialEffectX=0
    CirnoSpecialEffectY=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoAirWeak(dt) --[27]
  if CirnoGenericVariableAtk==0 then
    Cirno_sprite=1
    CirnoGenericVariableAtk=1
  end
  CirnoAttacktype=1
  CirnoState=6
  CirnoSpecialEffects=12
  Cirno_anim_type=27
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.05 then
    Cirno_sprite=Cirno_sprite+1
    CirnoAnimationTime = 0
  end
  if Cirno_sprite > 10 then
    Cirno_sprite=1
    CirnoSpecialEffects=0
    CirnoAttacktype=0
    CirnoGenericVariableAtk=0
    CirnoState=1
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoAirMedium(dt) --[28]
  if CirnoGenericVariableAtk==0 then
    Cirno_sprite=1
    Cirno_sprite2=8
    CirnoGenericVariableAtk=1
  end
  CirnoAttacktype=2
  CirnoState=6
  Cirno_anim_type=28
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.05 then
    Cirno_sprite=Cirno_sprite+1
    if Cirno_sprite>5 then
      Cirno_sprite2=Cirno_sprite2+1
    end
    CirnoAnimationTime = 0
  end
  if Cirno_sprite>5 then
    CirnoSpecialEffects=5
    CirnoSpecialEffectX=130
  end
  if Cirno_sprite>7 and CirnoGenericVariable==0 then
    Cirno_sprite=7
  end
  if Cirno_sprite2>26 then
    CirnoSpecialEffects=0
    CirnoGenericVariable=1
  end
  if Cirno_sprite > 8 then
    Cirno_sprite=1
    CirnoAttacktype=0
    CirnoGenericVariableAtk=0
    Cirno_sprite2=0
    CirnoGenericVariable=0
    CirnoSpecialEffects=0
    CirnoSpecialEffectX=0
    CirnoState=1
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoAirHeavy(dt) --[29]
  if CirnoGenericVariableAtk==0 then
    Cirno_sprite=1
    Cirno_sprite2=18
    CirnoGenericVariableAtk=1
  end
  CirnoAttacktype=3
  CirnoState=6
  Cirno_anim_type=29
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.08 then
    Cirno_sprite=Cirno_sprite+1
    if Cirno_sprite>4 and Cirno_sprite<12 then
      CirnoGenericVariable=CirnoGenericVariable+math.pi/4
    end
    if Cirno_sprite>12 then
      CirnoSpecialEffectX=60
      CirnoSpecialEffectY=40
      Cirno_sprite2=Cirno_sprite2+1
    end
    CirnoAnimationTime = 0
  end
  if Cirno_sprite>1 then
    CirnoSpecialEffects=6
    if CirnoGenericVariableAtk==1 then
      CirnoSpecialEffectX=30
      CirnoSpecialEffectY=-30
      CirnoGenericVariableAtk=2
    end
  end
  if Cirno_sprite>4 and Cirno_sprite<12 then
    if CirnoGenericVariableAtk==2 then
      Cirno_sprite2=17
      CirnoGenericVariableAtk=3
    end
    CirnoSpecialEffectX=math.cos(CirnoGenericVariable)*30
    CirnoSpecialEffectY=math.sin(CirnoGenericVariable)*30
  end
  if Cirno_sprite==12 then
    CirnoGenericVariable=0
    Cirno_sprite2=18
    CirnoSpecialEffectX=30
    CirnoSpecialEffectY=-10
  end
  if Cirno_sprite>15 and CirnoGenericVariable==1 then
    Cirno_sprite=15
  end
  if Cirno_sprite2>23 then
    CirnoGenericVariable=2
  end
  if Cirno_sprite > 16 then
    Cirno_sprite=1
    CirnoAttacktype=0
    CirnoGenericVariableAtk=0
    CirnoSpecialEffects=0
    CirnoSpecialEffectX=0
    CirnoSpecialEffectY=0
    Cirno_sprite2=0
    CirnoGenericVariable=0
    CirnoState=1
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoSpecial(dt) --[30]
  if CirnoGenericVariableAtk==0 then
    Cirno_sprite=1
    CirnoGenericVariableAtk=1
  end
  CirnoXSpeed=0
  CirnoSpecialEffects=7
  CirnoAttacktype=4
  CirnoState=5
  Cirno_anim_type=30
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.15 then
    Cirno_sprite=Cirno_sprite+1
    if CirnoGenericVariable==1 then
      Cirno_sprite2=Cirno_sprite2+1
    end
    CirnoAnimationTime = 0
  end
  if Cirno_sprite<5 then
    Cirno_sprite2=9
    CirnoSpecialEffectX=-50
    CirnoSpecialEffectY=0
  end
  if Cirno_sprite>4 and CirnoGenericVariable==0 then
    Cirno_sprite2=10
    CirnoGenericVariable=1
    CirnoSpecialEffectX=100
    CirnoSpecialEffectY=-50
  end
  if Cirno_sprite>7 and CirnoGenericVariable==1 then
    Cirno_sprite=7
  end
  if Cirno_sprite2>14 then
    CirnoGenericVariable=2
    CirnoSpecialEffects=0
  end
  if Cirno_sprite > 8 then
    Cirno_sprite=1
    CirnoState=0
    CirnoAttacktype=0
    CirnoGenericVariableAtk=0
    CirnoSpecialEffects=0
    CirnoSpecialEffectX=0
    CirnoSpecialEffectY=0
    Cirno_sprite2=0
    CirnoGenericVariable=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function CirnoSuper(dt) --[31]
  if CirnoGenericVariableAtk==0 then
    Cirno_sprite=1
    CirnoGenericVariableAtk=1
  end
  CirnoXSpeed=0
  CirnoAttacktype=5
  CirnoState=5
  Cirno_anim_type=31
  CirnoAnimationTime=CirnoAnimationTime+dt
  if CirnoAnimationTime > 0.10 then
    Cirno_sprite=Cirno_sprite+1
    if Cirno_sprite>7 then
      if CirnoGenericVariable == 0 then
        Cirno_sprite2=13
        CirnoGenericVariable=1
      end
      CirnoSpecialEffects=8
      CirnoSpecialEffectX=130
      Cirno_sprite2=Cirno_sprite2+1
    end
    CirnoAnimationTime = 0
  end
  if Cirno_sprite>9 and CirnoGenericVariable==1 then
    Cirno_sprite=9
  end
  if Cirno_sprite2>30 then
    CirnoSpecialEffects=0
    CirnoGenericVariable=2
  end
  if Cirno_sprite > 12 then
    Cirno_sprite=1
    CirnoAttacktype=0
    CirnoState=0
    CirnoGenericVariableAtk=0
    Cirno_sprite2=0
    CirnoGenericVariable=0
    CirnoSpecialEffects=0
    CirnoSpecialEffectX=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function c1:update(dt, prop, extraX, extraY, CirnoEnemyState, Cirnoside, winner) --[B]
  --MOVEMENT SYSTEM-- BEGIN
  CirnoCharbx=CirnoCharbx+Cirnoside*CirnoXSpeed*dt
  CirnoCharby=CirnoCharby+CirnoYSpeed*dt+CirnoGravity*250*math.pow(dt,2)
  CirnoYSpeed=CirnoYSpeed+CirnoGravity*500*dt
  if CirnoCharby>CirnoStageHeight-20 then
    CirnoCharby=CirnoStageHeight-20
    CirnoYSpeed=0
    if CirnoState==1 or CirnoState==6 then
      CirnoLanding(dt)
      CirnoAttacktype=0
      Cirno_sprite2=0
      CirnoSpecialEffects=0
      CirnoGenericVariableAtk=0
      CirnoSpecialEffects=0
      CirnoSpecialEffectX=0
      CirnoSpecialEffectY=0
    elseif Cirno_crouchvar==1 then
      CirnoCharby=CirnoStageHeight
    end
  end
  --MOVEMENT SYSTEM-- END
  
  if winner == 0 then
    if CirnoState == 0 then
      if love.keyboard.isDown(playerControl[Cirno_pl][5]) then
        CirnoNeutralWeak(dt) --[21]
      elseif love.keyboard.isDown(playerControl[Cirno_pl][6]) then
        CirnoNeutralMedium(dt) --[23]
      elseif love.keyboard.isDown(playerControl[Cirno_pl][7]) then
        CirnoNeutralHeavy(dt) --[22]
      elseif love.keyboard.isDown(playerControl[Cirno_pl][8]) then
        CirnoSpecial(dt) --[30]
      elseif love.keyboard.isDown(playerControl[Cirno_pl][9]) then
        CirnoSuper(dt) --[31]
      elseif love.keyboard.isDown(playerControl[Cirno_pl][Cirnoside+3]) then
        CirnoWalkForward(dt) --[1]
        if love.keyboard.isDown(playerControl[Cirno_pl][1]) then
          Cirno_sprite=1
          CirnoJumpForward(dt) --[7]
        elseif love.keyboard.isDown(playerControl[Cirno_pl][10]) then
          CirnoDashForward(dt, Cirnoside) --[17]
        end
      elseif love.keyboard.isDown(playerControl[Cirno_pl][-Cirnoside+3]) then
        CirnoWalkBackward(dt) --[2]
        if love.keyboard.isDown(playerControl[Cirno_pl][1]) then
          Cirno_sprite=1
          CirnoJumpBackward(dt) --[8]
        elseif love.keyboard.isDown(playerControl[Cirno_pl][10]) then
          CirnoDashBackward(dt, Cirnoside) --[18]
        end
      elseif love.keyboard.isDown(playerControl[Cirno_pl][3]) then
        Cirno_sprite=1
        CirnoCrouch(dt) --[20]
      elseif love.keyboard.isDown(playerControl[Cirno_pl][1]) then
        Cirno_sprite=1
        CirnoJump(dt) --[9]
      else
        CirnoStand(dt) --[4]
      end
    elseif CirnoState == 1 then
      if CirnoYSpeed<0 then
        if love.keyboard.isDown(playerControl[Cirno_pl][-Cirnoside+3]) then
          CirnoJumpBackward(dt) --[8]
        elseif love.keyboard.isDown(playerControl[Cirno_pl][Cirnoside+3]) then
          CirnoJumpForward(dt) --[7]
        else CirnoJump(dt) --[9]
        end
      end
      if CirnoYSpeed>0 then
        CirnoFalling(dt, Cirnoside) --[16]
      end
      if love.keyboard.isDown(playerControl[Cirno_pl][5]) then
        CirnoAirWeak(dt) --[27]
      elseif love.keyboard.isDown(playerControl[Cirno_pl][6]) then
        CirnoAirMedium(dt) --[28]
      elseif love.keyboard.isDown(playerControl[Cirno_pl][7]) then
        CirnoAirHeavy(dt) --[29]
      end
    elseif CirnoState == 3 then
      if love.keyboard.isDown(playerControl[Cirno_pl][1]) then
        CirnoGettingBackUp(dt) --[15]
      end
    elseif CirnoState==4 then
      if CirnoGuardtype==0 then
        CirnoGuard(dt, Cirnoside) --[14]
      elseif CirnoGuardtype==1 then
        CirnoCharby=CirnoStageHeight
        CirnoCrouchGuard(dt, Cirnoside) --[19]
      end
    elseif CirnoState == 5 then
      if CirnoAttacktype == 1 then
        CirnoNeutralWeak(dt) --[21]
      elseif CirnoAttacktype == 2 then
        CirnoNeutralMedium(dt) --[23]
      elseif CirnoAttacktype == 3 then
        CirnoNeutralHeavy(dt) --[22]
      elseif CirnoAttacktype == 4 then
        CirnoSpecial(dt) --[30]
      elseif CirnoAttacktype == 5 then
        CirnoSuper(dt) --[31]
      end
    elseif CirnoState == 6 then
      if CirnoAttacktype == 1 then
        CirnoAirWeak(dt) --[27]
      elseif CirnoAttacktype == 2 then
        CirnoAirMedium(dt) --[28]
      elseif CirnoAttacktype == 3 then
        CirnoAirHeavy(dt) --[29]
      end
    elseif CirnoState==8 then
      if CirnoAttacktype == 1 then
        CirnoCrouchingWeak(dt) --[24]
      elseif CirnoAttacktype == 2 then
        CirnoCrouchingMedium(dt) --[25]
      elseif CirnoAttacktype == 3 then
        CirnoCrouchingHeavy(dt, Cirnoside) --[26]
      end
    elseif CirnoState == 7 then
      if love.keyboard.isDown(playerControl[Cirno_pl][3]) then
        CirnoCrouch(dt) --[20]
        if Cirno_crouchvar==1 then
          if love.keyboard.isDown(playerControl[Cirno_pl][5]) then
            CirnoCrouchingWeak(dt) --[24]
          elseif love.keyboard.isDown(playerControl[Cirno_pl][6]) then
            CirnoCrouchingMedium(dt) --[25]
          elseif love.keyboard.isDown(playerControl[Cirno_pl][7]) then
            CirnoCrouchingHeavy(dt, Cirnoside) --[26]
          end
        end
      else
        CirnoStandUp(dt) --[3]
      end
    elseif CirnoState==9 then
      if CirnoGenericVariable==1 then
        CirnoDashForward(dt, Cirnoside) --[17]
      elseif CirnoGenericVariable==2 then
        CirnoDashBackward(dt, Cirnoside) --[18]
      end
    end
    if CirnoEnemyState==5 or CirnoEnemyState==6 or CirnoEnemyState==8 then
      if love.keyboard.isDown(playerControl[Cirno_pl][-Cirnoside+3]) and CirnoState==0 then
        CirnoGuard(dt, Cirnoside) --[14]
      elseif love.keyboard.isDown(playerControl[Cirno_pl][-Cirnoside+3]) and CirnoState==7 then
        CirnoCrouchGuard(dt, Cirnoside) --[19]
      end
    end
  else
    if Cirno_pl == winner then
      if CirnoGenericVariable == 0 then
        Cirno_sprite = 1
        Cirno_sprite2 = 0
        CirnoGenericVariable = 1
      end
      CirnoCharbx = 200
      CirnoCharby = CirnoStageHeight-20
      Cirno_anim_type = 32
      CirnoXSpeed=0
      CirnoState=0
      CirnoAnimationTime=CirnoAnimationTime+dt
      if CirnoAnimationTime > 0.10 then
        Cirno_sprite=Cirno_sprite+1
        CirnoAnimationTime = 0
        if Cirno_sprite2~=0 then
          Cirno_sprite2=Cirno_sprite2+1
        end
      end
      if Cirno_sprite > 2 and Cirno_sprite2==0 then
        CirnoSpecialEffects = 13
        CirnoSpecialEffectX = CirnoCharbx
        CirnoSpecialEffectY = CirnoCharby-70
        Cirno_sprite2 = 5
      end
      if Cirno_sprite>4 then
        Cirno_sprite = 3
      end
      if Cirno_sprite2>7 then
        Cirno_sprite2 = 5
      end
    else
      if CirnoGenericVariable == 0 then
        Cirno_sprite = 1
        CirnoGenericVariable = 1
      end
      CirnoCharbx = 200
      CirnoCharby = CirnoStageHeight+20
      Cirno_anim_type = 33
      CirnoXSpeed=0
      CirnoState=0
      CirnoAnimationTime=CirnoAnimationTime+dt
      if CirnoAnimationTime > 0.10 then
        Cirno_sprite=Cirno_sprite+1
        CirnoAnimationTime = 0
      end
      if Cirno_sprite > 5 then
        Cirno_sprite = 5
      end
    end
  end
  return extraX+CirnoCharbx*prop, extraY+CirnoCharby*prop, extraX+(CirnoCharbx+10)*prop, extraY+(CirnoCharby+5)*prop, Cirno_hitboxX*prop, Cirno_hitboxY*prop, CirnoState, extraX+(CirnoCharbx+CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getWidth())*prop, CirnoSpecialEffects, CirnoAttackBox
end
--------------------------------------------------------------------------------------------
function c1:draw(prop, extraX, extraY, charX, charY, Cirnoside) --[C]
  CirnoCharbx = (charX-extraX)/prop
  CirnoCharby = (charY-extraY)/prop
  if CirnoSpecialEffects==1 then --[22]
    love.graphics.draw(CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2], extraX+CirnoCharbx*prop, extraY+CirnoCharby*prop, 0, Cirnoside*prop, prop, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getWidth()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getWidth())/2, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getHeight()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getHeight())/2)
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX+(CirnoCharbx-75)*prop, extraY+(CirnoCharby-60)*prop, (Cirno_hitboxX+150)*prop, (Cirno_hitboxY+100)*prop)
    CirnoAttackBox = {extraX+(CirnoCharbx-75)*prop, extraY+(CirnoCharby-60)*prop, (Cirno_hitboxX+150)*prop, (Cirno_hitboxY+100)*prop}
    love.graphics.setColor(255,255,255)

  elseif CirnoSpecialEffects==2 then --[26]
    love.graphics.draw(CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2], extraX+(CirnoCharbx+CirnoSpecialEffectX)*prop, extraY+(CirnoCharby+CirnoSpecialEffectY)*prop, 0, Cirnoside*prop, prop, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getWidth()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getWidth())/2, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getHeight()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getHeight())/2)
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX+(CirnoCharbx+Cirnoside*(CirnoSpecialEffectX-15))*prop, extraY+(CirnoCharby+CirnoSpecialEffectY-15)*prop, (Cirno_hitboxX+30)*prop, (Cirno_hitboxY+30)*prop)
    CirnoAttackBox = {extraX+(CirnoCharbx+Cirnoside*(CirnoSpecialEffectX-15)*prop), extraY+(CirnoCharby+CirnoSpecialEffectY-15)*prop, (Cirno_hitboxX+30)*prop, (Cirno_hitboxY+30)*prop}
    love.graphics.setColor(255,255,255)

  elseif CirnoSpecialEffects==3 then --[23]
    love.graphics.draw(CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2], extraX+(CirnoCharbx+CirnoSpecialEffectX)*prop, extraY+(CirnoCharby+CirnoSpecialEffectY)*prop, 0, Cirnoside*0.6*prop, 0.6*prop, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getWidth()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getWidth())/2, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getHeight()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getHeight())/2)
    love.graphics.draw(CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2+1], extraX+(CirnoCharbx+CirnoSpecialEffectX-40)*prop, extraY+(CirnoCharby+CirnoSpecialEffectY+40)*prop, 0, Cirnoside*0.6*prop, 0.6*prop, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getWidth()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getWidth())/2, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getHeight()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getHeight())/2)
    love.graphics.draw(CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2], extraX+(CirnoCharbx+CirnoSpecialEffectX)*prop, extraY+(CirnoCharby+CirnoSpecialEffectY+40)*prop, 0, Cirnoside*0.6*prop, 0.6*prop, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getWidth()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getWidth())/2, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getHeight()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getHeight())/2)
    love.graphics.draw(CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2], extraX+(CirnoCharbx+CirnoSpecialEffectX-40)*prop, extraY+(CirnoCharby+CirnoSpecialEffectY)*prop, 0, Cirnoside*0.6*prop, 0.6*prop, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getWidth()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getWidth())/2, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getHeight()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getHeight())/2)
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX+(CirnoCharbx-25)*prop, extraY+(CirnoCharby-30)*prop, (Cirno_hitboxX+40)*prop, (Cirno_hitboxY+40)*prop)
    CirnoAttackBox = {extraX+(CirnoCharbx-25)*prop, extraY+(CirnoCharby-30)*prop, (Cirno_hitboxX+40)*prop, (Cirno_hitboxY+40)*prop}
    love.graphics.setColor(255,255,255)

  elseif CirnoSpecialEffects==4 then --[25]
    love.graphics.draw(CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2], extraX+(CirnoCharbx+CirnoSpecialEffectX)*prop, extraY+(CirnoCharby+CirnoSpecialEffectY)*prop, CirnoGenericVariable, Cirnoside*0.5*prop, 0.5*prop, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getWidth())/2, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getHeight()/2))
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX+(CirnoCharbx+Cirnoside*(CirnoSpecialEffectX-50))*prop, extraY+(CirnoCharby+CirnoSpecialEffectY-50)*prop, (Cirno_hitboxX+35)*prop, (Cirno_hitboxY+25)*prop)
    CirnoAttackBox = {extraX+(CirnoCharbx+CirnoSpecialEffectX-50)*prop, extraY+(CirnoCharby+CirnoSpecialEffectY-50)*prop, (Cirno_hitboxX+35)*prop, (Cirno_hitboxY+25)*prop}
    love.graphics.setColor(255,255,255)

  elseif CirnoSpecialEffects==5 then --[28]
    love.graphics.draw(CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2], extraX+(CirnoCharbx+CirnoSpecialEffectX)*prop, extraY+(CirnoCharby+CirnoSpecialEffectY)*prop, 0, Cirnoside*prop, prop, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getWidth()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getWidth())/2, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getHeight()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getHeight())/2)
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX+(CirnoCharbx+CirnoSpecialEffectX-75)*prop, extraY+(CirnoCharby+CirnoSpecialEffectY-15)*prop, (Cirno_hitboxX+35)*prop, (Cirno_hitboxY+25)*prop)
    CirnoAttackBox = {extraX+(CirnoCharbx+CirnoSpecialEffectX-75)*prop, extraY+(CirnoCharby+CirnoSpecialEffectY-15)*prop, (Cirno_hitboxX+35)*prop, (Cirno_hitboxY+25)*prop}
    love.graphics.setColor(255,255,255)

  elseif CirnoSpecialEffects==6 then --[29]
    love.graphics.draw(CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2], extraX+(CirnoCharbx+CirnoSpecialEffectX+33)*prop, extraY+(CirnoCharby+CirnoSpecialEffectY+33)*prop, CirnoGenericVariable, Cirnoside*prop, prop, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getWidth())/2+30, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getHeight())/2+40)
    love.graphics.setColor(255,0,0)
    if Cirno_sprite>1 and Cirno_sprite<5 then
      love.graphics.rectangle("line", extraX+(CirnoCharbx+20)*prop, extraY+(CirnoCharby-85)*prop, (Cirno_hitboxX-40)*prop, (Cirno_hitboxY+25)*prop)
      CirnoAttackBox = {extraX+(CirnoCharbx+20)*prop, extraY+(CirnoCharby-85)*prop, (Cirno_hitboxX-40)*prop, (Cirno_hitboxY+25)*prop}
    end
    if Cirno_sprite<8 and Cirno_sprite>4 then
      love.graphics.rectangle("line", extraX+(CirnoCharbx+40)*prop, extraY+(CirnoCharby-10)*prop, Cirno_hitboxX*prop, (Cirno_hitboxY+50)*prop)
      CirnoAttackBox = {extraX+(CirnoCharbx+40)*prop, extraY+(CirnoCharby-10)*prop, Cirno_hitboxX*prop, (Cirno_hitboxY+50)*prop}
    end
    if Cirno_sprite>6 and Cirno_sprite<10 then
      love.graphics.rectangle("line", extraX+(CirnoCharbx-25)*prop, extraY+(CirnoCharby+50)*prop, (Cirno_hitboxX+50)*prop, Cirno_hitboxY*prop)
      CirnoAttackBox = {extraX+(CirnoCharbx-25)*prop, extraY+(CirnoCharby+50)*prop, (Cirno_hitboxX+50)*prop, Cirno_hitboxY*prop}
    end
    if  Cirno_sprite>8 and Cirno_sprite<12 then
      love.graphics.rectangle("line", extraX+(CirnoCharbx-50)*prop, extraY+(CirnoCharby-10)*prop, Cirno_hitboxX*prop, (Cirno_hitboxY+50)*prop)
      CirnoAttackBox = {extraX+(CirnoCharbx-50)*prop, extraY+(CirnoCharby-10)*prop, Cirno_hitboxX*prop, (Cirno_hitboxY+50)*prop}
    end
    if  Cirno_sprite>12 and Cirno_sprite<16 then
      love.graphics.rectangle("line", extraX+(CirnoCharbx+30)*prop, extraY+(CirnoCharby+40)*prop, (Cirno_hitboxX+10)*prop, (Cirno_hitboxY+20)*prop)
      CirnoAttackBox = {extraX+(CirnoCharbx+30)*prop, extraY+(CirnoCharby+40)*prop, (Cirno_hitboxX+10)*prop, (Cirno_hitboxY+20)*prop}
    end
    love.graphics.setColor(255,255,255)

  elseif CirnoSpecialEffects==7 then --[30]
    love.graphics.draw(CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2], extraX+(CirnoCharbx+CirnoSpecialEffectX)*prop, extraY+(CirnoCharby+CirnoSpecialEffectY)*prop, 0, Cirnoside*prop, prop, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getWidth()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getWidth())/2, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getHeight()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getHeight())/2)
    love.graphics.setColor(255,0,0)
    if Cirno_sprite2>9 then
      love.graphics.rectangle("line", extraX+(CirnoCharbx+CirnoSpecialEffectX-20)*prop, extraY+(CirnoCharby+CirnoSpecialEffectY-10)*prop, (Cirno_hitboxX+75)*prop, (Cirno_hitboxY+70)*prop)
      CirnoAttackBox = {extraX+(CirnoCharbx+CirnoSpecialEffectX-20)*prop, extraY+(CirnoCharby+CirnoSpecialEffectY-10)*prop, (Cirno_hitboxX+75)*prop, (Cirno_hitboxY+70)*prop}
    end
    love.graphics.setColor(255,255,255)

  elseif CirnoSpecialEffects==8 then --[31]
    love.graphics.draw(CirnoAnimationFrame[Cirno_anim_type][32], extraX+400*prop, extraY+300*prop, 0, Cirnoside*3.2*prop, 3.2*prop, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getWidth())/2, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getHeight())/2)
    love.graphics.draw(CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2], extraX+(CirnoCharbx+CirnoSpecialEffectX)*prop, extraY+(CirnoCharby+CirnoSpecialEffectY)*prop, 0, Cirnoside*prop, prop, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getWidth()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getWidth())/2, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getHeight()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getHeight())/2)
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX, extraY, 800*prop, 600*prop)
    CirnoAttackBox = {extraX, extraY, 800*prop, 600*prop}
    love.graphics.setColor(255,255,255)

  elseif CirnoSpecialEffects==9 then --[14]
    love.graphics.draw(CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2], extraX+(CirnoCharbx+CirnoSpecialEffectX)*prop, extraY+(CirnoCharby+CirnoSpecialEffectY)*prop, 0, Cirnoside*prop, prop, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getWidth()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getWidth())/2, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getHeight()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getHeight())/2)
    
  elseif CirnoSpecialEffects==10 then --[21]
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX+(CirnoCharbx+45)*prop, extraY+(CirnoCharby+20)*prop, (Cirno_hitboxX-30)*prop, (Cirno_hitboxY-40)*prop)
    CirnoAttackBox = {extraX+(CirnoCharbx+45)*prop, extraY+(CirnoCharby+20)*prop, (Cirno_hitboxX-30)*prop, (Cirno_hitboxY-40)*prop}
    love.graphics.setColor(255,255,255)
    
  elseif CirnoSpecialEffects==11 then --[24]
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX+(CirnoCharbx+45)*prop, extraY+(CirnoCharby+40)*prop, (Cirno_hitboxX-30)*prop, (Cirno_hitboxY-40)*prop)
    CirnoAttackBox = {extraX+(CirnoCharbx+45)*prop, extraY+(CirnoCharby+40)*prop, (Cirno_hitboxX-30)*prop, (Cirno_hitboxY-40)*prop}
    love.graphics.setColor(255,255,255)
    
  elseif CirnoSpecialEffects==12 then --[27]
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX+(CirnoCharbx+40)*prop, extraY+(CirnoCharby+55)*prop, (Cirno_hitboxX-30)*prop, (Cirno_hitboxY-40)*prop)
    CirnoAttackBox = {extraX+(CirnoCharbx+40)*prop, extraY+(CirnoCharby+55)*prop, (Cirno_hitboxX-30)*prop, (Cirno_hitboxY-40)*prop}
    love.graphics.setColor(255,255,255)
  
  elseif CirnoSpecialEffects==13 then
    love.graphics.draw(CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2], extraX+CirnoSpecialEffectX*prop, extraY+CirnoSpecialEffectY*prop, 0, Cirnoside*prop, prop, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getWidth()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getWidth())/2, (CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite2]:getHeight()-CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getHeight())/2)
  end

  love.graphics.draw(CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite], extraX+(CirnoCharbx+34.5)*prop, extraY+CirnoCharby*prop, 0, Cirnoside*prop, prop, CirnoAnimationFrame[Cirno_anim_type][Cirno_sprite]:getWidth()/2, 0)
  --love.graphics.rectangle("line", extraX+CirnoCharbx*prop, extraY+CirnoCharby*prop, Cirno_hitboxX*prop, Cirno_hitboxY*prop)
  love.graphics.setColor(0,0,255)
  --love.graphics.rectangle("line", extraX+CirnoCharbx*prop, extraY+(CirnoCharby+5)*prop, (Cirno_hitboxX-10)*prop, (Cirno_hitboxY-10)*prop)
  love.graphics.setColor(255,255,255)
end

return c1