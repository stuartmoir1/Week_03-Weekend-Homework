DROP TABLE screenings;
DROP TABLE tickets;
DROP TABLE customers;
DROP TABLE films;

CREATE TABLE customers (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds INT4,
  tickets_bought INT4
);

CREATE TABLE films (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price INT2,
  max_tickets INT4,
  tickets_sold INT4
);

CREATE TABLE tickets (
  id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(id),
  film_id INT4 REFERENCES films(id),
  show_time VARCHAR(255)
);

CREATE TABLE screenings (
  id SERIAL4 PRIMARY KEY,
  film_id INT4 REFERENCES films(id),
  show_time1 VARCHAR(255),
  show_time2 VARCHAR(255),
  show_time3 VARCHAR(255),
  show_time4 VARCHAR(255)
);