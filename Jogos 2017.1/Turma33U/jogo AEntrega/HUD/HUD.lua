 a = (...):match("(.-)[^\\/]+$")
 
local HUD = {
  timesec2 = 0,
  timesec = 0,
  formsec = 0,
  timemin = 0,
  formin = 0,
  timehora = 0,
  formho = 0
}

local barra = {}
local carga = {}
 ncargas = 8
local decaicargas = 0
 nivelagua = 10
local fonte_agua
local decaiagua = 0

function HUD.load()
  
  timer = love.graphics.newImage(a.. "timer.png")
  fonte_agua = love.graphics.newImage(a .. "/fonte_agua2.png")
   barra = {}
   barra["image"] =   love.graphics.newImage(a .. "barra.png")
   barra["largura"] = pscalex * barra.image:getWidth()/2
   barra["altura"] =  pscaley * barra.image:getHeight()
   barra["px"] =      width/16   
   barra["py"] =      5.5*height/10
   barra["scalex"] =  1/2 * pscalex
   barra["scaley"] =  1/2 * pscaley
   
   carga = {}
   carga["image"] =   love.graphics.newImage(a .. "carga.png")
   carga["largura"] = pscalex * carga.image:getWidth()/2
   carga["altura"] =  pscaley * carga.image:getHeight()
   carga["px"] =      width/16
   carga["py"] =      8.3*height/10
   carga["scalex"] =  1/2 * pscalex
   carga["scaley"] =  1/2 * pscaley
   
  HUD.timesec2 = 0
  HUD.timesec = 0
  HUD.formsec = 0
  HUD.timemin = 0
  HUD.formin = 0
  HUD.timehora = 0
  HUD.formho = 0
  ncargas = 8
  nivelagua = 10
   
   
   agua = {}
for x =1, 10, 1 do
  agua[x] = love.graphics.newImage(a .. "/aguaparte" ..x.. ".png")
end  
  agua["altura"]  = agua[1]:getHeight()
  agua["px"]      = 15*width/16
  agua["py"]      = 9*height/10
  agua["scalex"]  = 1/9 * pscalex
  agua["scaley"]  = 1/8 * pscaley
end

function HUD.update(dt)
  if paused == false then
  --------------------------cronometro-----------
 HUD.timesec2 = HUD.timesec2 + dt
  HUD.timesec = HUD.timesec + 60*dt
      if HUD.timesec > 10 then
        HUD.formsec = ""
      else
        HUD.formsec = 0
      end 
      
      if HUD.timesec >= 60 then
        HUD.timemin = HUD.timemin + 1
        decaicargas = decaicargas + 1
        decaiagua = decaiagua + 1
        HUD.timesec = 0
      end
      
      if HUD.timemin > 9 then
        HUD.formin = ""
      else
        HUD.formin = 0
      end  
      
      if HUD.timemin >= 60 then
        HUD.timehora = HUD.timehora + 1
        HUD.timemin = 0
      end
      
      if HUD.timehora > 9 then
        HUD.formho = ""
      else
        HUD.formho = 0
      end
  ----------------------------
      if nivelagua >= 1 then-----decaimentoNivelAgua
      if decaiagua >= 4 then
       nivelagua = nivelagua - 1
       decaiagua = 0
      end  
end
  ----------------------------
      if ncargas >= 1 then-----decaimentoEstadoBicicleta
      if decaicargas >= 10 then
       ncargas = ncargas - 1
       decaicargas = 0
      end
    end
    end
end  

function HUD.draw()
  
   love.graphics.draw(barra.image, barra.px, barra.py, 0, barra.scalex, barra.scaley, barra.largura)
     for x = 0 , ncargas - 1, 1  do
       love.graphics.draw(carga.image, barra.px, carga.py - x*carga.altura/2, 0, barra.scalex, barra.scaley, carga.largura)
     end
   
   love.graphics.draw(fonte_agua, 15*width/16, 9*height/10, 0, 1/9 * pscalex, 1/8 * pscaley, fonte_agua:getWidth()/2, fonte_agua:getHeight())
   --love.graphics.print(width, 50, 50)
   
  for n = 1, nivelagua, 1 do
    love.graphics.draw(agua[n],agua.px, agua.py - agua.altura*n*agua.scaley, 0, agua.scalex, agua.scaley, agua[n]:getWidth()/2)
  end
  love.graphics.print(HUD.formho.. HUD.timehora.. ":"..HUD.formin.. HUD.timemin.. ":".. HUD.formsec..math.floor(HUD.timesec), width/2, 0.3*height/2, 0, pscalex, pscaley, 45)
  love.graphics.draw(timer, width/2.8, 0.3*height/2, -0.5, 0.1, 0.1 )
end  
return HUD