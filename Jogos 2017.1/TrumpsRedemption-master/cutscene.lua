cutscene = {
  fotos = {},
  onCutscene = false,
  cenas = 6,
  cAtual = 1
}

function cutscene.load()
  for i=1, cutscene.cenas do
    cutscene.fotos[i] = love.graphics.newImage("Cutscene/"..i..".png")
  end
end

function cutscene.draw()
  if cutscene.onCutscene then
    love.graphics.draw(cutscene.fotos[cutscene.cAtual], 0, 0);
  end
end

  return cutscene;