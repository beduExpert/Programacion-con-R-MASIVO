library(mongolite)

setwd("../Sesión 7/")   #dependerá de donde estén guardados tus datos
match=data.table::fread("../data.csv")
names(match)

my_collection = mongo(collection = "match", db = "match_games") # create connection, database and collection
my_collection$insert(match)  #insertando el CVS a la BDD

# Número de registros
my_collection$count()

# Visualizar el fichero 
my_collection$find()

# Basic queries: ¿Cuántos goles metió como local el Real Madrid el la fecha estipulada?
my_collection$find('{"date":"2015-12-20", "home_team":"Real Madrid"}')

#Agregar otro CVS a la DDB
my_collection = mongo(collection = "mtcars", db = "match_games") # create connection, database and collection
my_collection$insert(mtcars)

# Cerrando la conexión
rm(my_collection)
