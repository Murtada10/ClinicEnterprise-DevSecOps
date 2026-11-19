from infrastructure.database import DatabaseConnection
from models.patient import Patient

class PatientRepository:
    def __init__(self, db: DatabaseConnection):
        self.db = db

    def get_patient_by_id(self, patient_id: int) -> Patient | None:
        """Fetches a single patient by ID using safe parameterized queries."""
        conn = self.db.get_connection()
        cursor = conn.cursor()
        
        # Safe parameterization using a clean single-line query string
        sql = "SELECT Id, FirstName, LastName, PhoneNumber, DateOfBirth FROM dbo.Patients WHERE Id = ?"
        cursor.execute(sql, (patient_id,))
        
        row = cursor.fetchone()
        if not row:
            return None
            
        # Map raw SQL tuple to Pydantic Model
        return Patient(
            id=row[0],
            first_name=row[1],
            last_name=row[2],
            phone_number=row[3],
            date_of_birth=row[4]
        )