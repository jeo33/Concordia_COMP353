DROP TABLE IF EXISTS Payments, FamilyRelationships, ClubMembers, FamilyMembers, PersonnelLocation, Personnel, Locations;

CREATE TABLE Locations (
    LocationID INT AUTO_INCREMENT PRIMARY KEY,
    Type ENUM('Head', 'Branch') NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(100) NOT NULL,
    Province VARCHAR(100) NOT NULL,
    PostalCode VARCHAR(10) NOT NULL,
    PhoneNumber VARCHAR(15),
    WebAddress VARCHAR(255),
    MaxCapacity INT NOT NULL
);

CREATE TABLE Personnel (
    PersonnelID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    SocialSecurityNumber VARCHAR(15) NOT NULL UNIQUE,
    MedicareCardNumber VARCHAR(15) NOT NULL UNIQUE,
    TelephoneNumber VARCHAR(15),
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(100) NOT NULL,
    Province VARCHAR(100) NOT NULL,
    PostalCode VARCHAR(10) NOT NULL,
    EmailAddress VARCHAR(100),
    Role ENUM('Administrator', 'Captain', 'Coach', 'Assistant Coach', 'Other') NOT NULL,
    Mandate ENUM('Volunteer', 'Salaried') NOT NULL
);

CREATE TABLE PersonnelLocation (
    PersonnelLocationID INT AUTO_INCREMENT PRIMARY KEY,
    PersonnelID INT NOT NULL,
    LocationID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    FOREIGN KEY (PersonnelID) REFERENCES Personnel(PersonnelID),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

CREATE TABLE FamilyMembers (
    FamilyMemberID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    SocialSecurityNumber VARCHAR(15) NOT NULL UNIQUE,
    MedicareCardNumber VARCHAR(15) NOT NULL UNIQUE,
    TelephoneNumber VARCHAR(15),
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(100) NOT NULL,
    Province VARCHAR(100) NOT NULL,
    PostalCode VARCHAR(10) NOT NULL,
    EmailAddress VARCHAR(100),
    LocationID INT NOT NULL,
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

CREATE TABLE ClubMembers (
    ClubMemberID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Height DECIMAL(5,2),
    Weight DECIMAL(5,2),
    SocialSecurityNumber VARCHAR(15) NOT NULL UNIQUE,
    MedicareCardNumber VARCHAR(15) NOT NULL UNIQUE,
    TelephoneNumber VARCHAR(15),
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(100) NOT NULL,
    Province VARCHAR(100) NOT NULL,
    PostalCode VARCHAR(10) NOT NULL,
    FamilyMemberID INT NOT NULL,
    LocationID INT NOT NULL,
    FOREIGN KEY (FamilyMemberID) REFERENCES FamilyMembers(FamilyMemberID),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

CREATE TABLE FamilyRelationships (
    FamilyRelationshipID INT AUTO_INCREMENT PRIMARY KEY,
    FamilyMemberID INT NOT NULL,
    ClubMemberID INT NOT NULL,
    Relationship ENUM('Father', 'Mother', 'Grandfather', 'Grandmother', 'Tutor', 'Partner', 'Friend', 'Other') NOT NULL,
    FOREIGN KEY (FamilyMemberID) REFERENCES FamilyMembers(FamilyMemberID),
    FOREIGN KEY (ClubMemberID) REFERENCES ClubMembers(ClubMemberID)
);

CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    ClubMemberID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod ENUM('Cash', 'Debit Card', 'Credit Card') NOT NULL,
    MembershipYear INT NOT NULL,
    FOREIGN KEY (ClubMemberID) REFERENCES ClubMembers(ClubMemberID)
);

SELECT 
    l.*,
    p.FirstName AS GeneralManagerFirstName,
    p.LastName AS GeneralManagerLastName,
    (SELECT COUNT(*) FROM PersonnelLocation pl WHERE pl.LocationID = l.LocationID) AS NumberOfPersonnel,
    (SELECT COUNT(*) FROM ClubMembers cm WHERE cm.LocationID = l.LocationID) AS NumberOfClubMembers
FROM 
    Locations l
LEFT JOIN 
    PersonnelLocation pl ON l.LocationID = pl.LocationID
LEFT JOIN 
    Personnel p ON pl.PersonnelID = p.PersonnelID AND p.Role = 'Administrator'
ORDER BY 
    Province ASC, City ASC;

SELECT 
    fm.FirstName, 
    fm.LastName,
    COUNT(cm.ClubMemberID) AS ActiveClubMembersCount
FROM 
    FamilyMembers fm
LEFT JOIN 
    ClubMembers cm ON fm.FamilyMemberID = cm.FamilyMemberID
WHERE 
    cm.LocationID = <LOCATION_ID>
    AND TIMESTAMPDIFF(YEAR, cm.DateOfBirth, CURDATE()) BETWEEN 11 AND 18
GROUP BY 
    fm.FamilyMemberID;

SELECT 
    p.*,
    pl.StartDate,
    pl.EndDate
FROM 
    Personnel p
JOIN 
    PersonnelLocation pl ON p.PersonnelID = pl.PersonnelID
WHERE 
    pl.LocationID = <LOCATION_ID> 
    AND (pl.EndDate IS NULL OR pl.EndDate > CURDATE());

SELECT 
    cm.*,
    l.Name AS LocationName
FROM 
    ClubMembers cm
LEFT JOIN 
    Locations l ON cm.LocationID = l.LocationID;
