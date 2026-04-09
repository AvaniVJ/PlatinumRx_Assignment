-- RESET DATABASE (with correct collation)
DROP DATABASE IF EXISTS clinic_db;
CREATE DATABASE clinic_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE clinic_db;

-- CLINICS TABLE
CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CUSTOMERS TABLE
CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(20)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CLINIC SALES TABLE
CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime DATETIME,
    sales_channel VARCHAR(50)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- EXPENSES TABLE
CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(100),
    amount DECIMAL(10,2),
    datetime DATETIME
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CLINICS DATA
INSERT INTO clinics VALUES
('c1','Apollo Clinic','Bangalore','Karnataka','India'),
('c2','Fortis Health','Delhi','Delhi','India'),
('c3','Care Hospital','Hyderabad','Telangana','India'),
('c4','AIIMS','Delhi','Delhi','India'),
('c5','Manipal Clinic','Bangalore','Karnataka','India');

-- CUSTOMERS DATA
INSERT INTO customer VALUES
('u1','Aarav Sharma','9876543210'),
('u2','Riya Patel','9988776655'),
('u3','Arjun Reddy','9001122334'),
('u4','Neha Kapoor','9223344556'),
('u5','Emily Johnson','9123456780'),
('u6','Michael Brown','9871234567'),
('u7','Rahul Verma','9012345678'),
('u8','Priya Nair','9023456789'),
('u9','Karan Mehta','9034567890'),
('u10','Anjali Singh','9045678901'),
('u11','Rohit Gupta','9056789012'),
('u12','Sneha Iyer','9067890123'),
('u13','Vikram Joshi','9078901234'),
('u14','Pooja Desai','9089012345'),
('u15','Amit Shah','9090123456'),
('u16','Simran Kaur','9101234567'),
('u17','Daniel Lee','9112345678'),
('u18','Olivia Martin','9123456781'),
('u19','Ethan Clark','9134567812'),
('u20','Isabella Scott','9145678123');

-- SALES DATA
INSERT INTO clinic_sales VALUES
('o1','u1','c1',2000,'2021-09-10','online'),
('o2','u2','c1',1500,'2021-09-12','offline'),
('o3','u3','c2',3000,'2021-09-15','online'),
('o4','u4','c2',2500,'2021-09-18','offline'),
('o5','u5','c3',4000,'2021-10-10','online'),
('o6','u6','c3',3500,'2021-10-12','offline'),
('o7','u1','c4',2800,'2021-09-20','online'),
('o8','u2','c5',3200,'2021-09-22','offline'),
('o9','u7','c1',1800,'2021-09-05','online'),
('o10','u8','c2',2200,'2021-09-07','offline'),
('o11','u9','c3',2600,'2021-09-09','online'),
('o12','u10','c4',3000,'2021-09-11','offline'),
('o13','u11','c5',2800,'2021-09-13','online'),
('o14','u12','c1',2400,'2021-09-14','offline'),
('o15','u13','c2',3200,'2021-09-16','online'),
('o16','u14','c3',3500,'2021-09-17','offline'),
('o17','u15','c4',3700,'2021-09-19','online'),
('o18','u16','c5',3900,'2021-09-21','offline'),
('o19','u17','c1',4100,'2021-09-23','online'),
('o20','u18','c2',4300,'2021-09-25','offline'),
('o21','u19','c3',4500,'2021-09-27','online'),
('o22','u20','c4',4700,'2021-09-29','offline');

-- EXPENSES DATA
INSERT INTO expenses VALUES
('e1','c1','Medicines',500,'2021-09-10'),
('e2','c1','Staff Salary',700,'2021-09-12'),
('e3','c2','Equipment',1200,'2021-09-15'),
('e4','c2','Maintenance',800,'2021-09-18'),
('e5','c3','Supplies',1000,'2021-10-10'),
('e6','c3','Staff',900,'2021-10-12'),
('e7','c4','Electricity',600,'2021-09-20'),
('e8','c5','Cleaning',400,'2021-09-22');