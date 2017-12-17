
--Exercício 1
function e1()
  io.write("Entre com as 4 notas: ")
  local n1, n2,n3,n4 = io.read("*n","*n","*n","*n")
  io.write("A média é ", (n1+n2+n3+n4)/4, "\n")
end

--Exercício 2
function e2()
  io.write("Entre com o raio do círculo: ")
  local r = io.read()
  io.write("A área é ", math.pi*r*r, "\n")
end

--Exercício 3
function e3()
  io.write("Entre com o comprimento da pista (em metros): ")
  local comp = io.read()
  io.write("Entre com o número total de voltas a serem percorridas: ")
  local nv = io.read()
  io.write("Entre com o número de reabastecimentos desejados: ")
  local na = io.read()
  io.write("Entre com o consumo de combustível do carro (em Km/L): ")
  local cons = io.read()
  io.write("Número mínimo de litros necessários para percorrer até o primeiro reabastecimento = ", comp*nv/1000/na/cons, " litros\n")
end

--Exercício 4
function e4()
  io.write("Entre com os 2 números: ")
  local n1,n2=io.read("*n","*n")
  io.write("Média = ", calcula_media(n1,n2), "\nProduto = ", calcula_produto(n1, n2), "\n")
end
function calcula_media(n1, n2)
  return (n1+n2)/2
end
function calcula_produto(n1, n2)
  return n1*n2
end

--Exercício 5
function e5()
  io.write("Entre com as coordenadas do primeiro ponto: ")
  local x1, y1=io.read("*n","*n")
  io.write("Entre com as coordenadas do segundo ponto: ")
  local x2, y2 = io.read("*n","*n")
  io.write("Distância entre os pontos = ", distancia(x1,y1,x2,y2), "\n")
end
function distancia(x1, y1, x2, y2)
  return math.sqrt( math.pow(x1-x2,2) + math.pow(y1-y2) )
end

--Exercício 6
function e6()
  io.write("Entre com os pesos das duas provas (respectivamente): ")
  local p1, p2 = io.read("*n","*n")
  io.write("Agora entre com a matrícula e com as duas notas (na ordem): ")
  local mat, n1, n2 = io.read("*n","*n","*n")
  io.write("O aluno de matrícula ", mat, " obteve média ", calcula_media_ponderada(n1, n2, p1, p2), "\n")
end
function calcula_media_ponderada(n1, n2, p1, p2)
  return (n1*p1 + n2*p2)/(p1+p2)
end

--Exercício 7
function e7()
  io.write("Entre com o salário bruto: ")
  local sal = io.read()
  io.write("Salário líquido (com descontos) = ", sal - INSS(sal) - FTS(sal) - pSaude(sal), "\n")
end
function INSS(sal)
  return 0.1*sal
end
function FTS(sal)
  return 0.08*sal
end
function pSaude(sal)
  return 100
end

--Exercício 8
function e8()
  io.write("Entre com os valores d e D respectivamente: ")
  local d, D = io.read("*n","*n")
  io.write("Volume da peça = ", calcula_volume(d,D), "\n")
end
function calcula_raio(D)
  return D/2
end
function calcula_altura(r, d)
  return r - math.sqrt(r^2 - (d/2)^2)
end
function calcula_vCalota(r, h)
  return math.pi*h^2*(3*r-h)/3
end
function calcula_vCilindro(d,r,h)
  return math.pi*(d/2)^2 * ( 2*(r-h) )
end
function calcula_vEsfera(r)
  return 4*math.pi*r^3/3
end
function calcula_volume(d, D)
  local r = calcula_raio(D)
  local h = calcula_altura(r, d)
  return calcula_vEsfera(r) - 2*calcula_vCalota(r,h) - calcula_vCilindro(d,r,h)
end

function teste()
  io.write("Entre com a quantidade de alunos: ")
  local quant = io.read()
  local notas = {}
  local media=0
  
  
  
  for i=1, quant do
    io.write("Entre com a nota do aluno ", i, " : ")
    notas[i] = io.read()
  end
 
  for i=1, quant do
    media = media + notas[i]
  end
  media = media/quant
  io.write("\n",media,"\n")
end

function teste2()
  blocos = {}
  feitos=0
  quantT=15
  quant = 6
  -- até 15, fileira de cima

  for i=0, quantT-1 do
    blocos[i]=0
  end
math.randomseed(os.time())
  while(feitos<quant) do
    x=math.random(0,14)
    if(blocos[x]==0) then
      blocos[x]=1
      feitos = feitos + 1
    end
  end
  
  for i=0, quantT-1 do
    io.write(blocos[i], " ")
  end

for i=0, quantT-1 do
    bl[0][i] = blocos[i]
 end

end
teste2()