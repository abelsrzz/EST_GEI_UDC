#############################################################################################################################
# Instalar e importar R Commander
#############################################################################################################################

# install.packages("Rcmdr", dependencies = TRUE) # Instalación
library(Rcmdr) # Importar R Commander

# Estadística descriptiva, se encarga de organizar y resumir grandes colecciones de datos.
# Su finalidad es la extracción e interperetación de la información obtenida en ellos.
# Los datos a tratar pueden ser cualitativos o cuantitativos.
# Los datos cuantitativos pueden ser discretos o continuos.

##############
### ¡NOTA! ###
##############
# EL código mostrado a continuación debe introducirse en RCommander
# La guía para esta práctica está en el fichero 'práctica_2.md'.

setwd("ruta_del_proyecto")
load("utils/top500_a.RData") # Cargamos la base de datos Top 500

ad.data.frame(attr(top500, "variable.labels")) # Devuelve las etiquetas de las variables
str(top500)

log(RMax) # Esto devuelve el logaritmo neperiano del valor máximo

top500$LogRMax <- log(top500$RMax) 

summary(top500) # Estadísticos / Resumenes / COnjunto de datos activo
# Otorga un resumen de la base de datos.

# Distribución de frecuencias -> Devuelven el número de datos en cada categoría
tabla <- table(top500$Familia) # Frecuencias relativas de la tabla Familia
tabla # Mostrar la tabla

tabla / sum(tabla) # Esto devuelve las frecuencias relativas
tabla / sum(tabla) * 100 # Esto devuelve los porcentajes

tabla2 <- table(top500$Nucleosproc)
tabla2

# Desde el menú de R commander debemos ir a Estadísticos/Resúmenes/Distribución de frecuencias
# Como vemos la variable Nucleosproc no aparece.
# Debemos hacer que R Commander interprete esta variable como factor
# Datos/Modificar variables del conjunto de datos activo/Convertir variable numérica en factor
# Seleccionamos Nucleosproc, le cambiamos el nombre (Nucleosproc_f) 
# Ahora podremos hacer una distribución de frecuencias de la variable Nucleosproc_f
top500$Nucleosproc_f <- factor(top500$Nucleosproc)

cumsum(tabla2) # Suma acumulada de la Tabla Núcleosproc

# Tabla de frecuencias sin representación gráfica
hist(top500$Frecuencia, plot=FALSE)[c("breaks", "counts")]

# Segmentar una variáble numérica
# Generamos la variable Frecuencia_f desde el menú, seleccionamos el método Segmentos equidistantes
# Estadísticos/Resumenes/DIstribuciones de frecuencias - Ahora podremos ver Frecuencia_f y ver la nueva tabla

# Para guardar dos gráficos por separado, debemos ejecutar
windows() # En windows
x11() # En linux
# Ahora al dibujar un gráfico este se verá en la ventana nueva
# Desde el menú Gráficas podremos hacer los distintos gráficos

# pie() # Para gráficos de sectores
pie(tabla)
# barplot() # Para gráficos de barras
barplot(tabla, xlab="Familia", ylab="Frecuency", col="blue")

# También podemos hacer una gráfica por grupos.
# Esto creará un "subgráfico" por cada una de las familias de procesadores
# Create a table of frequencies for Familia by Nucleosproc
tabla3 <- table(top500$Familia, top500$Nucleosproc)
# Plot the barplot with the table of frequencies
barplot(tabla3, beside=TRUE, legend=TRUE, xlab="Familia", ylab="Frecuency", col=rainbow(nrow(tabla3)))

# Para realizar los cuantiles y quedarnos con el dato menor en lugar de realizar la media si los valores centrales son 2
# Debemos indicarle type=1
x <- c(6,2,6,1,1,5,9,9,4,9)
quantile(x, c(0.25,0.5,0.7,0.75,0.95), type=1)

# Para calcular la desviación típica no debemos confundir la función sd() -> (Cuasi-desviación típica)
# var() -> cuasivarianza

# Desviación típica -> sqrt((n-1) * var(x) / n )
sqrt((length(x) - 1) * var(x) / length(x))

# Estadísticos -> Resúmenes  -> Resúmenes de datos
numSummary(top500[,"Frecuencia", drop=FALSE], statistics=c("mean", "sd", "IQR", "quantiles", "cv"), quantiles=c(0,.25,.5,.75,1))
# IQR = Q3 - Q1 -> Es el 50% central de los datos

# Coeficiente de variación
s2 <- (500 - 1 ) / 500 * var(top500$Frecuencia)

cv <- sqrt(s2) / mean(x)
cv

# Histograma: Gráficas -> Histograma -> Variable
with(top500, Hist(Frecuencia, scale="frequency", breaks="Sturges", col="darkgray"))

# Diagrama de Caja y Bigotes: Gráficos -> Diagrama de Caja -> Variable
x11()
Boxplot( ~ Frecuencia, data=top500, id=list(method="y"))
boxplot(top500$Frecuencia, xlab="Frecuencia", horizontal=TRUE)

# Agrupar por otro dato: Estadísticos -> Resúmenes  -> Resúmenes de datos -> Familia de datos
numSummary(top500[,"Frecuencia", drop=FALSE], groups=top500$Familia, statistics=c("mean", "sd", "IQR", "quantiles", "cv"), quantiles=c(0,.25,.5,.75,1))

# Misma situación para la gráfica
x11()
Boxplot(Frecuencia ~ Familia, data=top500, id=list(method="y"))