/**************************************************************
  BASIC SELECT STATEMENTS
  Works for SQLite, MySQL, Postgres
**************************************************************/

/**************************************************************
  IDs, names, y GPAs de estudiantes con GPA > 3.6
**************************************************************/

SELECT sID, sName, GPA
FROM student
WHERE GPA > 3.6;

/*** Same query without GPA ***/
SELECT sID, sName
FROM student
WHERE GPA > 3.6;


/**************************************************************
  Nombres de los estudiantes y majors a los que han aplicado
**************************************************************/

select sName, major
from Student, Apply
where Student.sID = Apply.sID;

select distinct sName, major
from Student
inner join Apply
on Student.sID = Apply.sID;

/*** La misma query con distinct ***/
select distinct sName, major
from Student
inner join Apply
on Student.sID = Apply.sID;

/**************************************************************
  Names y GPAs de estudiantes con sizeHS < 1000 aplicando
  CS en Stanford, y la decisión de aplicación
**************************************************************/
SELECT sName, GPA, decision
FROM student S
INNER JOIN apply A
ON S.sID = A.sID
WHERE sizeHS < 1000 AND major = "CS" AND cName = "Stanford";

/**************************************************************
  Todos los campus grandes (+20k enrollment) con aplicantes a CS
**************************************************************/
SELECT cName
FROM college C
INNER JOIN apply A
ON C.cName = A.cName
WHERE enrollment > 20000;

/*** Solucionamos el error ***/
SELECT C.cName
FROM college C
INNER JOIN apply A
ON C.cName = A.cName
WHERE C.enrollment > 20000 AND A.major = "CS";

/*** Añade Distinct al nombre ***/
SELECT DISTINCT C.cName
FROM college C
INNER JOIN apply A
ON C.cName = A.cName
WHERE C.enrollment > 20000 AND A.major = "CS";

/**************************************************************
  Información de Aplicaciones (combinamos los 3)
**************************************************************/
SELECT S.*, 
		A.cName, 
        A.major, 
        C.state, 
        C.enrollment,
        A.decision
FROM apply A
INNER JOIN student S
ON A.sID = S.sID
INNER JOIN college C
ON A.cName = C.cName;

/*** Ordenamos por GPA decreciente ***/
SELECT S.*, 
		A.cName, 
        A.major, 
        C.state, 
        C.enrollment,
        A.decision
FROM apply A
INNER JOIN student S
ON A.sID = S.sID
INNER JOIN college C
ON A.cName = C.cName
ORDER BY S.GPA DESC;

/***Ahora también por enrollment ascendiente ***/
SELECT S.*, 
		A.cName, 
        A.major, 
        C.state, 
        C.enrollment,
        A.decision
FROM apply A
INNER JOIN student S
ON A.sID = S.sID
INNER JOIN college C
ON A.cName = C.cName
ORDER BY S.GPA DESC, C.enrollment;

/**************************************************************
  Aplicantes a grados "bio"
**************************************************************/

/* Introducimos LIKE a nuestra sintaxis*/
SELECT * 
FROM apply
WHERE major IN ("biology", "bioengineering", "marine biology");

SELECT * 
FROM apply
WHERE major LIKE "%bio%";

/*** Lo mismo pero con Select * ***/


/**************************************************************
  Crea un GPA escalado basado en sizeHS (GPA*(sizeHS/1000.0))
**************************************************************/

/*** Rename result attribute ***/
SELECT *, 
		GPA * (sizeHS / 1000.0) AS ScaledGPA
FROM student;