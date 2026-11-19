import logging

logger = logging.getLogger(__name__)

class ClinicService:
    def __init__(self, doctor_repo, appointment_repo, health_repo):
        self.doctor_repo = doctor_repo
        self.appointment_repo = appointment_repo
        self.health_repo = health_repo

    def get_active_doctor(self, doctor_id: int):
        logger.info("Fetching doctor record for doctor_id=%s", doctor_id)
        doctor = self.doctor_repo.get_by_id(doctor_id)

        if not doctor:
            logger.warning("Doctor not found: doctor_id=%s", doctor_id)
            raise ValueError(f"Doctor {doctor_id} not found.")

        if not doctor.is_active:
            logger.warning("Inactive doctor requested: doctor_id=%s", doctor_id)
            raise ValueError(f"Doctor {doctor_id} is currently inactive.")
    
        return doctor


    def get_database_health(self) -> dict:
        logger.info("Running SQL Server health check")
        stats = self.health_repo.get_connection_stats()
        logger.info(
            "DB health check complete: total_sessions=%s, active_sessions=%s",
            stats["total_sessions"],
            stats["active_sessions"]
        )
        return stats

    def get_appointment_details(self, appointment_id: int):
        logger.info("Fetching appointment details for appointment_id=%s", appointment_id)
        appointment = self.appointment_repo.get_by_id(appointment_id)

        if not appointment:
            logger.warning("Appointment not found: appointment_id=%s", appointment_id)
            raise ValueError(f"Appointment {appointment_id} not found.")

        return appointment