# Montréal Youth Volleyball Club Database System
## Project Report

### 1. Introduction
The Montréal Youth Volleyball Club (MYVC) database system is designed to manage club members, personnel, family members, teams, and financial transactions. The system provides a comprehensive solution for tracking member information, team formations, email notifications, and ensuring age and time conflict validations.

### 2. System Architecture

#### 2.1 Database Design
The system uses a MySQL database with the following key components:

- **Core Tables**:
  - `Locations`: Stores information about club locations
  - `CommonInfo`: Stores shared personal information
  - `Personnel`: Manages staff and volunteers
  - `FamilyMembers`: Tracks primary family members
  - `ClubMembers`: Manages club member information
  - `Teams`: Stores team information
  - `TeamFormations`: Tracks game and training sessions
  - `TeamFormationPlayers`: Links players to formations with roles

- **Supporting Tables**:
  - `SessionTypes`: Categorizes sessions (Training/Game)
  - `PlayerRoles`: Defines possible player roles
  - `EmailLogs`: Tracks system-generated emails
  - `SecondaryFamilyMembers`: Manages secondary family members

#### 2.2 Application Architecture
- **Backend**: Flask-based REST API
- **Frontend**: HTML/CSS/JavaScript web interface
- **Email System**: SMTP-based notification system

### 3. Key Features

#### 3.1 Member Management
- Age validation (11-18 years)
- Automatic membership deactivation at age 18
- Family member relationship tracking
- Secondary family member support

#### 3.2 Team Management
- Team formation tracking
- Player role assignment
- Session scheduling
- Time conflict prevention

#### 3.3 Communication
- Automated email notifications for:
  - Team formation details
  - Membership deactivation
- Email logging system

### 4. Database Queries

#### 4.1 Location Management
```sql
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
```

#### 4.2 Team Formation Reports
```sql
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
WHERE t.LocationID = {locationID}
AND tf.SessionDate BETWEEN '{startDate}' AND '{endDate}'
ORDER BY tf.SessionDate, tf.StartTime;
```

### 5. System Constraints

#### 5.1 Age Validation
```sql
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
END;
```

#### 5.2 Time Conflict Prevention
```sql
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
END;
```

### 6. User Interface

The system provides a modern, user-friendly interface with:
- Easy navigation between different sections
- Clear display of query results
- Input validation for parameters
- Error handling and user feedback
- Responsive design for different screen sizes

### 7. Future Enhancements
1. Mobile application development
2. Advanced reporting features
3. Integration with external volleyball leagues
4. Enhanced email notification system
5. Member performance tracking

### 8. Conclusion
The MYVC database system successfully meets all requirements for managing club members, teams, and communications. The system provides a robust foundation for future enhancements and scalability.