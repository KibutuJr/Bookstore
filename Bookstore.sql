-- Create the bookstore database
CREATE DATABASE bookstore;
USE bookstore;

-- 2. Create Tables
-- Country Table
CREATE TABLE country (
	country_id INT AUTO_INCREMENT PRIMARY KEY,
	country_name VARCHAR(50) NOT NULL);
    
-- Address Status Table
CREATE TABLE address_status (
	status_id INT AUTO_INCREMENT PRIMARY KEY,
	status_name VARCHAR(50) NOT NULL);
    
-- Book language table
CREATE TABLE book_language (
	language_id INT AUTO_INCREMENT PRIMARY KEY,
	language_name VARCHAR(50) NOT NULL);
    
-- publisher table
CREATE TABLE publisher (
	publisher_id INT AUTO_INCREMENT PRIMARY KEY, 
    publisher_name VARCHAR(100) NOT NULL);
    
-- author table
CREATE TABLE author (
	author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL);
    
-- shipping method table
CREATE TABLE shipping_method (
	method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL,
    cost DECIMAL(5,2) NOT NULL);
    
-- Order status table
CREATE TABLE order_status (
	status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_value VARCHAR(50) NOT NULL);
    
-- Address Table
CREATE TABLE address (
	address_id INT AUTO_INCREMENT PRIMARY KEY,
	street VARCHAR(200) NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id));
    
-- Customer Table
CREATE TABLE customer (
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) );
    
-- Customer Address Table
CREATE TABLE customer_address (
	customer_address_id INT AUTO_INCREMENT PRIMARY KEY,
	customer_id INT NOT NULL,
    address_id INT NOT NULL,
    status_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id) );
    
-- Book Table
CREATE TABLE book (
	book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) UNIQUE NOT NULL,
    publication_date DATE,
    price DECIMAL(10,2) NOT NULL,
    publisher_id INT NOT NULL,
    language_id INT NOT NULL,
    num_pages SMALLINT NOT NULL,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id) );
    
-- Book Author Junction Table
CREATE TABLE book_author (
	book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id) );
    
-- Customer Order Table
CREATE TABLE cust_order (
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    customer_id INT NOT NULL,
    shipping_address_id INT NOT NULL,
    shipping_method_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_address_id) REFERENCES address(address_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id) );
    
-- Order line table
CREATE TABLE order_line (
	line_id INT AUTO_INCREMENT PRIMARY KEY,
	order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity SMALLINT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN Key (book_id) REFERENCES book(book_id) );
    
-- Order History Table
CREATE TABLE order_history (
	history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    status_id INT NOT NULL,
    status_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id) );
    
    
-- 3. User Management
-- Create roles
CREATE ROLE 'store_manager', 'customer_services', 'inventory_clerk';

-- store manager priviledges
GRANT ALL PRIVILEGES ON bookstore. * TO 'store_manager';

-- Customer Services Privileges
GRANT SELECT, INSERT, UPDATE ON bookstore.customer TO 'customer_services';
GRANT SELECT, INSERT, UPDATE ON bookstore.cust_order TO 'customer_services';
GRANT SELECT, INSERT, UPDATE ON bookstore.order_history TO 'customer_services';

-- inventory clerk privileges
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore.book TO 'inventory_clerk';
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore.author TO 'inventory_clerk';
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore.book_author TO 'inventory_clerk';

-- Create users and assign roles
CREATE USER 'manager1'@'localhost'
IDENTIFIED BY 'securepassword';
GRANT 'store_manager' TO 'manager1'@'localhost';

CREATE USER 'service1'@'localhost'
IDENTIFIED BY 'servicespass';
GRANT 'customer_services' TO 'service1'@'localhost';

CREATE USER 'clerk1'@'localhost'
IDENTIFIED BY 'clerkpass';
GRANT 'inventory_clerk' TO 'clerk1'@'localhost';


-- 4. Querries
-- Retrieve all books with their authors
SELECT b.title, GROUP_CONCAT(a.author_name) AS authors
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
GROUP BY b.title; 

-- Get customer order history
SELECT c.first_name, c.last_name, o.order_id, os.status_value, oh.status_date
FROM customer c
JOIN cust_order o ON c.customer_id = o.customer_id
JOIN order_history oh ON o.order_id = oh.order_id
JOIN order_status os ON oh.status_id = os.status_id
WHERE c.email = 'customer@example.com'
ORDER BY oh.status_date DESC;

-- Calculate total sales by month
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
	SUM(ol.quantity * ol.price) AS total_sales
FROM cust_order co
JOIN order_line ol ON co.order_id = ol.order_id
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;
 

