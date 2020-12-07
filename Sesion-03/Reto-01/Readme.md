# Reto 1. Series de tiempo

#### Proposito
- Poner en práctica los conocimientos de series de tiempo para poder manipularlas y así obtener información relevante
- Implementar la descomposición **aditiva** y **multiplicativa**

#### Requisitos
- Haber llevado seguimiento de los ejercicios en clase
- Prework

#### Desarrollo 

Utiliza los datos (AP), de la siguiente librería para realizar lo que se te pide 

```R
library(forecast)
data(AirPassengers)
AP <- AirPassengers
```

1. Realiza la gráfica la serie de tiempo 
2. Descompón la serie de tiempo en aditiva y multiplicativa y realiza sus gráficas
3. Realiza la gráfica de la descomposición aditiva con la tendencia y la estacionalidad utilizando el comando `lines`
4. Realiza la gráfica de la descomposición multiplicativa con la tendencia y la estacionalidad utilizando el comando `lines`
5. Ejecuta la prueba de _Dickey-Fuller_ para determinar si el comportamiento es estocástico
