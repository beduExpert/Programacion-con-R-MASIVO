# Postwork 

# Importe el conjunto de datos match.data.csv a `R`:

# 1. Agregue una nueva columna `sumagoles` que contenga la suma de goles por partido
# 2. Obtenga el promedio por mes de la suma de goles
# 3. Creé la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019
# 4. Grafique la serie de tiempo

# Solución

# Primero cargamos el paquete que utilizaremos para manipular los datos

library(dplyr)

# Establecemos nuestro directorio de trabajo que deberá contener el archivo csv que importaremos a `R`

# Importamos los datos a `R`

data <- read.csv("match.data.csv")

# 1. # 2.

# Agregamos la columna `sumagoles` y obtenemos el promedio por mes
# de la suma de goles

nd <- data %>% 
  mutate(date = as.Date(date, "%Y-%m-%d"),
         sumagoles = home.score + away.score) %>%
  mutate(Ames = format(date, "%Y-%m")) %>%
  group_by(Ames) %>%
  summarise(promgoles = mean(sumagoles))

(nd <- as.data.frame(nd))

(nd <- nd %>% filter(Ames != "2013-06"))
(nd <- nd[1:95,])

# A partir de agosto de 2010

# 3. Creamos la serie de tiempo en `R`

(promgoles <- ts(nd$promgoles, start = 1,
                frequency = 10))

# 4. Graficamos la serie de tiempo

ts.plot(promgoles)
