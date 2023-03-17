CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50),
  email VARCHAR(50),
  phone VARCHAR(20)
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(50),
  description TEXT,
  product_category VARCHAR(50),
  unit_price DECIMAL(10,2)
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  product_id INT,
  quantity INT,
  delivery_status VARCHAR(50),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE payments(
  payment_id INT PRIMARY KEY,
  order_id INT,
  payment_date DATE,
  FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
