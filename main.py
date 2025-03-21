from flask import Flask, request, jsonify
from flask_cors import CORS
import pymysql
from datetime import datetime, timedelta
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

app = Flask(__name__)

# Enable CORS for all domains (or restrict to specific domains for more security)
CORS(app, origins="http://localhost:63342")

# Database connection parameters
host = 'localhost'
user = 'root'
password = 'n3u8c5t9A!'
database = 'warmup'

# Email configuration
SMTP_SERVER = 'smtp.gmail.com'
SMTP_PORT = 587
SMTP_USERNAME = 'your-email@gmail.com'
SMTP_PASSWORD = 'your-app-password'

# Create a database connection
def get_db_connection():
    return pymysql.connect(host=host, user=user, password=password, database=database)

def send_email(recipient, subject, body):
    try:
        msg = MIMEMultipart()
        msg['From'] = SMTP_USERNAME
        msg['To'] = recipient
        msg['Subject'] = subject
        msg.attach(MIMEText(body, 'plain'))
        
        server = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
        server.starttls()
        server.login(SMTP_USERNAME, SMTP_PASSWORD)
        server.send_message(msg)
        server.quit()
        return True
    except Exception as e:
        print(f"Error sending email: {str(e)}")
        return False

@app.route('/get_table', methods=['GET'])
def get_table():
    table_name = request.args.get('name')
    connection = get_db_connection()
    cursor = connection.cursor(pymysql.cursors.DictCursor)

    try:
        query = f"SELECT * FROM {table_name}"
        cursor.execute(query)
        result = cursor.fetchall()
        return jsonify(result)
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        cursor.close()
        connection.close()

@app.route('/execute_query', methods=['GET'])
def execute_query():
    query_number = request.args.get('query')
    locationID = request.args.get('locationID')
    familyMemberID = request.args.get('familyMemberID')
    clubMemberID = request.args.get('clubMemberID')
    startDate = request.args.get('startDate')
    endDate = request.args.get('endDate')
    connection = get_db_connection()
    cursor = connection.cursor(pymysql.cursors.DictCursor)

    try:
        if query_number == '7':
            query = """SELECT 
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
                    ORDER BY l.Province, l.City;"""
        elif query_number == '8':
            query = f"""SELECT 
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
                    WHERE fm.FamilyMemberID = {familyMemberID};"""
        elif query_number == '9':
            query = f"""SELECT 
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
                    ORDER BY tf.SessionDate, tf.StartTime;"""
        elif query_number == '10':
            query = """SELECT 
                        cm.MemberID,
                        CONCAT(ci.FirstName, ' ', ci.LastName) as MemberName
                    FROM ClubMembers cm
                    JOIN CommonInfo ci ON cm.CommonID = ci.CommonID
                    WHERE cm.LocationID IS NOT NULL
                    AND TIMESTAMPDIFF(YEAR, ci.DateOfBirth, CURDATE()) BETWEEN 11 AND 18
                    GROUP BY cm.MemberID
                    HAVING COUNT(DISTINCT cm.LocationID) >= 3
                    AND MAX(TIMESTAMPDIFF(YEAR, ci.DateOfBirth, CURDATE())) <= 3
                    ORDER BY cm.MemberID;"""
        elif query_number == '11':
            query = f"""SELECT 
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
                    WHERE tf.SessionDate BETWEEN '{startDate}' AND '{endDate}'
                    GROUP BY l.LocationID
                    HAVING COUNT(CASE WHEN st.Type = 'Game' THEN 1 END) >= 2
                    ORDER BY COUNT(CASE WHEN st.Type = 'Game' THEN 1 END) DESC;"""
        elif query_number == '12':
            query = """SELECT 
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
                    ORDER BY l.Name, cm.MemberID;"""
        elif query_number == '13':
            query = """SELECT 
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
                    ORDER BY l.Name, cm.MemberID;"""
        elif query_number == '14':
            query = """SELECT 
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
                    ORDER BY l.Name, cm.MemberID;"""
        elif query_number == '15':
            query = f"""SELECT 
                        CONCAT(ci.FirstName, ' ', ci.LastName) as FamilyMemberName,
                        ci.PhoneNumber
                    FROM FamilyMembers fm
                    JOIN CommonInfo ci ON fm.CommonID = ci.CommonID
                    JOIN ClubMembers cm ON fm.FamilyMemberID = cm.FamilyMemberID
                    JOIN TeamFormationPlayers tfp ON cm.MemberID = tfp.MemberID
                    JOIN TeamFormations tf ON tfp.FormationID = tf.FormationID
                    JOIN Teams t ON tf.TeamID = t.TeamID
                    WHERE t.LocationID = {locationID}
                    AND EXISTS (
                        SELECT 1 FROM TeamFormationPlayers tfp2
                        JOIN PlayerRoles pr ON tfp2.RoleID = pr.RoleID
                        WHERE tfp2.MemberID = cm.MemberID
                        AND pr.RoleName = 'Captain'
                    )
                    GROUP BY fm.FamilyMemberID;"""
        elif query_number == '16':
            query = """SELECT 
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
                    ORDER BY l.Name, cm.MemberID;"""
        elif query_number == '17':
            query = """SELECT 
                        CONCAT(ci.FirstName, ' ', ci.LastName) as TreasurerName,
                        MIN(pa.StartDate) as StartDate,
                        MAX(pa.EndDate) as EndDate
                    FROM Personnel p
                    JOIN CommonInfo ci ON p.CommonID = ci.CommonID
                    JOIN Personnel_Assignments pa ON p.PersonnelID = pa.PersonnelID
                    WHERE p.Role = 'Treasurer'
                    GROUP BY p.PersonnelID
                    ORDER BY ci.FirstName, ci.LastName, MIN(pa.StartDate);"""
        elif query_number == '18':
            query = """SELECT 
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
                    ORDER BY l.Name, pr.RoleName, ci.FirstName, ci.LastName;"""
        else:
            return jsonify({'error': 'Invalid query number'}), 400

        cursor.execute(query)
        result = cursor.fetchall()
        return jsonify(result)

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        cursor.close()
        connection.close()

@app.route('/send_team_formation_email', methods=['POST'])
def send_team_formation_email():
    connection = get_db_connection()
    cursor = connection.cursor(pymysql.cursors.DictCursor)

    try:
        # Get all team formations for the coming week
        next_week_start = datetime.now() + timedelta(days=7)
        next_week_end = next_week_start + timedelta(days=7)

        query = """SELECT 
                    tf.FormationID,
                    t.TeamName,
                    tf.SessionDate,
                    tf.StartTime,
                    tf.Address,
                    st.Type as SessionType,
                    CONCAT(cmci.FirstName, ' ', cmci.LastName) as PlayerName,
                    pr.RoleName as PlayerRole,
                    cmci.Email as PlayerEmail,
                    CONCAT(p.FirstName, ' ', p.LastName) as CoachName,
                    p.Email as CoachEmail
                FROM TeamFormations tf
                JOIN Teams t ON tf.TeamID = t.TeamID
                JOIN SessionTypes st ON tf.SessionTypeID = st.SessionTypeID
                JOIN TeamFormationPlayers tfp ON tf.FormationID = tfp.FormationID
                JOIN ClubMembers cm ON tfp.MemberID = cm.MemberID
                JOIN CommonInfo cmci ON cm.CommonID = cmci.CommonID
                JOIN PlayerRoles pr ON tfp.RoleID = pr.RoleID
                JOIN Personnel per ON t.LocationID = per.LocationID AND per.Role = 'Coach'
                JOIN CommonInfo p ON per.CommonID = p.CommonID
                WHERE tf.SessionDate BETWEEN %s AND %s"""

        cursor.execute(query, (next_week_start.date(), next_week_end.date()))
        formations = cursor.fetchall()

        for formation in formations:
            subject = f"{formation['TeamName']} {formation['SessionDate'].strftime('%d-%b-%Y')} {formation['StartTime'].strftime('%I:%M %p')} {formation['SessionType'].lower()} session"
            body = f"""Dear {formation['PlayerName']},

You are assigned as {formation['PlayerRole']} for the {formation['SessionType'].lower()} session.

Coach: {formation['CoachName']} ({formation['CoachEmail']})
Session Type: {formation['SessionType']}
Address: {formation['Address']}

Best regards,
MYVC Team"""

            if send_email(formation['PlayerEmail'], subject, body):
                # Log the email
                cursor.execute("""
                    INSERT INTO EmailLogs (EmailDate, Sender, Recipient, Subject, BodyPreview, EmailType)
                    VALUES (%s, %s, %s, %s, %s, %s)
                """, (
                    datetime.now(),
                    'system@myvc.com',
                    formation['PlayerEmail'],
                    subject,
                    body[:100],
                    'TeamFormation'
                ))

        connection.commit()
        return jsonify({'message': 'Team formation emails sent successfully'})

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        cursor.close()
        connection.close()

@app.route('/check_member_age', methods=['POST'])
def check_member_age():
    connection = get_db_connection()
    cursor = connection.cursor(pymysql.cursors.DictCursor)

    try:
        # Get members who turned 18 in the previous month
        query = """SELECT 
                    cm.MemberID,
                    ci.FirstName,
                    ci.LastName,
                    ci.Email,
                    ci.DateOfBirth,
                    l.Name as LocationName,
                    pr.RoleName as LastRole
                FROM ClubMembers cm
                JOIN CommonInfo ci ON cm.CommonID = ci.CommonID
                JOIN Locations l ON cm.LocationID = l.LocationID
                JOIN TeamFormationPlayers tfp ON cm.MemberID = tfp.MemberID
                JOIN PlayerRoles pr ON tfp.RoleID = pr.RoleID
                WHERE TIMESTAMPDIFF(YEAR, ci.DateOfBirth, CURDATE()) = 18
                AND MONTH(ci.DateOfBirth) = MONTH(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
                AND YEAR(ci.DateOfBirth) = YEAR(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
                AND tfp.FormationID = (
                    SELECT MAX(FormationID)
                    FROM TeamFormationPlayers
                    WHERE MemberID = cm.MemberID
                )"""

        cursor.execute(query)
        members = cursor.fetchall()

        for member in members:
            # Deactivate membership
            cursor.execute("""
                UPDATE ClubMembers 
                SET LocationID = NULL 
                WHERE MemberID = %s
            """, (member['MemberID'],))

            # Send deactivation email
            subject = "Membership Deactivation Notice"
            body = f"""Dear {member['FirstName']} {member['LastName']},

Your membership has been deactivated as you have reached the age of 18.

Last Location: {member['LocationName']}
Last Role: {member['LastRole']}

Thank you for being a member of MYVC.

Best regards,
MYVC Team"""

            if send_email(member['Email'], subject, body):
                # Log the email
                cursor.execute("""
                    INSERT INTO EmailLogs (EmailDate, Sender, Recipient, Subject, BodyPreview, EmailType)
                    VALUES (%s, %s, %s, %s, %s, %s)
                """, (
                    datetime.now(),
                    'system@myvc.com',
                    member['Email'],
                    subject,
                    body[:100],
                    'Deactivation'
                ))

        connection.commit()
        return jsonify({'message': 'Member age check completed successfully'})

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        cursor.close()
        connection.close()

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
