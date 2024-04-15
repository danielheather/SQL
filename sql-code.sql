-- Creating Database
CREATE DATABASE global_superstore_sales;

-- Creating Tables
CREATE TABLE customers(
customer_id VARCHAR(12) PRIMARY KEY,
customer_name VARCHAR(22),
segment VARCHAR(11),
city VARCHAR(35),
state VARCHAR(36),
country VARCHAR(32),
region VARCHAR(17),
market VARCHAR(12));

CREATE TABLE products(
product_id VARCHAR(11)PRIMARY KEY,
category VARCHAR(15),
sub_category VARCHAR(11),
product_name VARCHAR(127));

CREATE TABLE orders(
order_number INT PRIMARY KEY,
order_id VARCHAR(24),
order_date DATE,
shipping_date DATE,
shipping_mode VARCHAR(14),
sales NUMERIC(10,2),
quantity INT,
discount NUMERIC(10,2),
profit NUMERIC(10,2),
shipping_cost NUMERIC(10,2),
order_priority VARCHAR(8),
product_id VARCHAR(11),
customer_id VARCHAR(12),
FOREIGN KEY (product_id) REFERENCES products(product_id),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id));

-- Importing Data
COPY customers(customer_id, customer_name,segment,city,state,country,region,market)
FROM 'C:\Users\Public\Public Doc4SQL\customers.csv'
DELIMITER ','
CSV HEADER;

COPY products(product_id, category,sub_category,product_name)
FROM 'C:\Users\Public\Public Doc4SQL\products.csv'
DELIMITER ','
CSV HEADER;

COPY orders(order_number, order_id, order_date,shipping_date,shipping_mode,sales,quantity,discount,profit,shipping_cost,order_priority,product_id,customer_id)
FROM 'C:\Users\Public\Public Doc4SQL\orders.csv'
DELIMITER ','
CSV HEADER;

-- Examples of Data Queries
-- Top 5 Products by Total Revenue
SELECT product_name, SUM(sales)
FROM products
JOIN orders ON products.product_id = orders.product_id
GROUP BY product_name
ORDER BY SUM DESC
LIMIT 5;

-- Segments by Total Profit - Lowest to Highest
SELECT segment, SUM(profit)
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY segment
ORDER BY SUM ASC;

-- Minimum Order Quantity by Country
SELECT country, AVG(quantity) as average_quantity
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY country
HAVING AVG(quantity) > 1
ORDER BY average_quantity ASC
LIMIT 5;