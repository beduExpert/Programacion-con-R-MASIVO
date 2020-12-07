#Solución del Postwork Sesión 4

#Lo primero que haremos es cargar los paquetes que usaremos más adelante. Usamos las funciones suppressWarnings y supperssMessages para que no se impriman mensajes ni advertencias al cargar el paquete.

suppressWarnings(suppressMessages(library(dplyr)))
suppressWarnings(suppressMessages(library(reshape2)))
suppressWarnings(suppressMessages(library(ggplot2)))

#Comenzamos importando los datos que se encuentran en archivos csv a R

url1718 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url1819 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

d1718 <- read.csv(file = url1718) # Importación de los datos a R
d1819 <- read.csv(file = url1819)
d1920 <- read.csv(file = url1920)

#Obtenemos una mejor idea de los datos que se encuentran en los data frames con las funciones str, head, View y summary

str(d1718); str(d1819); str(d1920)
head(d1718); head(d1819); head(d1920)
View(d1718); View(d1819); View(d1920)
summary(d1718); summary(d1819); summary(d1920)

#Ahora seleccionaremos únicamente las columnas Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR en cada uno de los data frames. Primero guardaremos los data frames en una lista con nombre lista y después con ayuda de las funciones lapply y select (del paquete dplyr), seleccionaremos las columnas deseadas. Los nuevos data frames quedarán guardados en nlista.
lista <- list(d1718, d1819, d1920)
nlista <- lapply(lista, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)

#Con las funciones lapply y str observaremos la estrucura de nuestros nuevos data frames
lapply(nlista, str)

#Arreglamos las columnas Date para que R reconozca los elementos como fechas, esto lo hacemos con las funciones mutate (paquete dplyr) y as.Date.
nlista[[1]] <- mutate(nlista[[1]], Date = as.Date(Date, "%d/%m/%y"))
nlista[[2]] <- mutate(nlista[[2]], Date = as.Date(Date, "%d/%m/%Y"))
nlista[[3]] <- mutate(nlista[[3]], Date = as.Date(Date, "%d/%m/%Y"))

#Verificamos que nuestros cambios se hayan llevado a cabo
lapply(nlista, str)

#Finalmente, con ayuda de las funciones rbind y do.call combinamos los data frames contenidos en nlista como un único data frame
data <- do.call(rbind, nlista)
dim(data)
str(data)
tail(data)
View(data)
summary(data)

#Con ayuda de la función table obtenemos las estimaciones de probabilidades solicitadas
(pcasa <- round(table(data$FTHG)/dim(data)[1], 3)) # Probabilidades marginales estimadas para los equipos que juegan en casa

(pvisita <- round(table(data$FTAG)/dim(data)[1], 3)) # Probabilidades marginales estimadas para los equipos que juegan como visitante

(pcta <- round(table(data$FTHG, data$FTAG)/dim(data)[1], 3)) # Probabilidades conjuntas estimadas para los partidos

#Con la función apply primero dividimos cada elemento de las columnas de la matriz de probabilidades conjuntas, por las probabilidades marginales asociadas y que corresponden al equipo de casa. Note como hemos definido una función anómima dentro de apply. Luego dividimos cada elemento de las filas de la matriz que resulta, por las probabilidades marginales asociadas y que corresponden al equivo visitante. Finalmente hacemos obtenemos la transpuesta de la matriz que resulta. Esta última matriz, es la matriz de cocientes buscada, es decir, hemos dividio cada probabilidad conjunta, por el producto de probabilidades marginales correspondientes.
(cocientes <- apply(pcta, 2, function(col) col/pcasa))

(cocientes <- apply(cocientes, 1, function(fila) fila/pvisita))

(cocientes <- t(cocientes))

#Lo anterior igual lo pudimos lograr de la siguiente manera:

pcta/outer(pcasa, pvisita, "*")

#Primero extraemos de manera aleatoria algunas filas de nuestro data frame data, esto lo hacemos con ayuda de la función sample.
set.seed(2)
indices <- sample(dim(data)[1], size = 380, replace = TRUE)
newdata <- data[indices, ]

#Con ayuda de la función table obtenemos las estimaciones de probabilidades

(pcasa <- round(table(newdata$FTHG)/dim(newdata)[1], 3)) # Probabilidades marginales estimadas para los equipos que juegan en casa

(pvisita <- round(table(newdata$FTAG)/dim(newdata)[1], 3)) # Probabilidades marginales estimadas para los equipos que juegan como visitante

(pcta <- round(table(newdata$FTHG, newdata$FTAG)/dim(newdata)[1], 3)) # Probabilidades conjuntas estimadas para los partidos

#Obtenemos nuevamente los cocientes de probabilidades conjuntas entre probabilidades marginales

(cocientes <- pcta/outer(pcasa, pvisita, "*"))

#Repita el remuestreo anterior varias veces (unas 1000 veces) y obtenga una idea de las distribuciones de los cocientes. 
#Finalmente mencione en cuales casos le parece razonable la suposición de que el cociente es igual a 1.


