-- RESET DATABASE
DROP DATABASE IF EXISTS hotel_db;
CREATE DATABASE hotel_db;
USE hotel_db;

-- USERS TABLE
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(20),
    mail_id VARCHAR(100),
    billing_address TEXT
);

-- BOOKINGS TABLE
CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50)
);

-- ITEMS TABLE
CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);

-- BOOKING COMMERCIALS TABLE
CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2)
);

-- USERS DATA (REALISTIC)
INSERT INTO users VALUES
('usr_a1','Aarav Sharma','9876543210','aarav.sharma@gmail.com','Bangalore'),
('usr_b2','Emily Johnson','9123456780','emily.johnson@gmail.com','New York'),
('usr_c3','Riya Patel','9988776655','riya.patel@gmail.com','Ahmedabad'),
('usr_d4','Michael Brown','9871234567','michael.brown@gmail.com','London'),
('usr_e5','Arjun Reddy','9001122334','arjun.reddy@gmail.com','Hyderabad'),
('usr_f6','Sophia Wilson','9112233445','sophia.wilson@gmail.com','Sydney'),
('usr_g7','Neha Kapoor','9223344556','neha.kapoor@gmail.com','Delhi'),
('usr_h8','David Miller','9334455667','david.miller@gmail.com','Toronto');

-- BOOKINGS DATA (MATCHING USER IDs)
INSERT INTO bookings VALUES
('bk101','2021-11-10 10:00:00','r101','usr_a1'),
('bk102','2021-11-15 12:00:00','r102','usr_a1'),
('bk103','2021-10-05 09:00:00','r103','usr_b2'),
('bk104','2021-09-20 14:00:00','r104','usr_c3'),
('bk105','2021-11-18 16:00:00','r105','usr_d4'),
('bk106','2021-08-11 11:00:00','r106','usr_e5'),
('bk107','2021-07-25 18:00:00','r107','usr_f6'),
('bk108','2021-11-22 20:00:00','r108','usr_g7');

-- ITEMS DATA
INSERT INTO items VALUES
('i1','Tawa Paratha',20),
('i2','Mix Veg',100),
('i3','Paneer Butter Masala',180),
('i4','Dal Fry',120),
('i5','Jeera Rice',90),
('i6','Roti',10),
('i7','Chicken Curry',250),
('i8','Veg Biryani',200);

-- BOOKING COMMERCIALS DATA (CONSISTENT)
INSERT INTO booking_commercials VALUES
('c1','bk101','bill1','2021-11-10','i1',2),
('c2','bk101','bill1','2021-11-10','i2',1),
('c3','bk102','bill2','2021-11-15','i3',2),
('c4','bk102','bill2','2021-11-15','i6',10),
('c5','bk103','bill3','2021-10-05','i7',5), -- ensures >1000 for Q3
('c6','bk104','bill4','2021-09-20','i4',2),
('c7','bk105','bill5','2021-11-18','i8',1),
('c8','bk106','bill6','2021-08-11','i5',2),
('c9','bk107','bill7','2021-07-25','i2',4),
('c10','bk108','bill8','2021-11-22','i3',1);