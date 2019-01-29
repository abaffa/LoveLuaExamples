local c2 = {}
--[[ COMENTARIOS INDICADORES (INDICE) [0]

      [1] WALK FOWARD, [2] WALK BACKWARD, [3] STAND UP, [4] STAND, [5] LANDING ON GROUND, [6] LANDING, [7] JUMP FORWARD,
      [8] JUMP BACKWARD, [9] JUMP, [10] INTERFACE, [11] HIT LOW, [12] HIT HIGH, [13] HIT AIR, [14] GUARD, [15] GETTING BACK UP,
      [16] FALLING, [17] DASH FORWARD, [18] DASH BACKWARD, [19] CROUCH GUARD, [20] CROUCH, [21] NEUTRAL WEAK, [22] NEUTRAL HEAVY,
      [23] NEUTRAL MEDIUM, [24] CROUCH WEAK, [25] CROUCH MEDIUM, [26] CROUCH HEAVY, [27] AIR WEAK, [28] AIR MEDIUM, [29] AIR HEAVY,
      [30] SPECIAL, [31] SUPER.
      
      [A] c2:new(), [B] c2:update(), [C] c2:draw().
]]
local BowserSize = 1
local playerControl = {{"w","a","s","d","g","h","j","k","space","t"},{"up","left","down","right","kp4","kp8","kp9","kp+","kp0","kp7"}}
local BowserGravity = 1.2
--local BowserJump = 1.1
local BowserHP = 120
local BowserAnimationFrame ={}
local BowserAnimationTime = 0
local BowserAnimationSize = {6,6,6,4,2,2,3,2,5,1,3,3,2,1,1,4,5,11,3,3,12,9,6,2,8,7,8,5,3,11,9}
local Bowser_count = 1
local Bowser_anim_type=4
local BowserState=0 --Estado da Bowser: 0 é normal, 1 é no ar, 2 é em hitstun, 3 é caido, 4 é guardando, 5 é atacando, 6 é atacando no ar, 7 é agachada, 8 é atacando agachada, 9 é dash
local BowserStageHeight
local BowserCharbx
local BowserCharby
local BowserXSpeed = 0
local BowserYSpeed = 0
local Bowser_sprite = 1
local Bowser_sprite2 = 1
local BowserGenericVariable = 0
local BowserGenericVariableAtk = 0
local BowserAttacktype = 0
local BowserSpecialEffects =0
local BowserSpecialEffectX =0
local BowserSpecialEffectY =0
 -- 5,6 e 8 ativa Guard
local BowserGuardtype=0
local Bowser_hitboxX=80
local Bowser_hitboxY=80
local Bowser_crouchvar=0
local Bowser_pl = 0

function c2:new(pos_chao, prop, extraX, extraY, playerNum) --[A]
  Bowser_pl = playerNum
  BowserCharbx=700
  for i=1,31 do
    BowserAnimationFrame[i] = {}
    for j=1,BowserAnimationSize[i] do
      BowserAnimationFrame[i][j]=love.graphics.newImage("characters/char/Bowser/Bowser"..Bowser_count..".png")
      Bowser_count=Bowser_count+1
    end
  end
  BowserStageHeight = pos_chao - BowserAnimationFrame[Bowser_anim_type][Bowser_sprite]:getHeight()*1.3 -- Alterado por pos_chao. Crie uma variável pos_chao na main e coloque assim: "Bowser:new(pos_chao)"
  BowserCharby = BowserStageHeight
  Bowser_count=1
  return {extraX+BowserCharbx*prop, extraY+BowserCharby*prop, Bowser_hitboxX*prop, Bowser_hitboxY*prop}, {extraX+BowserCharbx*prop, extraY+(BowserCharby+5)*prop, (Bowser_hitboxX-10)*prop, (Bowser_hitboxY-10)*prop}
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserWalkForward(dt) --[1]
  Bowser_anim_type=1
  BowserXSpeed=90
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.15 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 6 then
    Bowser_sprite= 1
    BowserXSpeed=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserWalkBackward(dt) --[2]
  BowserAnimationTime=BowserAnimationTime+dt
  Bowser_anim_type=2
  BowserXSpeed=-90
  
  if BowserAnimationTime > 0.15 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 6 then
    Bowser_sprite= 1
    BowserXSpeed=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserStandUp(dt) --[3]
  if BowserGenericVariable==0 then
    Bowser_sprite=1
    BowserGenericVariable=1
  end
  
  Bowser_anim_type=3
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.15 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 6 then
    Bowser_sprite= 1
    BowserState=0
    BowserGenericVariable=0
    Bowser_crouchvar=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserStand(dt) --[4]
  BowserXSpeed=0
  Bowser_anim_type=4
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.15 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 4 then
    Bowser_sprite= 1
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserLanding(dt) --[6]
  if BowserGenericVariable==0 then
    Bowser_sprite=1
    BowserGenericVariable=1
  end
  
  BowserXSpeed=0
  Bowser_anim_type=6
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.10 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 2 then
    Bowser_sprite= 1
    BowserState=0
    BowserGenericVariable=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserLandingOnGround(dt) --[5]
  Bowser_anim_type=5
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.15 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 2 then
    Bowser_sprite=2
    BowserState=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserJumpForward(dt) --[7]
  if BowserState==0 then
    BowserYSpeed=-400
  end
  
  BowserState=1
  Bowser_anim_type=7
  BowserXSpeed=120
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.10 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 3 then
    Bowser_sprite=1
    BowserXSpeed=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserJumpBackward(dt)--[8]
  if BowserState==0 then
    BowserYSpeed=-400
  end
  
  BowserState=1
  Bowser_anim_type=8
  BowserXSpeed=-120
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.10 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 2 then
    Bowser_sprite=1
    BowserXSpeed=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserJump(dt) --[9]
  if BowserState==0 then
    BowserYSpeed=-400
  end
  
  BowserXSpeed=0
  BowserState=1
  Bowser_anim_type=9
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.15 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 5 then
    Bowser_sprite=5
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserHitLow(dt) --[11]
  BowserState=2
  Bowser_anim_type=11
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.15 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 3 then
    Bowser_sprite=1
    BowserState=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserHitHigh(dt) --[12]
  BowserState=2
  Bowser_anim_type=12
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.15 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 3 then
    Bowser_sprite=1
    BowserState=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserHitAir(dt) --[13]
  BowserState=2
  Bowser_anim_type=13
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.15 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 2 then
    Bowser_sprite=2
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserGuard(dt) --[14]
  if BowserGenericVariable==0 then
    Bowser_sprite=1
    BowserGenericVariable=1
  end
  
  BowserState=4
  BowserGuardtype=0
  BowserXSpeed=0
  Bowser_anim_type=14
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.15 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 2 and BowserGenericVariable==1 then
    Bowser_sprite=1
  end
  
  if love.keyboard.isDown(playerControl[Bowser_pl][3]) then
    BowserCrouchGuard(dt)
  end
  
  if not love.keyboard.isDown(playerControl[Bowser_pl][2]) then
    BowserGenericVariable=2
  end
  
  if Bowser_sprite>2 then
    Bowser_sprite=1
    BowserState=0
    BowserGuardtype=0
    BowserGenericVariable=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserGettingBackUp(dt) --[15]
  Bowser_anim_type=15
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.15 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 1 then
    Bowser_sprite=1
    BowserState=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserFalling(dt) --[16]
  Bowser_anim_type=16
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.10 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 4 then
    Bowser_sprite=1
  end
  
  if love.keyboard.isDown(playerControl[Bowser_pl][4]) then
    BowserXSpeed=90
  elseif love.keyboard.isDown(playerControl[Bowser_pl][2]) then
    BowserXSpeed=-90
  else 
    BowserXSpeed=0 
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserDashForward(dt) --[17]
  if BowserGenericVariable==0 then
    Bowser_sprite=1
    BowserGenericVariable=1
  end
  
  BowserState=9
  Bowser_anim_type=17
  BowserXSpeed=0
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.12 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 2 then
    BowserXSpeed=180
  end
  if Bowser_sprite > 4 and love.keyboard.isDown(playerControl[Bowser_pl][10]) and love.keyboard.isDown(playerControl[Bowser_pl][4]) then
    Bowser_sprite=3
  elseif Bowser_sprite>4 then
    BowserXSpeed=0
  end
  
  if not love.keyboard.isDown(playerControl[Bowser_pl][10]) or not love.keyboard.isDown(playerControl[Bowser_pl][4]) then
    if Bowser_sprite < 5 then
      Bowser_sprite=5
    end
  end
  
  if Bowser_sprite > 5 then
    Bowser_sprite=1
    BowserGenericVariable=0
    BowserXSpeed=0
    BowserState=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserDashBackward(dt) --[18]
  if BowserGenericVariable==0 then
    Bowser_sprite=1
    BowserGenericVariable=2
  end
  
  BowserState=9
  Bowser_anim_type=18
  BowserXSpeed=0
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.10 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 3 then
    BowserXSpeed=-180
  end
  
  if Bowser_sprite > 7 and love.keyboard.isDown(playerControl[Bowser_pl][10]) and love.keyboard.isDown(playerControl[Bowser_pl][2]) then
    Bowser_sprite=4
  elseif Bowser_sprite>7 then
    BowserXSpeed=0
  end
  
  if not love.keyboard.isDown(playerControl[Bowser_pl][10]) or not love.keyboard.isDown(playerControl[Bowser_pl][2]) then
    if Bowser_sprite < 8 then
      Bowser_sprite=8
    end
  end
  
  if Bowser_sprite > 11 then
    Bowser_sprite=1
    BowserGenericVariable=0
    BowserXSpeed=0
    BowserState=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserCrouchGuard(dt) --[19]
  if BowserGenericVariable==0 then
    Bowser_sprite=1
    BowserGenericVariable=1
  end
  
  BowserState=4
  BowserGuardtype=1
  BowserXSpeed=0
  Bowser_anim_type=19
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.15 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 3 and BowserGenericVariable==1 then
    Bowser_sprite=1
  end
  
  if not love.keyboard.isDown(playerControl[Bowser_pl][2]) then
    BowserGenericVariable=2
  end
  
  if not love.keyboard.isDown(playerControl[Bowser_pl][3]) then
    BowserGuard(dt)
  end
  
  if Bowser_sprite>3 then
    Bowser_sprite=1
    BowserState=0
    BowserGuardtype=0
    BowserGenericVariable=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserCrouch(dt) --[20]
  if Bowser_crouchvar~=1 then
    Bowser_sprite=1
    Bowser_crouchvar=1
  end
  
  BowserXSpeed=0
  BowserState=7
  Bowser_anim_type=20
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.15 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  if Bowser_sprite>2 then
    Bowser_sprite=3
    --Bowser_crouchvar=1
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserNeutralWeak(dt) --[21]
  if BowserGenericVariableAtk==0 then
    Bowser_sprite=1
    BowserGenericVariableAtk=1
  end
  
  BowserXSpeed=0
  BowserAttacktype=1
  BowserState=5
  Bowser_anim_type=21
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.06 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 12 then
    Bowser_sprite=1
    BowserState=0
    BowserAttacktype=0
    BowserGenericVariableAtk=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserNeutralHeavy(dt) --[22]
  if BowserGenericVariableAtk==0 then
    Bowser_sprite=1
    BowserGenericVariableAtk=1
  end
  
  BowserXSpeed=0
  BowserAttacktype=3
  BowserState=5
  Bowser_anim_type=22
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.10 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 9 then
    Bowser_sprite=1
    BowserState=0
    BowserAttacktype=0
    BowserGenericVariableAtk=0
    BowserGenericVariable=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserNeutralMedium(dt) --[23]
  if BowserGenericVariableAtk==0 then
    Bowser_sprite=1
    BowserGenericVariableAtk=1
  end
  
  BowserXSpeed=0
  BowserAttacktype=2
  BowserState=5
  Bowser_anim_type=23
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.10 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 6 then
    Bowser_sprite=1
    BowserState=0
    BowserAttacktype=0
    BowserGenericVariableAtk=0
    BowserGenericVariable=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserCrouchingWeak(dt) --[24]
  if BowserGenericVariableAtk==0 then
    Bowser_sprite=1
    BowserGenericVariableAtk=1
  end
  
  BowserXSpeed=0
  BowserAttacktype=1
  BowserState=8
  Bowser_anim_type=24
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.10 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 2 then
    Bowser_sprite=1
    BowserState=7
    BowserAttacktype=0
    BowserGenericVariableAtk=0
    BowserGenericVariable=
    
     0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserCrouchingMedium(dt) --[25]
  if BowserGenericVariableAtk==0 then
    Bowser_sprite=1
    BowserGenericVariableAtk=1
  end
  
  BowserXSpeed=0
  BowserAttacktype=2
  BowserState=8
  Bowser_anim_type=25
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.125 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite>8 then
    Bowser_sprite=1
    BowserState=7
    BowserAttacktype=0
    BowserGenericVariableAtk=0
    BowserSpecialEffects=0
    BowserGenericVariable=0
    BowserSpecialEffectX=0
    BowserSpecialEffectY=0
    BowserXSpeed=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserCrouchingHeavy(dt) --[26]
  if BowserGenericVariableAtk==0 then
    Bowser_sprite=1
    BowserGenericVariableAtk=1
  end
  
  BowserXSpeed=0
  BowserAttacktype=3
  BowserState=8
  Bowser_anim_type=26
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.10 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite>2 then
    BowserGenericVariable=BowserGenericVariable+2*dt
    BowserXSpeed=180
    if BowserGenericVariable<1 and Bowser_sprite>6 then
      Bowser_sprite=3
    end
  end
  
  if Bowser_sprite>6 then
    BowserXSpeed=0
  end
  
  if Bowser_sprite>7 then
    Bowser_sprite=1
    BowserState=7
    BowserAttacktype=0
    BowserGenericVariableAtk=0
    BowserGenericVariable=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserAirWeak(dt) --[27]
  if BowserGenericVariableAtk==0 then
    Bowser_sprite=1
    BowserGenericVariableAtk=1
  end
  
  BowserAttacktype=1
  BowserState=6
  Bowser_anim_type=27
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.10 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 8 then
    Bowser_sprite=1
    BowserAttacktype=0
    BowserGenericVariableAtk=0
    BowserGenericVariable=0
    BowserState=1
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserAirMedium(dt) --[28]
  if BowserGenericVariableAtk==0 then
    Bowser_sprite=1
    BowserGenericVariableAtk=1
  end
  
  BowserAttacktype=2
  BowserState=6
  Bowser_anim_type=28
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.08 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 5 then
    Bowser_sprite=1
    BowserAttacktype=0
    BowserGenericVariableAtk=0
    BowserGenericVariable=0
    BowserState=1
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserAirHeavy(dt) --[29]
  if BowserGenericVariableAtk==0 then
    Bowser_sprite=1
    BowserGenericVariableAtk=1
  end
  
  BowserAttacktype=3
  BowserState=6
  Bowser_anim_type=29
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.12 then
    Bowser_sprite=Bowser_sprite+1
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 3 then
    Bowser_sprite=1
    BowserAttacktype=0
    BowserGenericVariableAtk=0
    BowserGenericVariable=0
    BowserState=1
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserSpecial(dt) --[30]
  if BowserGenericVariableAtk==0 then
    Bowser_sprite=1
    BowserGenericVariableAtk=1
  end
  
  BowserXSpeed=0
  BowserAttacktype=4
  BowserState=5
  Bowser_anim_type=30
  BowserAnimationTime=BowserAnimationTime+dt
  
  if BowserAnimationTime > 0.15 then
    Bowser_sprite=Bowser_sprite+1
    if BowserGenericVariable==1 then
      Bowser_sprite2=Bowser_sprite2+1
    end
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite>2 and BowserGenericVariable==0 then
    BowserSpecialEffects=7
    Bowser_sprite2=6
    BowserGenericVariable=1
    BowserSpecialEffectX=100 -- Alterar para os efeitos do Especial
    BowserSpecialEffectY=20 -- Alterar para os efeitos do Especial
  end
  
  if Bowser_sprite>4 and BowserGenericVariable==1 then
    Bowser_sprite=3
  end
  
  if Bowser_sprite2>11 then
    BowserGenericVariable=2
    BowserSpecialEffects=0
    BowserSpecialEffectX=0
    BowserSpecialEffectY=0
  end
  
  if Bowser_sprite > 5 then
    Bowser_sprite=1
    BowserState=0
    BowserAttacktype=0
    BowserGenericVariableAtk=0
    Bowser_sprite2=0
    BowserGenericVariable=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function BowserSuper(dt) --[31]
  if BowserGenericVariableAtk==0 then
    Bowser_sprite=1
    BowserGenericVariableAtk=1
  end
  
  BowserAttacktype=5
  BowserState=5
  Bowser_anim_type=31
  BowserAnimationTime=BowserAnimationTime+dt
  BowserXSpeed = 360
  
  if BowserAnimationTime > 0.15 then
    Bowser_sprite=Bowser_sprite+1
    BowserSize = BowserSize + 0.15
    BowserAnimationTime = 0
  end
  
  if Bowser_sprite > 9 then
    BowserSize = 1
    Bowser_sprite=1
    BowserAttacktype=0
    BowserState=0
    BowserGenericVariableAtk=0
    Bowser_sprite2=0
    BowserGenericVariable=0
    BowserSpecialEffects=0
    BowserSpecialEffectX=0
  end
end
--x--x--x--x--x--x--x--x--x--x--x--

function c2:update(dt, prop, extraX, extraY, pos_chao, BowserEnemyState) --[B]
  --MOVEMENT SYSTEM-- BEGIN
  BowserCharbx=BowserCharbx+BowserXSpeed*dt
  BowserCharby=BowserCharby+BowserYSpeed*dt--+BowserGravity*250*math.pow(dt,2)
  BowserYSpeed=BowserYSpeed+BowserGravity*500*dt
    
  if BowserCharby>BowserStageHeight then
    BowserCharby=BowserStageHeight
    BowserYSpeed=0
    if BowserState==1 or BowserState==6 then
      BowserLanding(dt)
      BowserAttacktype=0
      Bowser_sprite2=0
      BowserSpecialEffects=0
      BowserGenericVariableAtk=0
      BowserSpecialEffects=0
      BowserSpecialEffectX=0
      BowserSpecialEffectY=0
    elseif Bowser_crouchvar==1 then
      BowserCharby=BowserStageHeight
    end
  end
  --MOVEMENT SYSTEM-- END
  
  if BowserState == 0 then
    if love.keyboard.isDown(playerControl[Bowser_pl][5]) then
      BowserNeutralWeak(dt) --[21]
    elseif love.keyboard.isDown(playerControl[Bowser_pl][6]) then
      BowserNeutralMedium(dt) --[23]
    elseif love.keyboard.isDown(playerControl[Bowser_pl][7]) then
      BowserNeutralHeavy(dt) --[22]
    elseif love.keyboard.isDown(playerControl[Bowser_pl][8]) then
      BowserSpecial(dt) --[30]
    elseif love.keyboard.isDown(playerControl[Bowser_pl][9]) then
      BowserSuper(dt) --[31]
    elseif love.keyboard.isDown(playerControl[Bowser_pl][4]) then
      BowserWalkForward(dt) --[1]
      if love.keyboard.isDown(playerControl[Bowser_pl][1]) then
        Bowser_sprite=1
        BowserJumpForward(dt) --[7]
      elseif love.keyboard.isDown(playerControl[Bowser_pl][10]) then
        BowserDashForward(dt) --[17]
      end
    elseif love.keyboard.isDown(playerControl[Bowser_pl][2]) then
      BowserWalkBackward(dt) --[2]
      if love.keyboard.isDown(playerControl[Bowser_pl][1]) then
        Bowser_sprite=1
        BowserJumpBackward(dt) --[8]
      elseif love.keyboard.isDown(playerControl[Bowser_pl][10]) then
        BowserDashBackward(dt) --[18]
      end
    elseif love.keyboard.isDown(playerControl[Bowser_pl][3]) then
      Bowser_sprite=1
      BowserCrouch(dt) --[20]
    elseif love.keyboard.isDown(playerControl[Bowser_pl][1]) then
      Bowser_sprite=1
      BowserJump(dt) --[9]
    else
      BowserStand(dt) --[4]
    end
  elseif BowserState == 1 then
    if BowserYSpeed<0 then
      if love.keyboard.isDown(playerControl[Bowser_pl][2]) then
        BowserJumpBackward(dt) --[8]
      elseif love.keyboard.isDown(playerControl[Bowser_pl][4]) then
        BowserJumpForward(dt) --[7]
      else BowserJump(dt) --[9]
      end
    end
    if BowserYSpeed>0 then
      BowserFalling(dt) --[16]
    end
    if love.keyboard.isDown(playerControl[Bowser_pl][5]) then
      BowserAirWeak(dt) --[27]
    elseif love.keyboard.isDown(playerControl[Bowser_pl][6]) then
      BowserAirMedium(dt) --[28]
    elseif love.keyboard.isDown(playerControl[Bowser_pl][7]) then
      BowserAirHeavy(dt) --[29]
    end
  elseif BowserState == 3 then
    if love.keyboard.isDown(playerControl[Bowser_pl][1]) then
      BowserGettingBackUp(dt) --[15]
    end
  elseif BowserState==4 then
    if BowserGuardtype==0 then
      BowserGuard(dt) --[14]
    elseif BowserGuardtype==1 then
      BowserCharby=BowserStageHeight
      BowserCrouchGuard(dt) --[19]
    end
  elseif BowserState == 5 then
    if BowserAttacktype == 1 then
      BowserNeutralWeak(dt) --[21]
    elseif BowserAttacktype == 2 then
      BowserNeutralMedium(dt) --[23]
    elseif BowserAttacktype == 3 then
      BowserNeutralHeavy(dt) --[22]
    elseif BowserAttacktype == 4 then
      BowserSpecial(dt) --[30]
    elseif BowserAttacktype == 5 then
      BowserSuper(dt) --[31]
    end
  elseif BowserState == 6 then
    if BowserAttacktype == 1 then
      BowserAirWeak(dt) --[27]
    elseif BowserAttacktype == 2 then
      BowserAirMedium(dt) --[28]
    elseif BowserAttacktype == 3 then
      BowserAirHeavy(dt) --[29]
    end
  elseif BowserState==8 then
    if BowserAttacktype == 1 then
      BowserCrouchingWeak(dt) --[24]
    elseif BowserAttacktype == 2 then
      BowserCrouchingMedium(dt) --[25]
    elseif BowserAttacktype == 3 then
      BowserCrouchingHeavy(dt) --[26]
    end
  elseif BowserState == 7 then
    if love.keyboard.isDown(playerControl[Bowser_pl][3]) then
      BowserCrouch(dt) --[20]
      if Bowser_crouchvar==1 then
        if love.keyboard.isDown(playerControl[Bowser_pl][5]) then
          BowserCrouchingWeak(dt) --[24]
        elseif love.keyboard.isDown(playerControl[Bowser_pl][6]) then
          BowserCrouchingMedium(dt) --[25]
        elseif love.keyboard.isDown(playerControl[Bowser_pl][7]) then
          BowserCrouchingHeavy(dt) --[26]
        end
      end
    else
      BowserStandUp(dt) --[3]
    end
  elseif BowserState==9 then
    if BowserGenericVariable==1 then
      BowserDashForward(dt) --[17]
    elseif BowserGenericVariable==2 then
      BowserDashBackward(dt) --[18]
    end
  end
  if BowserEnemyState==5 or BowserEnemyState==6 or BowserEnemyState==8 then
    if love.keyboard.isDown(playerControl[Bowser_pl][2]) and BowserState==0 then
      BowserGuard(dt) --[14]
    elseif love.keyboard.isDown(playerControl[Bowser_pl][2]) and BowserState==7 then
      BowserCrouchGuard(dt) --[19]
    end
  end
  return extraX+BowserCharbx*prop, extraY+BowserCharby*prop, extraY+(BowserCharby+5)*prop, (Bowser_hitboxX-10)*prop, BowserSize*BowserAnimationFrame[Bowser_anim_type][Bowser_sprite]:getWidth()*prop*1.3, BowserSize*BowserAnimationFrame[Bowser_anim_type][Bowser_sprite]:getHeight()*prop*1.3, BowserState
end
----------------------------------------------------------------------------------------------------------------------------

function c2:draw(prop, extraX, extraY, charX, charY) --[C]
  BowserCharbx = (charX-extraX)/prop
  BowserCharby = (charY-extraY)/prop
  
  if BowserSpecialEffects==7 then --[30]
    love.graphics.draw(BowserAnimationFrame[Bowser_anim_type][Bowser_sprite2], extraX+(BowserCharbx+BowserSpecialEffectX)*prop, extraY+(BowserCharby+BowserSpecialEffectY)*prop, 0, 2*prop, prop, (BowserAnimationFrame[Bowser_anim_type][Bowser_sprite2]:getWidth()-BowserAnimationFrame[Bowser_anim_type][Bowser_sprite]:getWidth())/2, (BowserAnimationFrame[Bowser_anim_type][Bowser_sprite2]:getHeight()-BowserAnimationFrame[Bowser_anim_type][Bowser_sprite]:getHeight())/2)
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line", extraX+(BowserCharbx+BowserSpecialEffectX-20)*prop, extraY+(BowserCharby+BowserSpecialEffectY-10)*prop, 2*BowserAnimationFrame[Bowser_anim_type][Bowser_sprite2]:getWidth()*prop, BowserAnimationFrame[Bowser_anim_type][Bowser_sprite2]:getHeight()*prop)
    love.graphics.setColor(255,255,255)
  end
  
  love.graphics.draw(BowserAnimationFrame[Bowser_anim_type][Bowser_sprite], extraX+BowserCharbx*prop, extraY+BowserCharby*prop, 0, 1.3*prop*BowserSize)
  love.graphics.rectangle("line", extraX+BowserCharbx*prop, extraY+BowserCharby*prop,1.3*BowserAnimationFrame[Bowser_anim_type][Bowser_sprite]:getWidth()*prop, 1.3*BowserAnimationFrame[Bowser_anim_type][Bowser_sprite]:getHeight()*prop)
  love.graphics.setColor(0,0,255)
  love.graphics.rectangle("line", extraX+BowserCharbx*prop, extraY+(BowserCharby+5)*prop, (Bowser_hitboxX-10)*prop, (Bowser_hitboxY-10)*prop)
  love.graphics.setColor(255,255,255)
end

return c2