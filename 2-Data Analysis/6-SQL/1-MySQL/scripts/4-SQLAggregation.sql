/**************************************************************
AGGREGATION
Funciona para SQLite, MySQL
Postgres no permite columnas Select ambiguas en consultas Group-by
**************************************************************/

/**************************************************************
Promedio de GPA de todos los estudiantes
**************************************************************/


/**************************************************************
GPA más bajo de los estudiantes que solicitan CS
**************************************************************/


/*** Promedio de GPA de los estudiantes que solicitan CS ***/


/*** Corregir el conteo incorrecto de GPAs ***/


/**************************************************************
Número de colegios con más de 15,000 estudiantes
**************************************************************/


/**************************************************************
Número de estudiantes que solicitan a Cornell
**************************************************************/


/*** Mostrar por qué el resultado es incorrecto, corregir usando Count Distinct ***/

/**************************************************************
Estudiantes tales que el número de otros estudiantes con el mismo GPA es
igual al número de otros estudiantes con el mismo tamaño de la escuela secundaria
**************************************************************/


/**************************************************************
Cantidad por la cual el GPA promedio de los estudiantes que solicitan CS
supera el promedio de los estudiantes que no solicitan CS
**************************************************************/


/*** Lo mismo utilizando subconsultas en Select ***/

/*** Eliminar duplicados ***/


/**************************************************************
Número de solicitudes a cada colegio
**************************************************************/

/*** Primero realizar la consulta para visualizar***/


/*** Ahora volvamos a la consulta que queremos ***/


/*** Rango más amplio ***/


/**************************************************************
Número de universidades a las que aplicó cada estudiante
**************************************************************/


/*** Primero hacemos la consulta para ver la agrupación ***/


/*** Ahora volvemos a la consulta que queremos ***/


/*** Agregamos el nombre del estudiante ***/


/*** Primero hacemos la consulta para ver la agrupación ***/


/*** Ahora volvemos a la consulta que queremos ***/



/*** Agregamos la universidad (no debería funcionar pero sí en algunos sistemas) ***/


/*** Volvemos a la consulta para ver la agrupación ***/



/**************************************************************
Número de universidades a las que aplicó cada estudiante,
incluyendo 0 para aquellos que no aplicaron a ninguna
**************************************************************/



/*** Agregamos los recuentos 0 ***/



/**************************************************************
Universidades con menos de 5 solicitudes
**************************************************************/


/*** La misma consulta sin Group-by ni Having ***/


/*** Eliminamos duplicados ***/



/*** Volvemos a la consulta original con Group, menos de 5 solicitudes ***/


/**************************************************************
Consulta para encontrar las especialidades cuyo GPA máximo es menor que el promedio
**************************************************************/
