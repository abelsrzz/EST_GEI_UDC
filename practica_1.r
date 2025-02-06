# Media truncada
# Input: vector x {x_1, ..., x_n}
# Output: media truncada de x al 20%
x <- (1:11)^2

media_truncada <- function(x, p = 0.2) {
    # Calcular el número de elementos de x; llamarle n
    n <- length(x)

    # Calcular el entero más próximo al 20 % de n; llamarle k.
    k <- round(p * n)

    # Ordenamos el vector
    x <- sort(x)

    # Eliminar los k primeros y los k últimos elementos de x; llamarle y al vector formado por los elementos no eliminados.
    y <- x[(k + 1):(n - k)]

    # Devolver media de y
    return(mean(y))
}

#############################################################################################################################

cat("Media truncada de (", x, "):\n", media_truncada(x), "\n")

# Matrices
# Existen dos formas de crear matrices
# Se pueden crear juntando dos vectores
x <- 1:4
y <- 4:1 + 1

matriz <- cbind(x, y) # Column bind (columnas)
matriz2 <- rbind(x, y) # Row bind (filas)

# Seleccionar elementos
matriz2[2, 1] # Elemento de la fila 2 y columna 1

# O mediante la función matrix
x <- 5:10
A <- matrix(x, 2, 6)
A # por columnas

B <- matrix(x, 2, 6, byrow = TRUE)
B # por filas

dim(A)
dim(B) # dimensiones matrices

rownames(A) <- c("Escrito", "Oral")
colnames(A) <- c("Ana", "Pablo", "Martin", "Nerea", "Pilar", "Mateo")
A
A[2, 3] # Nota de Martin en el examen Oral

t(A) # traspuesta de A

# Data frame de A (tabla)
data.frame(A)
#         Ana Pablo Martin Nerea Pilar Mateo
# Escrito   5     7      9     5     7     9
# Oral      6     8     10     6     8    10

#############################################################################################################################

# Podemos cargar dataframes con el comando read.table
# header(cabecera), sep(separador), dec(punto decimal)
# datos <- read.table("./file.txt", header=F, sep=" ", dec=".")

# Podemos practicar con la famosa base de datos "iris"
# iris
iris$Sepal.Length # Devuelve la columna Sepal.Length

# fix(iris) # Editar data.frame

#############################################################################################################################

# Gráficas (Histogramas)

x <- rnorm(100)

hist(x)

h <- hist(
    x,
    plot = FALSE
)

h

h$density

h2 <- hist(x, breaks = c(-4, 3, -2, -1, 0, 1, 2, 3))
h2$density
sum(h2$density)

x <- rnorm(10000)
hist(x, freq = FALSE)

#############################################################################################################################

# Con plot podemos representar puntos

x <- seq(-2, 2, 0.1)
y1 <- x^3
y2 <- x^2

plot(x, y1)
plot(x, y1, type = "l") # Type: l = Línea

lines(x, y2, col = "red", lw = 5) # Añade líneas al plot, col = color, lw = line_width

points(x, x) # Añade una línea de puntos

x <- seq(-2, 2, length = 50)
y <- seq(-4, 4, length = 50)

plot(x, y)
legend("bottomleft", c("Leyenda de la gráfica"))

#############################################################################################################################

# Con curve podemos representar curvas

curve(expr = sin, from = 0, to = 6 * pi)

curve(cos, add = TRUE) # Añadir una segunda curva a la anterior

#############################################################################################################################

# Sucesión de Fibonacci

# Definiendo una función recursiva

f <- function(n) {
    if (n <= 2) {
        a <- 1
    } else {
        a <- f(n - 1) + f(n - 2)
    }
    return(a)
}

system.time(f(20))
# system.time(f(100)) Podemos ver que tarda demasiado

# Utilizando un bucle
tiempo.inicial <- proc.time()
Fibonacci <- rep(NA, 20)
Fibonacci[1] <- Fibonacci[2] <- 1
for (i in 3:20) {
    Fibonacci[i] <- Fibonacci[i - 2] + Fibonacci[i - 1]
}
print(Fibonacci[20])
tiempo.final <- proc.time()
print(tiempo.final - tiempo.inicial)

#############################################################################################################################
# Ejercicio: quicksort
#############################################################################################################################

# El algoritmo quicksort con pivote aleatorio es un método de ordenación simple, práctico y eficiente.
# Debemos escribir una función recursiva de nombre Quicksort que lo implemente, conforme a las siguientes instrucciones:

# Input: un vector x = {x1, . . . , xn}.
# Output: los elementos de x ordenados.

# 1. Si x tiene cero o un elementos, devolver x. En caso contrario continuar.

# 2. Elegir al azar un elemento de x como pivote; llamarle a.

# 3. Comparar cada uno de los restantes elementos de x con a y construir dos nuevos vectores:
#   a) x1 contiene todos los elementos de x, excepto a, que son menores o iguales que a.
#   b) x2 contiene todos los elementos de x que son mayores que a.

# 4. Utilizar Quicksort para ordenar x1 y x2.

# 5. Devolver la lista x1, a, x2

quicksort <- function(x) {
    n <- length(x)

    # Si x tiene cero o un elementos, devolver x. En caso contrario continuar.
    if (n <= 1) {
        return(x)
    }

    m <- sample(1:n, 1)

    a <- x[m] # Elegir al azar un elemento de x como pivote; llamarle a.

    # Comparar cada uno de los restantes elementos de x con a y construir dos nuevos vectores:
    x <- x[-m]
    x1 <- x[x <= a]
    x2 <- x[x > a]

    # Utilizar Quicksort para ordenar x1 y x2.
    x1 <- quicksort(x1)
    x2 <- quicksort(x2)

    # Devolver la lista x1, a, x2
    y <- c(x1, a, x2)
    return(y)
}

# Creo un vector de 10 elementos aleatorios entre -1000 y 10000
x <- sample(-1000:1000, 10)

cat("Vector sin ordenar:", x, "\n")
cat("Vector ordenado:", quicksort(x), "\n")

#############################################################################################################################
# Ejercicio: quicksort
#############################################################################################################################
# Escribe una función que implemente el cálculo de la media recortada al 20 %:
# La media recortada es una variante de la media truncada. Se diferencia de esta en que en lugar
# de simplemente eliminar los primeros elementos del vector (ordenado), se reemplazan por el menor de
# los datos restantes; y de forma análoga los últimos elementos del vector se reemplazan por el mayor
# de los restantes.

x <- (1:11)^2

media_recortada <- function(x, p = 0.2) {
    # Calcular el número de elementos de x; llamarle n
    n <- length(x)

    # Calcular el entero más próximo al 20 % de n; llamarle k.
    k <- round(p * n)

    # Ordenamos el vector
    x <- sort(x)

    x[1:k] <- x[k + 1] # Substituimos los elementos de 1 al valor k(20% del vector)
    x[(n - k + 1):n] <- x[n - k] # Substituimos los elementos de n-k+1(20% final del vector)
    y <- x

    # Devolver media de y
    return(mean(y))
}

media_recortada(x)
