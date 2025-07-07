-- ALX Airbnb Database Seeding
-- This script populates the database with realistic sample data.

-- Start with lookup tables that have no dependencies
INSERT INTO Locations (city, country) VALUES
('Paris', 'France'),
('Tokyo', 'Japan'),
('New York', 'USA'),
('Marrakech', 'Morocco');

INSERT INTO Amenities (name) VALUES
('Wi-Fi'),
('Air Conditioning'),
('Pool'),
('Kitchen'),
('Free Parking'),
('Washing Machine');

-- Insert Users (some will be hosts, some guests)
INSERT INTO Users (first_name, last_name, email, password_hash, phone_number) VALUES
('Amine', 'El-Fassi', 'amine.elfassi@email.com', 'hash123', '212612345678'),
('Yuki', 'Tanaka', 'yuki.tanaka@email.com', 'hash456', '819012345678'),
('John', 'Smith', 'john.smith@email.com', 'hash789', '12125550123'),
('Fatima', 'Zahra', 'fatima.zahra@email.com', 'hash101', '212698765432');

-- Insert Properties linked to Users and Locations
-- User 1 (Amine) is a host in Marrakech
INSERT INTO Properties (host_id, location_id, title, description, property_type, price_per_night, max_guests, bedrooms, bathrooms) VALUES
(1, 4, 'Stunning Riad in Medina', 'Experience authentic Moroccan life in this beautiful Riad with a central courtyard.', 'Riad', 1250.00, 6, 3, 3.0),
-- User 2 (Yuki) is a host in Tokyo
(2, 2, 'Modern Shibuya Crossing Apt', 'A sleek apartment with incredible views of Shibuya. Perfect for city explorers.', 'Apartment', 25000.00, 2, 1, 1.0),
-- User 1 (Amine) has another property
(1, 1, 'Charming Flat near Eiffel Tower', 'A cozy flat just a short walk from the Eiffel Tower. Ideal for couples.', 'Apartment', 180.00, 2, 1, 1.0),
-- User 3 (John) is a host in New York
(3, 3, 'Spacious Loft in Brooklyn', 'An open-plan loft in a vibrant Brooklyn neighborhood, great for artists and creatives.', 'Loft', 210.00, 4, 2, 2.0);

-- Link Amenities to Properties
-- Riad in Marrakech (ID 1)
INSERT INTO Property_Amenities (property_id, amenity_id) VALUES (1, 1), (1, 2), (1, 3), (1, 4); -- Wi-Fi, AC, Pool, Kitchen
-- Shibuya Apt (ID 2)
INSERT INTO Property_Amenities (property_id, amenity_id) VALUES (2, 1), (2, 2), (2, 4), (2, 6); -- Wi-Fi, AC, Kitchen, Washing Machine
-- Paris Flat (ID 3)
INSERT INTO Property_Amenities (property_id, amenity_id) VALUES (3, 1), (3, 4), (3, 6); -- Wi-Fi, Kitchen, Washing Machine
-- Brooklyn Loft (ID 4)
INSERT INTO Property_Amenities (property_id, amenity_id) VALUES (4, 1), (4, 2), (4, 5); -- Wi-Fi, AC, Free Parking

-- Insert Bookings
-- User 4 (Fatima) books the Riad in Marrakech (Property 1)
INSERT INTO Bookings (guest_id, property_id, check_in_date, check_out_date, total_price) VALUES
(4, 1, '2025-08-10', '2025-08-15', 6250.00);
-- User 3 (John) books the Tokyo apartment (Property 2)
INSERT INTO Bookings (guest_id, property_id, check_in_date, check_out_date, total_price, status) VALUES
(3, 2, '2025-09-01', '2025-09-08', 175000.00, 'Completed');
-- User 2 (Yuki) books John's Brooklyn Loft (Property 4)
INSERT INTO Bookings (guest_id, property_id, check_in_date, check_out_date, total_price) VALUES
(2, 4, '2025-07-20', '2025-07-25', 1050.00);

-- Insert Reviews and Payments for completed bookings
-- Review for Booking ID 2 (John's stay in Tokyo)
INSERT INTO Reviews (booking_id, guest_id, property_id, rating, comment) VALUES
(2, 3, 2, 5, 'Absolutely amazing location and a beautiful, clean apartment. Yuki was a fantastic host. Highly recommend!');
-- Payment for Booking ID 2
INSERT INTO Payments (booking_id, amount, status) VALUES
(2, 175000.00, 'Completed');

-- Payment for Booking ID 1 (Fatima's upcoming stay)
INSERT INTO Payments (booking_id, amount, status) VALUES
(1, 6250.00, 'Completed');
-- Payment for Booking ID 3 (Yuki's upcoming stay)
INSERT INTO Payments (booking_id, amount, status) VALUES
(3, 1050.00, 'Completed');