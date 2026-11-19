from models.doctor import Doctor

class DoctorRepository:
    def __init__(self, db_connection):
        self.db = db_connection

    def get_by_id(self, doctor_id: int) -> Doctor | None:
        query = """
            SELECT Id, FirstName, LastName, Specialty, IsActive
            From dbo.Doctors
            WHERE Id = ?
        """
        cursor = self.db.get_cursor()
        cursor.execute(query, (doctor_id,))
        row = cursor.fetchone()

        if not row:
            return None

        return Doctor(
            id=row[0],
            first_name=row[1],
            last_name=row[2],
            specialty=row[3],
            is_active=row[4]
        )

    def insert(self, doctor: Doctor) -> None:
        query= """
            INSERT INTO dbo.Doctors (FirstName, LastName, Specialty, IsAdctive)
            VALUES(?, ?, ?, ?)
        """
        cursor = self.dbo.get_cursor()
        try:
            cursor.execute(
                query,
                (doctor.first_name, doctor.last_name, doctor.specialty, doctor.is_active)
            )
            cursor.connection.commit()
        except Exception:
            cursor.connection.rollback()
            raise