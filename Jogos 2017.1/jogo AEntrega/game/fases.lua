local color1, color2, sptile1, sptile2

local fases = {
  fase = 1,
  colors = {},
  obstc = {jumpable = {}, njumpable = {}},
  ambient = {}
  
}
-- colors
skyblue     = {100, 150, 235};
browndarker = {66, 43, 1};
darkgray    = {169, 169, 169};
greenmedium = {10, 111, 10};
whitesmoke  = {245, 245, 245};
darkgreen   = {0, 100, 0};
darkergreen = {1, 30, 5};
greenwet    = {5, 51, 12};
brownlight  = {207, 134, 50};
browndrak   = {163, 104, 0};
white       = {255, 255, 255};
darkergray  = {50, 60, 70};
gray        = {78, 88, 104};
sand        = {239, 235, 117};
darksand    = {204, 199, 75};

-- sprites
SPRITES = {
  NIL    =      { x =    0, y =    0,  w =      0, h =    0},
  TREE1  =      { x =    0, y =   50,  w =    232, h =  153},
  TREE2  =      { x =  442, y =  270,  w =    190, h =  255},
  TREE3  =      { x =  442, y =    8,  w =    278, h =  266},
  TREE4  =      { x =  746, y =   34,  w =    187, h =  230},
  TREE5  =      { x =  753, y =  300,  w =    670, h =  790},
  TREE6  =      { x =  113, y =  895,  w =    356, h =  486},
  CAR01  = 		  { x =  	0, y = 	   0,  w =	   82, h =	 46},
  CAR02  = 		  { x =  180, y =    0,  w =	   82, h =	 46},
  BIKE   =      { x =  272, y = 	50,  w =	   68, h =	120},
  WATER  =      { x =  235, y =   50,  w =     40, h =   66},
  TOOL   =      { x =  277, y =   50,  w =     57, h =   58},  
  ROCK   =      { x =  233, y =  114,  w =    100, h =   58},
  CONE   =      { x =  236, y =  188,  w =     91, h =  105},
  LAMP   =      { x =   86, y =  226,  w =     50, h =  345},
  TRASH  =      { x =  239, y =  310,  w =     66, h =   38},
  CACTUS =      { x =  242, y =  361,  w =     40, h =   71},
  LIZARD =      { x =  223, y =  450,  w =    118, h =   52},
  LOG    =      { x =  199, y =  513,  w =    162, h =   86},
  PINE   =      { x =  228, y =  667,  w =    120, h =   40},
  SAND   =      { x =   43, y =  800,  w =    155, h =   55},
  PIGEON =      { x =  275, y =  761,  w =     78, h =   76},
  JAGUAR =      { x =  453, y =  657,  w =    255, h =  103},
  MACAW  =      { x =  534, y =  828,  w =    118, h =  250},
  MACAW2 =      { x =  964, y = 1161,  w =     93, h =  200},
  CROCO  =      { x = 1021, y =  134,  w =    326, h =   82},
  NET    =      { x = 1347, y =  138,  w =    321, h =  230},
  SNAKE  =      { x =   56, y =  632,  w =    113, h =  100},
  ARMAD  =      { x =   92, y = 1442,  w =     81, h =   60}  
}

color = {}
for x = 1, 6, 1 do
  color1   = greenmedium
  color2   = darkgreen
  color    = {grassL = color1, grassD = color2}
  spritetile = {tree = SPRITES.TREE1, elemcity = SPRITES.LAMP, elemcity2 = SPRITES.NIL}
  table.insert(fases.colors, color)
  table.insert(fases.obstc.jumpable, SPRITES.ROCK)
  table.insert(fases.obstc.njumpable, SPRITES.CONE)
  table.insert(fases.ambient, spritetile)
end  
--fase1--------
fases.ambient[1].tree      = SPRITES.TREE1
--fases.ambient[1].elemcity = SPRITES.
fases.obstc.jumpable[1]    = SPRITES.PINE

--fase2--------
fases.colors[2].grassL     = darkergray
fases.colors[2].grassD     = gray
fases.obstc.jumpable[2]    = SPRITES.TRASH
fases.ambient[2].tree      = SPRITES.TREE4
--fases.ambient[2].tree      = SPRITES.

--fase3--------
fases.ambient[3].tree       = SPRITES.TREE2
fases.ambient[3].elemcity   = SPRITES.TREE2
fases.ambient[3].elemcity2  = SPRITES.NET
fases.obstc.jumpable[3]     = SPRITES.SAND
fases.obstc.njumpable[3]    = SPRITES.PIGEON
fases.colors[3].grassL      = sand
fases.colors[3].grassD      = darksand
--fases.music[3]              = rio

--fase4--------
fases.colors[4].grassL     = brownlight
fases.colors[4].grassD     = browndrak
fases.ambient[4].tree      = SPRITES.TREE3
fases.ambient[4].elemcity  = SPRITES.CACTUS
fases.obstc.njumpable[4]   = SPRITES.LIZARD

--fase5--------
fases.obstc.njumpable[5]   = SPRITES.LOG
fases.obstc.jumpable[5]    = SPRITES.ARMAD
fases.ambient[5].elemcity  = SPRITES.JAGUAR
fases.ambient[5].elemcity2 = SPRITES.MACAW
fases.ambient[5].tree      = SPRITES.TREE5

--fase6--------
fases.ambient[6].tree      = SPRITES.TREE6
fases.ambient[6].elemcity2 = SPRITES.CROCO
fases.ambient[6].elemcity  = SPRITES.MACAW2
fases.colors[6].grassL     = greenwet
fases.colors[6].grassD     = darkergreen
fases.obstc.njumpable[6]   = SPRITES.SNAKE

--
SPRITES.CARS = {SPRITES.CAR01, SPRITES.CAR02}
SPRITES.COLLECTABLE = {SPRITES.WATER, SPRITES.TOOL}
SPRITES.SCALE = 4.26
-- road config
ROAD = {
      LENGTH = { NONE= 0, SHORT=  25, MEDIUM=  40, LONG=  80 },
      CURVE =  { NONE= 0, EASY=    2, MEDIUM=   4, HARD=    6 }
 };


-- colors scheme
--[[COLORS = {
  SKY =  skyblue,
  LIGHT =  { road = darkgray, grass = fases.colors[fases.fase].grassL, lane = whitesmoke },
  DARK =   { road = darkgray, grass = fases.colors[fases.fase].grassD },
  START =  { road = white,    grass = fases.colors[fases.fase].grassL  }
};]]

function buildFaseRoad(fase)----------------------------
  -------------FASE 1
   if fase == 1 then
  addStraight(ROAD.LENGTH.SHORT/4)
	addSCurves()
	addStraight(ROAD.LENGTH.LONG)
	addSCurves()
	addCurve(ROAD.LENGTH.LONG, -ROAD.CURVE.MEDIUM)
	addCurve(ROAD.LENGTH.LONG, ROAD.CURVE.MEDIUM)
	addCurve(ROAD.LENGTH.LONG, -ROAD.CURVE.EASY)
	addStraight(ROAD.LENGTH.SHORT)
  addCurve(ROAD.LENGTH.LONG, ROAD.CURVE.HARD)
  addStraight(ROAD.LENGTH.LONG)
  
	pSegment = findSegment(playerZ)["index"]
	segments[pSegment + 2]["color"] = COLORS.START;
	segments[pSegment + 3]["color"] = COLORS.START;
   --segments[pSegment + 4]["color"] = COLORS.START;
	--segments[pSegment + 5]["color"] = COLORS.START;
  
  trackLength = tablelength(segments) * segmentLength;
end

  -------------FASE 2
 if fase == 2 then
  addStraight(ROAD.LENGTH.MEDIUM)
	addSCurves()
	addCurve(ROAD.LENGTH.MEDIUM, ROAD.CURVE.HARD)
	addStraight(ROAD.LENGTH.MEDIUM)
	addCurve(ROAD.LENGTH.SHORT, ROAD.CURVE.MEDIUM)
	addStraight(ROAD.LENGTH.SHORT)
  addSCurves()
  addCurve(ROAD.LENGTH.MEDIUM, ROAD.CURVE.EASY)
	addCurve(ROAD.LENGTH.LONG, -ROAD.CURVE.HARD)
  addCurve(ROAD.LENGTH.MEDIUM, ROAD.CURVE.EASY)
  addStraight(ROAD.LENGTH.SHORT)
  addSCurves()
	
	pSegment = findSegment(playerZ)["index"]
	segments[pSegment + 2]["color"] = COLORS.START;
	segments[pSegment + 3]["color"] = COLORS.START;
   --segments[pSegment + 4]["color"] = COLORS.START;
	--segments[pSegment + 5]["color"] = COLORS.START;
  
  trackLength = tablelength(segments) * segmentLength;
end


-------------FASE 3
 if fase == 3 then
  addStraight(ROAD.LENGTH.LONG)
  addCurve(ROAD.LENGTH.LONG, -ROAD.CURVE.MEDIUM)
	addSCurves()
  addSCurves()
	addStraight(ROAD.LENGTH.MEDIUM)
	addCurve(ROAD.LENGTH.LONG, -ROAD.CURVE.MEDIUM)
	addCurve(ROAD.LENGTH.LONG, ROAD.CURVE.MEDIUM)
	addCurve(ROAD.LENGTH.LONG, -ROAD.CURVE.EASY)
	addStraight(ROAD.LENGTH.LONG)
  
	pSegment = findSegment(playerZ)["index"]
	segments[pSegment + 2]["color"] = COLORS.START;
	segments[pSegment + 3]["color"] = COLORS.START;
   --segments[pSegment + 4]["color"] = COLORS.START;
	--segments[pSegment + 5]["color"] = COLORS.START;
  
  trackLength = tablelength(segments) * segmentLength;
end


-------------FASE 4
 if fase == 4 then
  addStraight(ROAD.LENGTH.SHORT)
	addSCurves()
  addCurve(ROAD.LENGTH.LONG, -ROAD.CURVE.HARD)
	addStraight(ROAD.LENGTH.LONG)
	addSCurves()
	addCurve(ROAD.LENGTH.LONG, -ROAD.CURVE.MEDIUM)
	addCurve(ROAD.LENGTH.LONG, ROAD.CURVE.MEDIUM)
	addCurve(ROAD.LENGTH.LONG, -ROAD.CURVE.EASY)
	addStraight(ROAD.LENGTH.LONG)
  
	pSegment = findSegment(playerZ)["index"]
	segments[pSegment + 2]["color"] = COLORS.START;
	segments[pSegment + 3]["color"] = COLORS.START;
   --segments[pSegment + 4]["color"] = COLORS.START;
	--segments[pSegment + 5]["color"] = COLORS.START;
  
  trackLength = tablelength(segments) * segmentLength;
end


-------------FASE 5
 if fase == 5 then
  addStraight(ROAD.LENGTH.SHORT/5)
	addSCurves()
	addStraight(ROAD.LENGTH.MEDIUM)
	addSCurves()
	addCurve(ROAD.LENGTH.LONG, -ROAD.CURVE.MEDIUM)
	addCurve(ROAD.LENGTH.LONG, ROAD.CURVE.MEDIUM)
	addCurve(ROAD.LENGTH.LONG, -ROAD.CURVE.EASY)
  addStraight(ROAD.LENGTH.SHORT)
  addCurve(ROAD.LENGTH.SHORT, -ROAD.CURVE.HARD)
	addCurve(ROAD.LENGTH.SHORT, ROAD.CURVE.HARD)
  addSCurves()
  addStraight(ROAD.LENGTH.SHORT)
  
	pSegment = findSegment(playerZ)["index"]
	segments[pSegment + 2]["color"] = COLORS.START;
	segments[pSegment + 3]["color"] = COLORS.START;
   --segments[pSegment + 4]["color"] = COLORS.START;
	--segments[pSegment + 5]["color"] = COLORS.START;
  
  trackLength = tablelength(segments) * segmentLength;
end


-------------FASE 6
 if fase == 6 then
  addStraight(ROAD.LENGTH.SHORT)
	addSCurves()
	addStraight(ROAD.LENGTH.LONG)
	addCurve(ROAD.LENGTH.LONG, -ROAD.CURVE.MEDIUM)
	addCurve(ROAD.LENGTH.SHORT, -ROAD.CURVE.MEDIUM)
	addCurve(ROAD.LENGTH.LONG, ROAD.CURVE.EASY)
	addSCurves()
  addCurve(ROAD.LENGTH.MEDIUM, -ROAD.CURVE.EASY)
	addCurve(ROAD.LENGTH.LONG, -ROAD.CURVE.MEDIUM)
	addCurve(ROAD.LENGTH.LONG, -ROAD.CURVE.HARD)
  addStraight(ROAD.LENGTH.SHORT)
 
	pSegment = findSegment(playerZ)["index"]
	segments[pSegment + 2]["color"] = COLORS.START;
	segments[pSegment + 3]["color"] = COLORS.START;
   --segments[pSegment + 4]["color"] = COLORS.START;
	--segments[pSegment + 5]["color"] = COLORS.START;
  
  trackLength = tablelength(segments) * segmentLength;
end
end  
function fases.load()
  fases.fase = 1
end

function fases.update()
  
end

function fasesdraw()
  
end  
return fases