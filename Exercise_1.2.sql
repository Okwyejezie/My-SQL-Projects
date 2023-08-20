-- Create new column "unit_price" into the product table
ALTER TABLE products
ADD COLUMN unit_cost DECIMAL(10,2);

--Update the table with new data 
UPDATE products
SET unit_cost = unit_price * 0.95;

UPDATE product
SET unit_price = unit_cost + (unit_price - unit_cost)/1.05;
--View table
SELECT * FROM public.products
ORDER BY product_id ASC


UPDATE product
SET unit_price = unit_cost + (unit_price - unit_cost)/1.05;