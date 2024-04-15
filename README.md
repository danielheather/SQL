# The use of SQL 

In conjunction with the PowerBI code, we utilized SQL code to convert the data into an easy-to-use database. This allows specific data queries without the risk of creating errors or issues in the dataset.

The Power BI dashboard/reports can be viewed here https://github.com/danielheather/Power-BI-Sales-Dashboard

## SQL Database Design

First, we create a database to store our data.

```SQL
CREATE DATABASE global_superstore_sales;
```

Then we can create our tables, we will have three tables "customers", "products", and "orders". "orders" will hold the foreign key for the other two tables. 
* customers: Records customer information, for in customer segmentation and demographic analysis.
* products: Catalogs product inventory, for tracking and analyzing product performance.
* orders: For sales transactions, linking the products and customers, and includeing financial metrics.

```SQL
CREATE TABLE customers(
customer_id VARCHAR(12) PRIMARY KEY,
customer_name VARCHAR(22),
segment VARCHAR(11),
city VARCHAR(35),
state VARCHAR(36),
country VARCHAR(32),
region VARCHAR(17),
market VARCHAR(12));
```

```SQL
CREATE TABLE products(
product_id VARCHAR(11)PRIMARY KEY,
category VARCHAR(15),
sub_category VARCHAR(11),
product_name VARCHAR(127));
```

```SQL
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
```

Next, we import the dataset into each table. The data has been split into multiple files to make importing easier.

```SQL
COPY customers(customer_id, customer_name,segment,city,state,country,region,market)
FROM 'C:\Users\Public\Public Doc4SQL\customers.csv'
DELIMITER ','
CSV HEADER;
```

```SQL
COPY products(product_id, category,sub_category,product_name)
FROM 'C:\Users\Public\Public Doc4SQL\products.csv'
DELIMITER ','
CSV HEADER;
```

```SQL
COPY orders(order_number, order_id, order_date,shipping_date,shipping_mode,sales,quantity,discount,profit,shipping_cost,order_priority,product_id,customer_id)
FROM 'C:\Users\Public\Public Doc4SQL\orders.csv'
DELIMITER ','
CSV HEADER;
```

Now that our data is set up we can easily query the data. Below I will highlight some examples.

```SQL
-- Examples of Data Queries
-- Top 5 Products by Total Revenue
SELECT product_name, SUM(sales)
FROM products
JOIN orders ON products.product_id = orders.product_id
GROUP BY product_name
ORDER BY SUM DESC
LIMIT 5;
```

```SQL
-- Segments by Total Profit - Lowest to Highest
SELECT segment, SUM(profit)
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY segment
ORDER BY SUM ASC;
```

```SQL
-- Minimum Order Quantity by Country
SELECT country, AVG(quantity) as average_quantity
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY country
HAVING AVG(quantity) > 1
ORDER BY average_quantity ASC
LIMIT 5;
```
