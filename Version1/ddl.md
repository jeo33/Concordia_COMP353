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
DROP TABLE IF EXISTS ClubMembers_Locations;


SET FOREIGN_KEY_CHECKS = 1;


CREATE TABLE Period (
  PeriodID INT AUTO_INCREMENT PRIMARY KEY,
  StartDate DATE NOT NULL,
  EndDate DATE
);

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

CREATE TABLE Personnel (
  PersonnelID INT AUTO_INCREMENT PRIMARY KEY,
  CommonID INT NOT NULL,
  Role ENUM('Administrator', 'Captain', 'Coach', 'Assistant Coach', 'Other', 'General Manager', 'Deputy Manager', 'Treasurer', 'Secretary') NOT NULL,
  Mandate ENUM('Volunteer', 'Salaried') NOT NULL,
  LocationID INT NOT NULL,
  FOREIGN KEY (CommonID) REFERENCES CommonInfo(CommonID),
  FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

CREATE TABLE Personnel_Assignments (
  AssignmentID INT AUTO_INCREMENT PRIMARY KEY,
  PersonnelID INT NOT NULL,
  LocationID INT NOT NULL,
  PeriodID INT NOT NULL,
  FOREIGN KEY (PersonnelID) REFERENCES Personnel(PersonnelID),
  FOREIGN KEY (LocationID) REFERENCES Locations(LocationID),
  FOREIGN KEY (PeriodID) REFERENCES Period(PeriodID)
);

CREATE TABLE FamilyMembers (
  FamilyMemberID INT AUTO_INCREMENT PRIMARY KEY,
  CommonID INT NOT NULL,
  LocationID INT,
  Relationship ENUM('Father', 'Mother', 'Grandfather', 'Grandmother', 'Tutor', 'Partner', 'Friend', 'Other'),
  FOREIGN KEY (LocationID) REFERENCES Locations(LocationID),
  FOREIGN KEY (CommonID) REFERENCES CommonInfo(CommonID)
);

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

CREATE TABLE Memberships (
  MembershipID INT AUTO_INCREMENT PRIMARY KEY,
  MemberID INT NOT NULL,
  Year INT NOT NULL,
  Status ENUM('Active', 'Inactive') DEFAULT 'Active',
  TotalPaid DECIMAL(10, 2) DEFAULT 0,
  DonationAmount DECIMAL(10, 2) AS (GREATEST(TotalPaid - 100, 0)) STORED,
  FOREIGN KEY (MemberID) REFERENCES ClubMembers(MemberID)
);
ALTER TABLE Memberships
ADD COLUMN Deactivation boolean;
CREATE TABLE Teams (
  TeamID INT AUTO_INCREMENT PRIMARY KEY,
  TeamName VARCHAR(100),
  TeamType ENUM('Boys', 'Girls'),
  LocationID INT NOT NULL,
  FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

CREATE TABLE ClubMembers_Teams (
  TeamID INT,
  MemberID INT,
  LocationID INT,
  PRIMARY KEY (TeamID, MemberID),
  FOREIGN KEY (TeamID) REFERENCES Teams(TeamID),
  FOREIGN KEY (MemberID) REFERENCES ClubMembers(MemberID),
  FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

CREATE TABLE Payments (
  PaymentID INT AUTO_INCREMENT PRIMARY KEY,
  MembershipID INT NOT NULL,
  PaymentDate DATE NOT NULL,
  Amount DECIMAL(10, 2) NOT NULL,
  PaymentMethod ENUM('Cash', 'Debit', 'Credit'),
  FOREIGN KEY (MembershipID) REFERENCES Memberships(MembershipID)
);

CREATE TABLE SessionTypes (
  SessionTypeID INT AUTO_INCREMENT PRIMARY KEY,
  Type ENUM('Training', 'Game') NOT NULL
);
INSERT INTO SessionTypes (Type) VALUES ('Training'), ('Game');

CREATE TABLE PlayerRoles (
  RoleID INT AUTO_INCREMENT PRIMARY KEY,
  RoleName ENUM('Outside Hitter', 'Opposite', 'Setter', 'Middle Blocker', 'Libero', 'Defensive Specialist', 'Serving Specialist') NOT NULL
);
INSERT INTO PlayerRoles (RoleName) VALUES ('Outside Hitter'), ('Opposite'), ('Setter'), ('Middle Blocker'), ('Libero'), ('Defensive Specialist'), ('Serving Specialist');



CREATE TABLE TeamFormations (
  FormationID INT AUTO_INCREMENT PRIMARY KEY,
  Team1ID INT NOT NULL,
  SessionTypeID INT NOT NULL,
  SessionDate DATE NOT NULL,
  StartTime TIME NOT NULL,
  EndTime TIME NOT NULL,
  LocationID INT NOT NULL,  -- Add LocationID as foreign key
  Team1Score INT DEFAULT 0,
  FOREIGN KEY (Team1ID) REFERENCES Teams(TeamID),
  FOREIGN KEY (SessionTypeID) REFERENCES SessionTypes(SessionTypeID),
  FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)  -- Foreign key reference to Locations
);



CREATE TABLE TeamFormationPlayers (
  FormationID INT NOT NULL,
  TeamID INT NOT NULL,
  MemberID INT NOT NULL,
  RoleID INT NOT NULL,
  PRIMARY KEY (FormationID, MemberID, RoleID),
  FOREIGN KEY (FormationID) REFERENCES TeamFormations(FormationID),
  FOREIGN KEY (TeamID) REFERENCES Teams(TeamID),
  FOREIGN KEY (MemberID) REFERENCES ClubMembers(MemberID),
  FOREIGN KEY (RoleID) REFERENCES PlayerRoles(RoleID)
);


CREATE TABLE EmailLogs (
  EmailLogID INT AUTO_INCREMENT PRIMARY KEY,
  EmailDate DATETIME NOT NULL,
  Sender VARCHAR(100) NOT NULL,
  Recipient VARCHAR(100) NOT NULL,
  CCList VARCHAR(255),
  Subject VARCHAR(255) NOT NULL,
  BodyPreview VARCHAR(100) NOT NULL,
  EmailType ENUM('Team Formation', 'Deactivation') NOT NULL
);

CREATE TABLE SecondaryFamilyMembers (
  SecondaryID INT AUTO_INCREMENT PRIMARY KEY,
  PrimaryFamilyMemberID INT NOT NULL,
  CommonID INT NOT NULL,
  Relationship ENUM('Father', 'Mother', 'Grandfather', 'Grandmother', 'Uncle', 'Aunt', 'Tutor', 'Partner', 'Friend', 'Other') NOT NULL,
  FOREIGN KEY (PrimaryFamilyMemberID) REFERENCES FamilyMembers(FamilyMemberID),
  FOREIGN KEY (CommonID) REFERENCES CommonInfo(CommonID)
);




CREATE TABLE ClubMembers_Locations (
  MemberID INT NOT NULL,
  LocationID INT NOT NULL,
  Current_location BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (MemberID, LocationID),
  FOREIGN KEY (MemberID) REFERENCES ClubMembers(MemberID),
  FOREIGN KEY (LocationID) REFERENCES Locations(LocationID) 
);


