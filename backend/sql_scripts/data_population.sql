INSERT INTO Locations (type, name, address, city, province, postal_code, phone_number, web_address, max_capacity)
VALUES 
    ('Branch', 'Laval Volleyball Center', '150 Laurent Blvd', 'Laval', 'QC', 'H7N 4Y5', '450-222-6789', 'www.lavalvc.ca', 275),
    ('Branch', 'Longueuil Volleyball Club', '321 Birch St', 'Longueuil', 'QC', 'J4H 1A3', '450-123-5678', 'www.longueuilvc.ca', 320),
    ('Branch', 'Quebec City Volleyball Club', '888 Royal Ave', 'Quebec City', 'QC', 'G1R 5P6', '418-555-9876', 'www.qcvc.ca', 350),
    ('Branch', 'Ottawa Volleyball Center', '200 Parliament Rd', 'Ottawa', 'ON', 'K1A 0A9', '613-999-1234', 'www.ottawavc.ca', 400),
    ('Branch', 'Sherbrooke Volleyball Hub', '55 University St', 'Sherbrooke', 'QC', 'J1K 2R1', '819-777-5678', 'www.sherbrookevc.ca', 280);

INSERT INTO FamilyMembers (first_name, last_name, dob, ssn, medicare_card_number, phone_number, address, city, province, postal_code, email, location_id)
VALUES 
    ('Robert', 'Johnson', '1978-11-12', '345678901', 'MC3456789012', '514-666-4321', '789 Cedar Rd', 'Montreal', 'QC', 'H2X 1L5', 'robertj@example.com', 1),
    ('Emily', 'Davis', '1985-02-17', '456789012', 'MC4567890123', '450-777-8888', '901 Spruce St', 'Laval', 'QC', 'H7L 2N6', 'emilyd@example.com', 2),
    ('Henry', 'Miller', '1982-06-29', '567890124', 'MC5678901245', '418-555-4321', '1025 Old Town Rd', 'Quebec City', 'QC', 'G1K 3B2', 'henrym@example.com', 3),
    ('Olivia', 'White', '1979-09-14', '678901235', 'MC6789012356', '613-333-7654', '202 Maple Dr', 'Ottawa', 'ON', 'K2P 1M1', 'oliviaw@example.com', 4),
    ('James', 'Taylor', '1983-11-30', '789012346', 'MC7890123467', '819-222-8888', '777 Lake Ave', 'Sherbrooke', 'QC', 'J1H 4M5', 'jamest@example.com', 5);

INSERT INTO ClubMembers (first_name, last_name, dob, height, weight, ssn, medicare_card_number, phone_number, address, city, province, postal_code, family_member_id)
VALUES 
    ('Jake', 'Johnson', '2011-04-22', 168, 62, '765432109', 'MC7654321098', '514-444-7777', '789 Cedar Rd', 'Montreal', 'QC', 'H2X 1L5', 3),
    ('Sophia', 'Davis', '2013-07-18', 160, 58, '654321098', 'MC6543210987', '450-555-9999', '901 Spruce St', 'Laval', 'QC', 'H7L 2N6', 4),
    ('Lucas', 'Miller', '2012-05-10', 172, 64, '543210987', 'MC5432109876', '418-444-2222', '1025 Old Town Rd', 'Quebec City', 'QC', 'G1K 3B2', 5),
    ('Emma', 'White', '2010-12-02', 165, 60, '432109876', 'MC4321098765', '613-222-5555', '202 Maple Dr', 'Ottawa', 'ON', 'K2P 1M1', 3),
    ('Noah', 'Taylor', '2011-09-25', 169, 63, '321098765', 'MC3210987654', '819-666-4444', '777 Lake Ave', 'Sherbrooke', 'QC', 'J1H 4M5',2);

INSERT INTO Personnel (first_name, last_name, dob, ssn, medicare_card_number, phone_number, address, city, province, postal_code, email, role, mandate)
VALUES 
    ('Michael', 'Brown', '1982-10-05', '567890123', 'MC5678901234', '514-777-1122', '345 Oak Ave', 'Montreal', 'QC', 'H3C 2K7', 'michaelb@example.com', 'Coach', 'Salaried'),
    ('Jessica', 'Wilson', '1990-03-14', '678901234', 'MC6789012345', '450-888-2233', '678 Willow Ln', 'Brossard', 'QC', 'J4Y 2Z3', 'jessicaw@example.com', 'Assistant Coach', 'Volunteer'),
    ('Daniel', 'Harris', '1975-07-20', '789012345', 'MC7890123456', '418-555-3333', '999 River Rd', 'Quebec City', 'QC', 'G1A 4R5', 'danielh@example.com', 'Administrator', 'Salaried'),
    ('Anna', 'Clark', '1988-08-08', '890123456', 'MC8901234567', '613-123-4444', '555 Downtown St', 'Ottawa', 'ON', 'K1P 3J2', 'annac@example.com', 'Coach', 'Volunteer'),
    ('Ryan', 'Martinez', '1992-05-15', '901234567', 'MC9012345678', '819-555-7777', '222 Forest Ave', 'Sherbrooke', 'QC', 'J1G 5N8', 'ryanm@example.com', 'Captain', 'Salaried');

INSERT INTO Payments (membership_number, payment_date, amount, payment_method, year_of_payment)
VALUES 
    (1, '2024-01-15', 150.00, 'Credit', 2024),
    (2, '2024-02-10', 120.00, 'Debit', 2024),
    (3, '2023-12-20', 130.00, 'Cash', 2023),
    (4, '2024-01-25', 140.00, 'Credit', 2024),
    (5, '2024-02-05', 135.00, 'Debit', 2024),
    (1, '2023-11-30', 125.00, 'Cash', 2023),
    (2, '2024-01-12', 145.00, 'Credit', 2024),
    (3, '2024-02-14', 155.00, 'Debit', 2024),
    (4, '2024-01-29', 160.00, 'Credit', 2024),
    (5, '2023-12-18', 128.00, 'Cash', 2023);
