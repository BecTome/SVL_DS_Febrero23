/* Soluciones Ejercicios Movies*/

/* 1. Encuentra los títulos de todas las películas dirigidas por Steven Spielberg.*/

SELECT title
FROM movie
WHERE director = "Steven Spielberg";

/* 2. Encuentra todos los años en que hay una película que recibió una calificación 
     de 4 o 5, y ordénalos en orden creciente.*/

SELECT distinct year
FROM rating R
INNER JOIN movie M
ON R.mID = M.mID
WHERE stars in (4, 5)
ORDER BY year;

/* 3. Encuentra los títulos de todas las películas que no tienen calificaciones */

SELECT title
FROM movie M
WHERE mID not in (SELECT mID FROM rating);

/* 4. Algunos críticos no proporcionaron una fecha con su calificación. Encuentra 
      los nombres de todos los críticos que tienen calificaciones con un valor NULL para la fecha */

SELECT distinct name
FROM reviewer RV
LEFT JOIN rating RT
ON RV.rID = RT.rID
where ratingDate is NULL;

/* 5. Escribe una consulta para devolver los datos de calificación en un formato más legible: 
      nombre del crítico, título de la película, estrellas y fecha de la calificación. Además, 
      ordena los datos, primero por nombre del crítico, luego por título de la película y por 
      último por número de estrellas */

SELECT RV.name, 
		M.title, 
		RT.stars, 
        RT.ratingDate
FROM reviewer RV
LEFT JOIN rating RT
ON RV.rID = RT.rID
LEFT JOIN movie M
ON RT.mID = M.mID
order by RV.name, M.title, RT.stars;

/* 6. Para todos los casos en que el mismo crítico calificó la misma película dos veces y le dio
		una calificación más alta la segunda vez, devuelva el nombre del crítico y el título de la película */

SELECT EARLIEST.rID, EARLIEST.mID, earlier_stars ,later_stars-- , n_reviews
FROM (SELECT rID, mID, stars as earlier_stars, ratingDate FROM rating GROUP BY 1, 2 HAVING ratingDate = MIN(ratingDate)) EARLIEST
LEFT JOIN (SELECT rID, mID, stars as later_stars, ratingDate FROM rating GROUP BY 1, 2 HAVING ratingDate = MAX(ratingDate)) LATEST
ON EARLIEST.rID = LATEST.rID AND EARLIEST.mID = LATEST.mID
-- LEFT JOIN (SELECT rID, mID, COUNT(*) as n_reviews FROM rating GROUP BY rID, mID) NR
-- ON NR.rID = LATEST.rID AND NR.mID = LATEST.mID
;

SELECT R.name, M.title, A.n_reviews, A.maxdate, B.mindate, C.stars AS earlier_stars, D.stars AS later_stars
FROM (SELECT rID, mID, min(ratingDate) as maxdate, COUNT(*) AS n_reviews FROM rating GROUP BY 1, 2) A
LEFT JOIN (SELECT rID, mID, max(ratingDate) as mindate FROM rating GROUP BY 1, 2) B
ON A.rID = B.rID AND A.mID = B.mID
INNER JOIN rating C
ON A.rID = C.rID AND A.mID = C.mID AND A.maxdate = C.ratingDate
INNER JOIN rating D
ON A.rID = D.rID AND A.mID = D.mID AND B.mindate = D.ratingDate
LEFT JOIN movie M
ON A.mID = M.mID
LEFT JOIN reviewer R
ON A.rID = R.rID
WHERE A.n_reviews = 2 AND C.stars < D.stars;

/* 7. Para cada película que tenga al menos una calificación, 
      busca el mayor número de estrellas que haya recibido. Devuelve el 
      título de la película y el número de estrellas. Ordenar por título de la película. */
      
/* 8. Para cada película, devuelve el título y la "rating spread", es decir, 
		la diferencia entre las puntuaciones más altas y más bajas dadas a esa película. 
        Ordenar por la diferencia de valoración de mayor a menor y, a continuación, por el título de la película. */
        
/* 9. Halla la diferencia entre la valoración media de las películas estrenadas antes de 1980 
      y la valoración media de las películas estrenadas después de 1980. (Asegúrate de calcular 
      la valoración media de cada película y, a continuación, la media de esas medias para las 
      películas anteriores y posteriores a 1980. No te limites a calcular la calificación media 
      global antes y después de 1980). */
