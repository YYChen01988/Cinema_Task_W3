SELECT customers.*, films.*, tickets.*, screenings.* FROM customers
INNER JOIN tickets
ON customers.id = tickets.customer_id
INNER JOIN films
ON films.id =  tickets.film_id
INNER JOIN screenings
ON screenings.id =  tickets.screening_id;
