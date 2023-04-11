# 1-Key Concepts

Conceptos fundamentales:
- Base de datos: Conjunto de relaciones (o tablas) con nombre
- Columnas: Conjunto de atributos dentro de cada relación
- Filas (o tuplas): Contienen un valor por cada atributo
- Tipo: Tipo de objeto almacenado en cada columna (int, float, strings, ...)
- Schema: Estructura de las relaciones de la base de datos. Incluye los nombres, tipos y atributos de las relaciones
- Instancias: Puntos de datos en un momento concreto en el tiempo
- NULL: Valor especial para "desconocido" o "indefinido"
- Key: Atributo o conjunto de atributos para el que cada valor de la columna tiene que ser ÚNICO

Creación de tablas
```SQL
CREATE TABLE Student(ID, name, GPA, photo)
```

Podemos incluir los tipos
```SQL
CREATE TABLE College(name string, state char(2), enrollment integer)
```
