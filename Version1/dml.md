SELECT * FROM Payments;
SELECT * FROM ClubMembers_Teams;
SELECT * FROM Teams;
SELECT * FROM Memberships;
SELECT * FROM ClubMembers;
SELECT * FROM FamilyMembers;
SELECT * FROM Personnel_Assignments;
SELECT * FROM Personnel;
SELECT * FROM CommonInfo;
SELECT * FROM Locations;
SELECT * FROM Period;
SELECT * FROM SessionTypes;
SELECT * FROM PlayerRoles;
SELECT * FROM TeamFormations;
SELECT * FROM TeamFormationPlayers;
SELECT * FROM EmailLogs;
SELECT * FROM SecondaryFamilyMembers;
SELECT * FROM ClubMembers_Locations;


-- Insert Locations into the Locations table
INSERT INTO Locations (Type, Name, Address, City, Province, PostalCode, PhoneNumber, MaxCapacity)
VALUES
  ('Head', 'Montreal Downtown', '123 Montreal Downtown St.', 'Montreal', 'QC', 'Q1X 806', '514-555-5079', 98),
  ('Branch', 'Plateau Mont-Royal', '123 Plateau Mont-Royal St.', 'Montreal', 'QC', 'Q3T 611', '514-555-8635', 118),
  ('Branch', 'Outremont', '123 Outremont St.', 'Montreal', 'QC', 'Q4C 725', '514-555-7097', 85),
  ('Branch', 'Villeray', '123 Villeray St.', 'Montreal', 'QC', 'Q1D 911', '514-555-7800', 151),
  ('Branch', 'Verdun', '123 Verdun St.', 'Montreal', 'QC', 'Q6W 197', '514-555-6117', 192),
  ('Branch', 'Ahuntsic-Cartierville', '123 Ahuntsic-Cartierville St.', 'Montreal', 'QC', 'Q6F 530', '514-555-2408', 150),
  ('Branch', 'Rosemont', '123 Rosemont St.', 'Montreal', 'QC', 'Q7C 738', '514-555-6681', 160),
  ('Branch', 'Hochelaga-Maisonneuve', '123 Hochelaga-Maisonneuve St.', 'Montreal', 'QC', 'Q5O 169', '514-555-2704', 54),
  ('Branch', 'Côte-des-Neiges', '123 Côte-des-Neiges St.', 'Montreal', 'QC', 'Q4F 533', '514-555-7724', 86),
  ('Branch', 'Saint-Laurent', '123 Saint-Laurent St.', 'Montreal', 'QC', 'Q4I 409', '514-555-4867', 120);


INSERT INTO CommonInfo (FirstName, LastName, DateOfBirth, SSN, MedicareCardNumber, PhoneNumber, Email, Address, City, Province, PostalCode)
VALUES
  ('John', 'Doe', '1985-04-23', '000000001', 'MCN000001', '514-555-0101', 'john.doe@example.com', '123 Elm St.', 'Montreal', 'QC', 'H3A 1B2'),
  ('Jane', 'Smith', '1992-06-10', '000000002', 'MCN000002', '514-555-0102', 'jane.smith@example.com', '456 Maple St.', 'Montreal', 'QC', 'H2X 2Y3'),
  ('Emily', 'Johnson', '1990-02-15', '000000003', 'MCN000003', '514-555-0103', 'emily.jhnson@example.com', '789 Oak St.', 'Montreal', 'QC', 'H4A 3C4'),
  ('Michael', 'Williams', '1987-11-30', '000000004', 'MCN000004', '514-555-0104', 'michael.williams@example.com', '101 Pine St.', 'Montreal', 'QC', 'H5B 4D5'),
  ('Sarah', 'Brown', '1988-07-22', '000000005', 'MCN000005', '514-555-0105', 'sarah.brown@example.com', '202 Cedar St.', 'Montreal', 'QC', 'H6C 5E6'),
  ('James', 'Davis', '1984-01-10', '000000006', 'MCN000006', '514-555-0106', 'james.davis@example.com', '303 Birch St.', 'Montreal', 'QC', 'H7D 6F7'),
  ('Olivia', 'Martinez', '1995-09-18', '000000007', 'MCN000007', '514-555-0107', 'olivia.martinez@example.com', '404 Ash St.', 'Montreal', 'QC', 'H8E 7G8'),
  ('David', 'Garcia', '1989-03-07', '000000008', 'MCN000008', '514-555-0108', 'david.garcia@example.com', '505 Fir St.', 'Montreal', 'QC', 'H9F 8H9'),
  ('Sophia', 'Rodriguez', '1991-05-25', '000000009', 'MCN000009', '514-555-0109', 'sophia.rodriguez@example.com', '606 Willow St.', 'Montreal', 'QC', 'H0G 9I0'),
  ('Daniel', 'Martinez', '1983-12-12', '000000010', 'MCN000010', '514-555-0110', 'daniel.martinez@example.com', '707 Redwood St.', 'Montreal', 'QC', 'H1J 0K1'),
  ('Liam', 'Lopez', '1993-08-30', '000000011', 'MCN000011', '514-555-0111', 'liam.lopez@example.com', '808 Maple St.', 'Montreal', 'QC', 'H2K 1L2'),
  ('Ava', 'Miller', '1996-11-14', '000000012', 'MCN000012', '514-555-0112', 'ava.miller@example.com', '909 Elm St.', 'Montreal', 'QC', 'H3L 2M3'),
  ('Mason', 'Wilson', '1981-03-21', '000000013', 'MCN000013', '514-555-0113', 'mason.wilson@example.com', '101 Birch St.', 'Montreal', 'QC', 'H4M 3N4'),
  ('Isabella', 'Taylor', '1998-05-07', '000000014', 'MCN000014', '514-555-0114', 'isabella.taylor@example.com', '202 Cedar St.', 'Montreal', 'QC', 'H5O 4P5'),
  ('Ethan', 'Anderson', '1990-09-01', '000000015', 'MCN000015', '514-555-0115', 'ethan.anderson@example.com', '303 Ash St.', 'Montreal', 'QC', 'H6Q 5R6'),
  ('Charlotte', 'Thomas', '1985-12-23', '000000016', 'MCN000016', '514-555-0116', 'charlotte.thomas@example.com', '404 Redwood St.', 'Montreal', 'QC', 'H7S 6T7'),
  ('Benjamin', 'Jackson', '1992-02-17', '000000017', 'MCN000017', '514-555-0117', 'benjamin.jackson@example.com', '505 Pine St.', 'Montreal', 'QC', 'H8U 7V8'),
  ('Amelia', 'White', '1989-08-11', '000000018', 'MCN000018', '514-555-0118', 'amelia.white@example.com', '606 Fir St.', 'Montreal', 'QC', 'H9W 8X9'),
  ('Lucas', 'Harris', '1994-07-13', '000000019', 'MCN000019', '514-555-0119', 'lucas.harris@example.com', '707 Oak St.', 'Montreal', 'QC', 'H0Y 9Z0'),
  ('Harper', 'Clark', '1991-10-29', '000000020', 'MCN000020', '514-555-0120', 'harper.clark@example.com', '808 Maple St.', 'Montreal', 'QC', 'H1A 0B1'),
  ('Jackson', 'Lewis', '1996-03-04', '000000021', 'MCN000021', '514-555-0121', 'jackson.lewis@example.com', '909 Birch St.', 'Montreal', 'QC', 'H2B 1C2'),
  ('Ella', 'Young', '1997-06-17', '000000022', 'MCN000022', '514-555-0122', 'ella.young@example.com', '101 Cedar St.', 'Montreal', 'QC', 'H3C 2D3'),
  ('Logan', 'Allen', '1994-12-01', '000000023', 'MCN000023', '514-555-0123', 'logan.allen@example.com', '202 Ash St.', 'Montreal', 'QC', 'H4D 3E4'),
  ('Mia', 'King', '1992-11-09', '000000024', 'MCN000024', '514-555-0124', 'mia.king@example.com', '303 Oak St.', 'Montreal', 'QC', 'H5E 4F5'),
  ('Sebastian', 'Scott', '1990-04-18', '000000025', 'MCN000025', '514-555-0125', 'sebastian.scott@example.com', '404 Maple St.', 'Montreal', 'QC', 'H6F 5G6'),
  ('Zoe', 'Adams', '1988-02-22', '000000026', 'MCN000026', '514-555-0126', 'zoe.adams@example.com', '505 Birch St.', 'Montreal', 'QC', 'H7G 6H7'),
  ('Elijah', 'Nelson', '1985-09-13', '000000027', 'MCN000027', '514-555-0127', 'elijah.nelson@example.com', '606 Pine St.', 'Montreal', 'QC', 'H8I 7J7'),
  ('Lily', 'Carter', '1993-12-08', '000000028', 'MCN000028', '514-555-0128', 'lily.carter@example.com', '707 Fir St.', 'Montreal', 'QC', 'H9J 8K8'),
  ('Jacob', 'Mitchell', '1986-05-14', '000000029', 'MCN000029', '514-555-0129', 'jacob.mitchell@example.com', '808 Redwood St.', 'Montreal', 'QC', 'H0K 9L9'),
  ('Madison', 'Perez', '1990-07-27', '000000030', 'MCN000030', '514-555-0130', 'madison.perez@example.com', '909 Fir St.', 'Montreal', 'QC', 'H1L 0M0'),
  ('William', 'Roberts', '1992-10-03', '000000031', 'MCN000031', '514-555-0131', 'william.roberts@example.com', '101 Redwood St.', 'Montreal', 'QC', 'H2M 1N1'),
  ('Chloe', 'Hernandez', '1989-12-19', '000000032', 'MCN000032', '514-555-0132', 'chloe.hernandez@example.com', '202 Pine St.', 'Montreal', 'QC', 'H3N 2O2'),
  ('Henry', 'Baker', '1995-05-02', '000000033', 'MCN000033', '514-555-0133', 'henry.baker@example.com', '303 Redwood St.', 'Montreal', 'QC', 'H4O 3P3'),
  ('Scarlett', 'Gonzalez', '1987-04-11', '000000034', 'MCN000034', '514-555-0134', 'scarlett.gonzalez@example.com', '404 Ash St.', 'Montreal', 'QC', 'H5P 4Q4'),
  ('Jack', 'Murphy', '1994-09-17', '000000035', 'MCN000035', '514-555-0135', 'jack.murphy@example.com', '505 Cedar St.', 'Montreal', 'QC', 'H6Q 5R5'),
  ('Grace', 'Rivera', '1991-03-14', '000000036', 'MCN000036', '514-555-0136', 'grace.rivera@example.com', '606 Oak St.', 'Montreal', 'QC', 'H7R 6S6'),
  ('Wyatt', 'Cooper', '1983-06-29', '000000037', 'MCN000037', '514-555-0137', 'wyatt.cooper@example.com', '707 Birch St.', 'Montreal', 'QC', 'H8S 7T7');
INSERT INTO CommonInfo (FirstName, LastName, DateOfBirth, SSN, MedicareCardNumber, PhoneNumber, Email, Address, City, Province, PostalCode)
VALUES
  ('Samuel', 'Reed', '1990-01-21', '000000041', 'MCN000041', '514-555-0138', 'samuel.reed@example.com', '808 Birch St.', 'Montreal', 'QC', 'H1A 1A1'),
  ('Avery', 'King', '1986-04-09', '000000042', 'MCN000042', '514-555-0139', 'avery.king@example.com', '909 Cedar St.', 'Montreal', 'QC', 'H2A 2B2'),
  ('Lucas', 'Martinez', '1993-07-15', '000000043', 'MCN000043', '514-555-0140', 'lucas.martinez@example.com', '101 Oak St.', 'Montreal', 'QC', 'H3A 3C3'),
  ('Mason', 'Harris', '2007-11-22', '000000044', 'MCN000044', '514-555-0141', 'mason.harris@example.com', '202 Ash St.', 'Montreal', 'QC', 'H4B 4D4'),
('Ella', 'Young', '2007-06-08', '000000045', 'MCN000045', '514-555-0142', 'ella.young@example.com', '303 Redwood St.', 'Montreal', 'QC', 'H5C 5E5'),
('Grace', 'Hall', '2007-01-18', '000000046', 'MCN000046', '514-555-0143', 'grace.hall@example.com', '404 Pine St.', 'Montreal', 'QC', 'H6D 6F6'),
('Ryan', 'Allen', '2006-05-11', '000000047', 'MCN000047', '514-555-0144', 'ryan.allen@example.com', '505 Oak St.', 'Montreal', 'QC', 'H7E 7G7'),
('Natalie', 'Thomas', '2007-02-28', '000000048', 'MCN000048', '514-555-0145', 'natalie.thomas@example.com', '606 Birch St.', 'Montreal', 'QC', 'H8F 8H8'),
('Tyler', 'White', '2006-12-03', '000000049', 'MCN000049', '514-555-0146', 'tyler.white@example.com', '707 Redwood St.', 'Montreal', 'QC', 'H9G 9I9'),
('Chloe', 'Lopez', '2006-10-24', '000000050', 'MCN000050', '514-555-0147', 'chloe.lopez@example.com', '808 Pine St.', 'Montreal', 'QC', 'H0H 1J1'),
('Alexander', 'Clark', '2006-09-13', '000000051', 'MCN000051', '514-555-0148', 'alexander.clark@example.com', '909 Ash St.', 'Montreal', 'QC', 'H1J 2K2'),
('Lily', 'Allen', '2007-03-20', '000000052', 'MCN000052', '514-555-0149', 'lily.allen@example.com', '101 Redwood St.', 'Montreal', 'QC', 'H2K 3L3'),
('Jack', 'Lopez', '2007-08-09', '000000053', 'MCN000053', '514-555-0150', 'jack.lopez@example.com', '202 Oak St.', 'Montreal', 'QC', 'H3L 4M4'),
('Mia', 'Miller', '2007-01-22', '000000054', 'MCN000054', '514-555-0151', 'mia.miller@example.com', '303 Cedar St.', 'Montreal', 'QC', 'H4N 5O5'),
('Sophie', 'Roberts', '2006-07-15', '000000055', 'MCN000055', '514-555-0152', 'sophie.roberts@example.com', '404 Redwood St.', 'Montreal', 'QC', 'H5P 6Q6'),
('Owen', 'Morris', '2006-06-29', '000000056', 'MCN000056', '514-555-0153', 'owen.morris@example.com', '505 Pine St.', 'Montreal', 'QC', 'H6Q 7R7'),
('Amelia', 'Jackson', '2007-11-30', '000000057', 'MCN000057', '514-555-0154', 'amelia.jackson@example.com', '606 Cedar St.', 'Montreal', 'QC', 'H7R 8S8'),
('James', 'Wilson', '2006-04-18', '000000058', 'MCN000058', '514-555-0155', 'james.wilson@example.com', '707 Oak St.', 'Montreal', 'QC', 'H8S 9T9'),
('Zoe', 'Lee', '2006-08-17', '000000059', 'MCN000059', '514-555-0156', 'zoe.lee@example.com', '808 Cedar St.', 'Montreal', 'QC', 'H9T 0U0'),
('Ethan', 'King', '2007-02-26', '000000060', 'MCN000060', '514-555-0157', 'ethan.king@example.com', '909 Pine St.', 'Montreal', 'QC', 'H0U 1V1');

INSERT INTO CommonInfo (FirstName, LastName, DateOfBirth, SSN, MedicareCardNumber, PhoneNumber, Email, Address, City, Province, PostalCode) VALUES
('John', 'Doe', '2007-05-12', '123456789', 'A123456789', '514-123-4567', 'john.doe@example.com', '123 Maple St', 'Montreal', 'QC', 'H1A 2B3'),
('Jane', 'Smith', '2006-07-22', '234567890', 'B987654321', '438-456-7890', 'jane.smith@example.com', '456 Pine St', 'Laval', 'QC', 'H2C 3D4'),
('Alice', 'Johnson', '2007-03-15', '345678901', 'C567890123', '514-678-1234', 'alice.johnson@example.com', '789 Oak St', 'Montreal', 'QC', 'H3E 4F5'),
('Bob', 'Williams', '2006-11-02', '456789012', 'D456789012', '450-789-4561', 'bob.williams@example.com', '101 Birch St', 'Longueuil', 'QC', 'J4G 5H6'),
('Charlie', 'Brown', '2006-06-30', '567890123', 'E345678901', '514-890-5678', 'charlie.brown@example.com', '202 Elm St', 'Montreal', 'QC', 'H5I 6J7'),
('David', 'Taylor', '2007-12-20', '678901234', 'F234567890', '514-901-6789', 'david.taylor@example.com', '303 Cedar St', 'Brossard', 'QC', 'J5K 7L8'),
('Eve', 'Anderson', '2006-04-10', '789012345', 'G123456789', '438-012-3456', 'eve.anderson@example.com', '404 Spruce St', 'Montreal', 'QC', 'H6L 8M9'),
('Frank', 'Thomas', '2006-09-15', '890123456', 'H098765432', '514-123-6789', 'frank.thomas@example.com', '505 Willow St', 'Laval', 'QC', 'H7N 9P0'),
('Grace', 'Harris', '2006-01-25', '901234567', 'I876543210', '514-234-7890', 'grace.harris@example.com', '606 Chestnut St', 'Montreal', 'QC', 'H8O 1P1'),
('Henry', 'Martin', '2006-05-05', '123345678', 'J765432109', '514-345-8901', 'henry.martin@example.com', '707 Redwood St', 'Longueuil', 'QC', 'J9P 2Q3'),
('Isabel', 'Clark', '2006-07-14', '234456789', 'K654321098', '514-456-9012', 'isabel.clark@example.com', '808 Poplar St', 'Montreal', 'QC', 'H0R 3S4'),
('Jack', 'Lee', '2006-08-24', '345567890', 'L543210987', '450-567-0123', 'jack.lee@example.com', '909 Ash St', 'Brossard', 'QC', 'J1T 4U5'),
('Kelly', 'Adams', '2006-02-28', '456678901', 'M432109876', '514-678-1234', 'kelly.adams@example.com', '1010 Fir St', 'Laval', 'QC', 'H2V 5W6'),
('Liam', 'Moore', '1999-10-10', '567789012', 'N321098765', '438-789-4567', 'liam.moore@example.com', '1111 Aspen St', 'Montreal', 'QC', 'H3X 6Y7'),
('Mia', 'Walker', '1989-12-31', '678890123', 'O210987654', '514-890-5678', 'mia.walker@example.com', '1212 Hemlock St', 'Longueuil', 'QC', 'J4Y 7Z8'),
('Nathan', 'Hall', '1977-03-13', '789901234', 'P109876543', '450-901-6789', 'nathan.hall@example.com', '1313 Alder St', 'Montreal', 'QC', 'H5Z 8A9'),
('Olivia', 'Scott', '2001-11-11', '890012345', 'Q987654321', '514-012-3456', 'olivia.scott@example.com', '1414 Maple St', 'Laval', 'QC', 'H7B 1C0'),
('Paul', 'Evans', '1986-06-06', '901123456', 'R876543210', '514-123-4567', 'paul.evans@example.com', '1515 Birch St', 'Montreal', 'QC', 'H8C 2D1'),
('Quinn', 'Hill', '1991-09-09', '123234567', 'S765432109', '438-234-5678', 'quinn.hill@example.com', '1616 Pine St', 'Longueuil', 'QC', 'J9E 3F2'),
('Ruby', 'Green', '1982-02-02', '234345678', 'T654321098', '514-345-6789', 'ruby.green@example.com', '1717 Oak St', 'Montreal', 'QC', 'H0G 4H3');


INSERT INTO CommonInfo (FirstName, LastName, DateOfBirth, SSN, MedicareCardNumber, PhoneNumber, Email, Address, City, Province, PostalCode)
VALUES
  ('Oliver', 'Walker', '1989-05-20', '100000060', 'MCN100060', '514-555-0160', 'oliver.walker@example.com', '123 Birch St.', 'Montreal', 'QC', 'H1A 3B4'),
  ('Mason', 'Scott', '1995-08-17', '100000061', 'MCN100061', '514-555-0161', 'mason.scott@example.com', '234 Pine St.', 'Montreal', 'QC', 'H2B 4C5'),
  ('Grace', 'Young', '1991-03-05', '100000062', 'MCN100062', '514-555-0162', 'grace.young@example.com', '345 Oak St.', 'Montreal', 'QC', 'H3C 5D6'),
  ('Jackson', 'Walker', '1988-11-12', '100000063', 'MCN100063', '514-555-0163', 'jackson.walker@example.com', '456 Cedar St.', 'Montreal', 'QC', 'H4D 6E7'),
  ('Amelia', 'Lopez', '1993-01-29', '100000064', 'MCN100064', '514-555-0164', 'amelia.lopez@example.com', '567 Elm St.', 'Montreal', 'QC', 'H5F 7G8'),
  ('Lucas', 'Hill', '1996-02-22', '100000065', 'MCN100065', '514-555-0165', 'lucas.hill@example.com', '678 Maple St.', 'Montreal', 'QC', 'H6G 8H9'),
  ('Chloe', 'Carter', '1990-07-08', '100000066', 'MCN100066', '514-555-0166', 'chloe.carter@example.com', '789 Birch St.', 'Montreal', 'QC', 'H7H 9I0'),
  ('David', 'Mitchell', '1984-12-18', '100000067', 'MCN100067', '514-555-0167', 'david.mitchell@example.com', '890 Redwood St.', 'Montreal', 'QC', 'H8I 0J1'),
  ('Ethan', 'Adams', '1997-03-25', '100000068', 'MCN100068', '514-555-0168', 'ethan.adams@example.com', '101 Oak St.', 'Montreal', 'QC', 'H9J 1K2'),
  ('Olivia', 'Nelson', '1992-09-05', '100000069', 'MCN100069', '514-555-0169', 'olivia.nelson@example.com', '212 Pine St.', 'Montreal', 'QC', 'H0K 2L3'),
  ('Sophia', 'Morris', '1995-04-21', '100000070', 'MCN100070', '514-555-0170', 'sophia.morris@example.com', '323 Maple St.', 'Montreal', 'QC', 'H1L 3M4'),
  ('Henry', 'King', '1987-11-09', '100000071', 'MCN100071', '514-555-0171', 'henry.king@example.com', '434 Elm St.', 'Montreal', 'QC', 'H2M 4N5'),
  ('Benjamin', 'Roberts', '1996-06-17', '100000072', 'MCN100072', '514-555-0172', 'benjamin.roberts@example.com', '545 Cedar St.', 'Montreal', 'QC', 'H3N 5O6'),
  ('Jack', 'Hernandez', '1989-08-14', '100000073', 'MCN100073', '514-555-0173', 'jack.hernandez@example.com', '656 Fir St.', 'Montreal', 'QC', 'H4O 6P7'),
  ('Madison', 'Brown', '1994-03-20', '100000074', 'MCN100074', '514-555-0174', 'madison.brown@example.com', '767 Birch St.', 'Montreal', 'QC', 'H5P 7Q8'),
  ('William', 'Gonzalez', '1988-10-02', '100000075', 'MCN100075', '514-555-0175', 'william.gonzalez@example.com', '878 Maple St.', 'Montreal', 'QC', 'H6Q 8R9'),
  ('Samuel', 'Lopez', '1990-12-10', '100000076', 'MCN100076', '514-555-0176', 'samuel.lopez@example.com', '989 Redwood St.', 'Montreal', 'QC', 'H7R 9S0'),
  ('Lily', 'Wilson', '1995-04-13', '100000077', 'MCN100077', '514-555-0177', 'lily.wilson@example.com', '101 Cedar St.', 'Montreal', 'QC', 'H8S 0T1');



-- here are the secondary family members
INSERT INTO CommonInfo (FirstName, LastName, DateOfBirth, SSN, MedicareCardNumber, PhoneNumber, Email, Address, City, Province, PostalCode) VALUES
('Noah', 'Evans', '2006-10-05', '000000061', 'MCN000061', '514-555-0158', 'noah.evans@example.com', '101 Elm St.', 'Montreal', 'QC', 'H1V 2W2'),
('Emma', 'Gonzalez', '2007-07-12', '000000062', 'MCN000062', '514-555-0159', 'emma.gonzalez@example.com', '202 Maple St.', 'Montreal', 'QC', 'H2W 3X3'),
('Liam', 'Bennett', '2006-03-27', '000000063', 'MCN000063', '514-555-0160', 'liam.bennett@example.com', '303 Oak St.', 'Montreal', 'QC', 'H3X 4Y4'),
('Olivia', 'Morris', '2007-09-15', '000000064', 'MCN000064', '514-555-0161', 'olivia.morris@example.com', '404 Cedar St.', 'Montreal', 'QC', 'H4Y 5Z5'),
('William', 'Jenkins', '2006-06-21', '000000065', 'MCN000065', '514-555-0162', 'william.jenkins@example.com', '505 Birch St.', 'Montreal', 'QC', 'H5Z 6A6'),
('Sophia', 'Russell', '2007-01-08', '000000066', 'MCN000066', '514-555-0163', 'sophia.russell@example.com', '606 Pine St.', 'Montreal', 'QC', 'H6A 7B7'),
('James', 'Foster', '2006-12-14', '000000067', 'MCN000067', '514-555-0164', 'james.foster@example.com', '707 Ash St.', 'Montreal', 'QC', 'H7B 8C8'),
('Ava', 'Patterson', '2007-05-22', '000000068', 'MCN000068', '514-555-0165', 'ava.patterson@example.com', '808 Oak St.', 'Montreal', 'QC', 'H8C 9D9'),
('Benjamin', 'Richardson', '2006-08-30', '000000069', 'MCN000069', '514-555-0166', 'benjamin.richardson@example.com', '909 Maple St.', 'Montreal', 'QC', 'H9D 0E0'),
('Mia', 'Bailey', '2007-03-03', '000000070', 'MCN000070', '514-555-0167', 'mia.bailey@example.com', '101 Birch St.', 'Montreal', 'QC', 'H0E 1F1'),
('Elijah', 'Long', '2006-04-09', '000000071', 'MCN000071', '514-555-0168', 'elijah.long@example.com', '202 Redwood St.', 'Montreal', 'QC', 'H1F 2G2'),
('Charlotte', 'Bryant', '2007-11-27', '000000072', 'MCN000072', '514-555-0169', 'charlotte.bryant@example.com', '303 Ash St.', 'Montreal', 'QC', 'H2G 3H3'),
('Daniel', 'Hughes', '2006-02-16', '000000073', 'MCN000073', '514-555-0170', 'daniel.hughes@example.com', '404 Elm St.', 'Montreal', 'QC', 'H3H 4I4'),
('Amelia', 'Sanders', '2007-07-04', '000000074', 'MCN000074', '514-555-0171', 'amelia.sanders@example.com', '505 Cedar St.', 'Montreal', 'QC', 'H4I 5J5'),
('Matthew', 'Price', '2006-09-20', '000000075', 'MCN000075', '514-555-0172', 'matthew.price@example.com', '606 Fir St.', 'Montreal', 'QC', 'H5J 6K6'),
('Evelyn', 'Collins', '2007-10-11', '000000076', 'MCN000076', '514-555-0173', 'evelyn.collins@example.com', '707 Oak St.', 'Montreal', 'QC', 'H6K 7L7'),
('Lucas', 'Ward', '2006-05-31', '000000077', 'MCN000077', '514-555-0174', 'lucas.ward@example.com', '808 Pine St.', 'Montreal', 'QC', 'H7L 8M8'),
('Harper', 'Howard', '2007-12-22', '000000078', 'MCN000078', '514-555-0175', 'harper.howard@example.com', '909 Maple St.', 'Montreal', 'QC', 'H8M 9N9'),
('Henry', 'Cook', '2006-01-19', '000000079', 'MCN000079', '514-555-0176', 'henry.cook@example.com', '101 Birch St.', 'Montreal', 'QC', 'H9N 0O0'),
('Scarlett', 'Carter', '2007-06-06', '000000080', 'MCN000080', '514-555-0177', 'scarlett.carter@example.com', '202 Redwood St.', 'Montreal', 'QC', 'H0O 1P1'),
('Junpeng111', 'Gai', '2007-06-06', '111111080', 'MCN111111', '514-555-0177', 'scarlett.carter@example.com', '202 Redwood St.', 'Montreal', 'QC', 'H0O 1P1'),
('Junpeng', 'Gai', '2007-06-06', '111121080', 'MCN112111', '514-555-0177', 'scarlett.carter@example.com', '202 Redwood St.', 'Montreal', 'QC', 'H0O 1P1');


INSERT INTO Period ( StartDate, EndDate)
VALUES
('2025-01-01', NULL);
INSERT INTO Personnel (CommonID, Role, Mandate, LocationID)
VALUES
  (1, 'General Manager', 'Salaried',1),
  (2, 'Administrator', 'Salaried',1),
  (3, 'Coach', 'Salaried',2),
  (4, 'Assistant Coach', 'Volunteer',2),
  (5, 'Administrator', 'Salaried',3),
  (6, 'Coach', 'Salaried',3),
  (7, 'Assistant Coach', 'Volunteer',4),
  (8, 'Coach', 'Salaried',4),
  (9, 'Administrator', 'Salaried',5),
  (10, 'Assistant Coach', 'Volunteer',5),
  (11, 'Administrator', 'Salaried',6),
  (12, 'Coach', 'Volunteer',6),
  (13, 'Administrator', 'Salaried',7),
  (14, 'Coach', 'Salaried',7),
  (15, 'Assistant Coach', 'Volunteer',8),
  (16, 'Treasurer', 'Salaried',8),
  (17, 'Coach', 'Salaried',9),
  (18, 'Assistant Coach', 'Volunteer',9),
  (19, 'Treasurer', 'Salaried',10),
  (20, 'Coach', 'Salaried',10),
  (116, 'Coach', 'Salaried',1),
  (21, 'Captain', 'Salaried',1);

INSERT INTO Personnel_Assignments (PersonnelID, LocationID, PeriodID)
VALUES
  (1, 1, 1),
  (2, 1, 1),
  (3, 2, 1),
  (4, 2, 1),
  (5, 3, 1),
  (6, 3, 1),
  (7, 4, 1),
  (8, 4, 1),
  (9, 5, 1),
  (10, 5, 1),
  (11, 6, 1),
  (12, 6, 1),
  (13, 7, 1),
  (14, 7, 1),
  (15, 8, 1),
  (16, 8, 1),
  (17, 9, 1),
  (18, 9, 1),
  (19, 10, 1),
  (20, 10, 1),
  (21, 1, 1),
  (22, 1, 1);


INSERT INTO FamilyMembers (CommonID, LocationID, Relationship)
VALUES
  (1, 1, 'Tutor'),
  (21, 1, 'Father'),
  (22, 1, 'Mother'),

  (3, 2, 'Tutor'),
  (23, 2, 'Father'),
  (24, 2, 'Mother'),

  (5, 3, 'Tutor'),
  (25, 3, 'Father'),
  (26, 3, 'Mother'),

  (7, 4, 'Tutor'),
  (27, 4, 'Father'),
  (28, 4, 'Mother'),

  (9, 5, 'Tutor'),
  (29, 5, 'Father'),
  (30, 5, 'Mother'),

  (11, 6, 'Tutor'),
  (31, 6, 'Father'),
  (32, 6, 'Mother'),

  (13, 7, 'Tutor'),
  (33, 7, 'Father'),
  (34, 7, 'Mother'),

  (15, 8, 'Tutor'),
  (35, 8, 'Father'),
  (36, 8, 'Mother'),

  (17, 9, 'Tutor'),
  (37, 9, 'Father'),
  (38, 9, 'Mother'),

  (19, 10, 'Tutor'),
  (39, 10, 'Father'),
  (40, 10, 'Mother');



INSERT INTO ClubMembers (CommonID, FamilyMemberID, LocationID, Height, Weight)
VALUES
  -- Family 1
  (41, 2, 1, 165.50, 60.00),
  (42, 3, 1, 172.30, 75.00),
  (43, 1, 1, 180.00, 70.00),

  -- Family 2
  (44, 5, 2, 160.00, 55.00),
  (45, 6, 2, 170.25, 68.00),
  (46, 4, 2, 182.10, 72.00),

  -- Family 3
  (47, 8, 3, 158.70, 50.00),
  (48, 9, 3, 175.00, 78.00),
  (49, 7, 3, 185.40, 82.00),

  -- Family 4
  (50, 11, 4, 162.00, 52.00),
  (51, 12, 4, 168.20, 65.00),
  (52, 10, 4, 183.30, 75.00),

  -- Family 5
  (53, 14, 5, 159.00, 48.00),
  (54, 15, 5, 173.50, 70.00),
  (55, 13, 5, 181.20, 76.00),

  -- Family 6
  (56, 17, 6, 163.30, 57.00),
  (57, 18, 6, 169.80, 62.00),
  (58, 16, 6, 179.50, 68.00),

  -- Family 7
  (59, 20, 7, 155.40, 49.00),
  (60, 21, 7, 176.20, 80.00),
  (61, 19, 7, 184.00, 85.00),

  -- Family 8
  (62, 23, 8, 161.00, 58.00),
  (63, 24, 8, 177.70, 72.00),
  (64, 22, 8, 182.50, 78.00),

  -- Family 9
  (65, 26, 9, 164.80, 55.00),
  (66, 27, 9, 170.00, 65.00),
  (67, 25, 9, 180.90, 70.00),

  -- Family 10
  (68, 29, 10, 166.10, 60.00),
  (69, 30, 10, 174.20, 68.00),
  (70, 28, 10, 181.90, 73.00);



INSERT INTO Teams (TeamName, TeamType, LocationID)
VALUES
  ('Location1 Boys Team', 'Boys', 1),
  ('Location1 Girls Team', 'Girls', 1),

  ('Location2 Boys Team', 'Boys', 2),
  ('Location2 Girls Team', 'Girls', 2),

  ('Location3 Boys Team', 'Boys', 3),
  ('Location3 Girls Team', 'Girls', 3),

  ('Location4 Boys Team', 'Boys', 4),
  ('Location4 Girls Team', 'Girls', 4),

  ('Location5 Boys Team', 'Boys', 5),
  ('Location5 Girls Team', 'Girls', 5),

  ('Location6 Boys Team', 'Boys', 6),
  ('Location6 Girls Team', 'Girls', 6),

  ('Location7 Boys Team', 'Boys', 7),
  ('Location7 Girls Team', 'Girls', 7),

  ('Location8 Boys Team', 'Boys', 8),
  ('Location8 Girls Team', 'Girls', 8),

  ('Location9 Boys Team', 'Boys', 9),
  ('Location9 Girls Team', 'Girls', 9),

  ('Location10 Boys Team', 'Boys', 10),
  ('Location10 Girls Team', 'Girls', 10);


INSERT INTO Memberships (MemberID, Year, Status, TotalPaid, Deactivation)
VALUES
  (1, 2024, 'Active', 120,1),
  (2, 2021, 'Active', 80, 0),
  (3, 2021, 'Inactive', 50, 1),  -- This record has been deactivated
  (4, 2025, 'Active', 150, 0),
  (5, 2025, 'Active', 200, 0),
  (6, 2025, 'Inactive', 90, 0),
  (7, 2025, 'Active', 110, 0),
  (8, 2025, 'Active', 95, 0),
  (9, 2025, 'Active', 160, 0),
  (10, 2025, 'Inactive', 75, 0),
  (11, 2025, 'Active', 180, 0),
  (12, 2025, 'Active', 130, 0),
  (13, 2025, 'Inactive', 40, 0),
  (14, 2025, 'Active', 200, 0),
  (15, 2025, 'Active', 210, 0),
  (16, 2025, 'Inactive', 60, 0),
  (17, 2025, 'Active', 120, 0),
  (18, 2025, 'Active', 115, 0),
  (19, 2025, 'Active', 155, 0),
  (20, 2025, 'Inactive', 85, 0),
  (21, 2025, 'Active', 140, 0),
  (22, 2025, 'Active', 125, 0),
  (23, 2025, 'Inactive', 65, 0),
  (24, 2025, 'Active', 170, 0),
  (25, 2025, 'Active', 220, 0),
  (26, 2025, 'Inactive', 50, 0),
  (27, 2025, 'Active', 110, 0),
  (28, 2025, 'Active', 140, 0),
  (29, 2025, 'Active', 130, 0),
  (30, 2025, 'Inactive', 70, 0);

  
SET SQL_SAFE_UPDATES = 0;

UPDATE Memberships
SET TotalPaid = 100
WHERE Status = 'Active' AND TotalPaid < 100;

SET SQL_SAFE_UPDATES = 1;



-- Insert sample data into ClubMembers_Teams for 10 locations following the specified pattern
INSERT INTO ClubMembers_Teams (TeamID, MemberID, LocationID)
VALUES
(1, 1, 1),
(2, 2, 1),
(2, 3, 1),

(3, 4, 2),
(4, 5, 2),
(4, 6, 2),

(5, 7, 3),
(6, 8, 3),
(6, 9, 3),

(7, 10, 4),
(8, 11, 4),
(8, 12, 4),

(9, 13, 5),
(10, 14, 5),
(10, 15, 5),

(11, 16, 6),
(12, 17, 6),
(12, 18, 6),

(13, 19, 7),
(14, 20, 7),
(14, 21, 7),

(15, 22, 8),
(16, 23, 8),
(16, 24, 8),

(17, 25, 9),
(18, 26, 9),
(18, 27, 9),

(19, 28, 10),
(20, 29, 10),
(20, 30, 10);

INSERT INTO Payments (MembershipID, PaymentDate, Amount, PaymentMethod)
SELECT
    MembershipID,
    CURRENT_DATE,  -- or a specific date for the payment
    TotalPaid,
    'Credit'  -- Assuming the payment method is 'Credit Card'; adjust as needed
FROM Memberships;

SET SQL_SAFE_UPDATES = 0;
update Payments
set Amount=Amount/2;

SET SQL_SAFE_UPDATES = 1;

INSERT INTO TeamFormations (Team1ID, SessionTypeID, SessionDate, StartTime, EndTime, LocationID, Team1Score)
VALUES 
(1, 2,  '2025-03-10', '18:00:00', '20:00:00', 1, 30),
(3, 2,  '2025-03-10', '18:00:00', '20:00:00', 1, 30),
(5, 1,  '2025-03-15', '19:30:00', '21:30:00', 1, 21),
(2, 2,  '2025-03-18', '14:00:00', '16:00:00', 1,23),
(4, 1, '2025-03-20', '17:00:00', '19:00:00', 1,25),
(5, 2, '2025-03-21', '17:00:00', '19:00:00', 3,25),
(5, 2, '2025-03-22', '17:00:00', '19:00:00', 3,25),
(5, 2, '2025-03-23', '17:00:00', '19:00:00', 3,25),
(5, 2, '2025-03-24', '17:00:00', '19:00:00', 3,25),
(5, 2, '2025-03-25', '17:00:00', '19:00:00', 3,25),
(5, 2, '2025-03-26', '17:00:00', '19:00:00', 3,25);

INSERT INTO TeamFormationPlayers (FormationID, TeamID, MemberID, RoleID) 
VALUES 
(1, 1, 1, 1),  -- Formation 1, Team 1, Member 101, Outside Hitter
(1, 1, 2, 2),  -- Formation 1, Team 1, Member 102, Opposite
(1, 1, 3, 3),  -- Formation 1, Team 1, Member 103, Setter
(2, 2, 4, 4),  -- Formation 2, Team 2, Member 104, Middle Blocker
(2, 2, 5, 5),  -- Formation 2, Team 2, Member 105, Libero
(2, 2, 6, 6),  -- Formation 2, Team 2, Member 106, Defensive Specialist
(3, 3, 7, 1),  -- Formation 3, Team 3, Member 107, Outside Hitter
(3, 3, 8, 3),  -- Formation 3, Team 3, Member 108, Setter
(3, 3, 9, 4),  -- Formation 3, Team 3, Member 109, Middle Blocker
(4, 4, 10, 2),  -- Formation 4, Team 4, Member 110, Opposite
(4, 4, 11, 5),  -- Formation 4, Team 4, Member 111, Libero
(4, 4, 12, 7),  -- Formation 4, Team 4, Member 112, Serving Specialist
(5, 5, 13, 6),  -- Formation 5, Team 5, Member 113, Defensive Specialist
(5, 5, 14, 1),  -- Formation 5, Team 5, Member 114, Outside Hitter
(5, 5, 15, 3),  -- Formation 5, Team 5, Member 115, Setter
(6, 5,7, 1),
(6, 5,7, 2),
(6, 5,7, 3),
(6, 5,7, 4),
(6, 5,7, 5),
(6, 5,7, 6),
(6, 5,7, 7);  -- 6




INSERT INTO SecondaryFamilyMembers (PrimaryFamilyMemberID, CommonID, Relationship) VALUES
(1, 96, 'Father'),
(2, 97, 'Mother'),
(3, 98, 'Grandfather'),
(4, 99, 'Grandmother'),
(5, 100, 'Uncle'),
(6, 101, 'Aunt'),
(7, 102, 'Tutor'),
(8, 103, 'Partner'),
(9, 104, 'Friend'),
(10, 105, 'Other'),
(11, 106, 'Father'),
(12, 107, 'Mother'),
(13, 108, 'Grandfather'),
(14, 109, 'Grandmother'),
(15, 110, 'Uncle'),
(16, 111, 'Aunt'),
(17, 112, 'Tutor'),
(18, 113, 'Partner'),
(19, 114, 'Friend'),
(20, 115, 'Other');


INSERT INTO ClubMembers_Locations (MemberID, LocationID, Current_location)
VALUES (1, 1, TRUE),(1, 2, FALSE),(1, 3, FALSE);



