-- Insert sample data for testing

-- Locations
INSERT INTO Locations (Name, Type, Address, City, Province, PostalCode, PhoneNumber, WebAddress, MaxCapacity)
VALUES 
('MYVC Head Office', 'Head', '123 Main St', 'Montreal', 'Quebec', 'H1A 1A1', '514-555-0123', 'www.myvc.ca', 100),
('MYVC Laval Branch', 'Branch', '456 Laval Ave', 'Laval', 'Quebec', 'H7A 2B2', '450-555-0123', 'www.myvc.ca/laval', 80),
('MYVC Longueuil Branch', 'Branch', '789 Longueuil Blvd', 'Longueuil', 'Quebec', 'J4K 3C3', '450-555-0124', 'www.myvc.ca/longueuil', 80);

-- CommonInfo (Personnel)
INSERT INTO CommonInfo (FirstName, LastName, DateOfBirth, SSN, MedicareCardNumber, PhoneNumber, Email, Address, City, Province, PostalCode)
VALUES 
('John', 'Smith', '1980-01-01', '123456789', 'ABC123456', '514-555-0125', 'john.smith@myvc.ca', '123 Main St', 'Montreal', 'Quebec', 'H1A 1A1'),
('Jane', 'Doe', '1985-02-15', '987654321', 'XYZ789012', '514-555-0126', 'jane.doe@myvc.ca', '456 Laval Ave', 'Laval', 'Quebec', 'H7A 2B2'),
('Mike', 'Johnson', '1990-03-20', '456789123', 'DEF456789', '450-555-0127', 'mike.johnson@myvc.ca', '789 Longueuil Blvd', 'Longueuil', 'Quebec', 'J4K 3C3');

-- Personnel
INSERT INTO Personnel (CommonID, Role, Mandate, LocationID)
VALUES 
(1, 'General Manager', 'Salaried', 1),
(2, 'Coach', 'Salaried', 2),
(3, 'Coach', 'Salaried', 3);

-- CommonInfo (Family Members)
INSERT INTO CommonInfo (FirstName, LastName, DateOfBirth, SSN, MedicareCardNumber, PhoneNumber, Email, Address, City, Province, PostalCode)
VALUES 
('Robert', 'Wilson', '1975-04-10', '111222333', 'GHI789012', '514-555-0128', 'robert.wilson@email.com', '321 Oak St', 'Montreal', 'Quebec', 'H1A 1A2'),
('Mary', 'Brown', '1978-05-25', '444555666', 'JKL012345', '450-555-0129', 'mary.brown@email.com', '654 Pine Ave', 'Laval', 'Quebec', 'H7A 2B3'),
('David', 'Lee', '1980-06-30', '777888999', 'MNO345678', '450-555-0130', 'david.lee@email.com', '987 Maple Rd', 'Longueuil', 'Quebec', 'J4K 3C4');

-- Family Members
INSERT INTO FamilyMembers (CommonID, LocationID, Relationship)
VALUES 
(4, 1, 'Father'),
(5, 2, 'Mother'),
(6, 3, 'Father');

-- CommonInfo (Club Members)
INSERT INTO CommonInfo (FirstName, LastName, DateOfBirth, SSN, MedicareCardNumber, PhoneNumber, Email, Address, City, Province, PostalCode)
VALUES 
('Tom', 'Wilson', '2008-07-15', '123123123', 'PQR678901', '514-555-0131', 'tom.wilson@email.com', '321 Oak St', 'Montreal', 'Quebec', 'H1A 1A2'),
('Sarah', 'Brown', '2009-08-20', '456456456', 'STU901234', '450-555-0132', 'sarah.brown@email.com', '654 Pine Ave', 'Laval', 'Quebec', 'H7A 2B3'),
('James', 'Lee', '2010-09-25', '789789789', 'VWX234567', '450-555-0133', 'james.lee@email.com', '987 Maple Rd', 'Longueuil', 'Quebec', 'J4K 3C4');

-- Club Members
INSERT INTO ClubMembers (CommonID, FamilyMemberID, LocationID, Height, Weight)
VALUES 
(7, 1, 1, 170, 65),
(8, 2, 2, 165, 60),
(9, 3, 3, 175, 70);

-- Teams
INSERT INTO Teams (TeamName, TeamType, LocationID)
VALUES 
('Montreal Boys U15', 'Boys', 1),
('Laval Girls U16', 'Girls', 2),
('Longueuil Boys U17', 'Boys', 3);

-- Session Types
INSERT INTO SessionTypes (Type)
VALUES 
('Training'),
('Game');

-- Player Roles
INSERT INTO PlayerRoles (RoleName)
VALUES 
('Outside Hitter'),
('Opposite'),
('Setter'),
('Middle Blocker'),
('Libero'),
('Defensive Specialist'),
('Serving Specialist');

-- Team Formations
INSERT INTO TeamFormations (TeamID, SessionTypeID, SessionDate, StartTime, EndTime, Address, Score)
VALUES 
(1, 1, '2024-03-20', '18:00:00', '20:00:00', '123 Main St, Montreal', NULL),
(2, 2, '2024-03-21', '19:00:00', '21:00:00', '456 Laval Ave, Laval', NULL),
(3, 1, '2024-03-22', '17:00:00', '19:00:00', '789 Longueuil Blvd, Longueuil', NULL);

-- Team Formation Players
INSERT INTO TeamFormationPlayers (FormationID, MemberID, RoleID)
VALUES 
(1, 1, 1),  -- Tom Wilson as Outside Hitter
(2, 2, 2),  -- Sarah Brown as Opposite
(3, 3, 3);  -- James Lee as Setter

-- Secondary Family Members
INSERT INTO CommonInfo (FirstName, LastName, PhoneNumber)
VALUES 
('William', 'Wilson', '514-555-0134'),
('Elizabeth', 'Brown', '450-555-0135'),
('Michael', 'Lee', '450-555-0136');

INSERT INTO SecondaryFamilyMembers (PrimaryFamilyMemberID, CommonID, Relationship)
VALUES 
(1, 10, 'Uncle'),
(2, 11, 'Aunt'),
(3, 12, 'Uncle');

INSERT INTO SecondaryFamilyMemberRelationships (SecondaryID, MemberID, Relationship)
VALUES 
(1, 1, 'Uncle'),
(2, 2, 'Aunt'),
(3, 3, 'Uncle');

-- Email Logs
INSERT INTO EmailLogs (EmailDate, Sender, Recipient, CCList, Subject, BodyPreview, EmailType)
VALUES 
(NOW(), 'system@myvc.ca', 'tom.wilson@email.com', NULL, 'Team Formation Update', 'Dear Tom, Your upcoming training session details...', 'Team Formation'),
(NOW(), 'system@myvc.ca', 'sarah.brown@email.com', NULL, 'Team Formation Update', 'Dear Sarah, Your upcoming game session details...', 'Team Formation'); 