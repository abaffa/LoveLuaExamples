bambam={}
  local Bam_anim_time = 0
  local Bam_anim_frame = 1
function bambam.load()
  for x=1,5,1 do
    bambam[x]=love.graphics.newImage("Sprites/bcorrendo00" .. x .. ".png")
  end
end

function bambam.update(dt)
  Bam_anim_time=Bam_anim_time+dt
  if Bam_anim_time > 0.09 then -- quando acumular mais de 0.1
    Bam_anim_frame = Bam_anim_frame + 1 -- avança para proximo frame
    Bam_anim_time = 0 -- reinicializa a contagem do tempo
  end
  
  if Bam_anim_frame > 5 then--reinicia os frames
    Bam_anim_frame = 1
  end
end

function bambam.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(bambam[Bam_anim_frame],bambam1.x,bambam1.y)
end