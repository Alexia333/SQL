-- 1. Crea el esquema de la BBDD.
-- El esquema se encuentra en un archivo distinto del repositorio

-- 2. Muestra los nombres de todas las películas con una clasificación por
-- edades de ‘R’.
select title
from film f 
where rating = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30
-- y 40.
select first_name, last_name
from actor a
where actor_id between 30 and 40;

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
select title
from film f 
where language_id = original_language_id;

-- 5. Ordena las películas por duración de forma ascendente.
select title, length
from film f 
order by length asc;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su
-- apellido.
select first_name, last_name
from actor a 
where last_name like '%Allen%';
-- No me quedaba muy claro si se refería a actores cuyo apellido sea 'Allen' o aquellos cuyo apellido contenga 'Allen',
-- así que me decanté por la segunda opción para variar un poco y emplear 'like'

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla
-- “film” y muestra la clasificación junto con el recuento.
select rating, count(*) as total_films
from film f 
group by rating
order by total_films desc;

-- 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
-- duración mayor a 3 horas en la tabla film.
select title
from film f 
where rating = 'PG-13' or length > 180;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
select stddev(replacement_cost) as deviation
from film f;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
select max(length) as max_duration, min(length) as min_duration
from film f;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select p.amount
from payment p 
join rental r on p.rental_id = r.rental_id
order by r.rental_date desc
offset 2
limit 1;

-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.
select title
from film f 
where rating not in ('NC-17', 'G');


-- 13. Encuentra el promedio de duración de las películas para cada
-- clasificación de la tabla film y muestra la clasificación junto con el
-- promedio de duración.
select rating, avg(length) as average_duration
from film f 
group by rating;

-- 14. Encuentra el título de todas las películas que tengan una duración mayor
-- a 180 minutos.
select title
from film f 
where length > 180;

-- 15. ¿Cuánto dinero ha generado en total la empresa?
select sum(amount) as total_revenue
from payment p;

-- 16. Muestra los 10 clientes con mayor valor de id.
select first_name, last_name, customer_id
from customer c 
order by customer_id desc
limit 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la
-- película con título ‘Egg Igby’.
select a.first_name, a.last_name
from actor a 
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
where f.title = 'Egg Igby';

-- 18. Selecciona todos los nombres de las películas únicos.
select distinct title
from film f;

-- 19. Encuentra el título de las películas que son comedias y tienen una
-- duración mayor a 180 minutos en la tabla “film”.
select f.title
from film f 
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id 
where c.name = 'Comedy' and f.length > 180;

-- 20. Encuentra las categorías de películas que tienen un promedio de
-- duración superior a 110 minutos y muestra el nombre de la categoría
-- junto con el promedio de duración.
select c.name, avg(f.length) as average_duration
from category c 
join film_category fc on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id
group by c.name
having avg(f.length) > 110;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?
select avg(rental_duration) as average_rental_duration
from film f; 

-- 22. Crea una columna con el nombre y apellidos de todos los actores y
-- actrices.
select concat(first_name, ' ', last_name) as full_name
from actor a;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de
-- forma descendente.
select date(rental_date) as rental_day, count(rental_id) as total_rentals
from rental r
group by rental_day
order by total_rentals desc;

-- 24. Encuentra las películas con una duración superior al promedio.
select title, length
from film f 
where length > (select avg(length) from film f);

-- 25. Averigua el número de alquileres registrados por mes.
select date_part('month', rental_date) as rental_month, count(rental_id) as total_rentals
from rental r 
group by rental_month
order by rental_month;
-- date_part se ha empleado para extraer únicamente el mes de cada fecha

-- 26. Encuentra el promedio, la desviación estándar y varianza del total
-- pagado.
select avg(amount) as average, stddev(amount) as deviation, variance(amount) as variance
from payment p;

-- 27. ¿Qué películas se alquilan por encima del precio medio?
select title, rental_rate
from film f 
where rental_rate > (select avg(rental_rate) from film f);

-- 28. Muestra el id de los actores que hayan participado en más de 40
-- películas.
select actor_id
from film_actor fa 
group by actor_id
having count(film_id) > 40;

-- 29. Obtener todas las películas y, si están disponibles en el inventario,
-- mostrar la cantidad disponible.
select f.film_id, f.title, count(i.inventory_id) as quantity
from film f 
left join inventory i on f.film_id = i.film_id
group by f.film_id
order by f.title;

-- 30. Obtener los actores y el número de películas en las que ha actuado.
select a.actor_id, a.first_name, a.last_name, count(fa.film_id) as total_films
from actor a 
left join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
order by total_films desc;

-- 31. Obtener todas las películas y mostrar los actores que han actuado en
-- ellas, incluso si algunas películas no tienen actores asociados.
select f.film_id, f.title, a.actor_id, a.first_name, a.last_name
from film f 
left join film_actor fa on f.film_id = fa.film_id
left join actor a on fa.actor_id = a.actor_id
order by f.title, a.last_name;

-- 32. Obtener todos los actores y mostrar las películas en las que han
-- actuado, incluso si algunos actores no han actuado en ninguna película.
select a.actor_id, a.first_name, a.last_name, f.film_id, f.title
from actor a 
left join film_actor fa on a.actor_id = fa.actor_id
left join film f on fa.film_id = f.film_id
order by a.last_name, f.title;

-- 33. Obtener todas las películas que tenemos y todos los registros de
-- alquiler.
select f.film_id, f.title, r.rental_date, r.return_date
from film f 
left join inventory i on f.film_id = i.film_id
left join rental r on i.inventory_id = r.inventory_id
order by f.title;

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select c.customer_id, c.first_name, c.last_name, sum(p.amount) as total_amount
from customer c 
join payment p on c.customer_id = p.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_amount desc
limit 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select actor_id, first_name, last_name
from actor a 
where first_name = 'Johnny';

-- 36. Renombra la columna “first_name” como Nombre y “last_name” como
-- Apellido.
select first_name as Nombre, last_name as Apellido
from actor a;

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
select min(actor_id) as min_actor_id, max(actor_id) as max_actor_id
from actor a;

-- 38. Cuenta cuántos actores hay en la tabla “actor”.
select count(*) as total_actors
from actor a;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden
-- ascendente.
select actor_id, first_name, last_name
from actor a 
order by last_name asc;

-- 40. Selecciona las primeras 5 películas de la tabla “film”.
select film_id, title
from film f 
limit 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
-- mismo nombre. ¿Cuál es el nombre más repetido?
select first_name, count(*) as total_actors
from actor a 
group by first_name
order by total_actors desc
limit 1;

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los
-- realizaron.
select r.rental_id, c.first_name, c.last_name
from rental r 
join customer c on r.customer_id = c.customer_id;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo
-- aquellos que no tienen alquileres.
select c.customer_id, c.first_name, c.last_name, r.rental_id
from customer c
left join rental r on c.customer_id = r.customer_id
order by c.customer_id;

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
-- esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select *
from film f 
cross join category c;
-- Esta consulta no aporta valor debido a que film y category son dos tablas muy grandes, así que el conjunto de datos
-- resultante es aun mayor. Y en este caso, no se necesita saber todas las combinaciones posibles de ambas tablas, por lo
-- que no es útil ni práctico

-- 45. Encuentra los actores que han participado en películas de la categoría
-- 'Action'.
select distinct a.actor_id, a.first_name, a.last_name
from actor a 
join film_actor fa on a.actor_id = fa.actor_id
join film_category fc on fa.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Action';

-- 46. Encuentra todos los actores que no han participado en películas.
select a.actor_id, a.first_name, a.last_name
from actor a 
left join film_actor fa on a.actor_id = fa.actor_id
where fa.film_id is null;

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las
-- que han participado.
select a.first_name, a.last_name, count(fa.film_id) as total_films
from actor a 
left join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
order by total_films desc;

-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres
-- de los actores y el número de películas en las que han participado.
create view actor_num_peliculas as
select a.actor_id, a.first_name, a.last_name, count(fa.film_id) as total_films
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
order by total_films desc;

-- 49. Calcula el número total de alquileres realizados por cada cliente.
select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as total_rentals
from customer c 
left join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_rentals desc;

-- 50. Calcula la duración total de las películas en la categoría 'Action'.
select sum(f.length) as total_duration
from film f 
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Action';

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para
-- almacenar el total de alquileres por cliente.
create temporary table cliente_rentas_temporal as
select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as total_rentals
from customer c
left join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name;

-- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
-- películas que han sido alquiladas al menos 10 veces.
create temporary table peliculas_alquiladas as
select f.film_id, f.title, count(r.rental_id) as total_rentals
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by f.film_id, f.title
having count(r.rental_id) > 9
order by total_rentals desc;

-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente
-- con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
-- los resultados alfabéticamente por título de película.
select f.title
from customer c 
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
where c.first_name = 'Tammy' and c.last_name = 'Sanders' and r.return_date is null 
order by f.title asc;

-- 54. Encuentra los nombres de los actores que han actuado en al menos una
-- película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
-- alfabéticamente por apellido.
select distinct a.first_name, a.last_name
from actor a 
join film_actor fa on a.actor_id = fa.actor_id
join film_category fc on fa.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Sci-Fi'
order by a.last_name asc;

-- 55. Encuentra el nombre y apellido de los actores que han actuado en
-- películas que se alquilaron después de que la película ‘Spartacus
-- Cheaper’ se alquilara por primera vez. Ordena los resultados
-- alfabéticamente por apellido.
select distinct a.first_name, a.last_name
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join inventory i on fa.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
where r.rental_date > (
		select min(r2.rental_date)
		from rental r2
		join inventory i2 on r2.inventory_id = i2.inventory_id
		join film f on i2.film_id = f.film_id
		where f.title = 'Spartacus Cheaper')
order by a.last_name asc;

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en
-- ninguna película de la categoría ‘Music’.
select a.first_name, a.last_name
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
left join inventory i on fa.film_id = i.film_id
left join film_category fc on i.film_id = fc.film_id
left join category c on fc.category_id = c.category_id and c.name = 'Music'
where c.category_id is null
group by a.first_name, a.last_name;

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más
-- de 8 días.
select f.title
from film f 
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
where r.return_date is not null and (r.return_date - r.rental_date) > '8 days'::interval;
-- interval sirve para representar un período de tiempo

-- 58. Encuentra el título de todas las películas que son de la misma categoría
-- que ‘Animation’.
select f.title
from film f 
join inventory i on f.film_id = i.film_id
join film_category fc on i.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Animation'
group by f.title;

-- 59. Encuentra los nombres de las películas que tienen la misma duración
-- que la película con el título ‘Dancing Fever’. Ordena los resultados
-- alfabéticamente por título de película.
select f.title
from film f 
where f.length = (select f2.length from film f2 where f2.title = 'Dancing Fever')
order by f.title asc;

-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7
-- películas distintas. Ordena los resultados alfabéticamente por apellido.
select c.first_name, c.last_name
from customer c 
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
group by c.first_name, c.last_name
having count(distinct i.film_id) > 6
order by c.last_name asc;

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y
-- muestra el nombre de la categoría junto con el recuento de alquileres.
select c.name, count(r.rental_id) as total_rentals
from category c 
join film_category fc on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by c.name
order by c.name asc;

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.
select c.name, count(f.film_id) as total_films
from category c 
join film_category fc on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id
where f.release_year = 2006
group by c.name
order by c.name asc;

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
-- que tenemos.
select s.staff_id, s.first_name, s.last_name, st.store_id
from staff s 
cross join store st;

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y
-- muestra el ID del cliente, su nombre y apellido junto con la cantidad de
-- películas alquiladas.
select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as total_rentals
from customer c 
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
group by c.customer_id, c.first_name, c.last_name
order by c.customer_id asc;
