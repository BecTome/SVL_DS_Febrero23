# 1-DBMS Properties

- Datos Masivos
- Persistente: Los datos continuan existiendo después de que se ejecute la aplicación (opuesto: variables)
- Seguros: Puede haber fallos de hardware, software, ... Las bases de datos tienen mecanismos para asegurarse de que los datos permanecen consistentes independientemente de lo que pueda ocurrir
- Multi-usuario: Control de concurrencia. Permite acceder a varios usuarios a la vez pero garantiza que no se pierde la consistencia, por ejemplo, permitiendo que un usuario modifique la mitad de una fila y otro usuario la otra mitad. Para ello, los permisos no están a nivel de usuario sino de cada conjunto de datos. Similar a los permisos de archivos.
- Convenient: 
	-  Independencia física de los datos: Puede haber cambios en el almacenamiento de los datos pero que esto no sea percibido por ninguna de las aplicaciones conectadas
	- Lenguajes de consulta de alto nivel: Normalmente son lenguajes sencillos y compactos. Cumplen que son **declarativos**, i.e., en la query describes lo que quieres hacer pero no el algoritmo que se emplea por detrás para ello ya que el sistema buscará el algoritmo capaz de hacer esto de la manera más eficiente posible.
- Eficiente: Los sistemas de BBDD tienen que hacer cientos y miles de queries y updates al segundo. Esta es una de las características más importantes de los DBMS
- Confiable: Altos niveles de Disponibilidad