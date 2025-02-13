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
