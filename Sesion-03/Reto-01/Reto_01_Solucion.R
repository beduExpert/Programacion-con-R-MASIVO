#Comenzaremos con un ejemplo típico que viene en la libreria `forecast`, el cual contiene datos de 
# los pasajeros internacionales de una aerolínea (Pan Am), entre los años de 1946 - 1960. Los datos 
# se utilizaron para predecir la demanda futura y la posible adquisición de aeronaves.

#Iniciamos cargando la libreria y cargando los datos


library(forecast)
data(AirPassengers)
AP <- AirPassengers
AP

#Verificamos que los datos sean una serie de tiempo

class(AP)

#Ahora podemos conocer el inicio, fin y la frecuencia de los datos en la serie de tiempo y los estadísticos básicos

start(AP); end(AP); frequency(AP)
summary(AP)

#Graficando la serie de tiempo

plot(AP, ylab= "Passengers (x1000)") # 1.


# Realizamos la gráfica de la descomposición 

Adi <- decompose(AirPassengers, type = "additive")
Mul <- decompose(AirPassengers, type = "multiplicative")

plot(Adi) # 2.

plot(Mul)

plot(Adi$trend , main  = "Aditiva", ylab = "Tendencia", xlab = "Año") # 3.
lines(Adi$seasonal + Adi$trend, col = 2, lty = 2, lwd = 2 )

# Debemos elegir entre componente estacional aditiva o multiplicativa

plot(Mul$trend , main  = "Multiplicativa", ylab = "Tendencia", xlab = "Año") # 4.
lines(Mul$seasonal * Mul$trend, col = 2, lty = 2, lwd = 2 )
