# Guía para la práctica 2 en R Commander

Para instalar R Commander debemos ejecutar el comando `install.packages("Rcmdr", dependencies = TRUE)` desde una terminal de R.
Podemos lanzar la interfaz de R Commander con el comando `library(Rcmdr)`

---

Para poder importar la base de datos [Top 500](/utils/top500_a.RData) debemos definir el directorio de trabajo de R Comander.

```R
setwd("ruta_del_proyecto") # Aquí debemos establecer la ruta raíz del proyecto
load("utils/top500_a.RData")
```

También podemos cargar el fichero desde el menú `Datos > Cargar conjunto de datos`

Para convertir la base de datos en un Data Frame ejecutamos `ad.data.frame(attr(top500, "variable.labels"))` y luego observamos su contenido con `str(top500)`

![Top500](/img/image.png)

---

El menú `Datos > Modificar variables del conjunto de datos activo > Calcular nueva`
variable permite generar nuevas variables a partir de las existentes.

- Especificar el nombre de la varible destino en la ventana `Nombre de la nueva variable`.

- En la ventana `Expresión a calcular` debemos introducir la fórmula de la transformación, se
pueden incluir variables a partir de la lista que aparece en `Variables actuales`.

---

Siguiendo los pasos anteriores vamos a crear una nueva variable `LogRMax`, que será la transformación a logaritmo neperiano del rendimiento alcanzado por el equipo.

- Introduce el nombre de la nueva variable en la ventana Nombre de la nueva variable: `LogRMax`.

- En la ventana `Expresión a calcular` introduce la expresión `log(RMax)`.

Se puede crear directamente en la ventana de comandos con la instrucción:
```R
top500$LogRMax <- log(top500$RMax)
```

Ahora guardaremos la nueva base de datos en un nuevo fichero con el nombre `top500b.RData`.
Para ello vamos al menú `Datos > Conjunto de datos activo > Guardar el conjunto de datos` activo... elegimos el directorio y escribimos el nombre del nuevo fichero.

El menú `Estadísticos > Resúmenes > Conjunto de datos activo` (comando `summary()`) permite obtener las frecuencias de las variables cualitativas y valores máximos y mínimos, los cuartiles, la media y el número de datos faltantes de las variables cuantitativas del conjunto de datos. A continuación se da algún ejemplo de los resultados que se pueden obtener con este menú.

---

A través del menú `Estadísticos > Resúmenes > Distribución de frecuencias` se pueden
obtener las tablas de frecuencias absolutas y porcentajes de las variables definidas como factores. Los
resultados que se generan son de la forma:

```R
# (Tabla de frecuencias absolutas)
.Table <- table(top500$Familia)
.Table # counts for Familia

# (Tabla de porcentajes)
100*.Table/sum(.Table) # percentages for Familia
```

En el menú `Estadísticos / Resumenes / COnjunto de datos activo` podemos obtener un resumen de la base de datos.
El comando equivalente es el siguiente:

```R
summary(top500)
```

El menú `Distribución de frecuencias` devuelve el número de datos en cada categoría y su comando equivalente es:

```R
tabla <- table(top500$Familia) # Frecuencias relativas de la tabla Familia
tabla # Mostrar la tabla
tabla / sum(tabla) # Esto devuelve las frecuencias relativas
tabla / sum(tabla) * 100 # Esto devuelve los porcentajes
```

Desde el menú de R commander debemos ir a `Estadísticos/Resúmenes/Distribución de frecuencias`
Como vemos la variable `Nucleosproc` no aparece.
Debemos hacer que R Commander interprete esta variable como factor
`Datos/Modificar variables del conjunto de datos activo/Convertir variable numérica en factor`
Seleccionamos `Nucleosproc`, le cambiamos el nombre a `Nucleosproc_f`. Ahora podremos hacer una distribución de frecuencias de la variable `Nucleosproc_f`
También podemos hacerlo con el comando

```R
top500$Nucleosproc_f <- factor(top500$Nucleosproc)
```

Para calcular la suma acumulada de la Tabla Nucleosproc podemos usar el comando `cumsum(tabla2)`.

Para representar por terminal una tabla de frecuencias sin representación gráfica podemos ejecutar el comando `hist(top500$Frecuencia, plot=FALSE)[c("breaks", "counts")]`

Para segmentar una variable numérica generamos la variable Frecuencia_f desde el menú, seleccionamos el método `Segmentos equidistantes`
- `Estadísticos/Resumenes/DIstribuciones de frecuencias` - Ahora podremos ver Frecuencia_f y ver la nueva tabla

Para guardar dos gráficos por separado, debemos ejecutar `windows()`.
Ahora al dibujar un gráfico este se verá en la ventana nueva

---

Si se quiere representar gráficamente, el diagrama de sectores es una de las representaciones más
habituales, y se obtiene a través del menú `Gráficas > Gráfica de sectores` Como puede verse
la familia Intel es la más frecuente seguida de AMD y Power.

![Pie](/img/image-1.png)

El comando equivalente es `pie(tabla)`

Otra forma de respresentar estas variables es con el diagramas de barras. En Rcmdr se selecciona
`Gráficas > Gráfica de barras`, el código R correspondiente es
```R
barplot(table(top500$Familia), xlab="Familia", ylab="Frequency")
```

![Barplot](/img/image-2.png)

También podemos hacer una gráfica por grupos.
Esto creará un "subgráfico" por cada una de las familias de procesadores

```R
tabla3 <- table(top500$Familia, top500$Nucleosproc)
barplot(tabla3, beside=TRUE, legend=TRUE, xlab="Familia", ylab="Frecuency", col=rainbow(nrow(tabla3)))
```
---
