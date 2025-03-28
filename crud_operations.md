# CRUD Operations for MYVC Database System

## 1. Location Management

### Create Location
```sql
INSERT INTO Locations (Name, Type, Address, City, Province, PostalCode, PhoneNumber, WebAddress, MaxCapacity)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
```

### Read Location
```sql
SELECT * FROM Locations WHERE LocationID = ?;
```

### Update Location
```sql
UPDATE Locations 
SET Name = ?, Type = ?, Address = ?, City = ?, Province = ?, 
    PostalCode = ?, PhoneNumber = ?, WebAddress = ?, MaxCapacity = ?
WHERE LocationID = ?;
```

### Delete Location
```sql
DELETE FROM Locations WHERE LocationID = ?;
```

## 2. Personnel Management

### Create Personnel
```sql
-- First create CommonInfo
INSERT INTO CommonInfo (FirstName, LastName, DateOfBirth, SSN, MedicareCardNumber, 
                       PhoneNumber, Email, Address, City, Province, PostalCode)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);

-- Then create Personnel
INSERT INTO Personnel (CommonID, Role, Mandate, LocationID)
VALUES (LAST_INSERT_ID(), ?, ?, ?);
```

### Read Personnel
```sql
SELECT p.*, c.* 
FROM Personnel p
JOIN CommonInfo c ON p.CommonID = c.CommonID
WHERE p.PersonnelID = ?;
```

### Update Personnel
```sql
-- Update CommonInfo
UPDATE CommonInfo 
SET FirstName = ?, LastName = ?, DateOfBirth = ?, SSN = ?, MedicareCardNumber = ?,
    PhoneNumber = ?, Email = ?, Address = ?, City = ?, Province = ?, PostalCode = ?
WHERE CommonID = (SELECT CommonID FROM Personnel WHERE PersonnelID = ?);

-- Update Personnel
UPDATE Personnel 
SET Role = ?, Mandate = ?, LocationID = ?
WHERE PersonnelID = ?;
```

### Delete Personnel
```sql
DELETE FROM Personnel WHERE PersonnelID = ?;
```

## 3. Family Member Management

### Create Family Member
```sql
-- First create CommonInfo
INSERT INTO CommonInfo (FirstName, LastName, DateOfBirth, SSN, MedicareCardNumber, 
                       PhoneNumber, Email, Address, City, Province, PostalCode)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);

-- Then create FamilyMember
INSERT INTO FamilyMembers (CommonID, LocationID, Relationship)
VALUES (LAST_INSERT_ID(), ?, ?);
```

### Read Family Member
```sql
SELECT f.*, c.* 
FROM FamilyMembers f
JOIN CommonInfo c ON f.CommonID = c.CommonID
WHERE f.FamilyMemberID = ?;
```

### Update Family Member
```sql
-- Update CommonInfo
UPDATE CommonInfo 
SET FirstName = ?, LastName = ?, DateOfBirth = ?, SSN = ?, MedicareCardNumber = ?,
    PhoneNumber = ?, Email = ?, Address = ?, City = ?, Province = ?, PostalCode = ?
WHERE CommonID = (SELECT CommonID FROM FamilyMembers WHERE FamilyMemberID = ?);

-- Update FamilyMember
UPDATE FamilyMembers 
SET LocationID = ?, Relationship = ?
WHERE FamilyMemberID = ?;
```

### Delete Family Member
```sql
DELETE FROM FamilyMembers WHERE FamilyMemberID = ?;
```

## 4. Club Member Management

### Create Club Member
```sql
-- First create CommonInfo
INSERT INTO CommonInfo (FirstName, LastName, DateOfBirth, SSN, MedicareCardNumber, 
                       PhoneNumber, Email, Address, City, Province, PostalCode)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);

-- Then create ClubMember
INSERT INTO ClubMembers (CommonID, FamilyMemberID, LocationID, Height, Weight)
VALUES (LAST_INSERT_ID(), ?, ?, ?, ?);
```

### Read Club Member
```sql
SELECT cm.*, c.*, f.*, l.Name as LocationName
FROM ClubMembers cm
JOIN CommonInfo c ON cm.CommonID = c.CommonID
JOIN FamilyMembers f ON cm.FamilyMemberID = f.FamilyMemberID
JOIN Locations l ON cm.LocationID = l.LocationID
WHERE cm.MemberID = ?;
```

### Update Club Member
```sql
-- Update CommonInfo
UPDATE CommonInfo 
SET FirstName = ?, LastName = ?, DateOfBirth = ?, SSN = ?, MedicareCardNumber = ?,
    PhoneNumber = ?, Email = ?, Address = ?, City = ?, Province = ?, PostalCode = ?
WHERE CommonID = (SELECT CommonID FROM ClubMembers WHERE MemberID = ?);

-- Update ClubMember
UPDATE ClubMembers 
SET FamilyMemberID = ?, LocationID = ?, Height = ?, Weight = ?
WHERE MemberID = ?;
```

### Delete Club Member
```sql
DELETE FROM ClubMembers WHERE MemberID = ?;
```

## 5. Team Formation Management

### Create Team Formation
```sql
INSERT INTO TeamFormations (TeamID, SessionTypeID, SessionDate, StartTime, EndTime, Address, Score)
VALUES (?, ?, ?, ?, ?, ?, ?);
```

### Read Team Formation
```sql
SELECT tf.*, t.TeamName, st.Type as SessionType
FROM TeamFormations tf
JOIN Teams t ON tf.TeamID = t.TeamID
JOIN SessionTypes st ON tf.SessionTypeID = st.SessionTypeID
WHERE tf.FormationID = ?;
```

### Update Team Formation
```sql
UPDATE TeamFormations 
SET TeamID = ?, SessionTypeID = ?, SessionDate = ?, StartTime = ?, 
    EndTime = ?, Address = ?, Score = ?
WHERE FormationID = ?;
```

### Delete Team Formation
```sql
DELETE FROM TeamFormations WHERE FormationID = ?;
```

## 6. Team Formation Player Assignment

### Assign Player to Formation
```sql
INSERT INTO TeamFormationPlayers (FormationID, MemberID, RoleID)
VALUES (?, ?, ?);
```

### Read Player Assignment
```sql
SELECT tfp.*, c.FirstName, c.LastName, pr.RoleName
FROM TeamFormationPlayers tfp
JOIN ClubMembers cm ON tfp.MemberID = cm.MemberID
JOIN CommonInfo c ON cm.CommonID = c.CommonID
JOIN PlayerRoles pr ON tfp.RoleID = pr.RoleID
WHERE tfp.FormationID = ? AND tfp.MemberID = ?;
```

### Update Player Assignment
```sql
UPDATE TeamFormationPlayers 
SET RoleID = ?
WHERE FormationID = ? AND MemberID = ?;
```

### Remove Player from Formation
```sql
DELETE FROM TeamFormationPlayers 
WHERE FormationID = ? AND MemberID = ?;
```

## 7. Secondary Family Member Management

### Create Secondary Family Member
```sql
-- First create CommonInfo
INSERT INTO CommonInfo (FirstName, LastName, PhoneNumber)
VALUES (?, ?, ?);

-- Then create SecondaryFamilyMember
INSERT INTO SecondaryFamilyMembers (PrimaryFamilyMemberID, CommonID, Relationship)
VALUES (?, LAST_INSERT_ID(), ?);
```

### Read Secondary Family Member
```sql
SELECT sfm.*, c.*, fm.*
FROM SecondaryFamilyMembers sfm
JOIN CommonInfo c ON sfm.CommonID = c.CommonID
JOIN FamilyMembers fm ON sfm.PrimaryFamilyMemberID = fm.FamilyMemberID
WHERE sfm.SecondaryID = ?;
```

### Update Secondary Family Member
```sql
-- Update CommonInfo
UPDATE CommonInfo 
SET FirstName = ?, LastName = ?, PhoneNumber = ?
WHERE CommonID = (SELECT CommonID FROM SecondaryFamilyMembers WHERE SecondaryID = ?);

-- Update SecondaryFamilyMember
UPDATE SecondaryFamilyMembers 
SET PrimaryFamilyMemberID = ?, Relationship = ?
WHERE SecondaryID = ?;
```

### Delete Secondary Family Member
```sql
DELETE FROM SecondaryFamilyMembers WHERE SecondaryID = ?;
```

## 8. Email Management

### Create Email Log
```sql
INSERT INTO EmailLogs (EmailDate, Sender, Recipient, CCList, Subject, BodyPreview, EmailType)
VALUES (NOW(), ?, ?, ?, ?, ?, ?);
```

### Read Email Log
```sql
SELECT * FROM EmailLogs WHERE EmailLogID = ?;
```

### Update Email Log
```sql
UPDATE EmailLogs 
SET EmailDate = ?, Sender = ?, Recipient = ?, CCList = ?, 
    Subject = ?, BodyPreview = ?, EmailType = ?
WHERE EmailLogID = ?;
```

### Delete Email Log
```sql
DELETE FROM EmailLogs WHERE EmailLogID = ?;
``` 