/**************************************************************
  BASIC SELECT STATEMENTS
  Works for SQLite, MySQL, Postgres
**************************************************************/

/**************************************************************
  IDs, names, y GPAs de estudiantes con GPA > 3.6
**************************************************************/


/*** Same query without GPA ***/


/**************************************************************
  Nombres de los estudiantes y majors a los que han aplicado
**************************************************************/

select sName, major
from Student, Apply
where Student.sID = Apply.sID;

/*** La misma query con distinct ***/


/**************************************************************
  Names y GPAs de estudiantes con sizeHS < 1000 aplicando
  CS en Stanford, y la decisión de aplicación
**************************************************************/


/**************************************************************
  Todos los campus grandes (+20k enrollment) con aplicantes a CS
**************************************************************/


/*** Solucionamos el error ***/

/*** Añade Distinct al nombre ***/

/**************************************************************
  Información de Aplicaciones (combinamos los 3)
**************************************************************/


/*** Ordenamos por GPA decreciente ***/


/***Ahora también por enrollment ascendiente ***/

/**************************************************************
  Aplicantes a grados "bio"
**************************************************************/

/* Introducimos LIKE a nuestra sintaxis*/


/*** Lo mismo pero con Select * ***/


/**************************************************************
  Crea un GPA escalado basado en sizeHS (GPA*(sizeHS/1000.0))
**************************************************************/

/*** Rename result attribute ***/
