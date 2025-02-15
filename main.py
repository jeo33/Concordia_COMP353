from flask import Flask, request, jsonify
from flask_cors import CORS
import pymysql

app = Flask(__name__)

# Enable CORS for all domains (or restrict to specific domains for more security)
CORS(app, origins="http://localhost:63342")

# Database connection parameters
host = 'localhost'
user = 'root'
password = 'n3u8c5t9A!'
database = 'warmup'

# Create a database connection
def get_db_connection():
    return pymysql.connect(host=host, user=user, password=password, database=database)

@app.route('/get_table', methods=['GET'])
def get_table():
    table_name = request.args.get('name')
    connection = get_db_connection()
    cursor = connection.cursor(pymysql.cursors.DictCursor)

    try:
        # SQL query to fetch data from the table
        query = f"SELECT * FROM {table_name}"
        cursor.execute(query)
        result = cursor.fetchall()

        return jsonify(result)  # Send data as JSON

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
    connection = get_db_connection()
    cursor = connection.cursor(pymysql.cursors.DictCursor)

    try:
        if query_number == '1':
            query = """SELECT 
                        l.Name AS LocationName,
                        l.Address,
                        l.City,
                        l.Province,
                        l.PostalCode,
                        l.PhoneNumber,
                        l.WebAddress,
                        l.Type AS LocationType,
                        l.MaxCapacity,
                        (SELECT FirstName FROM Personnel p JOIN CommonInfo c ON p.CommonID = c.CommonID WHERE p.Role = 'General Manager' AND p.LocationID = l.LocationID LIMIT 1) AS GeneralManagerName,
                        (SELECT COUNT(*) FROM Personnel p WHERE p.LocationID = l.LocationID) AS PersonnelCount,
                        (SELECT COUNT(*) FROM ClubMembers cm WHERE cm.LocationID = l.LocationID) AS ClubMembersCount
                        FROM Locations l
                        ORDER BY l.Province, l.City;"""
        elif query_number == '2':
            query = f"""SELECT 
                        ci.FirstName AS FamilyMemberFirstName,
                        ci.LastName AS FamilyMemberLastName,
                        COUNT(cm.MemberID) AS ActiveClubMembersCount
                        FROM FamilyMembers fm
                        JOIN CommonInfo ci ON fm.CommonID = ci.CommonID
                        JOIN ClubMembers cm ON fm.FamilyMemberID = cm.FamilyMemberID
                        JOIN Memberships m ON cm.MemberID = m.MemberID
                        JOIN Locations l ON fm.LocationID = l.LocationID
                        WHERE l.LocationID = {locationID}
                        AND m.Status = 'Active'
                        GROUP BY fm.FamilyMemberID;"""
        elif query_number == '3':
            query = f"""SELECT 
                        ci.FirstName,
                        ci.LastName,
                        ci.DateOfBirth,
                        ci.SSN,
                        ci.MedicareCardNumber,
                        ci.PhoneNumber,
                        ci.Address,
                        ci.City,
                        ci.Province,
                        ci.PostalCode,
                        ci.Email,
                        p.Role,
                        p.Mandate
                        FROM Personnel p
                        JOIN CommonInfo ci ON p.CommonID = ci.CommonID
                        JOIN Personnel_Assignments pa ON p.PersonnelID = pa.PersonnelID
                        JOIN Locations l ON pa.LocationID = l.LocationID
                        WHERE l.LocationID = {locationID};"""
        elif query_number == '4':
            query = """SELECT 
                        l.Name AS LocationName,
                        cm.MemberID AS MembershipNumber,
                        ci.FirstName,
                        ci.LastName,
                        TIMESTAMPDIFF(YEAR, ci.DateOfBirth, CURDATE()) AS Age,
                        ci.City,
                        ci.Province,
                        m.Status
                        FROM ClubMembers cm
                        JOIN CommonInfo ci ON cm.CommonID = ci.CommonID
                        JOIN Memberships m ON cm.MemberID = m.MemberID
                        JOIN Locations l ON cm.LocationID = l.LocationID
                        WHERE m.Status IN ('Active', 'Inactive')
                        ORDER BY l.Name ASC, Age ASC;"""
        elif query_number == '5':
            query = f"""SELECT 
                        m.MembershipID AS ClubMembershipNumber,
                        ci.FirstName,
                        ci.LastName,
                        ci.DateOfBirth,
                        ci.SSN,
                        ci.MedicareCardNumber,
                        ci.PhoneNumber,
                        ci.Address,
                        ci.City,
                        ci.Province,
                        ci.PostalCode,
                        fm.Relationship,
                        m.Status
                        FROM ClubMembers cm
                        JOIN CommonInfo ci ON cm.CommonID = ci.CommonID
                        JOIN Memberships m ON cm.MemberID = m.MemberID
                        JOIN FamilyMembers fm ON cm.FamilyMemberID = fm.FamilyMemberID
                        WHERE fm.FamilyMemberID = {familyMemberID}
                        ORDER BY m.MembershipID;"""
        elif query_number == '6':
            query = f"""SELECT 
                        ci.FirstName AS FamilyMemberFirstName,
                        ci.LastName AS FamilyMemberLastName,
                        ci.PhoneNumber AS FamilyMemberPhoneNumber
                        FROM FamilyMembers fm
                        JOIN CommonInfo ci ON fm.CommonID = ci.CommonID
                        JOIN ClubMembers cm ON fm.FamilyMemberID = cm.FamilyMemberID
                        JOIN Memberships m ON cm.MemberID = m.MemberID
                        JOIN Personnel_Assignments pa ON pa.LocationID = fm.LocationID
                        JOIN Personnel p ON p.PersonnelID = pa.PersonnelID
                        JOIN Locations l ON fm.LocationID = l.LocationID
                        WHERE m.Status = 'Active'
                        AND p.LocationID = fm.LocationID
                        AND p.Role IN ('General Manager', 'Deputy Manager', 'Treasurer', 'Secretary', 'Coach', 'Assistant Coach', 'Captain')  -- Operator roles
                        AND fm.LocationID = {locationID}
                        ORDER BY ci.FirstName, ci.LastName;"""
        elif query_number == '7':
            query = f"""SELECT 
                        p.PaymentDate,
                        p.Amount,
                        YEAR(p.PaymentDate) AS YearPaid
                        FROM Payments p
                        JOIN Memberships m ON p.MembershipID = m.MembershipID
                        WHERE m.MemberID = {clubMemberID}
                        ORDER BY p.PaymentDate;"""
        elif query_number == '8':
            query = """SELECT 
                        SUM(p.Amount) AS TotalMembershipFeesPaid,
                        SUM(m.DonationAmount) AS TotalDonationsCollected
                        FROM Payments p
                        JOIN Memberships m ON p.MembershipID = m.MembershipID
                        WHERE YEAR(p.PaymentDate) = 2025;"""
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

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
