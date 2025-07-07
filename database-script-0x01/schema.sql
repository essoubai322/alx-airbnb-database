-- ALX Airbnb Database Schema
-- This script creates all tables, constraints, and indexes.

-- Drop existing tables to start from a clean slate
DROP TABLE IF EXISTS Property_Amenities;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Amenities;
DROP TABLE IF EXISTS Properties;
DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS Users;

-- Create Users table
CREATE TABLE Users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Locations table (for 3NF)
CREATE TABLE Locations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    UNIQUE(city, country)
);

-- Create Properties table
CREATE TABLE Properties (
    id INT PRIMARY KEY AUTO_INCREMENT,
    host_id INT NOT NULL,
    location_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    property_type VARCHAR(50),
    price_per_night DECIMAL(10, 2) NOT NULL,
    max_guests INT NOT NULL,
    bedrooms INT DEFAULT 1,
    bathrooms DECIMAL(3, 1) DEFAULT 1.0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES Locations(id)
);

-- Create Bookings table
CREATE TABLE Bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT NOT NULL,
    property_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Confirmed' COMMENT 'e.g., Confirmed, Cancelled, Completed',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (guest_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES Properties(id) ON DELETE CASCADE,
    CONSTRAINT chk_dates CHECK (check_out_date > check_in_date)
);

-- Create Reviews table
CREATE TABLE Reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL UNIQUE, -- A booking can only have one review
    guest_id INT NOT NULL,
    property_id INT NOT NULL,
    rating INT NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES Bookings(id) ON DELETE CASCADE,
    FOREIGN KEY (guest_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES Properties(id) ON DELETE CASCADE,
    CONSTRAINT chk_rating CHECK (rating >= 1 AND rating <= 5)
);

-- Create Payments table
CREATE TABLE Payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'Completed' COMMENT 'e.g., Completed, Pending, Failed',
    FOREIGN KEY (booking_id) REFERENCES Bookings(id) ON DELETE CASCADE
);

-- Create Amenities lookup table
CREATE TABLE Amenities (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Create Property_Amenities join table for Many-to-Many relationship
CREATE TABLE Property_Amenities (
    property_id INT NOT NULL,
    amenity_id INT NOT NULL,
    PRIMARY KEY (property_id, amenity_id),
    FOREIGN KEY (property_id) REFERENCES Properties(id) ON DELETE CASCADE,
    FOREIGN KEY (amenity_id) REFERENCES Amenities(id) ON DELETE CASCADE
);

-- Add Indexes for Performance Optimization
CREATE INDEX idx_properties_host_id ON Properties(host_id);
CREATE INDEX idx_properties_location_id ON Properties(location_id);
CREATE INDEX idx_bookings_guest_id ON Bookings(guest_id);
CREATE INDEX idx_bookings_property_id ON Bookings(property_id);
CREATE INDEX idx_reviews_property_id ON Reviews(property_id);