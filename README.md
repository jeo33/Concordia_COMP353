# Montréal Youth Volleyball Club Database System

A comprehensive database application system for managing the Montréal Youth Volleyball Club (MYVC), built for Concordia University's COMP 353 - Databases course.

## Features

- Member Management
  - Age validation (11-18 years)
  - Automatic membership deactivation at age 18
  - Family member relationship tracking
  - Secondary family member support

- Team Management
  - Team formation tracking
  - Player role assignment
  - Session scheduling
  - Time conflict prevention

- Location Management
  - Multiple branch support
  - Capacity tracking
  - Personnel assignment

- Financial Management
  - Membership fee tracking
  - Payment processing
  - Donation handling

- Communication
  - Automated email notifications
  - Team formation updates
  - Membership status changes
  - Email logging system

## Technical Stack

- **Backend**: Python/Flask
- **Database**: MySQL
- **Frontend**: HTML/CSS/JavaScript
- **Email**: SMTP (Gmail)

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/myvc-database.git
   cd myvc-database
   ```

2. Create and activate a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Set up the database:
   ```bash
   mysql -u root -p < sql/init.sql
   ```

5. Configure environment variables:
   - Copy `.env.example` to `.env`
   - Update the values in `.env` with your configuration

6. Run the application:
   ```bash
   python main.py
   ```

7. Access the web interface:
   - Open your browser and navigate to `http://localhost:5000`

## Database Schema

The system uses the following main tables:

- `Locations`: Stores information about club locations
- `CommonInfo`: Stores shared personal information
- `Personnel`: Manages staff and volunteers
- `FamilyMembers`: Tracks primary family members
- `ClubMembers`: Manages club member information
- `Teams`: Stores team information
- `TeamFormations`: Tracks game and training sessions
- `TeamFormationPlayers`: Links players to formations with roles
- `EmailLogs`: Tracks system-generated emails
- `SecondaryFamilyMembers`: Manages secondary family members

## Key Features

1. **Member Management**
   - Age validation (11-18 years)
   - Automatic membership deactivation
   - Family member relationships
   - Secondary family member support

2. **Team Management**
   - Team formation tracking
   - Player role assignment
   - Session scheduling
   - Time conflict prevention

3. **Location Management**
   - Multiple branch support
   - Capacity tracking
   - Personnel assignment

4. **Financial Management**
   - Membership fee tracking
   - Payment processing
   - Donation handling

5. **Communication**
   - Automated email notifications
   - Team formation updates
   - Membership status changes
   - Email logging system

## Project Structure

```
myvc-database/
├── main.py              # Flask application
├── main.html           # Web interface
├── requirements.txt    # Python dependencies
├── .env               # Environment variables
├── sql/
│   ├── init.sql      # Database initialization
│   └── queries.sql   # SQL queries
└── docs/
    ├── er_diagram.md # E/R diagram
    └── normalization_analysis.md # Database normalization analysis
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Concordia University Department of Computer Science & Software Engineering
- COMP 353 - Databases Course Staff
- Montréal Youth Volleyball Club 