SELECT customers.*, films.*, tickets.* FROM customers
INNER JOIN tickets
ON customers.id = tickets.customer_id
INNER JOIN films
ON films.id =  tickets.film_id;
