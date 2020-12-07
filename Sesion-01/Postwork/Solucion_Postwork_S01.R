#Solución al Postwork Sesión 1
#Primera parte
url <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv" # url donde se encuentra el archivo csv
data <- read.csv(file = url) # Importación de los datos a R
dim(data) # Número de filas y número de columnas del data frame

#Segunda parte
data$FTHG # Goles anotados por los equipos que jugaron en casa
data$FTAG # Goles anotados por los equipos que jugaron como visitante

#Tercera parte
(table(data$FTHG)/dim(data)[1])*100 # Probabilidades marginales estimadas

(table(data$FTAG)/dim(data)[1])*100 # Probabilidades marginales estimadas

(table(data$FTHG, data$FTAG)/dim(data)[1])*100 # Probabilidades conjuntas estimadas
