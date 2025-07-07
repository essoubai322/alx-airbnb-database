# ALX Airbnb Database Project

This project involves designing and building a robust relational database for an Airbnb-like application. The primary goal is to apply principles of database design, normalization, and SQL to create a scalable and efficient system from the ground up.

## Project Structure
.
├── ERD/
│   └── (Your ER Diagram file, e.g., airbnb_erd.drawio)
├── database-script-0x01/
│   ├── README.md
│   └── schema.sql
├── database-script-0x02/
│   ├── README.md
│   └── seed.sql
├── normalization.md
└── README.md 

### Table of Contents

1.  [Entity-Relationship Diagram (ERD)](#1-entity-relationship-diagram-erd)
2.  [Database Normalization](#2-database-normalization)
3.  [Database Schema (DDL)](#3-database-schema-ddl)
4.  [Database Seeding (DML)](#4-database-seeding-dml)
5.  [Setup and Usage](#5-setup-and-usage)

---

### 1. Entity-Relationship Diagram (ERD)

The ERD provides a visual blueprint of the database structure. It defines all entities, their attributes, and the relationships between them. The diagram was created using Draw.io and illustrates the one-to-many and many-to-many relationships that form the backbone of our application logic.

**Key Entities:**
* `Users`: Stores user information (guests and hosts).
* `Locations`: Stores city and country data to reduce redundancy.
* `Properties`: Contains all property listings.
* `Bookings`: Manages reservations made by users for properties.
* `Reviews`: Allows guests to review properties after a stay.
* `Payments`: Tracks financial transactions for bookings.
* `Amenities`: A lookup table for available amenities (e.g., Wi-Fi, Pool).
* `Property_Amenities`: A join table linking properties to their amenities (Many-to-Many).

---

### 2. Database Normalization

The database schema is normalized to the **Third Normal Form (3NF)** to ensure data integrity and minimize redundancy.

**Key Normalization Steps:**
* **1NF:** All table columns contain atomic values. No repeating groups.
* **2NF:** The schema is in 1NF and all non-key attributes are fully dependent on the primary key. This is addressed by using single-column primary keys.
* **3NF:** The schema is in 2NF and there are no transitive dependencies.
    * **Example:** `Locations` table was created to store `city` and `country`. The `Properties` table now only stores a `location_id`, removing the transitive dependency where `country` would depend on `city`, which depends on `property_id`.
    * **Example:** `Amenities` and `Property_Amenities` tables were created to handle the many-to-many relationship between properties and their features, avoiding a non-atomic list of amenities in the `Properties` table.

---

### 3. Database Schema (DDL)

The `database-script-0x01/schema.sql` file contains the Data Definition Language (DDL) scripts required to create the database structure. These scripts define all tables, columns, data types, primary keys, foreign keys, constraints, and indexes.

**Features:**
* **Primary Keys:** Each table has a unique `id` for efficient record identification.
* **Foreign Keys:** Enforce referential integrity between related tables (e.g., a `Booking` must be linked to a valid `User` and `Property`).
* **Constraints:** `NOT NULL` and `UNIQUE` constraints are used to ensure data quality.
* **Indexes:** Indexes are created on foreign key columns and other frequently queried columns to optimize query performance.

---

### 4. Database Seeding (DML)

The `database-script-0x02/seed.sql` file contains the Data Manipulation Language (DML) scripts to populate the database with realistic sample data. This allows for testing and development in an environment that simulates real-world usage.

The seeding process follows a logical order to respect foreign key dependencies:
1.  `Locations` and `Amenities` are populated first as they are simple lookup tables.
2.  `Users` are created.
3.  `Properties` are added and linked to host `Users` and `Locations`.
4.  `Property_Amenities` are linked.
5.  `Bookings` are made by guest `Users` for `Properties`.
6.  `Payments` and `Reviews` are generated for the `Bookings`.

---

### 5. Setup and Usage

To set up and use the database, follow these steps:

**Prerequisites:**
* A running MySQL server instance.

**Instructions:**
1.  **Create the Database:**
    ```sql
    CREATE DATABASE alx_airbnb;
    ```
2.  **Switch to the Database:**
    ```sql
    USE alx_airbnb;
    ```
3.  **Create the Schema:**
    Run the `schema.sql` script to create the tables and relationships.
    ```bash
    mysql -u your_user -p alx_airbnb < database-script-0x01/schema.sql
    ```
4.  **Seed the Data:**
    Run the `seed.sql` script to populate the database with sample data.
    ```bash
    mysql -u your_user -p alx_airbnb < database-script-0x02/seed.sql
    ```
5.  **Verify:**
    You can now connect to the `alx_airbnb` database and run queries to verify the data.
    ```sql
    SELECT * FROM Users;
    SELECT * FROM Properties LIMIT 5;
    ```
