use sakila;

#1.Get all pairs of actors that worked together.
select * from actor a1
join film_actor f1
on a1.actor_id=f1.actor_id;

select f1.actor_id as actor_id1, a1.first_name, a1.last_name, f2.actor_id as actor_id2, a2.first_name, a2.last_name from film_actor f1
left join film_actor f2 on f1.film_id = f2.film_id
join actor a1 on a1.actor_id= f1.actor_id
join actor a2 on a2.actor_id= f2.actor_id
where f1.actor_id < f2.actor_id
order by a1.actor_id;

#2.Get all pairs of customers that have rented the same film more than 3 times.
SELECT c1 AS CUSTOMER_1, c2 as customer_2 from (
SELECT A.CUSTOMER_ID AS C1, B.CUSTOMER_ID AS C2, SUM(b.rentals) AS rentals FROM (
SELECT r.customer_id,  i.film_id, count(distinct rental_id) rentals FROM  rental AS r 
LEFT JOIN inventory AS i on i.inventory_id = r.inventory_id
group by  r.customer_id, i.film_id
) A 
LEFT JOIN 
(
SELECT r.customer_id,  i.film_id, count(distinct rental_id) rentals FROM  rental AS r 
LEFT JOIN inventory AS i on i.inventory_id = r.inventory_id
group by  r.customer_id, i.film_id
) B ON a.film_id = b.film_id and a.customer_id < b.customer_id  AND a.rentals >= b.rentals  
GROUP BY 1,2 
HAVING rentals > 3 
) as a 
ORDER BY 1 ;

#3.Get all possible pairs of actors and films.
select * from (
select distinct first_name, last_name from actor
) sub1
cross join (
select title from film
) sub2; 





