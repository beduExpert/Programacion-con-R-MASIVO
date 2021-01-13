# Ejemplo 2. Histogramas

#### Objetivo
- Generar histogramas de datasets
- Cambiar propiedades de los histogramas 
-  Comparar entre `hist()` y `ggplot`

#### Requisitos
- Manipulación de datos con R
- Lectura de ficheros

#### Desarrollo

Utilizaremos los mismos datos del ejemplo 3

```R
data2 <- read.csv("../Sesion_03/boxp.csv")
head(data2)
names(data2)
data <- mutate(data2, Mediciones = Mediciones*1.23)
```

Utilizando la función `hist`

```R
hist(data$Mediciones, breaks = (seq(0,360, 20)), 
     main = "Histograma de Mediciones",
     xlab = "Mediciones",
     ylab = "Frecuencia")
```

Ahora utilizando `ggplot` para apreciar los resultados de las dos funciones

```R
#Evitar el Warning de filas con NA´s
data <- na.omit(data) 

data %>%
  ggplot() + 
  aes(Mediciones) +
  geom_histogram(binwidth = 10)
```

Agregando algunas etiquetas y tema, intenta modificar algunas de las opciones para que aprecies los resultados

```R
data %>%
  ggplot() + 
  aes(Mediciones) +
  geom_histogram(binwidth = 10, col="black", fill = "blue") + 
  ggtitle("Histograma de Mediciones") +
  ylab("Frecuencia") +
  xlab("Mediciones") + 
  theme_light()
```

Tanto `hist()`, como `ggplot() + aes() + geom_histogram()` son útiles para generar los histogramas, tu decide cual te funciona mejor.  

