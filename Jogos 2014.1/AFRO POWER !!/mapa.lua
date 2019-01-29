mapa = {}
grama = {}
undergroundt = {}
lagot = {}
pentet = {}
S_lagot = {}
helmt = {}
deathcapt = {}
rangercapt = {}
enemie1t = {}
enemie2t = {}
enemie3t = {}
enemie4t = {}
enemie5t = {}
armadilhat = {}
cogumelot = {}
plataformat ={}
espinhost = {}
escadat = {}
pedrat = {}
portafogot = {}
portagelot = {}
miniboss1t = {}
miniboss2t = {}
miniboss3t = {}

function LoadMap(filename,camerax,cameray)
  local file = io.open (filename)
  local i=1
  for line in file:lines() do
    mapa[i] = {}
    for j=1, #line, 1 do
      mapa[i][j] = line:sub(j,j)
      if (mapa [i][j] == "G") then
        table.insert(grama,{x= ((j-1)*23)-28.5 - camerax,y=((i-1)*23)+46- cameray} )
       end
       if (mapa [i][j] == "T") then
        table.insert(undergroundt,{x= ((j-1)*23)-28.5- camerax,y=((i-1)*23)+46- cameray})
       end
       if (mapa [i][j] == "V") then
        table.insert(lagot,{x= ((j-1)*23)-28.5- camerax,y=((i-1)*23)+46- cameray})
       end
       if (mapa [i][j] == "D") then
        table.insert(pentet,{x= ((j-1)*23)-28.5- camerax,y=((i-1)*23)+46- cameray,i=i,j=j})
       end
       if (mapa [i][j] == "L") then
        table.insert(S_lagot,{x= ((j-1)*23)-28.5- camerax,y=((i-1)*23)+46- cameray})
       end
       if (mapa [i][j] == "K") then
        table.insert(helmt,{x= ((j-1)*23)-28.5- camerax,y=((i-1)*23)+46- cameray,i=i,j=j})
       end
       if (mapa [i][j] == "M") then
        table.insert(deathcapt,{x= ((j-1)*23)-28.5- camerax,y=((i-1)*23)+46- cameray,i=i,j=j})
       end
       if (mapa [i][j] == "A") then
        table.insert(rangercapt,{x= ((j-1)*23)-28.5- camerax,y=((i-1)*23)+46- cameray,i=i,j=j})
       end
       if (mapa [i][j] == "N") then
        table.insert(enemie1t,{x= ((j-1)*23)-80- camerax,y=((i-1)*23)+46- cameray,i=i,j=j,vida=900})
       end
       if (mapa [i][j] == "Y") then
        table.insert(enemie2t,{x= ((j-1)*23)-80- camerax,y=((i-1)*23)+46- cameray,i=i,j=j,vida=600})
       end
       if (mapa [i][j] == "Z") then
        table.insert(enemie3t,{x= ((j-1)*23)-28.5- camerax,y=((i-1)*23)+46- cameray,i=i,j=j,vida=300})
       end
       if (mapa [i][j] == "W") then
        table.insert(enemie4t,{x= ((j-1)*23)-80- camerax,y=((i-1)*23)+46- cameray,i=i,j=j,vida=600})
       end
       if (mapa [i][j] == "R") then
        table.insert(enemie5t,{x= ((j-1)*23)-28.5- camerax,y=((i-1)*23)+46- cameray,i=i,j=j,vida=200})
       end
       if (mapa [i][j] == "U") then
        table.insert(armadilhat,{x= ((j-1)*23)-28.5- camerax,y=((i-1)*23)+46- cameray})
       end
       if (mapa [i][j] == "B") then
        table.insert(cogumelot,{x= ((j-1)*23)-28.5- camerax,y=((i-1)*23)+46- cameray})
       end
       if (mapa [i][j] == "P") then
        table.insert(plataformat,{x= ((j-1)*23)-28.5- camerax,y=((i-1)*23)+46- cameray})
       end
       if (mapa [i][j] == "E") then
        table.insert(espinhost,{x= ((j-1)*23)-28.5- camerax,y=((i-1)*23)+46- cameray})
       end
       if (mapa [i][j] == "H") then
        table.insert(escadat,{x= ((j-1)*23)-28.5- camerax,y=((i-1)*23)+46- cameray})
       end
       if (mapa [i][j] == "S") then
        table.insert(pedrat,{x= ((j-1)*23)-28.5- camerax,y=((i-1)*23)+46- cameray})
       end
        if (mapa [i][j] == "F") then
        table.insert(portafogot,{x= ((j-1)*23)-28.5,y=((i-1)*23)+46})
       end
       if (mapa [i][j] == "I") then
        table.insert(portagelot,{x= ((j-1)*23)-28.5,y=((i-1)*23)+46})
       end
       if (mapa [i][j] == "Q") then
        table.insert(miniboss1t,{x= ((j-1)*23)-28.5,y=((i-1)*23)+46,i=i,j=j,vida=18000})
       end
       if (mapa [i][j] == "O") then
        table.insert(miniboss2t,{x= ((j-1)*23)-28.5,y=((i-1)*23)+46,i=i,j=j,vida=12000})
       end
       if (mapa [i][j] == "C") then
        table.insert(miniboss3t,{x= ((j-1)*23)-28.5,y=((i-1)*23)+46,i=i,j=j,vida=6000})
       end
    end
    i = i + 1
  end
  file:close()
  for i,v in ipairs(grama) do
    grama[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:addToGroup("platforms",grama[v])
    Collider:setPassive(grama[v])
    grama[v].type = "grama"
  end
  for i,v in ipairs(undergroundt) do
    undergroundt[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:addToGroup("platforms",undergroundt[v])
    Collider:setPassive(undergroundt[v])
    undergroundt[v].type = "underground"
  end
  for i,v in ipairs(lagot) do
    lagot[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(lagot[v])
    lagot[v].type = "lago"
  end
  for i,v in ipairs(pentet) do
    pentet[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(pentet[v])
    pentet[v].type = "pente"
  end
  for i,v in ipairs(S_lagot) do
    S_lagot[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(S_lagot[v])
    S_lagot[v].type = "s_lago"
  end
  for i,v in ipairs(helmt) do
    helmt[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(helmt[v])
    helmt[v].type = "helm"
  end
  for i,v in ipairs(deathcapt) do
    deathcapt[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(deathcapt[v])
    deathcapt[v].type = "deathcap"
  end
  for i,v in ipairs(rangercapt) do
    rangercapt[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(rangercapt[v])
    rangercapt[v].type = "rangercap"
  end
  for i,v in ipairs(enemie1t) do
    enemie1t[v]= Collider:addRectangle(v.x,v.y,30,23) 
    Collider:setPassive(enemie1t[v])
    enemie1t[v].type = "enemie1"
  end
  for i,v in ipairs(enemie2t) do
    enemie2t[v]= Collider:addRectangle(v.x,v.y,30,23) 
    Collider:setPassive(enemie2t[v])
    enemie2t[v].type = "enemie2"
  end
  for i,v in ipairs(enemie3t) do
    enemie3t[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(enemie3t[v])
    enemie3t[v].type = "enemie3"
  end
  for i,v in ipairs(enemie4t) do
    enemie4t[v]= Collider:addRectangle(v.x,v.y,30,23) 
    Collider:setPassive(enemie4t[v])
    enemie4t[v].type = "enemie4"
  end
  for i,v in ipairs(enemie5t) do
    enemie5t[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(enemie5t[v])
    enemie5t[v].type = "enemie5"
  end
  for i,v in ipairs(armadilhat) do
    armadilhat[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(armadilhat[v])
    armadilhat[v].type = "armadilha"
  end
  for i,v in ipairs(cogumelot) do
    cogumelot[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(cogumelot[v])
    cogumelot[v].type = "cogumelo"
  end
  for i,v in ipairs(plataformat) do
    plataformat[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(plataformat[v])
    plataformat[v].type = "plataforma"
  end
  for i,v in ipairs(espinhost) do
    espinhost[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(espinhost[v])
    espinhost[v].type = "espinhos"
  end
  for i,v in ipairs(escadat) do
    escadat[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(escadat[v])
    escadat[v].type = "escada"
  end
  for i,v in ipairs(pedrat) do
    pedrat[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(pedrat[v])
    pedrat[v].type = "pedra"
  end
  for i,v in ipairs(portafogot) do
    portafogot[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(portafogot[v])
    portafogot[v].type = "porta de fogo"
  end
  for i,v in ipairs(portagelot) do
    portagelot[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(portagelot[v])
    portagelot[v].type = "porta de gelo"
  end
  for i,v in ipairs(miniboss1t) do
    miniboss1t[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(miniboss1t[v])
    miniboss1t[v].type = "miniboss1"
  end
  for i,v in ipairs(miniboss2t) do
    miniboss2t[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(miniboss2t[v])
    miniboss2t[v].type = "miniboss2"
  end
  for i,v in ipairs(miniboss3t) do
    miniboss3t[v]= Collider:addRectangle(v.x,v.y,23,23) 
    Collider:setPassive(miniboss3t[v])
    miniboss3t[v].type = "miniboss3"
  end
end

