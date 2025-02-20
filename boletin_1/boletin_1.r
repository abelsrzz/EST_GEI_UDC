##############
### ¡NOTA! ###
##############
#  En ciertos casos los números factoriales pueden aparecer como Nan si son demasiado grandes

#############################################################################################################################
# Ejercicio: 2
#############################################################################################################################
# Si la palabra clave de un ordenador consiste en un número de 4 cifras elegido al azar, calcula la 
# probabilidad de que la primera y la última cifra coincidan.

# pA = (nºCasos favorables) / (nºCasos posibles)

pA <- (10 * 10^2) / (10^4)
cat("Las posibilidades son: ", pA, "o el", pA*10, "%\n")

#############################################################################################################################
# Ejercicio: 3
#############################################################################################################################
# En el juego de la Primitiva, apostamos a los números 1, 2, 3, 4, 5 y 6. Calcula:

# a) Probabilidad de obtener un pleno.
# b) Probabilidad de obtener exactamente 4 aciertos.
# c) Probabilidad de obtener 5 aciertos y el complementario.
# d) Ahora, apostamos a los números 1, 2, . . . , 11. ¿Cuál es la probabilidad de obtener un pleno?

# a)
# Hay C(6,49) posibles casos
# Defino la función combinaciones sin repetición
C <- function(m, n) {
    return (factorial(m) / (factorial(n) * factorial(m-n)))
}
posibles <- C(49, 6)

# Hay 1 caso favorable
favorables <- 1

pB <- posibles / favorables
pB

# b)
# Los casos posibles se mantienen
posibles <- C(49, 6)

# Casos favorables: Acertar 4 y fallar 2
# Acertar 4: C(4,6) 
# Fallar 2: C(2, 43)
c_4_6 <- C(6, 4)
c_2_43 <- C(43, 2)
favorables <- c_4_6 * c_2_43

pC <-  favorables / posibles
pC

# c)
# Los posibles se mantienen
posibles <- C(49, 6)
# Acertar 5
c_5_6 <- C(6, 5)
# Fallar 1
c_1_44 <- C(43, 1)
# Acertar complementario
c_1_43 <- 1 / 43

favorables <- c_5_6 * c_1_44 * c_1_43

pD <- favorables / posibles
pD

# d)
posibles <- C(49, 6)

# Hay 11 sobre 6 casos favorable C(11, 6)
favorables <- C(11, 6)

pE <- favorables / posibles
pE

#############################################################################################################################
# Ejercicio: 4
#############################################################################################################################
# Se permutan al azar los números 1, 2, . . . , n. Calcula la probabilidad de que el 1 y el 2 queden
# juntos y en ese orden.

# Los casos posibles son pemutaciones de n
# Los casos favorables son permutaciones de n-1 elementos
# Ejemplo:
n <- 5
favorables <- factorial(n-1)

# Los posibles son n! casos
posibles <- factorial(n)

pF <- favorables / posibles
pF

#############################################################################################################################
# Ejercicio: 5
#############################################################################################################################
# En una empresa trabajan 20 informáticos, 3 de los cuales serán elegidos al azar para trabajar el
# día de Navidad. ¿Cuál es la probabilidad de que el mejor informático no tenga que trabajar ese día?

# Casos posibles C(3, 20)
posibles <- C(20, 3)

# Favorables son C(3, 19)
favorables <- C(19, 3)
pG <- favorables / posibles 
pG

#############################################################################################################################
# Ejercicio: 6
#############################################################################################################################
# En una habitación se reúnen cinco personas sin ninguna relación. Calcula la probabilidad de que
# celebren sus cumpleaños en días distintos.

# Los casos posibles son VR(365, 5)
VR <- function(m, n){
    return (m^n)
}

posibles <- VR(365, 5)

# Los casos favorables son V(365, 5)
V <- function(m, n) {
    return ( factorial(m) / factorial(m-n))
}

favorables <- V(365, 5)

pH <- favorables / posibles
pH

#############################################################################################################################
# Ejercicio: 7
#############################################################################################################################
# Calcular el número mínimo de personas a las que tienes que preguntar para que la probabilidad
# de encontrar al menos una que cumpla años el mismo día que tú sea, por lo menos, 0.5.

# Podemos pensarlo como que nadie más cumple años el mismo día que tú

n <- 253 # Personas
# Posibilidades totales de cumpleaños de los demás
posibles <- VR(365, n)

# Posibles días sin tener en cuenta tu cumpleaños
favorables <- VR(364, n)

pI <- favorables / posibles
# Esto es igual que 
form <- (364/365)^n

# Para que esta posibilidad sea >= 0.5 debemos resolver la ecuación
# 1 - form >= 0.5
# Lo que nos dá 253 personas
pI

#############################################################################################################################
# Ejercicio: 8
#############################################################################################################################
# El suministro de energía de una ciudad procede de tres fuentes: electricidad, gas y gasóleo. Las
# probabilidades de que se produzca un corte en el suministro son 0.10 en el de electricidad, 0.05
# en el de gas y 0.15 en el de gasóleo. En el supuesto de que se produzca un corte en el suministro
# de gasóleo, la probabilidad de un corte de electricidad se incrementa en un 70 %. El corte del
# suministro de gas es independiente de los cortes de las otras fuentes de energía.

# a) ¿Cuál es la probabilidad de que se produzca un corte total en el suministro de energía a la ciudad el próximo invierno?
# b) ¿Cuál es la probabilidad de que se produzca un corte en al menos una de las tres fuentes de suministro?
# c) Si se produce un corte de electricidad, ¿cuál es la probabilidad de que también se produzcan al mismo tiempo cortes en las otras fuentes de suministro?


