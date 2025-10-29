CREATE DATABASE online_store;
USE online_store;

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order Details Table
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Payments Table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    payment_date DATE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Customers
INSERT INTO customers (customer_name, email, city, country) VALUES
('Naveen Kumar', 'naveen@example.com', 'Chennai', 'India'),
('Priya Sharma', 'priya@example.com', 'Delhi', 'India'),
('John Doe', 'john@example.com', 'New York', 'USA'),
('Sarah Lee', 'sarah@example.com', 'London', 'UK');

-- Products
INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 60000),
('Headphones', 'Electronics', 2000),
('Mobile Phone', 'Electronics', 25000),
('Shoes', 'Fashion', 3000),
('Watch', 'Accessories', 4000);

-- Orders
INSERT INTO orders (customer_id, order_date) VALUES
(1, '2025-10-01'),
(2, '2025-10-03'),
(3, '2025-10-05'),
(4, '2025-10-06'),
(1, '2025-10-08');

-- Order Details
INSERT INTO order_details (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(3, 4, 3),
(4, 5, 2),
(5, 2, 1),
(5, 5, 1);

-- Payments
INSERT INTO payments (order_id, amount, payment_method, payment_date) VALUES
(1, 64000, 'Credit Card', '2025-10-01'),
(2, 25000, 'UPI', '2025-10-03'),
(3, 9000, 'PayPal', '2025-10-05'),
(4, 8000, 'Cash', '2025-10-06'),
(5, 6000, 'Credit Card', '2025-10-08');


select sum(amount) as total_revenue from payments;


select c.customer_name,sum(p.amount) as total_cost
from customers c
join orders o on c.customer_id=o.customer_id
join payments p on o.order_id=p.order_id
group by c.customer_name
order by total_cost desc limit 3;


select p.product_name,sum(od.quantity) as total
from products p
join order_details od on p.product_id=od.product_id
group by p.product_name
order by total desc limit 2;

select payment_method,sum(amount) from payments group by payment_method;


select c.country ,count(o.order_id) as total
from customers c
join orders o on c.customer_id=o.customer_id
group by c.country ;


select avg(amount) from payments;


select c.customer_name ,count(*) as total
from customers c
join orders o on c.customer_id=o.customer_id
group by c.customer_name;




