local highscores = {}
local h = {}
-- Salva as pontuações no arquivo

function h.saveHighscores(filename)
  local file = io.open(filename, "w")
  for i,v in ipairs(highscores) do
    if i < #highscores then
      file:write(v.name .. "-" .. v.score .. "\n")
    else
      file:write(v.name .. "-" .. v.score)
    end
  end
	file:close()
end

function sortScores(a, b)
  return a.score > b.score
end

-- Adiciona uma pontuação à tabela
-- Retorna a tabela atualizada

function h.addHighscore(name, score)
  table.insert(highscores, {name = name, score = score})
  table.sort(highscores, sortScores)
  table.remove(highscores, #highscores)
  return highscores
end

function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
        table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

-- Carrega as pontuações de um arquivo
-- Retorna uma tabela com as maiores pontuações

function h.loadHighscores(filename, n)
  local file = io.open(filename, "r")
  if file ~= nil then
    for line in file:lines() do
      local name, score = unpack(split(line, "-"))
      print(name)
      print(score)
      table.insert(highscores, {name = tostring(name), score = tonumber(score)})
    end
    file:close()
  else
    for i=1, n do
      table.insert(highscores, {name = " ", score = 0})
    end
  end
  return highscores
end

function h.draw()
  love.graphics.print("Highscores:", 200, 150)
  for i,v in ipairs(highscores) do
    love.graphics.print("" .. v.name .. " - " .. v.score .. "", 200, 200 + i*30)
  end
end

return h