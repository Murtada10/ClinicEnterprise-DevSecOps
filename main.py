from fastapi import Depends, FastAPI, HTTPException, Security

from api.security import verify_api_key
from infrastructure.database import DatabaseConnection
from repositories.appointment_repository import AppointmentRepository
from repositories.database_health_repository import DatabaseHealthRepository
from repositories.doctor_repository import DoctorRepository
from services.clinic_service import ClinicService

app = FastAPI(title="ClinicEnterprise API")


def get_clinic_service() -> ClinicService:
    db = DatabaseConnection()
    doctor_repo = DoctorRepository(db)
    appointment_repo = AppointmentRepository(db)
    health_repo = DatabaseHealthRepository(db)
    return ClinicService(doctor_repo, appointment_repo, health_repo)


@app.get("/health")
def health():
    return {"status": "ok"}


@app.get("/doctors/{doctor_id}")
def get_doctor(doctor_id: int, service: ClinicService = Depends(get_clinic_service)):
    try:
        return service.get_active_doctor(doctor_id)
    except ValueError as exc:
        raise HTTPException(status_code=404, detail=str(exc)) from exc


@app.get("/appointments/{appointment_id}")
def get_appointment(
    appointment_id: int, service: ClinicService = Depends(get_clinic_service)
):
    try:
        return service.get_appointment_details(appointment_id)
    except ValueError as exc:
        raise HTTPException(status_code=404, detail=str(exc)) from exc


@app.get("/health/db")
def database_health(service: ClinicService = Depends(get_clinic_service)):
    return service.get_database_health()


@app.get("/dbre/health")
def dbre_health(
    _: str = Security(verify_api_key),
    service: ClinicService = Depends(get_clinic_service),
):
    return service.get_database_health()

@app.post("/de/trigger-parquet-export")
def trigger_parquet_export(_: str = Security(verify_api_key)):
    return {"status": "accepted", "detail": "Parquet export triggered."}


@app.get("/dbre/health")
def dbre_health(
    _: str = Security(verify_api_key),
    service: ClinicService = Depends(get_clinic_service),
):
    return service.get_database_health()


@app.post("/de/trigger-parquet-export")
def trigger_parquet_export(_: str = Security(verify_api_key)):
    return {"status": "accepted", "detail": "Parquet export triggered."}


from infrastructure.database import DatabaseConnection
from repositories.patient_repository import PatientRepository


def test_repository():
    print("--- Testing Tier 3 (Patient Repository) ---")
    try:
        with DatabaseConnection() as db:
            repo = PatientRepository(db)
            patient = repo.get_patient_by_id(100000)

            if patient:
                print("Successfully fetched via PatientRepository!")
                print(f"Patient Name: {patient.full_name}")
                print(f"Is Adult: {patient.is_adult}")
                print(f"Masked Phone (GDPR Safe): {patient.masked_phone()}")
            else:
                print("Patient ID not found.")
    except Exception as e:
        print(f"Repository Test Failed: {e}")


if __name__ == "__main__":
    test_repository()
@app.get("/dbre/health")


def dbre_health(
    _: str = Security(verify_api_key),
    service: ClinicService = Depends(get_clinic_service),
):
    return service.get_database_health()

