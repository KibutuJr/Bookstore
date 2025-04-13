# Bookstore Database Project

This project presents a well-structured relational database schema for an online bookstore, designed using MySQL. It includes a complete SQL script to create and manage the schema, alongside an Entity Relationship Diagram (ERD) image visualizing all table relationships and entities.

---

## 📁 Project Structure

### 1. **Bookstore.sql**
- Contains the SQL code to create all necessary tables.
- Defines primary keys, foreign keys, data types, and constraints.
- Tables include:
  - `country`
  - `address_status`
  - `customer`
  - `customer_address`
  - `book`
  - `book_language`
  - `publisher`
  - `author`
  - `shipping_method`
  - `customer_order`
  - `order_line`
  - `order_history`

### 2. **ERD Image**
- File: `A_database_Entity-Relationship_Diagram_(ERD)_is_de.png`
- Provides a visual representation of the schema.
- Highlights:
  - Clear table relationships using primary and foreign keys.
  - Color-coded tables for better distinction.
  - Typographical corrections for improved readability and accuracy.

---

## 📊 Key Features

- Supports multiple authors, publishers, and languages for books.
- Handles customer and address management through linking tables.
- Captures order history with timestamps and status tracking.
- Ensures normalization and eliminates redundancy.
- Easily extendable for future requirements (e.g., reviews, inventory management).

---

## 👩‍💻 Installation & Usage

1. Open a MySQL-compatible database environment (MySQL CLI, phpMyAdmin, MySQL Workbench, etc.).
2. Run the `Bookstore.sql` script to create all tables.
3. Use SQL `INSERT` statements to populate the database with sample data (if required).
4. Use standard SQL queries to retrieve, insert, update, and delete records.
5. Refer to the PNG file for an overview when building frontend/backend integrations.

---

## 🧑‍🤝‍🧑 Group Members

This project was collaboratively created by:

| Name                 | Email                             |
|----------------------|-----------------------------------|
| Fred Kibutu          | Fredkibutu@gmail.com              |
| Sylvia Karanja       | wanguisylvia59@gmail.com          |
| Thabo Wilfred Motsoahae | w.t.motsoahae@gmail.com       |

---

## 📌 Notes

- Please make sure the database engine supports foreign key constraints.
- Date formats and decimal precision settings should match MySQL standards.
- This database is designed with scalability in mind, ideal for academic projects or full-stack ecommerce systems.

---

## 📷 ERD Preview

The visual ERD is included to help users understand the database structure quickly. Each table is visually distinct with appropriate naming and linkages to maintain clarity and consistency.

---

## 📬 License

This project is for educational and academic purposes only. Free to use, modify, and distribute with proper attribution.
