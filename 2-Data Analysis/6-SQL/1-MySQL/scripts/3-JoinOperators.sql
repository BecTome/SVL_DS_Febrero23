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

/*** Reescribir usando INNER JOIN ***/


/*** La abreviatura es JOIN ***/


/**************************************************************
INNER JOIN CON CONDICIONES ADICIONALES
Nombres y GPAs de estudiantes con sizeHS < 1000 aplicando a
CS en Stanford
**************************************************************/

/*** Reescribir usando JOIN ***/


/*** Todo se puede colocar en la condición JOIN ON ***/


/**************************************************************
INNER JOIN DE TRES TABLAS
Información de aplicación: ID, nombre, GPA, nombre del colegio, inscripción
**************************************************************/

/*** Reescribir usando tres JOIN /
/ Funciona en SQLite y MySQL pero no en Postgres ***/

/*** Reescribir usando JOIN binario ***/


/**************************************************************
JOIN NATURAL
Nombres de estudiantes y sus especialidades a las que han aplicado
**************************************************************/


/*** Reescribir usando JOIN NATURAL ***/


/*** Al igual que el álgebra relacional, elimina columnas duplicadas ***/



/*** Se obtendría un error de ambigüedad con el producto cruzado ***/


/**************************************************************
JOIN NATURAL CON CONDICIONES ADICIONALES
Nombres y GPAs de estudiantes con sizeHS < 1000 aplicando a
CS en Stanford
**************************************************************/


/*** Reescribir usando JOIN NATURAL ***/


/*** La cláusula USING se considera más segura ***/


/**************************************************************
AUTOJOIN
Pares de estudiantes con el mismo GPA
**************************************************************/


/*** Reescribir usando JOIN y USING (no permitido) ***/


/*** Sin cláusula ON ***/

/**************************************************************
AUTOJOIN NATURAL
**************************************************************/

/*** Verificar la equivalencia con Student ***/


/**************************************************************
LEFT OUTER JOIN
Información de solicitud de estudiantes: nombre, ID, nombre universidad, especialidad
**************************************************************/


/*** Incluir estudiantes que no han solicitado a ninguna universidad ***/

/*** Abreviatura es LEFT JOIN ***/



/*** Usando NATURAL OUTER JOIN ***/


/*** Se puede simular sin ningún operador JOIN ***/


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


/**************************************************************
FULL OUTER JOIN
Información de solicitud de estudiantes
**************************************************************/

/*** Incluir estudiantes que no han solicitado a ninguna universidad /
/ y solicitudes sin estudiantes coincidentes ***/



/*** Se puede simular con LEFT y RIGHT OUTER JOIN /
/ Nota: UNION elimina duplicados ***/


