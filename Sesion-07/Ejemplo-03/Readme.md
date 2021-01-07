# Ejemplo 3. 

#### Objetivo
- Utilizar la libreria `dplyr` y `pool` para hacer queries a **MySQL**

#### Requisitos
- Libreria `dplyr`
- Libreria `pool`
- Libreria `DBI`

#### Desarrollo

Ahora utilizaremos otra opción para realizar queries a una BDD con la ayuda de dplyr que sustituye a `SELECT` en **MySQL**  y el operador `%>%`, hay que recordar que con este comando también podemos realizar busquedas  de forma local. 

Comenzamos instalando las paqueterias necesarias y cargándolas a R
```R
install.packages("pool")
install.packages("dbplyr")

library(dbplyr)
library(pool)
```
Se realiza la lectura de la BDD con el comando `dbPool`, los demás parámetros se siguen utilizando igual que el ejemplo anterior  
```R
my_db <- dbPool(
  RMySQL::MySQL(), 
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest"
)
```

Para ver el contenido de la BDD y realizar una busqueda se procede de la siguiente manera
```R
dbListTables(my_db)

# Obtener los primeros 5 registros de Country

my_db %>% tbl("Country") %>% head(5)

# Obtener los primeros 5 registros de CountryLanguage

my_db %>% tbl("CountryLanguage") %>% head(5)
```

Otra forma de generar una busqueda será con la libreria `DBI`, utilizando el comando  `dbSendQuery`

```R
library(DBI)
conn <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

rs <- dbSendQuery(conn, "SELECT * FROM City LIMIT 5;")

dbFetch(rs)
``` 
![](querie.jpg)

Para finalizar nos desconectamos de la BDD
```R
dbClearResult(rs)
dbDisconnect(conn)
```
