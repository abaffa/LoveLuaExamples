local var=1
local pulof1={
  estaPulando=false,
  vel=-300,
  }
function pulof1.update(dt)
  var=var-1.65*dt
  pyf1=pyf1+(pulof1.vel*var*dt)
  pyf2=pyf2+(pulof1.vel*var*dt)
  pyf3=pyf3+(pulof1.vel*var*dt)
  if pyf1>chao1 then
    pyf1=chao1
    pulof1.estaPulando=false
    var=1
  end
  if pyf2>chao2 then
    pyf2=chao2
    pulof1.estaPulando=false
    var=1
  end
  if pyf3>chao3 then
    pyf3=chao3
    pulof1.estaPulando=false
    var=1
  end
end
return pulof1