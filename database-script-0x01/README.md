# Database Schema (DDL)

## Description

This directory contains the Data Definition Language (DDL) script required to create the complete database structure for the ALX Airbnb project.

## Contents

* `schema.sql`: This script, when executed, will:
    * Drop any existing tables to ensure a clean setup.
    * Create all necessary tables (`Users`, `Locations`, `Properties`, `Bookings`, etc.).
    * Define all columns with appropriate data types.
    * Set `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, and `NOT NULL` constraints to enforce data integrity.
    * Create indexes on frequently queried columns to optimize performance.

## Usage

Before running this script, ensure you have created and selected the target database (e.g., `alx_airbnb`).

To execute the schema creation script, run the following command from your terminal:

```bash
mysql -u your_user -p your_database_name < schema.sql
