/**************************************************************
AGGREGATION
Funciona para SQLite, MySQL
Postgres no permite columnas Select ambiguas en consultas Group-by
**************************************************************/

/**************************************************************
Promedio de GPA de todos los estudiantes
**************************************************************/

select avg(GPA)
from Student;

/**************************************************************
GPA más bajo de los estudiantes que solicitan CS
**************************************************************/

select min(GPA)
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';

/*** Promedio de GPA de los estudiantes que solicitan CS ***/

select avg(GPA)
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';

/*** Corregir el conteo incorrecto de GPAs ***/

select avg(GPA)
from Student
where sID in (select sID from Apply where major = 'CS');

/**************************************************************
Número de colegios con más de 15,000 estudiantes
**************************************************************/

select count(*)
from College
where enrollment > 15000;

/**************************************************************
Número de estudiantes que solicitan a Cornell
**************************************************************/

select count(*)
from Apply
where cName = 'Cornell';

/*** Mostrar por qué el resultado es incorrecto, corregir usando Count Distinct ***/

select *
from Apply
where cName = 'Cornell';

select Count(Distinct sID)
from Apply
where cName = 'Cornell';

/**************************************************************
Estudiantes tales que el número de otros estudiantes con el mismo GPA es
igual al número de otros estudiantes con el mismo tamaño de la escuela secundaria
**************************************************************/

select *
from Student S1
where (select count() from Student S2
where S2.sID <> S1.sID and S2.GPA = S1.GPA) =
(select count() from Student S2
where S2.sID <> S1.sID and S2.sizeHS = S1.sizeHS);

/**************************************************************
Cantidad por la cual el GPA promedio de los estudiantes que solicitan CS
supera el promedio de los estudiantes que no solicitan CS
**************************************************************/

select CS.avgGPA - NonCS.avgGPA
from (select avg(GPA) as avgGPA from Student
where sID in (
select sID from Apply where major = 'CS')) as CS,
(select avg(GPA) as avgGPA from Student
where sID not in (
select sID from Apply where major = 'CS')) as NonCS;

/*** Lo mismo utilizando subconsultas en Select ***/

select (select avg(GPA) as avgGPA from Student
where sID in (
select sID from Apply where major = 'CS')) -
(select avg(GPA) as avgGPA from Student
where sID not in (
select sID from Apply where major = 'CS')) as d
from Student;

/*** Eliminar duplicados ***/

select distinct (select avg(GPA) as avgGPA from Student
where sID in (
select sID from Apply where major = 'CS')) -
(select avg(GPA) as avgGPA from Student
where sID not in (
select sID from Apply where major = 'CS')) as d
from Student;

/**************************************************************
Número de solicitudes a cada colegio
**************************************************************/

select cName, count(*)
from Apply
group by cName;

/*** Primero realizar la consulta para visualizar***/

select cName, major, GPA
from Student, Apply
where Student.sID = Apply.sID
order by cName, major;

/*** Ahora volvamos a la consulta que queremos ***/

SELECT cName, major, MIN(GPA), MAX(GPA)
FROM Student, Apply
WHERE Student.sID = Apply.sID
GROUP BY cName, major;

/*** Rango más amplio ***/

SELECT MAX(mx-mn)
FROM (
SELECT cName, major, MIN(GPA) AS mn, MAX(GPA) AS mx
FROM Student, Apply
WHERE Student.sID = Apply.sID
GROUP BY cName, major
) M;

/**************************************************************
Número de universidades a las que aplicó cada estudiante
**************************************************************/

SELECT Student.sID, COUNT(DISTINCT cName)
FROM Student, Apply
WHERE Student.sID = Apply.sID
GROUP BY Student.sID;

/*** Primero hacemos la consulta para ver la agrupación ***/

SELECT Student.sID, cName
FROM Student, Apply
WHERE Student.sID = Apply.sID
ORDER BY Student.sID;

/*** Ahora volvemos a la consulta que queremos ***/

SELECT Student.sID, COUNT(DISTINCT cName)
FROM Student, Apply
WHERE Student.sID = Apply.sID
GROUP BY Student.sID;

/*** Agregamos el nombre del estudiante ***/

SELECT Student.sID, sName, COUNT(DISTINCT cName)
FROM Student, Apply
WHERE Student.sID = Apply.sID
GROUP BY Student.sID;

/*** Primero hacemos la consulta para ver la agrupación ***/

SELECT Student.sID, sName, cName
FROM Student, Apply
WHERE Student.sID = Apply.sID
ORDER BY Student.sID;

/*** Ahora volvemos a la consulta que queremos ***/

SELECT Student.sID, sName, COUNT(DISTINCT cName)
FROM Student, Apply
WHERE Student.sID = Apply.sID
GROUP BY Student.sID;

/*** Agregamos la universidad (no debería funcionar pero sí en algunos sistemas) ***/

SELECT Student.sID, sName, COUNT(DISTINCT cName), cName
FROM Student, Apply
WHERE Student.sID = Apply.sID
GROUP BY Student.sID;

/*** Volvemos a la consulta para ver la agrupación ***/

SELECT Student.sID, sName, cName
FROM Student, Apply
WHERE Student.sID = Apply.sID
ORDER BY Student.sID;

/**************************************************************
Número de universidades a las que aplicó cada estudiante,
incluyendo 0 para aquellos que no aplicaron a ninguna
**************************************************************/

SELECT Student.sID, COUNT(DISTINCT cName)
FROM Student, Apply
WHERE Student.sID = Apply.sID
GROUP BY Student.sID;

/*** Agregamos los recuentos 0 ***/

SELECT Student.sID, COUNT(DISTINCT cName)
FROM Student, Apply
WHERE Student.sID = Apply.sID
GROUP BY Student.sID
UNION
SELECT sID, 0
FROM Student
WHERE sID NOT IN (SELECT sID FROM Apply);

/**************************************************************
Universidades con menos de 5 solicitudes
**************************************************************/

SELECT cName
FROM Apply
GROUP BY cName
HAVING COUNT(*) < 5;

/*** La misma consulta sin Group-by ni Having ***/

SELECT cName
FROM Apply A1
WHERE 5 > (SELECT COUNT(*) FROM Apply A2 WHERE A2.cName = A1.cName);

/*** Eliminamos duplicados ***/

SELECT DISTINCT cName
FROM Apply A1
WHERE 5 > (SELECT COUNT(*) FROM Apply A2 WHERE A2.cName = A1.cName);

/*** Volvemos a la consulta original con Group, menos de 5 solicitudes ***/

select cName
from Apply
group by cName
having count(distinct sID) < 5;

/**************************************************************
Consulta para encontrar las especialidades cuyo GPA máximo es menor que el promedio
**************************************************************/

select major
from Student, Apply
where Student.sID = Apply.sID
group by major
having max(GPA) < (select avg(GPA) from Student);
