/* Exercise 4 
Transform the table store in the "exercise4.xlsx" file into a normalized 
form and create a postgreSQL databsed for it. Insert all the data into the
corresponding tables in the database 
From the DB, answer the following questions.
1. On which day/s of the week are condoms mostly sold?
2. At what time of the day is it mostly sold?
3. What time of the day is it mostly sold?
4. Which aisle contains most of the organic products?
5. Which aisle/s can i find all the non-alcoholic drinks?
Note: Order_dow means order  of the day of the week. E.g 0=Sunday,
1=Monday....6=Saturday*/

--Create a table to import import denormalixed csv file
CREATE TABLE denormalized (
    product_id bigint,
    product_name text,
    aisle_id integer,
    department_id bigint,
    aisle text,
    order_id bigint,
    user_id bigint,
    order_dow integer,
    order_hour_of_day integer,
    days_since_prior_order integer,
    department text
);

-- View table
SELECT * FROM denormalized

-- Create view tables as a placeholder for the normalization tables

CREATE VIEW product_view AS SELECT DISTINCT (product_id), product_name, aisle_id, department_id
FROM denormalized
ORDER BY product_id;

CREATE VIEW order_view AS SELECT DISTINCT (order_id), user_id, order_dow, order_hour_of_day, days_since_prior_order, product_id
FROM denormalized
ORDER BY order_id;

CREATE VIEW aisle_view AS SELECT DISTINCT (aisle_id), aisle
FROM denormalized
ORDER BY aisle_id;

CREATE VIEW department_view AS SELECT DISTINCT (department_id), department
FROM denormalized
ORDER BY department_id;

--CREATE THE TABLES TO TRANSFER THE VIEWS INTO

CREATE TABLE depts (
    department_id bigint PRIMARY KEY,
    department VARCHAR (25));

CREATE TABLE ais (
    aisle_id bigint PRIMARY KEY,
    aisle text);

CREATE TABLE prods (
    product_id bigint PRIMARY KEY,
    product_name text,
    aisle_id bigint REFERENCES ais (aisle_id),
    department_id bigint REFERENCES depts(department_id)
);

CREATE TABLE orders_uz (
    order_id bigint PRIMARY KEY,
    user_id bigint,
    order_dow integer,
    order_hour_of_day integer,
    days_since_prior_order integer,
    product_id bigint REFERENCES prods(product_id)
);

--INSERT THE VIEW INTO THE CREATED TABLES

INSERT INTO depts (department_id, department)
SELECT department_id, department
FROM department_view ORDER BY department_id;

INSERT INTO ais (aisle_id, aisle)
SELECT DISTINCT aisle_id, aisle
FROM aisle_view order BY aisle_id;

INSERT INTO prods (product_id, product_name, aisle_id, department_id)
SELECT product_id, product_name, aisle_id, department_id
FROM product_view ORDER BY product_id;

INSERT INTO orders_uz (order_id, user_id, order_dow, order_hour_of_day, days_since_prior_order, product_id)
SELECT DISTINCT (order_id), user_id, order_dow, order_hour_of_day, days_since_prior_order, product_id
FROM denormalized ORDER BY order_id;

--View normalised tables
SELECT * FROM prods
SELECT * FROM ais
SELECT * FROM depts
SELECT * FROM orders_uz

--Questions

--1. On which day/s of the week are condoms mostly sold?
SELECT o.order_dow, COUNT(*) as num_sales
FROM prods p
JOIN ais a ON a.aisle_id = p.aisle_id
JOIN orders_uz o ON p.product_id = o.product_id
JOIN depts d ON p.department_id = d.department_id
WHERE p.product_name ILIKE '%Condom%'
GROUP BY o.order_dow
ORDER BY num_sales DESC
LIMIT 3;

--or adding the week days
SELECT 
  CASE o.order_dow 
    WHEN 0 THEN 'Sunday'
    WHEN 1 THEN 'Monday'
    WHEN 2 THEN 'Tuesday'
    WHEN 3 THEN 'Wednesday'
    WHEN 4 THEN 'Thursday'
    WHEN 5 THEN 'Friday'
    WHEN 6 THEN 'Saturday'
  END AS day_of_week,
  COUNT(*) as num_sales
FROM prods p
INNER JOIN ais a ON a.aisle_id = p.aisle_id
INNER JOIN orders_uz o ON p.product_id = o.product_id
INNER JOIN depts d ON p.department_id = d.department_id
WHERE p.product_name ILIKE '%Condom%'
GROUP BY o.order_dow
ORDER BY num_sales DESC
LIMIT 3;

--2. At what time of the day is it mostly sold?
SELECT o.order_hour_of_day, COUNT(*) as num_sales
FROM prods p
JOIN ais a ON a.aisle_id = p.aisle_id
JOIN orders_uz o ON p.product_id = o.product_id
JOIN depts d ON p.department_id = d.department_id
WHERE p.product_name ILIKE '%Condom%'
GROUP BY o.order_hour_of_day
ORDER BY num_sales DESC
LIMIT 1;

--3. What type of condom do the customers prefer?
SELECT p.product_name, COUNT(*) as num_sales
FROM prods p
JOIN ais a ON a.aisle_id = p.aisle_id
JOIN orders_uz o ON p.product_id = o.product_id
JOIN depts d ON p.department_id = d.department_id
WHERE p.product_name ILIKE '%Condom%'
GROUP BY p.product_name
ORDER BY num_sales DESC
LIMIT 1;

--4. Which aisle contains most of the organic products?
SELECT a.aisle, COUNT(*) as num_organic_products
FROM prods p
JOIN ais a ON p.aisle_id = a.aisle_id
WHERE p.product_name ILIKE '%Organic%'
GROUP BY a.aisle
ORDER BY num_organic_products DESC
LIMIT 1;

--5. Which aisle/s can I find all the non-alcoholic drinks?
SELECT a.aisle, COUNT(*) AS num_non_alcoholic_drinks, 
       string_agg(DISTINCT p.product_name, ', ') AS non_alcoholic_drinks
FROM prods p
JOIN ais a ON p.aisle_id = a.aisle_id
JOIN depts d ON p.department_id = d.department_id
WHERE p.product_name ILIKE '%non-alcoholic%' 
OR p.product_name ILIKE '%non alcoholic%' 
OR p.product_name ILIKE '%non alcohol%'
OR p.product_name ILIKE '%no alcohol%'
GROUP BY a.aisle
ORDER BY num_non_alcoholic_drinks DESC;










