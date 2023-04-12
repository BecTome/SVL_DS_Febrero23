/**************************************************************
AGGREGATION
Funciona para SQLite, MySQL
Postgres no permite columnas Select ambiguas en consultas Group-by
**************************************************************/

/**************************************************************
Promedio de GPA de todos los estudiantes
**************************************************************/
SELECT AVG(GPA) AS AVG_GPA
FROM student;

SELECT SUM(GPA) AS SUM_GPA,
		COUNT(*) AS N,
        SUM(GPA) / COUNT(*) AS AVG_GPA
FROM student;


/**************************************************************
GPA más bajo de los estudiantes que solicitan CS
**************************************************************/

SELECT MIN(GPA) AS min_cs_students
FROM student S
INNER JOIN apply A
ON S.sID = A.sID
WHERE major = "CS";

/*** Promedio de GPA de los estudiantes que solicitan CS ***/

SELECT AVG(X.GPA)
FROM (
		SELECT distinct A.sID, S.sName, GPA
		FROM student S
		INNER JOIN apply A
		ON S.sID = A.sID
		WHERE major = "CS"
        ) X;

SELECT AVG(GPA)
FROM student S
INNER JOIN apply A
ON S.sID = A.sID
WHERE major = "CS";


/*** Corregir el conteo incorrecto de GPAs ***/


/**************************************************************
Número de colegios con más de 15,000 estudiantes
**************************************************************/
SELECT COUNT(cName)
FROM college
WHERE enrollment > 15000;

/**************************************************************
Número de estudiantes que solicitan a Cornell
**************************************************************/
SELECT COUNT(distinct S.sID)
FROM student S
INNER JOIN apply A
ON S.sID = A.sID
WHERE cName = "Cornell";

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
SELECT cName, 
		count(*)
FROM apply
GROUP BY cName;

/*** Ahora volvamos a la consulta que queremos ***/


/*** Rango más amplio ***/


/**************************************************************
Número de universidades a las que aplicó cada estudiante
**************************************************************/

SELECT sID, 
		count(distinct cName)
FROM apply
GROUP BY sID;

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
SELECT S.sID, COUNT(DISTINCT cName)
FROM student S
LEFT JOIN apply A
ON S.sID = a.sID
GROUP BY sID;

WITH 
	X AS (SELECT DISTINCT S.sID, cName
			FROM student S
			LEFT JOIN apply A
			ON S.sID = a.sID),
	Y AS (SELECT *,
					CASE
							WHEN cName is NULL THEN 0
							ELSE 1
					END 
					AS isEmpty
			FROM X)
SELECT sID, SUM(isEmpty)
FROM Y
group by sID;

/**************************************************************
Universidades con menos de 5 solicitudes
**************************************************************/
SELECT C.cName, count(DISTINCT sID) AS n_students
FROM college C
LEFT JOIN apply A
ON C.cName = A.cName
GROUP BY C.cName
HAVING n_students <5;

/*** La misma consulta sin Group-by ni Having ***/


/*** Eliminamos duplicados ***/



/*** Volvemos a la consulta original con Group, menos de 5 solicitudes ***/


/**************************************************************
Consulta para encontrar las especialidades cuyo GPA máximo es menor que el promedio
**************************************************************/
WITH
	X AS (SELECT distinct A.major, S.sID, S.GPA
			FROM Apply A
			INNER JOIN student S
			ON A.sID = s.sID
			ORDER BY major)
        
SELECT major, MAX(GPA) as MAX_GPA, (SELECT AVG(X.GPA) FROM X) AS AVG_TOTAL
FROM X
GROUP BY major
HAVING MAX_GPA < AVG_TOTAL;
