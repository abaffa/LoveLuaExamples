require "menu"
require "zombie"
require "arma"
require "personagem"
require "powerup"
require "TEsound"


local loader = require("AdvTiledLoader.Loader")

local tilesetImage
tileQuads = {}
local normalImage
normalQuads = {}
local explodeImage
explodeQuads = {}
local rapidoImage 
rapidoQuads = {}
checar = 0
movedir = 0
dir = 0
tiroPos = 0
arvore1pos_x = 64
arvore1pos_y = 64
arvore2pos_x = 128
arvore2pos_y = 480
arvore3pos_x = 832
arvore3pos_y = 576
arvore4pos_x = 800
arvore4pos_y = 128
arvoreverdeheight = 96
arvoreverdewidth = 96
arvorerosapos_x = 448
arvorerosapos_y = 320
arvorerosaheight = 128
arvorerosawidth = 96



function restart()
 
 hero= {
 walk = {},
 arma = 1,
 anim_frame = 1,
 pos_x = 400,
 pos_y = 300,
 anim_time = 0,
 fire_time = 0,
 firerate = 1,
 balas = 0,
 met = 0,
 shot = 0,
 snip = 0,
 dano = 34,
 danooriginal = 34,
 vel = 1.25,
 hp = 300
}

  scorecount = 0
  dia = 1
  numdezumbis = 9 --num total = num + 1 
  zumbismortos = 0
  tiro = {}
  zombie = {}

  LoadZombies(numdezumbis)

  
  Met = {
  image = love.graphics.newImage("Met.png"),
  nomapa = 0,
  equipada = 0,
  numero = 43, --numero que randomiza quando a metralhadora spawna
  balas = 30,
  pos_x = love.math.random(100,700),
  pos_y = love.math.random(50,550)
} 

Shot = {
  image = love.graphics.newImage("Shot.png"),
  nomapa = 0,
  equipada = 0,
  numero = 35, --numero que randomiza quando a shotgun spawna
  balas = 30,
  pos_x = love.math.random(100,700),
  pos_y = love.math.random(5,550)
} 

Snip = {
  image = love.graphics.newImage("Snip.png"),
  nomapa = 0,
  equipada = 0,
  numero = 97, --numero que randomiza quando a shotgun spawna
  balas = 15,
  pos_x = love.math.random(100,700),
  pos_y = love.math.random(5,550)
} 

VacPU = {
  image = love.graphics.newImage("vacinapowerup.png"),
  nomapa = 0,
  numero = 75, --numero que randomiza quando a shotgun spawna
  pos_x = love.math.random(100,700),
  pos_y = love.math.random(5,550)
  }
end

function LoadTiles(filename, nx, ny, tileSizeX, tileSizeY)
  tilesetImage = love.graphics.newImage(filename)
  local count = 1
  for j = 0, ny, 1 do
    for i = 0, nx, 1 do
      tileQuads[count] = love.graphics.newQuad(i * tileSizeX ,
      j * tileSizeY, tileSizeX, tileSizeY,
      tilesetImage:getWidth(),
      tilesetImage:getHeight())
      count = count + 1
    end
  end
end

function LoadNormal(filename, nx, ny, tileSizeX, tileSizeY)
  normalImage = love.graphics.newImage(filename)
  local count = 1
  for j = 0, ny, 1 do
    for i = 0, nx, 1 do
      normalQuads[count] = love.graphics.newQuad(i * tileSizeX ,
      j * tileSizeY, tileSizeX, tileSizeY,
      normalImage:getWidth(),
      normalImage:getHeight())
      count = count + 1
    end
  end
end

function LoadExplode(filename, nx, ny, tileSizeX, tileSizeY)
  explodeImage = love.graphics.newImage(filename)
  local count = 1
  for j = 0, ny, 1 do
    for i = 0, nx, 1 do
      explodeQuads[count] = love.graphics.newQuad(i * tileSizeX ,
      j * tileSizeY, tileSizeX, tileSizeY,
      explodeImage:getWidth(),
      explodeImage:getHeight())
      count = count + 1
    end
  end
end

function LoadRapido(filename, nx, ny, tileSizeX, tileSizeY)
  rapidoImage = love.graphics.newImage(filename)
  local count = 1
  for j = 0, ny, 1 do
    for i = 0, nx, 1 do
      rapidoQuads[count] = love.graphics.newQuad(i * tileSizeX ,
      j * tileSizeY, tileSizeX, tileSizeY,
      rapidoImage:getWidth(),
      rapidoImage:getHeight())
      count = count + 1
    end
  end
end


  
function love.load()  
  
  restart()
  love.graphics.setBackgroundColor(0,0,0)
  vacina = love.graphics.newImage("vacina.png")
  love.graphics.setFont(love.graphics.newFont("28 Days Later.ttf",24))
  love.window.setTitle("Zombies for Days")
  LoadTiles("personagem.png", 2, 3,32,32)
  LoadNormal("Normal.png",2,3,32,32)
  LoadExplode("explode.png",2,3,43,43)
  LoadRapido("rapido.png",2,3,32,32)
  TEsound.playLooping("Musicafundo.mp3")
  somtiro = love.audio.newSource("tiro.wav","static")
  somtiro:setVolume(0.8)
  somarma = love.audio.newSource("arma.mp3","static")
  loader.path = "Mapas/"
  map = loader.load("Floresta.tmx")
  love.window.setMode(1024, 768, {resizable=false})
  gamestate = "menu"
  botao_spawn(100, 200, "start", "start")
  botao_spawn(100, 400, "quit", "quit")



Met = {
  image = love.graphics.newImage("Met.png"),
  nomapa = 0,
  equipada = 0,
  numero = 43, --numero que randomiza quando a metralhadora spawna
  balas = 30,
  pos_x = love.math.random(100,900),
  pos_y = love.math.random(50,800)
} 

Shot = {
  image = love.graphics.newImage("Shot.png"),
  nomapa = 0,
  equipada = 0,
  numero = 35, --numero que randomiza quando a shotgun spawna
  balas = 30,
  pos_x = love.math.random(100,900),
  pos_y = love.math.random(50,800)
} 

Snip = {
  image = love.graphics.newImage("Snip.png"),
  nomapa = 0,
  equipada = 0,
  numero = 97, --numero que randomiza quando a shotgun spawna
  balas = 15,
  pos_x = love.math.random(100,900),
  pos_y = love.math.random(50,800)
} 

VacPU = {
  image = love.graphics.newImage("vacinapowerup.png"),
  nomapa = 0,
  numero = 75, --numero que randomiza quando a shotgun spawna
  pos_x = love.math.random(100,900),
  pos_y = love.math.random(50,800)
} -- Vacina como Powerup

end

  function love.mousepressed(x,y)
    if gamestate == "menu" then
      checarBotao(x,y)
    end
  end



function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2) --x1,y2, coordenadas w1,h1 comprimento e altura
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function love.update(dt)
  

  if gamestate == "menu" then
    if love.keyboard.isDown("2") then
      LoadTiles("Faster.png", 2, 3,32,32)
      hero.vel = 1.75
      hero.danooriginal = 25
      hero.dano = 25
    elseif love.keyboard.isDown("3") then
      LoadTiles("shooter.png", 2,3,32,32)
      hero.hp = 400
      hero.danooriginal = 25
      hero.dano = 25
    end
  end

  if gamestate == "jogando" then
    
    if love.keyboard.isDown("d") then
      dir = 1
      movimento(dir, dt)
      
    elseif love.keyboard.isDown("a") then
      dir = 2
      movimento(dir, dt)
    
    elseif love.keyboard.isDown("w") then
      dir = 3
      movimento(dir, dt)
    
    elseif love.keyboard.isDown("s") then
      dir = 4
      movimento(dir, dt)
    end
   
   
   if checarSetas() == true then
     qualSeta() 
   end
   
  if (numdezumbis ~= zumbismortos - 1) and hero.hp > 0 then
     movimentozumbi(numdezumbis,dt)
     ColisaoTiroZumbi(numdezumbis)
  elseif (numdezumbis == zumbismortos - 1) and hero.hp > 0 then
     dia = dia + 1 
     numdezumbis = numdezumbis + 5
     zumbismortos = 0
     LoadZombies(numdezumbis)
  end

    atirar()
    powerupspawn()
    hero.fire_time = hero.fire_time + dt
    movTiro(dt)

  end

TEsound.cleanup()

end

function love.draw()
  
  
  if gamestate == "jogando" then
    
  if hero.hp > 0 then
    map:draw()
    map:setDrawRange(0,0,love.graphics.getWidth(), love.graphics.getHeight())
   --love.graphics.draw(hero.walk[hero.anim_frame], hero.pos_x, hero.pos_y)
    love.graphics.draw(tilesetImage, tileQuads[hero.anim_frame], hero.pos_x,hero.pos_y)
    
    
    for i = #tiro, 1, -1 do
      --if tiro[i].tipo == 1 then
        love.graphics.rectangle("fill", tiro[i].pox, tiro[i].poy, 3, 3)
      --else
        --love.graphics.rectangle("fill", tiro[i].pox, tiro[i].poy, 5, 5 --end
    end
    
    for i = 0, numdezumbis, 1 do
      if zombie[i].zombieinmap == 1 and zombie[i].zombiedead == 0 then
        if zombie[i].ztype == 2 then
          love.graphics.draw(explodeImage, explodeQuads[zombie[i].anim_frame], zombie[i].pos_x,zombie[i].pos_y)
        elseif zombie[i].ztype == 3 then
          love.graphics.draw(rapidoImage, rapidoQuads[zombie[i].anim_frame], zombie[i].pos_x,zombie[i].pos_y)
        else
          love.graphics.draw(normalImage, normalQuads[zombie[i].anim_frame], zombie[i].pos_x,zombie[i].pos_y)
        end
      end
    end
    
    
    for i = 0, (math.ceil(hero.hp/100) - 1), 1 do
      love.graphics.draw(vacina, 20 + (32*i), 20)
    end 
    
    if Met.nomapa == 1 then
      love.graphics.draw(Met.image,Met.pos_x,Met.pos_y)
    end
    
    if Met.equipada == 1 then
       love.graphics.print(hero.balas, 500,20)
    end
     
    
    if Shot.nomapa == 1 then
      love.graphics.draw(Shot.image,Shot.pos_x,Shot.pos_y)
    end
    
    if Shot.equipada == 1 then 
      love.graphics.print(hero.balas, 500,20)
    end
    
    
    if Snip.nomapa == 1 then
      love.graphics.draw(Snip.image,Snip.pos_x,Snip.pos_y)
    end
    
    if Snip.equipada == 1 then 
      love.graphics.print(hero.balas, 500,20)
    end
    
    if VacPU.nomapa == 1 then
      love.graphics.draw(VacPU.image,VacPU.pos_x,VacPU.pos_y)
    end
    
    
    love.graphics.print(scorecount, 900,20)
    love.graphics.print("Day", 900, 50)
    love.graphics.print(dia, 950, 50)
    
  else
    
    gamestate = "menu"
    
  end

end

  if gamestate == "menu" then
      botao_draw()
  end
  
end
