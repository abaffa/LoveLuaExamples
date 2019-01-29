local texto2 = {
  estaNoTexto2 = false
}
function texto2.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.print("6:57?!!! Nao acredito que", 50, 5)
  love.graphics.print("nao acordei com o",160,45)
  love.graphics.print("despertador! Se eu faltar", 50, 85)
  love.graphics.print("essa aula mais uma vez,", 55, 125)
  love.graphics.print("vou reprovar! PELA QUINTA", 15, 165)
  love.graphics.print("VEZ!! Nao vou ser jubilada", 20, 205)
  love.graphics.print("assim, tenho que correr!", 50, 245)
  love.graphics.print("Espaco para continuar", 75, 520)
  love.graphics.print(",", 220, 527)
end
return texto2