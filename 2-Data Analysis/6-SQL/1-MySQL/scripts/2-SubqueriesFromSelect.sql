/**************************************************************
  SUBQUERIES IN THE FROM AND SELECT CLAUSES
  Works for MySQL and Postgres
  SQLite doesn't support All
**************************************************************/

/**************************************************************
  Estudiantes cuyo GPA escalado difiere en más de 1 del GPA
**************************************************************/

/***Lo podemos simplificar con la funcion valor absoluto ***/


/*** Lo podemos simplificar más aún si hacemos subquery desde FROM ***/

select *
from (select sID, sName, GPA, GPA*(sizeHS/1000.0) as scaledGPA
      from Student) G
where abs(scaledGPA - GPA) > 1.0;

/**************************************************************
  Facultades emparejadas por el mayor GPA de sus aplicantes
**************************************************************/

select College.cName, state, GPA
from College, Apply, Student
where College.cName = Apply.cName
  and Apply.sID = Student.sID
  and GPA >= all
          (select GPA from Student, Apply
           where Student.sID = Apply.sID
             and Apply.cName = College.cName);

/*** Añadimos distinct para eliminar duplicados ***/


/*** Usamos subquery en el select ***/

/*** Now pair colleges with names of their applicants
    (doesn't work due to multiple rows in subquery result) ***/

select distinct cName, state,
  (select distinct sName
   from Apply, Student
   where College.cName = Apply.cName
     and Apply.sID = Student.sID) as sName
from College;
