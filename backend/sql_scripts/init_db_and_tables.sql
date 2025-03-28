-- Drop tables in reverse order of creation to avoid foreign key constraints
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS ClubMembers_Teams;
DROP TABLE IF EXISTS Teams;
DROP TABLE IF EXISTS Memberships;
DROP TABLE IF EXISTS ClubMembers;
DROP TABLE IF EXISTS FamilyMembers;
DROP TABLE IF EXISTS Personnel_Assignments;
DROP TABLE IF EXISTS Personnel;
DROP TABLE IF EXISTS CommonInfo;
DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS Period;
DROP TABLE IF EXISTS SessionTypes;
DROP TABLE IF EXISTS PlayerRoles;
DROP TABLE IF EXISTS TeamFormations;
DROP TABLE IF EXISTS TeamFormationPlayers;
DROP TABLE IF EXISTS EmailLogs;
DROP TABLE IF EXISTS SecondaryFamilyMembers;
DROP TABLE IF EXISTS SecondaryFamilyMemberRelationships;
SET FOREIGN_KEY_CHECKS = 1;
use  mydb;
-- Create Period Table
CREATE TABLE Period (
  PeriodID INT AUTO_INCREMENT PRIMARY KEY,
  StartDate DATE NOT NULL,
  EndDate date
);

-- Create Locations Table
CREATE TABLE Locations (
  LocationID INT AUTO_INCREMENT PRIMARY KEY,
  Type ENUM('Head', 'Branch') NOT NULL,
  Name VARCHAR(100) NOT NULL,
  Address VARCHAR(255),
  City VARCHAR(100),
  Province VARCHAR(50),
  PostalCode VARCHAR(10),
  PhoneNumber VARCHAR(20),
  WebAddress VARCHAR(100),
  MaxCapacity INT
);

-- Create CommonInfo Table
CREATE TABLE CommonInfo (
  CommonID INT AUTO_INCREMENT PRIMARY KEY,
  FirstName VARCHAR(100),
  LastName VARCHAR(100),
  DateOfBirth DATE,
  SSN CHAR(9) UNIQUE NOT NULL,
  MedicareCardNumber VARCHAR(20) UNIQUE NOT NULL,
  PhoneNumber VARCHAR(20),
  Email VARCHAR(100),
  Address VARCHAR(255),
  City VARCHAR(100),
  Province VARCHAR(50),
  PostalCode VARCHAR(10)
);

-- Create Personnel Table
CREATE TABLE Personnel (
  PersonnelID INT AUTO_INCREMENT PRIMARY KEY,
  CommonID INT NOT NULL,
  Role ENUM('Administrator', 'Captain', 'Coach', 'Assistant Coach', 'Other') NOT NULL,
  Mandate ENUM('Volunteer', 'Salaried') NOT NULL,
  FOREIGN KEY (CommonID) REFERENCES CommonInfo(CommonID)
);
ALTER TABLE Personnel
MODIFY Role ENUM('Administrator', 'Captain', 'Coach', 'Assistant Coach', 'Other', 'General Manager', 'Deputy Manager', 'Treasurer', 'Secretary') NOT NULL;
ALTER TABLE Personnel
ADD COLUMN LocationID INT NOT NULL;


SET SQL_SAFE_UPDATES = 0;
UPDATE Personnel p
JOIN Personnel_Assignments pa ON p.PersonnelID = pa.PersonnelID
SET p.LocationID = pa.LocationID;

SET SQL_SAFE_UPDATES = 1;


ALTER TABLE Personnel
ADD CONSTRAINT fk_location
FOREIGN KEY (LocationID) REFERENCES Locations(LocationID);
-- Create Personnel_Assignments Table
CREATE TABLE Personnel_Assignments (
  AssignmentID INT AUTO_INCREMENT PRIMARY KEY,
  PersonnelID INT NOT NULL,
  LocationID INT NOT NULL,
  PeriodID INT NOT NULL,
  FOREIGN KEY (PersonnelID) REFERENCES Personnel(PersonnelID),
  FOREIGN KEY (LocationID) REFERENCES Locations(LocationID),
  FOREIGN KEY (PeriodID) REFERENCES Period(PeriodID)
);

-- Create FamilyMembers Table
CREATE TABLE FamilyMembers (
  FamilyMemberID INT AUTO_INCREMENT PRIMARY KEY,
  CommonID INT NOT NULL,
  LocationID INT,
  Relationship ENUM('Father', 'Mother', 'Grandfather', 'Grandmother', 'Tutor', 'Partner', 'Friend', 'Other'),
  FOREIGN KEY (LocationID) REFERENCES Locations(LocationID),
  FOREIGN KEY (CommonID) REFERENCES CommonInfo(CommonID)
);

-- Create ClubMembers Table
CREATE TABLE ClubMembers (
  MemberID INT AUTO_INCREMENT PRIMARY KEY,
  CommonID INT NOT NULL,
  FamilyMemberID INT NOT NULL,
  LocationID INT,
  Height DECIMAL(5, 2),
  Weight DECIMAL(5, 2),
  FOREIGN KEY (LocationID) REFERENCES Locations(LocationID),
  FOREIGN KEY (CommonID) REFERENCES CommonInfo(CommonID),
  FOREIGN KEY (FamilyMemberID) REFERENCES FamilyMembers(FamilyMemberID)
);

-- Table for Memberships
CREATE TABLE Memberships (
  MembershipID INT AUTO_INCREMENT PRIMARY KEY,
  MemberID INT NOT NULL,
  Year INT NOT NULL,
  Status ENUM('Active', 'Inactive') DEFAULT 'Active',
  TotalPaid DECIMAL(10, 2) DEFAULT 0,
  DonationAmount DECIMAL(10, 2) AS (GREATEST(TotalPaid - 100, 0)) STORED,
  FOREIGN KEY (MemberID) REFERENCES ClubMembers(MemberID)
);
-- Create Teams Table
CREATE TABLE Teams (
  TeamID INT AUTO_INCREMENT PRIMARY KEY,
  TeamName VARCHAR(100),
  TeamType ENUM('Boys', 'Girls'),
  LocationID INT NOT NULL,
  FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

-- Create ClubMembers_Teams Table
CREATE TABLE ClubMembers_Teams (
  TeamID INT,
  MemberID INT,
  LocationID INT,
  PRIMARY KEY (TeamID, MemberID),
  FOREIGN KEY (TeamID) REFERENCES Teams(TeamID),
  FOREIGN KEY (MemberID) REFERENCES ClubMembers(MemberID),
  FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);
-- Table for Payments
CREATE TABLE Payments (
  PaymentID INT AUTO_INCREMENT PRIMARY KEY,
  MembershipID INT NOT NULL,
  PaymentDate DATE NOT NULL,
  Amount DECIMAL(10, 2) NOT NULL,
  PaymentMethod ENUM('Cash', 'Debit', 'Credit'),
  FOREIGN KEY (MembershipID) REFERENCES Memberships(MembershipID)
);

-- Create SessionTypes Table
CREATE TABLE SessionTypes (
  SessionTypeID INT AUTO_INCREMENT PRIMARY KEY,
  Type ENUM('Training', 'Game') NOT NULL
);

-- Create PlayerRoles Table
CREATE TABLE PlayerRoles (
  RoleID INT AUTO_INCREMENT PRIMARY KEY,
  RoleName ENUM('Outside Hitter', 'Opposite', 'Setter', 'Middle Blocker', 'Libero', 'Defensive Specialist', 'Serving Specialist') NOT NULL
);

-- Create TeamFormations Table
CREATE TABLE TeamFormations (
  FormationID INT AUTO_INCREMENT PRIMARY KEY,
  TeamID INT NOT NULL,
  SessionTypeID INT NOT NULL,
  SessionDate DATE NOT NULL,
  StartTime TIME NOT NULL,
  EndTime TIME NOT NULL,
  Address VARCHAR(255) NOT NULL,
  Score INT,
  FOREIGN KEY (TeamID) REFERENCES Teams(TeamID),
  FOREIGN KEY (SessionTypeID) REFERENCES SessionTypes(SessionTypeID)
);

-- Create TeamFormationPlayers Table
CREATE TABLE TeamFormationPlayers (
  FormationID INT NOT NULL,
  MemberID INT NOT NULL,
  RoleID INT NOT NULL,
  PRIMARY KEY (FormationID, MemberID),
  FOREIGN KEY (FormationID) REFERENCES TeamFormations(FormationID),
  FOREIGN KEY (MemberID) REFERENCES ClubMembers(MemberID),
  FOREIGN KEY (RoleID) REFERENCES PlayerRoles(RoleID)
);

-- Create EmailLogs Table
CREATE TABLE EmailLogs (
  EmailLogID INT AUTO_INCREMENT PRIMARY KEY,
  EmailDate DATETIME NOT NULL,
  Sender VARCHAR(100) NOT NULL,
  Recipient VARCHAR(100) NOT NULL,
  CCList VARCHAR(255),
  Subject VARCHAR(255) NOT NULL,
  BodyPreview VARCHAR(100) NOT NULL,
  EmailType ENUM('TeamFormation', 'Deactivation') NOT NULL
);

-- Create SecondaryFamilyMembers Table
CREATE TABLE SecondaryFamilyMembers (
  SecondaryID INT AUTO_INCREMENT PRIMARY KEY,
  PrimaryFamilyMemberID INT NOT NULL,
  CommonID INT NOT NULL,
  Relationship ENUM('Father', 'Mother', 'Grandfather', 'Grandmother', 'Uncle', 'Aunt', 'Tutor', 'Partner', 'Friend', 'Other') NOT NULL,
  FOREIGN KEY (PrimaryFamilyMemberID) REFERENCES FamilyMembers(FamilyMemberID),
  FOREIGN KEY (CommonID) REFERENCES CommonInfo(CommonID)
);

-- Create SecondaryFamilyMemberRelationships Table
CREATE TABLE SecondaryFamilyMemberRelationships (
  SecondaryID INT NOT NULL,
  MemberID INT NOT NULL,
  Relationship ENUM('Father', 'Mother', 'Grandfather', 'Grandmother', 'Uncle', 'Aunt', 'Tutor', 'Partner', 'Friend', 'Other') NOT NULL,
  PRIMARY KEY (SecondaryID, MemberID),
  FOREIGN KEY (SecondaryID) REFERENCES SecondaryFamilyMembers(SecondaryID),
  FOREIGN KEY (MemberID) REFERENCES ClubMembers(MemberID)
);

-- Add trigger for age validation
DELIMITER //
CREATE TRIGGER validate_member_age
BEFORE INSERT ON ClubMembers
FOR EACH ROW
BEGIN
    DECLARE member_age INT;
    SELECT TIMESTAMPDIFF(YEAR, (SELECT DateOfBirth FROM CommonInfo WHERE CommonID = NEW.CommonID), CURDATE()) INTO member_age;
    IF member_age < 11 OR member_age > 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Club member must be between 11 and 18 years old';
    END IF;
END //
DELIMITER ;

-- Add trigger for time conflict validation
DELIMITER //
CREATE TRIGGER validate_session_time_conflict
BEFORE INSERT ON TeamFormationPlayers
FOR EACH ROW
BEGIN
    DECLARE conflicting_sessions INT;
    SELECT COUNT(*)
    INTO conflicting_sessions
    FROM TeamFormationPlayers tfp
    JOIN TeamFormations tf ON tfp.FormationID = tf.FormationID
    WHERE tfp.MemberID = NEW.MemberID
    AND tf.SessionDate = (SELECT SessionDate FROM TeamFormations WHERE FormationID = NEW.FormationID)
    AND ABS(TIMESTAMPDIFF(HOUR, 
        CONCAT(tf.SessionDate, ' ', tf.StartTime),
        (SELECT CONCAT(SessionDate, ' ', StartTime) FROM TeamFormations WHERE FormationID = NEW.FormationID)
    )) < 3;
    
    IF conflicting_sessions > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot assign player to sessions less than 3 hours apart on the same day';
    END IF;
END //
DELIMITER ;

-- Add trigger for membership deactivation
DELIMITER //
CREATE TRIGGER check_member_age_monthly
AFTER UPDATE ON ClubMembers
FOR EACH ROW
BEGIN
    DECLARE member_age INT;
    DECLARE member_email VARCHAR(100);
    DECLARE member_name VARCHAR(200);
    
    IF NEW.LocationID IS NULL AND OLD.LocationID IS NOT NULL THEN
        SELECT TIMESTAMPDIFF(YEAR, (SELECT DateOfBirth FROM CommonInfo WHERE CommonID = NEW.CommonID), CURDATE()) INTO member_age;
        SELECT Email INTO member_email FROM CommonInfo WHERE CommonID = NEW.CommonID;
        SELECT CONCAT(FirstName, ' ', LastName) INTO member_name FROM CommonInfo WHERE CommonID = NEW.CommonID;
        
        IF member_age >= 18 THEN
            -- Insert into email logs
            INSERT INTO EmailLogs (EmailDate, Sender, Recipient, Subject, BodyPreview, EmailType)
            VALUES (NOW(), 'system@myvc.com', member_email, 'Membership Deactivation Notice',
                   CONCAT('Dear ', member_name, ', your membership has been deactivated due to age.'),
                   'Deactivation');
        END IF;
    END IF;
END //
DELIMITER ;

-- Insert sample data for SessionTypes
INSERT INTO SessionTypes (Type) VALUES 
('Training'),
('Game');

-- Insert sample data for PlayerRoles
INSERT INTO PlayerRoles (RoleName) VALUES 
('Outside Hitter'),
('Opposite'),
('Setter'),
('Middle Blocker'),
('Libero'),
('Defensive Specialist'),
('Serving Specialist');

-- Insert sample data for Locations
INSERT INTO Locations (Type, Name, Address, City, Province, PostalCode, PhoneNumber, WebAddress, MaxCapacity) VALUES
('Head', 'Montreal Main', '123 Main St', 'Montreal', 'QC', 'H1A 1A1', '514-555-0123', 'www.myvc-montreal.com', 100),
('Branch', 'Laval Branch', '456 Laval Ave', 'Laval', 'QC', 'H7A 2B2', '450-555-0123', 'www.myvc-laval.com', 75),
('Branch', 'Longueuil Branch', '789 Longueuil Blvd', 'Longueuil', 'QC', 'J4K 3C3', '450-555-0456', 'www.myvc-longueuil.com', 75);

-- Insert sample data for CommonInfo
INSERT INTO CommonInfo (FirstName, LastName, DateOfBirth, SSN, MedicareCardNumber, PhoneNumber, Email, Address, City, Province, PostalCode) VALUES
('John', 'Doe', '1990-01-01', '123456789', 'MED123456', '514-555-0001', 'john.doe@email.com', '123 Main St', 'Montreal', 'QC', 'H1A 1A1'),
('Jane', 'Smith', '1995-05-15', '987654321', 'MED987654', '514-555-0002', 'jane.smith@email.com', '456 Laval Ave', 'Laval', 'QC', 'H7A 2B2'),
('Mike', 'Johnson', '2000-12-25', '456789123', 'MED456789', '514-555-0003', 'mike.johnson@email.com', '789 Longueuil Blvd', 'Longueuil', 'QC', 'J4K 3C3'),
('Sarah', 'Williams', '2005-08-10', '789123456', 'MED789123', '514-555-0004', 'sarah.williams@email.com', '123 Main St', 'Montreal', 'QC', 'H1A 1A1');

-- Insert sample data for Personnel
INSERT INTO Personnel (CommonID, Role, Mandate, LocationID) VALUES
(1, 'General Manager', 'Salaried', 1),
(2, 'Coach', 'Salaried', 2),
(3, 'Assistant Coach', 'Volunteer', 3);

-- Insert sample data for FamilyMembers
INSERT INTO FamilyMembers (CommonID, LocationID, Relationship) VALUES
(4, 1, 'Mother');

-- Insert sample data for ClubMembers
INSERT INTO ClubMembers (CommonID, FamilyMemberID, LocationID, Height, Weight) VALUES
(4, 1, 1, 170.5, 65.0);

-- Insert sample data for Teams
INSERT INTO Teams (TeamName, TeamType, LocationID) VALUES
('Montreal Boys U16', 'Boys', 1),
('Laval Girls U14', 'Girls', 2),
('Longueuil Boys U18', 'Boys', 3);

-- Insert sample data for TeamFormations
INSERT INTO TeamFormations (TeamID, SessionTypeID, SessionDate, StartTime, EndTime, Address, Score) VALUES
(1, 1, '2024-02-20', '18:00:00', '20:00:00', '123 Main St, Montreal', NULL),
(2, 2, '2024-02-21', '19:00:00', '21:00:00', '456 Laval Ave, Laval', 25);

-- Insert sample data for TeamFormationPlayers
INSERT INTO TeamFormationPlayers (FormationID, MemberID, RoleID) VALUES
(1, 1, 1),
(2, 1, 2);

-- Insert sample data for EmailLogs
INSERT INTO EmailLogs (EmailDate, Sender, Recipient, Subject, BodyPreview, EmailType) VALUES
('2024-02-19 10:00:00', 'system@myvc.com', 'sarah.williams@email.com', 'Montreal Boys U16 Monday 20-Feb-2024 6:00 PM training session',
'Dear Sarah Williams, you are assigned as Outside Hitter for the training session.',
'TeamFormation');

-- Insert sample data for SecondaryFamilyMembers
INSERT INTO SecondaryFamilyMembers (PrimaryFamilyMemberID, CommonID, Relationship) VALUES
(1, 1, 'Father');

-- Insert sample data for SecondaryFamilyMemberRelationships
INSERT INTO SecondaryFamilyMemberRelationships (SecondaryID, MemberID, Relationship) VALUES
(1, 1, 'Father');

SELECT * FROM Period;
SELECT * FROM Locations;
SELECT * FROM CommonInfo;
SELECT * FROM Personnel;
SELECT * FROM Personnel_Assignments;
SELECT * FROM FamilyMembers;
SELECT * FROM ClubMembers;
SELECT * FROM Memberships;
SELECT * FROM Teams;
SELECT * FROM ClubMembers_Teams;
SELECT * FROM Payments;
SELECT * FROM SessionTypes;
SELECT * FROM PlayerRoles;
SELECT * FROM TeamFormations;
SELECT * FROM TeamFormationPlayers;
SELECT * FROM EmailLogs;
SELECT * FROM SecondaryFamilyMembers;
SELECT * FROM SecondaryFamilyMemberRelationships;

-- Query 7: Get complete details for every location
SELECT 
    l.Name,
    l.Address,
    l.City,
    l.Province,
    l.PostalCode,
    l.PhoneNumber,
    l.WebAddress,
    l.Type,
    l.MaxCapacity,
    CONCAT(p.FirstName, ' ', p.LastName) as ManagerName,
    COUNT(DISTINCT cm.MemberID) as ActiveMembers
FROM Locations l
LEFT JOIN Personnel per ON l.LocationID = per.LocationID AND per.Role = 'General Manager'
LEFT JOIN CommonInfo p ON per.CommonID = p.CommonID
LEFT JOIN ClubMembers cm ON l.LocationID = cm.LocationID
GROUP BY l.LocationID
ORDER BY l.Province, l.City;

-- Query 8: Get details for a family member and associated locations
SELECT 
    fm.FamilyMemberID,
    CONCAT(ci.FirstName, ' ', ci.LastName) as FamilyMemberName,
    ci.PhoneNumber as FamilyMemberPhone,
    l.Name as LocationName,
    CONCAT(sfm.FirstName, ' ', sfm.LastName) as SecondaryFamilyMemberName,
    sfm.PhoneNumber as SecondaryFamilyMemberPhone,
    cm.MemberID,
    CONCAT(cmci.FirstName, ' ', cmci.LastName) as ClubMemberName,
    cmci.DateOfBirth,
    cmci.SSN,
    cmci.MedicareCardNumber,
    cmci.PhoneNumber as ClubMemberPhone,
    cmci.Address,
    cmci.City,
    cmci.Province,
    cmci.PostalCode,
    sfmr.Relationship as SecondaryFamilyMemberRelationship
FROM FamilyMembers fm
JOIN CommonInfo ci ON fm.CommonID = ci.CommonID
LEFT JOIN Locations l ON fm.LocationID = l.LocationID
LEFT JOIN SecondaryFamilyMembers sfm ON fm.FamilyMemberID = sfm.PrimaryFamilyMemberID
LEFT JOIN CommonInfo sfmci ON sfm.CommonID = sfmci.CommonID
LEFT JOIN SecondaryFamilyMemberRelationships sfmr ON sfm.SecondaryID = sfmr.SecondaryID
LEFT JOIN ClubMembers cm ON sfmr.MemberID = cm.MemberID
LEFT JOIN CommonInfo cmci ON cm.CommonID = cmci.CommonID
WHERE fm.FamilyMemberID = 1;

-- Query 9: Get team formations for a location and week
SELECT 
    tf.FormationID,
    CONCAT(p.FirstName, ' ', p.LastName) as HeadCoachName,
    tf.SessionDate,
    tf.StartTime,
    tf.Address,
    st.Type as SessionType,
    t.TeamName,
    tf.Score,
    CONCAT(cmci.FirstName, ' ', cmci.LastName) as PlayerName,
    pr.RoleName as PlayerRole
FROM TeamFormations tf
JOIN Teams t ON tf.TeamID = t.TeamID
JOIN SessionTypes st ON tf.SessionTypeID = st.SessionTypeID
JOIN TeamFormationPlayers tfp ON tf.FormationID = tfp.FormationID
JOIN ClubMembers cm ON tfp.MemberID = cm.MemberID
JOIN CommonInfo cmci ON cm.CommonID = cmci.CommonID
JOIN PlayerRoles pr ON tfp.RoleID = pr.RoleID
JOIN Personnel per ON t.LocationID = per.LocationID AND per.Role = 'Coach'
JOIN CommonInfo p ON per.CommonID = p.CommonID
WHERE t.LocationID = 1
AND tf.SessionDate BETWEEN '2024-02-19' AND '2024-02-25'
ORDER BY tf.SessionDate, tf.StartTime;

-- Query 10: Get active members with multiple locations
SELECT 
    cm.MemberID,
    CONCAT(ci.FirstName, ' ', ci.LastName) as MemberName
FROM ClubMembers cm
JOIN CommonInfo ci ON cm.CommonID = ci.CommonID
WHERE cm.LocationID IS NOT NULL
AND TIMESTAMPDIFF(YEAR, ci.DateOfBirth, CURDATE()) BETWEEN 11 AND 18
GROUP BY cm.MemberID
HAVING COUNT(DISTINCT cm.LocationID) >= 3
AND MAX(TIMESTAMPDIFF(YEAR, ci.DateOfBirth, CURDATE())) <= 3
ORDER BY cm.MemberID;

-- Query 11: Get team formations report for a period
SELECT 
    l.Name as LocationName,
    COUNT(CASE WHEN st.Type = 'Training' THEN 1 END) as TotalTrainingSessions,
    COUNT(DISTINCT CASE WHEN st.Type = 'Training' THEN tfp.MemberID END) as TotalTrainingPlayers,
    COUNT(CASE WHEN st.Type = 'Game' THEN 1 END) as TotalGameSessions,
    COUNT(DISTINCT CASE WHEN st.Type = 'Game' THEN tfp.MemberID END) as TotalGamePlayers
FROM Locations l
JOIN Teams t ON l.LocationID = t.LocationID
JOIN TeamFormations tf ON t.TeamID = tf.TeamID
JOIN SessionTypes st ON tf.SessionTypeID = st.SessionTypeID
JOIN TeamFormationPlayers tfp ON tf.FormationID = tfp.FormationID
WHERE tf.SessionDate BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY l.LocationID
HAVING COUNT(CASE WHEN st.Type = 'Game' THEN 1 END) >= 2
ORDER BY COUNT(CASE WHEN st.Type = 'Game' THEN 1 END) DESC;

-- Query 12: Get active members never assigned to formations
SELECT 
    cm.MemberID,
    CONCAT(ci.FirstName, ' ', ci.LastName) as MemberName,
    TIMESTAMPDIFF(YEAR, ci.DateOfBirth, CURDATE()) as Age,
    ci.PhoneNumber,
    ci.Email,
    l.Name as CurrentLocation
FROM ClubMembers cm
JOIN CommonInfo ci ON cm.CommonID = ci.CommonID
JOIN Locations l ON cm.LocationID = l.LocationID
WHERE TIMESTAMPDIFF(YEAR, ci.DateOfBirth, CURDATE()) BETWEEN 11 AND 18
AND NOT EXISTS (
    SELECT 1 FROM TeamFormationPlayers tfp WHERE tfp.MemberID = cm.MemberID
)
ORDER BY l.Name, cm.MemberID;

-- Query 13: Get members only assigned as outside hitter
SELECT 
    cm.MemberID,
    CONCAT(ci.FirstName, ' ', ci.LastName) as MemberName,
    TIMESTAMPDIFF(YEAR, ci.DateOfBirth, CURDATE()) as Age,
    ci.PhoneNumber,
    ci.Email,
    l.Name as CurrentLocation
FROM ClubMembers cm
JOIN CommonInfo ci ON cm.CommonID = ci.CommonID
JOIN Locations l ON cm.LocationID = l.LocationID
WHERE TIMESTAMPDIFF(YEAR, ci.DateOfBirth, CURDATE()) BETWEEN 11 AND 18
AND EXISTS (
    SELECT 1 FROM TeamFormationPlayers tfp 
    JOIN PlayerRoles pr ON tfp.RoleID = pr.RoleID 
    WHERE tfp.MemberID = cm.MemberID AND pr.RoleName = 'Outside Hitter'
)
AND NOT EXISTS (
    SELECT 1 FROM TeamFormationPlayers tfp 
    JOIN PlayerRoles pr ON tfp.RoleID = pr.RoleID 
    WHERE tfp.MemberID = cm.MemberID AND pr.RoleName != 'Outside Hitter'
)
ORDER BY l.Name, cm.MemberID;

-- Query 14: Get members assigned to all roles
SELECT 
    cm.MemberID,
    CONCAT(ci.FirstName, ' ', ci.LastName) as MemberName,
    TIMESTAMPDIFF(YEAR, ci.DateOfBirth, CURDATE()) as Age,
    ci.PhoneNumber,
    ci.Email,
    l.Name as CurrentLocation
FROM ClubMembers cm
JOIN CommonInfo ci ON cm.CommonID = ci.CommonID
JOIN Locations l ON cm.LocationID = l.LocationID
WHERE TIMESTAMPDIFF(YEAR, ci.DateOfBirth, CURDATE()) BETWEEN 11 AND 18
AND EXISTS (
    SELECT 1 FROM TeamFormationPlayers tfp 
    JOIN PlayerRoles pr ON tfp.RoleID = pr.RoleID 
    WHERE tfp.MemberID = cm.MemberID AND pr.RoleName = 'Outside Hitter'
)
AND EXISTS (
    SELECT 1 FROM TeamFormationPlayers tfp 
    JOIN PlayerRoles pr ON tfp.RoleID = pr.RoleID 
    WHERE tfp.MemberID = cm.MemberID AND pr.RoleName = 'Opposite'
)
AND EXISTS (
    SELECT 1 FROM TeamFormationPlayers tfp 
    JOIN PlayerRoles pr ON tfp.RoleID = pr.RoleID 
    WHERE tfp.MemberID = cm.MemberID AND pr.RoleName = 'Setter'
)
AND EXISTS (
    SELECT 1 FROM TeamFormationPlayers tfp 
    JOIN PlayerRoles pr ON tfp.RoleID = pr.RoleID 
    WHERE tfp.MemberID = cm.MemberID AND pr.RoleName = 'Middle Blocker'
)
AND EXISTS (
    SELECT 1 FROM TeamFormationPlayers tfp 
    JOIN PlayerRoles pr ON tfp.RoleID = pr.RoleID 
    WHERE tfp.MemberID = cm.MemberID AND pr.RoleName = 'Libero'
)
AND EXISTS (
    SELECT 1 FROM TeamFormationPlayers tfp 
    JOIN PlayerRoles pr ON tfp.RoleID = pr.RoleID 
    WHERE tfp.MemberID = cm.MemberID AND pr.RoleName = 'Defensive Specialist'
)
AND EXISTS (
    SELECT 1 FROM TeamFormationPlayers tfp 
    JOIN PlayerRoles pr ON tfp.RoleID = pr.RoleID 
    WHERE tfp.MemberID = cm.MemberID AND pr.RoleName = 'Serving Specialist'
)
ORDER BY l.Name, cm.MemberID;

-- Query 15: Get family members who are captains
SELECT 
    CONCAT(ci.FirstName, ' ', ci.LastName) as FamilyMemberName,
    ci.PhoneNumber
FROM FamilyMembers fm
JOIN CommonInfo ci ON fm.CommonID = ci.CommonID
JOIN ClubMembers cm ON fm.FamilyMemberID = cm.FamilyMemberID
JOIN TeamFormationPlayers tfp ON cm.MemberID = tfp.MemberID
JOIN TeamFormations tf ON tfp.FormationID = tf.FormationID
JOIN Teams t ON tf.TeamID = t.TeamID
WHERE t.LocationID = 1
AND EXISTS (
    SELECT 1 FROM TeamFormationPlayers tfp2
    JOIN PlayerRoles pr ON tfp2.RoleID = pr.RoleID
    WHERE tfp2.MemberID = cm.MemberID
    AND pr.RoleName = 'Captain'
)
GROUP BY fm.FamilyMemberID;

-- Query 16: Get undefeated members
SELECT 
    cm.MemberID,
    CONCAT(ci.FirstName, ' ', ci.LastName) as MemberName,
    TIMESTAMPDIFF(YEAR, ci.DateOfBirth, CURDATE()) as Age,
    ci.PhoneNumber,
    ci.Email,
    l.Name as CurrentLocation
FROM ClubMembers cm
JOIN CommonInfo ci ON cm.CommonID = ci.CommonID
JOIN Locations l ON cm.LocationID = l.LocationID
WHERE TIMESTAMPDIFF(YEAR, ci.DateOfBirth, CURDATE()) BETWEEN 11 AND 18
AND EXISTS (
    SELECT 1 FROM TeamFormationPlayers tfp
    JOIN TeamFormations tf ON tfp.FormationID = tf.FormationID
    JOIN SessionTypes st ON tf.SessionTypeID = st.SessionTypeID
    WHERE tfp.MemberID = cm.MemberID
    AND st.Type = 'Game'
)
AND NOT EXISTS (
    SELECT 1 FROM TeamFormationPlayers tfp
    JOIN TeamFormations tf ON tfp.FormationID = tf.FormationID
    JOIN SessionTypes st ON tf.SessionTypeID = st.SessionTypeID
    WHERE tfp.MemberID = cm.MemberID
    AND st.Type = 'Game'
    AND tf.Score < (
        SELECT tf2.Score
        FROM TeamFormations tf2
        WHERE tf2.FormationID = tf.FormationID
        AND tf2.TeamID != tf.TeamID
    )
)
ORDER BY l.Name, cm.MemberID;

-- Query 17: Get treasurer history
SELECT 
    CONCAT(ci.FirstName, ' ', ci.LastName) as TreasurerName,
    MIN(pa.StartDate) as StartDate,
    MAX(pa.EndDate) as EndDate
FROM Personnel p
JOIN CommonInfo ci ON p.CommonID = ci.CommonID
JOIN Personnel_Assignments pa ON p.PersonnelID = pa.PersonnelID
WHERE p.Role = 'Treasurer'
GROUP BY p.PersonnelID
ORDER BY ci.FirstName, ci.LastName, MIN(pa.StartDate);

-- Query 18: Get deactivated members
SELECT 
    CONCAT(ci.FirstName, ' ', ci.LastName) as MemberName,
    ci.PhoneNumber,
    ci.Email,
    el.EmailDate as DeactivationDate,
    l.Name as LastLocation,
    pr.RoleName as LastRole
FROM EmailLogs el
JOIN CommonInfo ci ON el.Recipient = ci.Email
JOIN ClubMembers cm ON ci.CommonID = cm.CommonID
JOIN Locations l ON cm.LocationID = l.LocationID
JOIN TeamFormationPlayers tfp ON cm.MemberID = tfp.MemberID
JOIN PlayerRoles pr ON tfp.RoleID = pr.RoleID
WHERE el.EmailType = 'Deactivation'
AND tfp.FormationID = (
    SELECT MAX(FormationID)
    FROM TeamFormationPlayers
    WHERE MemberID = cm.MemberID
)
ORDER BY l.Name, pr.RoleName, ci.FirstName, ci.LastName;
