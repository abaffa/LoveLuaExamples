god={
  god=false,
  time=0,
}
function god.update(dt)
  god.time=god.time+(dt)
  if god.time>1 then
    god.time=0
    god.god=false
  end
end
return god