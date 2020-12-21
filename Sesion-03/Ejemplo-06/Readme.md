# Ejemplo 6. Series de tiempo y descomposición

#### Objetivo
- Aprender a graficar y descomponer series de tiempo
- Determinar si tiene un comportamiento estócastico

#### Requisitos
- Manejo de data frames
- Prework
- Gráficos: función plot

#### Desarrollo

Utilizaremos un data set de Kaggle el cual contiene datos sobre la temperatura en Fortaleza, Brasil del año 1946 a 1980. Lo primero que se hará será ajustar los datos para poder leerlos adecuadamente.

```R
library(dplyr)    
    
w.brazil <- read.csv("../station_fortaleza.csv")
head(w.brazil)

w.brazil <- w.brazil[, -c(1,14:18)]
tail(w.brazil)
class(w.brazil)

plot(w.brazil)
```
Quitamos los varoles que sean mayores a 50

```R
w.brazil <- w.brazil %>% filter(JAN<50,FEB<50,	MAR<50,	APR<50,	MAY<50,	JUN<50,	JUL<50,	AUG<50,	SEP<50,	OCT<50,	NOV<50,	DEC<50)
plot(w.brazil)

bras <- apply(w.brazil, 2, c)
class(bras)
bra1 <-  as.vector(t(bras))
```

Convertimos los datos en serie de tiempo con el comando `ts`
```R
tsb <- ts(bra1, start = c(1946,01), frequency = 12)
class(tsb)
summary(tsb)

start(tsb); end(tsb); frequency(tsb)  # Inicio, fin y frecuencia de la serie
```

Graficamos la serie de tiempo
```R
plot(tsb, main = "Serie de tiempo", ylab = "Temp", xlab = "Año")
```
Descomposición aditiva de la serie de tiempo 
```R
tsbd <- decompose(tsb, type = "additive")

plot(tsbd$trend)  # Gráfica  de la tendencia 
plot(tsbd$seasonal) # Gráfica  de la temporalidad
```
Realizamos la gráfica de la descomposición aditiva con la tendencia y la estacionalidad utilizando el comando `lines`
```R
plot(tsbd$trend , main  = "Aditiva", ylab = "Tendencia", xlab = "Año")
lines(tsbd$seasonal + tsbd$trend, col = 2, lty = 2, lwd = 2 )
```

Descomposición multiplicativa
```R
# Debemos elegir entre componente estacional aditiva o multiplicativa
tsbd <- decompose(tsb, type = "multiplicative")

plot(tsbd$trend, main = "Tendencia", ylab = "Tendencia", xlab = "Año")  # Gráfica de la tendencia 
plot(tsbd$seasonal, main = "Estacionalidad", ylab = "Tendencia", xlab = "Año") # Gráfica de la estacionalidad
```

Realizamos la gráfica de la descomposición aditiva con la tendencia y la estacionalidad utilizando el comando `lines`
```R
plot(tsbd$trend , main  = "Multiplicativa", ylab = "Tendencia", xlab = "Año")
lines(tsbd$seasonal * tsbd$trend, col = 2, lty = 2, lwd = 2 )
```

Comportamiento mes a mes
```R
boxplot(tsb ~ cycle(tsb), ylim = c(min(tsb), max(tsb) ) )
```

