# Ejemplo 01. Ambiente de trabajo UI y Server

#### Objetivo
- Entender el entorno de trabajo con la libreria `Shiny`
- Funciones básicas de la UI y del Server
- Presentar gráficas de dispersión en una webApp

#### Requisitos
- Tener instalada y cargada la libreria `Shiny`
- Desarrollar y entender el prework
- conocimiento de funciones como `paste` y `plot` 

#### Desarollo

Durante esta sesión serás capaz de realizar una webApp con el uso de la libreria de `Shiny`, está es útil para presentar reportes. 

Lo primero que se debe hacer es generar un arhivo Shiny Web App en RStudio

![image](imagenes/1.1.png)

Hay que colocar un nombre de nuestra Web App, además de seleccionar multiple file (esto creará dos archivos ui.R y server.R) y la ruta donde se almacenará 

![](imagenes/1.2.png)


Una vez hecho esto, tendremos los dos archivos creados, en el UI (User interface), se establece la visualización de nuestro Dashboar o reporte, y en el Serve se establecen las variables de entrada y salida. Para ejecutar la Web App con dar clic en `Run App` bastará. Los archivos por default tienen un ejemplo precargado el podría servir como base para ajustarlo a las necesidades de cada usuario

![](imagenes/1.3.png)


En la siguiente imágen podemos apreciar el ejemplo indicado anteriormente, ejecuta el ejemplo, intenta mover los parámetros para que observes el resultado tato dentro del archivo ui.R y de la webApp.

<p align="center">
<img src="imagenes/1.4.png" width="650" height="450"> 
</p>

A continuación se creará una webApp desde cero, se deben borrar todos los comentarios para dejar solamente las siguientes líneas de código

```R
library(shiny)
shinyUI(

)
```


En el archivo `ui.R`, dentro de la fución `shinyUI` colocaremos las siguientes instrucciones para poder visualizar las partes de nuesta webApp, posteriormente ejecuta el código para que observes el resultado y puedas ubicar donde se localiza gráficamente cada sentencia

```R
library(shiny)
shinyUI(
    pageWithSidebar(
    
        headerPanel("Este es el header panel"),
        sidebarPanel("Este es el sidebar panel"),
        mainPanel("Este es el main panel")
    
    )
)
```


Con lo anterior ya pudiste observar la distrubución de los objetos dentro de la webApp. Ahora vamos a crear una donde se puedam observar algunas gráficas de dispersión para las variables del dataset `mtcars`. 

En el archivo **`ui.R`** realiza los siguientes cambios

```R
library(shiny)
shinyUI(
    
    pageWithSidebar(
        headerPanel ("Aplicacion simple con Shiny"),
        sidebarPanel (
            p("Vamos a crear plots con el dataset de 'mtcars'"),
            selectInput("x", "Selecciona el eje de las X",
                        choices = colnames(mtcars) )
                    ),
        mainPanel (h3(textOutput("output_text")), 
                   plotOutput("output_plot")
                   )
                  )
        )
```
 
Ahora en el archivo **`server.R`**, debes borrar todos los comentarios, de tal modo que quede de la siguiente forma, el código siguiente define los argumentos de `imput` y `output` qué se visualizaran en la *UI*, en este caso se harán los gráficos correlación entre `mpg` y el resto de variables de `mtcars` 

```R
library(shiny)

shinyServer(function(input, output) { 
    output$output_text <- renderText(paste("Grafico de mpg ~ ", input$x))
    output$output_plot <- renderPlot(plot(as.formula(paste("mpg~", input$x)), 
                                          data = mtcars))
                                    }
            )
```

Ejecula la webApp y observa el resultado que se generó con el dódigo, ¿Qué otros escenarios se te ocurren?
