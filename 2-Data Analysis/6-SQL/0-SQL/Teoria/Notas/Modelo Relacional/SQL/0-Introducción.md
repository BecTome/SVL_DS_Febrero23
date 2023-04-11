# 0-Introducción

Características:
- Se pronuncia "sequel"
- Soportado por la mayoria de los DBMS comerciales
- Es un estándar que ha ido volviéndose muy completo con los años hasta llegar a haber páginas de este estándar
- Es un lenguaje declarativo

Está dividido en:
- Data Definition Language: `Create Table...` , `Drop Table...`, ...
- Data Manipulation Language: `SELECT`, `INSERT`, `DELETE`, `UPDATE`, ...
- Otros: indexes, constraints, views, triggers, ....

```SQL
SELECT A_1, A_2, ..., A_n /*What to return*/
FROM R_1, R_2, ..., R_m   /*Relations*/
WHERE condition           /*Combine Filter*/
```

Dado que el conjunto de relaciones es un conjunto matemáticamente cerrado, el resultado de las operaciones de álgebra relacional continúa siendo una relación (aunque no tenga nombre) sobre la cual se puede trabajar.
