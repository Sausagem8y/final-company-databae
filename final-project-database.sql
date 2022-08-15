CREATE DATABASE company;

USE company;

CREATE TABLE categories(
    category_id INT AUTO_INCREMENT PRIMARY KEY,
	category_name VARCHAR(255)
	);

CREATE TABLE products(
	product_name VARCHAR(225),
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_description VARCHAR(225),
    product_quantity INT,
    price DECIMAL (7, 2),
    category INT,
    FOREIGN KEY(category) REFERENCES categories(category_id) 
);

CREATE TABLE stores(
    store_name VARCHAR(225),
    store_id INT AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE customers(
	customer_name VARCHAR(225),
    age INT NOT NULL,
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(225),
    products_purchased INT,
    FOREIGN KEY(products_purchased) REFERENCES products(product_id),
    store_purchased_at INT,
    FOREIGN KEY(store_purchased_at) REFERENCES stores(store_id)
);

CREATE TABLE staff(
    employee_name VARCHAR(255),
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_department VARCHAR(255),
    sold_products INT,
    employee_store_location INT,
    FOREIGN KEY (employee_store_location) REFERENCES stores(store_id)
);

CREATE TABLE products_purchased(
    purchase_id INT,
    customer_purchase_id INT,
    employee_purchase_id INT,
    online_purchase BOOLEAN DEFAULT FALSE,
	FOREIGN KEY(purchase_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_purchase_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_purchase_id) REFERENCES staff(employee_id)
    );

INSERT INTO categories(category_name) VALUES ('grocery'), ('automotive'), ('electronics'), ('cosmetics'), ('pharmacy'), ('Bakery'), ('Sports');

INSERT INTO products(product_name, product_description, product_quantity, price, category) 
VALUES ('sony playstation 5', '5th generation home gaming console by sony, comes with 1 dualsense controller and astros playworld', 0, 499.99, 3), 
('Cheezy super sploders', 'your guess is as good as mine', 50, 1.79, 1), ('B16A2', '1.6L 16-valve DOHC VTEC 4-cylinder engine found in sixth generation honda civics', 3, 3299.00, 2), 
('Blue Bunny: Butter Pecan', 'Buttery Bits and Pieces of pecans mixed into our signature vanilla ice cream', 16, 3.49, 1), 
('Super Sally: Red', 'Crimson colored lip gloss', 74, 3.99, 4), ('HDMI Cable', 'Used to connect to high definition displays', 7, 9.99, 3), ('Chicken Nuggets', 'Dinosaur shaped rib and dark meats', 35, 17.89, 1),
('Cherry Turnovers', 'A chopped cherry, brown sugar, and bourbon reduction wrapped in a buttery tender pastry', 12, 5.99, 6), ('Chocolate Turnover', '%77 Cacao dark chocolate and port reduction wrapped in a tender and buttery pastry', 6, 5.99, 6),
('Baseball bat', '16 inch alluminum bat', 12, 9.99, 7);

INSERT INTO stores(store_name) VALUES ('Seattle, WA'), ('Provo, UT'), ('Arlen, TX'), ('Fox, AK'), ('Chicago, IL'), ('Los Angeles, CA'), ('New Orleans, LA'), ('Blue River, MT');

INSERT INTO customers(customer_name, age, email, store_purchased_at) 
VALUES ('Gerald Hopper', 54, 'theoggerry@hotmail.com', 2),
('Berry Borganzoli', 33, 'bigbarrybaskinson@gmail.com', 1), ('Karen Kcrackerburrel', 46, 'getmethemanager@facebook.com', 3),
('Hamish Villalobos', 32, 'HamiHamBone@myspace.com', 7), ('Indi Potter', 15, 'TheRealest@CallOfDutyElite.com', 5), ('Minnie herbert', 22, 'MinyMinnieMouse@disneyClubhouse.com', 8),
('Juliet Meza', 45, 'WaitingForRomeo@match.com', 6), ('Anoushka Maldonado', 42, 'allibaba556@gmail.com', 4), ('Taybah Herbert', 26, 'Taystation67@GamerPros.org', 7),
('Grady Warner', 31, 'norelation@warnerBros.com', 2), ('Ryder Little', 88, 'NearestGroceryStore', 5), ('Efa Leonard', 24, 'LeoTheWhiteLion@yourmoviesucks.org', 8);

INSERT INTO staff(employee_name, employee_department, sold_products, employee_store_location) VALUES 
('Marsha Greer', 'Grocery', 54, 2), ('Barnaby Haworth', 'Automotive', 8, 3), ('Harleen Owen', 'Bakery', 357, 1), ('Duncan Burch', 'Electronics', 76, 2),
('Conan Bostock', 'Bakery', 55, 3), ('Sania huerta', 'Automotive', 99, 4), ('Merlin Lott', 'Grocery', 43, 1), ('Kai Markham', 'Grocery', 73, 3),
('Leila Hayward', 'Electronics', 21, 1), ('Abdurrahman Cochran', 'Pharmacy', 6, 4), ('Emer Paine', 'Cosmetics', 543, 3), ('Idris Mays', 'Pharmacy', 23, 1);

INSERT INTO products_purchased(purchase_id, customer_purchase_id, employee_purchase_id, online_purchase) VALUES 
(6, 7, 9, false), (6, 1, 4, false), (2, 3, 1, 0), (3, 10, 2, 1), (4, 6, 7, true), (3, 7, 9, 0), (4, 7, 9, false), (8, 11, 3, 0), (8, 7, 5, 0), (8, 5, 5, 0), 
(9, 4, 7, 0), (10, 11, 8, 0), (7, 3, 10, 1), (10, 12, 5, 0), (3, 5, 9, 0), (7, 10, 8, 1), (9, 9, 9, 1), (2, 1, 6, 0), (9, 10, 2, 1);

select * from customers;

select * from products;

select * from employees;

select * from products_purchased;

# basic purchases table
SELECT product_name FROM products LEFT JOIN products_purchased ON products.product_id = products_purchased.purchase_id;

# complex purchases table
SELECT product_name, customer_name, employee_name, online_purchase FROM products_purchased 
INNER JOIN products ON products_purchased.purchase_id = products.product_id 
INNER JOIN customers ON products_purchased.customer_purchase_id = customers.customer_id 
INNER JOIN staff ON products_purchased.employee_purchase_id = staff.employee_id ORDER BY customer_name;
