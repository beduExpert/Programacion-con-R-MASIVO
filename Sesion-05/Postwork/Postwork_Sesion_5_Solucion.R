# Postwork Sesión 5

# 1. A partir del conjunto de datos de soccer de la liga española de las temporadas 2017/2018, 2018/2019 y 2019/2020, creé el data frame `SmallData`, que contenga las columnas `date`, `home.team`, `home.score`, `away.team` y `away.score`; esto lo puede hacer con ayuda de la función `select` del paquete `dplyr`. Luego establezca un directorio de trabajo y con ayuda de la función `write.csv` guarde el data frame como un archivo csv con nombre *soccer.csv*. Puede colocar como argumento `row.names = FALSE` en `write.csv`. 
# 2. Con la función `create.fbRanks.dataframes` del paquete `fbRanks` importe el archivo *soccer.csv* a `R` y al mismo tiempo asignelo a una variable llamada `listasoccer`. Se creará una lista con los elementos `scores` y `teams` que son data frames listos para la función `rank.teams`. Asigne estos data frames a variables llamadas `anotaciones` y `equipos`.
# 3. Con ayuda de la función `unique` creé un vector de fechas (`fecha`) que no se repitan y que correspondan a las fechas en las que se jugaron partidos. Creé una variable llamada `n` que contenga el número de fechas diferentes. Posteriormente, con la función `rank.teams` y usando como argumentos los data frames `anotaciones` y `equipos`, creé un ranking de equipos usando unicamente datos desde la fecha inicial y hasta la penúltima fecha en la que se jugaron partidos, estas fechas las deberá especificar en `max.date` y `min.date`. Guarde los resultados con el nombre `ranking`.
# 4. Finalmente estime las probabilidades de los eventos, el equipo de casa gana, el equipo visitante gana o el resultado es un empate para los partidos que se jugaron en la última fecha del vector de fechas `fecha`. Esto lo puede hacer con ayuda de la función `predict` y usando como argumentos `ranking` y `fecha[n]` que deberá especificar en `date`.

####
  
# **Solución**
  
# Lo primero que haremos es cargar los paquetes que usaremos más adelante. Usamos las funciones `suppressWarnings` y `supperssMessages` para que no se impriman mensajes ni advertencias al cargar el paquete.

suppressWarnings(suppressMessages(library(dplyr)))
suppressWarnings(suppressMessages(library(fbRanks)))

# Comenzamos importando los datos que se encuentran en archivos csv a `R`

url1718 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
url1819 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
url1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
d1718 <- read.csv(file = url1718) # Importación de los datos a R
d1819 <- read.csv(file = url1819)
d1920 <- read.csv(file = url1920)

# Obtenemos una mejor idea de los datos que se encuentran en los data frames con las funciones `str`, `head`, `View` y `summary` 

str(d1718); str(d1819); str(d1920)
head(d1718); head(d1819); head(d1920)
View(d1718); View(d1819); View(d1920)
summary(d1718); summary(d1819); summary(d1920)

# Ahora seleccionaremos únicamente las columnas `Date`, `HomeTeam`, `AwayTeam`, `FTHG`, `FTAG` y `FTR` en cada uno de los data frames. Primero guardaremos los data frames en una lista con nombre `lista` y después con ayuda de las funciones `lapply` y `select` (del paquete `dplyr`), seleccionaremos las columnas deseadas. Los nuevos data frames quedarán guardados en `nlista`.

lista <- list(d1718, d1819, d1920)
nlista <- lapply(lista, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)

# Con las funciones `lapply` y `str` observaremos la estrucura de nuestros nuevos data frames

lapply(nlista, str)

# Arreglamos las columnas `Date` para que `R` reconozca los elementos como fechas, esto lo hacemos con las funciones `mutate` (paquete `dplyr`) y `as.Date`.

nlista[[1]] <- mutate(nlista[[1]], Date = as.Date(Date, "%d/%m/%y"))
nlista[[2]] <- mutate(nlista[[2]], Date = as.Date(Date, "%d/%m/%Y"))
nlista[[3]] <- mutate(nlista[[3]], Date = as.Date(Date, "%d/%m/%Y"))

# Verificamos que nuestros cambios se hayan llevado a cabo

lapply(nlista, str)

# Finalmente, con ayuda de las funciones `rbind` y `do.call` combinamos los data frames contenidos en `nlista` como un único data frame

data <- do.call(rbind, nlista)
dim(data)
str(data)
tail(data)
View(data)
summary(data)

# 1. Primero debemos crear el data frame `SmallData`, que contenga las columnas `date`, `home.team`, `home.score`, `away.team` y `away.score`; esto lo hacemos con ayuda de la función `select` del paquete `dplyr`. Luego establecemos un directorio de trabajo y con ayuda de la función `write.csv` guardamos nuestro data frame como un archivo csv con nombre *soccer.csv*.

SmallData <- select(data, date = Date, home.team = HomeTeam, 
                    home.score = FTHG, away.team = AwayTeam, 
                    away.score = FTAG)
write.csv(x = SmallData, file = "soccer.csv", row.names = FALSE)

# 2. Ahora con la función `create.fbRanks.dataframes` del paquete `fbRanks` importamos nuestro archivo *soccer.csv* a `R` y al mismo tiempo asignamos a una variable llamada `listasoccer`. Se creará una lista con los elementos `scores` y `teams` que son data frames listos para la función `rank.teams`. Asignamos estos data frames a variables llamadas `anotaciones` y `equipos`.

listasoccer <- create.fbRanks.dataframes(scores.file = "soccer.csv")
anotaciones <- listasoccer$scores
equipos <- listasoccer$teams

# 3. Ahora con ayuda de la función `unique` creamos un vector de fechas que no se repiten y que corresponde a las fechas en las que se jugaron partidos. Creamos una variable llamada `n` que contiene el número de fechas diferentes. Posteriormente, con la función `rank.teams` y usando como argumentos los data frames `anotaciones` y `equipos`, creamos un ranking de equipos usando unicamente datos desde la fecha inicial y hasta la penúltima fecha en la que se jugaron partidos, estas fechas las especificamos en `max.date` y `min.date`. Guardamos los resultados con el nombre `ranking`.

fecha <- unique(anotaciones$date)
n <- length(fecha)
ranking <- rank.teams(scores = anotaciones, teams = equipos,
                      max.date = fecha[n-1],
                      min.date = fecha[1])
  
# 4. Finalmente estimamos las probabilidades de los eventos, el equipo de casa gana, el equipo visitante gana o el resultado es un empate para los partidos que se jugaron en la última fecha de nuestro vector de fechas `fecha`. Esto lo hacemos con ayuda de la función `predict` y usando como argumentos `ranking` y `fecha[n]` que especificamos en `date`.

pred <- predict(ranking, date = fecha[n])

