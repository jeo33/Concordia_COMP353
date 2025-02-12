from flask import Flask, request, jsonify
from flask_cors import CORS  # For handling CORS
import pymysql

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Database configuration
db_config = {
    "host": "localhost",
    "user": "root",
    "password": "1234",
    "database": "mydb"
}

def get_db_connection():
    """Establish a database connection."""
    return pymysql.connect(
        host=db_config["host"],
        user=db_config["user"],
        password=db_config["password"],
        database=db_config["database"],
        cursorclass=pymysql.cursors.DictCursor
    )

@app.route("/locations", methods=["GET"])
def get_locations():
    """Retrieve all locations."""
    conn = get_db_connection()
    with conn.cursor() as cursor:
        cursor.execute("SELECT * FROM Locations")
        locations = cursor.fetchall()
    conn.close()
    return jsonify(locations)

@app.route("/locations/<int:location_id>", methods=["GET"])
def get_location(location_id):
    """Retrieve a specific location by ID."""
    conn = get_db_connection()
    with conn.cursor() as cursor:
        cursor.execute("SELECT * FROM Locations WHERE LocationID = %s", (location_id,))
        location = cursor.fetchone()
    conn.close()

    if not location:
        return jsonify({"error": "Location not found"}), 404
    return jsonify(location)

@app.route("/locations", methods=["POST"])
def add_location():
    """Add a new location."""
    data = request.json
    required_fields = ["Type", "Name", "Address", "City", "Province", "PostalCode", "MaxCapacity"]

    # Validate required fields
    for field in required_fields:
        if field not in data:
            return jsonify({"error": f"'{field}' is required"}), 400

    conn = get_db_connection()
    with conn.cursor() as cursor:
        sql = """
            INSERT INTO Locations (Type, Name, Address, City, Province, PostalCode, PhoneNumber, WebAddress, MaxCapacity)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        cursor.execute(sql, (
            data["Type"], data["Name"], data["Address"], data["City"], data["Province"],
            data["PostalCode"], data.get("PhoneNumber"), data.get("WebAddress"), data["MaxCapacity"]
        ))
        conn.commit()
        location_id = cursor.lastrowid
    conn.close()

    return jsonify({"message": "Location added successfully", "LocationID": location_id}), 201

@app.route("/locations/<int:location_id>", methods=["PUT"])
def update_location(location_id):
    """Update an existing location."""
    data = request.json

    conn = get_db_connection()
    with conn.cursor() as cursor:
        sql = """
            UPDATE Locations
            SET Type = %s, Name = %s, Address = %s, City = %s, Province = %s,
                PostalCode = %s, PhoneNumber = %s, WebAddress = %s, MaxCapacity = %s
            WHERE LocationID = %s
        """
        cursor.execute(sql, (
            data["Type"], data["Name"], data["Address"], data["City"], data["Province"],
            data["PostalCode"], data.get("PhoneNumber"), data.get("WebAddress"),
            data["MaxCapacity"], location_id
        ))
        conn.commit()
    conn.close()

    return jsonify({"message": "Location updated successfully"})

@app.route("/locations/<int:location_id>", methods=["DELETE"])
def delete_location(location_id):
    """Delete a location."""
    conn = get_db_connection()
    with conn.cursor() as cursor:
        cursor.execute("DELETE FROM Locations WHERE LocationID = %s", (location_id,))
        conn.commit()
    conn.close()

    return jsonify({"message": "Location deleted successfully"})

if __name__ == "__main__":
    app.run(debug=True)
