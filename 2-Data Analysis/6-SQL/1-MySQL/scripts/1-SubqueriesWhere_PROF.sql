/**************************************************************
  SUBQUERIES IN THE WHERE CLAUSE
  Works for MySQL, Postgres
  SQLite doesn't support All or Any
**************************************************************/

/**************************************************************
  IDs y nombres de estudiantes aplicando a CS
**************************************************************/

select sID, sName
from Student
where sID in (select sID from Apply where major = 'CS');

/**************************************************************
  La misma query escrita sin "In"
**************************************************************/

select sID, sName
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';

/*** Resuelve el error ***/

select Student.sID, sName
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';

/*** Elimina Duplicados ***/

select distinct Student.sID, sName
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';

/**************************************************************
  Solo nombres de estudiantes que aplican a CS
**************************************************************/

select sName
from Student
where sID in (select sID from Apply where major = 'CS');

/**************************************************************
  La misma query escrita sin "In" (cruzando)
**************************************************************/

select sName
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';

/*** Eliminamos duplicados (aun incorrecto) ***/

select distinct sName
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';

/**************************************************************
  Los duplicados son importantes: GPA promedio de los 
  aplicantes a CS
**************************************************************/

select GPA
from Student
where sID in (select sID from Apply where major = 'CS');

/**************************************************************
  Queries alternativas e incorrectas sin "In"
**************************************************************/

select GPA
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';

select distinct GPA
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';

/**************************************************************
  Estudiantes que aplicaron a CS pero no EE
**************************************************************/

select sID, sName
from Student
where sID in (select sID from Apply where major = 'CS')
  and sID not in (select sID from Apply where major = 'EE');

/*** Cambio por not sID in***/

select sID, sName
from Student
where sID in (select sID from Apply where major = 'CS')
  and not sID in (select sID from Apply where major = 'EE');

/**************************************************************
  Facultades cumpliendo que hay otras en el mismo estado
**************************************************************/

select cName, state
from College C1
where exists (select * from College C2
              where C2.state = C1.state);

/*** Cuidado con ellas mismas ***/

select cName, state
from College C1
where exists (select * from College C2
              where C2.state = C1.state and C2.cName <> C1.cName);

/**************************************************************
  La facultad más grande (not exists uno mayor)
**************************************************************/

select cName
from College C1
where not exists (select * from College C2
                  where C2.enrollment > C1.enrollment);

/*** Similar: estudiante con mayor GPA  ***/

select sName
from Student C1
where not exists (select * from Student C2
                  where C2.GPA > C1.GPA);

/*** Añade GPA***/

select sName, GPA
from Student C1
where not exists (select * from Student C2
                  where C2.GPA > C1.GPA);

/**************************************************************
  Mayor GPA sin subquery
**************************************************************/

select S1.sName, S1.GPA
from Student S1, Student S2
where S1.GPA > S2.GPA;

/*** Eliminamos Duplicados (aun incorrecto) ***/

select distinct S1.sName, S1.GPA
from Student S1, Student S2
where S1.GPA > S2.GPA;

/**************************************************************
  Mayor GPA usando ">= all"
**************************************************************/

select sName, GPA
from Student
where GPA >= all (select GPA from Student);

/**************************************************************
  Mayor GPA que todos los demás estudiantes sin considerarse 
  a ellos mismos 
**************************************************************/

select sName, GPA
from Student S1
where GPA > all (select GPA from Student S2
                 where S2.sID <> S1.sID);

/*** Similar: mayor enrollment que el resto de facultades (>all) ***/

select cName
from College S1
where enrollment > all (select enrollment from College S2
                        where S2.cName <> S1.cName);

/*** La misma query usando not <= any ***/

select cName
from College S1
where not enrollment <= any (select enrollment from College S2
                             where S2.cName <> S1.cName);

/**************************************************************
  Estudiantes que no son del menor HS (> any)
**************************************************************/

select sID, sName, sizeHS
from Student
where sizeHS > any (select sizeHS from Student);

/**************************************************************
  Igual pero sin any/all (exists y where)
**************************************************************/

select sID, sName, sizeHS
from Student S1
where exists (select * from Student S2
              where S2.sizeHS < S1.sizeHS);

/**************************************************************
  Estudiantes que aplicaron a CS pero no a EE
**************************************************************/

select sID, sName
from Student
where sID = any (select sID from Apply where major = 'CS')
  and sID <> any (select sID from Apply where major = 'EE');

/*** Subtle error, fix ***/

select sID, sName
from Student
where sID = any (select sID from Apply where major = 'CS')
  and not sID = any (select sID from Apply where major = 'EE');
