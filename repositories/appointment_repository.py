from datetime import datetime
from models.appointment import Appointment
from models.patient import Patient
from models.doctor import Doctor

class AppointmentRepository:
    def __init__(self, db_connection):
        self.db = db_connection

    def get_by_id(self, appointment_id: int) -> Appointment | None:
        query = """
            SELECT 
            a.Id, a.PatientId, a.DoctorId, a.AppointmentDate, a.Status, a.Notes,
            d.Id, d.FirstName, d.LastName, d.Specialty, d.IsActive
            FROM dbo.Appointments a
            INNER JOIN dbo.Doctors d ON A.DoctorId = d.Id
            WHERE a.Id = ?
        """

        cursor = self.db.get_cursor()
        cursor.execute(query, (appointment_id,))
        row = cursor.fetchone()

        if not row:
            return None

        doctor = Doctor(
            id=row[6],
            first_name=row[7],
            last_name=row[8],
            specialty=row[9],
            is_active=row[10]
        )

        return Appointment(
            id=row[0],
            patient_id=row[1],
            doctor_id=row[2],
            appointment_date=row[3],
            status=row[4],
            notes=row[5],
            doctor=doctor
        )


    def get_update_since(self, since_date: datetime) -> list[Appointment]:
        query = """
            SELECT Id, PatientId, DoctorId, AppointmentDate, Status, Notes
            FROM dbo.Appointments
            WHERE AppointmentDate >= ?
            ORDER BY AppointmentDate ASC
        """
        cursor = self.db.get_cursor()
        cursor.execute(query ,(since_date,))
        rows = cursor.fetchall()

        return [
            Appointment(
                id=row[0],
                patient_id=row[1],
                doctor_id=row[2],
                appointment_date=row[3],
                status=row[4],
                notes=row[5]
            )
            for row in rows
        ]