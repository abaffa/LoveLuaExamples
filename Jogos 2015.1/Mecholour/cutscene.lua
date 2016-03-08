cutscene= {
  anim_frame = 1,
  anim_time = 0,
  image={}
}

function cutscene.load()
  for x = 1, 5, 1 do
    cutscene.image[x] = love.graphics.newImage("cutscene/cutscene" .. x .. ".png")
  end
end

function cutscene.update(dt)
  if gamestate == 3 then
    if love.keyboard.isDown("x") then
      cutscene.anim_frame = 1
      gamestate = 2
      cutscene.anim_time = 0
    end
    cutscene.anim_time = cutscene.anim_time + dt
    if love.mouse.isDown(1) and cutscene.anim_time > 0.2 or love.keyboard.isDown("space") and cutscene.anim_time > 0.2 then
      cutscene.anim_time = 0
      cutscene.anim_frame = cutscene.anim_frame + 1
      if cutscene.anim_frame > 5 then
        gamestate = 2
        cutscene.anim_frame = 1
      end
    end
  end
end
function cutscene.draw()
    love.graphics.draw(cutscene.image[cutscene.anim_frame], 0, 0)
    love.graphics.print("PRESSIONE ESPAÇO OU LMB PARA PASSAR, X PARA PULAR", love.graphics.getWidth()-420, love.graphics.getHeight()-50)
end