/**************************************************************
OPERADORES DE JOIN
Funciona para Postgres
MySQL no admite FULL OUTER JOIN
SQLite no admite RIGHT o FULL OUTER JOIN
**************************************************************/

/**************************************************************
INNER JOIN
Nombres de estudiantes y sus especialidades a las que han aplicado
**************************************************************/

select distinct sName, major
from Student, Apply
where Student.sID = Apply.sID;

/*** Reescribir usando INNER JOIN ***/

select distinct sName, major
from Student inner join Apply
on Student.sID = Apply.sID;

/*** La abreviatura es JOIN ***/

select distinct sName, major
from Student join Apply
on Student.sID = Apply.sID;

/**************************************************************
INNER JOIN CON CONDICIONES ADICIONALES
Nombres y GPAs de estudiantes con sizeHS < 1000 aplicando a
CS en Stanford
**************************************************************/

select sName, GPA
from Student, Apply
where Student.sID = Apply.sID
and sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

/*** Reescribir usando JOIN ***/

select sName, GPA
from Student join Apply
on Student.sID = Apply.sID
where sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

/*** Todo se puede colocar en la condición JOIN ON ***/

select sName, GPA
from Student join Apply
on Student.sID = Apply.sID
and sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

/**************************************************************
INNER JOIN DE TRES TABLAS
Información de aplicación: ID, nombre, GPA, nombre del colegio, inscripción
**************************************************************/

select Apply.sID, sName, GPA, Apply.cName, enrollment
from Apply, Student, College
where Apply.sID = Student.sID and Apply.cName = College.cName;

/*** Reescribir usando tres JOIN /
/ Funciona en SQLite y MySQL pero no en Postgres ***/

select Apply.sID, sName, GPA, Apply.cName, enrollment
from Apply join Student join College
on Apply.sID = Student.sID and Apply.cName = College.cName;

/*** Reescribir usando JOIN binario ***/

select Apply.sID, sName, GPA, Apply.cName, enrollment
from (Apply join Student on Apply.sID = Student.sID) join College on Apply.cName = College.cName;

/**************************************************************
JOIN NATURAL
Nombres de estudiantes y sus especialidades a las que han aplicado
**************************************************************/

select distinct sName, major
from Student inner join Apply
on Student.sID = Apply.sID;

/*** Reescribir usando JOIN NATURAL ***/

select distinct sName, major
from Student natural join Apply;

/*** Al igual que el álgebra relacional, elimina columnas duplicadas ***/

select *
from Student natural join Apply;

select distinct sID
from Student natural join Apply;

/*** Se obtendría un error de ambigüedad con el producto cruzado ***/

select distinct sID
from Student, Apply;

/**************************************************************
JOIN NATURAL CON CONDICIONES ADICIONALES
Nombres y GPAs de estudiantes con sizeHS < 1000 aplicando a
CS en Stanford
**************************************************************/

select sName, GPA
from Student join Apply
on Student.sID = Apply.sID
where sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

/*** Reescribir usando JOIN NATURAL ***/

select sName, GPA
from Student join Apply
on Student.sID = Apply.sID
where sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

/*** La cláusula USING se considera más segura ***/

select sName, GPA
from Student join Apply using(sID)
where sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

/**************************************************************
AUTOJOIN
Pares de estudiantes con el mismo GPA
**************************************************************/

select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1, Student S2
where S1.GPA = S2.GPA and S1.sID < S2.sID;

/*** Reescribir usando JOIN y USING (no permitido) ***/

select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1 join Student S2 on S1.sID < S2.sID using(GPA);

/*** Sin cláusula ON ***/

select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1 join Student S2 using(GPA)
where S1.sID < S2.sID;

/**************************************************************
AUTOJOIN NATURAL
**************************************************************/

select *
from Student S1 natural join Student S2;

/*** Verificar la equivalencia con Student ***/

select * from Student;

/**************************************************************
LEFT OUTER JOIN
Información de solicitud de estudiantes: nombre, ID, nombre universidad, especialidad
**************************************************************/

select sName, sID, cName, major
from Student inner join Apply using(sID);

/*** Incluir estudiantes que no han solicitado a ninguna universidad ***/

select sName, sID, cName, major
from Student left outer join Apply using(sID);

/*** Abreviatura es LEFT JOIN ***/

select sName, sID, cName, major
from Student left join Apply using(sID);

/*** Usando NATURAL OUTER JOIN ***/

select sName, sID, cName, major
from Student natural left outer join Apply;

/*** Se puede simular sin ningún operador JOIN ***/

select sName, Student.sID, cName, major
from Student, Apply
where Student.sID = Apply.sID
union
select sName, sID, NULL, NULL
from Student
where sID not in (select sID from Apply);

/*** En su lugar, se incluyen las solicitudes sin estudiantes coincidentes ***/

insert into Apply values (321, 'MIT', 'historia', 'N');
insert into Apply values (321, 'MIT', 'psicología', 'Y');

select sName, sID, cName, major
from Apply natural left outer join Student;

/**************************************************************
RIGHT OUTER JOIN
Información de solicitud de estudiantes: nombre, ID, nombre universidad, especialidad
**************************************************************/

/*** Incluir solicitudes sin estudiantes coincidentes ***/

select sName, sID, cName, major
from Student natural right outer join Apply;

/**************************************************************
FULL OUTER JOIN
Información de solicitud de estudiantes
**************************************************************/

/*** Incluir estudiantes que no han solicitado a ninguna universidad /
/ y solicitudes sin estudiantes coincidentes ***/

select sName, sID, cName, major
from Student full outer join Apply using(sID);

/*** Se puede simular con LEFT y RIGHT OUTER JOIN /
/ Nota: UNION elimina duplicados ***/

select sName, sID, cName, major
from Student left outer join Apply using(sID)
union
select sName, sID, sID, cName, major
from Student right outer join Apply using(sID);

