
-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ. --

select f.title, f.rating 
from film f 
where f.rating = 'R' ;


-- 3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40. --

select a.actor_id, a.first_name -- como solo pone nombre, he decidido no incluir el apellido --
from actor a 
where a.actor_id between 30 and 40 ;


-- 4. Obtén las películas cuyo idioma coincide con el idioma original. --

select f.title 
from film f 
where f.language_id = f.original_language_id ;


-- 5. Ordena las películas por duración de forma ascendente. --

select f.title , f.length
from film f 
order by f.length ;  -- si no ponemos nada por defecto va a ordenarlo de manera ascendente --


-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido. --

select concat( a.first_name , ' ', a.last_name ) as nombre_completo_actor
from actor a 
where a.last_name ilike 'Allen'; -- usamos ilike para que ignore si son mayúsculas o minúsculas --


-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento. --

select 
	f.rating , 
	count (f.film_id ) as cantidad_total_peliculas
from film f 
group by f.rating ;


-- 8. Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film. --

select f.title , f.rating , f.length  -- incluyo las columnas rating y length para que se pueda ver que filtra correctamente --
from film f 
where rating = 'PG-13' 
	or f.length > 180;


-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas. --

select round (variance(f.replacement_cost ), 2) as variabilidad_reemplazo 
from film f ;


-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD. --

select 
	MIN(f.length ) as pelicula_menor_duracion, 
	MAX(f.length ) as pelicula_mayor_duracion
from film f ;


-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día. --

select r.rental_id , r.rental_date , p.amount 
from rental r 
join payment p 
	on r.rental_id = p.rental_id 
order by rental_date desc   
limit 1 offset 2;
-- al solo ordenarlo por día y teniendo en cuenta que hay varios rental_date con el mismo valor, SQL lo ordena de una manera pero al limitarlo lo hace de otra, 
-- es por eso que si no lo limitamos el resultado debería ser el rental_id 15542, pero en cambio nos devuelve el rental_id 11676 --


-- Una solución sería ordenarlo también por otro criterio como puede ser el rental_id, quedando de la siguiente manera --

select r.rental_id , r.rental_date , p.amount 
from rental r 
join payment p 
	on r.rental_id = p.rental_id 
order by rental_date desc, r.rental_id desc
limit 1 offset 2;


-- 12. Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación. --

select f.title , f.rating 
from film f 
where f.rating not in ('NC-17', 'G');


-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración. --

select 
	f.rating , 
	round ( AVG(f.length ), 2) as duracion_promedio
from film f 
group by f.rating ;


-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos. --

select f.title , f.length
from film f 
where f.length > 180;


-- 15. ¿Cuánto dinero ha generado en total la empresa? --

select SUM(p.amount ) as total_ventas
from payment p;


-- 16. Muestra los 10 clientes con mayor valor de id. --

select c.customer_id as top10_clientes_mayor_id
from customer c 
order by c.customer_id desc 
limit 10;


-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ. --

select a.first_name , a.last_name , f.title 
from actor a 
	inner join film_actor fa 
		on a.actor_id = fa.actor_id
	inner join film f 
		on fa.film_id = f.film_id
where f.title ilike ('Egg Igby');


-- 18. Selecciona todos los nombres de las películas únicos. --

select distinct f.title 
from film f ;


-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.

select 
	f.title , 
	c."name" as categoria, 
	f.length 
from film f   -- vamos a unir la tabla film con las tablas film_category y category para poder obtener el nombre de la categoría --
	inner join film_category fc 
		on f.film_id = fc.film_id
	inner join category c 
		on fc.category_id = c.category_id
where c."name" ilike ('Comedy') and f.length > 180 ; 


-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.

select 
	c."name" as categoria , 
	round (AVG(f.length ), 2) as duracion_promedio 
from film f   -- vamos a unir la tabla film con las tablas film_category y category para poder agrupar y obtener el nombre de la categoría --
	inner join film_category fc 
		on f.film_id = fc.film_id
	inner join category c 
		on fc.category_id = c.category_id
group by c."name" 
having AVG(f.length ) > 110;


-- 21. ¿Cuál es la media de duración del alquiler de las películas? --

select  AVG (r.return_date - r.rental_date) as promedio_duracion_alquiler
from rental r ; -- con esta consulta salen 4 días, 24 horas (que debería transformar en una hora) y 36 minutos... --

	-- para corregirlo aplicaremos el siguiente ajuste --
	select justify_hours (AVG(r.return_date - r.rental_date)) as promedio_duracion_alquiler
	from rental r; 
	

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices. -- 

select 
	a.actor_id , 
	concat(a.first_name ,' ' , a.last_name ) as nombre_completo_actores  -- valoré incluir distinct y me salía un resultado menos, pero como el enunciado dice de todos los actores y actrices, lo he quitado puesto que aunque coincidan en nombre y apellidos, el actor_id es diferente --
from actor a ;

	-- Con esta consulta podemos saber si hay algún actor o actriz con el mismo nombre y apellido -- 
		select 
			a.first_name, 
			a.last_name, 
			count(*) 
		from actor a
		group by a.first_name, a.last_name
		having count(*) > 1;
	
	-- Y con esta podemos comprobar que el ID es diferente --
 
		select a.actor_id , a.first_name, a.last_name
		from actor a
		where concat(a.first_name , a.last_name ) = 'SUSANDAVIS';

		
-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.--

select 
	date_trunc ('day', r.rental_date ) as dia, 
	count (r.rental_id ) as cantidad_alquileres
from rental r 
group by dia 
order by cantidad_alquileres desc ;


-- 24. Encuentra las películas con una duración superior al promedio.--

select f.title , f.length 
from film f 
where f.length > (
	select AVG(f2.length )  -- generamos una subconsulta para calcular el promedio --
	from film f2
) ;


-- 25. Averigua el número de alquileres registrados por mes. --

select 
	date_trunc ('month', r.rental_date ) as mes,
	count(*) as total_alquileres
from rental r 
group by mes  
order by mes ;


-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

select 
	round (AVG(p.amount ), 2) as promedio_pagado,
	round (stddev(p.amount ), 2) as desviacion_estandar, 
	round (variance(p.amount ), 2) as varianza 
from payment p ;


-- 27. ¿Qué películas se alquilan por encima del precio medio?
	
select (f.title) , p.amount 
from payment p 
inner join rental r 
	on p.rental_id = r.rental_id
inner join inventory i 
	on r.inventory_id = i.inventory_id
inner join film f 
	on i.film_id = f.film_id
where p.amount > (
	select AVG(p2.amount )
	from payment p2 
);
	

  	-- Con la siguiente consulta he podido comprobar que hay títulos repetidos y que dentro del mismo título tenemos diferentes precios --

	select 
		f.title, 
		count(*) as veces
	from payment p
	inner join rental r
		on p.rental_id = r.rental_id
	inner join inventory i
		on r.inventory_id = i.inventory_id
	inner join film f
		on i.film_id = f.film_id
	where p.amount > (
		select AVG(p2.amount)
		from payment p2
	)
	group by f.title
	having count(*) > 1
	order by veces desc;

	-- Si incluimos DISTINCT en el select de la consulta principal, --
	-- podemos obtener los títulos únicos que están por encima del precio medio --

	select distinct (f.title) , p.amount 
	from payment p 
	inner join rental r 
		on p.rental_id = r.rental_id
	inner join inventory i 
		on r.inventory_id = i.inventory_id
	inner join film f 
		on i.film_id = f.film_id
	where p.amount > (
		select AVG(p2.amount )
		from payment p2 
	);
	
	
-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.--

select 
	fa.actor_id , 
	count(f.title ) as cantidad_peliculas
from film f 
inner join film_actor fa 
	on f.film_id = fa.film_id
group by fa.actor_id 
having count(f.title ) > 40;


-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible. --
	
select 
	f.title , 
	count(i.inventory_id ) as cantidad_disponible
from film f
left join inventory i 
	on f.film_id = i.film_id
group by f.title ; --como dice todas las películas, no incluimos un having count(i.inventory_id ) > 0 --


-- 30. Obtener los actores y el número de películas en las que ha actuado. --

select 
	a.actor_id , a.first_name , a.last_name , 
	count(fa.film_id ) as cantidad_peliculas 
from actor a 
left join film_actor fa 
	on a.actor_id = fa.actor_id
left join film f 
	on fa.film_id = f.film_id
group by a.actor_id 
order by a.actor_id ;


-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados. --

select f.title , a.first_name , a.last_name
from film f 
left join film_actor fa            -- con la frase del enunciado "incluso si algunas películas no tienen actores asociados" ya sabemos que debe ser left join --
	on f.film_id = fa.film_id
left join actor a 
	on fa.actor_id = a.actor_id ;


-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película. --

select a.first_name , a.last_name , f.title 
from actor a 
left join film_actor fa   -- elegimos left join porque incluirá también los actores que no hayan actuado en ninguna película --
	on a.actor_id = fa.actor_id
left join film f 
	on fa.film_id = f.film_id ;


-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler. --

select f.title , r.rental_id
from film f 
full join inventory i     -- todas las películas y todos los registros de alquiler sugieren un full join --
	on f.film_id = i.film_id
full join rental r 
	on i.inventory_id = r.inventory_id 
order by f.title ;


-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros. --

select 
	c.customer_id , c.first_name , c.last_name , 
	SUM(p.amount ) as total_gastado
from customer c 
inner join rental r 
	on c.customer_id = r.customer_id
inner join payment p 
	on r.rental_id = p.rental_id
group by c.customer_id
order by total_gastado desc 
limit 5;


-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'. --

select a.first_name , a.last_name 
from actor a 
where a.first_name ilike ('Johnny');


-- 36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.--

select 
	a.first_name as "Nombre" ,   -- en este caso, los alias irán entre comillas para que se respeten las mayúsculas y minúsculas -- 
	a.last_name as "Apellido"
from actor a ;


-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor. --

select 
	MIN(a.actor_id ) as minimo_actor_id , 
	MAX(a.actor_id ) as maximo_actor_id
from actor a ;


-- 38. Cuenta cuántos actores hay en la tabla “actorˮ. -- 

select count(a.actor_id ) as cantidad_actores
from actor a ;


-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente. --

select a.last_name as apellido, a.first_name as nombre --he decidido poner primero el apellido porque creo que al ordenarlo por apellido es más legible de esta manera -- 
from actor a 
order by a.last_name ;


-- 40. Selecciona las primeras 5 películas de la tabla “filmˮ. --

select f.title 
from film f 
order by f.film_id  -- esto garantiza que SQL siempre muestre las mismas 5 primeras películas --
limit 5;


-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido? --
	-- como hay más de un nombre que se repite el máximo de veces, he descartado el límite porque no sería correcto --

with recuento as (   -- CTE que muestra la cantidad de veces que se repite cada nombre -- 
	select a.first_name , count (a.first_name ) as veces_repetido
	from actor a 
	group by a.first_name 
)
select first_name , veces_repetido   
from recuento
where veces_repetido = (        -- condición de la consulta principal en la que las veces que se repite debe ser igual al máximo de veces que se repite un nombre --
	select MAX (recuento.veces_repetido )   -- Subconsulta que nos da el número máximo de veces que se repite un nombre --
	from recuento 
	);   -- con esto tenemos todos los nombres que se repiten el máximo de veces --
	

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron. --

select 
	r.rental_id , 
	concat(c.first_name , ' ', c.last_name ) as nombre_completo_cliente
from rental r 
left join customer c   -- un inner join valdría también si diésemos por hecho que la base de datos no tiene errores y que todos los rental_id van a tener un nombre de cliente asociado --
	on r.customer_id = c.customer_id ;


-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres. --

select 
	concat(c.first_name , ' ', c.last_name  ) as nombre_completo_cliente , 
	r.rental_id 
from customer c 
left join rental r 
	on c.customer_id = r.customer_id ;


-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación. --

select *
from film f 
cross join category c ;
	
	-- No aporta ningún valor porque ignora por completo la tabla intermedia film_category, la cual relaciona film con category --
	-- La consulta mezcla combinaciones válidas junto con miles de combinaciones falsas y sin sentido --


-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'. --

select 
	f.title , c."name" as category, 
	concat(a.first_name  ,' ',  a.last_name) as nombre_actor
from film f 
inner join film_category fc 
	on f.film_id = fc.film_id
inner join category c 
	on fc.category_id = c.category_id
inner join film_actor fa 
	on f.film_id = fa.film_id 
inner join actor a 
	on a.actor_id = fa.actor_id 
where c."name" ilike 'Action';


-- 46. Encuentra todos los actores que no han participado en películas. --

select 
	fa.film_id , 
	concat(a.first_name  ,' ',  a.last_name) as actores_sin_participacion_en_peliculas
from actor a 
left join film_actor fa 
	on a.actor_id = fa.actor_id 
where fa.film_id is NULL;   
		-- no obtenemos ningún resultado puesto que no existen actores que no hayan participado en ninguna película -- 


-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado. --

select 
	a.actor_id ,  -- importante incluir esto para evitar que dos actores que se llamen igual se agrupen en una sola línea como si fuesen el mismo --
	concat(a.first_name ,' ', a.last_name ) as nombre_completo_actor, 
	count(fa.film_id ) as cantidad_peliculas 
from actor a 
left join film_actor fa  
	on a.actor_id = fa.actor_id
group by a.actor_id  
order by a.actor_id ;


-- 48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado. --

create view actor_num_peliculas as
select 
	a.actor_id ,
	concat(a.first_name , ' ', a.last_name ) as nombre_completo_actor,
	count(fa.film_id ) as cantidad_peliculas 
from actor a 
left join film_actor fa  -- elegimos LEFT en vez de INNER JOIN para que no ignore los actores que no hayan participado en ninguna película. Aunque en esta BBDD no existe ninguno actualmente, puede que en un futuro sí --
	on a.actor_id = fa.actor_id
group by a.actor_id 
order by a.actor_id ;


-- 49. Calcula el número total de alquileres realizados por cada cliente. --

select c.customer_id , count(r.rental_id ) as total_alquileres
from customer c 
left join rental r   -- como el enunciado no indica que mostremos los clientes con alquileres y su total, lo correcto es un left join --
	on c.customer_id = r.customer_id
group by c.customer_id
order by c.customer_id  ;


-- 50. Calcula la duración total de las películas en la categoría 'Action'. --

select SUM(f.length ) as duracion_total_peliculas_action
from film f 
inner join film_category fc   -- no elegimos left join porque el where ya va a filtrar por las que tengan categoría 'Action' en este caso, con lo que los null no nos interesarían en el caso de que los hubiese -- 
	on f.film_id = fc.film_id
inner join category c 
	on fc.category_id = c.category_id
where c."name" ilike 'Action';


-- 51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente. --

create temporary table cliente_rentas_temporal as
select c.customer_id , count(r.rental_id ) as total_alquileres
from customer c 
left join rental r     -- con left join no perderemos clientes que no hayan alquilado aún ninguna película --
	on c.customer_id = r.customer_id
group by c.customer_id
order by c.customer_id ;


-- 52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces. --

create temporary table peliculas_alquiladas as
select 
	f.title, 
	count(r.rental_id ) as veces_alquilada
from film f 
inner join inventory i 
	on f.film_id = i.film_id
inner join rental r 
	on i.inventory_id = r.inventory_id 
group by f.title  
having count(r.rental_id ) >= 10 ;  -- podríamos poner >9 y daría lo mismo porque en este caso solo existen números enteros, pero como buena práctica creo que se debe poner literalmente como indica el enunciado --


-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

select f.title  -- para comprobar que fuese correcto, incluí tanto el concat para sacar el nombre como el rental date, pero ciñéndome al enunciado, he decidido quitarlo de la consulta --
from customer c 
inner join rental r 
	on c.customer_id = r.customer_id
inner join inventory i 
	on r.inventory_id = i.inventory_id
inner join film f 
	on i.film_id = f.film_id
where 
	concat(c.first_name , ' ', c.last_name ) ilike 'Tammy Sanders' and 
	r.return_date is null
order by f.title ;


-- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido. --

select distinct a.actor_id , a.first_name , a.last_name -- como en anteriores ejercicios, incluimos actor_id para evitar que actores con el mismo nombre y apellido se puedan fusionar --
from film f 
inner join film_category fc 
	on f.film_id = fc.film_id
inner join category c 
	on fc.category_id = c.category_id
inner join film_actor fa 
	on f.film_id = fa.film_id 
inner join actor a 
	on a.actor_id = fa.actor_id 
where c."name" ilike 'Sci-Fi'
order by a.last_name ;


-- 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido. --

select distinct
	a.first_name as nombre ,
	a.last_name as apellido 
from actor a 
inner join film_actor fa 
	on a.actor_id = fa.actor_id
inner join film f 
	on fa.film_id = f.film_id
inner join inventory i 
	on f.film_id = i.film_id 
inner join rental r 
	on i.inventory_id = r.inventory_id
where r.rental_date > (    -- subconsulta donde sacamos la fecha de la primera vez que se alquiló ‘Spartacus Cheaperʼ --
	select r2.rental_date 
	from rental r2 
	inner join inventory i2 
		on r2.inventory_id = i2.inventory_id
	inner join film f2 
		on i2.film_id = f2.film_id
	where f2.title ilike 'Spartacus Cheaper'
	order by r2.rental_date   -- ordenamos por rental_date de manera ascendente para que la primera fila sea la fecha más antigua y así poder usar el límite 1 para extraer la primera fecha de alquiler --
	limit 1
)
order by a.last_name ;


-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ. --

select distinct
	a.first_name as nombre,
	a.last_name as apellido
from actor a 
inner join film_actor fa 
	on a.actor_id = fa.actor_id 
where a.actor_id not in (   -- subconsulta para identificar todos los actores que sí participaron en alguna película de 'Music' y "not in" en el where de la consulta principal para excluirlos --
	select fa2.actor_id 
	from film_actor fa2 
	inner join film f 
		on fa2.film_id = f.film_id
	inner join film_category fc 
		on f.film_id = fc.film_id
	inner join category c 
		on fc.category_id = c.category_id
	where c."name" ilike 'Music'
	);


-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días. --

with duracion_alquiler as (  -- usamos una CTE para calcular los días de alquiler de cada película --
	select title, (r.return_date - r.rental_date ) as dias_alquiler
	from film f 
	inner join inventory i 
		on f.film_id = i.film_id
	inner join rental r 
		on i.inventory_id = r.inventory_id
	)
select title
from duracion_alquiler   -- utilizamos la CTE que hemos creado anteriormente para que la consulta nos devuelva la condición de que se hayan alquilado por más de 8 días --
where dias_alquiler > '8 days' ; -- debemos poner '8 days' ya que lo que devuelve en dias_alquiler es un intervalo con formato '8 days 00:01:00' y no un número como tal --


-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ. --

select f.title
from film f 
inner join film_category fc 
	on f.film_id = fc.film_id
where fc.category_id = (  -- el motivo de hacer una subconsulta es que el enunciado especifica "de la misma categoría que 'Animation'", en vez de decir "con categoría 'Animation'", lo que sugiere que primero debemos averiguar el id de la categoría Animación por si alguna otra categoría tuviera el mismo --
	select c.category_id 
	from category c 
	where c."name" ilike 'Animation'
	);
	

-- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película. --

select f.title 
from film f 
where f.length = (   -- en esta subconsulta calcularemos la duración de la película con título 'Dancing Fever' --
	select f2.length 
	from film f2
	where f2.title ilike 'Dancing Fever'
	)
order by f.title ;  
		-- no excluyo 'Dancing Fever' del resultado porque el enunciado no lo pide explícitamente y nos ayuda además a comprobar de un vistazo que la consulta es correcta --


-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido. --

with peliculas_alquiladas_cliente as (    -- creamos una CTE con la cantidad de películas distintas alquiladas por cliente --
	select 
		c2.customer_id , 
		c2.first_name,
		c2.last_name,
		count(distinct i2.film_id ) as peliculas_distintas_alquiladas
	from customer c2
	inner join rental r2
		on c2.customer_id = r2.customer_id 
	inner join inventory i2 
		on r2.inventory_id = i2.inventory_id 
	group by c2.customer_id 
)
select 
	first_name as nombre, 
	last_name as apellido 
from peliculas_alquiladas_cliente    -- usamos la CTE que hemos creado para extraer el nombre de los clientes que alquilaron al menos 7 películas distintas --
where peliculas_distintas_alquiladas >= 7 
order by apellido ;


-- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres. --

select 
	c."name" as categoria, 
	count(r.rental_id ) as total_peliculas_alquiladas
from category c 
inner join film_category fc 
	on c.category_id = fc.category_id
inner join film f 
	on fc.film_id = f.film_id
inner join inventory i 
	on f.film_id = i.film_id
inner join rental r 
	on i.inventory_id = r.inventory_id
group by c.category_id 
order by total_peliculas_alquiladas desc ;   -- el enunciado no pide explícitamente que se ordenen los resultados, pero creo que este order by tiene valor porque de un vistazo podemos ver cuáles son las categorías que más veces se han alquilado --


-- 62. Encuentra el número de películas por categoría estrenadas en 2006. --

select 
	c."name" as categoria,
	count(distinct f.film_id ) as peliculas_estrenadas_2006  -- incluyo distinct para el hipotético caso de que una película tuviera varias categorías --
from film f 
inner join film_category fc 
	on f.film_id = fc.film_id
inner join category c 
	on fc.category_id = c.category_id
where f.release_year = 2006
group by c.category_id 
order by c."name" ;  -- incluido para mayor legibilidad*


-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos. -- 

select *
from staff sf 
cross join store st ;  


-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas. --

select 
	c.customer_id ,
	c.first_name as nombre,
	c.last_name as apellido,
	count(r.rental_id ) as total_peliculas_alquiladas
from customer c 
left  join rental r    -- usamos left join para que no ignore los clienes con cero películas alquiladas, si los hubiese -- 
	on c.customer_id = r.customer_id
group by c.customer_id 
order by c.customer_id ;

