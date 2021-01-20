# Ejemplo 3. Máquinas de vectores de soporte (Compañía de tarjetas de crédito)

#### Objetivo

- Clasificar clientes potenciales de una compañía de tarjetas de crédito usando máquinas de vectores de soporte

#### Requisitos

- Tener instalado R y RStudio
- Haber trabajado con el Prework

#### Desarrollo

1. Observe algunas características del data frame `Default` del paquete `ISLR`, con funciones tales como `head`, `tail`, `dim` y `str`.

2. Usando `ggplot` del paquete `ggplot2`, realice el gráfico de dispersión con la variable `balance` en el eje x, la variable `income` en el eje y, distinga las distintas categorías en la variable `default` usando el argumento `colour`. Lo anterior para estudiantes y no estudiantes usando `facet_wrap`.

3. Genere un vector de índices llamado `train`, tomando de manera aleatoria 5000 números de los primeros 10,000 números naturales, esto servirá para filtrar el conjunto de entrenamiento y el conjunto de prueba del data frame `Default`. Realice el gráfico de dispersión análogo al punto 2, pero para los conjuntos de entrenamiento y de prueba.

4. Ahora utilice la función `tune` junto con la función `svm` para seleccionar el mejor modelo de un conjunto de modelos, los modelos considerados serán aquellos obtenidos al variar los valores de los parámetros `cost` y `gamma` (use un kernel radial).

5. Con el mejor modelo seleccionado y utilizando el conjunto de prueba, obtenga una matriz de confusión, para observar el número de aciertos y errores cometidos por el modelo. Obtenga la proporción total de aciertos y la matriz que muestre las proporciones de aciertos y errores cometidos pero por categorías.

6. Ajuste nuevamente el mejor modelo, pero ahora con el argumento `decision.values = TRUE`. Obtenga los valores predichos para el conjunto de prueba utilizando el mejor modelo, las funciones `predict`, `attributes` y el argumento `decision.values = TRUE` dentro de `predict`.

7. Realice clasificación de las observaciones del conjunto de prueba utilizando los valores predichos por el modelo y un umbral de decisión igual a cero. Obtenga la matriz de confusión y proporciones como anteriormente hicimos.

8. Repita el paso 7 pero con un umbral de decisión diferente, de tal manera que se reduzca la proporción del error más grave para la compañía de tarjetas de crédito.
