--Bootcamp Assignment
--Question 1
--Find the highest and lowest priced products along with their prices
SELECT product_name, unit_price 
FROM products 
WHERE unit_price = (SELECT MAX(unit_price) FROM products) 
   OR unit_price = (SELECT MIN(unit_price) FROM products);

--Question 2  
--Find the total number of orders in each month in the year 2022
SELECT 
    EXTRACT(MONTH FROM order_date) AS month, 
    COUNT(*) AS total_orders
FROM 
    orders
WHERE 
    EXTRACT(YEAR FROM order_date) = 2022
GROUP BY 
    EXTRACT(MONTH FROM order_date);

--Question 3
--Find the average unit price and unit cost (2 decimals) for each product category
SELECT product_category,
ROUND(AVG(unit_price),2) AS avg_unit_price, 
ROUND(AVG(unit_cost),2) AS avg_unit_cost
FROM products
GROUP BY product_category;


--Question 4	
--Find all orders that were placed on or after August 1,2022
SELECT order_id, order_date
FROM orders
where order_date >= '2022-08-01';

--Question 5
--Count the number of payments made on April 14,2023
SELECT COUNT(*) AS num_payment
FROM payments
WHERE payment_date = '2023-04-14';

--Question 6
--Which customer_id had the highest orders placed in the order table
SELECT 
    customer_id, 
    COUNT(*) AS num_orders
FROM 
    orders
GROUP BY 
    customer_id
ORDER BY 
    num_orders DESC
LIMIT 1;

--Question 7
--What is the total number of order made by each customer_id
SELECT 
    customer_id, 
    COUNT(*) AS num_orders
FROM 
    orders
GROUP BY 
    customer_id;
	
--Question 8	
-- What is the total number of delivered between January and February 2023
SELECT 
    COUNT(*) AS num_delivered_orders
FROM 
    orders
WHERE 
    delivery_status = 'delivered' 
    AND order_date >= '2023-01-01' 
    AND order_date < '2023-03-01';
	
--Question 9
--Create a Credit Card table and link it to the previous tables you created in the exercise 1 in the previous class.
-- Generate random data sets to populate the new credit card table.
-- The credit card table must contain the following columns; card_number, customer_id, card_expiry_date, and bank_name.

CREATE TABLE credit_cards (
    card_number VARCHAR(50) PRIMARY KEY,
    customer_id bigint,
    card_expiry_date DATE,
    bank_name VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(Customer_id)
);

--Question 10
--Retrieve all the information associated with the credit card that is next to expire from the “credit card" table?
SELECT *
FROM credit_cards
WHERE card_expiry_date = (
  SELECT MIN(card_expiry_date)
  FROM credit_cards
  WHERE card_expiry_date >= CURRENT_DATE
);	

--Question 11
--how many have expired?
SELECT COUNT(*)
FROM credit_cards
WHERE card_expiry_date < CURRENT_DATE;


