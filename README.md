# Recuperatorio Primer Parcial 2018
Consigna: https://docs.google.com/document/d/1iiHrEGrEhoWGRyaBAkAIg7ukvMU6KWw-YrafJOJPHt4/edit?usp=sharing


### Comentarios sobre la solucion

Las soluciones contiene los datos de ejemplo que sugiere la consigna. Para probar todos los casos se debe ampliar la base de conocimiento o las funciones de ejemplo definidas

De la parte funcional se proponen tres soluciones:
* La primera es mas parecida al modelado en logico, donde el vinculo entre las acciones y los periodos presidenciales esta dado por las fechas. En muchos items se requiere que se pase como parametro la lista de acciones y la lista de periodos.
* La segunda esta modelada con una lista de acciones dentro de cada periodo. Se simplifica algunos items y ya no se pasa la lista de acciones como parametros porque al tener el periodo ya se pueden conocer sus acciones.
* La tercera modela un tipo de dato presidente que tiene una lista de periodos, lo que permite minimizar el pasaje de parametros.
