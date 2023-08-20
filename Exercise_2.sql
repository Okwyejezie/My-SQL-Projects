--Create Customers table
CREATE TABLE Customers (
  customer_id SERIAL PRIMARY KEY,
  customer_name VARCHAR(255) NOT NULL,
  customer_address TEXT NOT NULL,
  customer_email VARCHAR(255) NOT NULL,
  UNIQUE (customer_name, customer_address, customer_email)
);

--Create items table
CREATE TABLE items (
    item_id SERIAL PRIMARY KEY,
    item_description VARCHAR(255) NOT NULL,
    price NUMERIC(10, 2) NOT NULL
);

--Create Orders table
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_quantity INTEGER NOT NULL,
    order_date DATE NOT NULL,
    item_id INTEGER NOT NULL REFERENCES items (item_id),
    price NUMERIC(10, 2) NOT NULL
);

--Create Restaurants table
CREATE TABLE Restaurants (
  restaurant_id SERIAL PRIMARY KEY,
  restaurant_name VARCHAR(255) NOT NULL,
  restaurant_address_line1 TEXT NOT NULL,
  restaurant_address_line2 TEXT,
  restaurant_city VARCHAR(255) NOT NULL,
  restaurant_state VARCHAR(255) NOT NULL,
  restaurant_zip_code VARCHAR(10) NOT NULL
);
	
--Insert data into Customers table
INSERT INTO Customers (customer_name, customer_address, customer_email)
VALUES ('Jane', '456 Main St', 'jane@gmail.com'),
       ('John Smith', '123 Main St', 'johnsmith@gmail.com'),
       ('Jane Doe', '456 Park Ave', 'janedoe@gmail.com'),
       ('Jane Doe', '456 Park Ave', 'janedoe@gmail.com'),
       ('Jane Doe', '456 Park Ave', 'janedoe@gmail.com'),
       ('Jane Doe', '456 Park Ave', 'janedoe@gmail.com'),
       ('Bob Johnson', '789 Elm St', 'bobjohnson@gmail.com'),
       ('Bob Johnson', '789 Elm St', 'bobjohnson@gmail.com'),
       ('Okafor Ikechukwu', '92 Ikenga St', 'okafor@gmail.com'),
       ('Jeffrey Godson', '083 john St', 'jef@gmail.com')
ON CONFLICT (customer_name, customer_address, customer_email)
DO NOTHING;

--Insert data into Restaurants table
INSERT INTO Restaurants (restaurant_id, restaurant_name, restaurant_address_line1, restaurant_address_line2, restaurant_city, restaurant_state, restaurant_zip_code)
VALUES (1, 'Italiano Pizza', '123 Main St', NULL, 'New York City', 'New York', '10001'),
       (2,'Breakfast Café', '456 Elm St',  NULL, 'Boston', 'Massachusetts', '2110'),
       (3, 'Burger King', '336 Main St', NULL, 'New York City', 'New York', '13201'),
       (4, 'Afro kitchen', '076 Hamburg St', NULL, 'Hamburg City', 'Hamburg', '10032'),
       (5, 'Afro foods', '123 Hamburg St', NULL, 'Hamburg City', 'Hamburg', '10041');
		
--Insert data into Items table
INSERT INTO items (item_description, price)
VALUES ('Tuner fish pizza', 25.5),
       ('Margherita pizza', 25.5),
       ('Mushroom pizza', 25.5),
       ('Black coffee', 26.99),
       ('Sausage', 26.99),
       ('Macaroni', 10.99),
       ('Black coffee', 10.99),
       ('Oxtail', 10.99),
       ('Custard', 10.99),
       ('Beans', 10.99),
       ('Burger', 35.78),
       ('Cola', 35.78),
       ('Chicken', 35.78),
       ('Cheese burger', 24.65),
       ('Fanta', 24.65),
       ('Chicken', 24.65),
       ('Abacha', 45),
       ('Nkwobi', 45),
       ('Oha soup', 45),
       ('Ugba', 50);

--Insert data into Orders table
INSERT INTO Orders (order_id, customer_id, order_quantity, order_date, item_id, price)
VALUES 
    (1, 1, 2, '2022/7/2 0:00', 1, 25.5),
    (2, 6, 1, '2022/12/21 0:00', 2, 25.5),
    (3, 1, 4, '2023/2/16 0:00', 3, 25.5),
    (4, 2, 2, '2022/11/29 0:00', 4, 26.99),
    (5, 2, 2, '2022/9/22 0:00', 6, 10.99),
    (6, 2, 1, '2023/2/27 0:00', 8, 10.99),
    (7, 2, 6, '2022/12/20 0:00', 9, 10.99),
    (8, 3, 3, '2022/11/12 0:00', 11, 35.78),
    (9, 3, 3, '2022/6/16 0:00', 14, 24.65),
    (10, 4, 3, '2022/5/3 0:00', 17, 45),
	(11, 5, 2, '2022/5/3 0:00', 20, 50);
    