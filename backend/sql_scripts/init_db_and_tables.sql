CREATE DATABASE IF NOT EXISTS MYVC;
USE MYVC;

DROP TABLE IF EXISTS Payments, FamilyRelationships, ClubMembers, FamilyMembers, PersonnelLocation, Personnel, Locations;

-- Locations table
CREATE TABLE Locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    type ENUM('Head', 'Branch') NOT NULL,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    phone_number VARCHAR(15),
    web_address VARCHAR(255),
    max_capacity INT NOT NULL
);

-- Personnel table
CREATE TABLE Personnel (
    personnel_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    ssn CHAR(9) UNIQUE NOT NULL,
    medicare_card_number CHAR(12) UNIQUE NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    role ENUM('Administrator', 'Captain', 'Coach', 'Assistant Coach', 'Other') NOT NULL,
    mandate ENUM('Volunteer', 'Salaried') NOT NULL,
    location_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

-- Family Members table
CREATE TABLE FamilyMembers (
    family_member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    ssn CHAR(9) UNIQUE NOT NULL,
    medicare_card_number CHAR(12) UNIQUE NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    location_id INT NOT NULL,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

-- Club Members table
CREATE TABLE ClubMembers (
    membership_number INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    height FLOAT,
    weight FLOAT,
    ssn CHAR(9) UNIQUE NOT NULL,
    medicare_card_number CHAR(12) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    family_member_id INT NOT NULL,
    FOREIGN KEY (family_member_id) REFERENCES FamilyMembers(family_member_id),
    CHECK (TIMESTAMPDIFF(YEAR, dob, CURDATE()) BETWEEN 11 AND 18)
);

-- Payments table
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    membership_number INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Cash', 'Debit', 'Credit') NOT NULL,
    year_of_payment YEAR NOT NULL,
    FOREIGN KEY (membership_number) REFERENCES ClubMembers(membership_number)
);

-- Family Relationships table to store the relationship between Family Members and Club Members
CREATE TABLE FamilyRelationships (
    family_member_id INT NOT NULL,
    club_member_id INT NOT NULL,
    relationship ENUM('Father', 'Mother', 'Grandfather', 'Grandmother', 'Tutor', 'Partner', 'Friend', 'Other') NOT NULL,
    PRIMARY KEY (family_member_id, club_member_id),
    FOREIGN KEY (family_member_id) REFERENCES FamilyMembers(family_member_id),
    FOREIGN KEY (club_member_id) REFERENCES ClubMembers(membership_number)
);

-- Trigger for checking the age of club members before insertion
DELIMITER //

CREATE TRIGGER before_insert_club_members
BEFORE INSERT ON ClubMembers
FOR EACH ROW
BEGIN
    IF TIMESTAMPDIFF(YEAR, NEW.dob, CURDATE()) NOT BETWEEN 11 AND 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Age must be between 11 and 18 years old';
    END IF;
END //

DELIMITER ;
