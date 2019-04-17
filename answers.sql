--  Practice Joins

SELECT unit_price FROM invoice_line 
WHERE unit_price > .99;

SELECT invoice.invoice_date, customer.first_name, customer.last_name, invoice.total FROM invoice
INNER JOIN customer ON invoice.customer_id = customer.customer_id;

SELECT c.first_name, c.last_name, e.first_name, e.last_name FROM customer AS c
INNER JOIN employee AS e ON e.employee_id = c.support_rep_id;

SELECT album.title, artist.name FROM album
INNER JOIN artist ON album.artist_id = artist.artist_id;

SELECT playlist_track_id FROM playlist_track
INNER JOIN playlist ON playlist.name = 'Music';

SELECT track.name FROM track
INNER JOIN playlist_track ON playlist_track.track_id = track.track_id
WHERE playlist_track.playlist_id = 5;

SELECT track.name, playlist.name FROM track
INNER JOIN playlist_track ON track.track_id = playlist_track.track_id
INNER JOIN playlist ON playlist_track.playlist_id = playlist.playlist_id;

SELECT track.name, album.title FROM track
INNER JOIN album ON track.album_id = album.album_id
INNER JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name = 'Alternative & Punk';

-- Black Diamond

SELECT track.name, genre.name, album.title, artist.name FROM track
INNER JOIN genre ON track.genre_id = genre.genre_id
INNER JOIN album ON track.album_id = album.album_id
INNER JOIN artist ON album.artist_id = artist.artist_id
INNER JOIN playlist_track ON track.track_id = playlist_track.track_id
INNER JOIN playlist ON playlist_track.playlist_id = playlist.playlist_id
WHERE playlist.name = 'Music';

-- Practice nested queries

SELECT * FROM invoice
WHERE invoice_id IN (
  SELECT invoice_id FROM invoice_line
  WHERE unit_price > .99);

SELECT * FROM playlist_track
WHERE playlist_id IN (
  SELECT playlist_id FROM playlist
  WHERE name = 'Music');

SELECT name FROM track
WHERE track_id IN (
  SELECT track_id FROM playlist_track
  WHERE playlist_id = 5);

SELECT * FROM track
WHERE genre_id IN (
  SELECT genre_id FROM genre
  WHERE name = 'Comedy');

SELECT * FROM track
WHERE album_id IN (
  SELECT album_id FROM album
  WHERE title = 'Fireball');

SELECT * FROM track
WHERE album_id IN (
  SELECT album_id FROM album
  WHERE artist_id IN (
    SELECT artist_id FROM artist
    WHERE name = 'Queen'));

-- Practice updating Rows

UPDATE customer
SET fax = NULL
WHERE fax IS NOT NULL;

UPDATE customer
SET company = 'Self'
WHERE company IS NULL;

UPDATE customer
SET last_name = 'Thompson'
WHERE last_name = 'Barnett' AND first_name = 'Julia';

UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

UPDATE track
SET composer = 'The darkness around us'
WHERE composer IS NULL AND genre_id IN 
(SELECT genre_id FROM genre
 	WHERE name = 'Metal');

-- Group By

SELECT count(*), genre.name FROM track
INNER JOIN genre ON track.genre_id = genre.genre_id
GROUP BY genre.name

SELECT count(*) FROM track
INNER JOIN genre ON track.genre_id = genre.genre_id
GROUP BY genre.name IN ('Pop', 'Rock');

SELECT artist.name, count(album.artist_id) FROM album
INNER JOIN artist ON album.artist_id = artist.artist_id
GROUP BY artist.name;

-- Use Distinct

SELECT DISTINCT composer FROM track;

SELECT DISTINCT billing_postal_code FROM invoice;

SELECT DISTINCT company FROM customer;

-- Delete Rows

DELETE FROM practice_delete
WHERE type = 'bronze';

DELETE FROM practice_delete
WHERE type = 'silver';

DELETE FROM practice_delete
WHERE value = 150;

-- eCommerce Simulation

CREATE TABLE users 
(user_id SERIAL PRIMARY KEY, name VARCHAR(50), email VARCHAR(225));
 
 CREATE TABLE products
 (product_id SERIAL PRIMARY KEY, name VARCHAR(50), price FLOAT);
 
 CREATE TABLE orders
 (order_id SERIAL PRIMARY KEY, product_id INTEGER 
  REFERENCES products(product_id));

INSERT INTO users (name, email) VALUES ('John', 'dfk@kjn.com'), ('Tim', 'lol@lol.com'), ('Sarah', 'umm@what.com');

INSERT INTO products (name, price) 
VALUES ('Soap', 1), ('Kittens', 50), ('Time', 0);

INSERT INTO orders (product_id) 
VALUES (3), (1), (2);

SELECT * FROM products	
INNER JOIN orders ON products.product_id = orders.product_id
WHERE orders.order_id = 1;

SELECT * FROM orders;	

SELECT sum(products.price) FROM products
INNER JOIN orders ON products.product_id = orders.product_id
GROUP BY orders.order_id;

ALTER TABLE orders
ADD COLUMN user_id INTEGER REFERENCES users(user_id);

UPDATE orders
SET user_id	= 2
WHERE user_id IS NULL;

SELECT * FROM orders
WHERE user_id = 2;

SELECT count(order_id) FROM orders
WHERE user_id = 2;