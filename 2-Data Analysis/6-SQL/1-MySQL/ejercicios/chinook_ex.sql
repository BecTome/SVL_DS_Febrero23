/* PRIMERA PARTE */

/*1.	Muestra los clientes de brasil* */
SELECT *
FROM CUSTOMER
WHERE country = "Brazil";

-- 2.	Muestrame los empleados que son agentes de ventas*

SELECT *
FROM employee
WHERE title = "Sales Support Agent";

-- 3.	Muestrame las canciones de ‘AC/DC’
SELECT *
FROM track
WHERE Composer LIKE "%AC/DC%";

-- 4.	Muestra los clientes que no sean de USA: Nombre completo, ID, Pais*
SELECT CustomerId,
		CONCAT(FirstName, " ", LastName) AS FullName,
		Country
FROM customer
WHERE country <> "USA";

-- 5.	Muestrame los empleados que son agentes de ventas: Nombre completo, 
--      Dirección (Ciudad, Estado, Pais) y email

SELECT CONCAT(FirstName, " ", LastName) AS FullName,
		CONCAT(City, " / ", State, " / ", Country) AS Location,
        Email
FROM employee
WHERE title = "Sales Support Agent";


-- 6.	Muestra una lista con los paises que aparecen a los que se ha facturado, 
--      la lista no debe contener paises repetidos*

SELECT distinct BillingCountry
FROM invoice
order by 1;

-- 7.	Muesta una lista con los estados de USA de donde son los clientes, la lista
--      no debe contener estados repetidos
SELECT DISTINCT State
FROM customer
WHERE Country = "USA"
ORDER BY 1;

-- 8.	Cuantos articulos tiene la factura 37*
SELECT Count(distinct invoicelineId)
FROM invoiceline
WHERE invoiceId = 37;

-- 9.	Cuantas canciones tiene ‘AC/DC’
SELECT *
FROM track T
INNER JOIN album A
USING(albumID)
WHERE A.artistId = (SELECT DISTINCT ArtistId FROM artist WHERE Name = "AC/DC");

-- 10.	Cuantos articulos tiene cada factura*
SELECT invoiceId,
		count(distinct invoicelineId) AS n_articulos
FROM invoiceline
GROUP BY 1
HAVING n_articulos = (SELECT MAX(n_articulos) FROM (SELECT invoiceId,
															count(distinct invoicelineId) AS n_articulos
															FROM invoiceline
															GROUP BY 1
                                                            ) x);


-- 11.	Muestrame cuantos facturas hay de cada pais

SELECT BillingCountry, COUNT(DISTINCT InvoiceId) AS n_invoice
FROM invoice
GROUP BY BillingCountry
ORDER BY 2 DESC;


-- 12.	Muestrame cuantos items tiene cada factura
SELECT InvoiceId, COUNT(DISTINCT InvoicelineId) AS n_items
FROM invoiceline
GROUP BY InvoiceId;


-- 13.	Cuantas facturas ha habido en 2009 y 2011*
SELECT *
FROM invoice
WHERE YEAR(InvoiceDate) IN (2009, 2011);

SELECT *
FROM invoice
WHERE YEAR(InvoiceDate) = 2009 OR YEAR(InvoiceDate) = 2011;

-- 14.	Cuantas facturas ha habido entre 2009 y 2011*
SELECT *
FROM invoice
WHERE YEAR(InvoiceDate) BETWEEN 2009 AND 2011;

-- 15.	Cuantos clientes hay de españa y de Brazil
SELECT *
FROM customer
WHERE country IN ("Spain", "Brazil");

-- 16.	Muestrame las canciones que su titulo empieza por ‘You’
SELECT *
FROM track
WHERE Name LIKE "You %";

/* SEGUNDA PARTE */

-- 1.	Facturas de Clientes de Brasil, Nombre del cliente, Id de factura, 
--      fecha de la factura y el pais de la factura*

/*SELECT *
FROM invoice
WHERE customerId in (SELECT DISTINCT CustomerId
						FROM customer
						where country = "Brazil");*/

SELECT CONCAT(C.FirstName, " ", C.LastName) AS FullName,
		InvoiceId,
		InvoiceDate,
        BillingCountry
FROM invoice I
INNER JOIN customer C
USING(customerId)
WHERE C.country = "Brazil";



-- 2.	Facturas de Clientes de Brasil*

SELECT *
FROM invoice I
INNER JOIN customer C
USING(customerId)
WHERE C.country = "Brazil";

-- 3.	Muestra cada factura asociada a cada agente de ventas con su nombre completo*
SELECT I.*,
		Concat(E.FirstName, " ", E.LastName) AS AgentName
FROM invoice I
LEFT JOIN customer C
using(customerId)
LEFT JOIN employee E
ON C.supportrepid = E.employeeid
ORDER BY customerid;

-- 4.	Muestra el nombre del cliente, el pais, el nombre del agente y el total
SELECT CONCAT(C.FirstName, " ", C.LastName) AS ClientName,
		C.country,
		Concat(E.FirstName, " ", E.LastName) AS AgentName,
        SUM(I.Total) AS TotalVentas
FROM invoice I
LEFT JOIN customer C
using(customerId)
LEFT JOIN employee E
ON C.supportrepid = E.employeeid
GROUP BY 1, 2, 3;

-- 5.	Muestra cada articulo de la factura con el nombre de la cancion

SELECT I.invoiceId,
		IL.invoicelineId,
        T.Name
FROM invoice I
INNER JOIN invoiceline IL
USING(invoiceID)
LEFT JOIN track T
USING(trackId)
ORDER BY 1, 2;

-- 6.	Muestra todas las conciones con su nombre, formato, album y genero
SELECT T.Name AS TrackName,
		A.Title AS AlbumTitle,
        MT.Name AS Format,
        G.Name AS Genre
FROM Track T
LEFT JOIN Album A
using(AlbumID)
LEFT JOIN mediatype MT
using(mediatypeId)
LEFT JOIN genre G
USING(genreId)
;


-- 7.	Muestra cuantas canciones hay en cada playlist y el nombre de cada playlist
SELECT P.Name AS PlaylistName,
		Count(TrackId) AS n_songs
FROM playlist P
LEFT JOIN playlisttrack PT
USING(playlistId)
GROUP BY 1;


-- 8.	Muestra cuánto ha vendido cada empleado
SELECT CONCAT(E.FirstName, " ", E.LastName) AS EmployeeName,
		CASE
         WHEN SUM(I.Total) IS NULL THEN 0
         ELSE SUM(I.Total)
         END AS TotalSales
FROM Employee E
LEFT JOIN Customer C
ON E.EmployeeId = C.SupportRepId
LEFT JOIN Invoice I
USING(customerId)
GROUP BY 1;

-- 9.	Quien ha sido el agente de ventas que más ha vendido en 2009?
SELECT CONCAT(E.FirstName, " ", E.LastName) AS EmployeeName,
		CASE
         WHEN SUM(I.Total) IS NULL THEN 0
         ELSE SUM(I.Total)
         END AS TotalSales
FROM Employee E
LEFT JOIN Customer C
ON E.EmployeeId = C.SupportRepId
LEFT JOIN Invoice I
USING(customerId)
WHERE E.Title = "Sales Support Agent" AND YEAR(I.invoiceDate) = 2009
GROUP BY 1
ORDER BY TotalSales DESC
LIMIT 1;

-- 10.	Quien es son los 3 grupos que más han vendido?

SELECT AR.Name as Artist,
		SUM(IL.Quantity * IL.UnitPrice) AS TotalSale
FROM artist AR
LEFT JOIN album AL
USING(artistID)
LEFT JOIN Track T
using(albumID)
LEFT JOIN invoiceline IL
USING(trackId)
LEFT JOIN invoice I
USING(invoiceID)
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 3;



